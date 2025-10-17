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

    describe '問い１', ->
        it 'expects Ke move [2,3]', ->
            b.addMotigoma(fo, Const.FIRST);b.addMotigoma(fk, Const.FIRST)
            b.addMotigoma(sm, Const.SECOND);b.addMotigoma(so, Const.SECOND)
            b.addMotigoma(sk, Const.SECOND);b.addMotigoma(sy, Const.SECOND)
            b.move_capture(fo, [3,2])
            b.move_capture(sm, [2,2])
            b.move_capture(sy, [1,2])
            b.move_capture(so, [1,1])
            b.move_capture(sk, [2,1])
            b.display()
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = first.think(b, second, 3, Const.MAX_VALUE)
            expect(ret.lastkoma.name).to.equal('Ke')
            expect(ret.lastposi).to.deep.equal([2,3])
            expect(ret.lastscore).to.be.above(9999)
    describe '問い２', ->
        it 'expects Fu move [2,1] when tumi is exist', ->
            b.addMotigoma(ff, Const.FIRST);b.addMotigoma(fm, Const.FIRST)
            b.addMotigoma(fo, Const.FIRST);b.addMotigoma(so, Const.SECOND)
            b.move_capture(fo, [3,2])
            b.move_capture(ff, [2,2])
            b.move_capture(fm, [3,3])
            b.move_capture(so, [1,1])
            b.display()
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = first.think(b, second, 5, Const.MAX_VALUE)
            expect(ret.lastkoma.name).to.equal('Fu')
            expect(ret.lastposi).to.deep.equal([2,1])
            expect(ret.lastscore).to.be.above(9999)
    describe 'mine01', ->
        it 'expects Uma move [2,2] when tumi is exist', ->
            b.addMotigoma(ff, Const.FIRST);b.addMotigoma(sm, Const.SECOND)
            b.addMotigoma(fo, Const.FIRST);b.addMotigoma(so, Const.SECOND)
            b.move_capture(fo, [3,2])
            b.move_capture(ff, [3,1], true)
            b.move_capture(sm, [2,3], true)
            b.move_capture(so, [1,3])
            # sm.status = Const.Status.URA
            # ff.status = Const.Status.URA
            b.display()
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = second.think(b, first, 3, Const.MIN_VALUE)
            expect(ret.lastkoma.name).to.equal('Ka')
            expect(ret.lastposi).to.deep.equal([3,2])
            expect(ret.lastscore).to.be.below(-9999)
    describe 'FIRST don`t miss tumi', ->
        it 'expects Gi move [2,2] when tumi is exist', ->
            b.addMotigoma(ff, Const.FIRST);b.addMotigoma(sf, Const.SECOND)
            b.addMotigoma(fo, Const.FIRST);b.addMotigoma(so, Const.SECOND)
            b.addMotigoma(fg, Const.FIRST);b.addMotigoma(sg, Const.SECOND)
            b.move_capture(ff, [1,3])
            b.move_capture(fo, [2,3])
            b.move_capture(so, [2,1])
            b.display()
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = first.think(b, second, 4, Const.MAX_VALUE)
            expect(ret.lastkoma.name).to.equal('Gi')
            expect(ret.lastposi[0]).to.be.within(2,3)
            expect(ret.lastposi[1]).to.equal(2)
    # describe 'mine02', ->
    #     it 'expects Ka move [2,2] when tumi is exist', ->
    #         b.addMotigoma(fo, Const.FIRST);b.addMotigoma(so, Const.SECOND)
    #         b.addMotigoma(fm, Const.FIRST);b.addMotigoma(fh, Const.FIRST)
    #         b.move_capture(fo, [1,3])
    #         b.move_capture(so, [1,1])
    #         b.display()
    #         ret = first.think(b, second, 6, Const.MAX_VALUE)
    #         expect(ret.lastkoma.name).to.equal('Ka')
    #         expect(ret.lastposi).to.deep.equal([2,2])
    describe 'mine03', ->
        it 'expects Hi move [3,1] when tumi is exist', ->
            b.addMotigoma(fo, Const.FIRST);b.addMotigoma(so, Const.SECOND)
            b.addMotigoma(fm, Const.FIRST);b.addMotigoma(fh, Const.FIRST)
            b.move_capture(fo, [2,3])
            b.move_capture(so, [1,1])
            b.move_capture(fh, [3,2])
            b.display()
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = first.think(b, second, 1, Const.MAX_VALUE)
            expect(ret.lastkoma.name).to.equal('Hi')
            expect(ret.lastposi).to.deep.equal([3,1])
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

describe 'utifudume1', ->
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

    # 特殊な打ち歩詰めはPlayer.think内で評価値に-1を掛けて対応
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
            b.addMotigoma(fo, Const.FIRST);b.addMotigoma(so, Const.SECOND)
            b.addMotigoma(fm, Const.FIRST);b.addMotigoma(sm, Const.SECOND)
            b.addMotigoma(sh, Const.SECOND);b.addMotigoma(ff, Const.FIRST)
            b.addMotigoma(sf, Const.SECOND)
            b.move_capture(so, [1,1])
            b.move_capture(fo, [3,3])
            b.move_capture(ff, [2,2])
            b.move_capture(sm, [2,1])
            b.move_capture(fm, [2,3])
            b.move_capture(sh, [1,3])
            b.display()
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = second.think(b, first, 3, Const.MIN_VALUE)
            expect(ret.lastkoma.name).to.equal('Ka')
            expect(ret.lastposi).to.deep.equal([1,2])
    describe 'FIRST escape utifudume alternatives', ->
        it 'expects Fu move [1,2] is judged utifudume', ->
            b.addMotigoma(fo, Const.FIRST);b.addMotigoma(so, Const.SECOND)
            b.addMotigoma(fm, Const.FIRST);b.addMotigoma(sh, Const.SECOND)
            b.addMotigoma(sf, Const.SECOND);b.addMotigoma(fg, Const.FIRST)
            b.addMotigoma(ff, Const.FIRST)
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
            expect(ret.lastkoma.name).to.equal('Fu')
            expect(ret.lastposi).to.deep.equal([3,2])
    describe 'FIRST escape utifudume alternatives 2', ->
        it 'expects Fu move [1,2] is judged utifudume', ->
            b.addMotigoma(fo, Const.FIRST);b.addMotigoma(so, Const.SECOND)
            b.addMotigoma(fm, Const.FIRST);b.addMotigoma(sh, Const.SECOND)
            b.addMotigoma(sf, Const.SECOND);b.addMotigoma(fg, Const.FIRST)
            b.addMotigoma(ff, Const.FIRST)
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
            expect(ret.lastkoma.name).to.equal('Fu')
            expect(ret.lastposi).to.deep.equal([3,2])
            expect(ret.spare.lastkoma.name).to.equal('Gi')
            expect(ret.spare.lastposi).to.deep.equal([2,2])
    describe 'FIRST escape utifudume alternatives 3', ->
        it 'expects Fu move [1,2] is judged utifudume', ->
            b.addMotigoma(fo, Const.FIRST);b.addMotigoma(so, Const.SECOND)
            b.addMotigoma(fm, Const.FIRST);b.addMotigoma(sh, Const.SECOND)
            b.addMotigoma(sf, Const.SECOND);b.addMotigoma(fg, Const.FIRST)
            b.addMotigoma(ff, Const.FIRST)
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
            if ret.lastkoma.name == 'Fu' && ret.lastscore >= Const.MAX_VALUE && first.depth <= 2
                console.log("alternatives")
                console.log(ret[4])
                expect(ret.spare.lastkoma.name).to.not.equal('Fu')
    describe 'avoid utifudume with spare move', ->
        it 'expects do not move Fu to [1,2]', ->
            b.addMotigoma(fo, Const.FIRST);b.addMotigoma(so, Const.SECOND)
            b.addMotigoma(fh, Const.FIRST);b.addMotigoma(sh, Const.SECOND)
            b.addMotigoma(fm, Const.FIRST);b.addMotigoma(sm, Const.SECOND)
            b.addMotigoma(ff, Const.FIRST);b.addMotigoma(sf, Const.SECOND)
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
            if ret.lastkoma.name == 'Fu' && ret.lastkoma.status == Const.Status.MOTIGOMA
                console.log("alternatives")
                console.log(ret.spare)
                expect(ret.spare.lastkoma.name).to.not.equal('Fu')
    describe 'Do not miss 1 move checkmate', ->
        it 'expects Gi move [2,2] and Nari', ->
            b.addMotigoma(fo, Const.FIRST);b.addMotigoma(so, Const.SECOND)
            b.addMotigoma(sk, Const.SECOND);b.addMotigoma(fy, Const.FIRST)
            b.addMotigoma(fg, Const.FIRST)
            b.move_capture(fo, [3,2])
            b.move_capture(so, [1,2])
            b.move_capture(sk, [1,3], true)
            # sk.status = Const.Status.URA
            b.move_capture(fg, [3,1])
            first.depth = 6; second.depth = 6
            b.display()
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = first.think(b, second, first.depth, Const.MAX_VALUE)
            expect(ret.lastkoma.name).to.equal('Gi')
            expect(ret.lastposi).to.deep.equal([2,2])
            expect(ret.laststatus).to.equal(Const.Status.URA)
    describe 'Do not miss 3 move checkmate', ->
        it 'expects Ka move [2,3] and Nari', ->
            b.addMotigoma(fo, Const.FIRST);b.addMotigoma(so, Const.SECOND)
            b.addMotigoma(sf, Const.SECOND);b.addMotigoma(ff, Const.FIRST)
            b.addMotigoma(fm, Const.FIRST);b.addMotigoma(sm, Const.SECOND)
            b.move_capture(fo, [3,2])
            b.move_capture(so, [1,3])
            b.move_capture(ff, [3,1], true)
            # ff.status = Const.Status.URA
            b.move_capture(sm, [1,2])
            second.depth = 4; first.depth = 4
            b.display()
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = second.think(b, first, second.depth, Const.MIN_VALUE)
            expect(ret.lastkoma.name).to.equal('Ka')
            expect(ret.lastposi).to.deep.equal([2,3])
            expect(ret.laststatus).to.equal(Const.Status.URA)
    describe 'Do not miss 1 move checkmate', ->
        it 'expects Ka move [2,2]', ->
            b.addMotigoma(fo, Const.FIRST);b.addMotigoma(so, Const.SECOND)
            b.addMotigoma(sf, Const.SECOND);b.addMotigoma(ff, Const.FIRST)
            b.addMotigoma(fm, Const.FIRST);b.addMotigoma(sm, Const.SECOND)
            b.move_capture(fo, [2,1])
            b.move_capture(so, [1,3])
            b.move_capture(ff, [3,1], true)
            # ff.status = Const.Status.URA
            b.move_capture(sm, [2,3], true)
            # sm.status = Const.Status.URA
            first.depth = 2; second.depth = 2
            b.display()
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = second.think(b, first, second.depth, Const.MIN_VALUE)
            expect(ret.lastkoma.name).to.equal('Ka')
            expect(ret.lastposi).to.deep.equal([2,2])
    describe 'Do not miss 1 move checkmate', ->
        it 'expects Ka drop [2,3]', ->
            b.addMotigoma(fo, Const.FIRST);b.addMotigoma(so, Const.SECOND)
            b.addMotigoma(sg, Const.SECOND);b.addMotigoma(sm, Const.SECOND)
            b.addMotigoma(fg, Const.FIRST);b.addMotigoma(sf, Const.SECOND)
            b.move_capture(fo, [3,2])
            b.move_capture(so, [1,2])
            b.move_capture(sg, [2,2])
            second.depth = 2; first.depth = 2
            b.display()
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = second.think(b, first, 2, Const.MIN_VALUE)
            expect(ret.lastkoma.name).to.equal('Ka')
            expect(ret.lastposi[0]).to.equal(2)
            expect(ret.laststatus).to.equal(Const.Status.OMOTE)
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

describe 'utifudume2', ->
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

    describe 'avoid utifudume without spare move', ->
        it 'expects do not move Fu to [1,2]', ->
            b.addMotigoma(fo, Const.FIRST);b.addMotigoma(so, Const.SECOND)
            b.addMotigoma(fh, Const.FIRST);b.addMotigoma(sh, Const.SECOND)
            b.addMotigoma(fm, Const.FIRST);b.addMotigoma(sm, Const.SECOND)
            b.addMotigoma(ff, Const.FIRST);b.addMotigoma(sf, Const.SECOND)
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
            expect(ret.lastkoma.name).to.equal('Ka')

    describe 'SECOND escape utifudume without spare move', ->
        it 'expects Fu move [3,2] is judged utifudume', ->
            b.addMotigoma(fo, Const.FIRST);b.addMotigoma(so, Const.SECOND)
            b.addMotigoma(fm, Const.FIRST);b.addMotigoma(sm, Const.SECOND)
            b.addMotigoma(sh, Const.SECOND);b.addMotigoma(ff, Const.FIRST)
            b.addMotigoma(sf, Const.SECOND)
            b.move_capture(so, [1,1])
            b.move_capture(fo, [3,3])
            b.move_capture(ff, [2,2])
            b.move_capture(sm, [2,1])
            b.move_capture(fm, [2,3])
            b.move_capture(sh, [1,3])
            b.display()
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = second.think(b, first, 3, Const.MIN_VALUE)
            expect(ret.lastkoma.name).to.equal('Ka')
            expect(ret.lastposi).to.deep.equal([1,2])
    describe 'FIRST escape utifudume without spare move', ->
        it 'expects Fu move [1,2] is judged utifudume', ->
            b.addMotigoma(fo, Const.FIRST);b.addMotigoma(so, Const.SECOND)
            b.addMotigoma(fm, Const.FIRST);b.addMotigoma(sh, Const.SECOND)
            b.addMotigoma(sf, Const.SECOND);b.addMotigoma(fg, Const.FIRST)
            b.addMotigoma(ff, Const.FIRST)
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
            expect(ret.lastkoma.name).to.equal('Fu')
            expect(ret.lastposi).to.deep.equal([3,2])
    describe 'FIRST escape utifudume without spare move 2', ->
        it 'expects Fu move [1,2] is judged utifudume', ->
            b.addMotigoma(fo, Const.FIRST);b.addMotigoma(so, Const.SECOND)
            b.addMotigoma(fm, Const.FIRST);b.addMotigoma(sh, Const.SECOND)
            b.addMotigoma(sf, Const.SECOND);b.addMotigoma(fg, Const.FIRST)
            b.addMotigoma(ff, Const.FIRST)
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
            expect(ret.lastkoma.name).to.equal('Fu')
            expect(ret.lastposi).to.deep.equal([3,2])
            expect(ret.spare.lastkoma.name).to.equal('Gi')
            expect(ret.spare.lastposi).to.deep.equal([2,2])
    describe 'FIRST escape utifudume without spare move 3', ->
        it 'expects Fu move [1,2] is judged utifudume', ->
            b.addMotigoma(fo, Const.FIRST);b.addMotigoma(so, Const.SECOND)
            b.addMotigoma(fm, Const.FIRST);b.addMotigoma(sh, Const.SECOND)
            b.addMotigoma(sf, Const.SECOND);b.addMotigoma(fg, Const.FIRST)
            b.addMotigoma(ff, Const.FIRST)
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
            expect(ret.lastkoma.name).to.equal('Gi')
            expect(ret.lastposi).to.deep.equal([2,2])
            expect(ret.spare.lastkoma.name).to.equal('Ka')
            expect(ret.spare.lastposi).to.deep.equal([2,2])
    describe 'avoid utifudume without spare move', ->
        it 'expects do not move Fu to [1,2]', ->
            b.addMotigoma(fo, Const.FIRST);b.addMotigoma(so, Const.SECOND)
            b.addMotigoma(fh, Const.FIRST);b.addMotigoma(sh, Const.SECOND)
            b.addMotigoma(fm, Const.FIRST);b.addMotigoma(sm, Const.SECOND)
            b.addMotigoma(ff, Const.FIRST);b.addMotigoma(sf, Const.SECOND)
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
            expect(ret.lastkoma.name).to.equal('Ka')
            expect(ret.lastposi).to.deep.equal([3,2])
            expect(ret.spare.lastkoma.name).to.equal('Ka')
            expect(ret.spare.lastposi).to.deep.equal([1,2])
    describe 'Do not miss second win', ->
        it 'expects Ka place [1,2]', ->
            b.addMotigoma(fo, Const.FIRST);b.addMotigoma(so, Const.SECOND)
            b.addMotigoma(sm, Const.SECOND);b.addMotigoma(fm, Const.FIRST)
            b.addMotigoma(fg, Const.FIRST);b.addMotigoma(sg, Const.SECOND)
            b.addMotigoma(ff, Const.FIRST);b.addMotigoma(sf, Const.SECOND)
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
            expect(ret.lastkoma.name).to.equal('Ka')
            expect(ret.lastposi).to.deep.equal([1,2])
    describe 'Do not miss second win', ->
        it 'expects Ou move [1,2]', ->
            b.addMotigoma(fo, Const.FIRST);b.addMotigoma(so, Const.SECOND)
            b.addMotigoma(sf, Const.SECOND);b.addMotigoma(fh, Const.FIRST)
            b.addMotigoma(sx, Const.SECOND)
            b.move_capture(fo, [3,3])
            b.move_capture(so, [1,1])
            b.move_capture(sf, [2,2])
            b.move_capture(fh, [3,1])
            second.depth = 7; first.depth = 7
            b.display()
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = second.think(b, first, second.depth, Const.MIN_VALUE)
            expect(ret.lastkoma.name).to.equal('Ou')
            expect(ret.lastposi).to.deep.equal([1,2])
    describe 'Do not judge utifudume', ->
        it 'expects Fu place [1,2]', ->
            b.addMotigoma(fo, Const.FIRST);b.addMotigoma(so, Const.SECOND)
            b.addMotigoma(fh, Const.FIRST);b.addMotigoma(sm, Const.SECOND)
            b.addMotigoma(ff, Const.FIRST)
            b.move_capture(fo, [2,3])
            b.move_capture(so, [2,1])
            b.move_capture(fh, [3,2])
            b.move_capture(sm, [1,1])
            first.depth = 7; second.depth = 7
            b.display()
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = first.think(b, second, first.depth, Const.MAX_VALUE)
            expect(ret.lastkoma.name).to.equal('Fu')
            expect(ret.lastposi).to.deep.equal([1,2])
    describe 'Do not miss first win', ->
        it 'expects Ka drop [1,3]', ->
            b.addMotigoma(fo, Const.FIRST);b.addMotigoma(so, Const.SECOND)
            b.addMotigoma(fm, Const.FIRST);b.addMotigoma(sh, Const.SECOND)
            b.move_capture(fo, [2,3])
            b.move_capture(so, [2,1])
            b.move_capture(sh, [3,2])
            second.depth = 7; first.depth = 7
            b.display()
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = first.think(b, second, 7, Const.MAX_VALUE)
            expect(ret.lastkoma.name).to.equal('Ka')
            expect(ret.lastposi).to.deep.equal([1,3])
    describe 'Do not miss second win', ->
        it 'expects Ou move [1,2]', ->
            b.addMotigoma(fo, Const.FIRST);b.addMotigoma(so, Const.SECOND)
            b.addMotigoma(fm, Const.FIRST);b.addMotigoma(sg, Const.SECOND)
            b.addMotigoma(fg, Const.FIRST);b.addMotigoma(ff, Const.FIRST)
            b.move_capture(fo, [3,3])
            b.move_capture(so, [2,1])
            b.move_capture(fm, [2,2])
            b.move_capture(ff, [3,2])
            # fg.turn = Const.SECOND
            b.removeMotigoma(fg)
            b.addMotigoma(fg, Const.SECOND)
            second.depth = 7; first.depth = 7
            b.display()
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = second.think(b, first, 7, Const.MIN_VALUE)
            expect(ret.lastkoma.name).to.equal('Ou')
            expect(ret.lastposi).to.deep.equal([1,2])
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

describe 'tumeshogi1', ->
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

    describe 'second do not miss win depth = 4', ->
        it 'expects Hi place [3,2]', ->
            b.addMotigoma(fo, Const.FIRST);b.addMotigoma(so, Const.SECOND)
            b.addMotigoma(fh, Const.FIRST);b.addMotigoma(sh, Const.SECOND)
            b.addMotigoma(fm, Const.FIRST);b.addMotigoma(sm, Const.SECOND)
            b.addMotigoma(ff, Const.FIRST);b.addMotigoma(sf, Const.SECOND)
            b.move_capture(fo, [3,3])
            b.move_capture(so, [3,1])
            b.move_capture(fh, [2,3])
            ff.turn = Const.FIRST
            first.depth = 4; second.depth = 4
            b.display()
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = second.think(b, first, second.depth, Const.MIN_VALUE)
            expect(ret.lastkoma.name).to.equal('Hi')
            expect(ret.lastposi).to.deep.equal([3,2])
    describe 'second do not miss win depth = 3', ->
        it 'expects Hi place [3,2]', ->
            b.addMotigoma(fo, Const.FIRST);b.addMotigoma(so, Const.SECOND)
            b.addMotigoma(fh, Const.FIRST);b.addMotigoma(sh, Const.SECOND)
            b.addMotigoma(fm, Const.FIRST);b.addMotigoma(sm, Const.SECOND)
            b.addMotigoma(ff, Const.FIRST);b.addMotigoma(sf, Const.SECOND)
            b.move_capture(fo, [3,3])
            b.move_capture(so, [3,1])
            b.move_capture(fh, [2,3])
            ff.turn = Const.FIRST
            first.depth = 3; second.depth = 3
            b.display()
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = second.think(b, first, second.depth, Const.MIN_VALUE)
            expect(ret.lastkoma.name).to.equal('Hi')
            expect(ret.lastposi).to.deep.equal([3,2])
    describe 'second do not miss win depth = 2', ->
        it 'expects Hi place [3,2]', ->
            b.addMotigoma(fo, Const.FIRST);b.addMotigoma(so, Const.SECOND)
            b.addMotigoma(fh, Const.FIRST);b.addMotigoma(sh, Const.SECOND)
            b.addMotigoma(fm, Const.FIRST);b.addMotigoma(sm, Const.SECOND)
            b.addMotigoma(ff, Const.FIRST);b.addMotigoma(sf, Const.SECOND)
            b.move_capture(fo, [3,3])
            b.move_capture(so, [3,1])
            b.move_capture(fh, [2,3])
            first.depth = 2; second.depth = 2
            b.display()
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = second.think(b, first, second.depth, Const.MIN_VALUE)
            expect(ret.lastkoma.name).to.equal('Hi')
            expect(ret.lastposi).to.deep.equal([3,2])
    describe 'second do not miss 3 move checkmate', ->
        it 'expects Hi place [3,2]', ->
            b.addMotigoma(fo, Const.FIRST);b.addMotigoma(so, Const.SECOND)
            b.addMotigoma(fh, Const.FIRST);b.addMotigoma(sh, Const.SECOND)
            b.addMotigoma(fm, Const.FIRST);b.addMotigoma(sm, Const.SECOND)
            b.addMotigoma(ff, Const.FIRST);b.addMotigoma(sf, Const.SECOND)
            b.move_capture(fo, [3,3])
            b.move_capture(so, [1,1])
            b.move_capture(sh, [3,1])
            b.move_capture(sf, [1,2])
            b.move_capture(fm, [3,2])
            # fh.turn = Const.SECOND
            b.removeMotigoma(fh)
            b.addMotigoma(fh, Const.SECOND)
            first.depth = 4; second.depth = 4
            b.display()
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = second.think(b, first, second.depth, Const.MIN_VALUE)
            expect(ret.lastkoma.name).to.equal('Hi')
            expect(ret.lastposi).to.deep.equal([2,2])
    describe 'first do not miss win', ->
        it 'expects Ka place [3,2]', ->
            b.addMotigoma(fo, Const.FIRST);b.addMotigoma(so, Const.SECOND)
            b.addMotigoma(fm, Const.FIRST);b.addMotigoma(sm, Const.SECOND)
            b.addMotigoma(fg, Const.FIRST);b.addMotigoma(sg, Const.SECOND)
            b.addMotigoma(ff, Const.FIRST);b.addMotigoma(sf, Const.SECOND)
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
            expect(ret.lastkoma.name).to.equal('Ka')
            expect(ret.lastposi).to.deep.equal([3,2])
    describe 'first do not miss win', ->
        it 'expects Fu place [1,2]', ->
            b.addMotigoma(fo, Const.FIRST);b.addMotigoma(so, Const.SECOND)
            b.addMotigoma(fg, Const.FIRST);b.addMotigoma(sg, Const.SECOND)
            b.addMotigoma(ff, Const.FIRST);b.addMotigoma(sf, Const.SECOND)
            b.move_capture(fo, [3,3])
            b.move_capture(so, [1,1])
            b.move_capture(fg, [1,3])
            b.move_capture(sg, [2,1])
            first.depth = 4; second.depth = 4
            b.display()
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = first.think(b, second, first.depth, Const.MAX_VALUE)
            expect(ret.lastkoma.name).to.equal('Fu')
            expect(ret.lastposi).to.deep.equal([1,2])
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

describe 'tumeshogi2', ->
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

    describe 'first do not miss tumi -1', ->
        it 'expects Hi move [3,1] and Nari', ->
            b.addMotigoma(fo, Const.FIRST);b.addMotigoma(so, Const.SECOND)
            b.addMotigoma(fh, Const.FIRST);b.addMotigoma(sx, Const.SECOND)
            b.move_capture(fo, [3,3])
            b.move_capture(so, [1,2])
            b.move_capture(fh, [3,1])
            first.depth = 4; second.depth = 4
            b.display()
            ret = first.prepare(b, second, first.depth, Const.MAX_VALUE)
            expect(ret.lastkoma.name).to.equal('Hi')
            expect(ret.laststatus).to.equal(Const.Status.URA)
            expect(ret.lastposi).to.deep.equal([3,2])
    describe 'first do not miss tumi -2', ->
        it 'expects Hi move [3,1] and Nari', ->
            b.addMotigoma(fo, Const.FIRST);b.addMotigoma(so, Const.SECOND)
            b.addMotigoma(fh, Const.FIRST);b.addMotigoma(sx, Const.SECOND)
            b.move_capture(fo, [3,3])
            b.move_capture(so, [1,2])
            b.move_capture(fh, [3,1])
            first.depth = 4; second.depth = 4
            b.display()
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = first.think(b, second, first.depth, Const.MAX_VALUE)
            expect(ret.lastkoma.name).to.equal('Hi')
            expect(ret.laststatus).to.equal(Const.Status.URA)
            expect(ret.lastposi).to.deep.equal([3,2])
    describe 'first do not miss tumi -3', ->
        it 'expects Ka move [1,1] and Nari', ->
            b.addMotigoma(fo, Const.FIRST);b.addMotigoma(so, Const.SECOND)
            b.addMotigoma(fm, Const.FIRST);b.addMotigoma(fk, Const.FIRST)
            b.move_capture(fo, [3,3])
            b.move_capture(so, [2,1])
            b.move_capture(fm, [2,2])
            b.move_capture(fk, [2,3])
            first.depth = 2; second.depth = 2
            b.display()
            ret = first.prepare(b, second, first.depth, Const.MAX_VALUE)
            expect(ret.lastkoma.name).to.equal('Ka')
            expect(ret.laststatus).to.equal(Const.Status.URA)
            expect(ret.lastposi).to.deep.equal([1,1])
    describe 'first do not miss tumi -4', ->
        it 'expects Ka move [1,1] and Nari', ->
            b.addMotigoma(fo, Const.FIRST);b.addMotigoma(so, Const.SECOND)
            b.addMotigoma(fm, Const.FIRST);b.addMotigoma(fk, Const.FIRST)
            b.move_capture(fo, [3,3])
            b.move_capture(so, [2,1])
            b.move_capture(fm, [2,2])
            b.move_capture(fk, [2,3])
            first.depth = 2; second.depth = 2
            b.display()
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = first.think(b, second, first.depth, Const.MAX_VALUE)
            expect(ret.lastkoma.name).to.equal('Ka')
            expect(ret.laststatus).to.equal(Const.Status.URA)
            expect(ret.lastposi).to.deep.equal([1,1])
    describe 'first do not miss tumi -5', ->
        it 'expects Hi move [2,3]', ->
            b.addMotigoma(fo, Const.FIRST);b.addMotigoma(so, Const.SECOND)
            b.addMotigoma(fh, Const.FIRST);b.addMotigoma(fy, Const.FIRST)
            b.addMotigoma(sh, Const.SECOND);b.addMotigoma(sy, Const.SECOND)
            b.move_capture(fo, [1,1])
            b.move_capture(so, [3,3])
            b.move_capture(fh, [1,3])
            b.move_capture(sh, [2,3])
            first.depth = 6; second.depth = 6
            b.display()
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = first.think(b, second, first.depth, Const.MAX_VALUE)
            expect(ret.lastkoma.name).to.equal('Hi')
            expect(ret.lastposi).to.deep.equal([2,3])
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
