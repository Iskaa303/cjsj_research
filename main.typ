#import "@preview/maquette-gltf:0.1.0": render-gltf

#set page(paper: "us-letter", margin: 0.75in, columns: 2)
#set text(font: ("Liberation Serif", "Libertinus Serif"), size: 10pt)
#set par(justify: true, leading: 0.95em, first-line-indent: 0.2in)

// Numbered section headings.
#set heading(numbering: "I.A.1)")
#show heading: it => {
  set par(first-line-indent: 0pt)
  if it.level == 1 {
    align(center, text(features: ("smcp",))[#it])
  } else {
    text(style: "italic")[#it]
  }
}

// Title.
#let title(body) = block(width: 100%, {
  set par(first-line-indent: 0pt)
  align(center, text(weight: "bold", size: 16pt)[#body])
})

// Author list.
#let authors(body) = block(width: 100%, {
  set par(first-line-indent: 0pt)
  align(center, text(size: 11pt)[#body])
})

// Abstract heading.
#let abstract-heading(body) = block({
  set par(first-line-indent: 0pt)
  text(weight: "bold", style: "italic", size: 9pt)[#body]
})

// Captions & bibliography styling.
#set figure(numbering: "1")
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

#let teal = rgb("#0e7c7b")
#let orange = rgb("#d9730d")
#let gridc = luma(210)

// A filled, rounded box with centered text.
#let lbox(w, h, fill, body) = box(width: w, height: h, {
  place(rect(width: 100%, height: 100%, fill: fill, radius: 4pt))
  place(center + horizon, body)
})

// An ellipse with centered text.
#let lellipse(w, h, fill, stroke, label) = box(width: w, height: h, {
  place(ellipse(width: 100%, height: 100%, fill: fill, stroke: stroke))
  place(center + horizon, label)
})

// ---------------------------------------------------------------------------
#title[Computational Design and Docking of a Bispecific Nanobody Targeting EphA2
and the Transferrin Receptor for Brain-Tumor Delivery]

#authors[Iskander Madikhan, Ameya Vathanan, Caroline Corey, and Rohnish P.]

#abstract-heading[Abstract]
Receptor-mediated transcytosis of the blood--brain barrier (BBB) remains a central
obstacle to brain-tumor therapy. Here we computationally designed a bispecific
single-domain antibody (nanobody) that simultaneously engages the transferrin
receptor (TfR) for BBB transcytosis and EphA2, a receptor tyrosine kinase
overexpressed in glioblastoma and other solid tumors. Paratopes from the
anti-EphA2 monoclonal antibody 3SKJ (PDB 3SKJ) and the TfR-binding antibody 6WX1
were grafted onto the camelid VHH scaffold cAbBCII-10 (PDB 3DWT), and the two
arms were fused through a $(G_4 S)_3$ linker. AlphaFold2/ColabFold predicted all
three constructs with favorable relaxed energies (EphA2 arm, $-414$; TfR arm,
$-380$; bispecific, $-781$ REU). Rosetta docking of the EphA2 arm onto its
receptor converged on a best interface score of $-1230.5$ REU. We further outline
a cathepsin B-cleavable Val-Cit-PABC linker strategy for payload conjugation.
Together, these results provide a testable, structure-guided blueprint for a
BBB-penetrant bispecific nanobody conjugate.

= Introduction

EphA2 is an Eph-family receptor tyrosine kinase whose overexpression correlates
with aggressive, treatment-resistant disease in glioblastoma and in breast,
ovarian, and pancreatic carcinomas, making it a validated tumor-selective
antigen @wykosky2008. The blood--brain barrier, however, excludes most protein
therapeutics from the central nervous system (CNS), limiting antibody-based
therapy for primary and metastatic brain tumors. A clinically validated route
across this barrier is receptor-mediated transcytosis (RMT) through the
transferrin receptor (TfR), which is highly expressed on brain endothelium and
continuously cycles across the barrier @yu2011. Bispecific constructs that bind
TfR on one arm and a brain antigen on the other --- the "molecular Trojan horse"
strategy --- have been shown to markedly increase CNS exposure of therapeutic
antibodies @niewoehner2014.

Single-domain antibodies (nanobodies, VHH) are attractive building blocks for
such bispecifics: they are small ($approx$15 kDa), thermostable, readily
expressed, and their single-domain architecture allows two or more paratopes to
be fused in tandem with a short flexible linker @muyldermans2013. Here we
combined these principles to design, model, and dock a tandem bispecific
nanobody whose EphA2 arm targets the tumor and whose TfR arm enables BBB
transcytosis. Because the intended clinical payload would be a highly cytotoxic
agent, we additionally specify a cathepsin B-cleavable Val-Cit-PABC linker to
ensure that the drug is released only after lysosomal internalization
@dubowchik2002.

= Methods

== Target and scaffold selection
The anti-EphA2 paratope was taken from the agonistic anti-human EphA2 monoclonal
antibody 3SKJ (PDB 3SKJ); the TfR-binding paratope was derived from the TfR
antibody 6WX1, whose epitope overlaps the designed binder characterized in PDB
6WRX bound to the TfR ectodomain (PDB 1CX8) @lawrence1999. The acceptor scaffold
was the camelid nanobody cAbBCII-10 (PDB 3DWT). Complementarity-determining
regions (CDRs) were grafted onto the VHH framework to produce two monovalent
nanobodies: EphA2-Nb and TfR-Nb.

== Structure prediction and relaxation
The three constructs --- EphA2-Nb, TfR-Nb, and the tandem bispecific (EphA2-Nb
--- $(G_4 S)_3$ --- TfR-Nb) --- were modeled with AlphaFold2 through ColabFold
using five seeds per construct, followed by AMBER relaxation
@jumper2021 @mirdita2022. Relaxed and unrelaxed model scores were recorded for
every prediction.

== Molecular docking
The EphA2 arm was docked against the EphA2 receptor using the Rosetta
low-resolution docking protocol; ten decoys were generated and ranked by
interface total score (REU). The transferrin-receptor arm was visualized against
the TfR ectodomain in PyMOL.

== Interface and linker analysis
Binding-interface residues were identified in PyMOL by differential solvent
accessibility (dASA) using a 1.0 #sym.angstrom#super[2] cutoff. Payload conjugation was
designed around the cathepsin B-cleavable valine-citrulline dipeptide with a
para-aminobenzyloxycarbonyl (PABC) self-immolative spacer @dubowchik2002.

= Results

AlphaFold2/ColabFold returned well-packed models for all three constructs, and
relaxation uniformly improved the scores by removing steric clashes (@tab:scores).
The best relaxed models were ranked fourth for every construct. The bispecific
nanobody achieved the lowest relaxed energy ($-781.0$ REU), consistent with the
larger, fully folded two-domain assembly; the monovalent arms reached $-414.4$
(EphA2) and $-380.0$ REU (TfR).

#figure(
  table(
    columns: 4,
    stroke: 0.6pt + gridc,
    align: (left, center, center, center),
    inset: 4pt,
    table.header(
      [*Construct*], [*Rank*], [*Relaxed (REU)*], [*#sym.Delta rel.-unrel.*]
    ),
    [Bispecific Nb], [1], [-755.5], [-2867.2],
    [Bispecific Nb], [2], [-775.1], [-2529.7],
    [Bispecific Nb], [3], [-760.3], [-3219.0],
    [Bispecific Nb], [*4*], [*-781.0*], [-4152.6],
    [Bispecific Nb], [5], [-726.4], [-2933.5],
    [EphA2-Nb], [1], [-412.1], [-583.8],
    [EphA2-Nb], [2], [-398.5], [-646.9],
    [EphA2-Nb], [3], [-392.2], [-799.4],
    [EphA2-Nb], [*4*], [*-414.4*], [-577.0],
    [EphA2-Nb], [5], [-395.3], [-1597.1],
    [TfR-Nb], [1], [-363.5], [-466.6],
    [TfR-Nb], [2], [-363.5], [-493.7],
    [TfR-Nb], [3], [-374.7], [-551.2],
    [TfR-Nb], [*4*], [*-380.0*], [-583.3],
    [TfR-Nb], [5], [-377.7], [-540.2],
  ),
  caption: [AlphaFold2/ColabFold model scores for the two monovalent arms and
    the tandem bispecific nanobody. Best relaxed model per construct is shown in
    bold.],
) <tab:scores>

Rosetta docking of the EphA2 arm produced five sterically reasonable decoys
clustered around $-1215$ to $-1230$ REU, with the lowest-energy interface at
$-1230.5$ REU (@tab:docking); the remaining five decoys adopted severe clashes
($> 10^5$ REU) and were discarded. The favorable decoys share a common binding
mode, indicating convergence of the search.

#figure(
  table(
    columns: 2,
    stroke: 0.6pt + gridc,
    align: (center, center),
    inset: 4pt,
    table.header([*Decoy*], [*Interface score (REU)*]),
    [0001], [-1215.3],
    [0002], [+142818.4],
    [0003], [-1219.1],
    [0004], [+139950.2],
    [*0005*], [*-1230.5*],
    [0006], [-1217.5],
    [0007], [+141511.8],
    [0008], [+139599.3],
    [0009], [+142308.8],
    [0010], [-1223.1],
  ),
  caption: [Rosetta docking scores for the EphA2 arm against the EphA2
    receptor. Favorable decoys cluster near $-1220$ REU; positive scores indicate
    steric clashes.],
) <tab:docking>

The engineered architecture is summarized in @fig:architecture. Each arm retains the
grafted paratope on the VHH framework, separated by a flexible $(G_4 S)_3$ linker
long enough to allow the two arms to engage EphA2 and TfR simultaneously. The
predicted bispecific nanobody is shown in @fig:model.

#figure(
  box(width: 100%, height: 150pt, {
    // EphA2 arm (left) and TfR arm (right)
    place(top + left, dx: 8pt, dy: 4pt,
      lbox(84pt, 22pt, teal, text(fill: white, size: 7.5pt)[EphA2 arm (VH)]))
    place(top + left, dx: 152pt, dy: 4pt,
      lbox(84pt, 22pt, orange, text(fill: white, size: 7.5pt)[TfR arm (VH)]))
    // linker between arms
    place(top + left, dx: 92pt, dy: 14pt,
      line(start: (0pt, 0pt), end: (60pt, 0pt), stroke: 1pt + gridc))
    place(top + left, dx: 104pt, dy: 4pt, text(size: 7pt)[$(G_4 S)_3$])
    // receptors below each arm, labels centered
    place(top + left, dx: 15pt, dy: 78pt,
      lellipse(70pt, 24pt, teal.lighten(82%), 0.7pt + teal,
        text(size: 6.5pt, fill: teal.darken(20%))[EphA2]))
    place(top + left, dx: 159pt, dy: 78pt,
      lellipse(70pt, 24pt, orange.lighten(82%), 0.7pt + orange,
        text(size: 6.5pt, fill: orange.darken(25%))[TfR]))
    // binding dashes
    place(top + left, dx: 50pt, dy: 27pt,
      line(start: (0pt, 0pt), end: (0pt, 50pt),
        stroke: (paint: gridc, thickness: 0.8pt, dash: "dashed")))
    place(top + left, dx: 194pt, dy: 27pt,
      line(start: (0pt, 0pt), end: (0pt, 50pt),
        stroke: (paint: gridc, thickness: 0.8pt, dash: "dashed")))
    // labels under receptors, centered
    place(top + left, dx: 15pt, dy: 108pt,
      box(width: 70pt, align(center, text(size: 6.5pt)[tumor antigen])))
    place(top + left, dx: 159pt, dy: 108pt,
      box(width: 70pt, align(center, text(size: 6.5pt)[BBB receptor])))
    // bottom note, centered
    place(top + center, dy: 130pt,
      text(size: 6.5pt, fill: luma(120))[blood--brain barrier: receptor-mediated transcytosis])
  }),
  caption: [Architecture of the tandem bispecific nanobody. Two VHH arms,
    grafted from the anti-EphA2 antibody 3SKJ and the TfR antibody 6WX1, are
    joined by a $(G_4 S)_3$ linker and simultaneously engage EphA2 on the tumor and
    TfR on the brain endothelium.],
) <fig:architecture>

#let model = read("assets/red_epha2_blue_tfr.glb", encoding: none)

#figure(
  render-gltf(model,
    camera: (44.144, 19.257, 74.308),
    center: (-0.6425, 0.7652, 0.2422),
    up: (-0.202, 0.972, -0.12),
    //background: "#182028",
    shadows: true,
    antialias: 4,
  ),
  caption: [Predicted tandem bispecific nanobody. The EphA2 arm is red, the TfR
    arm blue, and the $(G_4 S)_3$ linker green.],
) <fig:model>

= Discussion

== Model quality and docking energetics
Relaxed AlphaFold2 scores were strongly negative for all three constructs, and
relaxation consistently improved the unrelaxed models, indicating that the
grafted CDRs folded without destabilizing the VHH framework. The convergence of
five independent Rosetta decoys on a single binding mode near $-1220$ REU
supports the feasibility of the grafted EphA2 paratope engaging its receptor
epitope. The interface-residue analysis (dASA $>= 1.0$ #sym.angstrom#super[2]) recovered the
expected complementarity-determining residues at the modeled interface.

== Payload delivery and the Val-Cit-PABC linker
The cytotoxic payload must remain inert in circulation and be released only
inside the target cell. The valine-citrulline (Val-Cit) dipeptide satisfies this
requirement: it is stable in human plasma but is hydrolyzed selectively by
cathepsin B, a cysteine protease that is highly active in the lysosome
@dubowchik2002. Conjugation through a PABC spacer renders release
self-immolative --- cathepsin B cleavage triggers a 1,6-elimination that
liberates the free drug @dubowchik2002. Auristatin payloads such as MMAE then
bind tubulin and arrest mitosis, driving antigen-positive cells into mitotic
catastrophe; because the released auristatin is membrane-permeable, it diffuses
into neighboring antigen-poor cells, producing a bystander effect that widens
the therapeutic index @doronina2003. This release strategy is well-matched to
TfR-mediated transcytosis, since the conjugate is internalized through the
lysosomal pathway in both endothelium and tumor.

== Limitations
These results are purely computational: AlphaFold2 scores and Rosetta interface
energies are proxies for, not proofs of, binding, and the docked pose models a
static receptor without the conformational changes of TfR transcytosis or the
avidity of dual engagement. Surface plasmon resonance of the individual arms, a
BBB transcytosis assay, and cytotoxicity studies are required before any
therapeutic claim.

= Conclusion

We designed a tandem bispecific nanobody that couples an EphA2 tumor-targeting
arm to a transferrin-receptor arm for blood--brain barrier transcytosis, grafted
onto a camelid VHH scaffold and fused through a $(G_4 S)_3$ linker. AlphaFold2
modeling and Rosetta docking support the foldability of both arms and the
plausibility of the EphA2 interface, and a cathepsin B-cleavable Val-Cit-PABC
linker provides a rational payload-release strategy. The design is fully
specified by sequence and structure and is ready for recombinant expression and
experimental testing.

= References

#bibliography("references.yaml", title: none)
