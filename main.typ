#import "./template.typ": *
#show: master_thesis.with(
  title: "Typstで書く修論のテンプレ",
  author: "右往 左往",
  university: "東京大学大学院",
  school: "工学系研究科",
  department: "航空宇宙工学専攻",
  id: "12-345678",
  mentor: "魚 竿",
  mentor-post: "准教授",
  class: "修士",
  abstract_ja: [
      近年の宇宙ってほんますごい. 近年の宇宙ってほんますごい. 近年の宇宙ってほんますごい. 近年の宇宙ってほんますごい. 近年の宇宙ってほんますごい. 近年の宇宙ってほんますごい. 近年の宇宙ってほんますごい. 近年の宇宙ってほんますごい. 近年の宇宙ってほんますごい. 近年の宇宙ってほんますごい. 近年の宇宙ってほんますごい.
  ],
  keywords_ja: ("宇宙", "異常検知"),
  bibliography-file: "references.bib",
)

= 序論
 Typstはmarkdown likeなコーディングでpdf, ポスター, スライド等のドキュメントを作成できます. Rust言語で書かれており, コンパイルが#LATEX に比べて早いのが特長です.

== Typstは優秀だ
```typ
こんな感じで @ss8843592 or #cite(<ss8843592>) と引用できます
```

こんな感じで @ss8843592 or #cite(<ss8843592>) と引用できます


=== エレガントに書ける
数式
```typ
$ mat(1, 2; 3, 4) $ <eq1>
```
と書くと
$ A = mat(1, 2; 3, 4) $ <eq1>
@eq1 を書くことができます.

関数を作れば
#img(
  image("Figures/typst.svg", width: 20%),
  caption: [イメージ],
) <img1>\
@img1 を表示できますし,

#tbl(table(
    columns: 4,
    [t], [1], [2], [3],
    [y], [0.3s], [0.4s], [0.8s],
  ),
  caption: [テーブル @madje2022programmable],
) <tbl1>
@tbl1 も表示できます.

= 先行研究

#LATEX はカスタム性の高さ, 歴史的なところからまだまだ廃れないとは思いますが, 卒論や修論や学会の予稿等の作成においてはTypst @madje2022programmable の使いやすさから置き換わるのではないかと思います(半分願望).
#img(
  image("Figures/typst-github.svg", width: 20%),
  caption: [Typst + git @madje2022programmable],
) <img2>

=== #LATEX はコンパイルが遅い

本資料は, #LATEX でコンパイルの待ち時間中に作りました. 
他にも
```typ
#include path.typ
```

とすれば, 他ファイルを参照できるので, 長い分量の本などを作成する際に, 章ごとにファイルを分けるなどができるようになります.\
便利なので広まれば良いなと思います. \
詳しくは#link("https://typst.app/docs")[
  公式ドキュメント
]をご覧ください

= 定義

Typstでは関数定義が簡単であるので定理の書き方などをカスタマイズできます.

== 定義例
`thmbox`関数を作ってカスタマイズをできるようにしました.
```typ
#let theorem = thmbox(
  "theorem", //identifier
  "定理",
  base_level: 1
)

#theorem("ヲイラ-")[
  Typst はすごいのである.
] <theorem>
```

#let theorem = thmbox(
  "theorem",
  "定理",
  base_level: 1
)

#theorem("ヲイラ-")[
  Typst はすごいのである.
] <theorem>

```typ
#let lemma = thmbox(
  "theorem", //identifier
  "補題",
  base_level: 1,
)

#lemma[
  Texはさようならである.
] <lemma>
```
#let lemma = thmbox(
  "theorem",
  "補題",
  base_level: 1,
)

#lemma[
  Texはさようならである.
] <lemma>

このように, @theorem , @lemma を定義できます .\
カッコ内の引数に人名などを入れることができます.
また, identifierを変えれば, カウントはリセットされる.
identifier毎にカウントを柔軟に変えられるようにしてあるので, 様々な論文の形式に対応できるはずです.
```typ
#let definition = thmbox(
  "definition", //identifier
  "定義",
  base_level: 1,
  stroke: black + 1pt
)
#definition("Prime numbers")[
  A natural number is called a _prime number_ if it is greater than $1$ and
  cannot be written as the product of two smaller natural numbers. 
] <definition>
```

#let definition = thmbox(
  "definition",
  "定義",
  base_level: 1,
  stroke: black + 1pt,
)

#definition[
  Typst is a new markup-based typesetting system for the sciences. 
] <definition>

@definition のようにカウントがリセットされています.

```typ
#let corollary = thmbox(
  "corollary",
  "Corollary",
  base: "theorem",
)

#corollary[
  If $n$ divides two consecutive natural numbers, then $n = 1$.
] <corollary>
```

#let corollary = thmbox(
  "corollary",
  "Corollary",
  base: "theorem",
)

#corollary[
  If $n$ divides two consecutive natural numbers, then $n = 1$.
] <corollary>

baseにidentifierを入れることで@corollary のようにサブカウントを実現できます.

```typ
#let example = thmplain(
  "example",
  "Example"
).with(numbering: none)

#example[
  数式は\$\$で囲む
] <example>
```

#let example = thmplain(
  "example",
  "例"
).with(numbering: none)

#example[
  数式は\$\$で囲む
] <example>

thmplain関数を使ってplain表現も可能です.