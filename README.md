# ３三将棋アプリ

[３三将棋アプリ](https://happyclam.booth.pm/items/6323599)（Version1.1.8.0）のソースファイル一式です。  


### 関連記事
* [「３三将棋CUI版のC++バージョン」](https://happyclam.github.io/software/2025-08-07/OOP)
* [「CUIで９マス将棋を解く」](https://happyclam.github.io/project/2018-06-30/9masushogi_solver)

### 実行ファイル
* [３三将棋 for Android](https://happyclam.booth.pm/items/6323599)
* [３三将棋 for PC](https://happyclam.github.io/shogi33simple/)  

# 環境
```
$ node -v
v18.20.3
```

# JavaScript生成（transpile）
```
$ npm install
$ npm run dev
```

# CUI版実行
```
$ coffee --version
CoffeeScript version 2.4.1


$ coffee game.coffee 
x
 3 2 1
| | |o|1
| |f| |2
|O| | |3
H
x
 3 2 1
|H| |o|1
| |f| |2
|O| | |3

x
 3 2 1
|H| | |1
| |f|o|2
|O| | |3

x
 3 2 1
|H| | |1
|O|f|o|2
| | | |3


 3 2 1
|H| | |1
|O|f|o|2
|x| | |3


 3 2 1
|H| | |1
| |f|o|2
|O| | |3
X

 3 2 1
|H| | |1
| | |o|2
|O|t| |3
X

 3 2 1
|H| | |1
|O| |o|2
| |t| |3
X

 3 2 1
|H| | |1
|O|t|o|2
| | | |3
X
Second Win
8
経過時間: 1781ミリ秒

```

# テストスクリプト
```
$ mocha test/tumeShogi.coffee
```

※「.mocharc.jsonファイル」参照

# 全テスト実行時間計測

```
$ NODE_OPTIONS="--max-old-space-size=8192" mocha --require coffeescript/register --require test/setup.coffee "test/**/*.coffee"

~~~

Total duration: 24.58 sec

  176 passing (25s)

```

