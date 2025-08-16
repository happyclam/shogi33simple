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
    ret = []
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
            b.add(fo);b.add(fg);b.add(ff);b.add(so);b.add(sg);b.add(sf)
            b.move_capture(fo, [3,3])
            b.move_capture(fg, [2,3])
            b.move_capture(ff, [1,3])
            b.move_capture(so, [3,1])
            b.move_capture(sg, [2,1])
            b.move_capture(sf, [1,1])
            b.display()
            first.pre_ahead = 0; second.pre_ahead = 0            
            ret = first.think(b, second, 3, Const.MAX_VALUE)
            expect(ret[0].kind()).to.equal('Fu')
            expect(ret[1]).to.deep.equal([1,2])
    describe '桂香テスト', ->
        it 'expects Ky move [3,1] when tumi is exist', ->
            b.add(sy);b.add(so);b.add(sk);b.add(fo);
            b.move_capture(fo, [2,3])
            b.move_capture(so, [1,1])
            b.move_capture(sk, [2,1])
            b.move_capture(sy, [3,1])
            b.display()
            second.depth = 5; first.depth = 5
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = second.think(b, first, second.depth, Const.MIN_VALUE)
            expect(ret[2]).to.be.below(-9999)
            # expect(ret[0].kind()).to.equal('Ky')
            expect(ret[1]).to.deep.equal([3,3])
    describe '角香テスト', ->
        it 'expects Ky move [1,1] when tumi is exist', ->
            b.add(fm);b.add(so);b.add(fy);b.add(fo);b.add(sf);
            b.move_capture(so, [2,1])
            b.move_capture(sf, [3,1])
            b.move_capture(fo, [2,3])
            b.move_capture(fm, [3,3])
            b.move_capture(fy, [1,3])
            b.display()
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = first.think(b, second, 2, Const.MAX_VALUE)
            expect(ret[2]).to.be.above(9999)
            expect(ret[1]).to.deep.equal([1,1])
    describe '初級3-1', ->
        it 'expects Fu move [2,2] when tumi is exist', ->
            b.add(fo);b.add(fy);b.add(ff);b.add(so);b.add(sx);
            b.move_capture(fo, [2,3])
            b.move_capture(so, [2,1])
            b.display()
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = first.think(b, second, 3, Const.MAX_VALUE)
            expect(ret[1]).to.deep.equal([2,2])
    describe '初級3-2', ->
        it 'expects Hi move [2,1] when tumi is exist', ->
            b.add(fo);b.add(fh);b.add(ff);b.add(so);b.add(sh);b.add(sf);
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
            expect(ret[0].kind()).to.equal('Hi')
            expect(ret[1]).to.deep.equal([2,1])
            expect(ret[2]).to.be.above(9999)
    describe '初級4-1', ->
        it 'expects Fu move [2,2] when effective move is exist', ->
            b.add(fo);b.add(ff);b.add(so);b.add(sf);
            b.move_capture(fo, [3,2])
            b.move_capture(so, [1,2])
            b.display()
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = first.think(b, second, 3, Const.MAX_VALUE)
            expect(ret[0].kind()).to.equal('Fu')
            expect(ret[1]).to.deep.equal([2,2])
    afterEach ->
        console.log(ret)
        if ret[0]?
            if b.check_move(ret[0], ret[1])
                b.move_capture(ret[0], ret[1])
                ret[0].status = Const.Status.URA if ret[3]
        else
            console.log("AI resigned.")
        b.display()

describe '--- tyukyu', ->
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
            b.add(fo);b.add(fx);b.add(so);b.add(sx);b.add(sf);b.add(ff)
            b.move_capture(fo, [3,3])
            b.move_capture(so, [1,1])
            b.move_capture(sf, [2,2])
            b.display()
            first.depth = 5; second.depth = 5
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = first.think(b, second, first.depth, Const.MAX_VALUE)
            expect(ret[0].kind()).to.equal('Ki')
            expect(ret[1]).to.deep.equal([1,3])
    describe '中級3-2', ->
        it 'expects Ou move [1,2]', ->
            b.add(fo);b.add(fh);b.add(so);b.add(sx);b.add(sf)
            b.move_capture(fo, [3,3])
            b.move_capture(so, [1,1])
            b.move_capture(sf, [2,2])
            b.move_capture(fh, [3,1])
            b.display()
            second.depth = 7; first.depth = 7
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = second.think(b, first, second.depth, Const.MAX_VALUE)
            expect(ret[0].kind()).to.equal('Ou')
            expect(ret[1]).to.deep.equal([1,2])
    describe '中級3-1', ->
        it 'expects Ou move [2,1] when effective move is exist', ->
            b.add(fo);b.add(fy);b.add(so);b.add(sk);
            b.move_capture(fo, [3,3])
            b.move_capture(fy, [1,3])
            b.move_capture(so, [1,1])
            b.display()
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = second.think(b, first, 3, Const.MIN_VALUE)
            expect(ret[0].kind()).to.equal('Ou')
            expect(ret[1]).to.deep.equal([2,1])
    describe '中級4', ->
        it 'expects Hi move [2,2]', ->
            b.add(fo);b.add(fh);b.add(so);b.add(sh);
            b.move_capture(fo, [2,3])
            b.move_capture(so, [2,1])
            b.display()
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = first.think(b, second, 3, Const.MAX_VALUE)
            expect(ret[0].kind()).to.equal('Hi')
            expect(ret[1]).to.deep.equal([2,2])
    describe '上級1-2', ->
        it 'expects Ou move [1,2] when effective move is exist', ->
            b.add(fo);b.add(fk);b.add(so);b.add(sf);
            b.move_capture(fo, [2,3])
            b.move_capture(fk, [3,3])
            b.move_capture(so, [3,1])
            b.display()
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = first.think(b, second, 3, Const.MAX_VALUE)
            expect(ret[0].kind()).to.equal('Ou')
            expect(ret[1]).to.deep.equal([1,2])
    # describe '上級1-3', ->
    #     it 'expects Ka move [1,1] when effective move is exist', ->
    #         b.add(fo);b.add(fm);b.add(ff);b.add(so);b.add(sm);b.add(sf);
    #         b.move_capture(fo, [2,3])
    #         b.move_capture(so, [3,1])
    #         b.display()
    #         first.depth = 5
    #         ret = first.think(b, second, 5, Const.MIN_VALUE)
    #         expect(ret[0].kind()).to.equal('Ka')
    #         expect(ret[1]).to.deep.equal([1,1])
    afterEach ->
        console.log(ret)
        if ret[0]?
            if b.check_move(ret[0], ret[1])
                b.move_capture(ret[0], ret[1])
                ret[0].status = Const.Status.URA if ret[3]
        else
            console.log("AI resigned.")
        b.display()
