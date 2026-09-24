#import "@preview/maquette-gltf:0.1.0": render-gltf
#import "@preview/cetz:0.5.2"

#set page(paper: "us-letter", margin: 0.75in, columns: 2)
#set text(font: ("Liberation Serif", "Libertinus Serif"), size: 10pt)
#set par(justify: true, leading: 0.95em, first-line-indent: 0.2in)

// Numbered section and subsection headings.
#set heading(numbering: "I.A.1)")
#show heading: it => {
  set par(first-line-indent: 0pt)
  set block(above: 0.9em, below: 0.3em)
  if it.level == 1 {
    align(center, text(features: ("smcp",))[#it])
  } else {
    text(style: "italic")[#it]
  }
}

// Title and author blocks.
#let title(body) = block(width: 100%, {
  set par(first-line-indent: 0pt)
  align(center, text(weight: "bold", size: 16pt)[#body])
})
#let authors(body) = block(width: 100%, {
  set par(first-line-indent: 0pt)
  align(center, text(size: 11pt)[#body])
})
#let abstract-heading(body) = block({
  set par(first-line-indent: 0pt)
  text(weight: "bold", style: "italic", size: 9pt)[#body]
})

// Captions: below figures, above tables; "Fig. N" in captions and in text.
#set figure(numbering: "1", gap: 0.45em)
#show figure.where(kind: image): set figure(supplement: [Fig.])
#show figure.where(kind: table): set figure.caption(position: top)
#show figure.caption: it => {
  set par(first-line-indent: 0pt)
  set text(size: 8pt)
  it
}
#show bibliography: it => {
  set text(size: 8pt)
  set par(first-line-indent: 0pt, justify: false, hanging-indent: 1.6em)
  it
}

// Palette shared by the figures.
#let teal = rgb("#0e7c7b")
#let orange = rgb("#d9730d")
#let ink = rgb("#1f2a33")
#let gridc = luma(210)

// Schematic of the construct and its delivery mechanism.
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

// ---------------------------------------------------------------------------
#title[Computational Design of a Bispecific Nanobody Targeting EphA2
and the Transferrin Receptor for Brain-Tumor Delivery]

#authors[Iskander Madikhan, Ameya Vathanan, Caroline Corey, and Rohnish P.]

#abstract-heading[Abstract]
Receptor-mediated transcytosis (RMT) of the transferrin receptor (TfR) is one of
the few clinically validated routes for delivering protein therapeutics across the
blood--brain barrier (BBB), but brain-tumor therapy additionally requires
tumor-selective engagement. We designed and evaluated a bispecific single-domain antibody (nanobody)
that pairs an anti-EphA2 paratope
with a TfR-binding paratope. Complementarity-determining regions (CDRs) from the
anti-EphA2 antibody 3SKJ and the TfR binder 6WX1 were grafted onto the camelid VHH
scaffold cAbBCII-10 (PDB 3DWT) and fused through a $(G_4 S)_3$ linker.
AlphaFold2/ColabFold predicted five models per construct and AMBER relaxation
improved every model, giving mean relaxed energies of $-759.7 plus.minus 21.3$ REU
for the construct, $-402.5 plus.minus 10.1$ REU for the EphA2 arm and
$-371.9 plus.minus 7.9$ REU for the TfR arm ($n = 5$). The energy lies
within 15 REU of the sum of the isolated arms, indicating that fusion introduces no
significant strain. Rosetta docking of the EphA2 arm onto its receptor converged on
a single binding mode in five of ten decoys ($-1221.1 plus.minus 6.0$ REU), while
the remaining five were rejected as steric clashes. A cathepsin B-cleavable
Val-Cit-PABC linker is specified for payload conjugation.

= Introduction

== The blood--brain barrier and receptor-mediated transcytosis
Glioblastoma and other high-grade brain tumors remain among the most
treatment-resistant cancers, in part because the BBB excludes the great majority of
systemically administered drugs and essentially all unmodified antibodies from the
brain parenchyma. RMT offers a physiological route across this barrier: ligands
bound to receptors that cycle between the luminal and abluminal endothelial
surfaces are carried through the cell rather than degraded in the lysosome. The
TfR is the most extensively characterized RMT target @yu2011, and antibodies that
bind it with moderate affinity and monovalent valency reach substantially higher
brain exposure than their bivalent counterparts, an effect attributed to more
efficient sorting away from lysosomal degradation @niewoehner2014. A TfR arm can
therefore serve as a delivery module appended to an otherwise non-CNS therapeutic.

== EphA2 as a tumor-selective antigen
EphA2 is a receptor tyrosine kinase whose overexpression correlates with
aggressive, treatment-resistant disease in glioblastoma and in breast, ovarian and
pancreatic carcinomas, making it a validated tumor-selective antigen @wykosky2008.
Because EphA2 is displayed on the tumor cell surface rather than on normal brain
endothelium, an EphA2-binding arm adds an orthogonal specificity that concentrates
the payload at the tumor after barrier transit.

== Nanobodies as bispecific building blocks
Nanobodies (VHH) are small ($approx$15 kDa), thermostable and readily expressed,
and their single-domain architecture permits two paratopes to be fused in tandem
@muyldermans2013. The fusion is mediated by a flexible peptide linker whose length
determines how freely the domains adopt their binding orientations; glycine--serine
repeats are the usual choice because they are hydrophilic and unlikely to adopt
secondary structure @chen2013. We therefore designed a nanobody whose EphA2
arm engages the tumor and whose TfR arm enables BBB transcytosis
(@fig:architecture), and asked whether both grafted paratopes remain foldable and
docking-competent in that format.

= Methods and Materials

== Target and scaffold selection
The anti-EphA2 paratope was taken from the agonistic anti-human EphA2 monoclonal
antibody 3SKJ (PDB 3SKJ); the TfR-binding paratope was derived from the TfR
antibody 6WX1, whose epitope overlaps the designed binder characterized in PDB
6WRX bound to the TfR ectodomain (PDB 1CX8) @lawrence1999. The acceptor scaffold
was the camelid nanobody cAbBCII-10 (PDB 3DWT). All structures were retrieved from
the Protein Data Bank @berman2000.

== Paratope grafting
CDRs were assigned according to the IMGT definition @lefranc2003 and grafted onto
the VHH framework to produce two monovalent nanobodies, EphA2-Nb and TfR-Nb, fused
as EphA2-Nb---$(G_4 S)_3$---TfR-Nb. The sequences of the two arms and the
homologous VH sequences retrieved for the prediction formed a 473-column multiple
sequence alignment used as the ColabFold input.

== Structure prediction and relaxation
EphA2-Nb, TfR-Nb and the tandem bispecific were modeled with AlphaFold2 through the
ColabFold pipeline using five seeds per construct @jumper2021 @mirdita2022, then
subjected to AMBER relaxation, which removes steric clashes and regularizes bond
geometry while preserving the predicted fold. Relaxed and unrelaxed scores were
recorded for all five models per construct and ranked by relaxed score in Rosetta
energy units (REU), where more negative values indicate more favorable structures.

== Molecular docking and interface analysis
The EphA2 arm was docked against the EphA2 receptor using the Rosetta
low-resolution docking protocol, a coarse rigid-body search with a centroid
representation of side chains @gray2003; ten decoys were ranked by interface total
score (REU), where scores above $10^5$ REU indicate steric clashes.
Binding-interface residues were identified in PyMOL @delano2002 by differential
solvent accessibility (dASA) at a $1.0$ #sym.angstrom#super[2] cutoff, i.e.
positions buried upon complex formation, and compared with the CDR assignments to
verify that the contact surface is composed of the transplanted paratope.

== Payload conjugation and release design
Payload conjugation was designed around the cathepsin B-cleavable
valine--citrulline (Val-Cit) dipeptide with a para-aminobenzyloxycarbonyl (PABC)
self-immolative spacer @dubowchik2002, assuming a cytotoxic auristatin payload such
as monomethyl auristatin E (MMAE), whose release triggers tubulin binding and
mitotic arrest @doronina2003.

= Results and Discussion

== Fold quality and relaxation energetics
AlphaFold2/ColabFold returned well-packed models for all three constructs, and
relaxation improved every one of the fifteen models (@tab:scores). Mean relaxed
energies were $-759.7 plus.minus 21.3$ REU for the tandem bispecific,
$-402.5 plus.minus 10.1$ REU for the EphA2 arm and $-371.9 plus.minus 7.9$ REU for
the TfR arm, and the best model was ranked fourth for each construct with only a
narrow spread across ranks (54.6 REU for the tandem construct, 22.2 and 16.5 REU
for the arms), so no construct relies on a single favorable outlier. The sum of the
two monovalent arm energies is $-774.4$ REU, whereas the construct relaxes to
$-759.7$ REU, a difference of only about 2% of the total. Fusion therefore does not
appear to impose a folding penalty, and the two VHH domains behave as independently
folding units joined by the linker.

#figure(
  placement: top,
  align(center, text(size: 8pt, table(
    columns: 4,
    stroke: 0.6pt + gridc,
    align: (left, center, center, center),
    inset: 3pt,
    table.header(
      [*Construct*], [*Best (REU)*], [*Mean $plus.minus$ SD*], [*#sym.Delta*]
    ),
    [Bispecific Nb], [*-781.0*], [$-759.7 plus.minus 21.3$], [-4152.6],
    [EphA2-Nb], [*-414.4*], [$-402.5 plus.minus 10.1$], [-577.0],
    [TfR-Nb], [*-380.0*], [$-371.9 plus.minus 7.9$], [-583.3],
  ))),
  caption: [AlphaFold2/ColabFold relaxed energies of the five models predicted per
    construct. The best model was ranked fourth for every construct; $#sym.Delta$
    is the relaxation gain of that model, and the mean $plus.minus$ standard
    deviation is taken over all five models.],
) <tab:scores>

== Docking convergence of the EphA2 arm
Rosetta docking produced a sharply bimodal score distribution (@tab:docking): five
of the ten decoys clustered between $-1215.3$ and $-1230.5$ REU
($-1221.1 plus.minus 6.0$ REU, spread 15.2 REU), while the remaining five scored
above $+1.39 times 10^5$ REU. The nearly $1.4 times 10^5$ REU separation does not
depend on the exact cutoff chosen, and the tight clustering of the favorable decoys
indicates that the search converged on a single binding mode rather than sampling
comparable alternatives. The dASA analysis recovered the expected
complementarity-determining residues at the contact surface, i.e. the buried
positions correspond to the transplanted paratope rather than to framework
residues.

#figure(
  placement: top,
  table(
    columns: 4,
    stroke: 0.6pt + gridc,
    align: (center, center, center, center),
    inset: 2.5pt,
    table.header(
      [*Decoy*], [*Score (REU)*], [*Decoy*], [*Score (REU)*]
    ),
    [0001], [-1215.3], [0006], [-1217.5],
    [0002], [+142818.4], [0007], [+141511.8],
    [0003], [-1219.1], [0008], [+139599.3],
    [0004], [+139950.2], [0009], [+142308.8],
    [*0005*], [*-1230.5*], [0010], [-1223.1],
  ),
  caption: [Rosetta docking scores for the EphA2 arm against the EphA2 receptor
    (interface total score). Favorable decoys cluster near $-1220$ REU; scores
    above $10^5$ REU indicate steric clashes.],
) <tab:docking>

== Architecture of the tandem construct
@fig:architecture summarizes the design. Each arm retains its grafted paratope on
the VHH framework, and the two arms are separated by a linker long enough to allow
simultaneous engagement of EphA2 and TfR: 15 glycine--serine residues span roughly
50 #sym.angstrom when fully extended while remaining flexible in solution
@chen2013, so the two paratopes need not compete sterically for their epitopes. The
relaxed model (@fig:model) shows the two domains arranged side by side rather than
interdigitated, with the linker solvent-exposed and neither domain buried by the
other --- the geometric prerequisite for the bispecific mechanism.

#figure(
  placement: top,
  align(center, mechanism-figure()),
  caption: [Architecture of the tandem bispecific nanobody and its delivery
    mechanism. Two VHH arms, grafted from the anti-EphA2 antibody 3SKJ and the TfR
    antibody 6WX1, are joined by a $(G_4 S)_3$ linker and engage EphA2 on the tumor
    cell and TfR on the brain endothelium. The C-terminal Val-Cit-PABC--MMAE module
    is released by cathepsin B, and TfR binding drives receptor-mediated
    transcytosis across the blood--brain barrier.],
) <fig:architecture>

#figure(
  placement: top,
  render-gltf(
    read("assets/red_epha2_blue_tfr.glb", encoding: none),
    camera: (35.188, 32.69, 61.823),
    center: (-0.6425, 0.7652, 0.2422),
    up: (-0.306, 0.906, -0.292),
    shadows: true,
    width: 70%,
    antialias: 4,
  ),
  caption: [Relaxed model of the tandem bispecific nanobody. The EphA2 arm is
    shown in red, the TfR arm in blue, and the $(G_4 S)_3$ linker in green.],
) <fig:model>

== Payload delivery and the Val-Cit-PABC linker
The Val-Cit dipeptide keeps the payload inert in circulation while being hydrolyzed
selectively by cathepsin B, a lysosomal cysteine protease @dubowchik2002.
Conjugation through a PABC spacer renders release self-immolative: cleavage triggers
a 1,6-elimination that liberates the free drug @carl1981 @dubowchik2002. Auristatin payloads
such as MMAE then bind tubulin and arrest mitosis, and because the released drug is
membrane-permeable it diffuses into neighboring antigen-poor cells, producing a
bystander effect that widens the therapeutic index @doronina2003. This release
strategy matches TfR-mediated transcytosis, since the conjugate is internalized
through the lysosomal pathway in both endothelium and tumor. Placing the
conjugation site at the C-terminus of the TfR arm (@fig:architecture) keeps it
distal to both paratopes.

== Limitations and future work
These results are purely computational: a relaxed energy reports internal
consistency of the fold rather than affinity for a partner, and the docked pose
models a static receptor without the conformational changes that accompany TfR
transcytosis. Docking used a low-resolution protocol and ten decoys, so convergence
within that sample does not exclude binding modes the search did not sample, and
the epitope overlap between 6WX1 and the binder characterized in 6WRX is assumed
rather than demonstrated. Dual engagement, avidity and developability properties
such as immunogenicity of a camelid VHH framework in humans were not modeled. The
immediate experiments follow from those gaps: surface plasmon resonance or biolayer
interferometry to measure the affinity of each arm and of the tandem construct, a
transcytosis assay across a brain endothelial monolayer, and cytotoxicity assays on
EphA2-positive and EphA2-negative cell lines.

= Conclusion

We designed a bispecific nanobody that couples an EphA2 tumor-targeting arm
to a transferrin-receptor arm for blood--brain barrier transcytosis, grafted onto a
camelid VHH scaffold and fused through a $(G_4 S)_3$ linker. Relaxation improved
every one of the five predicted models per construct, and the construct
relaxed to within 15 REU of the sum of its isolated arms, indicating that the two
domains fold independently after fusion. Rosetta docking converged on a single
EphA2 binding mode in half of the decoys, and a cathepsin B-cleavable Val-Cit-PABC
linker provides a rational payload-release strategy. The design is fully specified
by sequence and structure and is ready for recombinant expression and experimental
testing.

= References

#bibliography("references.yaml", title: none)
