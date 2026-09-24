#import "@preview/cetz:0.5.2"
#set page(width: auto, height: auto, margin: 6pt)
#let teal = rgb("#0e7c7b")
#let orange = rgb("#d9730d")
#let ink = rgb("#1f2a33")
#let gridc = luma(210)
#let mechanism-figure() = {
  set text(size: 7pt)
  cetz.canvas({
    import cetz.draw: *
    set-style(stroke: none)
    let gray = rgb("#5b6b78")
    let dash = rgb("#8899a6")
    // ---------------- membranes (tumour cell, brain endothelium)
    for (x0, x1) in ((0.25, 3.15), (3.95, 7.05)) {
      rect((x0, 3.15), (x1, 4.05), fill: rgb("#eef3f6"), stroke: none)
      for i in range(int((x1 - x0) / 0.33)) {
        let x = x0 + 0.16 + i * 0.33
        line((x, 3.91), (x, 3.65), stroke: 0.5pt + rgb("#9fb0bd"))
        line((x, 3.29), (x, 3.55), stroke: 0.5pt + rgb("#9fb0bd"))
        circle((x, 3.97), radius: 0.072, fill: rgb("#cdd8e0"),
          stroke: 0.3pt + rgb("#9fb0bd"))
        circle((x, 3.23), radius: 0.072, fill: rgb("#cdd8e0"),
          stroke: 0.3pt + rgb("#9fb0bd"))
      }
    }
    // ---------------- VHH arms (β-sandwich glyphs)
    for (cx, fill) in ((1.70, teal), (5.30, orange)) {
      rect((cx - 1.15, 6.60), (cx + 1.15, 7.75), radius: 3pt,
        fill: fill.lighten(88%), stroke: 0.7pt + fill)
      for i in range(4) {
        let yy = 7.56 - i * 0.26
        line((cx - 0.92, yy), (cx + 0.92, yy), stroke: 1.1pt + fill.transparentize(30%),
          mark: (end: ">", stroke: 0.9pt + fill.transparentize(30%)))
      }
    }
    // ---------------- flexible (G4S)3 linker
    catmull((2.85, 7.17), (3.10, 7.45), (3.35, 6.90), (3.60, 7.45),
      (3.85, 7.17), (4.15, 7.17), stroke: 1.1pt + gray)
    // ---------------- receptors
    rect((1.35, 3.00), (2.25, 5.45), radius: 3pt,
      fill: teal.lighten(80%), stroke: 0.7pt + teal)
    line((1.35, 4.35), (2.25, 4.35), stroke: 0.5pt + teal.transparentize(65%))
    line((1.35, 4.95), (2.25, 4.95), stroke: 0.5pt + teal.transparentize(65%))
    circle((1.80, 2.65), radius: 0.24, fill: teal.lighten(40%),
      stroke: 0.7pt + teal)
    rect((4.62, 3.00), (4.98, 5.45), radius: 2pt,
      fill: orange.lighten(80%), stroke: 0.7pt + orange)
    rect((5.12, 3.00), (5.48, 5.45), radius: 2pt,
      fill: orange.lighten(80%), stroke: 0.7pt + orange)
    for x0 in (4.62, 5.12) {
      line((x0, 4.35), (x0 + 0.36, 4.35), stroke: 0.5pt + orange.transparentize(65%))
      line((x0, 4.95), (x0 + 0.36, 4.95), stroke: 0.5pt + orange.transparentize(65%))
    }
    circle((4.80, 2.65), radius: 0.20, fill: orange.lighten(45%),
      stroke: 0.7pt + orange)
    circle((5.30, 2.65), radius: 0.20, fill: orange.lighten(45%),
      stroke: 0.7pt + orange)
    // paratope-epitope contacts
    for x in (1.80, 5.05) {
      line((x, 6.53), (x, 5.88),
        stroke: (paint: dash, thickness: 0.7pt, dash: "dashed"))
    }
    // ---------------- C-terminal payload module
    line((6.45, 7.17), (7.35, 7.17), (7.35, 5.85), stroke: 1.1pt + gray)
    line((7.22, 6.48), (7.48, 6.30), stroke: 1.1pt + rgb("#c0392b"))
    rect((6.55, 4.90), (8.15, 5.78), radius: 3pt,
      fill: orange.lighten(92%), stroke: 0.7pt + orange)
    polygon((7.35, 4.10), 6, radius: 0.44, fill: orange.lighten(45%),
      stroke: 0.7pt + orange)
    // ---------------- labels
    content((1.70, 8.12), text(fill: teal, weight: "bold")[EphA2 arm (VHH)])
    content((5.30, 8.12), text(fill: orange, weight: "bold")[TfR arm (VHH)])
    content((3.50, 6.45), text(size: 6pt, fill: gray)[(G#sub[4]S)#sub[3] linker])
    content((1.80, 5.68), text(fill: teal)[EphA2])
    content((5.05, 5.68), text(fill: orange)[TfR])
    content((1.70, 1.95), text(size: 6.5pt)[glioblastoma cell])
    content((5.30, 1.95), text(size: 6.5pt)[brain endothelium (BBB)])
    content((7.35, 5.34), text(size: 6pt, fill: ink)[Val-Cit-PABC])
    content((7.35, 4.10), text(size: 6pt, fill: white)[MMAE])
    content((7.12, 6.39), text(size: 5.5pt, fill: rgb("#c0392b"))[cathepsin B],
      anchor: "east")
    // ---------------- transcytosis
    line((3.55, 5.00), (3.55, 2.45),
      stroke: (paint: dash, thickness: 0.8pt, dash: "dashed"),
      mark: (end: ">", stroke: 0.8pt + dash))
    content((3.55, 5.52), text(size: 5.5pt, fill: gray)[receptor-mediated])
    content((3.55, 5.28), text(size: 5.5pt, fill: gray)[transcytosis (BBB)])
  })
}

#mechanism-figure()
