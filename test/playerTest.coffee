chai = require 'chai'
expect = chai.expect
chai.should()
Const = require('../const.coffee')
Piece = require('../piece.coffee')
Board = require('../board.coffee')
Player = require('../player.coffee')

describe '--- Player1', ->
    b = null
    ff = null; fg = null; fo = null; so = null; sg = null; sf = null; fh = null;
    first = null; second = null;
    piece = null
    snapshot = null
    before ->
        b = new Board()
        b.set_standard()
        ff = b.getMotigoma(Const.FIRST, 'Fu')
        sf = b.getMotigoma(Const.SECOND, 'Fu')
        b.move_capture(ff, [3,2])
        snapshot = b.move_capture(sf, [2,2])
        b.display()
        first = new Player(Const.FIRST, false)
        second = new Player(Const.SECOND, false)
    describe 'FIRST think', ->
        it 'expects choose easy best move', ->
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = first.think(b, second, 1, Const.MAX_VALUE)
            console.log("ret = #{JSON.stringify(ret)}")
            check = b.check_move(ret.lastkoma, ret.lastposi)
            expect(check[0]).to.equal(true)
            b.move_capture(ret.lastkoma, ret.lastposi, check[1])
            expect(ret.lastkoma.status).to.equal(Const.Status.URA)
    describe 'SECOND think', ->
        it 'expects chose easy best move', ->
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = second.think(b, first, 1, Const.MIN_VALUE)
            expect(ret.lastkoma.name).to.equal('Gi')
            check = b.check_move(ret.lastkoma, ret.lastposi)
            expect(check[0]).to.equal(true)
            b.move_capture(ret.lastkoma, ret.lastposi, check[1])
    after ->
        b.display()

describe '--- Player2', ->
    b = null
    ff = null; fg = null; fo = null; so = null; sg = null; sf = null; fh = null;
    first = null; second = null;
    piece = null
    ret = null
    before ->
        first = new Player(Const.FIRST, false)
        second = new Player(Const.SECOND, false)
    beforeEach ->
        b = new Board()
        b.set_standard()
        ff = (v for v in b.getPieces(Const.FIRST) when v.name=='Fu')[0]
        sf = (v for v in b.getPieces(Const.SECOND) when v.name=='Fu')[0]
        fg = (v for v in b.getPieces(Const.FIRST) when v.name=='Gi')[0]
        sg = (v for v in b.getPieces(Const.SECOND) when v.name=='Gi')[0]
        fo = (v for v in b.getPieces(Const.FIRST) when v.name=='Ou')[0]
        so = (v for v in b.getPieces(Const.SECOND) when v.name=='Ou')[0]
    describe 'FIRST escape oute', ->
        it 'expects Ou move [2,3] when oute', ->
            b.move_capture(ff, [3,2])
            b.move_capture(sf, [2,2])
            check = b.check_move(ff, [3,1])
            b.move_capture(ff, [3,1], check[1])
            check = b.check_move(sf, [2,3])
            b.move_capture(sf, [2,3], check[1])
            b.display()
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = first.think(b, second, 1, Const.MAX_VALUE)
            console.log(ret)
            expect(ret.lastposi).to.deep.equal([2,3])
    describe 'SECOND escape oute', ->
        it 'expects Ou move [2,3] when oute', ->
            b.move_capture(fg, [2,2])
            b.display()
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = second.think(b, first, 1, Const.MIN_VALUE)
            console.log(ret)
            expect(ret.lastposi).to.deep.equal([1,2])
    describe 'FIRST escape utifudume', ->
        it 'expects Ou move [2,3] when oute', ->
            b.move_capture(fg, [2,2])
            b.move_capture(so, [1,2])
            b.display()
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = first.think(b, second, 1, Const.MAX_VALUE)
            console.log(ret)
            expect(ret.lastkoma.name).to.not.equal('Fu')
            expect(ret.lastposi).to.not.deep.equal([1,3])
    describe 'SECOND escape oute', ->
        it 'expects Ou move [1,2] when oute', ->
            b.move_capture(fg, [2,2])
            b.display()
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = second.think(b, first, 1, Const.MIN_VALUE)
            console.log(ret)
            expect(ret.lastposi).to.deep.equal([1,2])
    describe 'FIRST escape oute', ->
        it 'expects Ou move [3,2] when oute', ->
            b.move_capture(sg, [2,2])
            b.display()
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = first.think(b, second, 1, Const.MAX_VALUE)
            console.log(ret)
            expect(ret.lastposi).to.deep.equal([3,2])
    describe 'FIRST don`t miss tumi', ->
        it 'expects Gi move [2,2] and nari when tumi is exist', ->
            b.move_capture(fg, [3,1])
            b.move_capture(so, [1,2])
            b.display()
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = first.think(b, second, 3, Const.MAX_VALUE)
            console.log(ret)
            expect(ret.lastposi).to.deep.equal([2,2])
            expect(ret.laststatus).to.equal(Const.Status.URA)
    describe 'SECOND don`t miss tumi', ->
        it 'expects Gi move [2,2] and nari when tumi is exist', ->
            b.move_capture(sg, [1,3])
            b.move_capture(fo, [3,2])
            b.display()
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = second.think(b, first, 3, Const.MIN_VALUE)
            console.log(ret)
            expect(ret.lastposi).to.deep.equal([2,2])
            expect(ret.laststatus).to.equal(Const.Status.URA)
    describe 'FIRST don`t miss tumi', ->
        it 'expects nGi move [2,2] when tumi is exist', ->
            b.move_capture(sg, [1,2])
            b.move_capture(sg, [1,3], true)
            b.move_capture(so, [1,2])
            b.move_capture(ff, [2,3])
            b.move_capture(fg, [3,2], true)
            b.display()
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = first.think(b, second, 2, Const.MAX_VALUE)
            console.log(ret)
            expect(ret.lastposi).to.deep.equal([2,2])
            expect(ret.lastkoma.name).to.equal('Gi')
    afterEach ->
        check = b.check_move(ret.lastkoma, ret.lastposi)
        if check[0]
            b.move_capture(ret.lastkoma, ret.lastposi, check[1])
        b.display()
    # after ->
    #     b.display()
describe '--- Player3', ->
    b = null
    ff = null; fg = null; fo = null; so = null; sg = null; sf = null; fh = null;
    first = null; second = null;
    piece = null
    ret = null
    before ->
        first = new Player(Const.FIRST, false)
        second = new Player(Const.SECOND, false)
    beforeEach ->
        b = new Board()
        b.set_standard()
        ff = (v for v in b.getPieces(Const.FIRST) when v.name=='Fu')[0]
        sf = (v for v in b.getPieces(Const.SECOND) when v.name=='Fu')[0]
        fg = (v for v in b.getPieces(Const.FIRST) when v.name=='Gi')[0]
        sg = (v for v in b.getPieces(Const.SECOND) when v.name=='Gi')[0]
        fo = (v for v in b.getPieces(Const.FIRST) when v.name=='Ou')[0]
        so = (v for v in b.getPieces(Const.SECOND) when v.name=='Ou')[0]
    describe 'SECOND don`t miss tumi', ->
        it 'expects Gi move [2,2] when tumi is exist', ->
            b.move_capture(ff, [1,3])
            b.move_capture(fo, [2,3])
            b.move_capture(so, [2,1])
            b.display()
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = second.think(b, first, 3, Const.MIN_VALUE)
            expect(ret.lastkoma.name).to.equal('Gi')
            expect(ret.lastposi[0]).to.be.within(2,3)
            expect(ret.lastposi[1]).to.equal(2)
    describe 'FIRST don`t miss tumi', ->
        it 'expects Gi move [2,2] when tumi is exist', ->
            b.move_capture(ff, [1,3])
            b.move_capture(fo, [2,3])
            b.move_capture(so, [2,1])
            b.display()
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = first.think(b, second, 3, Const.MAX_VALUE)
            expect(ret.lastkoma.name).to.equal('Gi')
            expect(ret.lastposi[0]).to.be.within(2,3)
            expect(ret.lastposi[1]).to.equal(2)
    describe 'SECOND escape utifudume', ->
        it 'expects Fu move [2,1] when utifudume', ->
            b.move_capture(fg, [2,2])
            b.move_capture(so, [1,2])
            b.move_capture(sg, [2,3])
            b.display()
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = second.think(b, first, 2, Const.MIN_VALUE)
            expect(ret.lastkoma.name).to.equal('Fu')
            expect(ret.lastkoma.status).to.equal(Const.Status.MOTIGOMA)
            expect(ret.lastposi).to.not.deep.equal([3,2])
    describe 'SECOND escape utifudume', ->
        it 'expects Fu move [3,2] is judged utifudume', ->
            b.move_capture(fg, [2,2])
            b.move_capture(so, [1,2])
            b.move_capture(sg, [2,3])
            b.display()
            expect(b.check_utifudume(sf, [3,2])).to.be.true
    describe 'SECOND don`t miss komazon', ->
        it 'expects Ou move [2,1] when oute 1', ->
            b.move_capture(sg, [2,3])
            b.move_capture(so, [2,1])
            b.move_capture(ff, [2,2])
            b.display()
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = second.think(b, first, 2, Const.MIN_VALUE)
            expect(ret.lastkoma.name).to.equal('Ou')
            expect(ret.lastposi).to.deep.equal([1,2])
    describe 'SECOND don`t miss oute houti', ->
        it 'expects Ou move [1,3] when oute 2', ->
            b.addMotigoma(new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA), Const.FIRST)
            b.move_capture(sg, [2,3])
            b.move_capture(ff, [2,2])
            b.move_capture(so, [1,2])
            b.move_capture(b.getMotigoma(Const.FIRST, 'Fu'), [1,3])
            b.display()
            second.depth = 5; first.depth = 5
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = second.think(b, first, second.depth, Const.MIN_VALUE)
            expect(ret.lastkoma.name).to.equal('Ou')
            expect(ret.lastposi).to.deep.equal([1,3])
    describe 'FIRST don`t miss tumi', ->
        it 'expects Gi move [2,2] and nari when tumi is exist', ->
            b.move_capture(fg, [3,1])
            b.move_capture(so, [2,1])
            b.display()
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = first.think(b, second, 2, Const.MAX_VALUE)
            expect(ret.lastkoma.name).to.equal('Gi')
            expect(ret.lastposi).to.deep.equal([2,2])
            expect(ret.laststatus).to.equal(1)
    afterEach ->
        console.log(ret)
        check = b.check_move(ret.lastkoma, ret.lastposi)
        if check[0]
            b.move_capture(ret.lastkoma, ret.lastposi, check[1])
        b.display()

describe '--- Player4', ->
    b = null
    ff = null; fg = null; fo = null; so = null; sg = null; sf = null;
    first = null; second = null;
    ret = null
    before ->
        first = new Player(Const.FIRST, false)
        second = new Player(Const.SECOND, false)
    beforeEach ->
        b = new Board()
        fo = new Piece.Ou(Const.FIRST, Const.Status.MOTIGOMA)
        fg = new Piece.Gi(Const.FIRST, Const.Status.MOTIGOMA)
        ff = new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA)
        so = new Piece.Ou(Const.SECOND, Const.Status.MOTIGOMA)
        sg = new Piece.Gi(Const.SECOND, Const.Status.MOTIGOMA)
        sf = new Piece.Fu(Const.SECOND, Const.Status.MOTIGOMA)
        b.addMotigoma(fo, Const.FIRST)
        b.addMotigoma(fg, Const.FIRST)
        b.addMotigoma(ff, Const.FIRST)
        b.addMotigoma(so, Const.SECOND)
        b.addMotigoma(sg, Const.SECOND)
        b.addMotigoma(sf, Const.SECOND)
    describe 'FIRST don`t miss tumi', ->
        it 'expects Fu move [2,3] when tumi is exist', ->
            b.removeMotigoma(sg)
            b.addMotigoma(new Piece.Gi(Const.FIRST, Const.Status.MOTIGOMA), Const.FIRST)
            b.move_capture(fo, [1,1])
            b.move_capture(fg, [2,2], true)
            b.move_capture(so, [3,3])
            b.move_capture(sf, [3,1])
            b.display()
            first.depth = 4; second.depth = 4
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = first.think(b, second, first.depth, Const.MAX_VALUE)
            expect(ret.lastkoma.name).to.equal('Ou')
            expect(ret.lastposi).to.deep.equal([1,2])
            expect(ret.lastscore).to.equal(Const.MAX_VALUE)
    describe 'SECOND put up', ->
        it 'expects Fu move [3,2] when defeat is decided', ->
            b.removeMotigoma(sg)
            b.addMotigoma(new Piece.Gi(Const.FIRST, Const.Status.MOTIGOMA), Const.FIRST)
            b.move_capture(fo, [1,2])
            b.move_capture(fg, [2,2], true)
            b.move_capture(so, [3,3])
            b.move_capture(sf, [3,1])
            b.display()
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = second.think(b, first, 3, Const.MIN_VALUE)
            expect(ret.lastkoma).to.equal(null)
            expect(ret.lastposi).to.deep.equal([])
            console.log('1:' + JSON.stringify(ret))
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = second.think(b, first, 1, Const.MIN_VALUE)
            expect(ret.lastkoma.name).to.equal('Fu')
            expect(ret.lastposi).to.deep.equal([3, 2])
            console.log('2:' + JSON.stringify(ret))
    describe 'FIRST don`t miss tumi', ->
        it 'expects Ou move [1,1] when winning is decided', ->
            b.removeMotigoma(sg)
            b.addMotigoma(new Piece.Gi(Const.FIRST, Const.Status.MOTIGOMA), Const.FIRST)
            b.move_capture(fo, [1,2])
            b.move_capture(fg, [2,2], true)
            b.move_capture(so, [3,3])
            b.move_capture(sf, [3,2])
            b.display()
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = first.think(b, second, 2, Const.MAX_VALUE)
            expect(ret.lastkoma.name).to.equal('Ou')
            expect(ret.lastposi).to.deep.equal([1,1])
    describe 'SECOND resign', ->
        it 'expects Piece is null when no move to point', ->
            b.removeMotigoma(sg)
            b.addMotigoma(new Piece.Gi(Const.FIRST, Const.Status.MOTIGOMA), Const.FIRST)
            b.move_capture(fo, [1,1])
            b.move_capture(fg, [2,2], true)
            b.move_capture(so, [3,3])
            b.move_capture(sf, [3,2])
            b.display()
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = second.think(b, first, 2, Const.MIN_VALUE)
            expect(ret.lastkoma).to.equal(null)
            console.log('1:' + JSON.stringify(ret))
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = second.think(b, first, 1, Const.MIN_VALUE)
            expect(ret.lastkoma).to.equal(null)
    afterEach ->
        console.log(ret)
        if ret.lastkoma?
            check = b.check_move(ret.lastkoma, ret.lastposi)
            if check[0]
                b.move_capture(ret.lastkoma, ret.lastposi, check[1])
        else
            console.log("AI resigned.")
        b.display()
