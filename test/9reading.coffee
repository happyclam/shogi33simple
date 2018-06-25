chai = require 'chai'
expect = chai.expect
chai.should()
Const = require('../const.coffee')
Piece = require('../piece.coffee')
Board = require('../board.coffee')
Player = require('../player.coffee')

describe '--- 9reading', ->
    b = null
    ff = null; fy = null; fk = null; fg = null; fx = null; fm = null; fh = null; fo = null;
    sf = null; sy = null; sk = null; sg = null; sx = null; sm = null; sh = null; so = null;
    first = null; second = null;
    ret = []
    before ->
        first = new Player(Const.FIRST, false, 7)
        second = new Player(Const.SECOND, false, 7)
    beforeEach ->        
        b = new Board()
        fo = new Piece.Ou(Const.FIRST, Const.Status.MOTIGOMA)
        # fh = new Piece.Hi(Const.FIRST, Const.Status.MOTIGOMA)
        # fm = new Piece.Ka(Const.FIRST, Const.Status.MOTIGOMA)
        # fx = new Piece.Ki(Const.FIRST, Const.Status.MOTIGOMA)
        fg = new Piece.Gi(Const.FIRST, Const.Status.MOTIGOMA)
        # fk = new Piece.Ke(Const.FIRST, Const.Status.MOTIGOMA)
        # fy = new Piece.Ky(Const.FIRST, Const.Status.MOTIGOMA)
        # ff = new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA)
        so = new Piece.Ou(Const.SECOND, Const.Status.MOTIGOMA)
        # sh = new Piece.Hi(Const.SECOND, Const.Status.MOTIGOMA)
        # sm = new Piece.Ka(Const.SECOND, Const.Status.MOTIGOMA)
        sx = new Piece.Ki(Const.SECOND, Const.Status.MOTIGOMA)
        # sg = new Piece.Gi(Const.SECOND, Const.Status.MOTIGOMA)
        # sk = new Piece.Ke(Const.SECOND, Const.Status.MOTIGOMA)
        # sy = new Piece.Ky(Const.SECOND, Const.Status.MOTIGOMA)
        # sf = new Piece.Fu(Const.SECOND, Const.Status.MOTIGOMA)
    describe 'FIRST trace 1 step', ->
        it 'expects move fg [2,2] when 1 step', ->
            b.add(fo); b.add(so); b.add(fg); b.add(sx)
            b.move_capture(fo, [3,3])
            b.move_capture(so, [1,1])
            b.display()            
            ret = first.prepare(b, second, first.depth, Const.MAX_VALUE)
            expect(ret[0].kind()).to.equal('Gi')
            expect(ret[1]).to.deep.equal([2,2])            
    describe 'SECOND trace 2 step', ->
        it 'expects move so [1,2] when 2 step', ->
            b.add(fo); b.add(so); b.add(fg); b.add(sx)
            b.move_capture(fo, [3,3])
            b.move_capture(so, [1,1])
            b.move_capture(fg, [2,2])
            b.display()
            ret = second.prepare(b, first, second.depth, Const.MIN_VALUE)
            expect(ret[0].kind()).to.equal('Ou')
            expect(ret[1]).to.deep.equal([1,2])            
    describe 'FIRST trace 3 step', ->
        it 'expects move fo [3,2] when 3 step', ->
            b.add(fo); b.add(so); b.add(fg); b.add(sx)
            b.move_capture(fo, [3,3])
            b.move_capture(so, [1,1])
            b.move_capture(fg, [2,2])
            b.move_capture(so, [1,2])
            b.display()            
            ret = first.prepare(b, second, first.depth, Const.MAX_VALUE)
            expect(ret[0].kind()).to.equal('Ou')
            expect(ret[1]).to.deep.equal([3,2])            
    describe 'SECOND trace 4 step', ->
        it 'expects move sx [2,3] when 4 step', ->
            b.add(fo); b.add(so); b.add(fg); b.add(sx)
            b.move_capture(fo, [3,3])
            b.move_capture(so, [1,1])
            b.move_capture(fg, [2,2])
            b.move_capture(so, [1,2])
            b.move_capture(fo, [3,2])            
            b.display()
            ret = second.prepare(b, first, second.depth, Const.MIN_VALUE)
            expect(ret[0].kind()).to.equal('Ki')
            expect(ret[1]).to.deep.equal([2,3])            
    describe 'FIRST trace 5 step', ->
        it 'expects move fg [2,1] when 5 step', ->
            b.add(fo); b.add(so); b.add(fg); b.add(sx)
            b.move_capture(fo, [3,3])
            b.move_capture(so, [1,1])
            b.move_capture(fg, [2,2])
            b.move_capture(so, [1,2])
            b.move_capture(fo, [3,2])
            b.move_capture(sx, [2,3])                        
            b.display()            
            ret = first.prepare(b, second, first.depth, Const.MAX_VALUE)
            expect(ret[0].kind()).to.equal('Gi')
            expect(ret[1]).to.deep.equal([3,1])
            expect(ret[0].status).to.equal(Const.Status.OMOTE)
    describe 'SECOND trace 6 step', ->
        it 'expects move so [1,3] when 6 step', ->
            b.add(fo); b.add(so); b.add(fg); b.add(sx)
            b.move_capture(fo, [3,3])
            b.move_capture(so, [1,1])
            b.move_capture(fg, [2,2])
            b.move_capture(so, [1,2])
            b.move_capture(fo, [3,2])
            b.move_capture(sx, [2,3])
            b.move_capture(fg, [2,1])
            fg.status = Const.Status.OMOTE
            b.display()
            ret = second.prepare(b, first, second.depth, Const.MIN_VALUE)
            expect(ret[0].kind()).to.equal('Ou')
            expect(ret[1]).to.deep.equal([1,3])            
    afterEach ->
        console.log(ret)
        if ret[0]?
            if b.check_move(ret[0], ret[1])
                b.move_capture(ret[0], ret[1])
                ret[0].status = Const.Status.URA if ret[3]
        else
            console.log("AI resigned.")
        b.display()
