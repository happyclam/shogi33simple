chai = require 'chai'
expect = chai.expect
chai.should()
Const = require('../const.coffee')
Piece = require('../piece.coffee')
Board = require('../board.coffee')
Player = require('../player.coffee')

describe '--- 9masuBooks', ->
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

    describe '問い１', ->
        it 'expects Ke move [2,3]', ->
            b.add(fo);b.add(fk);b.add(sm);b.add(so);b.add(sk);b.add(sy)
            b.move_capture(fo, [3,2])
            b.move_capture(sm, [2,2])
            b.move_capture(sy, [1,2])
            b.move_capture(so, [1,1])
            b.move_capture(sk, [2,1])
            b.display()
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = first.think(b, second, 3, Const.MAX_VALUE)
            expect(ret[0].kind()).to.equal('Ke')
            expect(ret[1]).to.deep.equal([2,3])
            expect(ret[2]).to.be.above(9999)
    describe '問い２', ->
        it 'expects Fu move [2,1] when tumi is exist', ->
            b.add(ff);b.add(fm);b.add(fo);b.add(so);
            b.move_capture(fo, [3,2])
            b.move_capture(ff, [2,2])
            b.move_capture(fm, [3,3])
            b.move_capture(so, [1,1])
            b.display()
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = first.think(b, second, 5, Const.MAX_VALUE)
            expect(ret[0].kind()).to.equal('Fu')
            expect(ret[1]).to.deep.equal([2,1])
            expect(ret[2]).to.be.above(9999)
    describe 'mine01', ->
        it 'expects Uma move [2,2] when tumi is exist', ->
            b.add(ff);b.add(sm);b.add(fo);b.add(so);
            b.move_capture(fo, [3,2])
            b.move_capture(ff, [3,1])
            b.move_capture(sm, [2,3])
            b.move_capture(so, [1,3])
            sm.status = Const.Status.URA
            ff.status = Const.Status.URA
            b.display()
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = second.think(b, first, 3, Const.MIN_VALUE)
            expect(ret[0].kind()).to.equal('Ka')
            expect(ret[1]).to.deep.equal([3,2])
            expect(ret[2]).to.be.below(-9999)
    describe 'FIRST don`t miss tumi', ->
        it 'expects Gi move [2,2] when tumi is exist', ->
            b.add(ff);b.add(sf);b.add(fo);b.add(so);b.add(fg);b.add(sg);
            b.move_capture(ff, [1,3])
            b.move_capture(fo, [2,3])
            b.move_capture(so, [2,1])
            b.display()
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = first.think(b, second, 4, Const.MAX_VALUE)
            expect(ret[0].kind()).to.equal('Gi')
            expect(ret[1][0]).to.be.within(2,3)
            expect(ret[1][1]).to.equal(2)
    # describe 'mine02', ->
    #     it 'expects Ka move [2,2] when tumi is exist', ->
    #         b.add(fo);b.add(so);b.add(fm);b.add(fh);
    #         b.move_capture(fo, [1,3])
    #         b.move_capture(so, [1,1])
    #         b.display()
    #         ret = first.think(b, second, 6, Const.MAX_VALUE)
    #         expect(ret[0].kind()).to.equal('Ka')
    #         expect(ret[1]).to.deep.equal([2,2])
    describe 'mine03', ->
        it 'expects Hi move [3,1] when tumi is exist', ->
            b.add(fo);b.add(so);b.add(fm);b.add(fh);
            b.move_capture(fo, [2,3])
            b.move_capture(so, [1,1])
            b.move_capture(fh, [3,2])
            b.display()
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = first.think(b, second, 1, Const.MAX_VALUE)
            expect(ret[0].kind()).to.equal('Hi')
            expect(ret[1]).to.deep.equal([3,1])
    afterEach ->
        console.log(ret)
        if ret[0]?
            if b.check_move(ret[0], ret[1])
                b.move_capture(ret[0], ret[1])
                ret[0].status = Const.Status.URA if ret[3]
        else
            console.log("AI resigned.")
        b.display()


describe '--- utifudume', ->
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

    # describe 'FIRST move Fu because not utifudume', ->
    #     it 'expects Fu move [1,2] is judged utifudume', ->
    #         b.add(fo);b.add(so);b.add(fm);b.add(fh);b.add(sm);b.add(sh);b.add(ff);b.add(sf);
    #         b.move_capture(so, [1,1])
    #         b.move_capture(fo, [3,3])
    #         b.move_capture(fh, [3,1])
    #         b.move_capture(sh, [1,3])
    #         b.move_capture(fm, [2,3])
    #         b.move_capture(sm, [2,1])
    #         b.move_capture(sf, [2,2])
    #         b.display()
    #         expect(b.check_utifudume(ff, [1,2])).to.be.false
    describe 'SECOND escape utifudume alternatives', ->
        it 'expects Fu move [3,2] is judged utifudume', ->
            b.add(fo);b.add(so);b.add(fm);b.add(sm);b.add(sh);b.add(ff);b.add(sf);
            b.move_capture(so, [1,1])
            b.move_capture(fo, [3,3])
            b.move_capture(ff, [2,2])
            b.move_capture(sm, [2,1])
            b.move_capture(fm, [2,3])
            b.move_capture(sh, [1,3])
            b.display()
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = second.think(b, first, 3, Const.MIN_VALUE)
            expect(ret[0].kind()).to.equal('Ka')
            expect(ret[1]).to.deep.equal([1,2])
            # expect(ret[0].kind()).to.equal('Fu')
            # expect(ret[1]).to.deep.equal([3,2])
            # expect(ret[2]).to.be.below(-9999)
            # if ret[0].kind() == 'Fu' && ret[2] <= Const.MIN_VALUE
            #     console.log("alternatives")
            #     console.log(ret[4])
            #     expect(ret[4]["koma"].kind()).to.not.equal('Fu')
    describe 'FIRST escape utifudume alternatives', ->
        it 'expects Fu move [1,2] is judged utifudume', ->
            b.add(fo);b.add(so);b.add(fm);b.add(sh);b.add(sf);b.add(fg);b.add(ff);
            b.move_capture(so, [1,1])
            b.move_capture(fo, [3,1])
            b.move_capture(fm, [3,3])
            b.move_capture(sh, [2,2])
            b.move_capture(sf, [2,1])
            b.move_capture(fg, [1,3])
            b.display()
            first.depth = 3; second.depth = 3
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = first.think(b, second, first.depth, Const.MAX_VALUE)
            expect(ret[0].kind()).to.equal('Fu')
            expect(ret[1]).to.deep.equal([3,2])
            # expect(ret[0].kind()).to.equal('Fu')
            # expect(ret[1]).to.deep.equal([1,2])
            # expect(ret[2]).to.be.above(9999)
            # if ret[0].kind() == 'Fu' && ret[2] >= Const.MAX_VALUE && first.depth <= 2
            #     console.log("alternatives")
            #     console.log(ret[4])
            #     expect(ret[4]["koma"].kind()).to.not.equal('Fu')
    describe 'FIRST escape utifudume alternatives 2', ->
        it 'expects Fu move [1,2] is judged utifudume', ->
            b.add(fo);b.add(so);b.add(fm);b.add(sh);b.add(sf);b.add(fg);b.add(ff);
            b.move_capture(so, [1,1])
            b.move_capture(fo, [3,1])
            b.move_capture(fm, [3,3])
            b.move_capture(sh, [2,2])
            b.move_capture(sf, [2,1])
            b.move_capture(fg, [1,3])
            first.depth = 2; second.depth = 2
            b.display()
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = first.think(b, second, first.depth, Const.MAX_VALUE)
            expect(ret[0].kind()).to.equal('Fu')
            expect(ret[1]).to.deep.equal([3,2])
            expect(ret[4]["koma"].kind()).to.equal('Gi')
            expect(ret[4]["posi"]).to.deep.equal([2,2])
            # expect(ret[0].kind()).to.equal('Fu')
            # expect(ret[1]).to.deep.equal([1,2])
            # expect(ret[2]).to.be.above(9999)
            # if ret[0].kind() == 'Fu' && ret[2] >= Const.MAX_VALUE && first.depth <= 2
            #     console.log("alternatives")
            #     console.log(ret[4])
            #     expect(ret[4]["koma"].kind()).to.not.equal('Fu')
    describe 'FIRST escape utifudume alternatives 3', ->
        it 'expects Fu move [1,2] is judged utifudume', ->
            b.add(fo);b.add(so);b.add(fm);b.add(sh);b.add(sf);b.add(fg);b.add(ff);
            b.move_capture(so, [1,1])
            b.move_capture(fo, [3,1])
            b.move_capture(fm, [3,3])
            b.move_capture(sh, [2,2])
            b.move_capture(sf, [2,1])
            b.move_capture(fg, [1,3])
            first.depth = 1; second.depth = 1
            b.display()
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = first.think(b, second, first.depth, Const.MAX_VALUE)
            if ret[0].kind() == 'Fu' && ret[2] >= Const.MAX_VALUE && first.depth <= 2
                console.log("alternatives")
                console.log(ret[4])
                expect(ret[4]["koma"].kind()).to.not.equal('Fu')
    describe 'avoid utifudume with spare move', ->
        it 'expects do not move Fu to [1,2]', ->
            b.add(fo);b.add(so);b.add(fh);b.add(sh);b.add(fm);b.add(sm);b.add(ff);b.add(sf)
            b.move_capture(fo, [3,3])
            b.move_capture(so, [1,1])
            b.move_capture(fh, [3,1])
            b.move_capture(fm, [2,3])
            b.move_capture(sm, [2,1])
            b.move_capture(sf, [2,2])
            first.depth = 2; second.depth = 2
            b.display()
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = first.think(b, second, first.depth, Const.MAX_VALUE)
            if ret[0].kind() == 'Fu' && ret[0].status == Const.Status.MOTIGOMA
                console.log("alternatives")
                console.log(ret[4])
                expect(ret[4]["koma"].kind()).to.not.equal('Fu')
    describe 'Do not miss 1 move checkmate', ->
        it 'expects Gi move [2,2] and Nari', ->
            b.add(fo);b.add(so);b.add(sk);b.add(fy);b.add(fg)
            b.move_capture(fo, [3,2])
            b.move_capture(so, [1,2])
            b.move_capture(sk, [1,3])
            sk.status = Const.Status.URA
            b.move_capture(fg, [3,1])
            first.depth = 6; second.depth = 6
            b.display()
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = first.think(b, second, first.depth, Const.MAX_VALUE)
            expect(ret[0].kind()).to.equal('Gi')
            expect(ret[1]).to.deep.equal([2,2])
            expect(ret[3]).to.equal(Const.Status.URA)
    describe 'Do not miss 3 move checkmate', ->
        it 'expects Ka move [2,3] and Nari', ->
            b.add(fo);b.add(so);b.add(sf);b.add(ff);b.add(fm);b.add(sm)
            b.move_capture(fo, [3,2])
            b.move_capture(so, [1,3])
            b.move_capture(ff, [3,1])
            ff.status = Const.Status.URA
            b.move_capture(sm, [1,2])
            second.depth = 4; first.depth = 4
            b.display()
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = second.think(b, first, second.depth, Const.MIN_VALUE)
            expect(ret[0].kind()).to.equal('Ka')
            expect(ret[1]).to.deep.equal([2,3])
            expect(ret[3]).to.equal(Const.Status.URA)
    describe 'Do not miss 1 move checkmate', ->
        it 'expects Ka move [2,2]', ->
            b.add(fo);b.add(so);b.add(sf);b.add(ff);b.add(fm);b.add(sm)
            b.move_capture(fo, [2,1])
            b.move_capture(so, [1,3])
            b.move_capture(ff, [3,1])
            ff.status = Const.Status.URA
            b.move_capture(sm, [2,3])
            sm.status = Const.Status.URA
            first.depth = 2; second.depth = 2
            b.display()
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = second.think(b, first, second.depth, Const.MIN_VALUE)
            expect(ret[0].kind()).to.equal('Ka')
            expect(ret[1]).to.deep.equal([2,2])
    describe 'Do not miss 1 move checkmate', ->
        it 'expects Ka drop [2,3]', ->
            b.add(fo);b.add(so);b.add(sg);b.add(sm);b.add(fg);b.add(sf)
            console.log("sm = ")
            console.log(sm)
            b.move_capture(fo, [3,2])
            b.move_capture(so, [1,2])
            b.move_capture(sg, [2,2])
            second.depth = 2; first.depth = 2
            b.display()
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = second.think(b, first, 2, Const.MIN_VALUE)
            expect(ret[0].kind()).to.equal('Ka')
            expect(ret[1][0]).to.equal(2)
            expect(ret[3]).to.equal(Const.Status.OMOTE)
    afterEach ->
        console.log(ret)
        if ret[0]?
            if b.check_move(ret[0], ret[1])
                b.move_capture(ret[0], ret[1])
                ret[0].status = Const.Status.URA if ret[3]
        else
            console.log("AI resigned.")
        b.display()

describe '--- utifudume2', ->
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

    describe 'avoid utifudume without spare move', ->
        it 'expects do not move Fu to [1,2]', ->
            b.add(fo);b.add(so);b.add(fh);b.add(sh);b.add(fm);b.add(sm);b.add(ff);b.add(sf)
            b.move_capture(fo, [3,3])
            b.move_capture(so, [1,1])
            b.move_capture(fh, [3,1])
            b.move_capture(fm, [2,3])
            b.move_capture(sm, [2,1])
            b.move_capture(sf, [2,2])
            first.depth = 2; second.depth = 2
            b.display()
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = first.think(b, second, first.depth, Const.MAX_VALUE)
            console.log("Not alternatives")
            expect(ret[0].kind()).to.equal('Ka')

    describe 'SECOND escape utifudume without spare move', ->
        it 'expects Fu move [3,2] is judged utifudume', ->
            b.add(fo);b.add(so);b.add(fm);b.add(sm);b.add(sh);b.add(ff);b.add(sf);
            b.move_capture(so, [1,1])
            b.move_capture(fo, [3,3])
            b.move_capture(ff, [2,2])
            b.move_capture(sm, [2,1])
            b.move_capture(fm, [2,3])
            b.move_capture(sh, [1,3])
            b.display()
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = second.think(b, first, 3, Const.MIN_VALUE)
            expect(ret[0].kind()).to.equal('Ka')
            expect(ret[1]).to.deep.equal([1,2])
    describe 'FIRST escape utifudume without spare move', ->
        it 'expects Fu move [1,2] is judged utifudume', ->
            b.add(fo);b.add(so);b.add(fm);b.add(sh);b.add(sf);b.add(fg);b.add(ff);
            b.move_capture(so, [1,1])
            b.move_capture(fo, [3,1])
            b.move_capture(fm, [3,3])
            b.move_capture(sh, [2,2])
            b.move_capture(sf, [2,1])
            b.move_capture(fg, [1,3])
            b.display()
            first.depth = 3; second.depth = 3
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = first.think(b, second, first.depth, Const.MAX_VALUE)
            expect(ret[0].kind()).to.equal('Fu')
            expect(ret[1]).to.deep.equal([3,2])
    describe 'FIRST escape utifudume without spare move 2', ->
        it 'expects Fu move [1,2] is judged utifudume', ->
            b.add(fo);b.add(so);b.add(fm);b.add(sh);b.add(sf);b.add(fg);b.add(ff);
            b.move_capture(so, [1,1])
            b.move_capture(fo, [3,1])
            b.move_capture(fm, [3,3])
            b.move_capture(sh, [2,2])
            b.move_capture(sf, [2,1])
            b.move_capture(fg, [1,3])
            first.depth = 2; second.depth = 2
            b.display()
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = first.think(b, second, first.depth, Const.MAX_VALUE)
            expect(ret[0].kind()).to.equal('Fu')
            expect(ret[1]).to.deep.equal([3,2])
            expect(ret[4]["koma"].kind()).to.equal('Gi')
            expect(ret[4]["posi"]).to.deep.equal([2,2])
    describe 'FIRST escape utifudume without spare move 3', ->
        it 'expects Fu move [1,2] is judged utifudume', ->
            b.add(fo);b.add(so);b.add(fm);b.add(sh);b.add(sf);b.add(fg);b.add(ff);
            b.move_capture(so, [1,1])
            b.move_capture(fo, [3,1])
            b.move_capture(fm, [3,3])
            b.move_capture(sh, [2,2])
            b.move_capture(sf, [2,1])
            b.move_capture(fg, [1,3])
            first.depth = 1; second.depth = 1
            b.display()
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = first.think(b, second, first.depth, Const.MAX_VALUE)
            expect(ret[0].kind()).to.equal('Gi')
            expect(ret[1]).to.deep.equal([2,2])
            expect(ret[4]["koma"].kind()).to.equal('Ka')
            expect(ret[4]["posi"]).to.deep.equal([2,2])
    describe 'avoid utifudume without spare move', ->
        it 'expects do not move Fu to [1,2]', ->
            b.add(fo);b.add(so);b.add(fh);b.add(sh);b.add(fm);b.add(sm);b.add(ff);b.add(sf)
            b.move_capture(fo, [3,3])
            b.move_capture(so, [1,1])
            b.move_capture(fh, [3,1])
            b.move_capture(fm, [2,3])
            b.move_capture(sm, [2,1])
            b.move_capture(sf, [2,2])
            first.depth = 2; second.depth = 2
            b.display()
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = first.think(b, second, first.depth, Const.MAX_VALUE)
            expect(ret[0].kind()).to.equal('Ka')
            expect(ret[1]).to.deep.equal([3,2])
            expect(ret[4]["koma"].kind()).to.equal('Ka')
            expect(ret[4]["posi"]).to.deep.equal([1,2])
    describe 'Do not miss second win', ->
        it 'expects Ka place [1,2]', ->
            b.add(fo);b.add(so);b.add(sm);b.add(fm);b.add(fg);b.add(sg);b.add(ff);b.add(sf)
            b.move_capture(fo, [3,3])
            b.move_capture(so, [1,1])
            b.move_capture(fg, [1,3])
            b.move_capture(sg, [3,1])
            b.move_capture(sf, [2,2])
            b.move_capture(ff, [3,2])
            first.depth = 8; second.depth = 8
            b.display()
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = second.think(b, first, second.depth, Const.MIN_VALUE)
            expect(ret[0].kind()).to.equal('Ka')
            expect(ret[1]).to.deep.equal([1,2])
    describe 'Do not miss second win', ->
        it 'expects Ou move [1,2]', ->
            b.add(fo);b.add(so);b.add(sf);b.add(fh);b.add(sx)
            b.move_capture(fo, [3,3])
            b.move_capture(so, [1,1])
            b.move_capture(sf, [2,2])
            b.move_capture(fh, [3,1])
            second.depth = 7; first.depth = 7
            b.display()
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = second.think(b, first, second.depth, Const.MIN_VALUE)
            expect(ret[0].kind()).to.equal('Ou')
            expect(ret[1]).to.deep.equal([1,2])
    describe 'Do not judge utifudume', ->
        it 'expects Fu place [1,2]', ->
            b.add(fo);b.add(so);b.add(fh);b.add(sm);b.add(ff)
            b.move_capture(fo, [2,3])
            b.move_capture(so, [2,1])
            b.move_capture(fh, [3,2])
            b.move_capture(sm, [1,1])
            first.depth = 7; second.depth = 7
            b.display()
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = first.think(b, second, first.depth, Const.MAX_VALUE)
            expect(ret[0].kind()).to.equal('Fu')
            expect(ret[1]).to.deep.equal([1,2])
    describe 'Do not miss first win', ->
        it 'expects Ka drop [1,3]', ->
            b.add(fo);b.add(so);b.add(fm);b.add(sh)
            b.move_capture(fo, [2,3])
            b.move_capture(so, [2,1])
            b.move_capture(sh, [3,2])
            second.depth = 7; first.depth = 7
            b.display()
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = first.think(b, second, 7, Const.MAX_VALUE)
            expect(ret[0].kind()).to.equal('Ka')
            expect(ret[1]).to.deep.equal([1,3])
    describe 'Do not miss second win', ->
        it 'expects Ou move [1,2]', ->
            b.add(fo);b.add(so);b.add(fm);b.add(sg);b.add(fg);b.add(ff)
            b.move_capture(fo, [3,3])
            b.move_capture(so, [2,1])
            b.move_capture(fm, [2,2])
            b.move_capture(ff, [3,2])
            fg.turn = Const.SECOND
            second.depth = 7; first.depth = 7
            b.display()
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = second.think(b, first, 7, Const.MIN_VALUE)
            expect(ret[0].kind()).to.equal('Ou')
            expect(ret[1]).to.deep.equal([1,2])
    afterEach ->
        console.log(ret)
        if ret[0]?
            if b.check_move(ret[0], ret[1])
                b.move_capture(ret[0], ret[1])
                ret[0].status = Const.Status.URA if ret[3]
        else
            console.log("AI resigned.")
        b.display()

describe '--- tumeshogi1', ->
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

    describe 'second do not miss win depth = 4', ->
        it 'expects Hi place [3,2]', ->
            b.add(fo);b.add(so);b.add(fh);b.add(sh);b.add(fm);b.add(sm);b.add(ff);b.add(sf)
            b.move_capture(fo, [3,3])
            b.move_capture(so, [3,1])
            b.move_capture(fh, [2,3])
            ff.turn = Const.FIRST
            first.depth = 4; second.depth = 4
            b.display()
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = second.think(b, first, second.depth, Const.MIN_VALUE)
            expect(ret[0].kind()).to.equal('Hi')
            expect(ret[1]).to.deep.equal([3,2])
    describe 'second do not miss win depth = 3', ->
        it 'expects Hi place [3,2]', ->
            b.add(fo);b.add(so);b.add(fh);b.add(sh);b.add(fm);b.add(sm);b.add(ff);b.add(sf)
            b.move_capture(fo, [3,3])
            b.move_capture(so, [3,1])
            b.move_capture(fh, [2,3])
            ff.turn = Const.FIRST
            first.depth = 3; second.depth = 3
            b.display()
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = second.think(b, first, second.depth, Const.MIN_VALUE)
            expect(ret[0].kind()).to.equal('Hi')
            expect(ret[1]).to.deep.equal([3,2])
    describe 'second do not miss win depth = 2', ->
        it 'expects Hi place [3,2]', ->
            b.add(fo);b.add(so);b.add(fh);b.add(sh);b.add(fm);b.add(sm);b.add(ff);b.add(sf)
            b.move_capture(fo, [3,3])
            b.move_capture(so, [3,1])
            b.move_capture(fh, [2,3])
            ff.turn = Const.FIRST
            first.depth = 2; second.depth = 2
            b.display()
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = second.think(b, first, second.depth, Const.MIN_VALUE)
            expect(ret[0].kind()).to.equal('Hi')
            expect(ret[1]).to.deep.equal([3,2])
    describe 'second do not miss 3 move checkmate', ->
        it 'expects Hi place [3,2]', ->
            b.add(fo);b.add(so);b.add(fh);b.add(sh);b.add(fm);b.add(sm);b.add(ff);b.add(sf)
            b.move_capture(fo, [3,3])
            b.move_capture(so, [1,1])
            b.move_capture(sh, [3,1])
            b.move_capture(sf, [1,2])
            b.move_capture(fm, [3,2])
            fh.turn = Const.SECOND
            first.depth = 4; second.depth = 4
            b.display()
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = second.think(b, first, second.depth, Const.MIN_VALUE)
            expect(ret[0].kind()).to.equal('Hi')
            expect(ret[1]).to.deep.equal([2,2])
    describe 'first do not miss win', ->
        it 'expects Ka place [3,2]', ->
            b.add(fo);b.add(so);b.add(fm);b.add(sm);b.add(fg);b.add(sg);b.add(ff);b.add(sf)
            b.move_capture(fo, [3,3])
            b.move_capture(so, [1,1])
            b.move_capture(fg, [1,3])
            b.move_capture(sg, [3,1])
            b.move_capture(sf, [1,2])
            b.move_capture(ff, [2,2])
            first.depth = 8; second.depth = 8
            # first.pre_select = 4
            b.display()
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = first.think(b, second, first.depth, Const.MAX_VALUE)
            expect(ret[0].kind()).to.equal('Ka')
            expect(ret[1]).to.deep.equal([3,2])
    describe 'first do not miss win', ->
        it 'expects Fu place [1,2]', ->
            b.add(fo);b.add(so);b.add(fg);b.add(sg);b.add(ff);b.add(sf)
            b.move_capture(fo, [3,3])
            b.move_capture(so, [1,1])
            b.move_capture(fg, [1,3])
            b.move_capture(sg, [2,1])
            first.depth = 4; second.depth = 4
            b.display()
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = first.think(b, second, first.depth, Const.MAX_VALUE)
            expect(ret[0].kind()).to.equal('Fu')
            expect(ret[1]).to.deep.equal([1,2])
    afterEach ->
        console.log(ret)
        if ret[0]?
            if b.check_move(ret[0], ret[1])
                b.move_capture(ret[0], ret[1])
                ret[0].status = Const.Status.URA if ret[3]
        else
            console.log("AI resigned.")
        b.display()

describe '--- tumeshogi2', ->
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

    describe 'first do not miss tumi -1', ->
        it 'expects Hi move [3,1] and Nari', ->
            b.add(fo);b.add(so);b.add(fh);b.add(sx)
            b.move_capture(fo, [3,3])
            b.move_capture(so, [1,2])
            b.move_capture(fh, [3,1])
            first.depth = 4; second.depth = 4
            b.display()
            ret = first.prepare(b, second, first.depth, Const.MAX_VALUE)
            expect(ret[0].kind()).to.equal('Hi')
            expect(ret[3]).to.equal(Const.Status.URA)            
            expect(ret[1]).to.deep.equal([3,2])
    describe 'first do not miss tumi -2', ->
        it 'expects Hi move [3,1] and Nari', ->
            b.add(fo);b.add(so);b.add(fh);b.add(sx)
            b.move_capture(fo, [3,3])
            b.move_capture(so, [1,2])
            b.move_capture(fh, [3,1])
            first.depth = 4; second.depth = 4
            b.display()
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = first.think(b, second, first.depth, Const.MAX_VALUE)
            expect(ret[0].kind()).to.equal('Hi')
            expect(ret[3]).to.equal(Const.Status.URA)            
            expect(ret[1]).to.deep.equal([3,2])
    describe 'first do not miss tumi -3', ->
        it 'expects Ka move [1,1] and Nari', ->
            b.add(fo);b.add(so);b.add(fm);b.add(fk)
            b.move_capture(fo, [3,3])
            b.move_capture(so, [2,1])
            b.move_capture(fm, [2,2])
            b.move_capture(fk, [2,3])            
            first.depth = 2; second.depth = 2
            b.display()
            ret = first.prepare(b, second, first.depth, Const.MAX_VALUE)
            expect(ret[0].kind()).to.equal('Ka')
            expect(ret[3]).to.equal(Const.Status.URA)            
            expect(ret[1]).to.deep.equal([1,1])
    describe 'first do not miss tumi -4', ->
        it 'expects Ka move [1,1] and Nari', ->
            b.add(fo);b.add(so);b.add(fm);b.add(fk)
            b.move_capture(fo, [3,3])
            b.move_capture(so, [2,1])
            b.move_capture(fm, [2,2])
            b.move_capture(fk, [2,3])            
            first.depth = 2; second.depth = 2
            b.display()
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = first.think(b, second, first.depth, Const.MAX_VALUE)
            expect(ret[0].kind()).to.equal('Ka')
            expect(ret[3]).to.equal(Const.Status.URA)            
            expect(ret[1]).to.deep.equal([1,1])
    describe 'first do not miss tumi -5', ->
        it 'expects Hi move [2,3]', ->
            b.add(fo);b.add(so);b.add(fh);b.add(fy);b.add(sh);b.add(sy)
            b.move_capture(fo, [1,1])
            b.move_capture(so, [3,3])
            b.move_capture(fh, [1,3])
            b.move_capture(sh, [2,3])            
            first.depth = 6; second.depth = 6
            b.display()
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = first.think(b, second, first.depth, Const.MAX_VALUE)
            expect(ret[0].kind()).to.equal('Hi')
            expect(ret[1]).to.deep.equal([2,3])
    afterEach ->
        console.log(ret)
        if ret[0]?
            if b.check_move(ret[0], ret[1])
                b.move_capture(ret[0], ret[1])
                ret[0].status = Const.Status.URA if ret[3]
        else
            console.log("AI resigned.")
        b.display()
