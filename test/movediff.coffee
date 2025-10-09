chai = require 'chai'
expect = chai.expect
assert = require 'assert'
Const = require('../const.coffee')
Piece = require('../piece.coffee')
Board = require('../board.coffee')
Player = require('../player.coffee')
Util = require('../util.coffee')

describe 'BestMove', ->
  board = null
  first = null; second = null;
  before ->
    first = new Player(Const.FIRST, false)
    second = new Player(Const.SECOND, false)
  beforeEach ->
    board = new Board(3, 3)
    board.set_standard()
  describe 'think1', ->
    it 'return bestmove', ->
      bestmove = first.think(board, second, 1, Const.MAX_VALUE)
      console.log("===== bestmove = #{JSON.stringify(bestmove)}")
      expect(bestmove.lastkoma.name).to.equal('Gi')
      board.move_capture(bestmove.lastkoma, bestmove.lastposi)
  describe 'think2', ->
    it 'return bestmove', ->
      bestmove = first.think(board, second, 1, Const.MAX_VALUE)
      console.log("===== bestmove = #{JSON.stringify(bestmove)}")
      expect(bestmove.lastkoma.name).to.equal('Gi')
      board.move_capture(bestmove.lastkoma, bestmove.lastposi)
  describe 'revert_move', ->
    it 'should revert board move', ->
      piece = board.getPiece(3, 3)
      snapshot = board.move_capture(piece, [3, 2])
      board.revert_move(snapshot)
      assert.deepEqual board.pieceIndex[piece.id], [3, 3]

    it 'should revert motigoma place', ->
      piece = board.getMotigoma(Const.FIRST, 'Gi')
      snapshot = board.move_capture(piece, [3, 1])
      board.revert_move(snapshot)
      assert.equal board.getPiece(2, 2), null
      assert.equal board.isMotigoma(piece), true
      assert.equal board.motigoma[Const.FIRST][piece.name].length, 1

    it 'should revert board move', ->
      piece = board.getPiece(3, 3)
      snapshot = board.move_capture(piece, [2, 2])
      board.revert_move(snapshot)
      assert.deepEqual board.pieceIndex[piece.id], [3, 3]

    it 'should revert capture move', ->
      fOu = board.getPiece(3, 3)
      board.move_capture(fOu, [2, 2])
      sOu = board.getPiece(1, 1)
      snapshot = board.move_capture(sOu, [2, 2])
      # console.log("pieceIndex = #{JSON.stringify(board.pieceIndex)}")      
      # console.log("board = #{JSON.stringify(board)}")
      # console.log("snapshot = #{JSON.stringify(snapshot)}")
      board.revert_move(snapshot)
      # console.log("board = #{JSON.stringify(board)}")
      # console.log("board.motigoma[FIRST] = #{JSON.stringify(board.motigoma[Const.FIRST])}")
      # console.log("board.motigoma[SECOND] = #{JSON.stringify(board.motigoma[Const.SECOND])}")
      # console.log("pieceIndex = #{JSON.stringify(board.pieceIndex)}")
      assert.deepEqual board.pieceIndex[sOu.id], [1, 1]
      assert.deepEqual board.pieceIndex[fOu.id], [2, 2]

  afterEach ->
    board.display()
