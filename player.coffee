Const = require('./const')
Piece = require('./piece')

class Player
    # @depthプロパティはthink,prepareメソッドに渡す引数limitより大きな数値である必要がある
    # 読みの深さとしての属性（@depth）は許容量、実際の読みの深さとして渡すlimit引数の関係
    constructor:(@turn, @human, @depth = 3) ->
        @pre_ahead = 0
        @pre_select = 4
        @preparation = []

    prepare: (board, oppo, limit, preValue, pre_ahead = 3) ->
        @preparation = []
        @pre_ahead = pre_ahead
        ret = @think(board, oppo, @pre_ahead, preValue)
        if @turn == Const.FIRST
            sortPreparation.call @, @preparation, 'desc'
            # shellSortDesc.call @, @preparation
        else
            sortPreparation.call @, @preparation, 'asc'
            # shellSortAsc.call @, @preparation
        # console.log("@preparation")
        # console.log(@preparation)
        selection = {}
        selection["pieces"] = []
        selection["positions"] = []
        for v in @preparation[0..@pre_select]
            buf = (w for w in board.pieces when w.id == v.id)
            if buf.length > 0
                if (x for x in selection.pieces when x.id == v.id).length == 0
                    selection.pieces.push(buf[0])
                    selection.positions.push({id: v.id, posi: v.posi})
                if (x for x in selection.positions when x.id == v.id && x.posi == v.posi).length == 0
                    selection.positions.push({id: v.id, posi: v.posi})
        # console.log("selection")
        # console.log(selection)
        @pre_ahead = -1
        ret = @think(board, oppo, limit, preValue, selection)
        # console.log("ret = #{JSON.stringify(ret)}")
        return ret

    think: (board, oppo, limit, preValue, priority = {}, utifudume = null) ->
        spare = {}
        lastscore = if @turn == Const.FIRST then Const.MIN_VALUE else Const.MAX_VALUE
        lastposi = null
        lastkoma = null
        laststatus = null
        score = 0
        kinds = []
        move_piece = new Piece.Piece(Const.First, Const.Status.MOTIGOMA)
        dest_piece = new Piece.Piece(Const.First, Const.Status.MOTIGOMA)
        # move_piece = null
        utifudume_flg = null
        src = []
        src = ((null for c in [1..Const.COLS]) for r in [1..Const.ROWS])
        for v in board.pieces
            src[v.posi[0] - 1][v.posi[1] - 1] = v if v.posi.length != 0
        if Object.keys(priority).length != 0
            selections = priority.pieces
        else
            selections = board.pieces
        for koma in selections when koma.turn == @turn
            # 同じ駒でも指す場所が複数になるので、この段階では複数の候補となる
            if Object.keys(priority).length != 0
                choice = priority.positions
            if koma.status == Const.Status.MOTIGOMA
                continue if koma.name in kinds
                kinds.push(koma.name)
                for col in [1..board.cols]
                    for row in [1..board.rows]
                        if Object.keys(priority).length != 0
                            continue unless (w for w in choice when koma.id == w.id && row == w.posi[0] && col == w.posi[1])[0]?
                        dest = src[row - 1][col - 1]
                        continue if dest?
                        if koma.name == 'Fu' && is_utifuOute.call @, board, koma, [row, col]
                            if board.check_utifudume(koma, [row, col])
                                utifudume_flg = null
                                continue
                            else
                                utifudume_flg = koma
                        else
                            utifudume_flg = null

                        # move_piece = new Piece.Piece(koma.turn, koma.status, koma.posi)
                        move_piece.turn = koma.turn
                        move_piece.status = koma.status
                        move_piece.posi = [].concat(koma.posi)
                        if board.check_move(koma, [row, col])
                            board.move_capture(koma, [row, col])
                            result = board.gameover()
                            if limit > 0 && !result
                                if @pre_ahead == -1 && limit > 4
                                    ret = oppo.prepare(board, @, limit - 1, if oppo.turn == Const.FIRST then Const.MAX_VALUE else Const.MIN_VALUE)
                                else
                                    ret = oppo.think(board, @, limit - 1, lastscore, {}, utifudume_flg)
                                score = ret[2]
                            else
                                score = check_tumi.call @, board
                            @preparation.push {"id": koma.id, "kind": koma.name,"s_posi": move_piece.posi, "posi": [row,col], "status": koma.status, "score": score, "weight": koma.omomi()} if limit == @pre_ahead
                            shortCut = false
                            if (score > lastscore && @turn == Const.FIRST) || (score < lastscore && @turn == Const.SECOND)
                                spare["koma"] = lastkoma
                                spare["posi"] = [].concat(lastposi)
                                spare["score"] = lastscore
                                spare["status"] = laststatus
                                lastkoma = koma
                                lastscore = score
                                lastposi = [].concat([row, col])
                                laststatus = koma.status
                                if ((preValue < score && @turn == Const.FIRST) || (preValue > score && @turn == Const.SECOND))
                                    shortCut = true
                        koma.turn = move_piece.turn
                        koma.status = move_piece.status
                        koma.posi = move_piece.posi
                        return [lastkoma, lastposi, lastscore, laststatus, spare] if (score >= Const.MAX_VALUE && @turn == Const.FIRST) || (score <= Const.MIN_VALUE && @turn == Const.SECOND)
                        return [lastkoma, lastposi, lastscore, laststatus, spare] if shortCut
            else
                for v in getClass(koma.name).getD(koma.turn, koma.status)
                    buf = [].concat(koma.posi)
                    loop
                        break unless ((buf[0] + v.xd in [1..board.cols]) && (buf[1] + v.yd in [1..board.rows]))
                        promotion = false
                        buf[0] += v.xd; buf[1] += v.yd
                        if Object.keys(priority).length != 0
                            continue unless (w for w in choice when koma.id == w.id && buf[0] == w.posi[0] && buf[1] == w.posi[1])[0]?
                        dest = src[buf[0] - 1][buf[1] - 1]
                        break if dest? && dest.turn == koma.turn
                        # move_piece = new Piece.Piece(koma.turn, koma.status, koma.posi)
                        move_piece.turn = koma.turn
                        move_piece.status = koma.status
                        move_piece.posi = [].concat(koma.posi)
                        if dest?
                            # dest_piece = new Piece.Piece(dest.turn, dest.status, dest.posi)
                            dest_piece.turn = dest.turn
                            dest_piece.status = dest.status
                            dest_piece.posi = [].concat(dest.posi)
                        if board.check_move(koma, buf, src[buf[0] - 1][buf[1] - 1])
                            promotion = true if board.check_promotion(koma, buf)
                            board.move_capture(koma, buf, src[buf[0] - 1][buf[1] - 1])
                            loop
                                result = board.gameover()
                                if utifudume? && !result && dest? && dest.id == utifudume.id && koma.name != 'Ou'
                                    # console.log(" ===== #{koma.name} ===================") if limit <= 0
                                    # board.display() if limit <= 0
                                    ret = oppo.think(board, @, 0, lastscore, {}, null)
                                    if ret[2] >= Const.MAX_VALUE || ret[2] <= Const.MIN_VALUE
                                        score = ret[2] * -1
                                    else
                                        if limit > 0
                                            if @pre_ahead == -1 && limit > 4
                                                ret = oppo.prepare(board, @, limit - 1, if oppo.turn == Const.FIRST then Const.MAX_VALUE else Const.MIN_VALUE)
                                            else
                                                ret = oppo.think(board, @, limit - 1, lastscore, {}, null)
                                            score = ret[2]
                                        else
                                            score = check_tumi.call @, board
                                else
                                    if limit > 0 && !result
                                        if @pre_ahead == -1 && limit > 4
                                            ret = oppo.prepare(board, @, limit - 1, if oppo.turn == Const.FIRST then Const.MAX_VALUE else Const.MIN_VALUE)
                                        else
                                            ret = oppo.think(board, @, limit - 1, lastscore, {}, null)
                                        score = ret[2]
                                    else
                                        score = check_tumi.call @, board
                                @preparation.push {"id": koma.id,  "kind": koma.name,"s_posi": move_piece.posi, "posi": [].concat(buf), "status": koma.status, "score": score, "weight": koma.omomi()} if limit == @pre_ahead
                                shortCut = false
                                if (score > lastscore && @turn == Const.FIRST) || (score < lastscore && @turn == Const.SECOND)
                                    spare["koma"] = lastkoma
                                    spare["posi"] = [].concat(lastposi)
                                    spare["score"] = lastscore
                                    spare["status"] = laststatus
                                    lastkoma = koma
                                    lastscore = score
                                    lastposi = [].concat(buf)
                                    laststatus = koma.status
                                    if ((preValue < score && @turn == Const.FIRST) || (preValue > score && @turn == Const.SECOND))
                                        shortCut = true
                                # 駒が成れる場合は成ってからもう一度評価する
                                if promotion
                                    promotion = false
                                    koma.status = Const.Status.URA
                                else
                                    break
                        koma.turn = move_piece.turn
                        koma.status = move_piece.status
                        koma.posi = move_piece.posi
                        if dest?
                            dest.turn = dest_piece.turn
                            dest.status = dest_piece.status
                            dest.posi = dest_piece.posi
                        return [lastkoma, lastposi, lastscore, laststatus, spare] if (score >= Const.MAX_VALUE && @turn == Const.FIRST) || (score <= Const.MIN_VALUE && @turn == Const.SECOND)
                        return [lastkoma, lastposi, lastscore, laststatus, spare] if shortCut
                        break unless (!dest? && v.series)
        return [lastkoma, lastposi, lastscore, laststatus, spare]

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
        oppo_king = (v for v in board.pieces when v.turn == oppo && v.name == 'Ou')[0]
        buf = [].concat(d_posi)
        buf[0] += Piece.Fu.getD(piece.turn, piece.status)[0].xd
        buf[1] += Piece.Fu.getD(piece.turn, piece.status)[0].yd
        return (oppo_king.posi[0] == buf[0] && oppo_king.posi[1] == buf[1])

    check_tumi = (board) ->
        first = 0; second = 0
        kings = (v for v in board.pieces when v.name == 'Ou' && v.turn == Const.FIRST)
        switch kings.length
            when 2
                return Const.MAX_VALUE
            when 0
                return Const.MIN_VALUE
            else
                for v in board.pieces
                    first += v.omomi() if v.turn == Const.FIRST
                    second += v.omomi() if v.turn == Const.SECOND
                return (first - second)

    count_kiki = (piece, board) ->
        # console.log("piece = ")
        # console.log(piece)
        for v in getClass(piece.name).getD(piece.turn, piece.status)
            buf = [].concat(piece.posi)
            loop
                buf[0] += v.xd; buf[1] += v.yd
                break unless (buf[0] in [1..board.cols] && buf[1] in [1..board.rows])
                dest = (o for o in board.pieces when o.posi? && o.posi[0] == buf[0] && o.posi[1] == buf[1])[0]
                # console.log("dest = #{dest}")
                if dest
                    if dest.turn == piece.turn
                        break
                    else
                        piece.coefficient += 1.0
                        break
                else
                    piece.coefficient += 1.0
                break unless v.series
        # console.log("piece.coefficient = #{piece.coefficient}")
        # board.display()
        return


module.exports = Player
