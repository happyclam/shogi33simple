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

# 同じ駒が複数使用されていることもあるので座標も含めてソート
_sortCoordinate = (a, b) ->
    kinds = ["Ou", "Hi", "Ka", "Ki", "Gi", "Ke", "Ky", "Fu"]
    return kinds.indexOf(a["kind"]) - kinds.indexOf(b["kind"]) || a["posi0"] - b["posi0"] || a["posi1"] - b["posi1"]

# 局面を比較するためHashを生成
make_hash = (board) ->
    rec = []
    for koma in board.getPieces(Const.FIRST)
        buf = {}
        buf["kind"] = koma.name
        buf["turn"] = koma.turn
        buf["status"] = koma.status
        buf["posi0"] = board.getPiecePosition(koma)[0]
        buf["posi1"] = board.getPiecePosition(koma)[1]
        rec.push(buf)
    for koma in board.getPieces(Const.SECOND)
        buf = {}
        buf["kind"] = koma.name
        buf["turn"] = koma.turn
        buf["status"] = koma.status
        buf["posi0"] = board.getPiecePosition(koma)[0]
        buf["posi1"] = board.getPiecePosition(koma)[1]
        rec.push(buf)
    rec.sort _sortCoordinate
    return crypto.createHash('md5').update(JSON.stringify(rec)).digest("hex")

# GiFu
# b.pieces = []
# fo = new Piece.Ou(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(fo)
# fg = new Piece.Gi(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(fg)
# ff = new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(ff)
# so = new Piece.Ou(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(so)
# sg = new Piece.Gi(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(sg)
# sf = new Piece.Fu(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(sf)
# b.move_capture(fo, [3,3])
# b.move_capture(so, [1,1])

# ---
# saitanCheck(tumi2,tumi4がないとN.G.)
# KeKy
# b.pieces = []
# fo = new Piece.Ou(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(fo)
# so = new Piece.Ou(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(so)
# b.move_capture(fo, [3,3])
# b.move_capture(so, [1,1])
# b.add(new Piece.Ky(Const.FIRST, Const.Status.MOTIGOMA))
# b.add(new Piece.Ke(Const.SECOND, Const.Status.MOTIGOMA))
# ---
# sennitite?
# OuGi
# b.pieces = []
# fo = new Piece.Ou(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(fo)
# so = new Piece.Ou(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(so)
# b.move_capture(fo, [3,2])
# b.move_capture(so, [1,2])
# fg = new Piece.Gi(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(fg)
# sg = new Piece.Gi(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(sg)
# ---
# saitanOK
# b.pieces = []
# KaKe
# fo = new Piece.Ou(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(fo)
# so = new Piece.Ou(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(so)
# b.move_capture(fo, [3,3])
# b.move_capture(so, [1,1])
# fk = new Piece.Ke(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(fk)
# fk2 = new Piece.Ke(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(fk2)
# sm = new Piece.Ka(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(sm)
# ---
# sennitite?
# KiGi
# b.pieces = []
# fo = new Piece.Ou(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(fo)
# so = new Piece.Ou(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(so)
# b.move_capture(fo, [3,1])
# b.move_capture(so, [1,3])
# fg = new Piece.Gi(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(fg)
# sx = new Piece.Ki(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(sx)
# ---
# b.pieces = []
# KaFu
# fo = new Piece.Ou(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(fo)
# so = new Piece.Ou(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(so)
# b.move_capture(fo, [2,3])
# b.move_capture(so, [2,1])
# fm = new Piece.Ka(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(fm)
# b.move_capture(fm, [1,3])
# sm = new Piece.Ka(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(sm)
# b.move_capture(sm, [3,1])
# ff = new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(ff)
# sf = new Piece.Fu(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(sf)
# ---
# saitanOK
# HiFu
# b.pieces = []
# fo = new Piece.Ou(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(fo)
# so = new Piece.Ou(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(so)
# b.move_capture(fo, [3,3])
# b.move_capture(so, [1,1])
# fh = new Piece.Hi(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(fh)
# b.move_capture(fh, [2,3])
# sh = new Piece.Hi(Const.SECOND, Const.Status.MOTIGOMA)
# b.move_capture(sh, [2,1])
# b.add(sh)
# ff = new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(ff)
# b.move_capture(ff, [1,3])
# sf = new Piece.Fu(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(sf)
# b.move_capture(sf, [3,1])
# --- ituka check???
# GiFu
# b.pieces = []
# fo = new Piece.Ou(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(fo)
# so = new Piece.Ou(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(so)
# b.move_capture(fo, [3,3])
# b.move_capture(so, [1,1])
# ff = new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(ff)
# ff2 = new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(ff2)
# sg = new Piece.Gi(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(sg)
# ---
# HiKa
# b.pieces = []
# fo = new Piece.Ou(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(fo)
# so = new Piece.Ou(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(so)
# b.move_capture(fo, [3,3])
# b.move_capture(so, [1,1])
# sh = new Piece.Hi(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(sh)
# fm = new Piece.Ka(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(fm)

#-----------------------------
# check
# depth = 7 にしないと後手勝ちが読み切れない
# 経過時間: 8913ミリ秒
# 経過時間: 28996ミリ秒 (depth = 7 && check_utifudume)
# 経過時間: 31330ミリ秒 (depth = 7 && no check_utifudume)
# 経過時間: 30368ミリ秒 (depth = 7 && with check_utifudume)
# 経過時間: 24033ミリ秒 (depth = 7 && no tumi hensuu)
# HiKi
# b.pieces = []
# fo = new Piece.Ou(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(fo)
# so = new Piece.Ou(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(so)
# b.move_capture(fo, [3,3])
# b.move_capture(so, [1,1])
# sf = new Piece.Fu(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(sf)
# b.move_capture(sf, [2,2])
# fh = new Piece.Hi(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(fh)
# sx = new Piece.Ki(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(sx)

# b.pieces = []
# HiKi
# fo = new Piece.Ou(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(fo)
# so = new Piece.Ou(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(so)
# b.move_capture(fo, [3,3])
# b.move_capture(so, [1,2])
# sf = new Piece.Fu(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(sf)
# b.move_capture(sf, [2,2])
# fh = new Piece.Hi(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(fh)
# b.move_capture(fh, [3,1])
# sx = new Piece.Ki(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(sx)

# 経過時間: 47565ミリ秒 old
# 経過時間: 25912ミリ秒 new
# 経過時間: 12370ミリ秒 new2
# 経過時間: 37162ミリ秒 (depth = 7 && check_utifudume)
# 経過時間: 36556ミリ秒 (depth = 7 && no check_utifudume)
# 経過時間: 32390ミリ秒 (depth = 7 && with check_utifudume)
# 経過時間: 33378ミリ秒 (depth = 7 && no tumi hensuu)
# KaKe
# b.pieces = []
# fo = new Piece.Ou(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(fo)
# so = new Piece.Ou(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(so)
# b.move_capture(fo, [3,3])
# b.move_capture(so, [1,1])
# b.add(new Piece.Ka(Const.SECOND, Const.Status.MOTIGOMA))
# b.add(new Piece.Ke(Const.FIRST, Const.Status.MOTIGOMA))
# b.add(new Piece.Ke(Const.FIRST, Const.Status.MOTIGOMA))

# check
# 経過時間: 226342ミリ秒 old
# 経過時間: 71538ミリ秒 new
# 経過時間: 25858ミリ秒 new2
# 経過時間: 151004ミリ秒 (depth = 7 && check_utifudume)
# 経過時間: 544481ミリ秒 (depth = 7 && no check_utifudume)
# 経過時間: 467009ミリ秒 (depth = 7 && with check_utifudume)
# 経過時間: 463075ミリ秒 (depth = 7 && no tumi hensuu)
# HiKa
# b.pieces = []
# fo = new Piece.Ou(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(fo)
# so = new Piece.Ou(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(so)
# b.move_capture(fo, [3,3])
# b.move_capture(so, [1,1])
# fh = new Piece.Hi(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(fh)
# sh = new Piece.Hi(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(sh)
# fm = new Piece.Ka(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(fm)
# b.move_capture(fm, [2,3])
# sm = new Piece.Ka(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(sm)
# b.move_capture(sm, [2,1])
# ff = new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(ff)
# sf = new Piece.Fu(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(sf)

# utifudume check
# 経過時間: 176405ミリ秒 (depth = 7 && check_utifudume)
# 経過時間: 243146ミリ秒 (depth = 7 && no check_utifudume)
# 経過時間: 536976ミリ秒 (depth = 7 && with check_utifudume)
# 経過時間: 523221ミリ秒 (depth = 7 && no tumi hensuu)
# HiKa
# b.pieces = []
# fo = new Piece.Ou(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(fo)
# so = new Piece.Ou(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(so)
# b.move_capture(fo, [3,3])
# b.move_capture(so, [1,1])
# fh = new Piece.Hi(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(fh)
# b.move_capture(fh, [3,1])
# sh = new Piece.Hi(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(sh)
# fm = new Piece.Ka(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(fm)
# b.move_capture(fm, [2,3])
# sm = new Piece.Ka(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(sm)
# b.move_capture(sm, [2,1])
# ff = new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(ff)
# sf = new Piece.Fu(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(sf)
# b.move_capture(sf, [2,2])
# OuFu
# b.pieces = []
# fo = new Piece.Ou(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(fo)
# so = new Piece.Ou(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(so)
# b.move_capture(fo, [2,1])
# b.move_capture(so, [2,3])
# ff = new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(ff)
# sf = new Piece.Fu(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(sf)
# KaFu
# 149
# b.pieces = []
# fo = new Piece.Ou(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(fo)
# so = new Piece.Ou(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(so)
# b.move_capture(fo, [3,3])
# b.move_capture(so, [1,1])
# sm = new Piece.Ka(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(sm)
# ff = new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(ff)
# ff2 = new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(ff2)
# HiKa
# b.pieces = []
# fo = new Piece.Ou(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(fo)
# so = new Piece.Ou(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(so)
# b.move_capture(fo, [3,3])
# b.move_capture(so, [1,1])
# fm = new Piece.Ka(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(fm)
# sh = new Piece.Hi(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(sh)

# 経過時間: 62630ミリ秒 old
# 経過時間: 46750ミリ秒 new
# 経過時間: 17285ミリ秒 new2
# 経過時間: 74954ミリ秒 (depth = 7 && check_utifudume)
# 経過時間: 71417ミリ秒 (depth = 7 && no check_utifudume)
# 経過時間: 75041ミリ秒 (depth = 7 && with check_utifudume)
# 経過時間: 86705ミリ秒 (depth = 7 && no tumi hensuu)
# HiKa
# b.pieces = []
# fo = new Piece.Ou(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(fo)
# so = new Piece.Ou(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(so)
# b.move_capture(fo, [3,3])
# b.move_capture(so, [1,1])
# fm = new Piece.Ka(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(fm)
# sh = new Piece.Hi(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(sh)

# 経過時間: 190301ミリ秒 old
# 経過時間: 138430ミリ秒 new
# 経過時間: 40713ミリ秒 new2
# 経過時間: 134360ミリ秒 (depth = 7 && check_utifudume)
# 経過時間: 132108ミリ秒 (depth = 7 && no check_utifudume)
# 経過時間: 139211ミリ秒 (depth = 7 && with check_utifudume)
# 経過時間: 126222ミリ秒 (depth = 7 && no tumi hensuu)
# KiGi
# b.pieces = []
# fo = new Piece.Ou(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(fo)
# so = new Piece.Ou(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(so)
# b.move_capture(fo, [3,1])
# b.move_capture(so, [1,3])
# fg = new Piece.Gi(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(fg)
# fx = new Piece.Ki(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(fx)
# sg = new Piece.Gi(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(sg)
# sx = new Piece.Ki(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(sx)
# b.move_capture(sx, [2,2])

# 経過時間: 26048ミリ秒 old
# 経過時間: 24148ミリ秒 new
# 経過時間: 14691ミリ秒 new2
# 経過時間: 97286ミリ秒 (depth = 7 && check_utifudume)
# 経過時間: 117823ミリ秒 (depth = 7 && no check_utifudume)
# 経過時間: 117727ミリ秒 (depth = 7 && with check_utifudume)
# 経過時間: 153325ミリ秒 (depth = 7 && no tumi hensuu)
# KiGi
# b.pieces = []
# fo = new Piece.Ou(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(fo)
# so = new Piece.Ou(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(so)
# b.move_capture(fo, [3,1])
# b.move_capture(so, [1,3])
# fg = new Piece.Gi(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(fg)
# sx = new Piece.Ki(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(sx)
# GiFu
# b.pieces = []
# fo = new Piece.Ou(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(fo)
# so = new Piece.Ou(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(so)
# b.move_capture(fo, [1,3])
# b.move_capture(so, [3,1])
# fg = new Piece.Gi(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(fg)
# sg = new Piece.Gi(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(sg)
# sf = new Piece.Fu(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(sf)
# b.move_capture(sf, [2,2])

# 経過時間: 21984ミリ秒 old
# 経過時間: 9322ミリ秒 new
# 経過時間: 4765ミリ秒 new2
# 経過時間: 13876ミリ秒 (depth = 7 && check_utifudume)
# 経過時間: 16311ミリ秒 (depth = 7 && no check_utifudume)
# 経過時間: 14139ミリ秒 (depth = 7 && with check_utifudume)
# 経過時間: 13089ミリ秒 (depth = 7 && no tumi hensuu)
# KeFu
# b.pieces = []
# fo = new Piece.Ou(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(fo)
# so = new Piece.Ou(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(so)
# b.move_capture(fo, [2,3])
# b.move_capture(so, [2,1])
# fk = new Piece.Ke(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(fk)
# sf = new Piece.Fu(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(sf)

# 経過時間: 35368ミリ秒 old
# 経過時間: 11690ミリ秒 new
# 経過時間: 4456ミリ秒 new2
# 経過時間: 17210ミリ秒 (depth = 7 && check_utifudume)
# 経過時間: 17282ミリ秒 (depth = 7 && no check_utifudume)
# 経過時間: 22098ミリ秒 (depth = 7 && with check_utifudume)
# 経過時間: 10757ミリ秒 (depth = 7 && no tumi hensuu)
# b.pieces = []
# fo = new Piece.Ou(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(fo)
# so = new Piece.Ou(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(so)
# b.move_capture(fo, [2,1])
# b.move_capture(so, [2,3])
# fm = new Piece.Ka(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(fm)
# sx = new Piece.Ki(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(sx)

# only 7 check
# 経過時間: 87487ミリ秒 old
# 経過時間: 91233ミリ秒 new
# 経過時間: 18273ミリ秒 new2
# 経過時間: 232739ミリ秒 (depth = 7 && check_utifudume)
# 経過時間: 256918ミリ秒 (depth = 7 && no check_utifudume)
# 経過時間: 258393ミリ秒 (depth = 7 && with check_utifudume)
# 経過時間: 10757ミリ秒 (depth = 7 && no tumi hensuu)
# HiKa
# b.pieces = []
# fo = new Piece.Ou(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(fo)
# so = new Piece.Ou(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(so)
# b.move_capture(fo, [3,3])
# b.move_capture(so, [1,1])
# fm = new Piece.Ka(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(fm)
# sh = new Piece.Hi(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(sh)
# ff = new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(ff)
# sf = new Piece.Fu(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(sf)

# only 7   o39
# 経過時間: 135446ミリ秒 old
# 経過時間: 64609ミリ秒 new
# 経過時間: 26834ミリ秒 new2
# 経過時間: 331452ミリ秒 (depth = 7 && check_utifudume)
# 経過時間: 327491ミリ秒 (depth = 7 && no check_utifudume)
# 経過時間: 297375ミリ秒 (depth = 7 && with check_utifudume)
# 経過時間: 334540ミリ秒 (depth = 7 && no tumi hensuu)
# HiKa
# b.pieces = []
# fo = new Piece.Ou(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(fo)
# so = new Piece.Ou(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(so)
# b.move_capture(fo, [2,3])
# b.move_capture(so, [2,1])
# fm = new Piece.Ka(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(fm)
# sh = new Piece.Hi(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(sh)
# ff = new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(ff)
# sf = new Piece.Fu(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(sf)

# pending
# b.pieces = []
# fo = new Piece.Ou(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(fo)
# so = new Piece.Ou(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(so)
# b.move_capture(fo, [3,3])
# b.move_capture(so, [1,1])
# fh = new Piece.Hi(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(fh)
# sm = new Piece.Ka(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(sm)
# sf = new Piece.Fu(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(sf)

# sennititeで正解？ o18
# 経過時間: 75328ミリ秒 old
# 経過時間: 45509ミリ秒 new
# 経過時間: 21557ミリ秒 new2
# 経過時間: 286566ミリ秒 (depth = 7 && check_utifudume)
# 経過時間: 370429ミリ秒 (depth = 7 && no check_utifudume)
# 経過時間: 277972ミリ秒 (depth = 7 && with check_utifudume)
# 経過時間: 425833ミリ秒 (depth = 7 && no tumi hensuu)
# HiKa
# b.pieces = []
# fo = new Piece.Ou(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(fo)
# so = new Piece.Ou(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(so)
# b.move_capture(fo, [2,3])
# b.move_capture(so, [2,1])
# fh = new Piece.Hi(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(fh)
# sm = new Piece.Ka(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(sm)
# sf = new Piece.Fu(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(sf)

# 誤った打ち歩詰め判定だったケース
# 経過時間: 16561ミリ秒 old
# 経過時間: 6378ミリ秒 new
# 経過時間: 1384ミリ秒 new2
# 経過時間: 4194ミリ秒 (depth = 7 && check_utifudume)
# 経過時間: 8152ミリ秒 (depth = 7 && no check_utifudume)
# 経過時間: 3916ミリ秒 (depth = 7 && with check_utifudume)
# 経過時間: 3593ミリ秒 (depth = 7 && no tumi hensuu)
# HiKa
# b.pieces = []
# fo = new Piece.Ou(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(fo)
# so = new Piece.Ou(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(so)
# b.move_capture(fo, [2,3])
# b.move_capture(so, [2,1])
# fh = new Piece.Hi(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(fh)
# b.move_capture(fh, [3,2])
# sm = new Piece.Ka(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(sm)
# b.move_capture(sm, [1,1])
# ff = new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(ff)

# 経過時間: 49366ミリ秒 old
# 経過時間: 9785ミリ秒 new2
# 経過時間: 19306ミリ秒 (depth = 7 && check_utifudume)
# 経過時間: 48597ミリ秒 (depth = 7 && no check_utifudume)
# 経過時間: 57276ミリ秒 (depth = 7 && with check_utifudume)
# 経過時間: 15116ミリ秒 (depth = 7 && no tumi hensuu)
# KaKe
# b.pieces = []
# fo = new Piece.Ou(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(fo)
# so = new Piece.Ou(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(so)
# b.move_capture(fo, [1,3])
# b.move_capture(so, [1,1])
# fk = new Piece.Ke(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(fk)
# b.move_capture(fk, [3,3])
# sk = new Piece.Ke(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(sk)
# b.move_capture(sk, [2,1])
# fm = new Piece.Ka(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(fm)

# saitanOK
# 経過時間: 18748ミリ秒 old
# 経過時間: 41487ミリ秒 new
# 経過時間: 6156ミリ秒 new2
# 経過時間: 23526ミリ秒 (depth = 7 && check_utifudume)
# 経過時間: 40891ミリ秒 (depth = 7 && no check_utifudume)
# 経過時間: 23521ミリ秒 (depth = 7 && with check_utifudume)
# 経過時間: 20927ミリ秒 (depth = 7 && no tumi hensuu)
# KiGi
# b.pieces = []
# fo = new Piece.Ou(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(fo)
# so = new Piece.Ou(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(so)
# b.move_capture(fo, [3,3])
# b.move_capture(so, [1,1])
# fg = new Piece.Gi(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(fg)
# sx = new Piece.Ki(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(sx)

# check2
# 経過時間: 42972ミリ秒 (depth = 7 && with check_utifudume)
# 経過時間: 45851ミリ秒 (depth = 7 && no tumi hensuu)
# GiKeKy
# b.pieces = []
# fo = new Piece.Ou(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(fo)
# so = new Piece.Ou(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(so)
# b.move_capture(fo, [3,3])
# b.move_capture(so, [1,1])
# fk = new Piece.Ke(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(fk)
# fy = new Piece.Ky(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(fy)
# sg = new Piece.Gi(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(sg)

# GiKeKy
# b.pieces = []
# fo = new Piece.Ou(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(fo)
# so = new Piece.Ou(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(so)
# b.move_capture(fo, [3,3])
# b.move_capture(so, [1,1])
# fk = new Piece.Ke(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(fk)
# fy = new Piece.Ky(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(fy)
# sg = new Piece.Gi(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(sg)

# GiKeKy
# b.pieces = []
# fo = new Piece.Ou(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(fo)
# so = new Piece.Ou(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(so)
# b.move_capture(fo, [3,2])
# b.move_capture(so, [1,2])
# sk = new Piece.Ke(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(sk)
# b.move_capture(sk, [1,3])
# sk.status = Const.Status.URA
# fy = new Piece.Ky(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(fy)
# fg = new Piece.Gi(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(fg)
# b.move_capture(fg, [3,1])

# KaKyFu
# b.pieces = []
# fo = new Piece.Ou(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(fo)
# so = new Piece.Ou(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(so)
# b.move_capture(fo, [1,3])
# b.move_capture(so, [3,1])
# sy = new Piece.Ky(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(sy)
# b.move_capture(sy, [2,1])
# fm = new Piece.Ka(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(fm)
# sm = new Piece.Ka(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(sm)
# ff = new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(ff)
# ff2 = new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(ff2)

# 31
# KeKyFu
# b.pieces = []
# fo = new Piece.Ou(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(fo)
# so = new Piece.Ou(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(so)
# b.move_capture(fo, [3,3])
# b.move_capture(so, [1,1])
# ff = new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(ff)
# sk = new Piece.Ke(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(sk)
# sy = new Piece.Ky(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(sy)

# 32
# KaGiKy
# b.pieces = []
# fo = new Piece.Ou(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(fo)
# so = new Piece.Ou(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(so)
# b.move_capture(fo, [3,3])
# b.move_capture(so, [1,1])
# sy = new Piece.Ky(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(sy)
# b.move_capture(sy, [1,2])
# sk = new Piece.Ke(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(sk)
# b.move_capture(sk, [2,1])
# sm = new Piece.Ka(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(sm)
# b.move_capture(sm, [3,2])
# sg = new Piece.Gi(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(sg)
# b.move_capture(sg, [2,3])
# ff2 = new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(ff2)
# b.move_capture(ff2, [1,3])
# fh = new Piece.Hi(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(fh)
# b.move_capture(fh, [3,1])
# ff = new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(ff)
# b.move_capture(ff, [2,2])

# Hi test1 ---o33
# OuHi
# b.pieces = []
# fo = new Piece.Ou(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(fo)
# so = new Piece.Ou(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(so)
# b.move_capture(fo, [3,3])
# b.move_capture(so, [3,1])
# fh = new Piece.Hi(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(fh)
# b.move_capture(fh, [2,3])
# sh = new Piece.Hi(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(sh)
# b.move_capture(sh, [2,1])

# Hi test4 ---o34
# HiKa
# b.pieces = []
# fo = new Piece.Ou(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(fo)
# so = new Piece.Ou(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(so)
# b.move_capture(fo, [2,3])
# b.move_capture(so, [2,1])
# fm = new Piece.Ka(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(fm)
# sh = new Piece.Hi(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(sh)
# b.move_capture(sh, [3,2])

# KaKy test ---o35
# b.pieces = []
# fo = new Piece.Ou(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(fo)
# so = new Piece.Ou(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(so)
# b.move_capture(fo, [3,3])
# b.move_capture(so, [1,1])
# fy = new Piece.Ky(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(fy)
# b.move_capture(fy, [2,3])
# sm = new Piece.Ka(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(sm)
# b.move_capture(sm, [2,1])
# ff = new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(ff)
# b.move_capture(ff, [1,3])
# sf = new Piece.Fu(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(sf)
# b.move_capture(sf, [3,1])

# KaFu test check xxx -> depth=9で正解o
# 経過時間: 46592ミリ秒 (depth = 7 && check_utifudume)
# 経過時間: 82939ミリ秒 (depth = 7 && no check_utifudume)
# 経過時間: 32478ミリ秒 (depth = 7 && no tumi hensuu)
# b.pieces = []
# fo = new Piece.Ou(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(fo)
# so = new Piece.Ou(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(so)
# b.move_capture(fo, [3,3])
# b.move_capture(so, [1,1])
# fm = new Piece.Ka(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(fm)
# b.move_capture(fm, [3,1])
# sm = new Piece.Ka(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(sm)
# b.move_capture(sm, [1,3])
# ff = new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(ff)
# b.move_capture(ff, [3,2])
# sf = new Piece.Fu(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(sf)
# b.move_capture(sf, [1,2])

# KaGi test ---o37
# 経過時間: 321436ミリ秒 (depth = 7 && check_utifudume)
# 経過時間: 433804ミリ秒 (depth = 7 && no check_utifudume)
# 経過時間: 291786ミリ秒 (depth = 7 && with check_utifudume)
# 経過時間: 271554ミリ秒 (depth = 7 && no tumi hensuu)
# b.pieces = []
# fo = new Piece.Ou(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(fo)
# so = new Piece.Ou(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(so)
# b.move_capture(fo, [3,3])
# b.move_capture(so, [1,1])
# sm = new Piece.Ka(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(sm)
# sm2 = new Piece.Ka(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(sm2)
# fg = new Piece.Gi(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(fg)
# fg2 = new Piece.Gi(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(fg2)
# ff = new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(ff)
# sf = new Piece.Fu(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(sf)
# b.move_capture(sf, [2,1])

# KeFu test xxx
# b.pieces = []
# fo = new Piece.Ou(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(fo)
# so = new Piece.Ou(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(so)
# b.move_capture(fo, [3,3])
# b.move_capture(so, [1,1])
# sk = new Piece.Ke(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(sk)
# ff = new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(ff)

# HiGi test2 ---o
# 経過時間: 77330ミリ秒 (depth = 7 && check_utifudume)
# 経過時間: 139594ミリ秒 (depth = 7 && no check_utifudume)
# 経過時間: 81044ミリ秒 (depth = 7 && with check_utifudume)
# 経過時間: 75165ミリ秒 (depth = 7 && no tumi hensuu)
# b.pieces = []
# fo = new Piece.Ou(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(fo)
# so = new Piece.Ou(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(so)
# b.move_capture(fo, [2,3])
# b.move_capture(so, [2,1])
# sh = new Piece.Hi(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(sh)
# b.move_capture(sh, [3,2])
# fg = new Piece.Gi(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(fg)
# b.move_capture(fg, [1,3])
# ff = new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(ff)
# sf = new Piece.Fu(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(sf)

# KaGi test ---o36
# 経過時間: 51213ミリ秒 (depth = 7 && check_utifudume)
# 経過時間: 173464ミリ秒 (depth = 7 && no check_utifudume)
# 経過時間: 146743ミリ秒 (depth = 7 && with check_utifudume)
# 経過時間: 135717ミリ秒 (depth = 7 && no tumi hensuu)
# b.pieces = []
# fo = new Piece.Ou(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(fo)
# so = new Piece.Ou(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(so)
# b.move_capture(fo, [3,3])
# b.move_capture(so, [1,1])
# fm = new Piece.Ka(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(fm)
# sg = new Piece.Gi(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(sg)
# sg2 = new Piece.Gi(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(sg2)
# ff = new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(ff)

# KeKy test xxx
# 142
# b.pieces = []
# fo = new Piece.Ou(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(fo)
# so = new Piece.Ou(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(so)
# b.move_capture(fo, [3,3])
# b.move_capture(so, [1,1])
# fk = new Piece.Ke(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(fk)
# sg = new Piece.Gi(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(sg)
# fy = new Piece.Ky(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(fy)

# KeFu test xxx
# b.pieces = []
# fo = new Piece.Ou(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(fo)
# so = new Piece.Ou(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(so)
# b.move_capture(fo, [3,3])
# b.move_capture(so, [1,1])
# sk = new Piece.Ke(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(sk)
# ff = new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(ff)

# KaHi test ---
# b.pieces = []
# fo = new Piece.Ou(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(fo)
# so = new Piece.Ou(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(so)
# b.move_capture(fo, [3,3])
# b.move_capture(so, [1,1])
# sh = new Piece.Hi(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(sh)
# fm = new Piece.Ka(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(fm)

# KaGi tumi check ---xxx
# 143
# depth >= 8 にしないと後手勝ちが読み切れない（１二角が打てない）
# 経過時間: 4543342ミリ秒 (depth = 7 && check_utifudume)
# 経過時間: 876539ミリ秒 (depth = 7 && no check_utifudume)
# 経過時間: 109657ミリ秒 (depth = 7 && with check_utifudume)
# 経過時間: 80038ミリ秒 (depth = 7 && no tumi hensuu)
# 経過時間: 633408ミリ秒 (depth = 8 && no tumi hensuu)
# b.pieces = []
# fo = new Piece.Ou(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(fo)
# so = new Piece.Ou(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(so)
# b.move_capture(fo, [3,3])
# b.move_capture(so, [1,1])
# sm = new Piece.Ka(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(sm)
# fm = new Piece.Ka(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(fm)
# fg = new Piece.Gi(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(fg)
# b.move_capture(fg, [1,3])
# sg = new Piece.Gi(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(sg)
# b.move_capture(sg, [3,1])
# ff = new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(ff)
# sf = new Piece.Fu(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(sf)
# b.move_capture(sf, [2,2])

# KaHi test ---o38
# 経過時間: ミリ秒 (depth = 7 && check_utifudume)
# 経過時間: ミリ秒 (depth = 7 && no check_utifudume)
# 経過時間: 132107ミリ秒 (depth = 7 && no tumi hensuu)
# b.pieces = []
# fo = new Piece.Ou(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(fo)
# so = new Piece.Ou(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(so)
# b.move_capture(fo, [3,3])
# b.move_capture(so, [1,1])
# fm = new Piece.Ka(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(fm)
# sh = new Piece.Hi(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(sh)
# ff = new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(ff)
# b.move_capture(ff, [2,3])
# sf = new Piece.Fu(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(sf)
# b.move_capture(sf, [2,1])

# KaFu test ---xxx41 depth=9で正解
# b.pieces = []
# fo = new Piece.Ou(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(fo)
# so = new Piece.Ou(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(so)
# b.move_capture(fo, [3,3])
# b.move_capture(so, [1,1])
# fm = new Piece.Ka(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(fm)
# b.move_capture(fm, [3,1])
# sm = new Piece.Ka(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(sm)
# b.move_capture(sm, [1,3])
# ff = new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(ff)
# b.move_capture(ff, [3,2])
# sf = new Piece.Fu(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(sf)
# b.move_capture(sf, [1,2])

# HiGi test ---o40
# b.pieces = []
# fo = new Piece.Ou(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(fo)
# so = new Piece.Ou(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(so)
# b.move_capture(fo, [2,3])
# b.move_capture(so, [2,1])
# fg = new Piece.Gi(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(fg)
# b.move_capture(fg, [1,3])
# sh = new Piece.Hi(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(sh)
# b.move_capture(sh, [3,2])
# ff = new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(ff)
# sf = new Piece.Fu(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(sf)

# b.pieces = []
# fo = new Piece.Ou(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(fo)
# so = new Piece.Ou(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(so)
# b.move_capture(fo, [1,1])
# b.move_capture(so, [2,3])
# sx = new Piece.Ki(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(sx)
# b.move_capture(sx, [3,1])
# sx2 = new Piece.Ki(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(sx2)
# b.move_capture(sx2, [3,2])
# fg = new Piece.Gi(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(fg)
# fg.status = Const.Status.URA
# b.move_capture(fg, [2,1])
# fg2 = new Piece.Gi(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(fg2)
# fg2.status = Const.Status.URA
# b.move_capture(fg2, [1,2])
# ff = new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(ff)
# b.move_capture(ff, [1,3])
# sf = new Piece.Fu(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(sf)
# b.move_capture(sf, [2,2])

# b.pieces = []
# fo = new Piece.Ou(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(fo)
# so = new Piece.Ou(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(so)
# b.move_capture(fo, [1,1])
# b.move_capture(so, [1,3])
# fg = new Piece.Gi(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(fg)
# b.move_capture(fg, [2,3])
# sg = new Piece.Gi(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(sg)
# b.move_capture(sg, [3,1])
# sf2 = new Piece.Fu(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(sf2)
# b.move_capture(sf2, [1,2])
# sf = new Piece.Fu(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(sf)
# b.move_capture(sf, [2,1])

# tumeshogi
# depth >= 8にしないと３二角が打てない
# @pre_select = 5 にしないと候補手選択で漏れる？
# first.pre_select = 5
# 144
# b.pieces = []
# fo = new Piece.Ou(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(fo)
# so = new Piece.Ou(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(so)
# b.move_capture(fo, [3,3])
# b.move_capture(so, [1,1])
# sm = new Piece.Ka(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(sm)
# fm = new Piece.Ka(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(fm)
# fg = new Piece.Gi(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(fg)
# b.move_capture(fg, [1,3])
# sg = new Piece.Gi(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(sg)
# b.move_capture(sg, [3,1])
# ff = new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(ff)
# b.move_capture(ff, [2,2])
# sf = new Piece.Fu(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(sf)
# b.move_capture(sf, [1,2])

# tumeshogi
# b.pieces = []
# fo = new Piece.Ou(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(fo)
# so = new Piece.Ou(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(so)
# b.move_capture(fo, [2,1])
# b.move_capture(so, [1,3])
# fg1 = new Piece.Gi(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(fg1)
# b.move_capture(fg1, [1,1])
# fg2 = new Piece.Gi(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(fg2)
# b.move_capture(fg2, [3,3])
# sg1 = new Piece.Gi(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(sg1)
# sg1.status = Const.Status.URA
# b.move_capture(sg1, [2,3])
# sg2 = new Piece.Gi(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(sg2)
# sg2.status = Const.Status.URA
# b.move_capture(sg2, [3,2])
# ff = new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(ff)
# ff.status = Const.Status.URA
# b.move_capture(ff, [3,1])
# sf = new Piece.Fu(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(sf)
# sf.status = Const.Status.URA
# b.move_capture(sf, [2,2])

# tumeshogi2
# OuFu ---o85
# b.pieces = []
# fo = new Piece.Ou(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(fo)
# so = new Piece.Ou(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(so)
# b.move_capture(fo, [1,3])
# b.move_capture(so, [2,1])
# ff = new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(ff)
# b.move_capture(ff, [1,2])
# sf = new Piece.Fu(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(sf)
# sf.status = Const.Status.URA
# b.move_capture(sf, [1,1])

# sennitite???
# OuFu ---x88
# b.pieces = []
# fo = new Piece.Ou(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(fo)
# so = new Piece.Ou(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(so)
# b.move_capture(fo, [3,1])
# b.move_capture(so, [1,1])
# sg = new Piece.Gi(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(sg)
# sg.status = Const.Status.URA
# b.move_capture(sg, [1,2])
# ff = new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(ff)
# ff.status = Const.Status.URA
# b.move_capture(ff, [2,3])
# sf = new Piece.Fu(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(sf)
# b.move_capture(sf, [2,2])

# HiGi ---x43
# gote hissyou?
# b.pieces = []
# fo = new Piece.Ou(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(fo)
# so = new Piece.Ou(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(so)
# b.move_capture(fo, [3,3])
# b.move_capture(so, [1,1])
# fh = new Piece.Hi(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(fh)
# sg = new Piece.Gi(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(sg)
# sg2 = new Piece.Gi(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(sg2)
# ff = new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(ff)
# b.move_capture(ff, [2,3])
# sf = new Piece.Fu(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(sf)
# b.move_capture(sf, [2,1])

# KaGi ---x
# b.pieces = []
# fo = new Piece.Ou(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(fo)
# so = new Piece.Ou(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(so)
# b.move_capture(fo, [3,3])
# b.move_capture(so, [1,1])
# fg = new Piece.Gi(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(fg)
# sm = new Piece.Ka(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(sm)
# b.move_capture(sm, [3,1])
# sf = new Piece.Fu(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(sf)
# ff = new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(ff)


# KaKi ---o42
# b.pieces = []
# fo = new Piece.Ou(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(fo)
# so = new Piece.Ou(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(so)
# b.move_capture(fo, [3,3])
# b.move_capture(so, [1,1])
# fy = new Piece.Ky(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(fy)
# sx = new Piece.Ki(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(sx)
# sm = new Piece.Ka(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(sm)
# ff = new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(ff)
# b.move_capture(ff, [2,2])

# GiFu ---o
# b.pieces = []
# fo = new Piece.Ou(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(fo)
# so = new Piece.Ou(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(so)
# b.move_capture(fo, [3,3])
# b.move_capture(so, [3,1])
# sg = new Piece.Gi(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(sg)
# ff = new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(ff)
# ff2 = new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(ff2)

# GiFu ---o45
# b.pieces = []
# fo = new Piece.Ou(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(fo)
# so = new Piece.Ou(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(so)
# b.move_capture(fo, [3,1])
# b.move_capture(so, [1,3])
# fg = new Piece.Gi(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(fg)
# sg = new Piece.Gi(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(sg)
# sf = new Piece.Fu(Const.SECOND, Const.Status.MOTIGOMA)
# b.add(sf)
# ff = new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA)
# b.add(ff)

# GiKy ---o
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [1,3]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [3,1]))
# b.pieces.push(new Piece.Gi(Const.FIRST, Const.Status.OMOTE, [3,3]))
# b.pieces.push(new Piece.Gi(Const.SECOND, Const.Status.OMOTE, [1,1]))
# b.pieces.push(new Piece.Ky(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Ky(Const.SECOND, Const.Status.MOTIGOMA))

# KiKe ---o
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,2]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,2]))
# b.pieces.push(new Piece.Ki(Const.FIRST, Const.Status.OMOTE, [3,1]))
# b.pieces.push(new Piece.Ki(Const.SECOND, Const.Status.OMOTE, [1,3]))
# b.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.OMOTE, [3,3]))
# b.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.OMOTE, [1,1]))

# GiKe ---o
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [1,2]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [3,2]))
# b.pieces.push(new Piece.Gi(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Gi(Const.SECOND, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.OMOTE, [2,3]))
# b.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.OMOTE, [2,1]))

# KaKe ---o124
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,3]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,1]))
# b.pieces.push(new Piece.Ka(Const.FIRST, Const.Status.OMOTE, [2,1]))
# b.pieces.push(new Piece.Ka(Const.SECOND, Const.Status.OMOTE, [2,3]))
# b.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.MOTIGOMA))

# KaKe ---o125
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,3]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,1]))
# b.pieces.push(new Piece.Ka(Const.FIRST, Const.Status.OMOTE, [3,1]))
# b.pieces.push(new Piece.Ka(Const.SECOND, Const.Status.OMOTE, [1,3]))
# b.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.MOTIGOMA))

# KeFu ---o44
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
# b.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.OMOTE, [3,3]))
# b.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.OMOTE, [1,1]))
# b.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.OMOTE, [2,3]))
# b.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.OMOTE, [2,1]))

# KaKy ---o
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
# b.pieces.push(new Piece.Ky(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Ky(Const.SECOND, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Ka(Const.FIRST, Const.Status.OMOTE, [1,2]))
# b.pieces.push(new Piece.Ka(Const.SECOND, Const.Status.OMOTE, [3,2]))

# # KaKy ---o47
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [2,1]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [2,3]))
# b.pieces.push(new Piece.Ka(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Ka(Const.SECOND, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Ky(Const.FIRST, Const.Status.OMOTE, [1,3]))
# b.pieces.push(new Piece.Ky(Const.SECOND, Const.Status.OMOTE, [3,1]))

# GiKy ---△48
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
# b.pieces.push(new Piece.Ky(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Ky(Const.SECOND, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Gi(Const.FIRST, Const.Status.OMOTE, [3,3]))
# b.pieces.push(new Piece.Gi(Const.SECOND, Const.Status.OMOTE, [1,1]))

# GiFu ---△49
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
# b.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.OMOTE, [2,3]))
# b.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.OMOTE, [2,1]))
# b.pieces.push(new Piece.Gi(Const.FIRST, Const.Status.OMOTE, [1,2]))
# b.pieces.push(new Piece.Gi(Const.SECOND, Const.Status.OMOTE, [3,2]))

# KaFu ---o69
# sennitite?
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,2]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,2]))
# b.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.OMOTE, [2,3]))
# b.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.OMOTE, [2,1]))
# b.pieces.push(new Piece.Ka(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Ka(Const.SECOND, Const.Status.MOTIGOMA))

# KeKy ---△50
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [1,2]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [3,2]))
# b.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.OMOTE, [3,3]))
# b.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.OMOTE, [1,1]))
# b.pieces.push(new Piece.Ky(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Ky(Const.SECOND, Const.Status.MOTIGOMA))

# HiFu ---x30 depth=9じゃないと初手３二飛が指せない
# gote hissyou?
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [2,3]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [2,1]))
# b.pieces.push(new Piece.Hi(Const.FIRST, Const.Status.OMOTE, [3,3]))
# b.pieces.push(new Piece.Hi(Const.SECOND, Const.Status.OMOTE, [1,1]))
# b.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.MOTIGOMA))

# HiFu ---o depth=8で後手が勝つ変化、その他は千日手
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [1,3]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [3,1]))
# b.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.OMOTE, [2,3]))
# b.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.OMOTE, [2,1]))
# b.pieces.push(new Piece.Hi(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Hi(Const.SECOND, Const.Status.MOTIGOMA))

# KaKy ---o
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [1,2]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [3,2]))
# b.pieces.push(new Piece.Ka(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Ka(Const.SECOND, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Ky(Const.FIRST, Const.Status.OMOTE, [1,3]))
# b.pieces.push(new Piece.Ky(Const.SECOND, Const.Status.OMOTE, [3,1]))

# KaGi ---o46
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [2,1]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [2,3]))
# b.pieces.push(new Piece.Ka(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Ka(Const.SECOND, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Gi(Const.FIRST, Const.Status.OMOTE, [3,1]))
# b.pieces.push(new Piece.Gi(Const.SECOND, Const.Status.OMOTE, [1,3]))

# KaFu ---o51
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [2,3]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [2,1]))
# b.pieces.push(new Piece.Ka(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Ka(Const.SECOND, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.OMOTE, [3,3]))
# b.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.OMOTE, [1,1]))

# KiGi ---o
# sennitite
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
# b.pieces.push(new Piece.Ki(Const.FIRST, Const.Status.OMOTE, [3,2]))
# b.pieces.push(new Piece.Ki(Const.SECOND, Const.Status.OMOTE, [1,2]))
# b.pieces.push(new Piece.Gi(Const.FIRST, Const.Status.OMOTE, [3,3]))
# b.pieces.push(new Piece.Gi(Const.SECOND, Const.Status.OMOTE, [1,1]))

# KaKe ---o52
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
# b.pieces.push(new Piece.Ka(Const.FIRST, Const.Status.OMOTE, [2,3]))
# b.pieces.push(new Piece.Ka(Const.SECOND, Const.Status.OMOTE, [2,1]))
# b.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.MOTIGOMA))

# HiFu ---o53
# sennitite?
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,2]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,2]))
# b.pieces.push(new Piece.Hi(Const.FIRST, Const.Status.OMOTE, [3,3]))
# b.pieces.push(new Piece.Hi(Const.SECOND, Const.Status.OMOTE, [1,1]))
# b.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.OMOTE, [2,3]))
# b.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.OMOTE, [2,1]))

# HiGi ---o54
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [1,2]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [3,2]))
# b.pieces.push(new Piece.Gi(Const.FIRST, Const.Status.OMOTE, [1,3]))
# b.pieces.push(new Piece.Gi(Const.SECOND, Const.Status.OMOTE, [3,1]))
# b.pieces.push(new Piece.Hi(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Hi(Const.SECOND, Const.Status.MOTIGOMA))

# KeKy ---o55
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
# b.pieces.push(new Piece.Ky(Const.FIRST, Const.Status.OMOTE, [3,3]))
# b.pieces.push(new Piece.Ky(Const.SECOND, Const.Status.OMOTE, [1,1]))
# b.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.MOTIGOMA))

# KaGi ---o56
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
# b.pieces.push(new Piece.Ka(Const.FIRST, Const.Status.OMOTE, [2,3]))
# b.pieces.push(new Piece.Ka(Const.SECOND, Const.Status.OMOTE, [2,1]))
# b.pieces.push(new Piece.Gi(Const.FIRST, Const.Status.OMOTE, [1,2]))
# b.pieces.push(new Piece.Gi(Const.SECOND, Const.Status.OMOTE, [3,2]))

# KiFu ---o
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,2]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,2]))
# b.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.OMOTE, [2,3]))
# b.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.OMOTE, [2,1]))
# b.pieces.push(new Piece.Ki(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Ki(Const.SECOND, Const.Status.MOTIGOMA))

# HiFu ---o57
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [1,3]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [3,1]))
# b.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.OMOTE, [2,3]))
# b.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.OMOTE, [2,1]))
# b.pieces.push(new Piece.Hi(Const.FIRST, Const.Status.URA, [1,1]))
# b.pieces.push(new Piece.Hi(Const.SECOND, Const.Status.URA, [3,3]))

# KyFu ---o58
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [2,3]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [2,1]))
# b.pieces.push(new Piece.Ky(Const.FIRST, Const.Status.OMOTE, [3,3]))
# b.pieces.push(new Piece.Ky(Const.SECOND, Const.Status.OMOTE, [1,1]))
# b.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.MOTIGOMA))

# HiKa ---o
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [1,2]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [3,2]))
# b.pieces.push(new Piece.Hi(Const.FIRST, Const.Status.OMOTE, [1,3]))
# b.pieces.push(new Piece.Hi(Const.SECOND, Const.Status.OMOTE, [3,1]))
# b.pieces.push(new Piece.Ka(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Ka(Const.SECOND, Const.Status.MOTIGOMA))

# KaFu ---o
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
# b.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.OMOTE, [1,2]))
# b.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.OMOTE, [3,2]))
# b.pieces.push(new Piece.Ka(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Ka(Const.SECOND, Const.Status.MOTIGOMA))

# GiKe ---o
# sennitite
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [1,3]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [3,1]))
# b.pieces.push(new Piece.Gi(Const.FIRST, Const.Status.OMOTE, [1,2]))
# b.pieces.push(new Piece.Gi(Const.SECOND, Const.Status.OMOTE, [3,2]))
# b.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.OMOTE, [3,3]))
# b.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.OMOTE, [1,1]))

# KaKy ---o
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [1,3]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [3,1]))
# b.pieces.push(new Piece.Ky(Const.FIRST, Const.Status.OMOTE, [2,3]))
# b.pieces.push(new Piece.Ky(Const.SECOND, Const.Status.OMOTE, [2,1]))
# b.pieces.push(new Piece.Ka(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Ka(Const.SECOND, Const.Status.MOTIGOMA))

# GiKy ---o59
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [1,2]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [3,2]))
# b.pieces.push(new Piece.Gi(Const.FIRST, Const.Status.OMOTE, [3,1]))
# b.pieces.push(new Piece.Gi(Const.SECOND, Const.Status.OMOTE, [1,3]))
# b.pieces.push(new Piece.Ky(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Ky(Const.SECOND, Const.Status.MOTIGOMA))

# KaGi ---o
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
# b.pieces.push(new Piece.Ka(Const.FIRST, Const.Status.OMOTE, [1,2]))
# b.pieces.push(new Piece.Ka(Const.SECOND, Const.Status.OMOTE, [3,2]))
# b.pieces.push(new Piece.Gi(Const.FIRST, Const.Status.OMOTE, [3,3]))
# b.pieces.push(new Piece.Gi(Const.SECOND, Const.Status.OMOTE, [1,1]))

# KaGi ---o
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [2,1]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [2,3]))
# b.pieces.push(new Piece.Gi(Const.FIRST, Const.Status.OMOTE, [3,1]))
# b.pieces.push(new Piece.Gi(Const.SECOND, Const.Status.OMOTE, [1,3]))
# b.pieces.push(new Piece.Ka(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Ka(Const.SECOND, Const.Status.MOTIGOMA))

# KyFu ---o60
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
# b.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.OMOTE, [3,2]))
# b.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.OMOTE, [1,2]))
# b.pieces.push(new Piece.Ky(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Ky(Const.SECOND, Const.Status.MOTIGOMA))

# KaKy ---o61
# sennitite
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,3]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,1]))
# b.pieces.push(new Piece.Ky(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Ky(Const.SECOND, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Ka(Const.FIRST, Const.Status.OMOTE, [1,2]))
# b.pieces.push(new Piece.Ka(Const.SECOND, Const.Status.OMOTE, [3,2]))

# KeFu ---o62
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
# b.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.OMOTE, [2,3]))
# b.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.OMOTE, [2,1]))
# b.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.MOTIGOMA))

# GiKe ---o63
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
# b.pieces.push(new Piece.Gi(Const.FIRST, Const.Status.OMOTE, [3,2]))
# b.pieces.push(new Piece.Gi(Const.SECOND, Const.Status.OMOTE, [1,2]))
# b.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.OMOTE, [2,3]))
# b.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.OMOTE, [2,1]))

# GiFu ---o
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
# b.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.OMOTE, [3,3]))
# b.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.OMOTE, [1,1]))
# b.pieces.push(new Piece.Gi(Const.FIRST, Const.Status.OMOTE, [1,2]))
# b.pieces.push(new Piece.Gi(Const.SECOND, Const.Status.OMOTE, [3,2]))

# GiFu ---o64
# sennitite
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,3]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,1]))
# b.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.OMOTE, [2,3]))
# b.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.OMOTE, [2,1]))
# b.pieces.push(new Piece.Gi(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Gi(Const.SECOND, Const.Status.MOTIGOMA))

# KeKy ---o65
# sennitite
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,3]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,1]))
# b.pieces.push(new Piece.Ky(Const.FIRST, Const.Status.OMOTE, [2,3]))
# b.pieces.push(new Piece.Ky(Const.SECOND, Const.Status.OMOTE, [2,1]))
# b.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.MOTIGOMA))

# KaFu ---o
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
# b.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.OMOTE, [3,2]))
# b.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.OMOTE, [1,2]))
# b.pieces.push(new Piece.Ka(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Ka(Const.SECOND, Const.Status.MOTIGOMA))

# KaFu ---o
# sennitite
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
# b.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.OMOTE, [2,3]))
# b.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.OMOTE, [2,1]))
# b.pieces.push(new Piece.Ka(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Ka(Const.SECOND, Const.Status.MOTIGOMA))

# GiFu ---o66
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
# b.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.OMOTE, [2,3]))
# b.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.OMOTE, [2,1]))
# b.pieces.push(new Piece.Gi(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Gi(Const.SECOND, Const.Status.MOTIGOMA))

# KaKi ---o
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
# b.pieces.push(new Piece.Ka(Const.FIRST, Const.Status.OMOTE, [2,3]))
# b.pieces.push(new Piece.Ka(Const.SECOND, Const.Status.OMOTE, [2,1]))
# b.pieces.push(new Piece.Ki(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Ki(Const.SECOND, Const.Status.MOTIGOMA))

# KiKe ---o
# sennitite
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,2]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,2]))
# b.pieces.push(new Piece.Ki(Const.FIRST, Const.Status.OMOTE, [2,1]))
# b.pieces.push(new Piece.Ki(Const.SECOND, Const.Status.OMOTE, [2,3]))
# b.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.MOTIGOMA))

# KiFu ---o
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,2]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,2]))
# b.pieces.push(new Piece.Ki(Const.FIRST, Const.Status.OMOTE, [2,1]))
# b.pieces.push(new Piece.Ki(Const.SECOND, Const.Status.OMOTE, [2,3]))
# b.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.MOTIGOMA))

# GiFu ---o
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,2]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,2]))
# b.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.OMOTE, [3,3]))
# b.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.OMOTE, [1,1]))
# b.pieces.push(new Piece.Gi(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Gi(Const.SECOND, Const.Status.MOTIGOMA))

# GiFu ---o
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [2,1]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [2,3]))
# b.pieces.push(new Piece.Gi(Const.FIRST, Const.Status.OMOTE, [3,3]))
# b.pieces.push(new Piece.Gi(Const.SECOND, Const.Status.OMOTE, [1,1]))
# b.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.MOTIGOMA))

# GiFu ---o67
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [1,1]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
# b.pieces.push(new Piece.Gi(Const.FIRST, Const.Status.OMOTE, [2,3]))
# b.pieces.push(new Piece.Gi(Const.SECOND, Const.Status.OMOTE, [3,1]))
# b.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.OMOTE, [2,1]))
# b.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.OMOTE, [1,2]))

# KiFu ---o
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [2,1]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [2,3]))
# b.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.OMOTE, [3,3]))
# b.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.OMOTE, [1,1]))
# b.pieces.push(new Piece.Ki(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Ki(Const.SECOND, Const.Status.MOTIGOMA))

# HiKe ---o
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [1,2]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [3,2]))
# b.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.OMOTE, [1,3]))
# b.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.OMOTE, [3,1]))
# b.pieces.push(new Piece.Hi(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Hi(Const.SECOND, Const.Status.MOTIGOMA))

# KeFu ---o68
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [1,2]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [3,2]))
# b.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.OMOTE, [2,3]))
# b.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.OMOTE, [2,1]))
# b.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.MOTIGOMA))

# KaGi ---o
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,2]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,2]))
# b.pieces.push(new Piece.Gi(Const.FIRST, Const.Status.OMOTE, [3,3]))
# b.pieces.push(new Piece.Gi(Const.SECOND, Const.Status.OMOTE, [1,1]))
# b.pieces.push(new Piece.Ka(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Ka(Const.SECOND, Const.Status.MOTIGOMA))

# KeFu ---o
# 5tedume
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [1,3]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [3,1]))
# b.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.OMOTE, [3,3]))
# b.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.OMOTE, [1,1]))
# b.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.MOTIGOMA))

# KiKe ---ooo78
# sennitite
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [2,1]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [2,3]))
# b.pieces.push(new Piece.Ki(Const.FIRST, Const.Status.OMOTE, [1,2]))
# b.pieces.push(new Piece.Ki(Const.SECOND, Const.Status.OMOTE, [3,2]))
# b.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.MOTIGOMA))

# GiFu ---o
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [1,3]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [3,1]))
# b.pieces.push(new Piece.Gi(Const.FIRST, Const.Status.OMOTE, [2,1]))
# b.pieces.push(new Piece.Gi(Const.SECOND, Const.Status.OMOTE, [2,3]))
# b.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.MOTIGOMA))

# KeKy ---o70
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [1,2]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [3,2]))
# b.pieces.push(new Piece.Ky(Const.FIRST, Const.Status.OMOTE, [1,3]))
# b.pieces.push(new Piece.Ky(Const.SECOND, Const.Status.OMOTE, [3,1]))
# b.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.MOTIGOMA))

# KiKy ---o71
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,2]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,2]))
# b.pieces.push(new Piece.Ki(Const.FIRST, Const.Status.OMOTE, [2,1]))
# b.pieces.push(new Piece.Ki(Const.SECOND, Const.Status.OMOTE, [2,3]))
# b.pieces.push(new Piece.Ky(Const.FIRST, Const.Status.OMOTE, [3,3]))
# b.pieces.push(new Piece.Ky(Const.SECOND, Const.Status.OMOTE, [1,1]))

# KaFu ---o
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [2,1]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [2,3]))
# b.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.OMOTE, [1,2]))
# b.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.OMOTE, [3,2]))
# b.pieces.push(new Piece.Ka(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Ka(Const.SECOND, Const.Status.MOTIGOMA))

# HiFu ---o
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [1,2]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [3,2]))
# b.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.OMOTE, [1,3]))
# b.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.OMOTE, [3,1]))
# b.pieces.push(new Piece.Hi(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Hi(Const.SECOND, Const.Status.MOTIGOMA))

# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [1,2]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [3,3]))
# b.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.OMOTE, [1,3]))
# b.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.OMOTE, [3,1]))
# b.pieces.push(new Piece.Hi(Const.FIRST, Const.Status.OMOTE, [2,2]))
# b.pieces.push(new Piece.Hi(Const.SECOND, Const.Status.MOTIGOMA))

# GiKe ---o73
# sennitite
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [1,3]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [3,1]))
# b.pieces.push(new Piece.Gi(Const.FIRST, Const.Status.OMOTE, [2,1]))
# b.pieces.push(new Piece.Gi(Const.SECOND, Const.Status.OMOTE, [2,3]))
# b.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.OMOTE, [3,3]))
# b.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.OMOTE, [1,1]))

# HiKe ---o74
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,2]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,2]))
# b.pieces.push(new Piece.Hi(Const.FIRST, Const.Status.OMOTE, [3,3]))
# b.pieces.push(new Piece.Hi(Const.SECOND, Const.Status.OMOTE, [1,1]))
# b.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.MOTIGOMA))

# GiKe ---o
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,3]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,1]))
# b.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Gi(Const.FIRST, Const.Status.OMOTE, [2,3]))
# b.pieces.push(new Piece.Gi(Const.SECOND, Const.Status.OMOTE, [2,1]))

# KeFu ---o75
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [1,2]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [3,2]))
# b.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.OMOTE, [1,3]))
# b.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.OMOTE, [3,1]))
# b.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.MOTIGOMA))

# GiKy ---o
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [2,1]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [2,3]))
# b.pieces.push(new Piece.Gi(Const.FIRST, Const.Status.OMOTE, [1,3]))
# b.pieces.push(new Piece.Gi(Const.SECOND, Const.Status.OMOTE, [3,1]))
# b.pieces.push(new Piece.Ky(Const.FIRST, Const.Status.OMOTE, [3,2]))
# b.pieces.push(new Piece.Ky(Const.SECOND, Const.Status.OMOTE, [1,2]))

# KeKy ---x
# 141
# sennitite
# depth == 8 じゃないと千日手にならず後手勝ちになってしまう
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [2,1]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [2,3]))
# b.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.OMOTE, [3,3]))
# b.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.OMOTE, [1,1]))
# b.pieces.push(new Piece.Ky(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Ky(Const.SECOND, Const.Status.MOTIGOMA))

# KiGi ---o
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [2,1]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [2,3]))
# b.pieces.push(new Piece.Gi(Const.FIRST, Const.Status.OMOTE, [3,1]))
# b.pieces.push(new Piece.Gi(Const.SECOND, Const.Status.OMOTE, [1,3]))
# b.pieces.push(new Piece.Ki(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Ki(Const.SECOND, Const.Status.MOTIGOMA))

# HiFu ---o
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [2,1]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [2,3]))
# b.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.OMOTE, [1,3]))
# b.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.OMOTE, [3,1]))
# b.pieces.push(new Piece.Hi(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Hi(Const.SECOND, Const.Status.MOTIGOMA))

# KeFu ---o76
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
# b.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.OMOTE, [3,3]))
# b.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.OMOTE, [1,1]))
# b.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.MOTIGOMA))

# KeFu ---o
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,2]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,2]))
# b.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.OMOTE, [1,3]))
# b.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.OMOTE, [3,1]))
# b.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.MOTIGOMA))

# HiGi ---o
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [1,3]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [3,1]))
# b.pieces.push(new Piece.Gi(Const.FIRST, Const.Status.OMOTE, [1,2]))
# b.pieces.push(new Piece.Gi(Const.SECOND, Const.Status.OMOTE, [3,2]))
# b.pieces.push(new Piece.Hi(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Hi(Const.SECOND, Const.Status.MOTIGOMA))

# KeKy ---o
# sennitite
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,2]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,2]))
# b.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.OMOTE, [1,3]))
# b.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.OMOTE, [3,1]))
# b.pieces.push(new Piece.Ky(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Ky(Const.SECOND, Const.Status.MOTIGOMA))

# KyFu ---o77
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
# b.pieces.push(new Piece.Ky(Const.FIRST, Const.Status.OMOTE, [3,2]))
# b.pieces.push(new Piece.Ky(Const.SECOND, Const.Status.OMOTE, [1,2]))
# b.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.OMOTE, [2,3]))
# b.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.OMOTE, [2,1]))

# KyFu ---o
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,2]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,2]))
# b.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.OMOTE, [2,3]))
# b.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.OMOTE, [2,1]))
# b.pieces.push(new Piece.Ky(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Ky(Const.SECOND, Const.Status.MOTIGOMA))

# KeKy ---o
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,2]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,2]))
# b.pieces.push(new Piece.Ky(Const.FIRST, Const.Status.OMOTE, [3,3]))
# b.pieces.push(new Piece.Ky(Const.SECOND, Const.Status.OMOTE, [1,1]))
# b.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.MOTIGOMA))

# KaFu ---ooo
# sennitite
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
# b.pieces.push(new Piece.Ka(Const.FIRST, Const.Status.OMOTE, [3,2]))
# b.pieces.push(new Piece.Ka(Const.SECOND, Const.Status.OMOTE, [1,2]))
# b.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.OMOTE, [2,3]))
# b.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.OMOTE, [2,1]))

# GiKy ---o
# sennitite
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [2,3]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [2,1]))
# b.pieces.push(new Piece.Gi(Const.FIRST, Const.Status.OMOTE, [3,1]))
# b.pieces.push(new Piece.Gi(Const.SECOND, Const.Status.OMOTE, [1,3]))
# b.pieces.push(new Piece.Ky(Const.FIRST, Const.Status.OMOTE, [3,2]))
# b.pieces.push(new Piece.Ky(Const.SECOND, Const.Status.OMOTE, [1,2]))

# KeFu ---o79
# sennitite
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,2]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,2]))
# b.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.OMOTE, [1,3]))
# b.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.OMOTE, [3,1]))
# b.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.OMOTE, [3,3]))
# b.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.OMOTE, [1,1]))

# KaKy ---o
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [2,3]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [2,1]))
# b.pieces.push(new Piece.Ka(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Ka(Const.SECOND, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Ky(Const.FIRST, Const.Status.OMOTE, [3,2]))
# b.pieces.push(new Piece.Ky(Const.SECOND, Const.Status.OMOTE, [1,2]))

# KaGi ---o
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,3]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,1]))
# b.pieces.push(new Piece.Gi(Const.FIRST, Const.Status.OMOTE, [3,1]))
# b.pieces.push(new Piece.Gi(Const.SECOND, Const.Status.OMOTE, [1,3]))
# b.pieces.push(new Piece.Ka(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Ka(Const.SECOND, Const.Status.MOTIGOMA))

# KaGi ---o
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
# b.pieces.push(new Piece.Gi(Const.FIRST, Const.Status.OMOTE, [2,3]))
# b.pieces.push(new Piece.Gi(Const.SECOND, Const.Status.OMOTE, [2,1]))
# b.pieces.push(new Piece.Ka(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Ka(Const.SECOND, Const.Status.MOTIGOMA))

# GiFu ---o
# sennitite
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [1,2]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [3,2]))
# b.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.OMOTE, [2,3]))
# b.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.OMOTE, [2,1]))
# b.pieces.push(new Piece.Gi(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Gi(Const.SECOND, Const.Status.MOTIGOMA))

# GiFu ---o
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [1,3]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [3,1]))
# b.pieces.push(new Piece.Gi(Const.FIRST, Const.Status.OMOTE, [3,3]))
# b.pieces.push(new Piece.Gi(Const.SECOND, Const.Status.OMOTE, [1,1]))
# b.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.MOTIGOMA))

# KyFu ---o
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [2,3]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [2,1]))
# b.pieces.push(new Piece.Ky(Const.FIRST, Const.Status.OMOTE, [1,2]))
# b.pieces.push(new Piece.Ky(Const.SECOND, Const.Status.OMOTE, [3,2]))
# b.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.MOTIGOMA))

# GiKy ---o
# depth = 8で正解
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
# b.pieces.push(new Piece.Ky(Const.FIRST, Const.Status.OMOTE, [3,2]))
# b.pieces.push(new Piece.Ky(Const.SECOND, Const.Status.OMOTE, [1,2]))
# b.pieces.push(new Piece.Gi(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Gi(Const.SECOND, Const.Status.MOTIGOMA))

# KaFu ---o
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [2,1]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [2,3]))
# b.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.OMOTE, [3,3]))
# b.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.OMOTE, [1,1]))
# b.pieces.push(new Piece.Ka(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Ka(Const.SECOND, Const.Status.MOTIGOMA))

# KaFu ---o
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,3]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,1]))
# b.pieces.push(new Piece.Ka(Const.FIRST, Const.Status.OMOTE, [1,2]))
# b.pieces.push(new Piece.Ka(Const.SECOND, Const.Status.OMOTE, [3,2]))
# b.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.OMOTE, [1,3]))
# b.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.OMOTE, [3,1]))

# HiKi ---o80
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
# b.pieces.push(new Piece.Ki(Const.FIRST, Const.Status.OMOTE, [3,2]))
# b.pieces.push(new Piece.Ki(Const.SECOND, Const.Status.OMOTE, [1,2]))
# b.pieces.push(new Piece.Hi(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Hi(Const.SECOND, Const.Status.MOTIGOMA))

# HiFu ---o
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
# b.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.OMOTE, [3,2]))
# b.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.OMOTE, [1,2]))
# b.pieces.push(new Piece.Hi(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Hi(Const.SECOND, Const.Status.MOTIGOMA))

# HiFu ---o
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [2,3]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [2,1]))
# b.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.OMOTE, [3,3]))
# b.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.OMOTE, [1,1]))
# b.pieces.push(new Piece.Hi(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Hi(Const.SECOND, Const.Status.MOTIGOMA))

# GiFu ---o
# sennitite
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,3]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,1]))
# b.pieces.push(new Piece.Gi(Const.FIRST, Const.Status.OMOTE, [3,1]))
# b.pieces.push(new Piece.Gi(Const.SECOND, Const.Status.OMOTE, [1,3]))
# b.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.MOTIGOMA))

# KiGi ---o
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [1,2]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [3,2]))
# b.pieces.push(new Piece.Gi(Const.FIRST, Const.Status.OMOTE, [3,1]))
# b.pieces.push(new Piece.Gi(Const.SECOND, Const.Status.OMOTE, [1,3]))
# b.pieces.push(new Piece.Ki(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Ki(Const.SECOND, Const.Status.MOTIGOMA))

# KaFu ---o
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,3]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,1]))
# b.pieces.push(new Piece.Ka(Const.FIRST, Const.Status.OMOTE, [3,2]))
# b.pieces.push(new Piece.Ka(Const.SECOND, Const.Status.OMOTE, [1,2]))
# b.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.OMOTE, [2,2]))

# KaFu ---o
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,3]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,1]))
# b.pieces.push(new Piece.Ka(Const.FIRST, Const.Status.OMOTE, [3,2]))
# b.pieces.push(new Piece.Ka(Const.SECOND, Const.Status.OMOTE, [1,2]))
# b.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.OMOTE, [2,2]))
# b.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.MOTIGOMA))

# HiFu ---x
# depth == 8 じゃないと後手勝ちにならない
# depth == 9 でsennitite
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,3]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,1]))
# b.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.OMOTE, [2,3]))
# b.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.OMOTE, [2,1]))
# b.pieces.push(new Piece.Hi(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Hi(Const.SECOND, Const.Status.MOTIGOMA))

# KeKy ---△
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
# b.pieces.push(new Piece.Ky(Const.FIRST, Const.Status.OMOTE, [3,2]))
# b.pieces.push(new Piece.Ky(Const.SECOND, Const.Status.OMOTE, [1,2]))
# b.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.OMOTE, [2,3]))
# b.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.OMOTE, [2,1]))

# KeFu ---o
# sennitite
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [2,1]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [2,3]))
# b.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.OMOTE, [3,3]))
# b.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.OMOTE, [1,1]))

# KiKe ---o
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
# b.pieces.push(new Piece.Ki(Const.FIRST, Const.Status.OMOTE, [3,3]))
# b.pieces.push(new Piece.Ki(Const.SECOND, Const.Status.OMOTE, [1,1]))
# b.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.MOTIGOMA))

# KaKy ---o81
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [1,3]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [3,1]))
# b.pieces.push(new Piece.Ky(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Ky(Const.SECOND, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Ka(Const.FIRST, Const.Status.OMOTE, [2,3]))
# b.pieces.push(new Piece.Ka(Const.SECOND, Const.Status.OMOTE, [2,1]))

# KaKy ---o82
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [1,3]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [3,1]))
# b.pieces.push(new Piece.Ky(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Ky(Const.SECOND, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Ka(Const.FIRST, Const.Status.OMOTE, [1,2]))
# b.pieces.push(new Piece.Ka(Const.SECOND, Const.Status.OMOTE, [3,2]))

# KeKy ---o83
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,3]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,1]))
# b.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.OMOTE, [1,3]))
# b.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.OMOTE, [3,1]))
# b.pieces.push(new Piece.Ky(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Ky(Const.SECOND, Const.Status.MOTIGOMA))

# KiKe ---x
# depth == 8にしないと先手勝ちにならずに千日手になってしまう
# 145
# depth == 9 でやはり千日手
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,3]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,1]))
# b.pieces.push(new Piece.Ki(Const.FIRST, Const.Status.OMOTE, [2,3]))
# b.pieces.push(new Piece.Ki(Const.SECOND, Const.Status.OMOTE, [2,1]))
# b.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.MOTIGOMA))

# KeFu ---x
# depth = 8 で正解
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [1,2]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [3,2]))
# b.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.OMOTE, [3,3]))
# b.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.OMOTE, [1,1]))
# b.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.MOTIGOMA))

# GiKe ---o84
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [2,1]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [2,3]))
# b.pieces.push(new Piece.Gi(Const.FIRST, Const.Status.OMOTE, [3,1]))
# b.pieces.push(new Piece.Gi(Const.SECOND, Const.Status.OMOTE, [1,3]))
# b.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.MOTIGOMA))

# GiKe ---o
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [1,2]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [3,2]))
# b.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.OMOTE, [3,3]))
# b.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.OMOTE, [1,1]))
# b.pieces.push(new Piece.Gi(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Gi(Const.SECOND, Const.Status.MOTIGOMA))

# KaKy ---o86
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
# b.pieces.push(new Piece.Ka(Const.FIRST, Const.Status.OMOTE, [3,2]))
# b.pieces.push(new Piece.Ka(Const.SECOND, Const.Status.OMOTE, [1,2]))
# b.pieces.push(new Piece.Ky(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Ky(Const.SECOND, Const.Status.MOTIGOMA))

# KaKy ---o
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [2,1]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [2,3]))
# b.pieces.push(new Piece.Ky(Const.FIRST, Const.Status.OMOTE, [3,3]))
# b.pieces.push(new Piece.Ky(Const.SECOND, Const.Status.OMOTE, [1,1]))
# b.pieces.push(new Piece.Ka(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Ka(Const.SECOND, Const.Status.MOTIGOMA))

# HiFu ---o87???
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,3]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,1]))
# b.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.OMOTE, [1,3]))
# b.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.OMOTE, [3,1]))
# b.pieces.push(new Piece.Hi(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Hi(Const.SECOND, Const.Status.MOTIGOMA))

# KyFu ---o
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [2,3]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [2,1]))
# b.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.OMOTE, [3,3]))
# b.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.OMOTE, [1,1]))
# b.pieces.push(new Piece.Ky(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Ky(Const.SECOND, Const.Status.MOTIGOMA))

# KeFu ---x
# depth = 8 で正解sennitite
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [1,2]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [3,2]))
# b.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.OMOTE, [2,3]))
# b.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.OMOTE, [2,1]))
# b.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.MOTIGOMA))

# KeKy ---o89
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [2,1]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [2,3]))
# b.pieces.push(new Piece.Ky(Const.FIRST, Const.Status.OMOTE, [1,2]))
# b.pieces.push(new Piece.Ky(Const.SECOND, Const.Status.OMOTE, [3,2]))
# b.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.MOTIGOMA))

# KaFu ---o90
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
# b.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.OMOTE, [3,3]))
# b.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.OMOTE, [1,1]))
# b.pieces.push(new Piece.Ka(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Ka(Const.SECOND, Const.Status.MOTIGOMA))

# GiFu ---o91
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
# b.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.OMOTE, [1,2]))
# b.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.OMOTE, [3,2]))
# b.pieces.push(new Piece.Gi(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Gi(Const.SECOND, Const.Status.MOTIGOMA))

# KaKy ---o92
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
# b.pieces.push(new Piece.Ka(Const.FIRST, Const.Status.OMOTE, [2,3]))
# b.pieces.push(new Piece.Ka(Const.SECOND, Const.Status.OMOTE, [2,1]))
# b.pieces.push(new Piece.Ky(Const.FIRST, Const.Status.OMOTE, [3,3]))
# b.pieces.push(new Piece.Ky(Const.SECOND, Const.Status.OMOTE, [1,1]))

# HiKe ---o93
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,2]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,2]))
# b.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.OMOTE, [3,3]))
# b.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.OMOTE, [1,1]))
# b.pieces.push(new Piece.Hi(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Hi(Const.SECOND, Const.Status.MOTIGOMA))

# KeFu ---o94
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
# b.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.OMOTE, [2,3]))
# b.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.OMOTE, [2,1]))
# b.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.MOTIGOMA))

# KeKy ---x119
# depth = 7 で千日手、depth = 8 で先手勝ち
# depth = 6,8,9で正解、depth = 7 で不正解
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [2,3]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [2,1]))
# b.pieces.push(new Piece.Ky(Const.FIRST, Const.Status.OMOTE, [1,3]))
# b.pieces.push(new Piece.Ky(Const.SECOND, Const.Status.OMOTE, [3,1]))
# b.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.MOTIGOMA))

# KeKy ---x
# 146
# depth = 9 で正解
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [1,2]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [3,2]))
# b.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.OMOTE, [2,3]))
# b.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.OMOTE, [2,1]))
# b.pieces.push(new Piece.Ky(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Ky(Const.SECOND, Const.Status.MOTIGOMA))

# KaKe ---o95
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [1,2]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [3,2]))
# b.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.OMOTE, [1,3]))
# b.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.OMOTE, [3,1]))
# b.pieces.push(new Piece.Ka(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Ka(Const.SECOND, Const.Status.MOTIGOMA))

# KiKy ---o96
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,2]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,2]))
# b.pieces.push(new Piece.Ki(Const.FIRST, Const.Status.OMOTE, [3,1]))
# b.pieces.push(new Piece.Ki(Const.SECOND, Const.Status.OMOTE, [1,3]))
# b.pieces.push(new Piece.Ky(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Ky(Const.SECOND, Const.Status.MOTIGOMA))

# KiKy ---o97
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,3]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,1]))
# b.pieces.push(new Piece.Ki(Const.FIRST, Const.Status.OMOTE, [1,3]))
# b.pieces.push(new Piece.Ki(Const.SECOND, Const.Status.OMOTE, [3,1]))
# b.pieces.push(new Piece.Ky(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Ky(Const.SECOND, Const.Status.MOTIGOMA))

# KeKy ---o98
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,2]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,2]))
# b.pieces.push(new Piece.Ky(Const.FIRST, Const.Status.OMOTE, [3,3]))
# b.pieces.push(new Piece.Ky(Const.SECOND, Const.Status.OMOTE, [1,1]))
# b.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.OMOTE, [1,3]))
# b.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.OMOTE, [3,1]))

# KaKe ---o
# gote hissyo
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,3]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,1]))
# b.pieces.push(new Piece.Ka(Const.FIRST, Const.Status.OMOTE, [2,1]))
# b.pieces.push(new Piece.Ka(Const.SECOND, Const.Status.OMOTE, [2,3]))
# b.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.OMOTE, [1,3]))
# b.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.OMOTE, [3,1]))

# KaFu ---o
# sente hissyo
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
# b.pieces.push(new Piece.Ka(Const.FIRST, Const.Status.OMOTE, [2,3]))
# b.pieces.push(new Piece.Ka(Const.SECOND, Const.Status.OMOTE, [2,1]))
# b.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.MOTIGOMA))

# KyFu ---o99
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,3]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,1]))
# b.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.OMOTE, [1,3]))
# b.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.OMOTE, [3,1]))
# b.pieces.push(new Piece.Ky(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Ky(Const.SECOND, Const.Status.MOTIGOMA))

# HiFu ---o100
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,3]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,1]))
# b.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.OMOTE, [3,2]))
# b.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.OMOTE, [1,2]))
# b.pieces.push(new Piece.Hi(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Hi(Const.SECOND, Const.Status.MOTIGOMA))

# GiFu ---o123
# depth = 8 で正解???
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,3]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,1]))
# b.pieces.push(new Piece.Gi(Const.FIRST, Const.Status.OMOTE, [1,3]))
# b.pieces.push(new Piece.Gi(Const.SECOND, Const.Status.OMOTE, [3,1]))
# b.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.MOTIGOMA))

# KiFu ---x
# depth == 8 じゃないと千日手にならない
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
# b.pieces.push(new Piece.Ki(Const.FIRST, Const.Status.OMOTE, [2,1]))
# b.pieces.push(new Piece.Ki(Const.SECOND, Const.Status.OMOTE, [2,3]))
# b.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.MOTIGOMA))

# KiKe ---o
# depth == 8 で正解
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,2]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,2]))
# b.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.OMOTE, [3,3]))
# b.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.OMOTE, [1,1]))
# b.pieces.push(new Piece.Ki(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Ki(Const.SECOND, Const.Status.MOTIGOMA))

# KaFu ---o101
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
# b.pieces.push(new Piece.Ka(Const.FIRST, Const.Status.OMOTE, [2,1]))
# b.pieces.push(new Piece.Ka(Const.SECOND, Const.Status.OMOTE, [2,3]))
# b.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.MOTIGOMA))

# KyFu ---o102
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
# b.pieces.push(new Piece.Ky(Const.FIRST, Const.Status.OMOTE, [1,2]))
# b.pieces.push(new Piece.Ky(Const.SECOND, Const.Status.OMOTE, [3,2]))
# b.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.MOTIGOMA))

# GiKy ---x
# sennitite
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [2,3]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [2,1]))
# b.pieces.push(new Piece.Gi(Const.FIRST, Const.Status.OMOTE, [3,1]))
# b.pieces.push(new Piece.Gi(Const.SECOND, Const.Status.OMOTE, [1,3]))
# b.pieces.push(new Piece.Ky(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Ky(Const.SECOND, Const.Status.MOTIGOMA))

# GiKe ---o103
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,2]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,2]))
# b.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Gi(Const.FIRST, Const.Status.OMOTE, [3,1]))
# b.pieces.push(new Piece.Gi(Const.SECOND, Const.Status.OMOTE, [1,3]))

# KeFu ---x
# depth == 8じゃないと千日手にならない
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
# b.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.OMOTE, [3,3]))
# b.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.OMOTE, [1,1]))
# b.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.OMOTE, [2,3]))
# b.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.OMOTE, [2,1]))

# KeFu ---x
# 147
# depth == 8じゃないと先手勝てない
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [1,3]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [3,1]))
# b.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.OMOTE, [3,3]))
# b.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.OMOTE, [1,1]))
# b.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.MOTIGOMA))

# HiKe ---x
# 148
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [2,1]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [2,3]))
# b.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.OMOTE, [1,3]))
# b.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.OMOTE, [3,1]))
# b.pieces.push(new Piece.Hi(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Hi(Const.SECOND, Const.Status.MOTIGOMA))

# KaKe ---o104
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [1,3]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [3,1]))
# b.pieces.push(new Piece.Ka(Const.FIRST, Const.Status.OMOTE, [2,3]))
# b.pieces.push(new Piece.Ka(Const.SECOND, Const.Status.OMOTE, [2,1]))
# b.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.MOTIGOMA))

# KeFu ---o105
# depth == 8 で千日手だが他は先手勝ち
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,2]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,2]))
# b.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.OMOTE, [2,3]))
# b.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.OMOTE, [2,1]))
# b.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.MOTIGOMA))

# KyFu ---o120
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [1,2]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [3,2]))
# b.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.OMOTE, [2,3]))
# b.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.OMOTE, [2,1]))
# b.pieces.push(new Piece.Ky(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Ky(Const.SECOND, Const.Status.MOTIGOMA))

# KyFu ---o72
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [2,1]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [2,3]))
# b.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.OMOTE, [3,3]))
# b.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.OMOTE, [1,1]))
# b.pieces.push(new Piece.Ky(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Ky(Const.SECOND, Const.Status.MOTIGOMA))

# GiFu ---o106
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [2,1]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [2,3]))
# b.pieces.push(new Piece.Gi(Const.FIRST, Const.Status.OMOTE, [3,1]))
# b.pieces.push(new Piece.Gi(Const.SECOND, Const.Status.OMOTE, [1,3]))
# b.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.MOTIGOMA))

# HiFu ---o107
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [1,2]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [3,2]))
# b.pieces.push(new Piece.Hi(Const.FIRST, Const.Status.OMOTE, [1,3]))
# b.pieces.push(new Piece.Hi(Const.SECOND, Const.Status.OMOTE, [3,1]))
# b.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.MOTIGOMA))

# KyFu ---o108
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [1,2]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [3,2]))
# b.pieces.push(new Piece.Ky(Const.FIRST, Const.Status.OMOTE, [1,3]))
# b.pieces.push(new Piece.Ky(Const.SECOND, Const.Status.OMOTE, [3,1]))
# b.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.OMOTE, [2,3]))
# b.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.OMOTE, [2,1]))

# HiKy ---o109
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [2,1]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [2,3]))
# b.pieces.push(new Piece.Ky(Const.FIRST, Const.Status.OMOTE, [3,3]))
# b.pieces.push(new Piece.Ky(Const.SECOND, Const.Status.OMOTE, [1,1]))
# b.pieces.push(new Piece.Hi(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Hi(Const.SECOND, Const.Status.MOTIGOMA))

# HiKa ---o39
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,2]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,2]))
# b.pieces.push(new Piece.Ka(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Hi(Const.SECOND, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.MOTIGOMA))

# KiKe ---o110
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [2,1]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [2,3]))
# b.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.URA, [1,2]))
# b.pieces.push(new Piece.Ki(Const.SECOND, Const.Status.OMOTE, [3,2]))
# b.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.MOTIGOMA))

# HiKa ---o111
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,3]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,1]))
# b.pieces.push(new Piece.Hi(Const.FIRST, Const.Status.OMOTE, [3,2]))
# b.pieces.push(new Piece.Ka(Const.SECOND, Const.Status.OMOTE, [1,3]))

# KeFu ---o
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,3]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,1]))
# b.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.OMOTE, [1,3]))
# b.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.OMOTE, [3,1]))
# b.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.MOTIGOMA))

# HiFu ---o112
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [2,1]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [2,3]))
# b.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.OMOTE, [3,3]))
# b.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.OMOTE, [1,1]))
# b.pieces.push(new Piece.Hi(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Hi(Const.SECOND, Const.Status.MOTIGOMA))

# GiKe ---o
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [1,3]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [3,1]))
# b.pieces.push(new Piece.Gi(Const.FIRST, Const.Status.OMOTE, [1,2]))
# b.pieces.push(new Piece.Gi(Const.SECOND, Const.Status.OMOTE, [3,2]))
# b.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.MOTIGOMA))

# GiKe ---o
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [1,3]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [3,1]))
# b.pieces.push(new Piece.Gi(Const.FIRST, Const.Status.OMOTE, [2,3]))
# b.pieces.push(new Piece.Gi(Const.SECOND, Const.Status.OMOTE, [2,1]))
# b.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.MOTIGOMA))

# GiKe ---o114
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,2]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,2]))
# b.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.OMOTE, [1,3]))
# b.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.OMOTE, [3,1]))
# b.pieces.push(new Piece.Gi(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Gi(Const.SECOND, Const.Status.MOTIGOMA))

# KiKy ---o113
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [2,1]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [2,3]))
# b.pieces.push(new Piece.Ki(Const.FIRST, Const.Status.OMOTE, [3,1]))
# b.pieces.push(new Piece.Ki(Const.SECOND, Const.Status.OMOTE, [1,3]))
# b.pieces.push(new Piece.Ky(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Ky(Const.SECOND, Const.Status.MOTIGOMA))

# HiFu ---o
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
# b.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.OMOTE, [2,3]))
# b.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.OMOTE, [2,1]))
# b.pieces.push(new Piece.Hi(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Hi(Const.SECOND, Const.Status.MOTIGOMA))

# GiKy ---o115
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
# b.pieces.push(new Piece.Ky(Const.FIRST, Const.Status.OMOTE, [3,3]))
# b.pieces.push(new Piece.Ky(Const.SECOND, Const.Status.OMOTE, [1,1]))
# b.pieces.push(new Piece.Gi(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Gi(Const.SECOND, Const.Status.MOTIGOMA))

# KiKe ---o116
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [1,2]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [3,2]))
# b.pieces.push(new Piece.Ki(Const.FIRST, Const.Status.OMOTE, [1,3]))
# b.pieces.push(new Piece.Ki(Const.SECOND, Const.Status.OMOTE, [3,1]))
# b.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.OMOTE, [3,3]))
# b.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.OMOTE, [1,1]))

# KiKe ---o117
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [2,1]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [2,3]))
# b.pieces.push(new Piece.Ki(Const.FIRST, Const.Status.OMOTE, [3,2]))
# b.pieces.push(new Piece.Ki(Const.SECOND, Const.Status.OMOTE, [1,2]))
# b.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.OMOTE, [1,3]))
# b.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.OMOTE, [3,1]))

# KeFu ---o118
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [2,1]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [2,3]))
# b.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.OMOTE, [1,3]))
# b.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.OMOTE, [3,1]))
# b.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.MOTIGOMA))

# GiKe ---o
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [2,1]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [2,3]))
# b.pieces.push(new Piece.Gi(Const.FIRST, Const.Status.OMOTE, [1,3]))
# b.pieces.push(new Piece.Gi(Const.SECOND, Const.Status.OMOTE, [3,1]))
# b.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.MOTIGOMA))

# GiFu ---o121
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [2,1]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [2,3]))
# b.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.OMOTE, [1,3]))
# b.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.OMOTE, [3,1]))
# b.pieces.push(new Piece.Gi(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Gi(Const.SECOND, Const.Status.MOTIGOMA))

# GiKy ---o122
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
# b.pieces.push(new Piece.Gi(Const.FIRST, Const.Status.OMOTE, [2,3]))
# b.pieces.push(new Piece.Gi(Const.SECOND, Const.Status.OMOTE, [2,1]))
# b.pieces.push(new Piece.Ky(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Ky(Const.SECOND, Const.Status.MOTIGOMA))

# KaKy ---o126
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
# b.pieces.push(new Piece.Ka(Const.FIRST, Const.Status.OMOTE, [2,3]))
# b.pieces.push(new Piece.Ka(Const.SECOND, Const.Status.OMOTE, [2,1]))
# b.pieces.push(new Piece.Ky(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Ky(Const.SECOND, Const.Status.MOTIGOMA))

# KaKe ---o127
# gote hissyo
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,3]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,1]))
# b.pieces.push(new Piece.Ka(Const.FIRST, Const.Status.OMOTE, [1,2]))
# b.pieces.push(new Piece.Ka(Const.SECOND, Const.Status.OMOTE, [3,2]))
# b.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.MOTIGOMA))

# GiKe ---o128
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [1,2]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [3,2]))
# b.pieces.push(new Piece.Gi(Const.FIRST, Const.Status.OMOTE, [3,1]))
# b.pieces.push(new Piece.Gi(Const.SECOND, Const.Status.OMOTE, [1,3]))
# b.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.MOTIGOMA))

# GiKe ---o
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [1,2]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [3,2]))
# b.pieces.push(new Piece.Gi(Const.FIRST, Const.Status.OMOTE, [1,3]))
# b.pieces.push(new Piece.Gi(Const.SECOND, Const.Status.OMOTE, [3,1]))
# b.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.MOTIGOMA))

# HiKe ---o129
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
# b.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.OMOTE, [2,3]))
# b.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.OMOTE, [2,1]))
# b.pieces.push(new Piece.Hi(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Hi(Const.SECOND, Const.Status.MOTIGOMA))

# KiKy ---x
# depth = 8 で正解、
# sennitite
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [1,2]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [3,2]))
# b.pieces.push(new Piece.Ki(Const.FIRST, Const.Status.OMOTE, [2,1]))
# b.pieces.push(new Piece.Ki(Const.SECOND, Const.Status.OMOTE, [2,3]))
# b.pieces.push(new Piece.Ky(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Ky(Const.SECOND, Const.Status.MOTIGOMA))

# KaKe ---o130
# gote hissyo
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
# b.pieces.push(new Piece.Ka(Const.FIRST, Const.Status.OMOTE, [2,1]))
# b.pieces.push(new Piece.Ka(Const.SECOND, Const.Status.OMOTE, [2,3]))
# b.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.MOTIGOMA))

# HiKe ---o131
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
# b.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.OMOTE, [3,3]))
# b.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.OMOTE, [1,1]))
# b.pieces.push(new Piece.Hi(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Hi(Const.SECOND, Const.Status.MOTIGOMA))

# HiFu ---o
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
# b.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.OMOTE, [3,2]))
# b.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.OMOTE, [1,2]))
# b.pieces.push(new Piece.Hi(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Hi(Const.SECOND, Const.Status.MOTIGOMA))

# GiFu ---o
# sennitite
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,2]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,2]))
# b.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.OMOTE, [2,3]))
# b.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.OMOTE, [2,1]))
# b.pieces.push(new Piece.Gi(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Gi(Const.SECOND, Const.Status.MOTIGOMA))

# HiGi ---o
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [2,3]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [2,1]))
# b.pieces.push(new Piece.Hi(Const.FIRST, Const.Status.OMOTE, [1,3]))
# b.pieces.push(new Piece.Hi(Const.SECOND, Const.Status.OMOTE, [3,1]))
# b.pieces.push(new Piece.Gi(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Gi(Const.SECOND, Const.Status.MOTIGOMA))

# HiGi ---o132
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
# b.pieces.push(new Piece.Hi(Const.FIRST, Const.Status.OMOTE, [3,2]))
# b.pieces.push(new Piece.Hi(Const.SECOND, Const.Status.OMOTE, [1,2]))
# b.pieces.push(new Piece.Gi(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Gi(Const.SECOND, Const.Status.MOTIGOMA))

# HiGi ---o133
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
# b.pieces.push(new Piece.Gi(Const.FIRST, Const.Status.OMOTE, [3,2]))
# b.pieces.push(new Piece.Gi(Const.SECOND, Const.Status.OMOTE, [1,2]))
# b.pieces.push(new Piece.Hi(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Hi(Const.SECOND, Const.Status.MOTIGOMA))

# HiFu ---o134
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
# b.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.URA, [3,2]))
# b.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.URA, [1,2]))
# b.pieces.push(new Piece.Hi(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Hi(Const.SECOND, Const.Status.MOTIGOMA))

# KaFu ---o135
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
# b.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.URA, [3,2]))
# b.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.URA, [1,2]))
# b.pieces.push(new Piece.Ka(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Ka(Const.SECOND, Const.Status.MOTIGOMA))

# KaKi ---o136
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
# b.pieces.push(new Piece.Ki(Const.FIRST, Const.Status.OMOTE, [3,2]))
# b.pieces.push(new Piece.Ki(Const.SECOND, Const.Status.OMOTE, [1,2]))
# b.pieces.push(new Piece.Ka(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Ka(Const.SECOND, Const.Status.MOTIGOMA))

# KaKi ---o137
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
# b.pieces.push(new Piece.Ki(Const.FIRST, Const.Status.OMOTE, [2,1]))
# b.pieces.push(new Piece.Ki(Const.SECOND, Const.Status.OMOTE, [2,3]))
# b.pieces.push(new Piece.Ka(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Ka(Const.SECOND, Const.Status.MOTIGOMA))

# KaFu ---o138
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
# b.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.URA, [2,1]))
# b.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.URA, [2,3]))
# b.pieces.push(new Piece.Ka(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Ka(Const.SECOND, Const.Status.MOTIGOMA))

# KaGi ---o
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [1,1]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [3,3]))
# b.pieces.push(new Piece.Ka(Const.FIRST, Const.Status.OMOTE, [3,2]))
# b.pieces.push(new Piece.Ka(Const.SECOND, Const.Status.OMOTE, [1,2]))
# b.pieces.push(new Piece.Gi(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Gi(Const.SECOND, Const.Status.MOTIGOMA))

# HiFu ---o140
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
# b.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.URA, [3,3]))
# b.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.URA, [1,1]))
# b.pieces.push(new Piece.Hi(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Hi(Const.SECOND, Const.Status.MOTIGOMA))

# HiKi ---o139
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
# b.pieces.push(new Piece.Ki(Const.FIRST, Const.Status.OMOTE, [3,3]))
# b.pieces.push(new Piece.Ki(Const.SECOND, Const.Status.OMOTE, [1,1]))
# b.pieces.push(new Piece.Hi(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Hi(Const.SECOND, Const.Status.MOTIGOMA))

# 長手数の攻防
# KaFu ---
# b.setPiece(new Piece.Ou(Const.FIRST, Const.Status.OMOTE), 3, 3)
# b.setPiece(new Piece.Ou(Const.SECOND, Const.Status.OMOTE), 1, 1)
# b.setPiece(new Piece.Ka(Const.FIRST, Const.Status.OMOTE), 3, 1)
# b.setPiece(new Piece.Ka(Const.SECOND, Const.Status.OMOTE), 1, 3)
# b.setPiece(new Piece.Fu(Const.FIRST, Const.Status.OMOTE), 3, 2)
# b.setPiece(new Piece.Fu(Const.SECOND, Const.Status.OMOTE), 1, 2)
# first.depth = 10
# second.depth = 10

# tumi test
# b.setPiece(new Piece.Ou(Const.FIRST, Const.Status.OMOTE), 1, 1)
# b.setPiece(new Piece.Ou(Const.SECOND, Const.Status.OMOTE), 3, 3)
# b.setPiece(new Piece.Hi(Const.FIRST, Const.Status.OMOTE), 1, 3)
# b.setPiece(new Piece.Hi(Const.SECOND, Const.Status.OMOTE), 2, 3)
# b.addMotigoma(new Piece.Ky(Const.FIRST, Const.Status.MOTIGOMA), Const.FIRST)
# b.addMotigoma(new Piece.Ky(Const.SECOND, Const.Status.MOTIGOMA), Const.SECOND)
# first.depth = 7
# second.depth = 7

# 後手７手読み（５手詰め）
b.setPiece(new Piece.Ou(Const.FIRST, Const.Status.OMOTE), 3, 3)
b.setPiece(new Piece.Ou(Const.SECOND, Const.Status.OMOTE), 1, 1)
b.addMotigoma(new Piece.Hi(Const.FIRST, Const.Status.MOTIGOMA), Const.FIRST)
b.addMotigoma(new Piece.Ki(Const.SECOND, Const.Status.MOTIGOMA), Const.SECOND)
b.setPiece(new Piece.Fu(Const.SECOND, Const.Status.OMOTE), 2, 2)
first.depth = 7
second.depth = 7

b.display()
ret = null
loop
    temp = null
    ret = null
    for i in [1,2,4,first.depth].unique()
        if i > 9
            temp = first.prepare(b, second, i, Const.MAX_VALUE)
            # first.pre_ahead = 0; second.pre_ahead = 0
            # temp = first.think(b, second, i, Const.MAX_VALUE)
        else
            first.pre_ahead = 0; second.pre_ahead = 0
            temp = first.think(b, second, i, Const.MAX_VALUE)
        # console.log("first: i = #{i}: temp = #{JSON.stringify(temp)}")
        # console.log("board = #{JSON.stringify(b)}")
        if temp.lastkoma?
            ret = temp.clone()
            break if temp.lastkoma? && (temp.lastscore >= Const.MAX_VALUE || temp.lastscore <= Const.MIN_VALUE)
        else
            break
    # console.log("ret = #{JSON.stringify(ret)}")
    if ret?
        check = b.check_move(ret.lastkoma, ret.lastposi)
        if check[0]
            nari = if (check[1] || ret.laststatus == Const.Status.URA) then true else false
            snapshot = b.move_capture(ret.lastkoma, ret.lastposi, nari)
        md5hash = make_hash(b.cloneBoard())
    else
        console.log("Second Win")
        break
    counter += 1
    state.push({"turn": ret.lastturn, "s_posi": snapshot.s_posi, "move": JSON.stringify(ret.lastposi)})
    md5hash = make_hash(b.cloneBoard())
    duplication.push(md5hash)
    b.display()
    sennitite = (v for v in duplication when v == md5hash)
    if sennitite.length >= 4
        console.log("--- 千日手 ---")
        break
    temp = null
    ret = null
    for i in [1,2,4,second.depth].unique()
        if i > 9
            temp = second.prepare(b, first, i, Const.MIN_VALUE)
            # first.pre_ahead = 0; second.pre_ahead = 0
            # temp = second.think(b, first, i, Const.MIN_VALUE)
        else
            first.pre_ahead = 0; second.pre_ahead = 0
            temp = second.think(b, first, i, Const.MIN_VALUE)
        # console.log("second: i = #{i}: temp = #{JSON.stringify(temp)}")
        if temp.lastkoma?
            ret = temp.clone()
            break if temp.lastkoma? && (temp.lastscore >= Const.MAX_VALUE || temp.lastscore <= Const.MIN_VALUE)
        else
            break
    if ret?
        check = b.check_move(ret.lastkoma, ret.lastposi)
        if check[0]
            nari = if (check[1] || ret.laststatus == Const.Status.URA) then true else false
            snapshot = b.move_capture(ret.lastkoma, ret.lastposi, nari)
        md5hash = make_hash(b.cloneBoard())
    else
        console.log("First Win")
        break
    counter += 1
    state.push({"turn": ret.lastturn, "s_posi": snapshot.s_posi, "move": JSON.stringify(ret.lastposi)})
    md5hash = make_hash(b.cloneBoard())
    duplication.push(md5hash)
    b.display()
    sennitite = (v for v in duplication when v == md5hash)
    if sennitite.length >= 4
        console.log("--- 千日手 ---")
        break

console.log(counter)
# console.log(JSON.stringify(b.pieces))
# md5hash = crypto.createHash('md5').update(JSON.stringify(b.pieces)).digest("hex")
#md5hash = make_hash(b.cloneBoard())
# console.log(md5hash)
# console.log(duplication)
elapsed = new Date().getTime() - startTime
console.log "経過時間: #{elapsed}ミリ秒"
