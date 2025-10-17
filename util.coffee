Const = require('./const')
Piece = require('./piece')

class MoveDiff
    constructor: (@piece, @s_posi, @dest, @d_posi, @pieceStatus, @destTurn, @destStatus) ->

class BestMove
    constructor: (@lastkoma = null, @lastposi = [], @lastscore = 0, @laststatus = 0, spare = null) ->
        @spare = spare

    update: (lastkoma, lastposi, lastscore, laststatus) ->
        @spare = new BestMove.Spare @lastkoma, @lastposi, @lastscore, @laststatus
        @lastkoma = lastkoma
        @lastposi = lastposi
        @lastscore  = lastscore
        @laststatus = laststatus

BestMove.Spare = class Spare
    constructor: (@lastkoma = null, @lastposi = null, @lastscore = 0, @laststatus = null) ->

module.exports = 
    MoveDiff: MoveDiff
    BestMove: BestMove
