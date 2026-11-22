MODULE GfxDrawTest;  (** GfxDrawTest.Run: a red rectangle drawn with Gfx into an image, its pixels checked; the outline
  of a letter of the metafont Oberon; needs the desktop's display *)

IMPORT Images, Gfx, GfxBuffer, GfxPaths, GfxFonts, Out;

VAR fails, checks: LONGINT;

PROCEDURE Check(what: ARRAY OF CHAR; ok: BOOLEAN);
BEGIN
  INC(checks);
  IF ~ok THEN INC(fails); Out.String("FAIL "); Out.String(what); Out.Ln END
END Check;

PROCEDURE Red(img: Images.Image; x, y: INTEGER): BOOLEAN;
VAR pix: Images.Pixel; mode: Images.Mode;
BEGIN
  Images.InitMode(mode, Images.srcCopy); Images.Get(img, x, y, pix, mode);
  RETURN (pix[Images.r] = 0FFX) & (pix[Images.g] = 0X) & (pix[Images.b] = 0X)
END Red;

PROCEDURE Run*;
VAR img: Images.Image; bc: GfxBuffer.Context; font: GfxFonts.Font; path: GfxPaths.Path; s: GfxPaths.Scanner;
  curve: BOOLEAN;
BEGIN
  fails := 0; checks := 0;
  NEW(img); Images.Create(img, 10, 10, Images.BGR888);
  NEW(bc); GfxBuffer.Init(bc, img); GfxBuffer.SetBGColor(bc, Gfx.White); Gfx.Reset(bc);
  Gfx.SetFillColor(bc, Gfx.Red); Gfx.DrawRect(bc, 2, 2, 8, 8, {Gfx.Fill});
  Check("red inside the rectangle", Red(img, 5, 5));
  Check("not red outside", ~Red(img, 0, 0) & ~Red(img, 9, 9));
  font := GfxFonts.OpenSize("Oberon", 72); NEW(path); GfxPaths.Clear(path); curve := FALSE;
  IF font # NIL THEN
    GfxFonts.GetOutline(font, "A", 0.0, 0.0, path); GfxPaths.Open(s, path, 0);
    WHILE s.elem # GfxPaths.Stop DO IF s.elem = GfxPaths.Bezier THEN curve := TRUE END; GfxPaths.Scan(s) END
  END;
  Check("the outline of A from Oberon.MTF, with curves", curve);  (* from the raster font: lines only *)
  Out.String("GfxDrawTest: "); Out.Int(checks, 0); Out.String(" checks, "); Out.Int(fails, 0); Out.String(" failed"); Out.Ln
END Run;

END GfxDrawTest.
