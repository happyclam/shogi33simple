crypto = require('crypto');
Const = require('./const')
Piece = require('./piece')
Board = require('./board')
Player = require('./player')

Array::unique = ->
  output = {}
  output[@[key]] = @[key] for key in [0...@length]
  value for key, value of output

startTime = new Date().getTime()
first = new Player(Const.FIRST, false)
second = new Player(Const.SECOND, false)
b = new Board()
# b.set_standard()
state = []
counter = 0
sennitite = []
duplication = []

# 後手７手読み（５手詰め）
b.pieces = []
b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,3]))
b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,1]))
b.pieces.push(new Piece.Hi(Const.FIRST, Const.Status.MOTIGOMA))
b.pieces.push(new Piece.Ki(Const.SECOND, Const.Status.MOTIGOMA))
b.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.OMOTE, [2,2]))

b.display()
first.depth = 7
second.depth = 7
ret = []
loop
    if first.human
        human_move = false
        until human_move
            process.stdout.write("指し手（駒,筋,段,成／不成,）を入力後、Ctrl+D\n")
            process.stdout.write("入力例(Gi,2,1,1,):")
            input = require('fs').readFileSync('/dev/stdin', 'utf8')

            koma = input.split(',')[0]
            col = input.split(',')[1]
            row = input.split(',')[2]
            nari = input.split(',')[3]
            ret = []
            ret[0] = (v for v in b.pieces when v.kind() == koma && v.turn == first.turn)[0]
            continue unless ret[0]
            ret[1] = [parseInt(col, 10), parseInt(row, 10)]
            ret[2] = 0
            ret[3] = if parseInt(nari, 10) >= 1 then 1 else 0
            # if b.check_move(ret[0], ret[1]) && (b.check_utifudume(ret[0], ret[1]) == false)
            if b.check_move(ret[0], ret[1])
                # console.log(ret)
                # console.log("--- ---------------")
                s_posi = b.move_capture(ret[0], ret[1])
                ret[0].status = ret[3]
                human_move = true
                md5hash = crypto.createHash('md5').update(JSON.stringify(b.pieces)).digest("hex")
    else
        temp = []; ret = []
        # 対人戦の場合は相手玉を取るまで指す
        # unless ret[0]
        for i in [1,2,4,first.depth].unique()
            temp = []
            temp = first.think(b, second, i, Const.MAX_VALUE)
            # console.log("first: i = #{i}: temp = #{JSON.stringify(temp)}")
            if temp[0]?
                ret = [].concat(temp)
                break if (temp[2] >= Const.MAX_VALUE || temp[2] <= Const.MIN_VALUE)
            else
                break
        if ret[0]
            if b.check_move(ret[0], ret[1])
                s_posi = b.move_capture(ret[0], ret[1])
                ret[0].status = ret[3]
            md5hash = crypto.createHash('md5').update(JSON.stringify(b.pieces)).digest("hex")
        else
            console.log("Second Win")
            break
    counter += 1
    state.push({"turn": ret[0].turn, "s_posi": s_posi, "move": [].concat(ret)})
    duplication.push(crypto.createHash('md5').update(JSON.stringify(b.pieces)).digest("hex"))
    b.display()
    sennitite = (v for v in duplication when v == md5hash)
    if sennitite.length >= 4
        console.log("--- 千日手 ---")
        break

    if second.human
        human_move = false
        until human_move
            process.stdout.write("指し手（駒,筋,段,成／不成,）を入力後、Ctrl+D\n")
            process.stdout.write("入力例(Gi,2,1,1,):")
            input = require('fs').readFileSync('/dev/stdin', 'utf8')

            koma = input.split(',')[0]
            col = input.split(',')[1]
            row = input.split(',')[2]
            nari = input.split(',')[3]
            ret = []
            ret[0] = (v for v in b.pieces when v.kind() == koma && v.turn == second.turn)[0]
            continue unless ret[0]
            ret[1] = [parseInt(col, 10), parseInt(row, 10)]
            ret[2] = 0
            ret[3] = if parseInt(nari, 10) >= 1 then 1 else 0
            # if b.check_move(ret[0], ret[1]) && b.check_utifudume(ret[0], ret[1]) == false
            if b.check_move(ret[0], ret[1])
                s_posi = b.move_capture(ret[0], ret[1])
                ret[0].status = ret[3]
                human_move = true
                md5hash = crypto.createHash('md5').update(JSON.stringify(b.pieces)).digest("hex")
    else
        temp = []; ret = []
        # 対人戦の場合は相手玉を取るまで指す
        # unless ret[0]
        for i in [1,2,4,second.depth].unique()
            temp = []
            temp = second.think(b, first, i, Const.MIN_VALUE)
            # console.log("second: i = #{i}: temp = #{JSON.stringify(temp)}")
            if temp[0]?
                ret = [].concat(temp)
                break if temp[0]? && (temp[2] >= Const.MAX_VALUE || temp[2] <= Const.MIN_VALUE)
            else
                break
        if ret[0]
            if b.check_move(ret[0], ret[1])
                s_posi = b.move_capture(ret[0], ret[1])
                ret[0].status = ret[3]
            md5hash = crypto.createHash('md5').update(JSON.stringify(b.pieces)).digest("hex")
        else
            console.log("First Win")
            break
    counter += 1
    state.push({"turn": ret[0].turn, "s_posi": s_posi, "move": [].concat(ret)})
    duplication.push(crypto.createHash('md5').update(JSON.stringify(b.pieces)).digest("hex"))
    b.display()
    sennitite = (v for v in duplication when v == md5hash)
    if sennitite.length >= 4
        console.log("--- 千日手 ---")
        break

console.log(counter)
console.log(JSON.stringify(b.pieces))
md5hash = crypto.createHash('md5').update(JSON.stringify(b.pieces)).digest("hex")
console.log(md5hash)
console.log(duplication)
elapsed = new Date().getTime() - startTime
console.log "経過時間: #{elapsed}ミリ秒"
