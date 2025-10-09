chai = require 'chai'
expect = chai.expect
chai.should()
Const = require('../const.coffee')
Piece = require('../piece.coffee')
Board = require('../board.coffee')
Player = require('../player.coffee')

describe '--- Board1', ->
    b = null
    ff = null; fg = null; fo = null; so = null; sg = null; sf = null; fh = null;
    before ->
        b = new Board()
        b.set_standard()
        fo = b.getPiece(3, 3)
        fg = b.getMotigoma(Const.FIRST, 'Gi')
        ff = b.getMotigoma(Const.FIRST, 'Fu')
        so = b.getPiece(1, 1)
        sg = b.getMotigoma(Const.SECOND, 'Gi')
        sf = b.getMotigoma(Const.SECOND, 'Fu')
        fh = b.setPiece(new Piece.Hi(Const.FIRST, Const.Status.OMOTE), 3, 1)
        b.display()
    describe 'ff check_move [1,1]', ->
        it 'should return false when already exist', ->
            b.check_move(ff, [1, 1])[0].should.equal false
    describe 'ff check_move [2,1]', ->
        it 'should return false when no place to go', ->
            b.check_move(ff, [2, 1])[0].should.equal false
    describe 'ff check_move [1,2]', ->
        it 'should return true when ordinary case of motigoma', ->
            b.check_move(ff, [1, 2])[0].should.equal true
    describe 'fo check_move [2,2]', ->
        it 'should return true when ordinary case on board', ->
            b.check_move(fo, [2,2])[0].should.equal true
    describe 'fh check_move [2,2]', ->
        it 'should return false when hi illegal move', ->
            b.check_move(fh, [2,2])[0].should.equal false
    describe 'fo check_promotion', ->
        it 'expects false when Ou promote', ->
            expect(b.check_promotion(fo, [2,3])).to.be.false
    describe 'fh check_move [1,1]', ->
        it 'expects true when Hi yoko move', ->
            expect(b.check_move(fh, [1,1])[0]).to.be.true
    describe 'fh move_capture [1,1]', ->
        it 'expect src piece posi changed captured posi when Hi capture Ou', ->
            b.move_capture(fh, [1,1])
            expect(b.getPiece(1, 1).name).equal('Hi')
    after ->
        console.log(fh)
        b.display()

describe '--- Board2', ->
    b = null
    piece = null
    before ->
        b = new Board()
        b.set_standard()
        b.display()
    describe 'move_capture(fg, [2,2])', ->
        it 'expects [] when motigoma Gi move_capture [2,2]', ->
            piece = b.getMotigoma(Const.FIRST, 'Gi')
            expect(b.move_capture(piece, [2,2]).s_posi).to.deep.equal([])
    describe 'move_capture(fg, [2,2])', ->
        it 'expects [2,2] when Gi moved', ->
            expect(b.getPiecePosition(piece)).to.deep.equal([2,2])
    describe 'move_capture(fg, [2,2])', ->
        it 'expects status=OMOTE when Gi moved', ->
            piece = b.getPiece(2, 2)
            expect(piece.status).to.equal(Const.Status.OMOTE)
    describe 'move_capture(so, [1,2])', ->
        it 'expects original position when Ou move_capture [1,2]', ->
            piece = b.getPiece(1, 1)
            expect(b.move_capture(piece, [1,2]).s_posi).to.deep.equal([1,1])
    describe 'move_capture(so, [1,2])', ->
        it 'expects [1,2] when Ou moved', ->
            piece = b.getPiece(1, 2)
            expect(b.getPiecePosition(piece)).to.deep.equal([1,2])
    describe 'move_capture(so, [1,2])', ->
        it 'expects status=OMOTE when Ou moved', ->
            piece = b.getPiece(1, 2)
            expect(piece.status).to.equal(Const.Status.OMOTE)
    describe 'move_capture(ff, [1,3]) utifudume check', ->
        it 'expects false when Fu move_capture [1,3]', ->
            piece = b.getMotigoma(Const.FIRST, 'Fu')
            expect(b.check_utifudume(piece, [1,3])).to.be.true
    describe 'move_capture(ff, [1,3]) utifudume check', ->
        it 'expects status=MOTIGOMA when Fu move failed', ->
            piece = b.getMotigoma(Const.FIRST, 'Fu')
            expect(piece.status).to.equal(Const.Status.MOTIGOMA)
    after ->
        b.display()

describe '--- Board3', ->
    b = null
    piece = null
    pieces = []
    before ->
        b = new Board()
        b.set_standard()
        b.display()
    describe 'move_capture(fg, [2,2])', ->
        it 'expects true when motigoma Gi move_capture [2,2]', ->
            # piece = v for v in b.pieces when v.name == 'Gi' && v.turn == Const.FIRST
            piece = b.getMotigoma(Const.FIRST, 'Gi')
            expect(b.move_capture(piece, [2,2]).s_posi).to.deep.equal([])
    describe 'move_capture(fg, [2,2])', ->
        it 'expects [2,2] when motigoma Gi moved', ->
            expect(b.getPiecePosition(piece)).to.deep.equal([2,2])
    describe 'move_capture(sf, [3,1])', ->
        it 'expects true when motigoma Fu move_capture [3,1]', ->
            piece = b.getMotigoma(Const.SECOND, 'Fu')
            expect(b.move_capture(piece, [3,1]).s_posi).to.deep.equal([])
    describe 'move_capture(fg, [3,1])', ->
        it 'expects [3,1] when motigoma Fu moved', ->
            expect(b.getPiecePosition(piece)).to.deep.equal([3,1])
    describe 'move_capture(fg, [2,1])', ->
        it 'expects original position when Gi move_capture [2,2]', ->
            piece = b.getPiece(2, 2)
            expect(b.move_capture(piece, [2,1]).s_posi).to.deep.equal([2,2])
    describe 'move_capture(fg, [2,1])', ->
        it 'expects status=OMOTE when Gi moved', ->
            expect(piece.status).to.equal(Const.Status.OMOTE)
    describe 'move_capture(sf, [3,2])', ->
        it 'expects original position [3,1] when Fu move_capture [3,2]', ->
            piece = b.getPiece(3, 1)
            expect(b.move_capture(piece, [3,2]).s_posi).to.deep.equal([3,1])
    describe 'move_capture(fg, [3,2])', ->
        it 'expects status=OMOTE when Fu moved', ->
            expect(piece.status).to.equal(Const.Status.OMOTE)
    describe 'check_move(sf, [3,3])', ->
        it 'expects true when Fu check moved', ->
            piece = b.getPiece(3, 2)
            expect(b.check_move(piece, [3,3])[0]).to.be.true
    describe 'check_move(sf, [3,3])', ->
        it 'expects status changed URA when check moved', ->
#            expect(piece.status).to.equal(Const.Status.URA)          
            expect(b.check_move(piece, [3,3])[1]).to.be.true          
    describe 'move_capture(sf, [3,3])', ->
        it 'expects original position [3,2] when Fu move_capture [3,3]', ->
            piece = b.getPiece(3, 2)
            expect(b.move_capture(piece, [3,3]).s_posi).to.deep.equal([3,2])
    describe 'move_capture(sf, [3,3])', ->
        it 'expects captured pieces status changed when Fu moved', ->
            # pieces = (v for v in b.pieces when v.name == "Ou" && v.turn == Const.SECOND)
            expect(b.getMotigoma(Const.SECOND, 'Ou').name).to.equal('Ou')
    after ->
        b.display()

describe '--- Board4', ->
    b = null
    piece = null
    before ->
        b = new Board()
        b.set_standard()
        b.display()
    describe 'FIRST move_capture(ff, [3,2])', ->
        it 'expects original position null when motigoma Fu move_capture [3,2]', ->
            piece = b.getMotigoma(Const.FIRST, 'Fu')
            expect(b.move_capture(piece, [3,2]).s_posi).to.deep.equal([])
            b.display()
    describe 'FIRST check_move(ff, [3,1])', ->
        it 'expects true when Fu check moved', ->
            piece = b.getPiece(3, 2)
            expect(b.check_move(piece, [3,1])[0]).to.be.true
            b.display()
    describe 'FIRST check_move(ff, [3,1])', ->
        it 'expects status==URA when no place to go', ->
            piece = b.getPiece(3, 2)
            expect(b.check_move(piece, [3,1])[1]).to.be.true
            # b.move_capture(piece, [3,1], true)
            # expect(piece.status).to.equal(Const.Status.URA)            
            # b.display()
    describe 'FIRST move_capture(ff, [3,1])', ->
        it 'expects original position [3,2] when Fu move_capture [3,3]', ->
            piece = b.getPiece(3, 2)
            expect(b.move_capture(piece, [3,1]).s_posi).to.deep.equal([3,2])
    describe 'SECOND move_capture(sf, [2,2])', ->
        it 'expects original position [null] when motigoma Fu move_capture [2,2]', ->
            piece = b.getMotigoma(Const.SECOND, 'Fu')
            expect(b.move_capture(piece, [2,2]).s_posi).to.deep.equal([])
            b.display()
    describe 'SECOND check_move(sf, [2,3])', ->
        it 'expects true when Fu check moved', ->
            expect(b.check_move(piece, [2,3])[0]).to.be.true
    describe 'SECOND check_move(sf, [2,3])', ->
        it 'expects status==URA when no place to go', ->
            piece = (v for v in b.getPieces(Const.SECOND) when v.name=='Fu')[0]
            expect(piece.status).to.equal(Const.Status.OMOTE)
            b.display()
    describe 'move_capture(sf, [2,3])', ->
        it 'expects original position [2,2] when Fu move_capture [2,3]', ->
            expect(b.move_capture(piece, [2,3], true).s_posi).to.deep.equal([2,2])
            expect(piece.status).to.equal(Const.Status.URA)
    after ->
        b.display()

describe '--- Board5', ->
    b = null
    ff = null; fg = null; fo = null; so = null; sg = null; sf = null; fh = null;
    first = null; second = null;
    piece = null
    ret = []
    before ->
        first = new Player(Const.FIRST, false)
        second = new Player(Const.SECOND, false)
    beforeEach ->
        b = new Board()
        b.set_standard()
        # ff = (v for v in b.pieces when v.name == 'Fu' && v.turn == Const.FIRST)[0]
        # sf = (v for v in b.pieces when v.name == 'Fu' && v.turn == Const.SECOND)[0]
        # fg = (v for v in b.pieces when v.name == 'Gi' && v.turn == Const.FIRST)[0]
        # sg = (v for v in b.pieces when v.name == 'Gi' && v.turn == Const.SECOND)[0]
        # fo = (v for v in b.pieces when v.name == 'Ou' && v.turn == Const.FIRST)[0]
        # so = (v for v in b.pieces when v.name == 'Ou' && v.turn == Const.SECOND)[0]
    describe '二歩 check1', ->
        it 'expects false when nifu', ->
            sf2 = new Piece.Fu(Const.SECOND, Const.Status.OMOTE)
            b.addMotigoma(sf2, Const.SECOND)
            b.move_capture(sf2, [2,1])
            sf = b.getMotigoma(Const.SECOND, 'Fu')
            expect(b.check_move(sf, [2, 2])[0]).to.be.false
    describe '二歩 check2', ->
        it 'expects true when not nifu', ->
            sf2 = new Piece.Fu(Const.SECOND, Const.Status.OMOTE)
            b.addMotigoma(sf2, Const.SECOND)
            ff = b.getMotigoma(Const.SECOND, 'Fu')
            b.move_capture(sf2, [2,1])
            expect(b.check_move(ff, [1,2])[0]).to.be.true
            b.move_capture(ff, [1,2])
    describe '二歩 check3', ->
        it 'expects true when not nifu', ->
            ff2 = new Piece.Fu(Const.FIRST, Const.Status.OMOTE)
            b.addMotigoma(ff2, Const.FIRST)
            b.move_capture(ff2, [1,2])
            ff = b.getMotigoma(Const.FIRST, 'Fu')
            expect(b.check_move(ff, [1,3])[0]).to.be.false
    describe 'と金と歩を持っている時の処理', ->
        it 'expects true when not nifu', ->
            ff2 = new Piece.Fu(Const.FIRST, Const.Status.OMOTE)
            b.addMotigoma(ff2, Const.FIRST)
            b.move_capture(ff2, [2,2])
            # 強制成りのテスト
            ret = b.check_move(ff2, [2,1])
            expect(ret[0]).to.be.true
            expect(ret[1]).to.be.true
            b.move_capture(ff2, [2,1], ret[1])
            ff = b.getMotigoma(Const.FIRST, 'Fu')
            expect(b.check_move(ff, [2,2])[0]).to.be.true
    describe '打ち歩詰め check1', ->
        it 'expects false when not utifudume', ->
            fg = b.getMotigoma(Const.FIRST, 'Gi')
            b.move_capture(fg, [2,3])
            ff = b.getMotigoma(Const.FIRST, 'Fu')
            expect(b.check_utifudume(ff, [1,2])).to.be.false
    describe '打ち歩詰め check2', ->
        it 'expects false when not utifudume', ->
            fg = b.getMotigoma(Const.FIRST, 'Gi')
            b.move_capture(fg, [2,2])
            so = b.getPiece(1, 1)
            b.move_capture(so, [1,2])
            b.move_capture(fg, [3,1])
            fg.status = Const.Status.URA
            sf = b.getMotigoma(Const.SECOND, 'Fu')
            b.move_capture(sf, [2,2])
            ff = b.getMotigoma(Const.FIRST, 'Fu')
            expect(b.check_move(ff, [1,3])[0]).to.be.true
    describe '持ち歩一枚、と金一個ある時の処理', ->
        it 'expects true when not nifu', ->
            ff2 = new Piece.Fu(Const.FIRST, Const.Status.OMOTE)
            b.addMotigoma(ff2, Const.FIRST)
            ff = b.getMotigoma(Const.FIRST, 'Fu')
            fo = b.getPiece(3, 3)
            b.move_capture(fo, [3,1])
            b.move_capture(ff, [2,1])
            ff.status=Const.Status.URA
            so = b.getPiece(1, 1)
            b.move_capture(so, [2,3])
            sg = b.getMotigoma(Const.SECOND, 'Gi')
            b.move_capture(sg, [1,3])
            sg.status=Const.Status.URA
            sf = b.getMotigoma(Const.SECOND, 'Fu')
            expect(b.check_move(sf, [2,2])[0]).to.be.true
    afterEach ->
        b.display()
