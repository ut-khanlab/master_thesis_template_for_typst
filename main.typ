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
)

= 序論
 Typstはmarkdown likeなコーディングでpdf, ポスター, スライド等のドキュメントを作成できます. Rust言語で書かれており, コンパイルがLatexにくらべて早いのが特長です.

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
  caption: "イメージ",
) <img1>\
@img1 を表示できますし,

#tbl(table(
    columns: 4,
    [t], [1], [2], [3],
    [y], [0.3s], [0.4s], [0.8s],
  ),
  caption: "テーブル",
) <tbl1>
@tbl1 も表示できます.

= 先行研究

== #LATEX はオワコンだ

#LATEX ではカスタム性の高さ, 歴史的なところからまだまだ廃れないとは思いますが, 卒論や修論や学会の予稿等の作成においてはTypst @madje2022programmable の使いやすさから置き換わるのではないかと思います(半分願望).

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