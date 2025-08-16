Const = require('./const')

@getClass = (classname) ->
    return switch classname
        when 'Ou' then gOu
        when 'Hi' then gHi
        when 'Ka' then gKa
        when 'Ki' then gKi
        when 'Gi' then gGi
        when 'Ke' then gKe
        when 'Ky' then gKy
        when 'Fu' then gFu
        else gPiece
            
class Course
    constructor: (series = false, xd = 0, yd = 0) ->
        @series = series
        @xd = xd
        @yd = yd

class Piece
    constructor: (@turn, @status, @posi = null) ->
        @posi = if @posi? then @posi.concat() else []
        @id = uniqueId.call @
        @coefficient = 0.0
    setTurn: (turn) ->
        if turn != @turn
            @turn = turn
    uniqueId = (length = 8) ->
        id = ""
        id += Math.random().toString(36).substr(2) while id.length < length
        return id.substr 0, length

class Ou extends Piece
    _direction = {}
    _direction[Const.Status.OMOTE] = {}
    _direction[Const.Status.URA] = {}
    _direction[Const.Status.MOTIGOMA] = {}
    _direction[Const.Status.OMOTE][Const.FIRST] = [new Course(false, 0, -1), new Course(false, -1, -1), new Course(false, -1, 0), new Course(false, -1, 1), new Course(false, 0, 1), new Course(false, 1, 1), new Course(false, 1, 0), new Course(false, 1, -1)]
    _direction[Const.Status.OMOTE][Const.SECOND] = [new Course(false, 0, 1), new Course(false, 1, 1), new Course(false, 1, 0), new Course(false, 1, -1), new Course(false, 0, -1), new Course(false, -1, -1), new Course(false, -1, 0), new Course(false, -1, 1)]
    _direction[Const.Status.URA][Const.FIRST] = []
    _direction[Const.Status.URA][Const.SECOND] = []
    _direction[Const.Status.MOTIGOMA][Const.FIRST] = []
    _direction[Const.Status.MOTIGOMA][Const.SECOND] = []
    @potential = [8, 8, 8]
    @getD: (turn, status) ->
        return _direction[status][turn]

    constructor: (turn, status, posi) ->
        super(turn, status, posi)
        @name = 'Ou'
    kind: ->
        @constructor.name
    koma: ->
        return "OU"
    omomi: ->
        ret = switch @status
            when Const.Status.OMOTE then 9999
            when Const.Status.URA then 9999
            when Const.Status.MOTIGOMA then 9999
            else 0
        return ret
    caption: ->
        switch @status
            when Const.Status.OMOTE
                if @turn == Const.FIRST then 'O' else 'o'
            when Const.Status.URA
                if @turn == Const.FIRST then 'O' else 'o'
            when Const.Status.MOTIGOMA
                if @turn == Const.FIRST then 'O' else 'o'

class Hi extends Piece
    _direction = {}
    _direction[Const.Status.OMOTE] = {}
    _direction[Const.Status.URA] = {}
    _direction[Const.Status.MOTIGOMA] = {}
    _direction[Const.Status.OMOTE][Const.FIRST] = [new Course(true, 0, -1), new Course(true, -1, 0), new Course(true, 0, 1), new Course(true, 1, 0)]
    _direction[Const.Status.OMOTE][Const.SECOND] = [new Course(true, 0, 1), new Course(true, 1, 0), new Course(true, 0, -1), new Course(true, -1, 0)]
    _direction[Const.Status.URA][Const.FIRST] = [new Course(true, 0, -1), new Course(false, -1, -1), new Course(true, -1, 0), new Course(false, -1, 1), new Course(true, 0, 1), new Course(false, 1, 1), new Course(true, 1, 0), new Course(false, 1, -1)]
    _direction[Const.Status.URA][Const.SECOND] = [new Course(true, 0, 1), new Course(false, 1, 1), new Course(true, 1, 0), new Course(false, 1, -1), new Course(true, 0, -1), new Course(false, -1, -1), new Course(true, -1, 0), new Course(false, -1, 1)]
    _direction[Const.Status.MOTIGOMA][Const.FIRST] = [new Course(true, 0, -1), new Course(true, -1, 0), new Course(true, 0, 1), new Course(true, 1, 0)]
    _direction[Const.Status.MOTIGOMA][Const.SECOND] = [new Course(true, 0, 1), new Course(true, 1, 0), new Course(true, 0, -1), new Course(true, -1, 0)]
    @potential = [8, 8, 8]
    @getD: (turn, status) ->
        return _direction[status][turn]

    constructor: (turn, status, posi) ->
        super(turn, status, posi)
        @name = 'Hi'
    kind: ->
        @constructor.name
    koma: ->
        return if @status == Const.Status.URA then "RY" else "HI"
    omomi: ->
        ret = switch @status
            when Const.Status.OMOTE
                85 * (1 + @coefficient / Hi.potential[@status])
            when Const.Status.URA
                110 * (1 + @coefficient / Hi.potential[@status])
            when Const.Status.MOTIGOMA
                75
            else 0
        return parseInt(ret, 10)
    caption: ->
        switch @status
            when Const.Status.OMOTE
                if @turn == Const.FIRST then 'H' else 'h'
            when Const.Status.URA
                if @turn == Const.FIRST then 'R' else 'r'
            when Const.Status.MOTIGOMA
                if @turn == Const.FIRST then 'H' else 'h'

class Ka extends Piece
    _direction = {}
    _direction[Const.Status.OMOTE] = {}
    _direction[Const.Status.URA] = {}
    _direction[Const.Status.MOTIGOMA] = {}
    _direction[Const.Status.OMOTE][Const.FIRST] = [new Course(true, -1, -1), new Course(true, -1, 1), new Course(true, 1, 1), new Course(true, 1, -1)]
    _direction[Const.Status.OMOTE][Const.SECOND] = [new Course(true, 1, 1), new Course(true, 1, -1), new Course(true, -1, -1), new Course(true, -1, 1)]
    _direction[Const.Status.URA][Const.FIRST] = [new Course(false, 0, -1), new Course(true, -1, -1), new Course(false, -1, 0), new Course(true, -1, 1), new Course(false, 0, 1), new Course(true, 1, 1), new Course(false, 1, 0), new Course(true, 1, -1)]
    _direction[Const.Status.URA][Const.SECOND] = [new Course(false, 0, 1), new Course(true, 1, 1), new Course(false, 1, 0), new Course(true, 1, -1), new Course(false, 0, -1), new Course(true, -1, -1), new Course(false, -1, 0), new Course(true, -1, 1)]
    _direction[Const.Status.MOTIGOMA][Const.FIRST] = [new Course(true, -1, -1), new Course(true, -1, 1), new Course(true, 1, 1), new Course(true, 1, -1)]
    _direction[Const.Status.MOTIGOMA][Const.SECOND] = [new Course(true, 1, 1), new Course(true, 1, -1), new Course(true, -1, -1), new Course(true, -1, 1)]
    @potential = [8, 8, 8]
    @getD: (turn, status) ->
        return _direction[status][turn]

    constructor: (turn, status, posi) ->
        super(turn, status, posi)
        @name = 'Ka'
    kind: ->
        @constructor.name
    koma: ->
        return if @status == Const.Status.URA then "UM" else "KA"
    omomi: ->
        ret = switch @status
            when Const.Status.OMOTE
                75 * (1 + @coefficient / Ka.potential[@status])
            when Const.Status.URA
                100 * (1 + @coefficient / Ka.potential[@status])
            when Const.Status.MOTIGOMA
                65
            else 0
        return parseInt(ret, 10)
    caption: ->
        switch @status
            when Const.Status.OMOTE
                if @turn == Const.FIRST then 'M' else 'm'
            when Const.Status.URA
                if @turn == Const.FIRST then 'U' else 'u'
            when Const.Status.MOTIGOMA
                if @turn == Const.FIRST then 'M' else 'm'

class Ki extends Piece
    _direction = {}
    _direction[Const.Status.OMOTE] = {}
    _direction[Const.Status.URA] = {}
    _direction[Const.Status.MOTIGOMA] = {}
    _direction[Const.Status.OMOTE][Const.FIRST] = [new Course(false, 0, -1), new Course(false, -1, -1), new Course(false, -1, 0), new Course(false, 0, 1), new Course(false, 1, 0), new Course(false, 1, -1)]
    _direction[Const.Status.OMOTE][Const.SECOND] = [new Course(false, 0, 1), new Course(false, 1, 1), new Course(false, 1, 0), new Course(false, 0, -1), new Course(false, -1, 0), new Course(false, -1, 1)]
    _direction[Const.Status.URA][Const.FIRST] = []
    _direction[Const.Status.URA][Const.SECOND] = []
    _direction[Const.Status.MOTIGOMA][Const.FIRST] = [new Course(false, 0, -1), new Course(false, -1, -1), new Course(false, -1, 0), new Course(false, 0, 1), new Course(false, 1, 0), new Course(false, 1, -1)]
    _direction[Const.Status.MOTIGOMA][Const.SECOND] = [new Course(false, 0, 1), new Course(false, 1, 1), new Course(false, 1, 0), new Course(false, 0, -1), new Course(false, -1, 0), new Course(false, -1, 1)]
    @potential = [6, 6, 6]
    @getD: (turn, status) ->
        return _direction[status][turn]

    constructor: (turn, status, posi) ->
        super(turn, status, posi)
        @name = 'Ki'
    kind: ->
        @constructor.name
    koma: ->
        return "KI"
    omomi: ->
        ret = switch @status
            when Const.Status.OMOTE
                50 * (1 + @coefficient / Ki.potential[@status])
            when Const.Status.URA
                50 * (1 + @coefficient / Ki.potential[@status])
            when Const.Status.MOTIGOMA
                45
            else 0
        return parseInt(ret, 10)
    caption: ->
        switch @status
            when Const.Status.OMOTE
                if @turn == Const.FIRST then 'X' else 'x'
            when Const.Status.URA
                if @turn == Const.FIRST then 'X' else 'x'
            when Const.Status.MOTIGOMA
                if @turn == Const.FIRST then 'X' else 'x'

class Gi extends Piece
    _direction = {}
    _direction[Const.Status.OMOTE] = {}
    _direction[Const.Status.URA] = {}
    _direction[Const.Status.MOTIGOMA] = {}
    _direction[Const.Status.OMOTE][Const.FIRST] = [new Course(false, 0, -1), new Course(false, -1, -1), new Course(false, -1, 1), new Course(false, 1, 1), new Course(false, 1, -1)]
    _direction[Const.Status.OMOTE][Const.SECOND] = [new Course(false, 0, 1), new Course(false, 1, 1), new Course(false, 1, -1), new Course(false, -1, -1), new Course(false, -1, 1)]
    _direction[Const.Status.URA][Const.FIRST] = [new Course(false, 0, -1), new Course(false, -1, -1), new Course(false, -1, 0), new Course(false, 0, 1), new Course(false, 1, 0), new Course(false, 1, -1)]
    _direction[Const.Status.URA][Const.SECOND] = [new Course(false, 0, 1), new Course(false, 1, 1), new Course(false, 1, 0), new Course(false, 0, -1), new Course(false, -1, 0), new Course(false, -1, 1)]
    _direction[Const.Status.MOTIGOMA][Const.FIRST] = [new Course(false, 0, -1), new Course(false, -1, -1), new Course(false, -1, 1), new Course(false, 1, 1), new Course(false, 1, -1)]
    _direction[Const.Status.MOTIGOMA][Const.SECOND] = [new Course(false, 0, 1), new Course(false, 1, 1), new Course(false, 1, -1), new Course(false, -1, -1), new Course(false, -1, 1)]
    @potential = [5, 6, 6]
    @getD: (turn, status) ->
        return _direction[status][turn]

    constructor: (turn, status, posi) ->
        super(turn, status, posi)
        @name = 'Gi'
    kind: ->
        @constructor.name
    koma: ->
        return if @status == Const.Status.URA then "NG" else "GI"
    omomi: ->
        ret = switch @status
            when Const.Status.OMOTE
                45 * (1 + @coefficient / Gi.potential[@status])
            when Const.Status.URA
                50 * (1 + @coefficient / Gi.potential[@status])
            when Const.Status.MOTIGOMA
                40
            else 0
        return parseInt(ret, 10)
    caption: ->
        switch @status
            when Const.Status.OMOTE
                if @turn == Const.FIRST then 'G' else 'g'
            when Const.Status.URA
                if @turn == Const.FIRST then 'N' else 'n'
            when Const.Status.MOTIGOMA
                if @turn == Const.FIRST then 'G' else 'g'

class Ke extends Piece
    _direction = {}
    _direction[Const.Status.OMOTE] = {}
    _direction[Const.Status.URA] = {}
    _direction[Const.Status.MOTIGOMA] = {}
    _direction[Const.Status.OMOTE][Const.FIRST] = [new Course(false, 1, -2), new Course(false, -1, -2)]
    _direction[Const.Status.OMOTE][Const.SECOND] = [new Course(false, -1, 2), new Course(false, 1, 2)]
    _direction[Const.Status.URA][Const.FIRST] = [new Course(false, 0, -1), new Course(false, -1, -1), new Course(false, -1, 0), new Course(false, 0, 1), new Course(false, 1, 0), new Course(false, 1, -1)]
    _direction[Const.Status.URA][Const.SECOND] = [new Course(false, 0, 1), new Course(false, 1, 1), new Course(false, 1, 0), new Course(false, 0, -1), new Course(false, -1, 0), new Course(false, -1, 1)]
    _direction[Const.Status.MOTIGOMA][Const.FIRST] = [new Course(false, 1, -2), new Course(false, -1, -2)]
    _direction[Const.Status.MOTIGOMA][Const.SECOND] = [new Course(false, -1, 2), new Course(false, 1, 2)]
    @potential = [2, 6, 6]
    @getD: (turn, status) ->
        return _direction[status][turn]

    constructor: (turn, status, posi) ->
        super(turn, status, posi)
        @name = 'Ke'
    kind: ->
        @constructor.name

    koma: ->
        return if @status == Const.Status.URA then "NK" else "KE"

    omomi: ->
        ret = switch @status
            when Const.Status.OMOTE
                30 * (1 + @coefficient / Ke.potential[@status])
            when Const.Status.URA
                50 * (1 + @coefficient / Ke.potential[@status])
            when Const.Status.MOTIGOMA
                25
            else 0
        return parseInt(ret, 10)

    caption: ->
        switch @status
            when Const.Status.OMOTE
                if @turn == Const.FIRST then 'K' else 'k'
            when Const.Status.URA
                if @turn == Const.FIRST then 'E' else 'e'
            when Const.Status.MOTIGOMA
                if @turn == Const.FIRST then 'K' else 'k'

class Ky extends Piece
    _direction = {}
    _direction[Const.Status.OMOTE] = {}
    _direction[Const.Status.URA] = {}
    _direction[Const.Status.MOTIGOMA] = {}
    _direction[Const.Status.OMOTE][Const.FIRST] = [new Course(true, 0, -1)]
    _direction[Const.Status.OMOTE][Const.SECOND] = [new Course(true, 0, 1)]
    _direction[Const.Status.URA][Const.FIRST] = [new Course(false, 0, -1), new Course(false, -1, -1), new Course(false, -1, 0), new Course(false, 0, 1), new Course(false, 1, 0), new Course(false, 1, -1)]
    _direction[Const.Status.URA][Const.SECOND] = [new Course(false, 0, 1), new Course(false, 1, 1), new Course(false, 1, 0), new Course(false, 0, -1), new Course(false, -1, 0), new Course(false, -1, 1)]
    _direction[Const.Status.MOTIGOMA][Const.FIRST] = [new Course(true, 0, -1)]
    _direction[Const.Status.MOTIGOMA][Const.SECOND] = [new Course(true, 0, 1)]
    @potential = [2, 6, 6]
    @getD: (turn, status) ->
        return _direction[status][turn]

    constructor: (turn, status, posi) ->
        super(turn, status, posi)
        @name = 'Ky'
    kind: ->
        @constructor.name
    koma: ->
        return if @status == Const.Status.URA then "NY" else "KY"
    omomi: ->
        ret = switch @status
            when Const.Status.OMOTE
                25 * (1 + @coefficient / Ky.potential[@status])
            when Const.Status.URA
                50 * (1 + @coefficient / Ky.potential[@status])
            when Const.Status.MOTIGOMA
                20
            else 0
        return parseInt(ret, 10)
    caption: ->
        switch @status
            when Const.Status.OMOTE
                if @turn == Const.FIRST then 'Y' else 'y'
            when Const.Status.URA
                if @turn == Const.FIRST then 'S' else 's'
            when Const.Status.MOTIGOMA
                if @turn == Const.FIRST then 'Y' else 'y'

class Fu extends Piece
    _direction = {}
    _direction[Const.Status.OMOTE] = {}
    _direction[Const.Status.URA] = {}
    _direction[Const.Status.MOTIGOMA] = {}
    _direction[Const.Status.OMOTE][Const.FIRST] = [new Course(false, 0, -1)]
    _direction[Const.Status.OMOTE][Const.SECOND] = [new Course(false, 0, 1)]
    _direction[Const.Status.URA][Const.FIRST] = [new Course(false, 0, -1), new Course(false, -1, -1), new Course(false, -1, 0), new Course(false, 0, 1), new Course(false, 1, 0), new Course(false, 1, -1)]
    _direction[Const.Status.URA][Const.SECOND] = [new Course(false, 0, 1), new Course(false, 1, 1), new Course(false, 1, 0), new Course(false, 0, -1), new Course(false, -1, 0), new Course(false, -1, 1)]
    _direction[Const.Status.MOTIGOMA][Const.FIRST] = [new Course(false, 0, -1)]
    _direction[Const.Status.MOTIGOMA][Const.SECOND] = [new Course(false, 0, 1)]
    @potential = [1, 6, 6]
    @getD: (turn, status) ->
        return _direction[status][turn]

    constructor: (turn, status, posi) ->
        super(turn, status, posi)
        @name = 'Fu'
    kind: ->
        @constructor.name
    koma: ->
        return if @status == Const.Status.URA then "TO" else "FU"
    omomi: ->
        ret = switch @status
            when Const.Status.OMOTE
                10 * (1 + @coefficient / Fu.potential[@status])
            when Const.Status.URA
                50 * (1 + @coefficient / Fu.potential[@status])
            when Const.Status.MOTIGOMA
                7
            else 0
        return parseInt(ret, 10)
    caption: ->
        switch @status
            when Const.Status.OMOTE
                if @turn == Const.FIRST then 'F' else 'f'
            when Const.Status.URA
                if @turn == Const.FIRST then 'T' else 't'
            when Const.Status.MOTIGOMA
                if @turn == Const.FIRST then 'F' else 'f'

module.exports =
    Course: Course
    Piece: Piece
    Ou: Ou
    Hi: Hi
    Ka: Ka
    Ki: Ki
    Gi: Gi
    Ke: Ke
    Ky: Ky
    Fu: Fu
global.gPiece = Piece
global.gOu = Ou
global.gHi = Hi
global.gKa = Ka
global.gKi = Ki
global.gGi = Gi
global.gKe = Ke
global.gKy = Ky
global.gFu = Fu
global.getClass = @getClass
