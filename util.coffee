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

    clone: ->
        new BestMove(
            if @lastkoma? then @lastkoma.clone() else null,
            Array.from(@lastposi ? []),
            @lastscore,
            @laststatus,
            if @spare? then new BestMove.Spare(
                if @spare.lastkoma? then @spare.lastkoma.clone() else null,
                Array.from(@spare.lastposi ? []),
                @spare.lastscore,
                @spare.laststatus
            ) else null
        )

    restore: ->
        return unless @spare?
        @lastkoma   = if @spare.lastkoma?.clone? then @spare.lastkoma.clone() else @spare.lastkoma
        @lastposi   = Array.from(@spare.lastposi ? [])
        @lastscore  = @spare.lastscore
        @laststatus = @spare.laststatus

        @spare = null

BestMove.Spare = class Spare
    constructor: (@lastkoma = null, @lastposi = null, @lastscore = 0, @laststatus = null) ->

module.exports = 
    MoveDiff: MoveDiff
    BestMove: BestMove
