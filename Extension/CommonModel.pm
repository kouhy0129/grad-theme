package CommonModel;

use strict;
use warnings;

use Data::Dumper;

my $LIB;

use RewriteTokens;
use Diff 'diff';


# パッケージを有効化するため
BEGIN {
    ($LIB = $INC{__PACKAGE__ . ".pm"}) =~ s/[^\/]+$//;
    unshift(@INC, "$LIB/..");
}

sub new() {
  # このパッケージにオブジェクト $self を連携させる
  my $self = bless {};
  return $self;
}

sub set_teba() {
    # パッケージ名を$selfに記録
    my $self = shift;
    my $text = shift;
    # 引数がリファレンスならリファレンスが参照する型を返す
    if (ref($text) eq "ARRAY") {
      # 属性を設定
      $self->{coderef} = $text;
    } else { # should be ARRAY
      $self->{coderef} = [ split("\n", $text) ];
    }
    return $self;
}

sub rewrite() {
  my $self = shift;
  my @res;
  my $code = join("", @{$self->{coderef}});

  # 共通モデルからの書き換え
  $code = RewriteTokens->new()->set_rules(&load_rules('change-ruby'))
    ->rewrite($code);
  # $code = RewriteTokens->new()->set_rules(&load_rules('change-python'))
  # ->rewrite($code);

  return $code;
}

sub load_rules() {
    my $f = shift;
    my $fname = "$LIB/${f}.rules";
    my $common_def = "$LIB/common.rules";

    open(my $co, '<', $common_def) || die "can't open $common_def";
    my $def = join('', <$co>);
    close($co);
    open(my $fp, '<', $fname) || die "can't open $fname";
    my $rules = join('', <$fp>);
    close($fp);
    return $def.$rules;
}

# use がエラーにならないように 0 以外の値を記述しておく
1;         
