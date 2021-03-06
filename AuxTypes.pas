{$IFNDEF Included}
{-------------------------------------------------------------------------------

  This Source Code Form is subject to the terms of the Mozilla Public
  License, v. 2.0. If a copy of the MPL was not distributed with this
  file, You can obtain one at http://mozilla.org/MPL/2.0/.

-------------------------------------------------------------------------------}
{===============================================================================

  Auxiliary types

    Some types (eg. integers of defined size) that are not guaranteed to be
    declared in all compilers.

  version 1.0.9 (2020-06-29)

  Last change 2020-08-02

  ©2015-2020 František Milt

  Contacts:
    František Milt: frantisek.milt@gmail.com

  Support:
    If you find this code useful, please consider supporting its author(s) by
    making a small donation using the following link(s):

      https://www.paypal.me/FMilt

  Changelog:
    For detailed changelog and history please refer to this git repository:

      github.com/TheLazyTomcat/Lib.AuxTypes

  Dependencies:
    none

===============================================================================}
unit AuxTypes;

interface
{$ENDIF Included}

{$H+}

{$UNDEF UInt64_NotNative}
{$IF (Defined(DCC) or Declared(CompilerVersion)) and not Defined(FPC)}
  // assumes Delphi (DCC symbol is not defined in older Delphi than XE2)
  {$IF (CompilerVersion <= 17)}
    {$DEFINE UInt64_NotNative}
  {$IFEND}
{$IFEND}

const
  NativeUInt64 = {$IFDEF UInt64_NotNative}False{$ELSE}True{$ENDIF};

type
//== Integers ==================================================================

{$IF (SizeOf(ShortInt) <> 1) or (SizeOf(Byte) <> 1)}
  {$MESSAGE FATAL 'Wrong size of 8bit integers'}
{$IFEND}
  Int8   = ShortInt;      UInt8   = Byte;
  PInt8  = ^Int8;         PUInt8  = ^UInt8;
  PPInt8 = ^PInt8;        PPUInt8 = ^PUInt8;

{$IF (SizeOf(SmallInt) <> 2) or (SizeOf(Word) <> 2)}
  {$MESSAGE FATAL 'Wrong size of 16bit integers'}
{$IFEND}
  Int16   = SmallInt;     UInt16   = Word;
  PInt16  = ^Int16;       PUInt16  = ^UInt16;
  PPInt16 = ^PInt16;      PPUInt16 = ^PUInt16;

{$IF (SizeOf(LongInt) = 4) and (SizeOf(LongWord) = 4)}
  Int32   = LongInt;      UInt32  = LongWord;
{$ELSE}
  {$IF (SizeOf(Integer) <> 4) or (SizeOf(Cardinal) <> 4)}
    {$MESSAGE FATAL 'Wrong size of 32bit integers'}
  {$ELSE}
  Int32   = Integer;      UInt32  = Cardinal;
  {$IFEND}
{$IFEND}
  PInt32  = ^Int32;       PUInt32  = ^UInt32;
  PPInt32 = ^PInt32;      PPUInt32 = ^PUInt32;

  DoubleWord = UInt32;    PDoubleWord = ^DoubleWord;  PPDoubleWord = ^PDoubleWord;

  DWord = UInt32;         PDWord = ^DWord;            PPDWord = ^PDWord;

{$IFDEF UInt64_NotNative}
  UInt64 = Int64;
{$ELSE}
  UInt64 = System.UInt64;
{$ENDIF}
{$IF (SizeOf(Int64) <> 8) or (SizeOf(UInt64) <> 8)}
  {$MESSAGE FATAL 'Wrong size of 64bit integers'}
{$IFEND}
  PUInt64  = ^UInt64;
  PPUInt64 = ^PUInt64;

  QuadWord = UInt64;      PQuadWord = ^QuadWord;      PPQuadWord = ^PQuadWord;
  
  QWord = UInt64;         PQWord = ^QWord;            PPQWord = ^PQWord;

//-- Half-byte -----------------------------------------------------------------

  TNibble = 0..15;        PNibble = ^TNibble;         PPNibble = ^PNibble;

  Nibble = TNibble;

//-- Pointer related -----------------------------------------------------------

{$IF SizeOf(Pointer) = 8}
  PtrInt  = Int64;
  PtrUInt = UInt64;
{$ELSEIF SizeOf(Pointer) = 4}
  PtrInt  = Int32;
  PtrUInt = UInt32;
{$ELSE}
  {$MESSAGE FATAL 'Unsupported size of pointer type'}
{$IFEND}
  PPtrInt  = ^PtrInt;     PPPtrInt  = ^PPtrInt;
  PPtrUInt = ^PtrUInt;    PPPtrUInt = ^PPtrUInt;

  TStrSize = Int32;       PStrSize = ^TStrSize;       PPStrSize = ^PStrSize;
  TMemSize = PtrUInt;     PMemSize = ^TMemSize;       PPMemSize = ^PMemSize;

  NativeInt  = PtrInt;    PNativeInt  = ^NativeInt;   PPNativeInt  = ^PNativeInt;
  NativeUInt = PtrUInt;   PNativeUInt = ^NativeUInt;  PPNativeUInt = ^PNativeUInt;

//== Floats ====================================================================

  // half precision floating point numbers
  // only for I/O operations, cannot be used in arithmetics
  Half  = packed array[0..1] of UInt8;        PHalf = ^Half;      PPHalf = ^PHalf;

{$IF (SizeOf(Half) <> 2)}
  {$MESSAGE FATAL 'Wrong size of 16bit float'}
{$IFEND}
  Float16 = Half;         PFloat16 = ^Float16;        PPFloat16 = ^PFloat16;

{$IF (SizeOf(Single) <> 4)}
  {$MESSAGE FATAL 'Wrong size of 32bit float'}
{$IFEND}
  Float32 = Single;       PFloat32 = ^Float32;        PPFloat32 = ^PFloat32;

{$IF (SizeOf(Double) <> 8)}
  {$MESSAGE FATAL 'Wrong size of 64bit float'}
{$IFEND}
  Float64 = Double;       PFloat64 = ^Float64;        PPFloat64 = ^PFloat64;

{$IF SizeOf(Extended) = 10}
  Float80 = Extended;
{$ELSE}
  // only for I/O operations, cannot be used in arithmetics
  Float80 = packed array[0..9] of UInt8;
{$IFEND}
  PFloat80  = ^Float80;
  PPFloat80 = ^PFloat80;

//== Strings ===================================================================

{$IF not declared(UnicodeChar)}  
  UnicodeChar    = WideChar;
{$IFEND}
{$IF not declared(UnicodeString)}
  UnicodeString  = WideString;
{$IFEND}
  PUnicodeChar   = ^UnicodeChar;      PPUnicodeChar   = ^PUnicodeChar;
  PUnicodeString = ^UnicodeString;    PPUnicodeString = ^PUnicodeString;

{$IF not declared(UTF8Char)}
  UTF8Char = type AnsiChar;
{$IFEND}
  PUTF8Char  = ^UTF8Char;
  PPUTF8Char = ^PUTF8Char;

{$IFNDEF Included}
implementation

{$WARNINGS OFF}
end.
{$ENDIF Included}
{$WARNINGS ON}
