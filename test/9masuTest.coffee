chai = require 'chai'
expect = chai.expect
chai.should()
Const = require('../const.coffee')
Piece = require('../piece.coffee')
Board = require('../board.coffee')
Player = require('../player.coffee')

describe '--- syokyu', ->
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

    describe '初級2', ->
        it 'expects Fu move [1,2]', ->
            b.addMotigoma(fo, Const.FIRST);b.addMotigoma(fg, Const.FIRST)
            b.addMotigoma(ff, Const.FIRST);b.addMotigoma(so, Const.SECOND)
            b.addMotigoma(sg, Const.SECOND);b.addMotigoma(sf, Const.SECOND)
            b.move_capture(fo, [3,3])
            b.move_capture(fg, [2,3])
            b.move_capture(ff, [1,3])
            b.move_capture(so, [3,1])
            b.move_capture(sg, [2,1])
            b.move_capture(sf, [1,1])
            b.display()
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = first.think(b, second, 3, Const.MAX_VALUE)
            expect(ret.lastkoma.name).to.equal('Fu')
            expect(ret.lastposi).to.deep.equal([1,2])
    describe '桂香テスト', ->
        it 'expects Ky move [3,1] when tumi is exist', ->
            b.addMotigoma(sy, Const.SECOND);b.addMotigoma(so, Const.SECOND)
            b.addMotigoma(sk, Const.SECOND);b.addMotigoma(fo, Const.FIRST);
            b.move_capture(fo, [2,3])
            b.move_capture(so, [1,1])
            b.move_capture(sk, [2,1])
            b.move_capture(sy, [3,1])
            b.display()
            second.depth = 3; first.depth = 3
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = second.think(b, first, second.depth, Const.MIN_VALUE)
            expect(ret.lastscore).to.be.below(-9999)
            expect(ret.lastkoma.name).to.equal('Ky')
            expect(ret.lastposi).to.deep.equal([3,3])
    describe '角香テスト', ->
        it 'expects Ky move [1,1] when tumi is exist', ->
            b.addMotigoma(fm, Const.FIRST);b.addMotigoma(so, Const.SECOND)
            b.addMotigoma(fy, Const.FIRST);b.addMotigoma(fo, Const.FIRST)
            b.addMotigoma(sf, Const.SECOND)
            b.move_capture(so, [2,1])
            b.move_capture(sf, [3,1])
            b.move_capture(fo, [2,3])
            b.move_capture(fm, [3,3])
            b.move_capture(fy, [1,3])
            b.display()
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = first.think(b, second, 2, Const.MAX_VALUE)
            expect(ret.lastscore).to.be.above(9999)
            expect(ret.lastposi).to.deep.equal([1,1])
    describe '初級3-1', ->
        it 'expects Fu move [2,2] when tumi is exist', ->
            b.addMotigoma(fo, Const.FIRST);b.addMotigoma(fy, Const.FIRST)
            b.addMotigoma(ff, Const.FIRST);b.addMotigoma(so, Const.SECOND)
            b.addMotigoma(sx, Const.SECOND);
            b.move_capture(fo, [2,3])
            b.move_capture(so, [2,1])
            b.display()
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = first.think(b, second, 3, Const.MAX_VALUE)
            expect(ret.lastposi).to.deep.equal([2,2])
    describe '初級3-2', ->
        it 'expects Hi move [2,1] when tumi is exist', ->
            b.addMotigoma(fo, Const.FIRST);b.addMotigoma(fh, Const.FIRST)
            b.addMotigoma(ff, Const.FIRST);b.addMotigoma(so, Const.SECOND)
            b.addMotigoma(sh, Const.SECOND);b.addMotigoma(sf, Const.SECOND)
            b.move_capture(fo, [3,3])
            b.move_capture(fh, [2,3])
            b.move_capture(ff, [1,3])
            b.move_capture(so, [1,1])
            b.move_capture(sh, [2,1])
            b.move_capture(sf, [3,1])
            b.display()
            first.depth = 6; second.depth = 6
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = first.think(b, second, first.depth, Const.MAX_VALUE)
            expect(ret.lastkoma.name).to.equal('Hi')
            expect(ret.lastposi).to.deep.equal([2,1])
            expect(ret.lastscore).to.be.above(9999)
    describe '初級4-1', ->
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
    afterEach ->
        console.log(ret)
        if ret.lastkoma?
            check = b.check_move(ret.lastkoma, ret.lastposi)
            nari = if (check[1] || ret.laststatus == Const.Status.URA) then true else false
            if check[0]
                b.move_capture(ret.lastkoma, ret.lastposi, nari)
        else
            console.log("AI resigned.")
        b.display()

describe '--- tyukyu', ->
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

    describe '中級1', ->
        it 'expects Ki move [1,3]', ->
            b.addMotigoma(fo, Const.FIRST);b.addMotigoma(fx, Const.FIRST)
            b.addMotigoma(so, Const.SECOND);b.addMotigoma(sx, Const.SECOND)
            b.addMotigoma(sf, Const.SECOND);b.addMotigoma(ff, Const.FIRST)
            b.move_capture(fo, [3,3])
            b.move_capture(so, [1,1])
            b.move_capture(sf, [2,2])
            b.display()
            first.depth = 5; second.depth = 5
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = first.think(b, second, first.depth, Const.MAX_VALUE)
            expect(ret.lastkoma.name).to.equal('Ki')
            expect(ret.lastposi).to.deep.equal([1,3])
    describe '中級3-2', ->
        it 'expects Ou move [1,2]', ->
            b.addMotigoma(fo, Const.FIRST);b.addMotigoma(fh, Const.FIRST)
            b.addMotigoma(so, Const.SECOND);b.addMotigoma(sx, Const.SECOND)
            b.addMotigoma(sf, Const.SECOND)
            b.move_capture(fo, [3,3])
            b.move_capture(so, [1,1])
            b.move_capture(sf, [2,2])
            b.move_capture(fh, [3,1])
            b.display()
            second.depth = 7; first.depth = 7
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = second.think(b, first, second.depth, Const.MAX_VALUE)
            expect(ret.lastkoma.name).to.equal('Ou')
            expect(ret.lastposi).to.deep.equal([1,2])
    describe '中級3-1', ->
        it 'expects Ou move [2,1] when effective move is exist', ->
            b.addMotigoma(fo, Const.FIRST);b.addMotigoma(fy, Const.FIRST)
            b.addMotigoma(so, Const.SECOND);b.addMotigoma(sk, Const.SECOND)
            b.move_capture(fo, [3,3])
            b.move_capture(fy, [1,3])
            b.move_capture(so, [1,1])
            b.display()
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = second.think(b, first, 3, Const.MIN_VALUE)
            expect(ret.lastkoma.name).to.equal('Ou')
            expect(ret.lastposi).to.deep.equal([2,1])
    describe '中級4', ->
        it 'expects Hi move [2,2]', ->
            b.addMotigoma(fo, Const.FIRST);b.addMotigoma(fh, Const.FIRST)
            b.addMotigoma(so, Const.SECOND);b.addMotigoma(sh, Const.SECOND)
            b.move_capture(fo, [2,3])
            b.move_capture(so, [2,1])
            b.display()
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = first.think(b, second, 3, Const.MAX_VALUE)
            expect(ret.lastkoma.name).to.equal('Hi')
            expect(ret.lastposi).to.deep.equal([2,2])
    describe '上級1-2', ->
        it 'expects Ou move [1,2] when effective move is exist', ->
            b.addMotigoma(fo, Const.FIRST);b.addMotigoma(fk, Const.FIRST)
            b.addMotigoma(so, Const.SECOND);b.addMotigoma(sf, Const.SECOND)
            b.move_capture(fo, [2,3])
            b.move_capture(fk, [3,3])
            b.move_capture(so, [3,1])
            b.display()
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = first.think(b, second, 3, Const.MAX_VALUE)
            expect(ret.lastkoma.name).to.equal('Ou')
            expect(ret.lastposi).to.deep.equal([1,2])
    # describe '上級1-3', ->
    #     it 'expects Ka move [1,1] when effective move is exist', ->
    #         b.addMotigoma(fo, Const.FIRST);b.addMotigoma(fm, Const.FIRST)
    #         b.addMotigoma(ff, Const.FIRST);b.addMotigoma(so, Const.SECOND)
    #         b.addMotigoma(sm, Const.SECOND);b.addMotigoma(sf, Const.SECOND)
    #         b.move_capture(fo, [2,3])
    #         b.move_capture(so, [3,1])
    #         b.display()
    #         first.depth = 5
    #         ret = first.think(b, second, 5, Const.MIN_VALUE)
    #         expect(ret.lastkoma.name).to.equal('Ka')
    #         expect(ret.lastposi).to.deep.equal([1,1])
    afterEach ->
        console.log(ret)
        if ret.lastkoma?
            check = b.check_move(ret.lastkoma, ret.lastposi)
            nari = if (check[1] || ret.laststatus == Const.Status.URA) then true else false
            if check[0]
                b.move_capture(ret.lastkoma, ret.lastposi, nari)
        else
            console.log("AI resigned.")
        b.display()
