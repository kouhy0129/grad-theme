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
