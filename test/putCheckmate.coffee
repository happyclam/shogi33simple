chai = require 'chai'
expect = chai.expect
chai.should()
Const = require('../const.coffee')
Piece = require('../piece.coffee')
Board = require('../board.coffee')
Player = require('../player.coffee')

describe '--- leave alone', ->
    b = null
    ff = null; fy = null; fk = null; fg = null; fx = null; fm = null; fh = null; fo = null;
    sf = null; sy = null; sk = null; sg = null; sx = null; sm = null; sh = null; so = null;
    first = null; second = null;
    ret = null
    before ->
        first = new Player(Const.FIRST, false)
        second = new Player(Const.SECOND, false)
    beforeEach ->
        b = new Board(3, 3)
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

    describe 'SECOND resigned when checkmate', ->
        it 'expects no move when checkmate', ->
            b.addMotigoma(fo, Const.FIRST);b.addMotigoma(so, Const.SECOND);b.addMotigoma(fm, Const.FIRST);b.addMotigoma(sm, Const.SECOND);b.addMotigoma(sh, Const.SECOND);b.addMotigoma(sf, Const.SECOND);b.addMotigoma(fh, Const.FIRST);b.addMotigoma(ff, Const.FIRST);
            b.move_capture(so, [1,3])
            b.move_capture(fo, [3,2])
            b.move_capture(fm, [3,1])
            b.move_capture(sm, [1,1])
            b.move_capture(fh, [2,1])
            fh.status = Const.Status.URA
            b.move_capture(sh, [1,2])
            b.move_capture(sf, [2,2])
            b.display()
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = second.think(b, first, 1, Const.MIN_VALUE)
            console.log("ret = #{JSON.stringify(ret)}")
            expect(ret.lastkoma).to.equal(null)
            expect(ret.lastposi).to.deep.equal([])
            expect(ret.lastscore).to.be.above(9999)
    describe 'FIRST put checkmate if getting Ou', ->
        it 'expects Ka move [1,3] put checkmate', ->
            b.addMotigoma(fo, Const.FIRST);b.addMotigoma(so, Const.SECOND);b.addMotigoma(fm, Const.FIRST);b.addMotigoma(sm, Const.SECOND);b.addMotigoma(sh, Const.SECOND);b.addMotigoma(sf, Const.SECOND);b.addMotigoma(fh, Const.FIRST);b.addMotigoma(ff, Const.FIRST);
            b.move_capture(so, [1,3])
            b.move_capture(fo, [3,2])
            b.move_capture(fm, [3,1])
            b.move_capture(sm, [1,1])
            b.move_capture(fh, [2,1])
            fh.status = Const.Status.URA
            b.move_capture(sh, [1,2])
            b.move_capture(sf, [2,3])
            sf.status = Const.Status.URA
            b.display()
            first.pre_ahead = 0; second.pre_ahead = 0
            ret = first.think(b, second, 0, Const.MAX_VALUE)
            expect(ret.lastkoma.name).to.equal('Ka')
            expect(ret.lastposi).to.deep.equal([1,3])
            expect(ret.lastscore).to.be.above(9999)
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
