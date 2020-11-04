# TEBAインストール手順

1. tebaのダウンロード
[http://tebasaki.jp/src/](http://tebasaki.jp/src/)より, teba.tar.gzをダウンロード

2. JSON.pm のインストール
```
$ sudo perl -MCPAN -e 'install JSON'
```

3. PATHの設定
```
$ echo 'PATH=${PATH}:~/teba-1.10/bin' >> ~/.bashrc
```