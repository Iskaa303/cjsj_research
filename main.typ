#set page(paper: "us-letter", margin: 0.75in, columns: 2)
#set text(font: ("Liberation Serif", "Libertinus Serif"), size: 10pt)
#set par(justify: true, leading: 0.95em, first-line-indent: 0.2in)

// Numbered section headings.
#set heading(numbering: "I.A.1)")
#show heading: it => {
  if it.level == 1 {
    align(center, text(features: ("smcp",))[#it])
  } else {
    text(style: "italic")[#it]
  }
}

// Title.
#let title(body) = align(center, text(weight: "bold", size: 16pt)[#body])

// Author list.
#let authors(body) = align(center, text(size: 11pt)[#body])

// Abstract heading.
#let abstract-heading(body) = text(weight: "bold", style: "italic", size: 9pt)[#body]

// ---------------------------------------------------------------------------

#title[A Metrically Compatible Study of Placeholder Text in Two Columns]

#authors[First A. Author, Second B. Author, Jr., and Third C. Author]

#abstract-heading[Abstract]
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor
incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis
nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.

= Introduction

Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor
incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis
nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.
Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore
eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt
in culpa qui officia deserunt mollit anim id est laborum.

Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium
doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore
veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim
ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia
consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt.

== Background

Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur,
adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et
dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis
nostrum exercitationem ullam corporis suscipit laboriosam.

= Methods

At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis
praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias
excepturi sint occaecati cupiditate non provident, similique sunt in culpa qui
officia deserunt mollitia animi, id est laborum et dolorum fuga. Et harum
quidem rerum facilis est et expedita distinctio.

= Results and Discussion

Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit
quo minus id quod maxime placeat facere possimus, omnis voluptas assumenda est,
omnis dolor repellendus. Temporibus autem quibusdam et aut officiis debitis aut
rerum necessitatibus saepe eveniet ut et voluptates repudiandae sint et
molestiae non recusandae.

= Acknowledgements

Itaque earum rerum hic tenetur a sapiente delectus, ut aut reiciendis
voluptatibus maiores alias consequatur aut perferendis doloribus asperiores
repellat.
