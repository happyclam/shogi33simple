Const = require('./const')
Piece = require('./piece')
Util = require('./util')

Array::unique = ->
    output = {}
    output[@[key]] = @[key] for key in [0...@length]
    value for key, value of output

class Board extends Array
    @promotion_line = [1, 3]
    constructor: (rows = Const.ROWS, cols = Const.COLS) ->
        super()
        @rows = rows
        @cols = cols
        for r in [0...@rows]
            @[r] = new Array(@cols).fill(null)
        @motigoma = {}
        @motigoma[Const.FIRST] = {}
        @motigoma[Const.SECOND] = {}
        @pieceIndex = {}
        @kiki = {}
        # @board = @

    # clear: ->
    #     for r in [0...@rows]
    #         @[r] = new Array(@cols).fill(null)

    getPieces: (turn) ->
        pieces = []
        for row in [0...@rows]
            for col in [0...@cols]
                piece = @[row][col]
                pieces.push(piece) if piece? and piece.turn == turn
        for kind, ps of @motigoma[turn]
            pieces.push(p) for p in ps
        return pieces

    setPiece: (piece, row, col) ->
        # テスト用コード
        # if @[row - 1][col - 1]?
        #     console.log("piece = #{JSON.stringify(piece)}")
        #     console.log("pieceIndex = #{JSON.stringify(@pieceIndex)}")
        #     console.log("row = #{row}, col = #{col}")
        #     @display()
        #     throw new Error("setPiece [#{row}, #{col}] is occupied")
        # unique = (1 for k, v of @pieceIndex when v[0] == row && v[1] == col).length
        # if unique > 1
        #     console.log("piece = #{JSON.stringify(piece)}")
        #     console.log("pieceIndex = #{JSON.stringify(@pieceIndex)}")
        #     console.log("row = #{row}, col = #{col}")
        #     @display()
        #     throw new Error("setPiece piece [id:#{piece.id}, turn:#{piece.turn}, name:#{piece.name}] is already exist")
        @[row - 1][col - 1] = piece
        @pieceIndex[piece.id] = [row, col]
        return piece

    getPiece: (row, col) ->
        @[row - 1][col - 1]

    getPiecePosition: (piece) ->
        @pieceIndex[piece.id]

    addMotigoma: (piece, turn) ->
        @motigoma[turn][piece.name] ?= []
        @motigoma[turn][piece.name].push(piece)
        # 引数のturnとpiece.turnの矛盾が無いようpiece.turnを引数で上書き
        piece.setTurn(turn)
        piece.status = Const.Status.MOTIGOMA
        @pieceIndex[piece.id] = []

    removeMotigoma: (piece) ->
        if !@motigoma[piece.turn][piece.name]
            throw new Error("removeMotigoma [id:#{piece.id}, turn:#{piece.turn}, name:#{piece.name}] isn't exist")
        index = @motigoma[piece.turn][piece.name].findIndex (p) -> p.id == piece.id
        @motigoma[piece.turn][piece.name].splice(index, 1)
        delete @motigoma[piece.turn][piece.name] if @motigoma[piece.turn][piece.name].length == 0
        # delete @pieceIndex[piece.id]

    isMotigoma: (piece) ->
        @pieceIndex[piece.id].length == 0

    getMotigoma: (turn, name) ->
        piece = (v for v in @motigoma[turn][name] when v.name == name)[0]
        if piece?
            return piece
        else
            throw new Error("turn: #{turn}, name: #{name}] isn't exist")
    countMotigoma: ->
        counts = {}
        counts[Const.FIRST] = {}
        counts[Const.SECOND] = {}
        for turn in [Const.FIRST, Const.SECOND]
            for kind, pieces of @motigoma[turn]
                counts[turn][kind] = pieces.length
        return counts

    cloneBoard: ->
        clone = new Board(@rows, @cols)
        for r in [0...@rows]
            for c in [0...@cols]
                clone[r][c] = @[r][c]
        clone.motigoma = {}
        for turn in [Const.FIRST, Const.SECOND]
            clone.motigoma[turn] = {}
            for kind, pieces of @motigoma[turn]
                clone.motigoma[turn][kind] = pieces.slice()
        clone.pieceIndex = Object.assign({}, @pieceIndex)
        return clone

    set_standard: ->
        # @clear()
        @motigoma = { [Const.FIRST]: {}, [Const.SECOND]: {} }
        @pieceIndex = {}
        @setPiece(new Piece.Ou(Const.FIRST, Const.Status.OMOTE), 3, 3)
        @addMotigoma(new Piece.Gi(Const.FIRST, Const.Status.MOTIGOMA), Const.FIRST)
        @addMotigoma(new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA), Const.FIRST)
        @setPiece(new Piece.Ou(Const.SECOND, Const.Status.OMOTE), 1, 1)
        @addMotigoma(new Piece.Gi(Const.SECOND, Const.Status.MOTIGOMA), Const.SECOND)
        @addMotigoma(new Piece.Fu(Const.SECOND, Const.Status.MOTIGOMA), Const.SECOND)
        return

    gameover: ->
        if @motigoma[Const.FIRST].Ou?.length > 0
            return Const.FIRST
        else if @motigoma[Const.SECOND].Ou?.length > 0
            return Const.SECOND
        else
            return false

    display: ->
        for kind, pieces of @motigoma[Const.SECOND]
            for piece in pieces
                process.stdout.write(piece.caption()) if piece?
        process.stdout.write("\n")

        for col in [@cols..1]
            process.stdout.write(" " + col.toString())
        process.stdout.write("\n")

        for row in [1..@rows]
            for col in [@cols..1] by -1
                koma = @[col - 1][row - 1]
                process.stdout.write("|" + if koma? then koma.caption() else " ")
            process.stdout.write("|" + row.toString() + "\n")

        for kind, pieces of @motigoma[Const.FIRST]
            for piece in pieces
                process.stdout.write(piece.caption()) if piece?
        process.stdout.write("\n")
        return

    make_kiki: (turn, exclude = null) ->
        # @kiki[turn] = ((0 for c in [0...@cols]) for r in [0...@rows])
        @kiki[turn] = []
        for r in [0...@rows]
            for c in [0...@cols]
                piece = @[r][c]
                continue unless piece? && piece.turn == turn && piece.name != exclude
                for v in getClass(piece.name).getD(piece.turn, piece.status)
                    buf = [r + 1, c + 1]
                    loop
                        buf[0] += v.xd; buf[1] += v.yd
                        break unless buf[0] in [1..@cols] && buf[1] in [1..@rows]
                        # @kiki[turn][buf[0] - 1][buf[1] - 1] = 1
                        @kiki[turn].push([buf[0], buf[1]])
                        break if @[buf[0] - 1][buf[1] - 1]? || !v.series
        @kiki[turn] = @kiki[turn].unique()

    # 戻り値; [着手可能(true/false), 強制成(true/false)]
    # 強制成は、着手可能がfalseのときは意味を持たない
    # 強制成は成れるかどうかではなく成らなければならない時だけtrueを返す
    check_move: (piece, d_posi) ->
        # console.log("check_move")
        # console.log("piece = #{JSON.stringify(piece)}")
        force_promo = false
        dest = @getPiece(d_posi[0], d_posi[1])
        s_posi = @getPiecePosition(piece)
        # console.log("s_posi = #{s_posi}")
        # console.log("dest = #{dest}")
        # console.log("piece.id = #{piece.id}")
        # console.log("piece = #{JSON.stringify(piece)}")
        # console.log("motigoma[FIRST]= #{JSON.stringify(@motigoma[piece.turn])}")
        # console.log("pieceIndex= #{JSON.stringify(@pieceIndex)}")
        if piece.status == Const.Status.MOTIGOMA
            if !dest? && check_potential.call @, piece, d_posi
                # 二歩チェック
                if (piece.name == 'Fu') && (check_nifu.call @, piece, d_posi)
                    # console.log("check0")
                    return [false, false]
                else
                    # console.log("check-1")
                    return [true, false]
            else
                # console.log("check00")
                return [false, false]
        else
            unless check_potential.call @, piece, d_posi
                if @check_promotion(piece, d_posi)
                    force_promo = true
                else
                    return [false, false]
        for v in getClass(piece.name).getD(piece.turn, piece.status)
            buf = [].concat(s_posi)
            buf[0] += v.xd; buf[1] += v.yd
            if buf[0] == d_posi[0] && buf[1] == d_posi[1]
                if dest?
                    if piece.turn != dest.turn
                        # piece.status = Const.Status.URA if force_promo
                        # console.log("check1")
                        if force_promo then return [true, true] else return [true, false]
                else
                    # piece.status = Const.Status.URA if force_promo
                    # console.log("check2")
                    if force_promo then return [true, true] else return [true, false]
            if v.series
                while (buf[0] in [1..@cols]) && (buf[1] in [1..@rows])
                    if (buf[0] == d_posi[0] && buf[1] == d_posi[1])
                        if !dest?
                            # piece.status = Const.Status.URA if force_promo
                            # console.log("check3")
                            if force_promo then return [true, true] else return [true, false]
                        else
                            if (piece.turn != dest.turn)
                                # piece.status = Const.Status.URA if force_promo
                                # console.log("check4")
                                if force_promo then return [true, true] else return [true, false]
                            else
                                # console.log("check5")
                                break
                    else
                        break if @[buf[0] - 1][buf[1] - 1]?
                    buf[0] += v.xd; buf[1] += v.yd
        # console.log("check6")
        return [false, false]

    # # 成れるかどうか判定
    check_promotion: (piece, d_posi) ->
        return false unless piece.status == Const.Status.OMOTE
        return false if piece.name in ['Ou', 'Ki']
        posi = @getPiecePosition(piece)
        switch piece.turn
            when Const.FIRST
                return true if (posi[1] <= Board.promotion_line[0] || d_posi[1] <= Board.promotion_line[0])
            when Const.SECOND
                return true if (posi[1] >= Board.promotion_line[1] || d_posi[1] >= Board.promotion_line[1])
        return false

    move_capture: (piece, d_posi, promote = false) ->
        pieceStatus = piece.status
        if @isMotigoma(piece)
            s_posi = []
            @removeMotigoma(piece)
            piece.status = Const.Status.OMOTE
            if @[d_posi[0] - 1][d_posi[1] - 1]?
                throw new Error("move_capture [#{d_posi}] is occupied")
        else
            s_posi = @getPiecePosition(piece)
            unless s_posi?
                throw new Error("move_capture piece [id:#{piece.id}, turn:#{piece.turn}, name:#{piece.name}] isn't exist")
            @[s_posi[0] - 1][s_posi[1] - 1] = null
        dest = @[d_posi[0] - 1][d_posi[1] - 1]
        destTurn = dest?.turn
        destStatus = dest?.status
        if dest?
            dest.status = Const.Status.MOTIGOMA
            dest.setTurn(piece.turn)
            @addMotigoma(dest, piece.turn)
            @[d_posi[0] - 1][d_posi[1] - 1] = null
        @setPiece(piece, d_posi[0], d_posi[1])
        if promote
            piece.status = Const.Status.URA
        return new Util.MoveDiff(piece, s_posi, dest, d_posi, pieceStatus, destTurn, destStatus)
        # console.log("xxx move_capture")
        # result = new Util.MoveDiff(piece, s_posi, dest, d_posi, pieceStatus, destTurn, destStatus)
        # console.log("xxx move_capture = #{JSON.stringify(result)}")
        # console.log("xxx motigoma[FIRST] = #{JSON.stringify(@motigoma[Const.FIRST])}")
        # console.log("xxx motigoma[SECOND] = #{JSON.stringify(@motigoma[Const.SECOND])}")
        # return result

    revert_move: (diff) ->
        {piece, s_posi, dest, d_posi, pieceStatus, destTurn, destStatus} = diff
        # console.log("xxx revert_diff = #{JSON.stringify(diff)}")
        # console.log("xxx motigoma[FIRST] = #{JSON.stringify(@motigoma[Const.FIRST])}")
        # console.log("xxx motigoma[SECOND] = #{JSON.stringify(@motigoma[Const.SECOND])}")
        @[d_posi[0] - 1][d_posi[1] - 1] = null
        if s_posi.length == 0
            @addMotigoma(piece, piece.turn)
            piece.status = Const.Status.MOTIGOMA
            @[d_posi[0] - 1][d_posi[1] - 1] = null
            @pieceIndex[piece.id] = []
        else
            piece.status = pieceStatus
            # @[s_posi[0] - 1][s_posi[1] - 1] = piece
            # @pieceIndex[piece.id] = s_posi
            @setPiece(piece, s_posi[0], s_posi[1])
        if dest?
            @removeMotigoma(dest)
            # @[d_posi[0] - 1][d_posi[1] - 1] = dest
            # @pieceIndex[dest.id] = d_posi
            dest.turn = destTurn
            dest.status = destStatus
            @setPiece(dest, d_posi[0], d_posi[1])

    check_utifudume: (piece, d_posi) ->
        oppo = if piece.turn == Const.FIRST then Const.SECOND else Const.FIRST
        oppo_king = (v for v in @getPieces(oppo) when v.name=='Ou')[0]
        unless oppo_king
            throw new Error("check_utifudume: piece = #{JSON.stringify(piece)}, d_posi = #{d_posi} isn't exist")

        #2,打ち歩を玉以外の味方の駒で取ることが出来ない
        @make_kiki(oppo, 'Ou')
        if (o for o in @kiki[oppo] when o[0] == d_posi[0] && o[1] == d_posi[1])[0]?
            # console.log("check2")
            return false

        #3,玉が逃げることも出来ないし、打たれた歩に相手の駒の利きがある（玉で取ることも出来ない）
        @make_kiki(piece.turn)
        # console.log("kiki = #{JSON.stringify(@kiki)}")
        org = [].concat(@getPiecePosition(oppo_king))
        for v in Piece.Ou.getD(oppo_king.turn, oppo_king.status)
            dest = [org[0] + v.xd, org[1] + v.yd]
            continue unless (dest[0] in [1..@cols] && dest[1] in [1..@rows])
            if (o for o in @kiki[piece.turn] when o[0] == dest[0] && o[1] == dest[1])[0]?
                continue
            else
                # unless (w for w in @pieces when w.posi? && w.posi[0] == dest[0] && w.posi[1] == dest[1])[0]?
                #     return false
                check = false
                for r in [0...@rows]
                    for c in [0...@cols]
                        p = @[r][c]
                        if p? && (r + 1) == dest[0] && (c + 1) == dest[1]
                            check = true
                            break
                    break if check
                return check
        return true

    check_nifu = (piece, d_posi) ->
        for c in [0...@cols]
            p = @[d_posi[0] - 1][c]
            # console.log("p = #{JSON.stringify(p)}")
            return true if p? && p.name == 'Fu' && p.status == Const.Status.OMOTE && p.turn == piece.turn
        return false

    check_potential = (piece, d_posi) ->
        # console.log("piece = #{JSON.stringify(piece)}")
        # console.log("d_posi = #{d_posi}")
        for v in getClass(piece.name).getD(piece.turn, piece.status)
            if ((d_posi[0] + v.xd) > 0) && ((d_posi[1] + v.yd) > 0) && ((d_posi[0] + v.xd) <= @cols) && ((d_posi[1] + v.yd) <= @rows)
                return true
        return false

    # # 打った後、指した後に移動可能な場所が無い場合falseを返す
    # check_potential = (piece, d_posi) ->
    #     for v in getClass(piece.name).getD(piece.turn, piece.status)
    #         if ((d_posi[0] + v.xd) > 0) && ((d_posi[1] + v.yd) > 0) && ((d_posi[0] + v.xd) <= @cols) && ((d_posi[1] + v.yd) <= @rows)
    #             return true
    #     return false

    # check_kiki = (piece, d_posi, src) ->
    #     for v in getClass(piece.name).getD(piece.turn, piece.status)
    #         buf = [].concat(piece.posi)
    #         loop
    #             buf[0] += v.xd; buf[1] += v.yd
    #             break unless buf[0] in [1..@cols] && buf[1] in [1..@rows]
    #             return true if buf[0] == d_posi[0] && buf[1] == d_posi[1]
    #             break if src[buf[0] - 1][buf[1] - 1]?
    #             break unless v.series
    #     return false

module.exports = Board

