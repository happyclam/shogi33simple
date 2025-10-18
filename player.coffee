Const = require('./const')
Piece = require('./piece')
Util = require('./util')

class Player
    # @depthプロパティはthink,prepareメソッドに渡す引数limitより大きな数値である必要がある
    # 読みの深さとしての属性（@depth）は許容量、実際の読みの深さとして渡すlimit引数の関係
    constructor:(@turn, @human, @depth = 3) ->
        @pre_ahead = 0
        @pre_select = 4
        @preparation = []
        @oppo = if @turn == Const.FIRST then Const.SECOND else Const.FIRST

    prepare: (board, oppo, limit, preValue, pre_ahead = 3) ->
        @preparation = []
        @pre_ahead = pre_ahead
        ret = @think(board, oppo, @pre_ahead, preValue)
        if @turn == Const.FIRST
            sortPreparation.call @, @preparation, 'desc'
        else
            sortPreparation.call @, @preparation, 'asc'
        # console.log("@preparation")
        # console.log(@preparation)
        selection = {}
        selection["pieces"] = []
        selection["positions"] = []
        for v in @preparation[0..@pre_select]
            buf = (w for w in board.getPieces(@turn) when w.id == v.id)
            if buf.length > 0
                if (x for x in selection.pieces when x.id == v.id).length == 0
                    selection.pieces.push(buf[0])
                    selection.positions.push({id: v.id, posi: board.getPiecePosition(v)})
                if (x for x in selection.positions when x.id == v.id && x.posi == v.posi).length == 0
                    selection.positions.push({id: v.id, posi: v.posi})
            break if selection.positions.length > @pre_select
        # console.log("selection")
        # console.log(selection)
        @pre_ahead = -1
        ret = @think(board, oppo, limit, preValue, selection)
        # console.log("ret = #{JSON.stringify(ret)}")
        return ret

    think: (board, oppo, limit, preValue, priority = {}, utifudume = null) ->
        # console.log("limit = #{limit}")
        # board.display()
        if @turn == Const.FIRST
            bestMove = new Util.BestMove(null, [], Const.MIN_VALUE, Const.Status.OMOTE)
        else
            bestMove = new Util.BestMove(null, [], Const.MAX_VALUE, Const.Status.OMOTE)
        score = 0
        kinds = []
        utifudume_flg = null
        if Object.keys(priority).length != 0
            selections = priority.pieces
        else
            selections = board.getPieces(@turn)
        for koma in selections
            # console.log("koma = #{JSON.stringify(koma)}")
            if Object.keys(priority).length != 0
                choice = priority.positions
            if koma.status == Const.Status.MOTIGOMA
                continue if koma.name in kinds
                kinds.push(koma.name)
                for col in [1..board.cols]
                    for row in [1..board.rows]
                        if Object.keys(priority).length != 0
                            # Piece.posiは廃止したけど候補手要素のposiは使っている
                            continue unless (w for w in choice when koma.id == w.id && row == w.posi[0] && col == w.posi[1])[0]?
                        dest = board.getPiece(row, col)
                        continue if dest?
                        if koma.name == 'Fu' && is_utifuOute.call @, board, koma, [row, col]
                            if board.check_utifudume(koma, [row, col])
                                utifudume_flg = null
                                continue
                            else
                                utifudume_flg = koma
                        else
                            utifudume_flg = null

                        check = board.check_move(koma, [row, col])
                        if check[0]
                            # console.log("move_capture: 82")
                            diff = board.move_capture(koma, [row, col], check[1])
                            result = board.gameover()
                            if limit > 0 && !result
                                if @pre_ahead == -1 && limit > 4
                                    ret = oppo.prepare(board, @, limit - 1, if oppo.turn == Const.FIRST then Const.MAX_VALUE else Const.MIN_VALUE)
                                else
                                    ret = oppo.think(board, @, limit - 1, bestMove.lastscore, {}, utifudume_flg)
                                score = ret.lastscore
                            else
                                score = check_tumi.call @, board
                            @preparation.push {"id": koma.id, "kind": koma.name,"s_posi": diff.s_posi, "posi": [row,col], "status": koma.status, "score": score, "weight": koma.omomi()} if limit == @pre_ahead
                            shortCut = false
                            if (score > bestMove.lastscore && @turn == Const.FIRST) || (score < bestMove.lastscore && @turn == Const.SECOND)
                                # console.log("uti bestMove = #{JSON.stringify(bestMove)}")
                                bestMove.update(koma, [].concat([row, col]), score, koma.status)
                                # console.log("uti bestMove = #{JSON.stringify(bestMove)}")
                                if ((preValue < score && @turn == Const.FIRST) || (preValue > score && @turn == Const.SECOND))
                                    shortCut = true
                            # console.log("revert_move: 103")
                            board.revert_move(diff)
                            # board.display()
                        return bestMove if (score >= Const.MAX_VALUE && @turn == Const.FIRST) || (score <= Const.MIN_VALUE && @turn == Const.SECOND)
                        return bestMove if shortCut
            else
                for v in getClass(koma.name).getD(koma.turn, koma.status)
                    buf = [].concat(board.getPiecePosition(koma))
                    loop
                        break unless ((buf[0] + v.xd in [1..board.cols]) && (buf[1] + v.yd in [1..board.rows]))
                        promotion = false
                        buf[0] += v.xd; buf[1] += v.yd
                        if Object.keys(priority).length != 0
                            continue unless (w for w in choice when koma.id == w.id && buf[0] == w.posi[0] && buf[1] == w.posi[1])[0]?
                        dest = board.getPiece(buf[0], buf[1])
                        break if dest? && dest.turn == koma.turn
                        check = board.check_move(koma, buf)
                        if check[0]
                            promotion = true if board.check_promotion(koma, buf)
                            # console.log("move_capture: 119")
                            diff = board.move_capture(koma, buf, check[1])
                            loop
                                result = board.gameover()
                                if utifudume? && !result && dest? && dest.id == utifudume.id && koma.name != 'Ou'
                                    # console.log(" ===== #{koma.name} ===================") if limit <= 0
                                    # board.display() if limit <= 0
                                    ret = oppo.think(board, @, 0, bestMove.lastscore, {}, null)
                                    if ret.lastscore >= Const.MAX_VALUE || ret.lastscore <= Const.MIN_VALUE
                                        score = ret.lastscore * -1
                                    else
                                        if limit > 0
                                            if @pre_ahead == -1 && limit > 4
                                                ret = oppo.prepare(board, @, limit - 1, if oppo.turn == Const.FIRST then Const.MAX_VALUE else Const.MIN_VALUE)
                                            else
                                                ret = oppo.think(board, @, limit - 1, bestMove.lastscore, {}, null)
                                            score = ret.lastscore
                                        else
                                            score = check_tumi.call @, board
                                else
                                    if limit > 0 && !result
                                        if @pre_ahead == -1 && limit > 4
                                            ret = oppo.prepare(board, @, limit - 1, if oppo.turn == Const.FIRST then Const.MAX_VALUE else Const.MIN_VALUE)
                                        else
                                            ret = oppo.think(board, @, limit - 1, bestMove.lastscore, {}, null)
                                        score = ret.lastscore
                                    else
                                        score = check_tumi.call @, board
                                @preparation.push {"id": koma.id,  "kind": koma.name,"s_posi": diff.s_posi, "posi": [].concat(buf), "status": koma.status, "score": score, "weight": koma.omomi()} if limit == @pre_ahead
                                shortCut = false
                                if (score > bestMove.lastscore && @turn == Const.FIRST) || (score < bestMove.lastscore && @turn == Const.SECOND)
                                    bestMove.update(koma, [].concat(buf), score, koma.status)
                                    if ((preValue < score && @turn == Const.FIRST) || (preValue > score && @turn == Const.SECOND))
                                        shortCut = true
                                # 駒が成れる場合は成ってからもう一度評価する
                                if promotion
                                    promotion = false
                                    koma.status = Const.Status.URA
                                else
                                    break
                            # console.log("revert_move: 164")
                            board.revert_move(diff)
                            # board.display()
                        return bestMove if (score >= Const.MAX_VALUE && @turn == Const.FIRST) || (score <= Const.MIN_VALUE && @turn == Const.SECOND)
                        return bestMove if shortCut
                        break unless (!dest? && v.series)
        return bestMove

    sortPreparation = (arr, order = 'asc') ->
        arr.sort (a, b) ->
            if a.score != b.score
                if order is 'asc'
                    a.score - b.score
                else
                    b.score - a.score
            else if a.weight != b.weight
                a.weight - b.weight
            else
                if Math.random() < 0.5 then -1 else 1

    is_utifuOute = (board, piece, d_posi) ->
        oppo = if piece.turn == Const.FIRST then Const.SECOND else Const.FIRST
        oppo_king = (v for v in board.getPieces(oppo) when v.name=='Ou')[0]
        return false unless oppo_king
        posi = board.getPiecePosition(oppo_king)
        return false unless posi
        buf = [].concat(d_posi)
        buf[0] += Piece.Fu.getD(piece.turn, piece.status)[0].xd
        buf[1] += Piece.Fu.getD(piece.turn, piece.status)[0].yd
        return (posi[0] == buf[0] && posi[1] == buf[1])

    check_tumi = (board) ->
        first = 0; second = 0
        firstKing  = board.motigoma[Const.FIRST].Ou?.length
        secondKing  = board.motigoma[Const.SECOND].Ou?.length
        if firstKing > 0
            return Const.MAX_VALUE
        else if secondKing > 0
            return Const.MIN_VALUE
        else
            for koma in board.getPieces(Const.FIRST)
                first += koma.omomi()
            for koma in board.getPieces(Const.SECOND)
                second += koma.omomi()
            return (first - second)


module.exports = Player
