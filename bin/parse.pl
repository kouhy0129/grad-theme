#!/usr/bin/env perl

# TEBA拡張用実行ファイル
# 用途: 言語の判定を行い、共通モデルを返す
# 処理: 1. CParserを利用し、構文解析を行う.
#      2. 1の結果に各言語のrulesを適用し、共通モデルを作成する.
#      3. 2の結果を出力する. 

use strict;
use warnings;

use FindBin qw($Bin);
# 第一引数を絶対パスで各自修正
# use lib (<TEBA_path>,"$Bin/../Extension");
use lib ("/home/nanzan/teba-1.11/TEBA","$Bin/../Extension");

use CParser;
use Parser;

use Carp qw( confess);

use Getopt::Std;
my %opts = ();

$| = 1;

my $tk = join('', <>);

# python
my $python = CParser->new();
&CParser::insert_token_def($python, &Parser::read_file("python.def"));
print Parser->new('python')->set_teba($python->parse($tk))->parse();

# ruby
my $ruby = CParser->new();
&CParser::insert_token_def($ruby, &Parser::read_file("ruby.def"));
print Parser->new('ruby')->set_teba($ruby->parse($tk))->parse();

# php
my $php = CParser->new();
&CParser::insert_token_def($php, &Parser::read_file("php.def"));
print Parser->new('php')->set_teba($php->parse($tk))->parse();

# javascript
my $javascript = CParser->new();
&CParser::insert_token_def($javascript, &Parser::read_file("javascript.def"));
print Parser->new('javascript')->set_teba($javascript->parse($tk))->parse();

# c
my $cp = CParser->new();
print Parser->new('c')->set_teba($cp->parse($tk))->parse();
