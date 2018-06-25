# shogi33simple

[３三将棋アプリ](https://play.google.com/store/apps/details?id=shogi33.io.github.happyclam)の「長考」「瞑想」モードを省いた簡易版です。  
[スマホアプリ](https://happyclam.github.io/project/2018-01-01/33shogiapp)では４手読みで候補手を上位５手までに絞って、さらにその５手を評価値でソート後９手読みを行うという反復深化の方法で先読みを行いますが、ブラウザで実行するには重たすぎるので、その部分を省略しています。  

* [３三将棋 for Android](https://play.google.com/store/apps/details?id=shogi33.io.github.happyclam)
* [３三将棋 for PC](https://happyclam.github.io/shogi33lite/)  
※ブラウザの設定や広告許可の有無によって実行できない環境もあるようです。

# ブラウザ用JavaScript生成（transpile）
```
npm install webpack -g
yarn add -D coffeescript
yarn add -D coffee-loader
yarn add -D babel-core babel-loader babel-preset-es2015
webpack
```

# CUI版実行方法
```
coffee game.coffee
```

# テストスクリプト
```
mocha test/
```

※簡易版に実装していないメソッドではエラーになります。

