
                         □□□ TEBA の使い方 □□□

■ インストール

  インストールしたい場所に展開する

  例: [ホームディレクトリの下の teba というディレクトリに展開する]

    (1) TEBA の最新版をダウンロードする。
        以下、ダウンロードされたファイルは ~/Download/teba-X.XX.tar.gz と
        表記する。

    (2) 展開する。

        cd             # ホームディレクトリに移動 (すでに移動しているなら不要)
        tar zxvf ~/Download/teba-X.XX.tar.gz

    (3) 名前を変更する
        展開すると、バージョン番号が入ったディレクトリ(ここでは teba-X.XX と
        表記する)ができるので、名前を変更する。

	mv teba-X.XX teba

■ パッケージの内容

  展開すると以下のファイルおよびディレクトリができる。

     COPYRIGHT
     README
     TEBA/
     bin/
     sample/

  COPYRIGHT は著作権に関する記述、README は使い方に関する記述が書かれた
  ファイルである。ディレクトリ TEBA には実行に必要なライブラリ等の
  ファイルが、bin には実行コマンドが配置されている。ディレクトリ sample は
  プログラムのパターンによる書換えの例となるファイル群である。

  実行にあたっては、bin の下のコマンドを起動する。なお、bin の下のコマンドは
  bin と同じディレクトリにあるディレクトリ TEBA からライブラリを読み出すので
  この構成は変更しないこと。(注意: この文章ではディレクトリ名の "teba" は
  パッケージを展開した場所を、"TEBA" はパッケージの中のライブラリを格納して
  いる場所を表すので、区別して読むこと。)

■ 準備

  (1) 必須ライブラリ
  一部のコマンドで、Perl のモジュールである Algorithm::Diff を利用しているので
  あらかじめインストールしておくこと。各自の OS のアプリケーション管理システム
  で該当するパッケージを探してインストールする。もしない場合には、CPAN を
  利用してインストールする。

  (2) 実行パス
  各ターミナル(シェル)で、環境変数 PATH に bin を追加する。例えば、bash を
  使用している場合には以下の命令を実行する。

     PATH=${PATH}:~/teba/bin

  なお、毎回、ターミナルで設定することを避けるには、~/.bashrc に上記の命令を
  書いておけばよい。 (注意: シェルに csh, tcsh, zsh を使っている場合には、
  各シェルに合わせて設定すること)

■ コマンド

  ディレクトリ bin の下にあるコマンド(実行ファイル)とその機能は以下の通り
  である。

  cparse.pl           # 構文情報を含む字句系列を生成する
    引数: 解析対象ファイル名 (省略した場合は標準入力)
    オプション -E   式レベルの詳細の解析をしない (以前の版との互換性維持用)
               -f   左結合の2項演算子について、連続する同じ演算子の結合を
                    1つの式単位になるように再構成する 
                    (Ex. (((a) + b) + c) => (a + b + c)
               -t   テストモード (解析時に使用した一時的な仮想字句が残って
                    いないか、仮想字句や括弧の組の対応が正しいかを調べ、
                    異常がある場合には最後に出力する)

  id_unify.pl         # 2つの字句系列で、内部識別記号を統一
    引数: 字句系列ファイル名A 字句系列ファイル名B
    出力: 2つのファイルの名前の後ろに、それぞれ .unified を付けたファイルが
          生成され、その中に統一後の字句列が格納される。

  join-token.pl       # 字句系列から元のテキストを再構成する
    引数: 字句系列ファイル名 (省略した場合は標準入力)
    オプション: -d  仮想字句を残した状態で再構成する
                    仮想字句にはエスケープシーケンスで色をつけている。
                    less を使って見るときは -R オプションをつける必要がある。
                -E  -d オプションと同時に使用し、式に関する仮想字句を排除する

  rewrite.pl          # プログラムパターン記述に基づて字句系列を書換える
    引数: -p プログラムパターン記述ファイル名  字句系列ファイル名
              (字句系列ファイル名を省略した場合は標準入力)
    オプション: -s   空白保存モード (コメントや空白をすべて残し、できるだけ
                     位置も保つ。削除しないので、不自然な結果になることもある)
                -r   再帰適用モデル (書換えが行われなくなるまで、繰り返し
                     パターンを適用する。無限ループに陥る場合もある)
                -e   式モード (パターンを文、宣言、関数としてではなく、
                     単純に式として取扱う。)
                -d   デバッグモード (プログラムパターン記述から生成される
                     字句系列パターン記述や、さらに、そこから生成される
                     文字列の正規表現を確認できる。)

  rewrite_token.pl    # 字句系列パターン記述に基づいて字句系列を書換える
    引数: 字句系列ファイル名
    オプション: -p "字句系列パターン記述"  (引数に直接記述されたルールに
                      従って書換える)
                -f  字句系列パターン記述ファイル名 (ルールをファイルから
                    読み込んで適用する)
                -d  デバッグモード (ルールから生成される文字列の正規表現も
                    出力する)

  preg.pl            # パターン記述に基づいてプログラム断片を検索する
                       パターンの記述方法は rewrite.pl の %before と同じ
    引数: パターン ファイル名
    オプション  -a プログラム全体を出力し、その中で該当箇所を {< と >} で
                   囲む。
                -d デバッグモード (検索時に用いるパターンの出力)
                -e 式モード (パターンを文、宣言、関数としてではなく、
                   単純に式として取扱う。)
                -h オプション等の出力
                -t テキストではなく、字句系列を出力する。
		-T 入力ファイルを字句系列として読み込む。
                -v 出力に色を付加する。(ANSI エスケープシーケンスを使用)
                -f 直後にファイル名を書き、パターンを引数で指定する代わりに
                   ファイルからパターンを読み込む。複数のパターンを同時に
		   指定するときは、パターン間を "%%--\n" で区切る。
		-l 適合箇所の前後を、オプションのあとに指定された行数だけ
             	   出力する。該当箇所は {< と >} で囲まれて出力される。
                -b 適合箇所を含むブロック(文/宣言/関数/マクロ定義)全体を
		   出力する。オプションのあとに何ブロックの入れ子を遡るか
		   指定する。該当箇所は {< と >} で囲まれて出力される。
                -s 適合箇所の前後のブロックの境界を指定された数だけ含んで
		   出力する。境界の数はオプションのあとに指定する。
		   該当箇所は {< と >} で囲まれて出力される。
                -p 直後に検索するパターンを記述する。パターンが "-" (ハイフン)
                   で始まる場合に、オプションとして解釈させないために用いる。
		-r マッチした箇所の前後の一時仮想字句 /_[RM][BE]/ を取り除く。
                   広い条件で適合させたあとの字句系列に対し、例外として
                   排除したいパターンを指定して、適合箇所から除外する。
	        -u 入力から一時仮想字句 /_[RM][BE]/ をすべて取り除いてから、
		   パターンに適合する。文脈となる条件で取り出した字句系列から、
		   さらに目的のパターンに適合する箇所を取り出すときに使用する。

■ コマンドの典型的な組み合わせ

  基本的には、以下のように使用する。(書換え対象のソースファイルを Source.c、
  書換えパターンのファイルを Pattern.pt とする。)

    cparse.pl Source.c | rewrite.pl -p Pattern.pt | join-token.pl

  出力をファイルに保存したい場合はリダイレクトを利用する。 (出力先の
  ファイル名を Result.c とする。Source.c に直接書き込んではいけない。)

    cparse.pl Source.c | rewrite.pl -p Pattern.pt | join-token.pl > Result.c

  less で確認したいときは、以下のようにパイプで接続する。

    cparse.pl Source.c | rewrite.pl -p Pattern.pt | join-token.pl | less

  構文解析後あるいは、書換え後の構文の情報を確認したい場合には、
  join-token.pl の -d オプションを用いる。また、エスケープシーケンスを正しく
  処理させるためには less には -R をつける必要がある。

    cparse.pl Source.c | join-token.pl -d | less -R
    cparse.pl Source.c | rewrite.pl -p Pattern.pt | join-token.pl -d | less -R

  書換え前後の字句の違いを調べたいときは以下のように diff で比較する。

    cparse.pl Source.c > Source.t0
    cparse.pl Source.c | rewrite.pl -p Pattern.pt > Source.t1
    diff -u Source.t0 Source.t1
  
  ただし、書換えによって、同じ構文要素であっても内部識別記号が変更され
  差分として出力されることがある。それを避けるためには、以下のように
  diff で確認する前に id_unify.pl を用いて統一し、統一されたファイルを
  比較する。
  
    cparse.pl Source.c > Source.t0
    cparse.pl Source.c | rewrite.pl -p Pattern.pt > Source.t1
    id_unify.pl Source.t0 Source.t1
    diff -u Source.t0.unified Source.t1.unified

  TEBA のツールは、UNIX のコマンドの基本理念を尊重して作成しており、
  シェルとの組み合わせを重視している。すなわち、リダイレクトやパイプなどの
  機能を用いることや、diff などの既存のツールと組み合わせることを前提として
  余分な機能は作り込まないようにしている。よって、利用にあたっては、シェルに
  関する知識を習得していることが望ましい。

■ プログラムパターンの記述方法

□ 全体の構成

  以下の例ように、変更前と変更後の記述を %before と %after の直後に書く。

    % before
      for ( ${init:EXPR} ; ${cond:EXPR} ; ${succ:EXPR} )
        ${stmt:STMT} $;
    % after
      ${init};
      while (${cond}) {
          ${stmt} $;
          ${succ} ;
      }
    % end

  なお、この記述は、for 文を while に置き換える記述の例である。


□ パターンの表現

  変数名や式など、可変な要素を表現するために、パターンでは以下の表現が使える。

    (a) パターン変数
    (b) グループ

  また、書換えの挙動を制御する指示として以下の記述がある。

    (c) オプション指定

    . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 

  (a) パターン変数は、任意の識別子、型、式、文、宣言子、宣言に適合する変数で、
  変更前(%before)では以下のように、適合する要素の種別を指定して書く。

    書き方: ${変数名:種別}, ${{変数名:種別}}
    使用例: ${s:STMT}, ${e:EXPR}, ${{var:ID_VF}}, ${:DECR}

  ${:DECR} のように変数名を省略することもできる。ただし、これは次に
  述べる変更後(%after)で、その変数を参照できない。後述するグループを
  使用したときに、参照する必要がない変数が生じることがあり、その記述を
  簡便にするために用いる。

  2種類の書き方があるが、どちらもパターン変数は指定された種別のみに適合する。
  ただし、${{変数名:種別}} は、前後に任意の字句列が存在することを許容する。
  すなわち、実質的には、以下のように3つのパターン変数を指定している場合と
  同じである。

     ${:ANY} ${変数名:種別} ${:ANY}

  ただし、パターンにこれを直接記述すると、構文解析では3つ変数が並んでいると
  解釈され、この前後に演算子を配置すると、どちらかの {$:ANY} と結合するので、
  期待通りの構造を得られない。


  変更後(%after)は、以下のように名前だけを書き、変数の参照を表す。パターン
  変数の参照は、その変数に適合した字句への置き換えを意味する。変数名は
  省略できない。

    書き方: ${変数名}
    使用例: ${s}, ${e}, ${var}

  なお、変更前(%before)で、パターン変数に適合したものと同じものが存在することを
  示したい場合には、変数名のみを書く。例えば、同じ文が並んでいることを表す
  パターンは以下のように書く。

    %before
      ${st:STMT} $;
      ${st} $;
    %after
      ....
    %end

  ここで、"$;" は、特別な記号で、文の終りを表す。これは、パターンを構文解析
  するときに文の区切りを明確に指定する役割がある。
 
  パターン変数に用いる「種別」は、1つの字句に適合させたいときは字句の種別を、
  複数の字句の並びに適合させたいときは、ファイル TEBA/default-token.def に
  文字列の正規表現を用いて名前を定義して使用する。

    . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 

  (b) グループは、記述の繰り返しや存在しない場合もあることを表現したいときに
  用いる。正規表現で用いる *, +, ? にも対応している。以下に記述例を示す。

    % recursive
    % before
    ${type:TYPE} ${decr:DECR} , $[others: ${:DECR} $[: , ${:DECR} $]* $] ;
    % after

    ${type} ${decr};
    ${type} $[others];

    % end

  グループは、グループの開始と終了を表す2つの記号で表現され、以下の形式で
  記述する。

    グループの開始:  $[名前:
    グループの終了:  $]

  名前は省略可能であるが、%after で適合した字句列を参照できなくなる。
  字句列を参照するにはグループの名前を用いて、以下のように記述する。

    $[名前]

  なお、パターン変数と同様に ${名前} と参照することも可能だが、その場合、
  式を構成する B_P と E_P に囲まれる。構文木としては正しくない状態に
  なる可能性が高い。

  グループのオプションとして、'*', '+', '?' の3つ記号を用いて、それぞれ
  「0回以上の繰り返し」、「1回以上の繰り返し」、「1つ以下存在する」の
  3種類の条件を表現できる。それぞれ、以下のように、グループの終了の後ろに
  記号を記述する。

    0回以上の繰り返し:   $[名前:  .... $]*
    1回以上の繰り返し:   $[名前:  .... $]+
    1つ以下存在する:     $[名前:  .... $]?

  なお、グループは、繰り返し全体の字句を参照する。すなわち、正規表現で
  (abc)* と記述した場合、グループ(括弧の組)を後方参照したときに、
  繰り返される abc のうち最後の abc のみが対象となる。TEBA における
  グループは、正規表現で表したときは ((abc)*) と二重に用いたときの
  外側のグループに対応する。

  パターンを構文解析するときに、グループは空白として扱う。グループの
  開始記号と終了記号は、その存在を無視したときに構文的に妥当である限り、
  どの位置でも用いることができる。

    . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 

  また、グループでは、選択(論理和)も以下の記号で表現できる。

    $|

  ただし、パターンを構文解析するときは空白と同等に扱うので、$| を無視した
  ときに構文解析ができ、また、構文木の部分木が意図通りになるように配置する
  ことが必要である。例えば、exit() と return のどちらかに適合したいときは
  以下のように記述する。

    $[exit: exit(${:EXPR}); $| return ${:EXPR}; $]

  この記号の扱いには制約があるので注意が必要である。例えば、上記の記述で、
  共通するセミコロンを外側に出した以下のような記述をすると、

    $[exit: exit(${:EXPR}) $| return ${:EXPR} $] ;

  構文解析では、"exit(${:EXPR}) return ${:EXPR};" という文法的にありえな
  文を解析することになり、意図通りには適合しない。現状としては、連続して
  並んでも文法的に正しい状態であることが必須であり、実際的には文や宣言の
  選択にのみに利用可能である。
  
  また、以下のように、選択の中でパターン変数に名前を付けた場合、

    $[exit: exit(${e:EXPR}); $| return ${e:EXPR}; $]

  パターン変数 ${e} は、それぞれの選択で適合した字句列を参照する。
  なお、この場合、各選択の中のパターン変数の名前とその出現順序は一致して
  いる必要がある。内部の実装では Perl の正規表現の "branch reset" を
  使用しているので、詳細については、名前を用いた後方参照と合わせて
   Perl のマニュアルを参照すること。

    . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 

  (c) オプション指定は、rewrite.pl のオプションのうち -s, -r, -e に対応して
  おり、それぞれ以下のように記述する。

     % space preserving
     % recursive
     % expression

  なお、各オプション指定は先頭の1, 2文字だけを見て区別しており、
  %s, %r, %ex と書くだけでもよい。

■ 字句系列パターンの記述方法 (RewriteTokens)

  字句系列に対するパターンは以下の3つの記述から構成される。書換えルールは
  基本形と、字句の置換と削除のためのルールの2種類に分けられる。

    (a) 書換えルール
      (a-1) 基本形
      (a-2) 字句の置換と削除のためのルール
      (a-3) 字句の分割
      (a-4) 文字列から識別子への変換
    (b) 字句種別定義
    (c) フィルタ

    . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 

  (a-1) 基本形: 書換えルールは、書換え前の字句列の状態と書換え後の状態の
  記述で構成され、以下のように記述する。

    { 書換え前の字句列の並び } => { 書換え後の字句列の並び }
    { 書換え前の字句列の並び } =>> { 書換え後の字句列の並び }

  真ん中の記号の => は、ルールを1回だけ適用することを、=>> は書換えが
  できなくなるまで繰り返し適用することを意味する。

  書換え前の字句列の並びは、以下の要素で構成される。

     型付き字句変数            $名前#後方参照名:{型指定}{字句指定}
     			       '#後方参照名' は省略可能
			       {型指定} => 型名 or /正規表現/
			       {字句指定} => /正規表現/ (省略可能)

     テキスト指定字句変数      $名前:'テキスト' or $名前#後方参照名:'テキスト'

     変数参照                  $名前

     字句参照                  'テキスト':型

     グループ                  $[名前:  ... $] オプションとして '*', '+', '?'

     結合演算子		       $##

  このうち、グループの表記は、プログラムパターン記述のグループと同じである
  ので、以下では説明を省略する。

    . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 

  「型付き字句変数」は、その型、すなわち種別名に合致する字句に適合する。
  型は、$bp:B_P のように、種別名をそのまま書くか、$ct:/CT_.*/ のように、
  スラッシュで囲って種別名の正規表現を指定する。「後方参照名」(後述)と
  「字句指定」は省略が可能である。「字句指定」には、$while:ID_VF/[A-Z1-0_]+/
  のように、スラッシュで囲って正規表現で、適合したいテキストを指定する。

  「テキスト指定字句変数」はテキストに合致する字句に適合する。(同じことが
  型付き字句変数で表現できるので、近い将来、廃止される予定)

  それぞれの変数は、同じ字句が出現していることを示すときに参照することが
  でき、その「変数参照」は名前のみを記述する。いずれも名前は省略可能だが、
  省略した場合は参照することはできない。

  また、単に字句の存在だけを指定したいときは「字句参照」を用いる。
  字句はそのまま正規表現の一部として扱うので、バックトラックを制御する
  特殊なメタ記号などを挿入したい場合にも利用できる。

  「型付き字句変数」と「テキスト指定字句変数」は、オプションとして「後方
  参照名」を指定できる。これは、括弧や仮想字句のように、開始と終了で1つの
  組になっているものについて、正しい組み合わせで変数に合致させるときに
  用いる。例えば、丸括弧の組を表現したときは、以下のように記述する。

    $pl#1:P_L  ...  $pr#1:P_R
    $pl#1:'('  ...  $pr#1:')'

  なお、「後方参照名」は文字または数字の組み合わで表現し、上記の例では
  単純な 1 を使っている。ルールの中で、入れ子など複数の組が存在する
  場合には、以下のようにそれぞれの組ごとに別の名前をつける必要がある。

    $pl1#outer:P_L  $pl2#inner:P_L  ...  $pr2#inner:P_R  $pr1#outer:P_R

    . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 

  書換え後の字句列の並びは、以下の要素で構成される。

    変数参照     $名前  or  $名前:型
    字句参照     'テキスト':型  or 'テキスト'#後方参照名:型
    結合演算子	 $##
   
  「変数参照」は、書換え前の字句列に含まれる変数の参照であり、変数に適合した
  字句または字句列への置き換えを意味する。名前の後ろに型をつけた場合は、
  字句の型を指定したものに変更することを意味する。ただし、その場合は、
  変数は単一の字句に適合していることが必要となる。

  「字句参照」は、指定した型(種別名)の字句に置き換わることを意味する。
  後方参照名は、括弧や仮想字句など組を構成する字句を配置する場合に
  使用し、同じ後方参照名を持つ字句には、同じ内部識別番号を割り振り、
  それらの組を表現する。TEBA の解析ルールを例として以下に示す。

    @TERMINAL => "(?:ID_(?:VF|MB|MC)|LI).*+\n"
    { $id:TERMINAL } => { ''#1:_B_X $id ''#1:_E_X }

  TERMINAL は、終端記号となる識別子と定数値を表す種別であり、その前後に
  仮想字句 _B_X と _E_X を組になるように入れることを意味する。

    . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 

  (a-2) 置換と削除の記法: 特定の範囲に含まれる字句の置換と削除を記述する
  専用の記法である。

    { 置換したい字句 in それを囲う型 } => { 置換後の字句 }
    { 削除したい字句 in それを囲う型 } => { }

  「置換したい字句」および「削除したい字句」は型付き字句変数で書く。ただし、
  型指定のみが許され、字句指定はできない。また、「それを囲う型」は型名のみを
  書くが、範囲は、その型名に B_ または _B_ を付けた型からE_ または _E_ を
  付けた型までを意味する。置換後の字句も、型付き字句変数で書くが、型指定のみが
  許され、かつ、型指定に正規表現は使用できない。例えば、_B_PCOND と _E_PCOND
  で囲われた範囲の IDN 型を ID_MC 型に変換したいときは以下のように記述する。

      { $:IDN in PCOND } => { $:ID_MC }

  この例では変数名を省略しているが、記述していもよい。この特殊な記法を
  使用しなくても、削除や置換は表現できるが、極めて効率が悪く、定義が複雑化
  する。この記法を用いた場合、専用のルーチンに置き換わるので、高速に処理される。

    . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 

  (a-3) 同じ接頭辞を持つ識別子に適合したいときなど、識別子を分割したいときは
  結合演算子 $## を用いる。結合演算子は、前後の変数を1つの字句として処理する。
  例えば、以下のように記述すると、1つの字句を "_" の直前で分割し、2つの字句に
  分けることができる。

    { $x:IDN/\w+/ $## $y:IDN/_.*/ } => { $x $y }

  この場合、直感的には、/(\w+)(_.*)/ という正規表現に適合させ、2つのグループに
  適合した字句が $x と $y に格納される。なお、$## の後ろの字句の型は無視され、
  前の字句の型に統一される。

  上記の例で、$x のパターンとして /\w+/ を指定しているが、これを /\w*/ や
  /.*/ など、長さ 0 の字句が適合できるようにすると、$y の結果に適当し続け、
  停止しなくなるので注意が必要である。

  この演算子は、C言語の前処理で用いる ## 演算子を模倣しており、## 演算子を
  使用したマクロ定義をパターン化するときなどに使用できる。

    . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 

  (a-4) 変数名が文字列になっている場合に、その文字列を変数として扱いたい
  ときは $# 演算子を用いる。例えば、次のようなマクロ定義を考える。

    #define print_int_var(v) printf("debug: %s = %d\n", #v, v)

  このマクロに置き換えられる場所を探して書換えるときに、

    printf("debug: %s = %d\n", "hoge", hoge)

  という式を探さなければならない。このうち2番目と3番目の引数部分に
  適合するパターンは次のように記述できる。(注意: B_P と E_P を省略)

    { $# $v:LIS $c:CA $v:ID_VF }

  この場合、最初の $v は文字列(LIS)として適合するが、文字列定数の中の
  文字列を取り出し、2番目の $v の後方参照は、その文字列を名前とする
  識別子の参照になる。次のように、後方参照する方に $# を付加することも
  できる。

    { $v:ID_VF $c:CA $# $v:LIS }

  書換え後に $v を参照した場合、一律に IDN 型になる。これは、書換え後の型は
  正確に求められないからである。もし、書換えルールを書くときに、型がわかる
  のであれば、$v:ID_VF のように型を明示的に指定することが望ましい。

    . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .


  (b) 字句種別定義は、複数の種別を扱いたい場合など、特殊な種別を用いたい
  ときに定義する。記述方法は以下の通りである。

    @種別名 => "正規表現"

  ここで記述する正規表現は、TEBA の属性付き字句全体を表現するもので、
  最後は改行(\n)を明示的に記述する必要がある。また、正規表現の中で、
  "@種別名" と書くと、その種別名の定義が展開される。(補足: 将来的には、
  生の正規表現を扱うのではなく、抽象化された簡便な記述の導入が必要で
  あると認識しているが、最適化が必要になるなど簡単ではない。)

  記述例として、TEBA における空白の連続の定義 @P_ と、それに必要な種別の
  定義を示す。 (TEBA/token-pattern.def より)

    @TOKEN => ".*+\n"
    @ANY => "(?:@TOKEN)*?"

    @_SPC => "SP.*+\n"
    @_DIRE => "B_DIRE.*+\n(?>(?:@ANY)E_DIRE).*+\n"
    @_SP => "@_SPC|@_DIRE"
    @SP => "(?:@_SP)*+"

  例えば、@_SPC は、種別名が SP で始まるすべての字句に適合し、空白文字や、
  改行などに適合する。@_DIRE は、前処理命令を1つの単位として扱うための
  パターンで、構文解析時に前処理命令が途中に含まれても無視することができる。
  @_SP は、1つの空白を表現し、@_SPC と @_DIRE を組み合わせている。
  基本的な記述の流儀として、"_" で始まる種別名は、定義を構成する部分的な
  要素で、かつ、ルールの記述では直接使用する可能性が低いものに用いている。
  また、@_SP と @SP のように、1種類の字句の定義と、その連続の定義は分けて
  記述することで、1種類の字句の定義の方は部品として、他の定義でも用いる
  ことができ、再利用性を高めている。

  TEBA では、各解析のためのルール定義(TEBA/*.rules)や、字句の種別定義
  (TEBA/token-pattern.def)の中で、正規表現の最適化を考慮して記述している。
  特に、バックトラックの抑制は重要であり、上記の例の中で、頻繁に用いて
  いる "*+" や、@_DIRE の "(?> ... )" はバックトラックの必要がないことを
  指示するために用いている。TEBA のルール定義の中では、'(?>':X や ')':X
  といった X 型を使用した記述が含まれるが、これもバックトラックの抑制の
  ために用いている。正規表現の詳細については、Perl の正規表現のドキュメントを
  熟読すること。(man perlre または perldoc perlre)

  同じ名前の定義が重複した場合、後方に記述された定義が優先され、全体に
  おける定義となる。部分的に定義が変わることはない。また、以下のように、
  自分自身を参照することができる。

     @_EXPRS => "@_EXPRS|_[BE]_(?:A|OP).*+\n"

  この場合、右辺の自分自身の参照は、この定義の直前までの定義に置き換わる。
  これにより、定義を読み込んだときに、オーバーライドすることも可能になる。
  上記の例は、expr-p01.rules において、一時的な仮想字句 _[BE]_A と
  _[BE]_OP01 を式の要素として扱う必要があるので、オーバーライドによって
  拡張している。(本来は "@_EXPRS|_[BE]_(?:A|OP01).*+\n" と書くのが正しいが、
  OP までで対象が確定するので、手を抜いて 01 は省略している)

    . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 

  (c) フィルタ

  フィルタは、ルールを適用していく過程で、特別な処理をしたい場合に、その
  指示を記述する。指示として記述できるものは以下の通りである。

   規則の挿入   @"ファイル名"
   実行フィルタ @|Method|
   強制停止     @!BREAK!

  「規則の挿入」は、それが書かれた場所に指定されたファイルを展開する。これは
  C言語の前処理における #include とほぼ同じである。

  「実行フィルタ」は、書換えルールでは対処できない処理を扱うときに用いる。
   TEBAの解析器における使用例を以下に示す。

     @|BeginEnd->new()->conv|
     @|CoarseGrainedParser->delete_stmt_in_compound_literal|
     @|NameSpaces->id_member|
     @|NameSpaces->id_fix|

  モジュール BeginEnd は、仮想字句の各組に対して、その組を表現する内部識別
  記号を割り振るもので、規則の中で、片方ずつ挿入したような場合に、以後の
  処理に支障が起きないよう、割り振り直すときに用いる。

  CoarseGrainedParser->delete_stmt_in_compound_literal は、文ではない
  中括弧、すなわち、構造体型の変数や配列の初期化式や、複合値から、文の区切りを
  表す仮想字句 [BE]_ST を削除する処理である。これは書換えルールとしては
  記述可能だが、極めてパフォーマンスが悪いことから、専用の処理を書いて
  置き換えている。

  NameSpaces については、変数と型、タグ、メンバなど識別子の種別を解析し、
  置き換えるためのフィルタである。

 「強制停止」はデバッグ用の機能であり、それが書かれた箇所で処理全体が止まり、
  その時点までの解析結果(すなわち字句系列)が出力される。また、その直前の
  ルールから生成された正規表現の記述も出力される。ルールが期待通りに適用
  されない場合に、その直前または直後の状態を確認することで、原因がわかる
  場合がある。

■ 字句系列パターンの適用順序

  字句系列パターンの処理は、モジュール RewriteTokens が行う。これを使用する
  ときは、そのインスタンスを生成して実行するが、ルールの適用方法を選択できる。
  以下に生成方法と適用のされ方を示す。

    RewriteTokens->new()   ルールの上から下に適用を試み、書換えられたら、
                           また先頭に戻って繰り返す。最後のルールまでに
                           書換えが発生しなければ終了する。
                                  
    RewriteTokens->seq()   ルールを上から下に1度だけ適用していく。

    RewriteTokens->rep()   ルールを上から下に1度だけ適用していき、
                           1回でも書換えが起きていれば、再度、先頭から
                           適用を繰り返していく。書換えが発生しなければ
                           終了する。

  TEBA の解析では、ルールの状況に合わせて、これらを組み合わせて実現している。
  RewriteTokens を使用する場合は、できるだけ seq() を使うと、無限ループを
  回避しやすく、また、効率が良い。また、同じ繰り返しでも rep() の方が
  問題が起きたときにその挙動を理解しやすい。ただし、実行効率は、必ずしも
  rep() の方が良いとは限らない。

  new(), seq(), rep() の各メソッドは、引数にルールを渡せば、インスタンスの
  生成と同時にルールを設定する。インスタンスを生成したあとに、ルールを
  設定したい場合は set_rules() を使う。また、すでに設定したルールの後ろに
  ルールを追加したいときは、add_rules() を使う。なお、ファイルから読み込ま
  せたいときは、load() を用いる。load() は内部で add_rules() を呼んで
  設定を行なっており、読み込んだ順に登録される。ルールの適用順序も
  読み込んだ順に従う。


■ TEBA の内部の概要

□ cparse.pl (CParser.pm)

  cparse.pl は、CParser.pm を呼び出すラッパーであり、基本的な処理は
  CParser.pm に記述されている。処理は解析対象のテキストを以下の順に
  処理していく。

    (1) Tokenizer で字句に分解する
    (2) 前処理指令について解析する
    (3) 括弧の対応関係について解析する
    (4) マクロ文を解析する
    (5) 文レベルの粗い解析をする
    (6) 名前空間の切り分けを行う
    (7) 式レベルの解析を行う
    (8) 補正処理と宣言の識別を行う

  これらの処理は可能な限り、字句系列の書換えルールとして実現している。
  書換えルールでは、様々な要素の組み合わせに対応できるよう、目的の構造の
  核となる部分を特定して、一時的な仮想字句を配置してから、その仮想字句を
  基としてさらにルールを適用していく手法が取られている。このとき、仮想字句
  の型名は、必ず "_" で始めるようにしており、解析の終了までには削除れるか、
  名前が変更される。よって、解析結果に "_" を含む型が含まれたときは、
  何らかの理由で解析に失敗していることを意味する。また、型名を見ることで、
  問題が起きたルールを見つける手掛りとなる。

  (1) Tokenizer は字句解析器であり、TEBA/token.def に従って字句に分解する。
  分解された結果は、属性付き字句系列となる。

  (2) 前処理指令のみを解析し、前処理指令の範囲を確定する。これにより、
  以後の解析で、前処理指令を空白として扱ったり、前処理指令の内部に閉じた
  構文解析が可能になる。(TEBA/prep.rules)

  (3) 括弧の対応関係を解析し、対応する組には同じ内部識別記号を割り当てる。
  また、対応する括弧の数が合わないマクロ定義があった場合には、テキストを
  持たない仮想字句として、疑似的な括弧を挿入し、必ず組が閉じるようにする。
  (TEBA/BracketsID.pm)

  (4) マクロを文や宣言のように使用していて、かつ、行末がセミコロンでは
  終わっていない場合に、仮想字句として擬似的なセミコロンを追加して、
  整合を取る。なお、これはヒューリスティックな規則であり、完全ではない。
  (TEBA/macro-stmt.rules)

  (5) 文レベルまでの解析をする。式のレベルの解析をしない理由は、型と
  それ以外の識別を区別できないと、構文木を唯一に決められない曖昧な
  表現があるためである。例えば (x)(y) は x が型か関数名かによって木構造が
  異なる。そのため、先に曖昧さの少ない文レベルまで解析し、識別子が
  どの名前空間に属するかを推定してから、式レベルの解析を行う。
  (TEBA/CoarseGrainedParser.pm)

  (6) 名前空間の切り分けは、識別子をタグ、ラベル、メンバ、マクロ、型、
  変数または関数に分ける。マクロを使った特殊な形がない限り、タグ、ラベル、
  メンバは前後の文脈から正確に決まる。マクロは、本来は名前空間に属さない
  分類であるが、前処理指令の中など明確にマクロ名とわかるものだけを
  取り扱う。型は、文脈から推定して型と確信が持てるものだけを置き換える。
  最終的に残った識別子を変数または関数として扱う。(TEBA/namespace.rules)

  (7) 式レベルの解析は、優先度に基づいて解析をしていくのみである。
  ただし、+ や - のように単項演算子と2項演算子の両方がありうるものを
  区別するために、単項演算子の文脈で出現する演算子を識別し、型名を
  OP_U に変更して区別する。また、カンマは演算子であるが、線形構造を
  表現することに意味があるとは思われないので、解析ルールを定義して
  いるが、実際には適用していない。(TEBA/EParser)

  (8) 引数に文を含むマクロ呼び出しや、末尾にセミコロンがないが文や
  宣言と同様に扱うマクロ文など、解析が正しく行えない事例に対して、
  解析結果を補正を行う。この時点では、式の解析が行われているので、
  正しく解析されていればありえない字句の並びから誤った箇所を同定し、
  補正を行う。また、宣言の識別はこの最終段階で行う。これは、補正で
  新たに文が追加されることと、宣言の識別に依存するルールは存在しない
  からである。

□ CoarseGrainedParser.pm

  文レベルまでの構造を解析する。その処理は大きく3つの段階で構成している。

    (1) 文の区切り位置の同定(制御文の入れ子は除く)  
    (2) 制御文の入れ子の解析の準備
    (3) 制御文の入れ子の解析

  (1) の段階で、セミコロンの直後など、文の区切りとなると想定される箇所に
  B_ST または E_ST を入れていく。なお、宣言はすべて文として扱う。宣言の
  初期化式の中など、文脈を調べないと区別がつかない箇所は、まず、文の区切り
  として扱い、そのあと、文が出現しない特定の文脈を特定してから区切りを取り
  除く。また、この段階では、制御文は識別せず、式文やジャンプ文など、制御文
  以外の文を識別する。B_ST と E_ST は組にならないといけないが、片方ずつ
  入れているので、マクロの定義の中などでは、数が合わない可能性があり、
  それも補正している。 (TEBA/parser-stage1.rules)

  (2) 制御文の入れ子の解析の準備として、条件式を含む頭の部分を識別し、これを
  次の段階の出発点とする。また、関数の識別を行い、書換えの適用範囲が
  関数をまたがる危険性を解消している。(TEBA/parser-stage2.rules)

  (3) 条件式の部分から右側の文を取り込むように範囲を広げ、それを文として
  識別する。入れ子になっているので、再帰的に適用する。なお、構文上、ラベルは
  文の外側に存在するものだが、一旦、中に移動させてから制御構造の入れ子を
  識別している。これは、制御文の本文が複合文ではなく、かつ、ラベルが付与
  されている場合に正しく解析できないためである。(補足:グループを使えば
  このような手間を避けられる可能性が、複雑なルールは大量のバックトラックを
  引き起すことがあるので注意が必要である。) (TEBA/parser-condstmt.rules)

□ EParser.pm

  EParser.pm は式レベルの解析をするにあたり、以下の書換えルールを適用して
  いく。ファイル名の p の後ろの数字は、演算子の優先度のレベルを表しており、
  優先度の高いものから徐々に解析していく。

    TEBA/expr-base.rules
    TEBA/expr-p01.rules
    TEBA/expr-p02.rules
    TEBA/expr-p03-12.rules
    TEBA/expr-p13.rules
    TEBA/expr-p14.rules
    TEBA/expr-p15.rules

  expr-base.rules は、解析の準備であり、変数などの終端要素や括弧で囲われた
  式など、解析の出発点となる要素を識別する。また、単項演算子と二項演算子を
  区別するために、単項演算子が出現する文脈に基づき、単項演算子の型名を
  OP_U に変更している。優先度 03 から 12 の演算子はルールの構成が同じであり、
  可読性の観点で1つのファイルにまとめている。それ以外は、ルールに特徴があり、
  別のファイルにまとめている。例えば、優先度 02 と 13 は、再帰的に繰り返す
  必要がある。なお、すでに述べた通り、現在の実装では、カンマ演算子の解析を
  実装している expr-p15.rules は適用していない。

  演算子は、同じ優先度の演算子に関して、左結合と右結合があり、その結合の
  方向に従って式を識別していく必要がある。そこで、各ルールでは、一時的な
  仮想字句を使って、正しく結合するように処理している。この一時的な仮想字句の
  型の名前には演算子の優先度を入れており、正しく処理されなかったときに、
  どの規則で問題が起きたか把握できるようになっている。また、右結合の演算子に
  ついて書換えルールを定義する場合、 演算子の左側に任意の式が存在するので、
  一つのルールの中に選択を含む箇所が増え、大量のバックトラックが発生しやすい。
  よって、選択を減らすようルールを分解して記述している。

□ rewrite.pl, ProgTrans.pm

  rewrite.pl は ProgTrans.pm の機能を利用してプログラムの書換えを実現する。
  基本的な処理の流れは以下の通りである。

    (1) プログラムパターンの %before と %after をそれぞれ構文解析する
    (2) 各結果に対して、パターン変数や空白類の正規化等の補正を行う。
    (3) 各結果から、字句系列のパターンの前と後を生成し、書換えルールを
        構成する。
    (4) RewriteTokens を用いて、入力に対して書換えを適用する。

  プログラムパターンは、プログラム本来の記述とほぼ同じであるが、パターン
  変数などの拡張があり、そのままの CParser.pm では解析できない。しかし、
  CParser.pm には、字句の定義の追加や、処理の途中にフィルタを加える方法が
  用意されており、それを用いて拡張している。なお、フィルタをどこに追加すれば
  よいかは、CParser.pm の各段階を正しく理解していないと判断できない。

  %before と %after の各パターンを構文解析によって字句系列に変換したあと、
  それぞれ字句系列のパターンに変換するが、パターン変数や空白などに関しての
  特別な処理が必要である。例えば、文に適合する STMT 型の変数 ${stmt:STMT} を
  使用した場合、構文解析の段階では文として解析する方法がなく、識別子として
  解析を行う。その場合、パターン変数の前後は式を表す B_P と E_P に囲まれ、
  文に適合しなくなる。よって、このような型に合わせて不要な仮想字句を削除する
  ことが必要である。

  空白についても特別な処理を行う。すなわち、%before に記述された空白類と、
  実際に適合させたいプログラムの断片の空白類が一致するという保証はなく、
  空白類が入りうる箇所すべてに任意の空白が存在することを前提とする必要がある。
  一方、文や式など仮想字句で囲われる非終端記号については、その開始と
  終了は空白ではないので、そこに空白が入ることを前提にすべきではない。
  よって、すべての字句間にスペースを入れたあと、仮想字句の直後または直前の
  空白を削除し、あらゆる空白の連続を1つの空白に置き換えるという正規化を
  行い、その空白を任意の空白類に適合する変数に置き換えるという処理をしている。

  さらに、-s オプションを用いた場合には、%before で適合した空白類が
  %after に保存されるよう、%after 側の字句系列の間に空白類の参照が
  含まれるように変換を行う。基本的な戦略として、%before の空白類の前後の
  テキストを持つ字句のうち、%after 側にも出現していて、かつ、最も近いものを
  特定し、すべての空白類はその字句に付随するように移るという方法を
  採用している。空白類を削除しないので、必ずしも適切な処理とはならないが、
  直感的にはほぼ位置が変わらないように見える結果を得られる。

  書換えそのものは、RewriteTokens を用いて行うが、内部識別記号が重複するなど
  字句系列としての整合性が崩れることがあるので、内部識別記号の再割り当てなど
  正規化を行う。また、パターンの構文解析は、入力となるプログラムの構文解析と
  同じ CParser.pm を、上位互換となる形で拡張しているので、パターン変数などの
  独自の記法以外については、例え、解析結果が間違っていたとしても、同じ結果に
  なり、確実に書換えが適用できる。

  記述できるパターンは、必ず構文解析ができる状態でなければならない。
  したがって、式の一部や単体の case ラベルなど、特定の文脈の中でしか
  構成できない要素をそのまま記述すると、B_ST や E_ST が意図しない位置に
  補完され、目的を果せない。その場合には、文脈を含めて記述し、目的の
  範囲を ${%begin} と ${%end} で囲うことで、指定できる。

□ id_unify.pl (IdUnify.pm)

  二つの字句系列間で、内部識別記号を統一する。この基本的な処理の流れは以下の
  通りである。

    (1) すべての識別記号を無視して、LCS により、字句の対応関係を求める。
    (2) 対応する字句の組を取り出し、それらの字句および同じ識別記号を持つ
        字句には、統一した字句番号を与える。
    (3) 統一した字句番号以外は無視して、再び LCS によって対応関係を求め、
        組がなくなるまで (2) に戻って統一を行う。

  Algorithm::Diff の実行性能に大きく依存しており、大規模なファイルでは時間が
  かかる。また、実際には、上記の流れより複雑な処理をしている。例えば、比較
  する字句系列は、先頭の方は一致しやすいという性質があるので、LCS を求める
  前に、一致する先頭の部分について、対応する内部識別記号を求め、それらは
  確定したものとして、残りの部分だけについて、LCS を求めている。

□ preg.pl

  プログラムのパターンに適合する部分を探すツールである。検索は、rewrite.pl
  と同様に字句系列に対するパターンに変換して適用する。よって、パターンに
  変換する部分は ProgTrans.pm の %before に関する処理を利用している。
 
  検索した箇所を出力するために、まず、与えられたパターンに適合した箇所の
  前後に仮想字句を入れ、その仮想字句を用いてオプションに合わせた出力を
  している。仮想字句は、適合開始箇所に _RB と _MB を、終了箇所に _ME と
  _RE を用いている。2つ用いている理由は、適合した範囲と出力する範囲が
  異なる場合に対処するためである。 _RB と _RE は出力する範囲を、_MB と
  _ME は適合した範囲を表し、-s オプションで出力範囲を拡大するときは
  _RB と _RE の位置を変更している。

  適合した範囲を仮想字句で表現しているので、-t オプションを使って
  出力すれば、そのあと、適合箇所を別のツールで処理することも可能である。

■ 字句の種別(一覧)

  仮想字句 (virtual tokens)
    UNIT_BEGIN UNIT_END : 解析結果の開始と終了

    B_DIRE E_DIRE : 前処理指令の開始と終了
    B_MCB E_MCB : マクロ定義の本体の開始と終了

    B_FUNC E_FUNC : 関数定義の開始と終了
    B_DE E_DE : 宣言の開始と終了
    B_ST E_ST : 文の開始と終了
    B_TD E_TD : typedef の開始と終了

    B_SCT E_SCT : 構造体型の開始と終了
    B_EN E_EN : 列挙体の開始と終了
    B_UN E_UN : 共用体の開始と終了
    B_CP E_CP : 構造体、共有体や配列の初期化リスト、複合値の開始と終了

    B_FD E_FD : 関数の宣言子の開始と終了
    B_FR E_FR : 関数の参照の開始と終了
    B_CAST E_CAST : キャスト演算子の開始と終了
    B_P E_P : 式の開始と終了
    B_LB E_LB : ラベルの開始と終了

  前処理指令 (preprocessor directives)
    PRE_TOP : '#' (前処理指令の開始を示す#記号)
    PRE_S : '#' (識別子を文字列リテラルに変換する#演算子)
    PRE_JOIN : '##' (識別子を結合させる##演算子)
    PRE_DIR : ディレクティブ (指令)
    PRE_H : インクルードファイル名 '<hoge.h>'

  識別子 (indentifier)
    ID_LB : ラベル名
    ID_MB : メンバー名
    ID_MC : マクロ名
    ID_TAG : タグ名
    ID_TP : 型名
    ID_TPCS : 記憶クラス指定子 ( 'static', 'extern', 'register', 'auto' )
    ID_TPFS : 関数指定子 ( 'inline' )
    ID_TPQ : 型修飾子 ( 'volatile', 'const', 'restrict' )
    ID_TPSP : 型指定子 ( 'signed', 'unsigned' )
    ID_VF : 変数名または関数名

  アトリビュート (attribute)
    ATTR : アトリビュート ('__hoge__')

  メッセージ
    ID_MSG : #errorと#pragma の引数に書かれる文、または、強制的に
             コンパイルエラーを引き起すために書かれている文字列

  区切りの要素
    CA : カンマ
    C_L C_R : 中括弧の左右 ( '{' , '}' )
    P_L P_R : 丸括弧の右と左 ( '(', ')' )
    A_L  A_R  : 配列の左括弧, 右括弧 ( '[', ']' )
    SC : セミコロン ';'

  制御文の予約語 (control tokens)
    CT_EL : 'else'
    CT_DO : 'do'
    CT_BE : 'for', 'while', 'switch' ('B'はブロック、'E'は式が後ろに続くの意味)
    CT_IF : 'if'

  予約語 (reserved tokens)
    RE_JP : ジャンブ命令 ( 'return', 'continue', 'break' )
    RE_JPG : goto 命令 ('goto')
    RE_LC : ラベル ( 'case' )
    RE_LD : ラベル ( 'default' )
    RE_TD : 型定義 ( 'typedef' )
    RE_SUE : 構造体等 ( 'struct', 'union', 'enum' )

  定数値 (literal)
    LIC : 文字定数
    LIN : 定数値
    LIS : 定数文字列

  演算子 (operator)
    OP : 2項演算子
    OP_T : 3項演算子
    OP_U : 単項演算子

  空白 (spaces)
    SP_B : 1個以上の空白文字 ' '
    SP_C : コメント ( '/* .... */', '// ....\n' )
    SP_NC : マクロの中の継続行を表す改行 '\\n'
    SP_NL : 改行 '\n'

  一時的な仮想字句 (書換えの途中で一時的に使用)
    _B_PCOND, _E_PCOND : 前処理の条件分岐指令の条件部分を指定
                   (挿入: prep.rules, 削除: prep.rules)
    _B_CT, _E_CT : 制御文(if文以外)の条件部を指定
                   (挿入: parser-stage2.rules, 削除: parser-cndstmt.rules)
    _B_IF, _E_IF : if文の頭部を指定
                   (挿入: parser-stage2.rules, 削除: parser-cndstmt.rules)
    _B_ARG, _E_ARG : 関数参照の引数部分を指定し、cast 演算子と区別する
                     (挿入・削除: namespace.rules)
    _B_X, _E_X : 解析が終了した式の最外の範囲を指定
                     (挿入・削除: expr-*.rules)
    _B_OP01, _E_OP01 : 演算子とその右側の式を指定 
                     (挿入・削除: expr-p01.rules)
    _B_A, _E_A : 関数呼び出しの引数部分
                     (挿入・削除: expr-p01.rules)
    _B_OP03, _E_OP03, ..., _B_OP12, _E_OP12 : 演算子とその右側の式を指定 
                     (挿入・削除: expr-p03-12.rules)
    _B_OP13, _E_OP13 : 3項演算子の内側の式, 内側と右側の式を指定
                     (挿入・削除: expr-p13.rules)
    _B_OP14, _E_OP14 : 代入演算子とその左側の式を指定
                     (挿入・削除: expr-p14.rules)
    _X, _Y : マクロ呼び出しの引数に文が含まれているときに、その文の開始位置と
             終了位置をそれぞれ指定
                     (挿入・削除: parser-adjust.rules)

    SC (空文字) : 文末を指定
                     (挿入: macro-stmt.rules, 削除: namespace.rules)

■ sample の使い方

  TEBA のパッケージのディレクトリ sample にはプログラムの書換えパターンの
  例となるファイルが含まれている。拡張子が .pt のファイルがパターンの記述例
  であり、同じ名前で拡張子が .c のファイルが入力の例、拡張子が .x0 のファイル
  が書換え後の例である。

  このディレクトリはテストもかねており、実際に書換えを実行させ、その出力が
  正しいかどうかを確認する仕組みがある。テスト実行は以下のように行なう。

    (1) 実行パスに teba/bin を加えておく。 (すでに設定していれば不要)
    (2) make を実行

  途中でエラーが起こる場合は、実行パスが正しいか確認をし、以下のコマンドを
  実行する。

      make clean
      make

  エラーが解消されない場合は、エラーの内容がわかる情報を作者に連絡すること。

    . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 

  実行されるプログラムの書換えパターンとテストの目的は以下の通りである。

    add-debug.pt
      ・デバッグ処理を挿入する書換えパターン
      ・前処理指令の挿入が可能なことの確認

    extract-decl.pt
      ・1つの宣言には1つの宣言子のみを書くスタイルに変更する書換えパターン
      ・グループおよびその繰り返し $[: ... $]* が使えることの確認
      ・再帰的(recursive)に書換えられることの確認

    for-while.pt
      ・for 文を等価な while 文に置き換える書換えパターン
      ・制御構造の入れ子の関係を正しく処理できることの確認

    ifdef-curly-refact.pt
      ・前処理の条件分岐内の中括弧の組み合わせが閉じるようにする書換えパターン
      ・前処理の条件分岐に中括弧が片方のみ存在する状態を取り扱えることの確認

    iff.pt
      ・二重のif文を合成する書換えパターン
      ・コメントをできるだけ適切な位置に保存できるかことの確認

    if-exit.pt
      ・else 側で処理を止める例外処理に対し、そのことがより明確なスタイルに
        変更する書換えパターン
      ・$| による選択を適切に処理できることの確認

    init-decl.pt
      ・初期化式を含む宣言を、純粋な宣言と初期化の代入文に分ける書換えパターン
      ・ ${{Name:Type}} を正しく処理できるかの確認

    swap-decl.pt
      ・文の途中に出現する宣言をブロックの先頭に移動させる書換えパターン
      ・複数の書換えパターンの組み合わせが可能であることの確認
        (init-decl.pt との組み合わせをテストする)


■ 独自のツールを作る場合についての考え方 (学生向け)

  (1) TEBA と自分の成果物は分けておきましょう。

  TEBA でツールを作るときに、TEBA の bin の下に作ってはいけません。面倒でも、
  別のディレクトリで作成し、TEBA の成果物と自分の成果物を区別しましょう。
  また、TEBA のファイルを無闇に変更することも避けましょう。TEBA が
  バージョンアップしても置き換えることができなくなります。

  (2) シェルを活用しましょう。

  シェルとの相性を考え、単機能のツールの組み合わせで作るよう心掛けましょう。
  そのためには、シェルの基本的な使い方やそのこころを理解することが必要です。
  最初のうちは苦労するかもしれませんが、パイプで接続したり、シェルスクリプトを
  記述することで、実装や保守が簡単になり、あとから得られるメリットは大きい
  です。なお、いちいち組み合わせるのは面倒と思うかもしれません。その場合には、
  それ全体をまとめるシェルスクリプトやエイリアス(シェルの関数)を書いてもよい
  でしょう。長い歴史を持つシェルには作業を簡単にさせる様々な仕組みがあるので、
  それを学び、活用することが大切です。

  (3) Perl とシェルをうまく使い分けましょう。

  少し複雑に機能を組み合わせなければならないときは、無理にシェルを活用せず、
  Perl で記述しましょう。TEBA の構文解析器はモジュール化されています。また、
  解析の途中に処理を追加することも可能です。プログラムパターンの変換系の
  実装である rewrite.pl は、パターンの構文解析にはTEBAのモジュールを使って
  います。その際には、字句の定義を追加したり、新しい解析の処理を加えています。
  どこまでを Perl で書いて、どこからはシェルを利用するかは設計の美しさに
  対するセンスが必要です。センスを磨くには、実現方法のメリットとデメリットを
  常に検討して、自分にとって最適な方法を選択していってください。ときには、
  大きな方針転換をすることも厭わないようにしましょう。センスはそういった
  経験でしか磨かれません。

  (4) より抽象度の高い表現を活用しましょう。

  やりたいことが書換えルールで書けないかも考えてください。字句系列を直接
  処理する Perl の記述は複雑になりがちです。しかし、書換えルールという
  抽象化された記述を用いると、簡単になることがあります。TEBA は、可能な
  限り書換えルールで構成するというポリシーで作っています。特に、構文解析器
  の大半を書換えルールで記述したことで、全体として簡素化され、保守がしやすく
  なりました。
  
  (5) TEBA の中身を理解しましょう。

  ぜひTEBAの解析器を読んでください。細かいところはわからなくてもよいので、
  おおまかな処理の流れをつかんでください。そのあと、自分のツールを作るうえで
  参考になる部分を中心に読んでみましょう。


作成者: 吉田敦
