# ３三将棋simple

[３三将棋アプリ](https://play.google.com/store/apps/details?id=shogi33.io.github.happyclam)の「長考」「瞑想」モードを省いた簡易版です。  
[スマホアプリ](https://happyclam.github.io/project/2018-01-01/33shogiapp)では４手読みで候補手を上位５手までに絞って、さらにその５手を評価値でソート後９手読みを行うという反復深化の方法で先読みを行いますが、ブラウザで実行するには重たすぎるので、その部分を省略しています。  

* [３三将棋 for Android](https://play.google.com/store/apps/details?id=shogi33.io.github.happyclam)
* [３三将棋 for PC](https://happyclam.github.io/shogi33simple/)  
※駒が表示されない場合は、設定メニューから「ＡＩレベル」が選択されているか確認してください。

# JavaScript生成（transpile）環境
```
npm install webpack -g
yarn add -D coffeescript
yarn add -D coffee-loader
yarn add -D babel-core babel-loader babel-preset-es2015
```

※package.json参照

# JavaScript生成（transpile）
```
webpack
```

※webpack.config.coffee参照

# CUI版実行
```
coffee game.coffee
```

# テストスクリプト
```
mocha test/
```

※簡易版に実装していないメソッドではエラーになります。

