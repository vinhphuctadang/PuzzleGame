Program Demo_version_game;
Uses gr8bit, imgsplit, font, crt, dos, crtAddin;
Type TData = array[0..5, 0..5] of word;
     TStep = array[0..0] of byte;
const maxLevel = 14;
      clX = 169;
      clY = 177;
      clWidth = 150;
      clHeight = 5;
      perHi = 30;
      perMed = 30;
      perLo = 40;
var motherBuf : PPictureBuf;
    IL, save : TImgList;
    Data, sub : TData;
    posX, posY, sX, sY, easy : integer;
    HidenBuf : PPictureBuf;
    SaveStep : ^TStep;
    min, sec : word;
    step : word;
    pX, pY : word;
    divideX, divideY : byte;
    level : byte;
    imgX, imgY : integer;
    maxRand : word;
    what : dirstr;
    gExit : boolean;
    heapTOP : pointer;
    win : boolean;
    isTimeLeft : boolean;
    total, maxTime : word;
procedure tone(w, h : word);
begin
sound(w);
delay(h);
nosound;
end;
procedure Rectangle(x1, y1, x2, y2 : integer; color : integer);
var i : integer;
begin
for i := x1 to x2 do
    begin
    putpixel(i, y1, color);
    putpixel(i, y2, color);
    end;
for i := y1 + 1 to y2 - 1 do
    begin
    putpixel(x1, i, color);
    putpixel(x2, i, color);
    end;
end;
{Time line -----------------------------------------}
function strCv(a : word) : string;
var s : string;
begin
str(a, s);
strCv := s;
end;
function canUpdate : boolean;
var hh, mm, ss, s100 : word;
begin
getTime(hh, mm, ss, s100);
canUpdate := ss <> step;
step := ss;
end;
procedure UpdateTime;
var time : string; color : byte; dWidth : word;
begin
if isTimeLeft then
   begin
   dec(total);
   dWidth := clWidth * (total * 100 div maxTime) div 100;
   fillRange(clX + dWidth, cly, clWidth - dWidth, clHeight, 0);
   end;
inc(sec);
if sec = 60 then begin sec := 0; min := min + 1;end;
time := StrCv(min) + ':' + Copy('00', 1, 2 - length(StrCv(sec))) + StrCv(Sec);
Outtext(170, 183, time, 45, 0);
end;
procedure SaveLevel;
var f : text;
begin
Assign(f, 'rec.rec');
rewrite(f);
Write(f, level);
close(f);
end;
{Image processor ----------------------------------}
procedure Update;
var i, j : integer;
begin
for j := 0 to divideY - 1 do
    for i := 0 to divideX - 1 do
    ExportImg(i * easy + pX, j * easy + pY, IL.Buf^[j * divideX + i]);
end;

procedure Swap(var a, b : word);
var tam : byte;
begin
tam := a;
a := b;
b := tam;
end;
procedure SwapBuf(var a, b : PPictureBuf);

var tam : PPictureBuf;
begin
tam := a;
a := b;
b := tam;
end;
procedure Process(huong : integer);
begin
case huong of
     2 : if posY > 1 then
       begin
       swap(data[posY - 1, posX -1], data[posY - 2, posX - 1]);
       swapBuf(IL.Buf^[(posY - 1) * divideX + posX - 1],
                             IL.Buf^[(posY - 2) * divideX + posX - 1]);
       dec(posY);
       sound(1300);
       delay(20);
       nosound;
       end;
     1 : if posY < divideY then
       begin
       swap(data[posY - 1, posX -1], data[posY, posX - 1]);
       swapBuf(IL.Buf^[(posY - 1) * divideX + posX - 1],
                             IL.Buf^[(posY) * divideX + posX - 1]);
       inc(posY);
       sound(1100);
       delay(20);
       nosound;
       end;
     4 : if posX > 1 then
       begin
       swap(data[posY - 1, posX - 1], data[posY - 1, posX - 2]);
       swapBuf(IL.Buf^[(posY - 1) * divideX + posX - 1],
                             IL.Buf^[(posY - 1) * divideX + posX - 2]);
       dec(posX);
       sound(1100);
       delay(20);
       nosound;
       end;
     3 : if posX < divideX then
       begin
       swap(data[posY - 1, posX - 1], data[posY - 1, posX]);
       swapBuf(IL.Buf^[(posY - 1) * divideX + posX - 1],
                             IL.Buf^[(posY - 1) * divideX + posX]);
       inc(posX);
       sound(1100);
       delay(20);
       nosound;
       end;
     end;
end;
procedure randomImage;
var  ok : boolean;
    huong, last, i : integer;
begin
randomize;
getmem(saveStep, maxRand);
for i := 1 to maxRand do
    begin
    ok := false;
    repeat
          last := random(4) + 1;
          case last of
               2 : if (posY > 1) and (huong <> 1) then ok := true;
               1 : if (posY < divideY) and (huong <> 2) then ok := true;
               4 : if (posX > 1) and (huong <> 3) then ok := true;
               3 : if (posX < divideX) and (huong <> 4) then ok := true;
               end;
    until ok;
    process(last);
    saveStep^[i - 1] := last;
    huong := last;
    update;
    end;
end;
procedure Init;
var j, i : integer; width : word;ok : boolean;
    f : text;
begin
min := 0;
sec := 0;
isTimeLeft := false;
win := False;
Assign(f,'lv' + strcv(level) + '.lv');
Reset(f);
readln(f, what);
readln(f, divideX);
readln(f, divideY);
readln(f, maxRand);
if not eof(f) then
   begin
   readln(f, total);
   isTimeLeft := true;
   maxTime := total;
   Outtext(1, 17, Vtrans('Chus ys thanh thowfi gian owr duwowsi'), $6E, 0);
   fillRange(clX, clY, perLo * clWidth div 100, clHeight, $6F);
   fillRange(clX + perlo * clWidth div 100, clY, permed * clWidth div 100, clHeight, $2C);
   fillRange(clX + (perlo + permed) * clWidth div 100 ,clY, perHi * clWidth div 100, clHeight, $2F);
   end;
close(f);
mark(heapTOP);
FImportImg(what, MotherBuf);
rectangle(0, 16, 319, 182, $F);
imgX := (319 - getImgWidth(MotherBuf)*2 - divideX - 20) div 2;
imgY := (199 - getImgHeight(MotherBuf) - divideX) div 2;
pX := imgX + getImgWidth(MotherBuf) + 20;
pY := imgY;
Rectangle(imgX - 2, imgY - 2, imgX + getImgWidth(MotherBuf) + 1, imgY + getImgHeight(motherBuf) + 1, 127);
ExportImg(imgX , imgY , MotherBuf);
Rectangle(pX - 2, pY - 2, pX + getImgWidth(MotherBuf) + divideX,
pY + getImgHeight(MotherBuf) + divideY, 127);
for j := 0 to divideY - 1 do
    for i := 0 to divideX - 1 do
         Data[j, i] := j * divideX + i;
posX := divideX; posY := divideY;
ok := SplitImg(MotherBuf, divideX, divideY, IL);
if ok = false then exit;
width := getImgWidth(motherBuf) div divideX;
HidenBuf := provideBuf(width, width);
fillchar(HidenBuf^[4] , width * width, 0);
SwapBuf(IL.Buf^[IL.pWidth * IL.pHeight - 1], HidenBuf);
easy := getImgWidth(MotherBuf) div divideX + 1;
update;
key.ClearKeyBuf;
Outtext(0, 0, Vtrans('Nhaasn |Enter|'), $76, 0);
key.WaitChar([#13]);
Outtext(0, 0, Vtrans('Nhaasn |Enter|'), 0, 0);
if isTimeLeft then begin
   Outtext(1, 17, Vtrans('Chus ys thanh thowfi gian owr duwowsi'), 0, 0);
   Outtext(1, 17, StrCv(total div 60) + Vtrans(' phust ') + StrCv(total mod 60)
              + Vtrans(' giaay') + Vtrans(' ... Bawst ddaafu '), $2F, 0);
   delay(600);
   Outtext(1, 17, StrCv(total div 60) + Vtrans(' phust ') + StrCv(total mod 60)
              + Vtrans(' giaay') + Vtrans(' ... Bawst ddaafu '), 0, 0);
              end;
randomImage;
sub := Data;
save := il;
getmem(save.Buf, save.pWidth * save.pHeight * 4);
for i := 0 to save.pWidth * save.pHeight - 1 do
    save.Buf^[i] := il.Buf^[i];
sX := posX;
sY := posY;
end;
function test : boolean;
var j, i, count, last  : integer;
begin
last := Data[0, 0];
test := false;
count := 0;
for j := 0 to divideY - 1 do
    for i := 0 to divideX - 1 do
        begin
        if last > data[j, i] then exit;
        last := data[j, i];
        end;
test := true;
end;
procedure solve;
var h,i : integer;
begin
IL := Save;
Outtext(240, 186, Vtrans('Masy giari'), 0, 15);
Data := Sub;
posX := sX;
posY := sY;
Update;
for i := maxrand - 1 downto 0 do
    begin
    h := saveStep^[i];
    case h of
         1 : h := 2;
         2 : h := 1;
         3 : h := 4;
         4 : h := 3;
         end;
    process(h);
    update;
    delay(200);
    end;
end;
procedure run;
var ch : char; i : integer; isSolve : boolean;
begin
isSolve := False;
repeat
if canUpdate then updateTime;
if (istimeleft) and (total = 0) then
               begin
               tone(600, 120);
               tone(300, 100);
               outtext(10, 183, Vtrans('Bajn thua !'), 167, 0);
               Outtext(0, 0, Vtrans('Nhaasn |Enter|'), $76, 0);
               key.WaitChar([#13]);
               Outtext(0, 0, Vtrans('Nhaasn |Enter|'), 0, 0);
               win := False;
               exit;
               end;
if keypressed then
begin
      ch := readkey;
      case ch of
           'w' : process(1);
           's' : process(2);
           'a' : process(3);
           'd' : process(4);
           'q' : solve;
           #27 : begin gExit := true; exit;end;
           end;
      if ch in ['w', 's', 'a', 'd', 'q'] then
      begin update;
            if test then
            begin
               tone(600, 150);
               tone(1200, 80);
               tone(1500, 60);
               for i := 1 to random(4) + 10 do
                   begin
                   exportImg(pX + (divideX - 1) * easy, pY + (divideY - 1) * easy,
                   IL.Buf^[IL.pWidth * IL.pHeight - 1]);
                   delay(100);
                   exportImg(pX + (divideX - 1) * easy, pY + (divideY - 1) * easy,
                   HidenBuf);
                   delay(100);
                   end;
               outtext(10, 183, Vtrans('Bajn thawsng !'), 45, 0);
               Outtext(0, 0, Vtrans('Nhaasn |Enter|'), $76, 0);
               key.WaitChar([#13]);
               Outtext(0, 0, Vtrans('Nhaasn |Enter|'), 0, 0);
               win := True;
               exit;
               end;
               end;
      end;
until ch = #27;
end;
procedure done;
begin
release(heapTOP);
end;
procedure Clearscreen1;
var i, j : integer;
begin
for i := 0 to 159 do
begin
    for j := 0 to 199 do
    begin
        putpixel(i, j, 0);
        putpixel(319 - i, j, 0);
    end;
delay(30);
end;
end;
procedure ClearScreen2;
var i, j : integer;
begin
for j := 0 to 99 do
    begin
    for i := 0 to 319 do
        begin
        putpixel(i, j, 0);
        putpixel(i, 199 - j, 0);
        end;
    delay(30);
    end;
end;
{____________________________________________}
procedure CenterText(y : integer; s : string; fore, back : integer);
var x : integer;
begin
x := (319 - length(s) * 8 ) div 2;
Outtext(x, y, s, fore, back);
end;
procedure ShowLevel(a : byte);
var s : string;
begin
s := 'LEVEL ' + strCv(a);
CenterText(0, s, $56, 0);
delay(1200);
end;
Procedure ShowInstruction;
begin
Outtext(0, 16, Vtrans('-------------- Huwowsng daaxn ------------[x]'), $4F, 0);
Outtext(0, 32, Vtrans('+ Suwr dujng casc phism A,S,D,W ddeer ddieefu khieern'), $4D, 0);
Outtext(0, 48, Vtrans('+ Dufng phism |Enter| ddeer chojn'), $4D, 0);
Outtext(0, 64, Vtrans('+ Baasm |Esc| ddeer thoast '), $4D, 0);
Outtext(0, 80, Vtrans('------------------[OK]------------------'), $4F, 0);
key.WaitChar([#13]);
end;
Procedure AskforInstr;
var myKey : char;
begin
Outtext(0, 0, Vtrans('Xem huwowsng daaxn (C, K) : '), $4F, 0);
myKey := key.WaitChar(['c','C','K','k']);
case myKey of
     'c', 'C' : showInstruction;
     end;
end;
{Game doing ------------------------------}
procedure initgame;
begin
Fillchar(mem[$A000 : 0000], 64000, 0);
Outtext(45, 20, Vtrans('Taj Ddawjng Vixnh Phusc giowsi thieeju :'), $2F, 0);
Delay(400);
Outtext(140, 46, 'Game', $6F, 0);
Delay(600);
Outtext(132, 78, 'PU' + Upcase('z') + UpCase('z') + 'LE', $4A, 0);
Outtext(108, 92, 'Demo version', $5A, 0);
Delay(500);
Outtext(108, 108, Vtrans('Vowsi chur ddeef : '), $4E, 0);
Delay(600);
Outtext(90, 140,  'PLANTS & ' + upcase('z') + 'OOMBIES', $6F, 0);
Outtext(88, 172, Vtrans('<<< Nhaasn |Enter| >>>'), $2F, 0);
key.WaitChar([#13]);
randomize;
case random(2) of
     0 : clearscreen1;
     1 : clearScreen2;
     end;
AskforInstr;
end;
procedure gameLife;
var f : text;
begin
Assign(f, 'rec.rec');
reset(f);
readln(f, level);
close(f);
gExit := False;
if level = 0 then level := 1;
repeat
      case random(2) of
           0 : clearscreen1;
           1 : clearscreen2;
           end;
      showLevel(level);
      init;
      saveLevel;
      run;
      done;
      if win then inc(level);
      if (level > maxLevel) and (not gExit) then
         begin
         level := 1;
         saveLevel;
         end;
until gExit;
end;
begin
initgraph;
initgame;
gameLife;
closegraph;
end.


