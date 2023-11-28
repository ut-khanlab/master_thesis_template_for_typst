#let indent() = {
  box(width: 2em)
}

#let indent_par(body) = {
  box(width: 1.8em)
  body
}

#let equation_num(_) = {
  locate(loc => {
    let chapt = counter(heading).at(loc).at(0)
    let c = counter(math.equation)
    let n = c.at(loc).at(0)
    "(" + str(chapt) + "." + str(n) + ")"
  })
}

#let table_num(_) = {
  locate(loc => {
    let chapt = counter(heading).at(loc).at(0)
    let c = counter("table-chapter" + str(chapt))
    let n = c.at(loc).at(0)
    str(chapt) + "." + str(n + 1)
  })
}

#let image_num(_) = {
  locate(loc => {
    let chapt = counter(heading).at(loc).at(0)
    let c = counter("image-chapter" + str(chapt))
    let n = c.at(loc).at(0)
    str(chapt) + "." + str(n + 1)
  })
}

#let tbl(tbl, caption: "") = {
  figure(
    tbl,
    caption: caption,
    supplement: [表],
    numbering: table_num,
    kind: "table",
  )
}

#let img(img, caption: "") = {
  figure(
    img,
    caption: caption,
    supplement: [図],
    numbering: image_num,
    kind: "image",
  )
}

// definition of abstruct page
#let abstract_page(abstract_ja, abstract_en, keywords_ja: (), keywords_en: ()) = {
  if abstract_ja != [] {
    show <_ja_abstract_>: {
      align(center)[
        #text(size: 20pt, "概要")
      ]
    }
    [= 概要 <_ja_abstract_>]

    v(30pt)
    set text(size: 12pt)
    h(1em)
    abstract_ja
    par(first-line-indent: 0em)[
      #text(weight: "bold", size: 12pt)[
      // #keywords_ja.join("; ")
      ]
    ]
  } else {
    show <_en_abstract_>: {
      align(center)[
        #text(size: 18pt, "Abstruct")
      ]
    }
    [= Abstract <_en_abstract_>]

    set text(size: 12pt)
    h(1em)
    abstract_en
    par(first-line-indent: 0em)[
      #text(weight: "bold", size: 12pt)[
        Key Words: 
        // #keywords_en.join("; ")
      ]
    ]
  }
  
}

#let toc() = {
  align(left)[
    #text(size: 20pt, weight: "bold")[
      #v(30pt)
      目次
      #v(30pt)
    ]
  ]

  set text(size: 12pt)
  set par(leading: 1.24em, first-line-indent: 0pt)
  locate(loc => {
    let elements = query(heading.where(outlined: true), loc)
    for el in elements {
      let before_toc = query(heading.where(outlined: true).before(loc), loc).find((one) => {one.body == el.body}) != none
      let page_num = if before_toc {
        numbering("i", counter(page).at(el.location()).first())
      } else {
        counter(page).at(el.location()).first()
      }

      link(el.location())[#{
        // acknoledgement has no numbering
        let chapt_num = if el.numbering != none {
          numbering(el.numbering, ..counter(heading).at(el.location()))
        } else {none}

        if el.level == 1 {
          set text(weight: "black")
          if chapt_num == none {} else {
            chapt_num
            "  "
          }
          el.body
        } else if el.level == 2 {
          h(2em)
          chapt_num
          " "
          el.body
        } else {
          h(5em)
          chapt_num
          " "
          el.body
        }
      }]
      box(width: 1fr, h(0.5em) + box(width: 1fr, repeat[.]) + h(0.5em))
      [#page_num]
      linebreak()
    }
  })
}

#let toc_img() = {
  align(left)[
    #text(size: 20pt, weight: "bold")[
      #v(30pt)
      図目次
      #v(30pt)
    ]
  ]

  set text(size: 12pt)
  set par(leading: 1.24em, first-line-indent: 0pt)
  locate(loc => {
    let elements = query(figure.where(outlined: true, kind: "image"), loc)
    for el in elements {
      let chapt = counter(heading).at(el.location()).at(0)
      let num = counter(el.kind + "-chapter" + str(chapt)).at(el.location()).at(0) + 1
      let page_num = counter(page).at(el.location()).first()
      str(chapt)
      "."
      str(num)
      h(1em)
      el.caption.body
      box(width: 1fr, h(0.5em) + box(width: 1fr, repeat[.]) + h(0.5em))
      [#page_num]
      linebreak()
    }
  })
}

#let toc_tbl() = {
  align(left)[
    #text(size: 20pt, weight: "bold")[
      #v(30pt)
      表目次
      #v(30pt)
    ]
  ]

  set text(size: 12pt)
  set par(leading: 1.24em, first-line-indent: 0pt)
   locate(loc => {
    let elements = query(figure.where(outlined: true, kind: "table"), loc)
    for el in elements {
      let chapt = counter(heading).at(el.location()).at(0)
      let num = counter(el.kind + "-chapter" + str(chapt)).at(el.location()).at(0) + 1
      let page_num = counter(page).at(el.location()).first()
      str(chapt)
      "."
      str(num)
      h(1em)
      el.caption.body
      box(width: 1fr, h(0.5em) + box(width: 1fr, repeat[.]) + h(0.5em))
      [#page_num]
      linebreak()
    }
  })
}

#let empty_par() = {
  v(-1em)
  box()
}

#let master_thesis(
  // The master thesis title.
  title: "ここにtitleが入る",

  // The paper`s author.
  author: "ここに著者が入る",

  // The author's information
  university: "",
  school: "",
  department: "",
  id: "",
  mentor: "",
  mentor-post: "",
  class: "修士",
  date: (datetime.today().year(), datetime.today().month(), datetime.today().day()),

  paper-type: "論文",

  // Abstruct
  abstract_ja: [],
  abstract_en: [],
  keywords_ja: (),
  keywords_en: (),

  // The paper size to use.
  paper-size: "a4",

  // The path to a bibliography file if you want to cite some external
  // works.
  bibliography-file: none,

  // The paper's content.
  body,
) = {
  show ref: it => {
    if it.element != none and it.element.func() == figure {
      let el = it.element
      let loc = el.location()
      let chapt = counter(heading).at(loc).at(0)

      link(loc)[#if el.kind == "image" or el.kind == "table" {
          // 章ごとに数字をカウント
          let num = counter(el.kind + "-chapter" + str(chapt)).at(loc).at(0) + 1
          it.element.supplement
          " "
          str(chapt)
          "."
          str(num)
        } else {
          it
        }
      ]
    } else {
      it
    }
  }

  // caotion番号の更新
  show figure: it => {
    set align(center)
    if it.kind == "image" {
      set text(size: 12pt)
      it.body
      it.supplement
      " " + it.counter.display(it.numbering)
      " " + it.caption.body
      locate(loc => {
        let chapt = counter(heading).at(loc).at(0)
        let c = counter("image-chapter" + str(chapt))
        c.step()
      })
    } else if it.kind == "table" {
      set text(size: 12pt)
      it.supplement
      " " + it.counter.display(it.numbering)
      " " + it.caption.body
      set text(size: 10.5pt)
      it.body
      locate(loc => {
        let chapt = counter(heading).at(loc).at(0)
        let c = counter("table-chapter" + str(chapt))
        c.step()
      })
    } else {
      it
    }
  }

  // Set the document's metadata.
  set document(title: title, author: author)

  // Set the body font. TeX Gyre Pagella is a free alternative
  // to Palatino.
  set text(font: (
    "Nimbus Roman",
    // "Hiragino Mincho ProN",
    "Noto Serif CJK JP",
    ), size: 12pt)

  // Configure the page properties.
  set page(
    paper: paper-size,
    margin: (bottom: 1.75cm, top: 2.25cm),
  )

  // The first page.
  align(center)[
    #v(80pt)
    #text(
      size: 16pt,
    )[
      #university #school #department
    ]

    #text(
      size: 16pt,
    )[
      #class#paper-type
    ]
    #v(40pt)
    #text(
      size: 22pt,
    )[
      #title
    ]
    #v(50pt)
    #text(
      size: 16pt,
    )[
      #id #author
    ]

    #text(
      size: 16pt,
    )[
      指導教員: #mentor #mentor-post
    ]
    #v(40pt)
    #text(
      size: 16pt,
    )[
      #date.at(0) 年 #date.at(1) 月 #date.at(2) 日 提出
    ]
    #pagebreak()
  ]

  set page(
    footer: [
      #align(center)[#counter(page).display("i")]
    ]
  )

  counter(page).update(1)
  // Show abstruct
  abstract_page(abstract_ja, abstract_en, keywords_ja: keywords_ja, keywords_en: keywords_en)
  pagebreak()

  // Configure paragraph properties.
  set par(leading: 0.78em, first-line-indent: 12pt, justify: true)
  show par: set block(spacing: 0.78em)

   // Configure chapter headings.
  set heading(numbering: (..nums) => {
    nums.pos().map(str).join(".") + " "
  })
  show heading.where(level: 1): it => {
    pagebreak()
    counter(math.equation).update(0)
    set text(weight: "bold", size: 20pt)
    set block(spacing: 1.5em)
    let pre_chapt = if it.numbering != none {
          text()[
            #v(50pt)
            第
            #numbering(it.numbering, ..counter(heading).at(it.location()))
            章
          ] 
        } else {none}
    text()[
      #pre_chapt \
      #it.body \
      #v(50pt)
    ]
  }
  show heading.where(level: 2): it => {
    set text(weight: "bold", size: 16pt)
    set block(above: 1.5em, below: 1.5em)
    it
  }

  show heading: it => {
    set text(weight: "bold", size: 14pt)
    set block(above: 1.5em, below: 1.5em)
    it
  } + empty_par()


  // Start with a chapter outline.
  toc()
  pagebreak()
  toc_img()
  pagebreak()
  toc_tbl()

  set page(
    footer: [
      #align(center)[#counter(page).display("1")]
    ]
  )

  counter(page).update(1)
 
  set math.equation(supplement: [式], numbering: equation_num)

  body

  // Display bibliography.
  if bibliography-file != none {
    show bibliography: set text(12pt)
    bibliography(bibliography-file, title: "参考文献", style: "ieee")
  }
}

#let LATEX = {
  [L];box(move(
    dx: -4.2pt, dy: -1.2pt,
    box(scale(65%)[A])
  ));box(move(
  dx: -5.7pt, dy: 0pt,
  [T]
));box(move(
  dx: -7.0pt, dy: 2.7pt,
  box(scale(100%)[E])
));box(move(
  dx: -8.0pt, dy: 0pt,
  [X]
));h(-8.0pt)
}