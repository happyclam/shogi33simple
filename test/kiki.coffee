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
        b.pieces = []
        b.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,3]))
        b.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,1]))
        b.pieces.push(new Piece.Hi(Const.FIRST, Const.Status.MOTIGOMA))
        b.pieces.push(new Piece.Hi(Const.SECOND, Const.Status.MOTIGOMA))
        b.pieces.push(new Piece.Ka(Const.FIRST, Const.Status.OMOTE, [2,3]))
        b.pieces.push(new Piece.Ka(Const.SECOND, Const.Status.OMOTE, [2,1]))
        b.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA))
        b.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.MOTIGOMA))
        b.display()
    describe '--- 1手目', ->
        it 'expects Hi check_move [3,1] is true -1', ->
            expect(b.check_move(b.pieces[2], [3,1])).to.be.true
    describe '--- 1手目', ->
        it 'expects return [] when move_capture -2', ->
            expect(b.move_capture(b.pieces[2], [3,1])).to.deep.equal([])
    describe '--- 1手目', ->
        it 'expects Ou is not kiki -3', ->
            b.move_capture(b.pieces[2], [3,1])
            b.make_kiki(second.turn)
            king = (v for v in b.pieces when v.kind() == 'Ou' && v.turn == first.turn)[0]
            console.log(b.kiki[second.turn])
            expect(b.kiki[second.turn]).to.deep.not.include(king.posi)
    describe '--- 2手目-1', ->
        it 'expects Fu check_move [2,2] is true -1', ->
            expect(b.check_move(b.pieces[7], [2,2])).to.be.true
    describe '--- 2手目-1', ->
        it 'expects return [] when move_capture -2', ->
            expect(b.move_capture(b.pieces[7], [2,2])).to.deep.equal([])
    describe '--- 2手目-1 後手２二歩は指せる', ->
        it 'expects Ou is not kiki -3', ->
            b.check_move(b.pieces[2], [3,1])
            b.move_capture(b.pieces[2], [3,1])
            b.check_move(b.pieces[7], [2,2])
            b.move_capture(b.pieces[7], [2,2])
            b.make_kiki(first.turn)
            king = (v for v in b.pieces when v.kind() == 'Ou' && v.turn == second.turn)[0]
            console.log(b.kiki[first.turn])
            expect(b.kiki[first.turn]).to.deep.not.include(king.posi)
    describe '--- 2手目-2', ->
        it 'expects Ka check_move [3,2] is true -1', ->
            expect(b.check_move(b.pieces[5], [3,2])).to.be.true
    describe '--- 2手目-2', ->
        it 'expects return [2,1] when move_capture -2', ->
            expect(b.move_capture(b.pieces[5], [3,2])).to.deep.equal([2,1])
    describe '--- 2手目-2 後手３二角は指せない（王手放置）', ->
        it 'expects Ou is not kiki -3', ->
            b.check_move(b.pieces[2], [3,1])
            b.move_capture(b.pieces[2], [3,1])
            b.check_move(b.pieces[5], [3,2])
            b.move_capture(b.pieces[5], [3,2])
            b.make_kiki(first.turn)
            king = (v for v in b.pieces when v.kind() == 'Ou' && v.turn == second.turn)[0]
            console.log(b.kiki[first.turn])
            expect(b.kiki[first.turn]).to.deep.include(king.posi)
    afterEach ->
        b.display()
