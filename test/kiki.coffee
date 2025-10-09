chai = require 'chai'
expect = chai.expect
chai.should()
Const = require('../const.coffee')
Piece = require('../piece.coffee')
Board = require('../board.coffee')
Player = require('../player.coffee')

describe '=== touch check', ->
    b = null
    first = null; second = null;
    ret = []
    before ->
        first = new Player(Const.FIRST, false)
        second = new Player(Const.SECOND, false)
    beforeEach ->
        Board.promotion_line = [1,3]
        b = new Board()
        b.setPiece(new Piece.Ou(Const.FIRST, Const.Status.OMOTE), 3, 3)
        b.setPiece(new Piece.Ou(Const.SECOND, Const.Status.OMOTE), 1, 1)
        b.setPiece(new Piece.Ka(Const.FIRST, Const.Status.OMOTE), 2, 3)
        b.setPiece(new Piece.Ka(Const.SECOND, Const.Status.OMOTE), 2, 1)
        b.addMotigoma(new Piece.Hi(Const.FIRST, Const.Status.MOTIGOMA), Const.FIRST)
        b.addMotigoma(new Piece.Hi(Const.SECOND, Const.Status.MOTIGOMA), Const.SECOND)
        b.addMotigoma(new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA), Const.FIRST)
        b.addMotigoma(new Piece.Fu(Const.SECOND, Const.Status.MOTIGOMA), Const.SECOND)
        b.display()
    describe '--- 1手目', ->
        it 'expects Hi check_move [3,1] is true -1', ->
            expect(b.check_move(b.getMotigoma(Const.FIRST, 'Hi'), [3, 1])[0]).to.be.true
    describe '--- 1手目', ->
        it 'expects return [] when move_capture -2', ->
            expect(b.move_capture(b.getMotigoma(Const.FIRST, 'Hi'), [3, 1]).s_posi).to.deep.equal([])
    describe '--- 1手目', ->
        it 'expects Ou is not kiki -3', ->
            b.move_capture(b.getMotigoma(Const.FIRST, 'Hi'), [3, 1])
            # b.move_capture(b.pieces[2], [3,1])
            b.make_kiki(second.turn)
            king = (v for v in b.getPieces(Const.FIRST) when v.name=='Ou')[0]
            console.log(b.kiki[second.turn])
            expect(b.kiki[second.turn]).to.deep.not.include(b.getPiecePosition(king))
    describe '--- 2手目-1', ->
        it 'expects Fu check_move [2,2] is true -1', ->
            sf = b.getMotigoma(Const.SECOND, 'Fu')
            expect(b.check_move(sf, [2,2])[0]).to.be.true
    describe '--- 2手目-1', ->
        it 'expects return [] when move_capture -2', ->
            sf = b.getMotigoma(Const.SECOND, 'Fu')
            expect(b.move_capture(sf, [2,2]).s_posi).to.deep.equal([])
    describe '--- 2手目-1 後手２二歩は指せる', ->
        it 'expects Ou is not kiki -3', ->
            b.check_move(b.getMotigoma(Const.FIRST, 'Hi'), [3,1])
            b.move_capture(b.getMotigoma(Const.FIRST, 'Hi'), [3,1])
            b.check_move(b.getMotigoma(Const.SECOND, 'Fu'), [2,2])
            b.move_capture(b.getMotigoma(Const.SECOND, 'Fu'), [2,2])
            b.make_kiki(first.turn)
            king = (v for v in b.getPieces(Const.SECOND) when v.name=='Ou')[0]
            console.log(b.kiki[first.turn])
            expect(b.kiki[first.turn]).to.deep.not.include(b.getPiecePosition(king))
    describe '--- 2手目-2', ->
        it 'expects Ka check_move [3,2] is true -1', ->
            sm = (v for v in b.getPieces(Const.SECOND) when v.name=='Ka')[0]
            expect(b.check_move(sm, [3,2])[0]).to.be.true
    describe '--- 2手目-2', ->
        it 'expects return [2,1] when move_capture -2', ->
            sm = (v for v in b.getPieces(Const.SECOND) when v.name=='Ka')[0]
            expect(b.move_capture(sm, [3,2]).s_posi).to.deep.equal([2,1])
    describe '--- 2手目-2 後手３二角は指せない（王手放置）', ->
        it 'expects Ou is not kiki -3', ->
            b.check_move(b.getMotigoma(Const.FIRST, 'Hi'), [3,1])
            b.move_capture(b.getMotigoma(Const.FIRST, 'Hi'), [3,1])
            sm = (v for v in b.getPieces(Const.SECOND) when v.name=='Ka')[0]
            b.check_move(sm, [3,2])
            b.move_capture(sm, [3,2])
            b.make_kiki(first.turn)
            king = (v for v in b.getPieces(Const.SECOND) when v.name=='Ou')[0]
            console.log(b.kiki[first.turn])
            expect(b.kiki[first.turn]).to.deep.include(b.getPiecePosition(king))
    afterEach ->
        b.display()
