# gfx

Gfx of ETH Oberon for [polpo](https://github.com/polpo-system/polpo): two-dimensional graphics with
high-level operations: paths of lines, arcs and Bezier curves, stroked and filled, transformations,
clipping, images and fonts. The same drawing goes to the screen (GfxDisplay), into images of the
package images (GfxBuffer) and to printers (GfxPrinter); PostScript is the package gfx-ps, PK and
OpenType fonts are gfx-pkfonts and gfx-otype. Leonardo and Vinci are built on Gfx.

```
portia.Install gfx
```

## What is here

    src/GfxMatrix.Mod, GfxImages.Mod, GfxPaths.Mod, GfxRegions.Mod   transformations, images,
                                                                    paths, regions
    src/OLR.GfxFonts0.Mod, GfxFonts.Mod      fonts (raster fonts of Oberon, outlines)
    src/Gfx.Mod, GfxRaster.Mod               the drawing interface and the rasterizer
    src/GfxDisplay.Mod, GfxBuffer.Mod, GfxPrinter.Mod   screen, images, printers
    share/GfxOverview.html, GfxHowto.html    the documentation
    share/Oberon.MTF, OberonBold.MTF, OberonItalic.MTF   the outlines of the fonts Oberon
    tools/Gfx.Tool
    test/GfxDrawTest.Mod

The sources come from ETH Linux Oberon (OLR, 2017-06-18), converted from Oberon texts to plain
text; the first commit has them unchanged, the second makes GfxFonts0 find the raster fonts in
fonts/ of polpo. They compile unchanged with all five of polpo's compilers.

The outlines (metafonts) Oberon.MTF, OberonBold.MTF and OberonItalic.MTF come unchanged from
Contrib/Metafonts/Oberon.Arc of the ETH Oberon archive. GfxFonts draws Oberon, Oberon-Bold and
Oberon-Italic from them at the sizes that have no raster font.

## Tests

    GfxDrawTest.Run      3 checks: a red rectangle drawn into an image, its pixels checked inside
                         and outside; the outline of A from Oberon.MTF, with curves; it needs
                         the desktop's display

The license is GPL-3 (`LICENSE`); the code comes from ETH Oberon, whose license (`LICENSE.ETH`)
asks to keep its copyright notice and conditions, which `LICENSE.ETH` does.
