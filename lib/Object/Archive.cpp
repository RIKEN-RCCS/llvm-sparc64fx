//===- Archive.cpp - ar File Format implementation --------------*- C++ -*-===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This file defines the ArchiveObjectFile class.
//
//===----------------------------------------------------------------------===//

#include "llvm/Object/Archive.h"
#include "llvm/ADT/APInt.h"
#include "llvm/ADT/SmallString.h"
#include "llvm/ADT/Twine.h"
#include "llvm/Support/Endian.h"
#include "llvm/Support/MemoryBuffer.h"

using namespace llvm;
using namespace object;

static const char *Magic = "!<arch>\n";

static bool isInternalMember(const ArchiveMemberHeader &amh) {
  static const char *const internals[] = {
    "/",
    "//"
  };

  StringRef name = amh.getName();
  for (std::size_t i = 0; i < sizeof(internals) / sizeof(*internals); ++i) {
    if (name == internals[i])
      return true;
  }
  return false;
}

void Archive::anchor() { }

StringRef ArchiveMemberHeader::getName() const {
  char EndCond;
  if (Name[0] == '/' || Name[0] == '#')
    EndCond = ' ';
  else
    EndCond = '/';
  llvm::StringRef::size_type end =
      llvm::StringRef(Name, sizeof(Name)).find(EndCond);
  if (end == llvm::StringRef::npos)
    end = sizeof(Name);
  assert(end <= sizeof(Name) && end > 0);
  // Don't include the EndCond if there is one.
  return llvm::StringRef(Name, end);
}

uint64_t ArchiveMemberHeader::getSize() const {
  uint64_t ret;
  if (llvm::StringRef(Size, sizeof(Size)).rtrim(" ").getAsInteger(10, ret))
    llvm_unreachable("Size is not an integer.");
  return ret;
}

Archive::Child::Child(const Archive *p, StringRef d) : Parent(p), Data(d) {
  if (!p || d.empty())
    return;
  // Setup StartOfFile and PaddingBytes.
  StartOfFile = sizeof(ArchiveMemberHeader);
  // Don't include attached name.
  StringRef Name = ToHeader(Data.data())->getName();
  if (Name.startswith("#1/")) {
    uint64_t NameSize;
    if (Name.substr(3).rtrim(" ").getAsInteger(10, NameSize))
      llvm_unreachable("Long name length is not an integer");
    StartOfFile += NameSize;
  }
}

Archive::Child Archive::Child::getNext() const {
  size_t SpaceToSkip = Data.size();
  // If it's odd, add 1 to make it even.
  if (SpaceToSkip & 1)
    ++SpaceToSkip;

  const char *NextLoc = Data.data() + SpaceToSkip;

  // Check to see if this is past the end of the archive.
  if (NextLoc >= Parent->Data->getBufferEnd())
    return Child(Parent, StringRef(0, 0));

  size_t NextSize = sizeof(ArchiveMemberHeader) + ToHeader(NextLoc)->getSize();

  return Child(Parent, StringRef(NextLoc, NextSize));
}

error_code Archive::Child::getName(StringRef &Result) const {
  StringRef name = getRawName();
  // Check if it's a special name.
  if (name[0] == '/') {
    if (name.size() == 1) { // Linker member.
      Result = name;
      return object_error::success;
    }
    if (name.size() == 2 && name[1] == '/') { // String table.
      Result = name;
      return object_error::success;
    }
    // It's a long name.
    // Get the offset.
    std::size_t offset;
    if (name.substr(1).rtrim(" ").getAsInteger(10, offset))
      llvm_unreachable("Long name offset is not an integer");
    const char *addr = Parent->StringTable->Data.begin()
                       + sizeof(ArchiveMemberHeader)
                       + offset;
    // Verify it.
    if (Parent->StringTable == Parent->end_children()
        || addr < (Parent->StringTable->Data.begin()
                   + sizeof(ArchiveMemberHeader))
        || addr > (Parent->StringTable->Data.begin()
                   + sizeof(ArchiveMemberHeader)
                   + Parent->StringTable->getSize()))
      return object_error::parse_failed;

    // GNU long file names end with a /.
    if (Parent->kind() == K_GNU) {
      StringRef::size_type End = StringRef(addr).find('/');
      Result = StringRef(addr, End);
    } else {
      Result = addr;
    }
    return object_error::success;
  } else if (name.startswith("#1/")) {
    uint64_t name_size;
    if (name.substr(3).rtrim(" ").getAsInteger(10, name_size))
      llvm_unreachable("Long name length is not an ingeter");
    Result = Data.substr(sizeof(ArchiveMemberHeader), name_size);
    return object_error::success;
  }
  // It's a simple name.
  if (name[name.size() - 1] == '/')
    Result = name.substr(0, name.size() - 1);
  else
    Result = name;
  return object_error::success;
}

error_code Archive::Child::getMemoryBuffer(OwningPtr<MemoryBuffer> &Result,
                                           bool FullPath) const {
  StringRef Name;
  if (error_code ec = getName(Name))
    return ec;
  SmallString<128> Path;
  Result.reset(MemoryBuffer::getMemBuffer(
      getBuffer(), FullPath ? (Twine(Parent->getFileName()) + "(" + Name + ")")
                                  .toStringRef(Path)
                            : Name,
      false));
  return error_code::success();
}

error_code Archive::Child::getAsBinary(OwningPtr<Binary> &Result) const {
  OwningPtr<Binary> ret;
  OwningPtr<MemoryBuffer> Buff;
  if (error_code ec = getMemoryBuffer(Buff))
    return ec;
  if (error_code ec = createBinary(Buff.take(), ret))
    return ec;
  Result.swap(ret);
  return object_error::success;
}

Archive::Archive(MemoryBuffer *source, error_code &ec)
  : Binary(Binary::ID_Archive, source) {
  // Check for sufficient magic.
  if (!source || source->getBufferSize()
                 < (8 + sizeof(ArchiveMemberHeader)) // Smallest archive.
              || StringRef(source->getBufferStart(), 8) != Magic) {
    ec = object_error::invalid_file_type;
    return;
  }

  // Get the special members.
  child_iterator i = begin_children(false);
  child_iterator e = end_children();

  if (i == e) {
    ec = object_error::parse_failed;
    return;
  }

  StringRef Name = i->getRawName();

  // Below is the pattern that is used to figure out the archive format
  // GNU archive format
  //  First member : / (may exist, if it exists, points to the symbol table )
  //  Second member : // (may exist, if it exists, points to the string table)
  //  Note : The string table is used if the filename exceeds 15 characters
  // BSD archive format
  //  First member : __.SYMDEF (points to the symbol table)
  //  There is no string table, if the filename exceeds 15 characters or has a 
  //  embedded space, the filename has #1/<size>, The size represents the size 
  //  of the filename that needs to be read after the archive header
  // COFF archive format
  //  First member : /
  //  Second member : / (provides a directory of symbols)
  //  Third member : // (may exist, if it exists, contains the string table)
  //  Note: Microsoft PE/COFF Spec 8.3 says that the third member is present
  //  even if the string table is empty. However, lib.exe does not in fact
  //  seem to create the third member if there's no member whose filename
  //  exceeds 15 characters. So the third member is optional.

  if (Name == "__.SYMDEF") {
    Format = K_BSD;
    SymbolTable = i;
    ec = object_error::success;
    return;
  }

  if (Name == "/") {
    SymbolTable = i;

    ++i;
    if (i == e) {
      ec = object_error::parse_failed;
      return;
    }
    Name = i->getRawName();
  }

  if (Name == "//") {
    Format = K_GNU;
    StringTable = i;
    ec = object_error::success;
    return;
  }

  if (Name[0] != '/') {
    Format = K_GNU;
    ec = object_error::success;
    return;
  }

  if (Name != "/") {
    ec = object_error::parse_failed;
    return;
  }

  Format = K_COFF;
  SymbolTable = i;

  ++i;
  if (i == e) {
    ec = object_error::success;
    return;
  }

  Name = i->getRawName();

  if (Name == "//")
    StringTable = i;

  ec = object_error::success;
}

Archive::child_iterator Archive::begin_children(bool skip_internal) const {
  const char *Loc = Data->getBufferStart() + strlen(Magic);
  size_t Size = sizeof(ArchiveMemberHeader) +
    ToHeader(Loc)->getSize();
  Child c(this, StringRef(Loc, Size));
  // Skip internals at the beginning of an archive.
  if (skip_internal && isInternalMember(*ToHeader(Loc)))
    return c.getNext();
  return c;
}

Archive::child_iterator Archive::end_children() const {
  return Child(this, StringRef(0, 0));
}

error_code Archive::Symbol::getName(StringRef &Result) const {
  Result = StringRef(Parent->SymbolTable->getBuffer().begin() + StringIndex);
  return object_error::success;
}

error_code Archive::Symbol::getMember(child_iterator &Result) const {
  const char *Buf = Parent->SymbolTable->getBuffer().begin();
  const char *Offsets = Buf + 4;
  uint32_t Offset = 0;
  if (Parent->kind() == K_GNU) {
    Offset = *(reinterpret_cast<const support::ubig32_t*>(Offsets)
               + SymbolIndex);
  } else if (Parent->kind() == K_BSD) {
    llvm_unreachable("BSD format is not supported");
  } else {
    uint32_t MemberCount = *reinterpret_cast<const support::ulittle32_t*>(Buf);
    
    // Skip offsets.
    Buf += sizeof(support::ulittle32_t)
           + (MemberCount * sizeof(support::ulittle32_t));

    uint32_t SymbolCount = *reinterpret_cast<const support::ulittle32_t*>(Buf);

    if (SymbolIndex >= SymbolCount)
      return object_error::parse_failed;

    // Skip SymbolCount to get to the indices table.
    const char *Indices = Buf + sizeof(support::ulittle32_t);

    // Get the index of the offset in the file member offset table for this
    // symbol.
    uint16_t OffsetIndex =
      *(reinterpret_cast<const support::ulittle16_t*>(Indices)
        + SymbolIndex);
    // Subtract 1 since OffsetIndex is 1 based.
    --OffsetIndex;

    if (OffsetIndex >= MemberCount)
      return object_error::parse_failed;

    Offset = *(reinterpret_cast<const support::ulittle32_t*>(Offsets)
               + OffsetIndex);
  }

  const char *Loc = Parent->getData().begin() + Offset;
  size_t Size = sizeof(ArchiveMemberHeader) +
    ToHeader(Loc)->getSize();
  Result = Child(Parent, StringRef(Loc, Size));

  return object_error::success;
}

Archive::Symbol Archive::Symbol::getNext() const {
  Symbol t(*this);
  // Go to one past next null.
  t.StringIndex =
      Parent->SymbolTable->getBuffer().find('\0', t.StringIndex) + 1;
  ++t.SymbolIndex;
  return t;
}

Archive::symbol_iterator Archive::begin_symbols() const {
  const char *buf = SymbolTable->getBuffer().begin();
  if (kind() == K_GNU) {
    uint32_t symbol_count = 0;
    symbol_count = *reinterpret_cast<const support::ubig32_t*>(buf);
    buf += sizeof(uint32_t) + (symbol_count * (sizeof(uint32_t)));
  } else if (kind() == K_BSD) {
    llvm_unreachable("BSD archive format is not supported");
  } else {
    uint32_t member_count = 0;
    uint32_t symbol_count = 0;
    member_count = *reinterpret_cast<const support::ulittle32_t*>(buf);
    buf += 4 + (member_count * 4); // Skip offsets.
    symbol_count = *reinterpret_cast<const support::ulittle32_t*>(buf);
    buf += 4 + (symbol_count * 2); // Skip indices.
  }
  uint32_t string_start_offset = buf - SymbolTable->getBuffer().begin();
  return symbol_iterator(Symbol(this, 0, string_start_offset));
}

Archive::symbol_iterator Archive::end_symbols() const {
  const char *buf = SymbolTable->getBuffer().begin();
  uint32_t symbol_count = 0;
  if (kind() == K_GNU) {
    symbol_count = *reinterpret_cast<const support::ubig32_t*>(buf);
  } else if (kind() == K_BSD) {
    llvm_unreachable("BSD archive format is not supported");
  } else {
    uint32_t member_count = 0;
    member_count = *reinterpret_cast<const support::ulittle32_t*>(buf);
    buf += 4 + (member_count * 4); // Skip offsets.
    symbol_count = *reinterpret_cast<const support::ulittle32_t*>(buf);
  }
  return symbol_iterator(
    Symbol(this, symbol_count, 0));
}

Archive::child_iterator Archive::findSym(StringRef name) const {
  Archive::symbol_iterator bs = begin_symbols();
  Archive::symbol_iterator es = end_symbols();
  Archive::child_iterator result;
  
  StringRef symname;
  for (; bs != es; ++bs) {
    if (bs->getName(symname))
        return end_children();
    if (symname == name) {
      if (bs->getMember(result))
        return end_children();
      return result;
    }
  }
  return end_children();
}
