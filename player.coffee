Const = require('./const')
Piece = require('./piece')

class Player
    # @depthプロパティはthink,prepareメソッドに渡す引数limitより大きな数値である必要がある
    # 読みの深さとしての属性（@depth）は許容量、実際の読みの深さとして渡すlimit引数の関係
    constructor:(@turn, @human, @depth = 3) ->
        # 以下のメンバー変数は簡易版では未使用
        @pre_ahead = -1
        @pre_select = 4
        @preparation = []

    # prepare: (board, oppo, limit, preValue, pre_ahead = 3) ->
        # 簡易版は省略
        
    # think: (board, oppo, limit, preValue, priority = [], utifudume = null) ->
    think: (board, oppo, limit, preValue, utifudume = null) ->
        spare = {}
        lastscore = if @turn == Const.FIRST then Const.MIN_VALUE else Const.MAX_VALUE
        lastposi = null
        lastkoma = null
        laststatus = null
        score = 0
        kinds = []
        move_piece = null
        utifudume_flg = null
        for koma in board.pieces when koma.turn == @turn
            if koma.status == Const.Status.MOTIGOMA
                continue if koma.kind() in kinds
                kinds.push(koma.kind())
                for col in [1..board.cols]
                    for row in [1..board.rows]
                        # if priority.length != 0
                        #     continue unless (w for w in choice when row == w.posi[0] && col == w.posi[1])[0]?
                        dest = (v for v in board.pieces when v.posi? && v.posi[0] == row && v.posi[1] == col)
                        continue if dest.length != 0
                        if koma.kind() == 'Fu' && is_utifuOute.call @, board, koma, [row, col]
                            if board.check_utifudume(koma, [row, col])
                                utifudume_flg = null
                                continue
                            else
                                utifudume_flg = koma
                        else
                            utifudume_flg = null

                        move_piece = new Piece.Piece(koma.turn, koma.status, koma.posi)
                        if board.check_move(koma, [row, col])
                            board.move_capture(koma, [row, col])
                            # 王手放置をチェック
                            # board.make_kiki(oppo.turn)
                            # if (check_kiki.call @, board, oppo) && limit > 0
                            #     if @turn == Const.FIRST
                            #         score = Const.MIN_VALUE
                            #     else
                            #         score = Const.MAX_VALUE
                            # else
                            result = board.gameover()
                            if limit > 0 && !result
                                ret = oppo.think(board, @, limit - 1, lastscore, utifudume_flg)
                                score = ret[2]
                            else
                                score = check_tumi.call @, board
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
                for v in eval("Piece." + koma.kind()).getD(koma.turn, koma.status)
                    buf = [].concat(koma.posi)
                    loop
                        break unless ((buf[0] + v.xd in [1..board.cols]) && (buf[1] + v.yd in [1..board.rows]))
                        promotion = false
                        buf[0] += v.xd; buf[1] += v.yd
                        dest = (o for o in board.pieces when o.posi? && o.posi[0] == buf[0] && o.posi[1] == buf[1])
                        break if dest.length != 0 && dest[0].turn == koma.turn
                        move_piece = new Piece.Piece(koma.turn, koma.status, koma.posi)
                        if dest.length != 0
                            dest_piece = new Piece.Piece(dest[0].turn, dest[0].status, dest[0].posi)
                        if board.check_move(koma, buf)
                            promotion = true if board.check_promotion(koma, buf)
                            board.move_capture(koma, buf)
                            loop
                                # 王手放置をチェック
                                # board.make_kiki(oppo.turn)
                                # if (check_kiki.call @, board, oppo) && limit > 0
                                #     if @turn == Const.FIRST
                                #         score = Const.MIN_VALUE
                                #     else
                                #         score = Const.MAX_VALUE
                                # else
                                result = board.gameover()
                                if utifudume? && !result && dest.length != 0 && dest[0].id == utifudume.id && koma.kind() != 'Ou'
                                    # console.log(" ===== #{koma.kind()} ===================") if limit <= 0
                                    # board.display() if limit <= 0
                                    ret = oppo.think(board, @, 0, lastscore, null)
                                    if ret[2] >= Const.MAX_VALUE || ret[2] <= Const.MIN_VALUE
                                        score = ret[2] * -1
                                    else
                                        if limit > 0
                                            ret = oppo.think(board, @, limit - 1, lastscore, null)
                                            score = ret[2]
                                        else
                                            score = check_tumi.call @, board
                                else
                                    if limit > 0 && !result
                                        ret = oppo.think(board, @, limit - 1, lastscore, null)
                                        score = ret[2]
                                    else
                                        score = check_tumi.call @, board
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
                        if dest.length != 0
                            dest[0].turn = dest_piece.turn
                            dest[0].status = dest_piece.status
                            dest[0].posi = dest_piece.posi
                        return [lastkoma, lastposi, lastscore, laststatus, spare] if (score >= Const.MAX_VALUE && @turn == Const.FIRST) || (score <= Const.MIN_VALUE && @turn == Const.SECOND)
                        return [lastkoma, lastposi, lastscore, laststatus, spare] if shortCut
                        break unless (dest.length == 0 && v.series)
        return [lastkoma, lastposi, lastscore, laststatus, spare]

    is_utifuOute = (board, piece, d_posi) ->
        oppo = if piece.turn == Const.FIRST then Const.SECOND else Const.FIRST
        oppo_king = (v for v in board.pieces when v.turn == oppo && v.kind() == 'Ou')[0]
        buf = [].concat(d_posi)
        buf[0] += Piece.Fu.getD(piece.turn, piece.status)[0].xd
        buf[1] += Piece.Fu.getD(piece.turn, piece.status)[0].yd
        return (oppo_king.posi[0] == buf[0] && oppo_king.posi[1] == buf[1])

    check_tumi = (board) ->
        first = 0; second = 0
        kings = (v for v in board.pieces when v.kind() == 'Ou' && v.turn == Const.FIRST)
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

    check_kiki = (board, oppo) ->
        king = (v for v in board.pieces when v.kind() == 'Ou' && v.turn == @turn)[0]
        # return king.posi.toString() in board.kiki[oppo.turn].map (o) -> o.toString()
        return (o for o in board.kiki[oppo.turn] when king.posi[0] == o[0] && king.posi[1] == o[1])[0]?

    evaluate = (board) ->
        first = 0; second = 0
        for v in board.pieces
            first += v.omomi() if v.turn == Const.FIRST
            second += v.omomi() if v.turn == Const.SECOND
        return (first - second)


module.exports = Player
