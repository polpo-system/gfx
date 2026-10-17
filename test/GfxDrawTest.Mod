MODULE GfxDrawTest;  (** GfxDrawTest.Run: a red rectangle drawn with Gfx into an image, its pixels checked; needs the desktop's display *)

IMPORT Images, Gfx, GfxBuffer, Out := out;

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
VAR img: Images.Image; bc: GfxBuffer.Context;
BEGIN
  fails := 0; checks := 0;
  NEW(img); Images.Create(img, 10, 10, Images.BGR888);
  NEW(bc); GfxBuffer.Init(bc, img); GfxBuffer.SetBGColor(bc, Gfx.White); Gfx.Reset(bc);
  Gfx.SetFillColor(bc, Gfx.Red); Gfx.DrawRect(bc, 2, 2, 8, 8, {Gfx.Fill});
  Check("red inside the rectangle", Red(img, 5, 5));
  Check("not red outside", ~Red(img, 0, 0) & ~Red(img, 9, 9));
  Out.String("GfxDrawTest: "); Out.Int(checks, 0); Out.String(" checks, "); Out.Int(fails, 0); Out.String(" failed"); Out.Ln
END Run;

END GfxDrawTest.
