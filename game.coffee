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

# HiGi test xxx
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
# OuFu ---x
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
# saitanCheck
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

# KyFu ---o
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [2,3]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [2,1]))
# b.pieces.push(new Piece.Ky(Const.FIRST, Const.Status.OMOTE, [3,3]))
# b.pieces.push(new Piece.Ky(Const.SECOND, Const.Status.OMOTE, [1,1]))
# b.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.MOTIGOMA))

# GiKe ---o
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [1,2]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [3,2]))
# b.pieces.push(new Piece.Gi(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Gi(Const.SECOND, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.OMOTE, [2,3]))
# b.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.OMOTE, [2,1]))

# KaKe ---o
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,3]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,1]))
# b.pieces.push(new Piece.Ka(Const.FIRST, Const.Status.OMOTE, [2,1]))
# b.pieces.push(new Piece.Ka(Const.SECOND, Const.Status.OMOTE, [2,3]))
# b.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.MOTIGOMA))

# KaKe ---o
# b.pieces = []
# b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,3]))
# b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,1]))
# b.pieces.push(new Piece.Ka(Const.FIRST, Const.Status.OMOTE, [3,1]))
# b.pieces.push(new Piece.Ka(Const.SECOND, Const.Status.OMOTE, [1,3]))
# b.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.MOTIGOMA))
# b.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.MOTIGOMA))

# # KeFu ---o44
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

# KaFu ---△
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
b.pieces = []
b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [2,1]))
b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [2,3]))
b.pieces.push(new Piece.Ka(Const.FIRST, Const.Status.MOTIGOMA))
b.pieces.push(new Piece.Ka(Const.SECOND, Const.Status.MOTIGOMA))
b.pieces.push(new Piece.Gi(Const.FIRST, Const.Status.OMOTE, [3,1]))
b.pieces.push(new Piece.Gi(Const.SECOND, Const.Status.OMOTE, [1,3]))

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
                console.log(ret)
                console.log("--- ---------------")
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
            console.log("first: i = #{i}: temp = #{JSON.stringify(temp)}")
            if temp[0]?
                ret = [].concat(temp)
                break if (temp[2] >= Const.MAX_VALUE || temp[2] <= Const.MIN_VALUE)
            else
                break
        if ret[0]
            # # 一手詰み、三手詰みチェック
            # tumi2 = []
            # tumi2 = first.think(b, second, 2, Const.MAX_VALUE)
            # console.log("tumi2")
            # console.log(tumi2)
            # tumi4 = []
            # tumi4 = first.think(b, second, 4, Const.MAX_VALUE)
            # console.log("tumi4")
            # console.log(tumi4)
            # 一手詰み、三手詰みがあれば差し替える
            # if tumi2[0] && (tumi2[2] >= Const.MAX_VALUE || tumi2[2] <= Const.MIN_VALUE)
            #     if b.check_move(tumi2[0], tumi2[1])
            #         s_posi = b.move_capture(tumi2[0], tumi2[1])
            #         tumi2[0].status = tumi2[3]
            # else if tumi4[0] && (tumi4[2] >= Const.MAX_VALUE || tumi4[2] <= Const.MIN_VALUE)
            #     if b.check_move(tumi4[0], tumi4[1])
            #         s_posi = b.move_capture(tumi4[0], tumi4[1])
            #         tumi4[0].status = tumi4[3]
            # else
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
            console.log("second: i = #{i}: temp = #{JSON.stringify(temp)}")
            if temp[0]?
                ret = [].concat(temp)
                break if temp[0]? && (temp[2] >= Const.MAX_VALUE || temp[2] <= Const.MIN_VALUE)
            else
                break
        if ret[0]
            # # 一手詰み、三手詰みチェック
            # tumi2 = []
            # tumi2 = second.think(b, first, 2, Const.MIN_VALUE)
            # console.log("tumi2")
            # console.log(tumi2)
            # tumi4 = []
            # tumi4 = second.think(b, first, 4, Const.MIN_VALUE)
            # console.log("tumi4")
            # console.log(tumi4)
            # 一手詰み、三手詰みがあれば差し替える
            # if tumi2[0] && (tumi2[2] >= Const.MAX_VALUE || tumi2[2] <= Const.MIN_VALUE)
            #     if b.check_move(tumi2[0], tumi2[1])
            #         s_posi = b.move_capture(tumi2[0], tumi2[1])
            #         tumi2[0].status = tumi2[3]
            # else if tumi4[0] && (tumi4[2] >= Const.MAX_VALUE || tumi4[2] <= Const.MIN_VALUE)
            #     if b.check_move(tumi4[0], tumi4[1])
            #         s_posi = b.move_capture(tumi4[0], tumi4[1])
            #         tumi4[0].status = tumi4[3]
            # else
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

# for v in state
#     console.log("turn = #{v.turn}")
#     console.log("s_posi = #{v.s_posi}")
#     console.log(v.move)
console.log(counter)
console.log(JSON.stringify(b.pieces))
md5hash = crypto.createHash('md5').update(JSON.stringify(b.pieces)).digest("hex")
console.log(md5hash)
console.log(duplication)
elapsed = new Date().getTime() - startTime
console.log "経過時間: #{elapsed}ミリ秒"
