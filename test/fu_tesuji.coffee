chai = require 'chai'
expect = chai.expect
chai.should()
Const = require('../const.coffee')
Piece = require('../piece.coffee')
Board = require('../board.coffee')
Player = require('../player.coffee')

describe 'basic', ->
    b = null
    ff = null; fy = null; fk = null; fg = null; fx = null; fm = null; fh = null; fo = null;
    sf = null; sy = null; sk = null; sg = null; sx = null; sm = null; sh = null; so = null;
    first = null; second = null;
    ret = null
    before ->
        first = new Player(Const.FIRST, false)
        second = new Player(Const.SECOND, false)
    beforeEach ->
        b = new Board()
        b.pieces = []
        fo = new Piece.Ou(Const.FIRST, Const.Status.MOTIGOMA)
        fh = new Piece.Hi(Const.FIRST, Const.Status.MOTIGOMA)
        fm = new Piece.Ka(Const.FIRST, Const.Status.MOTIGOMA)
        fx = new Piece.Ki(Const.FIRST, Const.Status.MOTIGOMA)
        fg = new Piece.Gi(Const.FIRST, Const.Status.MOTIGOMA)
        fk = new Piece.Ke(Const.FIRST, Const.Status.MOTIGOMA)
        fy = new Piece.Ky(Const.FIRST, Const.Status.MOTIGOMA)
        ff = new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA)
        so = new Piece.Ou(Const.SECOND, Const.Status.MOTIGOMA)
        sh = new Piece.Hi(Const.SECOND, Const.Status.MOTIGOMA)
        sm = new Piece.Ka(Const.SECOND, Const.Status.MOTIGOMA)
        sx = new Piece.Ki(Const.SECOND, Const.Status.MOTIGOMA)
        sg = new Piece.Gi(Const.SECOND, Const.Status.MOTIGOMA)
        sk = new Piece.Ke(Const.SECOND, Const.Status.MOTIGOMA)
        sy = new Piece.Ky(Const.SECOND, Const.Status.MOTIGOMA)
        sf = new Piece.Fu(Const.SECOND, Const.Status.MOTIGOMA)

    describe '基本三手読み先手', ->
        it 'expects Fu move [2,2] when effective move is exist', ->
            b.addMotigoma(fo, Const.FIRST);b.addMotigoma(ff, Const.FIRST)
            b.addMotigoma(so, Const.SECOND);b.addMotigoma(sf, Const.SECOND)
            b.move_capture(fo, [3,2])
            b.move_capture(so, [1,2])
            b.display()
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = first.think(b, second, 2, Const.MAX_VALUE)
            expect(ret.lastkoma.name).to.equal('Fu')
            expect(ret.lastposi).to.deep.equal([2,2])
    describe '基本四手読み先手', ->
        it 'expects Fu move [2,2] when effective move is exist', ->
            b.addMotigoma(fo, Const.FIRST);b.addMotigoma(ff, Const.FIRST)
            b.addMotigoma(so, Const.SECOND);b.addMotigoma(sf, Const.SECOND)
            b.move_capture(fo, [3,2])
            b.move_capture(so, [1,2])
            b.display()
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = first.think(b, second, 3, Const.MAX_VALUE)
            expect(ret.lastkoma.name).to.equal('Fu')
            expect(ret.lastposi).to.deep.equal([2,2])
    describe '基本五手読み先手', ->
        it 'expects Fu move [2,2] when effective move is exist', ->
            b.addMotigoma(fo, Const.FIRST);b.addMotigoma(ff, Const.FIRST)
            b.addMotigoma(so, Const.SECOND);b.addMotigoma(sf, Const.SECOND)
            b.move_capture(fo, [3,2])
            b.move_capture(so, [1,2])
            b.display()
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = first.think(b, second, 4, Const.MAX_VALUE)
            expect(ret.lastkoma.name).to.equal('Fu')
            expect(ret.lastposi).to.deep.equal([2,2])
    describe '基本六手読み先手', ->
        it 'expects Fu move [2,2] when effective move is exist', ->
            b.addMotigoma(fo, Const.FIRST);b.addMotigoma(ff, Const.FIRST)
            b.addMotigoma(so, Const.SECOND);b.addMotigoma(sf, Const.SECOND)
            b.move_capture(fo, [3,2])
            b.move_capture(so, [1,2])
            b.display()
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = first.think(b, second, 5, Const.MAX_VALUE)
            expect(ret.lastkoma.name).to.equal('Fu')
            expect(ret.lastposi).to.deep.equal([2,2])
    describe '基本七手読み先手', ->
        it 'expects Fu move [2,2] when effective move is exist', ->
            b.addMotigoma(fo, Const.FIRST);b.addMotigoma(ff, Const.FIRST)
            b.addMotigoma(so, Const.SECOND);b.addMotigoma(sf, Const.SECOND)
            # b.add(fo);b.add(ff);b.add(so);b.add(sf);
            b.move_capture(fo, [3,2])
            b.move_capture(so, [1,2])
            b.display()
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = first.think(b, second, 6, Const.MAX_VALUE)
            expect(ret.lastkoma.name).to.equal('Fu')
            expect(ret.lastposi).to.deep.equal([2,2])
    describe '基本三手読み後手', ->
        it 'expects Fu move [2,2] when effective move is exist', ->
            b.addMotigoma(fo, Const.FIRST);b.addMotigoma(ff, Const.FIRST)
            b.addMotigoma(so, Const.SECOND);b.addMotigoma(sf, Const.SECOND)
            b.move_capture(fo, [3,2])
            b.move_capture(so, [1,2])
            b.display()
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = second.think(b, first, 2, Const.MIN_VALUE)
            expect(ret.lastkoma.name).to.equal('Fu')
            expect(ret.lastposi).to.deep.equal([2,2])
    describe '基本四手読み後手', ->
        it 'expects Fu move [2,2] when effective move is exist', ->
            b.addMotigoma(fo, Const.FIRST);b.addMotigoma(ff, Const.FIRST)
            b.addMotigoma(so, Const.SECOND);b.addMotigoma(sf, Const.SECOND)
            b.move_capture(fo, [3,2])
            b.move_capture(so, [1,2])
            b.display()
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = second.think(b, first, 3, Const.MIN_VALUE)
            expect(ret.lastkoma.name).to.equal('Fu')
            expect(ret.lastposi).to.deep.equal([2,1])
    describe '基本五手読み後手', ->
        it 'expects Fu move [2,2] when effective move is exist', ->
            b.addMotigoma(fo, Const.FIRST);b.addMotigoma(ff, Const.FIRST)
            b.addMotigoma(so, Const.SECOND);b.addMotigoma(sf, Const.SECOND)
            b.move_capture(fo, [3,2])
            b.move_capture(so, [1,2])
            b.display()
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = second.think(b, first, 4, Const.MIN_VALUE)
            expect(ret.lastkoma.name).to.equal('Fu')
            expect(ret.lastposi).to.deep.equal([2,2])
    describe '基本六手読み後手', ->
        it 'expects Fu move [2,2] when effective move is exist', ->
            b.addMotigoma(fo, Const.FIRST);b.addMotigoma(ff, Const.FIRST)
            b.addMotigoma(so, Const.SECOND);b.addMotigoma(sf, Const.SECOND)
            b.move_capture(fo, [3,2])
            b.move_capture(so, [1,2])
            b.display()
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = second.think(b, first, 5, Const.MIN_VALUE)
            expect(ret.lastkoma.name).to.equal('Fu')
            expect(ret.lastposi).to.deep.equal([2,2])
    describe '基本七手読み後手', ->
        it 'expects Fu move [2,2] when effective move is exist', ->
            b.addMotigoma(fo, Const.FIRST);b.addMotigoma(ff, Const.FIRST)
            b.addMotigoma(so, Const.SECOND);b.addMotigoma(sf, Const.SECOND)
            b.move_capture(fo, [3,2])
            b.move_capture(so, [1,2])
            b.display()
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = second.think(b, first, 6, Const.MIN_VALUE)
            expect(ret.lastkoma.name).to.equal('Fu')
            expect(ret.lastposi).to.deep.equal([2,2])
    afterEach ->
        console.log(ret)
        if ret.lastkoma?
            check = b.check_move(ret.lastkoma, ret.lastposi)
            if check[0]
                b.move_capture(ret.lastkoma, ret.lastposi, check[1])
        else
            console.log("AI resigned.")
        b.display()

describe 'Fu Tesuji1', ->
    b = null
    ff = null; fy = null; fk = null; fg = null; fx = null; fm = null; fh = null; fo = null;
    sf = null; sy = null; sk = null; sg = null; sx = null; sm = null; sh = null; so = null;
    first = null; second = null;
    ret = []
    before ->
        first = new Player(Const.FIRST, false)
        second = new Player(Const.SECOND, false)
    beforeEach ->
        b = new Board()
        b.pieces = []
        fo = new Piece.Ou(Const.FIRST, Const.Status.MOTIGOMA)
        fh = new Piece.Hi(Const.FIRST, Const.Status.MOTIGOMA)
        fm = new Piece.Ka(Const.FIRST, Const.Status.MOTIGOMA)
        fx = new Piece.Ki(Const.FIRST, Const.Status.MOTIGOMA)
        fg = new Piece.Gi(Const.FIRST, Const.Status.MOTIGOMA)
        fk = new Piece.Ke(Const.FIRST, Const.Status.MOTIGOMA)
        fy = new Piece.Ky(Const.FIRST, Const.Status.MOTIGOMA)
        ff = new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA)
        so = new Piece.Ou(Const.SECOND, Const.Status.MOTIGOMA)
        sh = new Piece.Hi(Const.SECOND, Const.Status.MOTIGOMA)
        sm = new Piece.Ka(Const.SECOND, Const.Status.MOTIGOMA)
        sx = new Piece.Ki(Const.SECOND, Const.Status.MOTIGOMA)
        sg = new Piece.Gi(Const.SECOND, Const.Status.MOTIGOMA)
        sk = new Piece.Ke(Const.SECOND, Const.Status.MOTIGOMA)
        sy = new Piece.Ky(Const.SECOND, Const.Status.MOTIGOMA)
        sf = new Piece.Fu(Const.SECOND, Const.Status.MOTIGOMA)

    describe '二つの持ち歩先手 depth3 step1', ->
        it 'expects Fu move [2,2] when effective move is exist', ->
            b.addMotigoma(fo, Const.FIRST);b.addMotigoma(ff, Const.FIRST)
            b.addMotigoma(so, Const.SECOND)
            b.addMotigoma(sf, Const.FIRST)
            b.addMotigoma(sh, Const.SECOND)
            b.move_capture(fo, [2,3])
            b.move_capture(so, [2,1])
            # sf.turn = Const.FIRST
            first.depth = 3; second.depth = 3
            b.display()
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = first.think(b, second, first.depth, Const.MAX_VALUE)
            expect(ret.lastkoma.name).to.equal('Fu')
            expect(ret.lastposi).to.deep.equal([2,2])
    describe '二つの持ち歩先手 depth3 step2', ->
        it 'expects Fu move [3,2] when effective move is exist', ->
            b.addMotigoma(fo, Const.FIRST);b.addMotigoma(ff, Const.FIRST)
            b.addMotigoma(so, Const.SECOND)
            b.addMotigoma(sf, Const.FIRST)
            b.addMotigoma(sh, Const.SECOND)
            b.move_capture(fo, [2,3])
            b.move_capture(so, [1,1])
            b.move_capture(ff, [2,2])
            # sf.turn = Const.FIRST
            first.depth = 3; second.depth = 3
            b.display()
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = first.think(b, second, first.depth, Const.MAX_VALUE)
            expect(ret.lastkoma.name).to.equal('Fu')
            expect(ret.lastposi).to.deep.equal([3,2])
    describe '二つの持ち歩先手 depth4 step1', ->
        it 'expects Fu move [2,2] when effective move is exist', ->
            b.addMotigoma(fo, Const.FIRST);b.addMotigoma(ff, Const.FIRST)
            b.addMotigoma(so, Const.SECOND)
            b.addMotigoma(sf, Const.FIRST)
            b.addMotigoma(sh, Const.SECOND)
            b.move_capture(fo, [2,3])
            b.move_capture(so, [2,1])
            # sf.turn = Const.FIRST
            first.depth = 4; second.depth = 4
            b.display()
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = first.think(b, second, first.depth, Const.MAX_VALUE)
            expect(ret.lastkoma.name).to.equal('Fu')
            expect(ret.lastposi).to.deep.equal([2,2])
    describe '二つの持ち歩先手 depth4 step2', ->
        it 'expects Fu move [1,3] when effective move is exist', ->
            b.addMotigoma(fo, Const.FIRST);b.addMotigoma(ff, Const.FIRST)
            b.addMotigoma(so, Const.SECOND)
            b.addMotigoma(sf, Const.FIRST)
            b.addMotigoma(sh, Const.SECOND)
            b.move_capture(fo, [2,3])
            b.move_capture(so, [1,1])
            b.move_capture(ff, [2,2])
            # sf.turn = Const.FIRST
            first.depth = 4; second.depth = 4
            b.display()
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = first.think(b, second, first.depth, Const.MAX_VALUE)
            expect(ret.lastkoma.name).to.equal('Fu')
            expect(ret.lastposi).to.deep.equal([1,3])
    describe '二つの持ち歩後手 depth3 step1', ->
        it 'expects Fu move [2,2] when effective move is exist', ->
            b.addMotigoma(fo, Const.FIRST)
            b.addMotigoma(ff, Const.SECOND)
            b.addMotigoma(so, Const.SECOND)
            b.addMotigoma(sf, Const.SECOND)
            b.addMotigoma(fh, Const.FIRST)
            b.move_capture(fo, [2,3])
            b.move_capture(so, [2,1])
            # ff.turn = Const.SECOND
            first.depth = 3; second.depth = 3
            b.display()
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = second.think(b, first, second.depth, Const.MIN_VALUE)
            expect(ret.lastkoma.name).to.equal('Fu')
            expect(ret.lastposi).to.deep.equal([2,2])
    describe '二つの持ち歩後手 depth3 step2', ->
        it 'expects Fu move [3,2] when effective move is exist', ->
            b.addMotigoma(fo, Const.FIRST)
            b.addMotigoma(ff, Const.SECOND)
            b.addMotigoma(so, Const.SECOND)
            b.addMotigoma(sf, Const.SECOND)
            b.addMotigoma(fh, Const.FIRST)
            b.move_capture(fo, [1,3])
            b.move_capture(so, [2,1])
            b.move_capture(ff, [2,2])
            # ff.turn = Const.SECOND
            first.depth = 3; second.depth = 3
            b.display()
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = second.think(b, first, second.depth, Const.MIN_VALUE)
            expect(ret.lastkoma.name).to.equal('Fu')
            expect(ret.lastposi).to.deep.equal([3,2])
    describe '二つの持ち歩後手 depth4 step1', ->
        it 'expects Fu move [2,2] when effective move is exist', ->
            b.addMotigoma(fo, Const.FIRST)
            b.addMotigoma(ff, Const.SECOND)
            b.addMotigoma(so, Const.SECOND)
            b.addMotigoma(sf, Const.SECOND)
            b.addMotigoma(fh, Const.FIRST)
            b.move_capture(fo, [2,3])
            b.move_capture(so, [2,1])
            # ff.turn = Const.SECOND
            first.depth = 4; second.depth = 4
            b.display()
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = second.think(b, first, second.depth, Const.MIN_VALUE)
            expect(ret.lastkoma.name).to.equal('Fu')
            expect(ret.lastposi).to.deep.equal([2,2])
    describe '二つの持ち歩後手 depth4 step2', ->
        it 'expects Fu move [1,1] when effective move is exist', ->
            b.addMotigoma(fo, Const.FIRST)
            b.addMotigoma(ff, Const.SECOND)
            b.addMotigoma(so, Const.SECOND)
            b.addMotigoma(sf, Const.SECOND)
            b.addMotigoma(fh, Const.FIRST)
            b.move_capture(fo, [1,3])
            b.move_capture(so, [2,1])
            b.move_capture(ff, [2,2])
            # ff.turn = Const.SECOND
            first.depth = 4; second.depth = 4
            b.display()
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = second.think(b, first, second.depth, Const.MIN_VALUE)
            expect(ret.lastkoma.name).to.equal('Fu')
            expect(ret.lastposi).to.deep.equal([1,1])
    afterEach ->
        console.log(ret)
        if ret.lastkoma?
            check = b.check_move(ret.lastkoma, ret.lastposi)
            if check[0]
                b.move_capture(ret.lastkoma, ret.lastposi, check[1])
        else
            console.log("AI resigned.")
        b.display()
describe 'Fu Tesuji1-2', ->
    b = null
    ff = null; fy = null; fk = null; fg = null; fx = null; fm = null; fh = null; fo = null;
    sf = null; sy = null; sk = null; sg = null; sx = null; sm = null; sh = null; so = null;
    first = null; second = null;
    ret = []
    before ->
        first = new Player(Const.FIRST, false)
        second = new Player(Const.SECOND, false)
    beforeEach ->
        b = new Board()
        b.pieces = []
        fo = new Piece.Ou(Const.FIRST, Const.Status.MOTIGOMA)
        fh = new Piece.Hi(Const.FIRST, Const.Status.MOTIGOMA)
        fm = new Piece.Ka(Const.FIRST, Const.Status.MOTIGOMA)
        fx = new Piece.Ki(Const.FIRST, Const.Status.MOTIGOMA)
        fg = new Piece.Gi(Const.FIRST, Const.Status.MOTIGOMA)
        fk = new Piece.Ke(Const.FIRST, Const.Status.MOTIGOMA)
        fy = new Piece.Ky(Const.FIRST, Const.Status.MOTIGOMA)
        ff = new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA)
        so = new Piece.Ou(Const.SECOND, Const.Status.MOTIGOMA)
        sh = new Piece.Hi(Const.SECOND, Const.Status.MOTIGOMA)
        sm = new Piece.Ka(Const.SECOND, Const.Status.MOTIGOMA)
        sx = new Piece.Ki(Const.SECOND, Const.Status.MOTIGOMA)
        sg = new Piece.Gi(Const.SECOND, Const.Status.MOTIGOMA)
        sk = new Piece.Ke(Const.SECOND, Const.Status.MOTIGOMA)
        sy = new Piece.Ky(Const.SECOND, Const.Status.MOTIGOMA)
        sf = new Piece.Fu(Const.SECOND, Const.Status.MOTIGOMA)

    describe '二つの持ち歩先手 depth3 step2', ->
        it 'expects Fu move [3,2] when effective move is exist', ->
            b.addMotigoma(fo, Const.FIRST);b.addMotigoma(ff, Const.FIRST)
            b.addMotigoma(so, Const.SECOND)
            b.addMotigoma(sf, Const.FIRST)
            b.addMotigoma(sh, Const.SECOND)
            b.move_capture(fo, [2,3])
            b.move_capture(so, [1,1])
            b.move_capture(ff, [2,2])
            # sf.turn = Const.FIRST
            first.depth = 3; second.depth = 3
            b.display()
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = first.think(b, second, first.depth, Const.MAX_VALUE)
            console.log("b = #{JSON.stringify(b)}")
            console.log("motigoma[FIRST] = #{JSON.stringify(b.motigoma[Const.FIRST])}")
            console.log("motigoma[SECOND] = #{JSON.stringify(b.motigoma[Const.SECOND])}")
            console.log("pieceIndex = #{JSON.stringify(b.pieceIndex)}")
            console.log("ret = #{JSON.stringify(ret)}")
            expect(ret.lastkoma.name).to.equal('Fu')
            expect(ret.lastposi).to.deep.equal([3,2])
    afterEach ->
        console.log(ret)
        console.log("ret2 = #{JSON.stringify(ret)}")
        if ret.lastkoma?
            check = b.check_move(ret.lastkoma, ret.lastposi)
            console.log("check = #{check}")
            if check[0]
                b.move_capture(ret.lastkoma, ret.lastposi, check[1])
        else
            console.log("AI resigned.")
        b.display()
describe 'Fu Tesuji1-3', ->
    b = null
    ff = null; fy = null; fk = null; fg = null; fx = null; fm = null; fh = null; fo = null;
    sf = null; sy = null; sk = null; sg = null; sx = null; sm = null; sh = null; so = null;
    first = null; second = null;
    ret = []
    before ->
        first = new Player(Const.FIRST, false)
        second = new Player(Const.SECOND, false)
    beforeEach ->
        b = new Board()
        b.pieces = []
        fo = new Piece.Ou(Const.FIRST, Const.Status.MOTIGOMA)
        fh = new Piece.Hi(Const.FIRST, Const.Status.MOTIGOMA)
        fm = new Piece.Ka(Const.FIRST, Const.Status.MOTIGOMA)
        fx = new Piece.Ki(Const.FIRST, Const.Status.MOTIGOMA)
        fg = new Piece.Gi(Const.FIRST, Const.Status.MOTIGOMA)
        fk = new Piece.Ke(Const.FIRST, Const.Status.MOTIGOMA)
        fy = new Piece.Ky(Const.FIRST, Const.Status.MOTIGOMA)
        ff = new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA)
        so = new Piece.Ou(Const.SECOND, Const.Status.MOTIGOMA)
        sh = new Piece.Hi(Const.SECOND, Const.Status.MOTIGOMA)
        sm = new Piece.Ka(Const.SECOND, Const.Status.MOTIGOMA)
        sx = new Piece.Ki(Const.SECOND, Const.Status.MOTIGOMA)
        sg = new Piece.Gi(Const.SECOND, Const.Status.MOTIGOMA)
        sk = new Piece.Ke(Const.SECOND, Const.Status.MOTIGOMA)
        sy = new Piece.Ky(Const.SECOND, Const.Status.MOTIGOMA)
        sf = new Piece.Fu(Const.SECOND, Const.Status.MOTIGOMA)

    describe '二つの持ち歩先手 depth4 step1', ->
        it 'expects Fu move [2,2] when effective move is exist', ->
            b.addMotigoma(fo, Const.FIRST);b.addMotigoma(ff, Const.FIRST)
            b.addMotigoma(so, Const.SECOND)
            b.addMotigoma(sf, Const.FIRST)
            b.addMotigoma(sh, Const.SECOND)
            b.move_capture(fo, [2,3])
            b.move_capture(so, [2,1])
            first.depth = 4; second.depth = 4
            b.display()
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = first.think(b, second, first.depth, Const.MAX_VALUE)
            console.log("b = #{JSON.stringify(b)}")
            console.log("motigoma[FIRST] = #{JSON.stringify(b.motigoma[Const.FIRST])}")
            console.log("motigoma[SECOND] = #{JSON.stringify(b.motigoma[Const.SECOND])}")
            console.log("pieceIndex = #{JSON.stringify(b.pieceIndex)}")
            console.log("ret = #{JSON.stringify(ret)}")
            expect(ret.lastkoma.name).to.equal('Fu')
            expect(ret.lastposi).to.deep.equal([2,2])
    afterEach ->
        console.log(ret)
        if ret.lastkoma?
            check = b.check_move(ret.lastkoma, ret.lastposi)
            if check[0]
                b.move_capture(ret.lastkoma, ret.lastposi, check[1])
        else
            console.log("AI resigned.")
        b.display()

describe 'tumi Tesuji', ->
    b = null
    ff = null; fy = null; fk = null; fg = null; fx = null; fm = null; fh = null; fo = null;
    sf = null; sy = null; sk = null; sg = null; sx = null; sm = null; sh = null; so = null;
    first = null; second = null;
    ret = []
    before ->
        first = new Player(Const.FIRST, false)
        second = new Player(Const.SECOND, false)
    beforeEach ->
        b = new Board()
        b.pieces = []
        fo = new Piece.Ou(Const.FIRST, Const.Status.MOTIGOMA)
        fh = new Piece.Hi(Const.FIRST, Const.Status.MOTIGOMA)
        fm = new Piece.Ka(Const.FIRST, Const.Status.MOTIGOMA)
        fx = new Piece.Ki(Const.FIRST, Const.Status.MOTIGOMA)
        fg = new Piece.Gi(Const.FIRST, Const.Status.MOTIGOMA)
        fk = new Piece.Ke(Const.FIRST, Const.Status.MOTIGOMA)
        fy = new Piece.Ky(Const.FIRST, Const.Status.MOTIGOMA)
        ff = new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA)
        so = new Piece.Ou(Const.SECOND, Const.Status.MOTIGOMA)
        sh = new Piece.Hi(Const.SECOND, Const.Status.MOTIGOMA)
        sm = new Piece.Ka(Const.SECOND, Const.Status.MOTIGOMA)
        sx = new Piece.Ki(Const.SECOND, Const.Status.MOTIGOMA)
        sg = new Piece.Gi(Const.SECOND, Const.Status.MOTIGOMA)
        sk = new Piece.Ke(Const.SECOND, Const.Status.MOTIGOMA)
        sy = new Piece.Ky(Const.SECOND, Const.Status.MOTIGOMA)
        sf = new Piece.Fu(Const.SECOND, Const.Status.MOTIGOMA)

    describe '歩と香先手 depth3 step1', ->
        it 'expects Fu move [2,2] when effective move is exist', ->
            b.add(fo);b.add(ff);b.add(so);b.add(sf);b.add(fy)
            b.move_capture(fo, [2,3])
            b.move_capture(so, [2,1])
            first.depth = 3; second.depth = 3
            b.display()
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = first.think(b, second, first.depth, Const.MAX_VALUE)
            expect(ret[0].name).to.equal('Fu')
            expect(ret[1]).to.deep.equal([2,2])
    describe '歩と香先手 depth3 step2', ->
        it 'expects Fu move [1,2] when effective move is exist', ->
            b.add(fo);b.add(ff);b.add(so);b.add(sf);b.add(fy)
            b.move_capture(fo, [2,3])
            b.move_capture(so, [1,1])
            b.move_capture(ff, [2,2])
            first.depth = 3; second.depth = 3
            b.display()
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = first.think(b, second, first.depth, Const.MAX_VALUE)
            expect(ret[0].name).to.equal('Ky')
            expect(ret[1]).to.deep.equal([1,2])
    describe '歩と香後手 depth4 step1', ->
        it 'expects Fu move [2,2] when effective move is exist', ->
            b.add(fo);b.add(ff);b.add(so);b.add(sf);b.add(sy)
            b.move_capture(fo, [2,3])
            b.move_capture(so, [2,1])
            first.depth = 4; second.depth = 4
            b.display()
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = second.think(b, first, second.depth, Const.MIN_VALUE)
            expect(ret[0].name).to.equal('Fu')
            expect(ret[1]).to.deep.equal([2,2])
    describe '歩と香後手 depth4 step2', ->
        it 'expects Fu move [3,1] when effective move is exist', ->
            b.add(fo);b.add(ff);b.add(so);b.add(sf);b.add(sy)
            b.move_capture(fo, [3,3])
            b.move_capture(so, [2,1])
            b.move_capture(sf, [2,2])
            first.depth = 4; second.depth = 4
            b.display()
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = second.think(b, first, second.depth, Const.MIN_VALUE)
            expect(ret[0].name).to.equal('Ky')
            expect(ret[1]).to.deep.equal([3,1])
    describe '歩と飛先手 depth4 step1', ->
        it 'expects Hi move [2,1] when effective move is exist', ->
            b.add(fo);b.add(so);b.add(ff);b.add(sf);b.add(fh);b.add(sh)
            b.move_capture(fo, [3,3])
            b.move_capture(so, [1,1])
            b.move_capture(fh, [2,3])
            b.move_capture(sh, [2,1])
            first.depth = 4; second.depth = 4
            b.display()
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = first.think(b, second, first.depth, Const.MAX_VALUE)
            expect(ret[0].name).to.equal('Hi')
            expect(ret[1]).to.deep.equal([2,1])
    describe '歩と飛先手 depth7 step2', ->
        it 'expects Hi move [2,2] when effective move is exist', ->
            b.add(fo);b.add(so);b.add(ff);b.add(sf);b.add(fh);b.add(sh)
            b.move_capture(fo, [3,3])
            b.move_capture(so, [2,1])
            first.depth = 7; second.depth = 7
            b.display()
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = first.think(b, second, first.depth, Const.MAX_VALUE)
            expect(ret[0].name).to.equal('Hi')
            expect(ret[1]).to.deep.equal([2,2])
    describe '歩と飛先手 depth7 step3', ->
        it 'expects Ou move [2,3] when effective move is exist', ->
            b.add(fo);b.add(so);b.add(ff);b.add(sf);b.add(fh);b.add(sh)
            b.move_capture(fo, [3,3])
            b.move_capture(so, [3,1])
            b.move_capture(fh, [2,2])            
            first.depth = 7; second.depth = 7
            b.display()
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = first.think(b, second, first.depth, Const.MAX_VALUE)
            expect(ret[0].name).to.equal('Ou')
            expect(ret[1]).to.deep.equal([2,3])
    describe '歩と飛先手 depth7 step4', ->
        it 'expects Fu move [3,3] when effective move is exist', ->
            b.add(fo);b.add(so);b.add(ff);b.add(sf);b.add(fh);b.add(sh)
            b.move_capture(fo, [2,3])
            b.move_capture(so, [3,1])
            b.move_capture(fh, [2,2])
            b.move_capture(sh, [1,1])                        
            first.depth = 4; second.depth = 4
            b.display()
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = first.think(b, second, first.depth, Const.MAX_VALUE)
            expect(ret[0].name).to.equal('Fu')
            expect(ret[1]).to.deep.equal([3,3])
    describe '歩と飛後手 depth4 step1', ->
        it 'expects Hi move [2,3] when effective move is exist', ->
            b.add(fo);b.add(so);b.add(ff);b.add(sf);b.add(fh);b.add(sh)
            b.move_capture(fo, [3,3])
            b.move_capture(so, [1,1])
            b.move_capture(fh, [2,3])
            b.move_capture(sh, [2,1])
            first.depth = 4; second.depth = 4
            b.display()
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = second.think(b, first, second.depth, Const.MIN_VALUE)
            expect(ret[0].name).to.equal('Hi')
            expect(ret[1]).to.deep.equal([2,3])
    describe '歩と飛後手 depth7 step2', ->
        it 'expects Hi move [2,2] when effective move is exist', ->
            b.add(fo);b.add(so);b.add(ff);b.add(sf);b.add(fh);b.add(sh)
            b.move_capture(fo, [2,3])
            b.move_capture(so, [1,1])
            first.depth = 7; second.depth = 7
            b.display()
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = second.think(b, first, second.depth, Const.MIN_VALUE)
            expect(ret[0].name).to.equal('Hi')
            expect(ret[1]).to.deep.equal([2,2])
    describe '歩と飛後手 depth7 step3', ->
        it 'expects Ou move [2,1] when effective move is exist', ->
            b.add(fo);b.add(so);b.add(ff);b.add(sf);b.add(fh);b.add(sh)
            b.move_capture(fo, [1,3])
            b.move_capture(so, [1,1])
            b.move_capture(sh, [2,2])            
            first.depth = 7; second.depth = 7
            b.display()
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = second.think(b, first, second.depth, Const.MIN_VALUE)
            expect(ret[0].name).to.equal('Ou')
            expect(ret[1]).to.deep.equal([2,1])
    describe '歩と飛後手 depth6 step4', ->
        it 'expects Fu move [1,1] when effective move is exist', ->
            b.add(fo);b.add(so);b.add(ff);b.add(sf);b.add(fh);b.add(sh)
            b.move_capture(fo, [1,3])
            b.move_capture(so, [2,1])
            b.move_capture(sh, [2,2])
            b.move_capture(fh, [3,3])                        
            first.depth = 4; second.depth = 4
            b.display()
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = second.think(b, first, second.depth, Const.MIN_VALUE)
            expect(ret[0].name).to.equal('Fu')
            expect(ret[1]).to.deep.equal([1,1])
    afterEach ->
        console.log(ret)
        if ret[0]?
            if b.check_move(ret[0], ret[1])
                b.move_capture(ret[0], ret[1])
                ret[0].status = Const.Status.URA if ret[3]
        else
            console.log("AI resigned.")
        b.display()
