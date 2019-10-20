Unit Menu;
{Menu which can be executed in graph mode (1 level)}
Interface
Uses gr8bit, crtAddin;
Type TmenuStr = string[40];
     PMenuStr = ^TMenuStr;
     PMenuItem = ^TMenuItem;
     TMenuItem = record
               Next : PMenuItem;
               code : word;
               Enable : boolean;
               inf : TMenuStr;
               end;
var mUpChar, mDownChar, mOkChar, mCancelChar : integer;
function NewMenuItem(inf : TMenuStr; code : word; ptrNext : PMenuItem) : PMenuItem;
procedure RemoveMenuItem(var P : PMenuItem);
function ExcuteMenu(var P : PMenuItem; TForeground, TBackground : byte; limit : byte) :  word;
implementation
function makeStrLength(s : TMenuStr; l : byte) : TMenuStr;
{Build the Menu - string which has the same information with the given length}
var needb, i : byte;
begin
if length(s) >= l then s := copy(s, 1, l)
else begin
     needb := l - length(s);
     for i := 1 to needb div 2 do
         s := ' ' + s;
     for i := 1 to needb - needb div 2 do
         s := s + ' ';
     end;
makestrLength := s;
end;
function NewMenuItem(inf : TMenuStr; code : word; ptrNext : PMenuItem) : PMenuItem;
var n : PMenuItem;
begin
New(n);
N^.Inf := Inf;
N^.Code := Code;
N^.Next := PtrNext;
NewMenuItem := N;
end;
procedure RemoveMenuItem(var P : PMenuItem);
var PNext : PMenuItem;
begin
While P <> Nil do
      begin
      PNext := p^.Next;
      Dispose(p);
      p := PNext;
      end;
end;
function ExcuteMenu(var P : PMenuItem; TForeground, TBackground : byte; limit : byte) :  word;
