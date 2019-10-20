Unit ImgSplit;
Interface
Uses Gr8bit;
Type
    TImgArr = Array[0..0] of PPictureBuf;
    PImgArr = ^TImgArr;
    TImgList = record
             pWidth, pHeight : byte;
             Buf : PImgArr;
             end;
function provideBuf(width, height : word) : PPictureBuf;
function SelectImg(pX, pY : integer; Width, Height : word; Buf : PPictureBuf) : PPictureBuf;
function SplitImg(Buf : PPictureBuf; Width, Height : byte; var Img : TImgList) : boolean;
procedure FreeList(var Img : TImgList);
implementation
function ProvideBuf(width, height : word) : PPictureBuf;
var Buf : PPictureBuf;
begin
Getmem(Buf, width * height + 4);
Buf^[0] := Hi(width);
Buf^[1] := Lo(Width);
Buf^[2] := Hi(Height);
Buf^[3] := Lo(Height);
ProvideBuf := Buf;
end;
function SelectImg(pX, pY : integer; Width, Height : word; Buf : PPictureBuf) : PPictureBuf;
var ABuf : PPictureBuf; i : integer; w : word;
begin
ABuf := ProvideBuf(Width, Height);
if pX + width > getImgWidth(Buf) then w := GetImgWidth(Buf) - pX - 1 else w := width;
for i := 0 to Height - 1 do
    if pY + i < getImgHeight(Buf) then
       move(Buf^[(pY + i) * getImgWidth(Buf) + pX + 4], ABuf^[i * width + 4], w);
SelectImg := ABuf;
end;
Function SplitImg(Buf : PPictureBuf; Width, Height : byte; var Img : TImgList) : boolean;
var pX, pY, i, j, k: integer; wNeed : word;
begin
SplitImg := False;
if (getImgWidth(Buf) mod width <> 0)
   or (getImgHeight(Buf) mod Height <> 0)
      or (getImgHeight(Buf) div height <> getImgWidth(Buf) div Width)
         then exit;
wNeed := getImgWidth(Buf) div Width;
GetMem(Img.Buf, width * height * 4);
with img do begin pWidth := Width; pHeight := Height; end;
for j := 0 to height - 1 do
    for i := 0 to width - 1 do
        begin
        pX := i * wNeed ;
        pY := j * wNeed ;
        Img.Buf^[j * width + i] :=
                   selectImg(pX, pY, wNeed, wNeed, Buf);
        end;
SplitImg := true;
end;
procedure FreeList(var Img : TImgList);
var i : integer; wNeed : word;
begin
for i := 0 to img.pwidth * img.pheight - 1 do destroyImg(Img.Buf^[i]);
freemem(Img.Buf, Img.pWidth * Img.pHeight * 4);
end;
end.