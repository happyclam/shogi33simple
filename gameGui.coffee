crypto = require('crypto')
Const = require('./const')
Piece = require('./piece')
Board = require('./board')
Player = require('./player')

$ ->
    return new GameGUI()

Array::unique = ->
  output = {}
  output[@[key]] = @[key] for key in [0...@length]
  value for key, value of output

class BoardGUI extends Board
    constructor: ->
        super()
        @width = 0
        @height = 0
        @statusarea = null
    display: ->
        s_motigoma = {"Hi": 0, "Ka": 0, "Ki": 0, "Gi": 0, "Ke": 0, "Ky": 0, "Fu": 0}
        for v,i in @pieces when v.turn == Const.SECOND && v.status == Const.Status.MOTIGOMA
            s_motigoma[v.kind()] += 1
        for k,v of s_motigoma
            $('#s' + k).text(v.toString())
        for row in [1..@rows]
            for col in [@cols..1] by -1
                koma = (v for v in @pieces when v.posi? && v.posi.toString() == [col, row].toString())[0]
                if koma?
                    $('#b' + koma.posi[0] + koma.posi[1]).children('img').attr('src': (getImg.call @, koma), 'alt': koma.caption(), 'class': (if koma.turn == Const.FIRST then 'first' else 'second'))
                else
                    $('#b' + col + row).children('img').attr('src': './img/empty.svg', 'class': 'empty')
        f_motigoma = {"Hi": 0, "Ka": 0, "Ki": 0, "Gi": 0, "Ke": 0, "Ky": 0, "Fu": 0}
        for v,i in @pieces when v.turn == Const.FIRST && v.status == Const.Status.MOTIGOMA
            f_motigoma[v.kind()] += 1
        for k,v of f_motigoma
            $('#f' + k).text(v.toString())
        return

    init: ->
        @statusarea = document.getElementById("spanStatus")

    getImg = (piece) ->
        ret = ""
        switch piece.kind()
            when "Ou"
                ret = if piece.turn == Const.FIRST then "./img/f_ou.svg" else "./img/s_ou.svg"
            when "Hi"
                if piece.status == Const.Status.URA
                    ret = if piece.turn == Const.FIRST then "./img/f_ry.svg" else "./img/s_ry.svg"
                else
                    ret = if piece.turn == Const.FIRST then "./img/f_hi.svg" else "./img/s_hi.svg"
            when "Ka"
                if piece.status == Const.Status.URA
                    ret = if piece.turn == Const.FIRST then "./img/f_um.svg" else "./img/s_um.svg"
                else
                    ret = if piece.turn == Const.FIRST then "./img/f_ka.svg" else "./img/s_ka.svg"
            when "Ki"
                ret = if piece.turn == Const.FIRST then "./img/f_ki.svg" else "./img/s_ki.svg"
            when "Gi"
                if piece.status == Const.Status.URA
                    ret = if piece.turn == Const.FIRST then "./img/f_ng.svg" else "./img/s_ng.svg"
                else
                    ret = if piece.turn == Const.FIRST then "./img/f_gi.svg" else "./img/s_gi.svg"
            when "Ke"
                if piece.status == Const.Status.URA
                    ret = if piece.turn == Const.FIRST then "./img/f_nk.svg" else "./img/s_nk.svg"
                else
                    ret = if piece.turn == Const.FIRST then "./img/f_ke.svg" else "./img/s_ke.svg"
            when "Ky"
                if piece.status == Const.Status.URA
                    ret = if piece.turn == Const.FIRST then "./img/f_ny.svg" else "./img/s_ny.svg"
                else
                    ret = if piece.turn == Const.FIRST then "./img/f_ky.svg" else "./img/s_ky.svg"
            when "Fu"
                if piece.status == Const.Status.URA
                    ret = if piece.turn == Const.FIRST then "./img/f_to.svg" else "./img/s_to.svg"
                else
                    ret = if piece.turn == Const.FIRST then "./img/f_fu.svg" else "./img/s_fu.svg"
        return ret

class State
    constructor:(@turn, @status, @posi = []) ->

class GameGUI
    constructor: ->
        # console.log("GameGUI.constructor")
        @selected = null; @posi = null
        @s_posi = null; @d_posi = null;@pre_posi = null;
        @interrupt_flg = false;  @auto_flg = false
        @history = []
        @duplication = []
        @first_player = null; @second_player = null;
        @radio_arrange = null;@radio_depth = null;
        @first = new Player(Const.FIRST, true, 3)
        @second = new Player(Const.SECOND, true, 3)
        @teban = @first
        @board = new BoardGUI()
        @md5hash = null
        special_event = if typeof(cordova)=="undefined" then "DOMContentLoaded" else "deviceready"
        @setEventListener(special_event)

    viewState: ->
        for v,i in @board.pieces
            v.turn = @history[@seq][i].turn
            v.status = @history[@seq][i].status
            v.posi = @history[@seq][i].posi
        $('#naviSeq').text(@seq.toString())
        @board.display()

    addState: (md5hash) ->
        state = []
        for v in @board.pieces
            state.push(new State(v.turn, v.status, [].concat(v.posi)))
        @history.push(state)
        @duplication.push(md5hash)
        $('#naviSeq').text((@history.length - 1).toString())

    # ゲーム開始毎
    prepare: ->
        # console.log("GameGUI.prepare")
        @interrupt_flg = false; @auto_flg = false
        @history = []
        @duplication = []
        @seq = 0
        $('#naviSeq').text('')
        @startbtn.disabled = true; $("#btnStop").val("中断").button("refresh")
        @naviA.style.display = "none"
        @board.statusarea.innerHTML = "先手の番です"
        @teban = @first
        launch.call @
        @addState()
        @board.display()
        @first_player.selectedIndex = parseInt(localStorage.getItem("first_player")|0, 10)
        @second_player.selectedIndex = parseInt(localStorage.getItem("second_player")|0, 10)
        @first.human = if first_player.selectedIndex == 1 then false else true
        @second.human = if second_player.selectedIndex == 1 then false else true

    auto_battle: (@seq) ->
        # console.log("auto_battle")
        @auto_flg = true
        if @teban.turn == Const.FIRST
            player = @first
            oppo = @second
            threshold = Const.MAX_VALUE
        else
            player = @second
            oppo = @first
            threshold = Const.MIN_VALUE
        ret = []
        # if player.depth >= 6
        #     ret = player.prepare(@board, oppo, player.depth, threshold)
        # else
        ret = player.think(@board, oppo, player.depth, threshold)
        if ret[0]
            # 一手前のハッシュ値ですでに千日手判定されていればreturn
            chk_sennitite =  @sennitite(@md5hash)
            if chk_sennitite
                @board.display()
                @auto_flg = false
                return
            # else if chk_sennitite == null && ret[4]["koma"]?
            #     ret[0] = ret[4]["koma"]
            #     ret[1] = ret[4]["posi"]
            #     ret[2] = ret[4]["score"]
            #     ret[3] = ret[4]["status"]
            # 一手詰み、三手詰みチェック（これがないと千日手を優先してしまうケースがある）
            tumi2 = []
            tumi2 = player.think(@board, oppo, 2, threshold)
            tumi4 = []
            tumi4 = player.think(@board, oppo, 4, threshold)
            # 一手詰み、三手詰みがあれば差し替える
            if tumi2[0] && (tumi2[2] >= Const.MAX_VALUE || tumi2[2] <= Const.MIN_VALUE)
                if @board.check_move(tumi2[0], tumi2[1])
                    src_posi = @board.move_capture(tumi2[0], tumi2[1])
                    tumi2[0].status = tumi2[3]
            else if tumi4[0] && (tumi4[2] >= Const.MAX_VALUE || tumi4[2] <= Const.MIN_VALUE)
                if @board.check_move(tumi4[0], tumi4[1])
                    src_posi = @board.move_capture(tumi4[0], tumi4[1])
                    tumi4[0].status = tumi4[3]
            else
                if @board.check_move(ret[0], ret[1])
                    src_posi = @board.move_capture(ret[0], ret[1])
                    ret[0].status = ret[3]
            @md5hash = crypto.createHash('md5').update(JSON.stringify(@board.pieces)).digest("hex")
            @seq += 1
            @addState(@md5hash)
            if @sennitite(@md5hash)
                @board.display()
                @auto_flg = false
                return
            @teban = if (@seq % 2) == 0 then @first else @second
            @board.statusarea.innerHTML = (if @teban.turn == Const.FIRST then "先手" else "後手") + "の番です"
            @board.statusarea.innerHTML = @board.statusarea.innerHTML + "（評価値:" + ret[2].toString() + "）"
        else
            @board.statusarea.innerHTML = (if @teban.turn == Const.FIRST then "後手" else "先手") + "の勝ちです"
            @board.display()
            @startbtn.disabled = false; $("#btnStop").val("再開").button("refresh")
            @naviA.style.display = "block"
            @auto_flg = false
            return
        @board.display()
        if @interrupt_flg
            @interrupt_flg = false
            @auto_flg = false
            @board.statusarea.innerHTML = ""
            return
        setTimeout (=>
            @auto_battle(@seq)
            ), 1000
        return

    # 起動時
    init: ->
        # console.log("GameGUI.init")
        @startbtn = document.getElementById("btnStart")
        @first_player = document.getElementById("first_player")
        @second_player = document.getElementById("second_player")
        @radio_arrange = document.getElementsByName("radio-arrange")
        @radio_depth = document.getElementsByName("radio-depth")
        @naviA = document.getElementById("naviA")
        @naviA.style.display = "none"
        try
            @first_player.selectedIndex = parseInt(localStorage.getItem("first_player")|0, 10)
            @second_player.selectedIndex = parseInt(localStorage.getItem("second_player")|0, 10)
            idx = parseInt(localStorage.getItem("radio-arrange")|0, 10)
            @radio_arrange[idx].checked = true
            depth = parseInt(localStorage.getItem("radio-depth")|0, 10)
            if depth == 3
                @radio_depth[3].checked = true
                @first.depth = 7; @second.depth = 7
            else if depth == 2
                @radio_depth[2].checked = true
                @first.depth = 6; @second.depth = 6
            else if depth == 1
                @radio_depth[1].checked = true
                @first.depth = 4; @second.depth = 4
            else
                @radio_depth[0].checked = true
                @first.depth = 3; @second.depth = 3
        catch err
            console.log("=== Error ===")
            console.log(err)
            @first_player.selectedIndex = 0
            @second_player.selectedIndex = 0
            @radio_arrange[0].checked = true
            @radio_depth[0].checked = true

        $('#btnStart').on 'click', (e) =>
            target = $(e.currentTarget)
            @prepare()
            @first.human = if @first_player.selectedIndex == 1 then false else true
            @second.human = if @second_player.selectedIndex == 1 then false else true
            if !@first.human && !@second.human
                @board.statusarea.innerHTML = "thinking..."
                @board.display()
                setTimeout (=>
                    @auto_battle(@seq)
                    ), 1000
            else if not @first.human
                @board.statusarea.innerHTML = "thinking..."
                setTimeout (=>
                    event = new ($.Event)('ai_thinking')
                    $(window).trigger event
                    ),500
            return

        $('#naviStart').on 'click', (e) =>
            @seq = 0
            @viewState()
            return
        $('#naviPrev').on 'click', (e) =>
            @seq -= 1 if @seq > 0
            @viewState()
            return
        $('#naviFollow').on 'click', (e) =>
            @seq += 1 if @seq < (@history.length - 1)
            @viewState()
            return
        $('#naviEnd').on 'click', (e) =>
            @seq = @history.length - 1
            @viewState()
            return
        $('#b11').on 'click', (e) =>
            @select([Number(e.currentTarget.dataset.col), Number(e.currentTarget.dataset.row)])
            return
        $('#b21').on 'click', (e) =>
            @select([Number(e.currentTarget.dataset.col), Number(e.currentTarget.dataset.row)])
            return
        $('#b31').on 'click', (e) =>
            @select([Number(e.currentTarget.dataset.col), Number(e.currentTarget.dataset.row)])
            return
        $('#b12').on 'click', (e) =>
            @select([Number(e.currentTarget.dataset.col), Number(e.currentTarget.dataset.row)])
            return
        $('#b22').on 'click', (e) =>
            @select([Number(e.currentTarget.dataset.col), Number(e.currentTarget.dataset.row)])
            return
        $('#b32').on 'click', (e) =>
            @select([Number(e.currentTarget.dataset.col), Number(e.currentTarget.dataset.row)])
            return
        $('#b13').on 'click', (e) =>
            @select([Number(e.currentTarget.dataset.col), Number(e.currentTarget.dataset.row)])
            return
        $('#b23').on 'click', (e) =>
            @select([Number(e.currentTarget.dataset.col), Number(e.currentTarget.dataset.row)])
            return
        $('#b33').on 'click', (e) =>
            @select([Number(e.currentTarget.dataset.col), Number(e.currentTarget.dataset.row)])
            return
        $('#sFu').on 'click', (e) =>
            @motigoma((if e.currentTarget.id[0] == "s" then Const.SECOND else Const.FIRST), e.currentTarget.id[1..2])
            return
        $('#sHi').on 'click', (e) =>
            @motigoma((if e.currentTarget.id[0] == "s" then Const.SECOND else Const.FIRST), e.currentTarget.id[1..2])
            return
        $('#sKa').on 'click', (e) =>
            @motigoma((if e.currentTarget.id[0] == "s" then Const.SECOND else Const.FIRST), e.currentTarget.id[1..2])
            return
        $('#sKi').on 'click', (e) =>
            @motigoma((if e.currentTarget.id[0] == "s" then Const.SECOND else Const.FIRST), e.currentTarget.id[1..2])
            return
        $('#sGi').on 'click', (e) =>
            @motigoma((if e.currentTarget.id[0] == "s" then Const.SECOND else Const.FIRST), e.currentTarget.id[1..2])
            return
        $('#sKe').on 'click', (e) =>
            @motigoma((if e.currentTarget.id[0] == "s" then Const.SECOND else Const.FIRST), e.currentTarget.id[1..2])
            return
        $('#sKy').on 'click', (e) =>
            @motigoma((if e.currentTarget.id[0] == "s" then Const.SECOND else Const.FIRST), e.currentTarget.id[1..2])
            return
        $('#fFu').on 'click', (e) =>
            @motigoma((if e.currentTarget.id[0] == "s" then Const.SECOND else Const.FIRST), e.currentTarget.id[1..2])
            return
        $('#fHi').on 'click', (e) =>
            @motigoma((if e.currentTarget.id[0] == "s" then Const.SECOND else Const.FIRST), e.currentTarget.id[1..2])
            return
        $('#fKa').on 'click', (e) =>
            @motigoma((if e.currentTarget.id[0] == "s" then Const.SECOND else Const.FIRST), e.currentTarget.id[1..2])
            return
        $('#fKi').on 'click', (e) =>
            @motigoma((if e.currentTarget.id[0] == "s" then Const.SECOND else Const.FIRST), e.currentTarget.id[1..2])
            return
        $('#fGi').on 'click', (e) =>
            @motigoma((if e.currentTarget.id[0] == "s" then Const.SECOND else Const.FIRST), e.currentTarget.id[1..2])
            return
        $('#fKe').on 'click', (e) =>
            @motigoma((if e.currentTarget.id[0] == "s" then Const.SECOND else Const.FIRST), e.currentTarget.id[1..2])
            return
        $('#fKy').on 'click', (e) =>
            @motigoma((if e.currentTarget.id[0] == "s" then Const.SECOND else Const.FIRST), e.currentTarget.id[1..2])
            return
        $('#btnInterrupt').on 'click', (e) =>
            @interrupted()
            location.href = "#win_menu"
        $('#btnStop').on 'click', (e) =>
            @interrupted()
        $('#btnNari').on 'click', (e) =>
            @routine(@selected, @posi, true)
        $('#btnNarazu').on 'click', (e) =>
            @routine(@selected, @posi, false)
        $('input[name=radio-arrange]').change ->
            idx = $('input[name=radio-arrange]:checked').val()
            try
                localStorage.setItem("radio-arrange", idx)
            catch err
                console.log(err)
        $('input[name="radio-depth"]').on 'change', (e) =>
            target = $(e.currentTarget)
            try
                if @radio_depth[3].checked
                    localStorage.setItem("radio-depth", 3)
                    @first.depth = 7; @second.depth = 7
                else if @radio_depth[2].checked
                    localStorage.setItem("radio-depth", 2)
                    @first.depth = 6; @second.depth = 6
                else if @radio_depth[1].checked
                    localStorage.setItem("radio-depth", 1)
                    @first.depth = 4; @second.depth = 4
                else
                    localStorage.setItem("radio-depth", 0)
                    @first.depth = 3; @second.depth = 3
            catch err
                console.log(err)
        $('#first_player').on 'change', (e) =>
            target = $(e.currentTarget)
            try
                localStorage.setItem("first_player", target.context.selectedIndex)
            catch err
                console.log(err)
        $('#second_player').on 'change', (e) =>
            target = $(e.currentTarget)
            try
                localStorage.setItem("second_player", target.context.selectedIndex)
            catch err
                console.log(err)
    interrupted: ->
        # console.log("Game.interrupted")
        return unless @seq?
        if @startbtn.disabled
            @interrupt_flg = true
            $("#btnStop").val("再開").button("refresh")
            @startbtn.disabled = false
            @naviA.style.display = "block"
            @board.statusarea.innerHTML = ""
        else
            @interrupt_flg = false
            $("#btnStop").val("中断").button("refresh")
            @startbtn.disabled = true
            @naviA.style.display = "none"
            @board.statusarea.innerHTML = (if (@seq % 2) == 0 then "先手" else "後手") + "の番です"
            @teban = if (@seq % 2) == 0 then @first else @second
            @first_player.selectedIndex = parseInt(localStorage.getItem("first_player")|0, 10)
            @second_player.selectedIndex = parseInt(localStorage.getItem("second_player")|0, 10)
            @first.human = if first_player.selectedIndex == 1 then false else true
            @second.human = if second_player.selectedIndex == 1 then false else true
            @history.splice(@seq + 1); @duplication.splice(@seq + 1)
            if !@first.human && !@second.human
                @board.statusarea.innerHTML = "thinking..."
                setTimeout (=>
                    @auto_battle(@seq)
                    ), 1000
            else if not @teban.human
                @board.statusarea.innerHTML = "thinking..."
                setTimeout (=>
                    event = new ($.Event)('ai_thinking')
                    $(window).trigger event
                    ),500
            else
                ret = []
                oppo = if (@teban.turn == Const.FIRST) then @second else @first
                threshold = if (@teban.turn == Const.FIRST) then Const.MAX_VALUE else Const.MIN_VALUE
                ret = @teban.think(@board, oppo, 1, threshold)
                unless ret[0]
                    switch ret[2]
                        when Const.MAX_VALUE
                            @board.statusarea.innerHTML = "先手の勝ちです"
                            @startbtn.disabled = false; $("#btnStop").val("再開").button("refresh")
                            @naviA.style.display = "block"
                        when Const.MIN_VALUE
                            @board.statusarea.innerHTML = "後手の勝ちです"
                            @startbtn.disabled = false; $("#btnStop").val("再開").button("refresh")
                            @naviA.style.display = "block"
                        else
                            console.log("Error!")
                    @board.display()
        return

    sennitite: (h) ->
        b = (v for v in @duplication when v == h)
        if b.length == 3
            return null
        else if b.length >= 4
            @board.statusarea.innerHTML = "千日手です"
            @startbtn.disabled = false; $("#btnStop").val("再開").button("refresh")
            @naviA.style.display = "block"
            return true
        else
            return false

    routine: (piece, posi, nari) ->
        # console.log("routine")
        src_posi = @board.move_capture(piece, posi)
        piece.status = Const.Status.URA if nari
        @md5hash = crypto.createHash('md5').update(JSON.stringify(@board.pieces)).digest("hex")
        @seq += 1
        @addState(@md5hash)
        if @sennitite(@md5hash)
            @board.display()
            return
        @teban = if (@seq % 2) == 0 then @first else @second
        threshold = if @teban.turn == Const.FIRST then Const.MAX_VALUE else Const.MIN_VALUE
        switch @board.gameover()
            when Const.FIRST
                @board.statusarea.innerHTML = "先手の勝ちです"
                @startbtn.disabled = false; $("#btnStop").val("再開").button("refresh")
                @naviA.style.display = "block"
                @board.display()
                return
            when Const.SECOND
                @board.statusarea.innerHTML = "後手の勝ちです"
                @startbtn.disabled = false; $("#btnStop").val("再開").button("refresh")
                @naviA.style.display = "block"
                @board.display()
                return
            else
                @board.statusarea.innerHTML = (if @teban.turn == Const.FIRST then "先手" else "後手") + "の番です"
        @s_posi = null; @d_posi = null
        @board.display()
        if @teban.human
            oppo = if @teban.turn == Const.FIRST then @second else @first
            ret = []
            # 詰みチェック
            ret = @teban.think(@board, oppo, 1, threshold)
            unless ret[0]
                @board.statusarea.innerHTML = (if @teban.turn == Const.FIRST then "後手" else "先手") + "の勝ちです"
                @startbtn.disabled = false; $("#btnStop").val("再開").button("refresh")
                @naviA.style.display = "block"
                return
        else
            @board.statusarea.innerHTML = "thinking..."
            setTimeout (=>
                event = new ($.Event)('ai_thinking')
                $(window).trigger event
                ),500

    touch: (piece, posi) ->
        # console.log("touch")
        return unless @startbtn.disabled
        return if @auto_flg
        dest = (v for v in @board.pieces when v.posi? && v.posi.toString() == posi.toString())
        if dest.length != 0 && dest[0].turn == piece.turn
            @s_posi = null
            return
        move_piece = new Piece.Piece(piece.turn, piece.status, [].concat(piece.posi))
        if dest.length != 0
            dest_piece = new Piece.Piece(dest[0].turn, dest[0].status, [].concat(dest[0].posi))
        if @board.check_move(piece, posi)
            @board.move_capture(piece, posi)
        else
            @s_posi = null
            return

        if @teban.turn == Const.FIRST
            player = @second
            oppo = @first
            threshold = Const.MIN_VALUE
        else
            player = @first
            oppo = @second
            threshold = Const.MAX_VALUE
        @board.make_kiki(player.turn)
        king = (v for v in @board.pieces when v.kind() == 'Ou' && v.turn == @teban.turn)[0]

        if (king.posi.toString() in @board.kiki[player.turn].map (o) -> o.toString())
            $('#popupCheckLeft').popup("open")
            @s_posi = null
            piece.turn = move_piece.turn
            piece.status = move_piece.status
            piece.posi = move_piece.posi
            if dest.length != 0
                dest[0].turn = dest_piece.turn
                dest[0].status = dest_piece.status
                dest[0].posi = dest_piece.posi
            return

        if piece.kind() == 'Fu' && move_piece.status == Const.Status.MOTIGOMA
            ret = []
            ret = player.think(@board, oppo, 1, threshold)
            if ret[2] >= Const.MAX_VALUE || ret[2] <= Const.MIN_VALUE
                if is_oute.call @, piece, posi
                    $('#popupDropPawnMate').popup("open")
                    @s_posi = null
                    piece.turn = move_piece.turn
                    piece.status = move_piece.status
                    piece.posi = move_piece.posi
                    return
        piece.turn = move_piece.turn
        piece.status = move_piece.status
        piece.posi = move_piece.posi
        if dest.length != 0
            dest[0].turn = dest_piece.turn
            dest[0].status = dest_piece.status
            dest[0].posi = dest_piece.posi

        if @board.check_move(piece, posi)
            if @board.check_promotion(piece, posi)
                @posi = posi
                $('#popupNari').popup("open")
            else
                @routine(piece, posi, false)
        else
            @s_posi = null
        return

    motigoma: (turn, kind) ->
        # console.log("motigoma")
        return unless @startbtn.disabled
        $('#b' + @pre_posi[0] + @pre_posi[1]).css('background-color', '#FFFACD') if @pre_posi
        @selected = (v for v in @board.pieces when v.turn == turn && v.kind() == kind && v.status == Const.Status.MOTIGOMA && v.turn == @teban.turn)[0]
        if @selected
            @s_posi = not null
        return

    select: (posi) ->
        # console.log("select")
        $('#b' + posi[0] + posi[1]).css('background-color', '#FFFACD')
        if !@s_posi
            @s_posi = posi
            @selected = (v for v in @board.pieces when v.posi? && v.posi.toString() == posi.toString() && v.turn == @teban.turn)[0]
            if @selected
                $('#b' + posi[0] + posi[1]).css('background-color', '#E3D7A6')
                @pre_posi = posi
            else
                @s_posi = null
        else
            @d_posi = posi
            $('#b' + @pre_posi[0] + @pre_posi[1]).css('background-color', '#FFFACD') if @pre_posi
            @touch(@selected, @d_posi)
        return

    set_standard: ->
        @board.pieces = []
        fo = new Piece.Ou(Const.FIRST, Const.Status.MOTIGOMA)
        @board.add(fo)
        so = new Piece.Ou(Const.SECOND, Const.Status.MOTIGOMA)
        @board.add(so)
        @board.move_capture(fo, [3,3])
        @board.move_capture(so, [1,1])
        fg = new Piece.Gi(Const.FIRST, Const.Status.MOTIGOMA)
        @board.add(fg)
        sg = new Piece.Gi(Const.SECOND, Const.Status.MOTIGOMA)
        @board.add(sg)
        ff = new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA)
        @board.add(ff)
        sf = new Piece.Fu(Const.SECOND, Const.Status.MOTIGOMA)
        @board.add(sf)

    set_arrange1: ->
        @board.pieces = []
        fo = new Piece.Ou(Const.FIRST, Const.Status.MOTIGOMA)
        @board.add(fo)
        so = new Piece.Ou(Const.SECOND, Const.Status.MOTIGOMA)
        @board.add(so)
        @board.move_capture(fo, [2,3])
        @board.move_capture(so, [2,1])
        fm = new Piece.Ka(Const.FIRST, Const.Status.MOTIGOMA)
        @board.add(fm)
        @board.move_capture(fm, [1,3])
        sm = new Piece.Ka(Const.SECOND, Const.Status.MOTIGOMA)
        @board.add(sm)
        @board.move_capture(sm, [3,1])
        ff = new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA)
        @board.add(ff)
        sf = new Piece.Fu(Const.SECOND, Const.Status.MOTIGOMA)
        @board.add(sf)

    set_arrange2: ->
        @board.pieces = []
        fo = new Piece.Ou(Const.FIRST, Const.Status.MOTIGOMA)
        @board.add(fo)
        so = new Piece.Ou(Const.SECOND, Const.Status.MOTIGOMA)
        @board.add(so)
        @board.move_capture(fo, [2,3])
        @board.move_capture(so, [2,1])
        ff = new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA)
        @board.add(ff)
        sf = new Piece.Fu(Const.SECOND, Const.Status.MOTIGOMA)
        @board.add(sf)
        fh = new Piece.Hi(Const.FIRST, Const.Status.MOTIGOMA)
        @board.add(fh)
        @board.move_capture(fh, [3,3])
        sm = new Piece.Ka(Const.SECOND, Const.Status.MOTIGOMA)
        @board.add(sm)
        @board.move_capture(sm, [1,1])

    set_arrange3: ->
        @board.pieces = []
        fo = new Piece.Ou(Const.FIRST, Const.Status.MOTIGOMA)
        @board.add(fo)
        so = new Piece.Ou(Const.SECOND, Const.Status.MOTIGOMA)
        @board.add(so)
        @board.move_capture(fo, [3,3])
        @board.move_capture(so, [1,1])
        fm = new Piece.Ka(Const.FIRST, Const.Status.MOTIGOMA)
        @board.add(fm)
        @board.move_capture(fm, [3,2])
        sm = new Piece.Ka(Const.SECOND, Const.Status.MOTIGOMA)
        @board.add(sm)
        @board.move_capture(sm, [1,2])
        ff = new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA)
        @board.add(ff)
        sf = new Piece.Fu(Const.SECOND, Const.Status.MOTIGOMA)
        @board.add(sf)

    set_arrange4: ->
        @board.pieces = []
        fo = new Piece.Ou(Const.FIRST, Const.Status.MOTIGOMA)
        @board.add(fo)
        so = new Piece.Ou(Const.SECOND, Const.Status.MOTIGOMA)
        @board.add(so)
        @board.move_capture(fo, [3,3])
        @board.move_capture(so, [1,1])
        fh = new Piece.Hi(Const.FIRST, Const.Status.MOTIGOMA)
        @board.add(fh)
        sh = new Piece.Hi(Const.SECOND, Const.Status.MOTIGOMA)
        @board.add(sh)
        fm = new Piece.Ka(Const.FIRST, Const.Status.MOTIGOMA)
        @board.add(fm)
        @board.move_capture(fm, [2,3])
        sm = new Piece.Ka(Const.SECOND, Const.Status.MOTIGOMA)
        @board.add(sm)
        @board.move_capture(sm, [2,1])
        ff = new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA)
        @board.add(ff)
        sf = new Piece.Fu(Const.SECOND, Const.Status.MOTIGOMA)
        @board.add(sf)

    set_arrange5: ->
        @board.pieces = []
        fo = new Piece.Ou(Const.FIRST, Const.Status.MOTIGOMA)
        @board.add(fo)
        so = new Piece.Ou(Const.SECOND, Const.Status.MOTIGOMA)
        @board.add(so)
        @board.move_capture(fo, [3,3])
        @board.move_capture(so, [1,1])
        fh = new Piece.Hi(Const.FIRST, Const.Status.MOTIGOMA)
        @board.add(fh)
        @board.move_capture(fh, [3,2])
        sh = new Piece.Hi(Const.SECOND, Const.Status.MOTIGOMA)
        @board.add(sh)
        @board.move_capture(sh, [1,2])
        fm = new Piece.Ka(Const.FIRST, Const.Status.MOTIGOMA)
        @board.add(fm)
        sm = new Piece.Ka(Const.SECOND, Const.Status.MOTIGOMA)
        @board.add(sm)
        ff = new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA)
        @board.add(ff)
        @board.move_capture(ff, [2,3])
        sf = new Piece.Fu(Const.SECOND, Const.Status.MOTIGOMA)
        @board.add(sf)
        @board.move_capture(sf, [2,1])

    set_arrange6: ->
        @board.pieces = []
        fo = new Piece.Ou(Const.FIRST, Const.Status.MOTIGOMA)
        @board.add(fo)
        so = new Piece.Ou(Const.SECOND, Const.Status.MOTIGOMA)
        @board.add(so)
        @board.move_capture(fo, [2,3])
        @board.move_capture(so, [2,1])
        fh = new Piece.Hi(Const.FIRST, Const.Status.MOTIGOMA)
        @board.add(fh)
        @board.move_capture(fh, [1,3])
        sh = new Piece.Hi(Const.SECOND, Const.Status.MOTIGOMA)
        @board.add(sh)
        @board.move_capture(sh, [3,1])

    set_arrange7: ->
        @board.pieces = []
        fo = new Piece.Ou(Const.FIRST, Const.Status.MOTIGOMA)
        @board.add(fo)
        so = new Piece.Ou(Const.SECOND, Const.Status.MOTIGOMA)
        @board.add(so)
        @board.move_capture(fo, [3,3])
        @board.move_capture(so, [1,1])
        fh = new Piece.Hi(Const.FIRST, Const.Status.MOTIGOMA)
        @board.add(fh)
        sh = new Piece.Hi(Const.SECOND, Const.Status.MOTIGOMA)
        @board.add(sh)
        ff = new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA)
        @board.add(ff)
        sf = new Piece.Fu(Const.SECOND, Const.Status.MOTIGOMA)
        @board.add(sf)

    set_arrange8: ->
        @board.pieces = []
        fo = new Piece.Ou(Const.FIRST, Const.Status.MOTIGOMA)
        @board.add(fo)
        so = new Piece.Ou(Const.SECOND, Const.Status.MOTIGOMA)
        @board.add(so)
        @board.move_capture(fo, [3,3])
        @board.move_capture(so, [1,1])
        fm = new Piece.Ka(Const.FIRST, Const.Status.MOTIGOMA)
        @board.add(fm)
        sh = new Piece.Hi(Const.SECOND, Const.Status.MOTIGOMA)
        @board.add(sh)

    set_arrange9: ->
        @board.pieces = []
        fo = new Piece.Ou(Const.FIRST, Const.Status.MOTIGOMA)
        @board.add(fo)
        so = new Piece.Ou(Const.SECOND, Const.Status.MOTIGOMA)
        @board.add(so)
        @board.move_capture(fo, [3,3])
        @board.move_capture(so, [1,1])
        fx = new Piece.Ki(Const.FIRST, Const.Status.MOTIGOMA)
        @board.add(fx)
        @board.move_capture(fx, [2,3])
        sx = new Piece.Ki(Const.SECOND, Const.Status.MOTIGOMA)
        @board.add(sx)
        @board.move_capture(sx, [2,1])
        ff = new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA)
        @board.add(ff)
        @board.move_capture(ff, [1,3])
        sf = new Piece.Fu(Const.SECOND, Const.Status.MOTIGOMA)
        @board.add(sf)
        @board.move_capture(sf, [3,1])

    set_arrange10: ->
        @board.pieces = []
        fo = new Piece.Ou(Const.FIRST, Const.Status.MOTIGOMA)
        @board.add(fo)
        so = new Piece.Ou(Const.SECOND, Const.Status.MOTIGOMA)
        @board.add(so)
        @board.move_capture(fo, [3,3])
        @board.move_capture(so, [1,1])
        fk = new Piece.Ke(Const.FIRST, Const.Status.MOTIGOMA)
        @board.add(fk)
        @board.move_capture(fk, [1,3])
        sk = new Piece.Ke(Const.SECOND, Const.Status.MOTIGOMA)
        @board.add(sk)
        @board.move_capture(sk, [3,1])
        ff = new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA)
        @board.add(ff)
        @board.move_capture(ff, [2,3])
        sf = new Piece.Fu(Const.SECOND, Const.Status.MOTIGOMA)
        @board.add(sf)
        @board.move_capture(sf, [2,1])

    set_arrange11: ->
        @board.pieces = []
        fo = new Piece.Ou(Const.FIRST, Const.Status.MOTIGOMA)
        @board.add(fo)
        so = new Piece.Ou(Const.SECOND, Const.Status.MOTIGOMA)
        @board.add(so)
        @board.move_capture(fo, [3,3])
        @board.move_capture(so, [1,1])
        fk = new Piece.Ke(Const.FIRST, Const.Status.MOTIGOMA)
        @board.add(fk)
        sk = new Piece.Ke(Const.SECOND, Const.Status.MOTIGOMA)
        @board.add(sk)
        ff = new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA)
        @board.add(ff)
        sf = new Piece.Fu(Const.SECOND, Const.Status.MOTIGOMA)
        @board.add(sf)

    set_arrange12: ->
        @board.pieces = []
        fo = new Piece.Ou(Const.FIRST, Const.Status.MOTIGOMA)
        @board.add(fo)
        so = new Piece.Ou(Const.SECOND, Const.Status.MOTIGOMA)
        @board.add(so)
        @board.move_capture(fo, [3,3])
        @board.move_capture(so, [1,1])
        fy = new Piece.Ky(Const.FIRST, Const.Status.MOTIGOMA)
        @board.add(fy)
        sy = new Piece.Ky(Const.SECOND, Const.Status.MOTIGOMA)
        @board.add(sy)
        ff = new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA)
        @board.add(ff)
        sf = new Piece.Fu(Const.SECOND, Const.Status.MOTIGOMA)
        @board.add(sf)

    set_arrange13: ->
        @board.pieces = []
        fo = new Piece.Ou(Const.FIRST, Const.Status.MOTIGOMA)
        @board.add(fo)
        so = new Piece.Ou(Const.SECOND, Const.Status.MOTIGOMA)
        @board.add(so)
        @board.move_capture(fo, [3,2])
        @board.move_capture(so, [1,1])
        fy = new Piece.Ky(Const.FIRST, Const.Status.MOTIGOMA)
        @board.add(fy)
        sx = new Piece.Ki(Const.SECOND, Const.Status.MOTIGOMA)
        @board.add(sx)

    set_arrange14: ->
        @board.pieces = []
        fo = new Piece.Ou(Const.FIRST, Const.Status.MOTIGOMA)
        @board.add(fo)
        so = new Piece.Ou(Const.SECOND, Const.Status.MOTIGOMA)
        @board.add(so)
        @board.move_capture(fo, [3,3])
        @board.move_capture(so, [1,1])
        fk = new Piece.Ke(Const.FIRST, Const.Status.MOTIGOMA)
        @board.add(fk)
        sk = new Piece.Ke(Const.SECOND, Const.Status.MOTIGOMA)
        @board.add(sk)
        fy = new Piece.Ky(Const.FIRST, Const.Status.MOTIGOMA)
        @board.add(fy)
        sy = new Piece.Ky(Const.SECOND, Const.Status.MOTIGOMA)
        @board.add(sy)

    set_arrange15: ->
        @board.pieces = []
        fo = new Piece.Ou(Const.FIRST, Const.Status.MOTIGOMA)
        @board.add(fo)
        so = new Piece.Ou(Const.SECOND, Const.Status.MOTIGOMA)
        @board.add(so)
        @board.move_capture(fo, [3,3])
        @board.move_capture(so, [1,1])
        fm = new Piece.Ka(Const.FIRST, Const.Status.MOTIGOMA)
        @board.add(fm)
        @board.move_capture(fm, [2,3])
        sm = new Piece.Ka(Const.SECOND, Const.Status.MOTIGOMA)
        @board.add(sm)
        @board.move_capture(sm, [2,1])
        ff = new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA)
        @board.add(ff)
        @board.move_capture(ff, [1,3])
        sf = new Piece.Fu(Const.SECOND, Const.Status.MOTIGOMA)
        @board.add(sf)
        @board.move_capture(sf, [3,1])

    set_arrange16: ->
        @board.pieces = []
        fo = new Piece.Ou(Const.FIRST, Const.Status.MOTIGOMA)
        @board.add(fo)
        so = new Piece.Ou(Const.SECOND, Const.Status.MOTIGOMA)
        @board.add(so)
        @board.move_capture(fo, [3,1])
        @board.move_capture(so, [1,3])
        fg = new Piece.Gi(Const.FIRST, Const.Status.MOTIGOMA)
        @board.add(fg)
        fx = new Piece.Ki(Const.FIRST, Const.Status.MOTIGOMA)
        @board.add(fx)
        sg = new Piece.Gi(Const.SECOND, Const.Status.MOTIGOMA)
        @board.add(sg)
        sx = new Piece.Ki(Const.SECOND, Const.Status.MOTIGOMA)
        @board.add(sx)
        @board.move_capture(sx, [2,2])

    set_arrange17: ->
        @board.pieces = []
        fo = new Piece.Ou(Const.FIRST, Const.Status.MOTIGOMA)
        @board.add(fo)
        so = new Piece.Ou(Const.SECOND, Const.Status.MOTIGOMA)
        @board.add(so)
        @board.move_capture(fo, [3,3])
        @board.move_capture(so, [1,1])
        fg = new Piece.Gi(Const.FIRST, Const.Status.MOTIGOMA)
        @board.add(fg)
        sx = new Piece.Ki(Const.SECOND, Const.Status.MOTIGOMA)
        @board.add(sx)

    set_arrange18: ->
        @board.pieces = []
        fo = new Piece.Ou(Const.FIRST, Const.Status.MOTIGOMA)
        @board.add(fo)
        so = new Piece.Ou(Const.SECOND, Const.Status.MOTIGOMA)
        @board.add(so)
        @board.move_capture(fo, [2,3])
        @board.move_capture(so, [2,1])
        fh = new Piece.Hi(Const.FIRST, Const.Status.MOTIGOMA)
        @board.add(fh)
        sm = new Piece.Ka(Const.SECOND, Const.Status.MOTIGOMA)
        @board.add(sm)
        sf = new Piece.Fu(Const.SECOND, Const.Status.MOTIGOMA)
        @board.add(sf)

    set_arrange19: ->
        @board.pieces = []
        fo = new Piece.Ou(Const.FIRST, Const.Status.MOTIGOMA)
        @board.add(fo)
        so = new Piece.Ou(Const.SECOND, Const.Status.MOTIGOMA)
        @board.add(so)
        @board.move_capture(fo, [2,3])
        @board.move_capture(so, [2,1])
        fk = new Piece.Ke(Const.FIRST, Const.Status.MOTIGOMA)
        @board.add(fk)
        sf = new Piece.Fu(Const.SECOND, Const.Status.MOTIGOMA)
        @board.add(sf)

    set_arrange20: ->
        @board.pieces = []
        fo = new Piece.Ou(Const.FIRST, Const.Status.MOTIGOMA)
        @board.add(fo)
        so = new Piece.Ou(Const.SECOND, Const.Status.MOTIGOMA)
        @board.add(so)
        @board.move_capture(fo, [3,3])
        @board.move_capture(so, [1,1])
        @board.add(new Piece.Ka(Const.SECOND, Const.Status.MOTIGOMA))
        @board.add(new Piece.Ke(Const.FIRST, Const.Status.MOTIGOMA))
        @board.add(new Piece.Ke(Const.FIRST, Const.Status.MOTIGOMA))

    set_arrange21: ->
        @board.pieces = []
        fo = new Piece.Ou(Const.FIRST, Const.Status.MOTIGOMA)
        @board.add(fo)
        so = new Piece.Ou(Const.SECOND, Const.Status.MOTIGOMA)
        @board.add(so)
        @board.move_capture(fo, [3,3])
        @board.move_capture(so, [1,1])
        sf = new Piece.Fu(Const.SECOND, Const.Status.MOTIGOMA)
        @board.add(sf)
        @board.move_capture(sf, [2,2])
        fh = new Piece.Hi(Const.FIRST, Const.Status.MOTIGOMA)
        @board.add(fh)
        sx = new Piece.Ki(Const.SECOND, Const.Status.MOTIGOMA)
        @board.add(sx)

    set_arrange22: ->
        @board.pieces = []
        fo = new Piece.Ou(Const.FIRST, Const.Status.MOTIGOMA)
        @board.add(fo)
        so = new Piece.Ou(Const.SECOND, Const.Status.MOTIGOMA)
        @board.add(so)
        @board.move_capture(fo, [3,3])
        @board.move_capture(so, [1,1])
        sm = new Piece.Ka(Const.SECOND, Const.Status.MOTIGOMA)
        @board.add(sm)
        fh = new Piece.Hi(Const.FIRST, Const.Status.MOTIGOMA)
        @board.add(fh)
        @board.move_capture(fh, [2,3])
        @board.move_capture(sm, [2,1])
        ff = new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA)
        @board.add(ff)
        sf = new Piece.Fu(Const.SECOND, Const.Status.MOTIGOMA)
        @board.add(sf)
        @board.move_capture(ff, [1,3])
        @board.move_capture(sf, [3,1])

    set_arrange23: ->
        @board.pieces = []
        fo = new Piece.Ou(Const.FIRST, Const.Status.MOTIGOMA)
        @board.add(fo)
        so = new Piece.Ou(Const.SECOND, Const.Status.MOTIGOMA)
        @board.add(so)
        @board.move_capture(fo, [3,3])
        @board.move_capture(so, [1,1])
        fm = new Piece.Ka(Const.FIRST, Const.Status.MOTIGOMA)
        @board.add(fm)
        sh = new Piece.Hi(Const.SECOND, Const.Status.MOTIGOMA)
        @board.add(sh)
        ff = new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA)
        @board.add(ff)
        sf = new Piece.Fu(Const.SECOND, Const.Status.MOTIGOMA)
        @board.add(sf)

    set_arrange24: ->
        @board.pieces = []
        ff = new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA)
        @board.add(ff)
        @board.move_capture(ff, [3,3])
        ff2 = new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA)
        @board.add(ff2)
        @board.move_capture(ff2, [2,2])
        fx = new Piece.Ki(Const.FIRST, Const.Status.MOTIGOMA)
        @board.add(fx)
        @board.move_capture(fx, [2,1])
        fx2 = new Piece.Ki(Const.FIRST, Const.Status.MOTIGOMA)
        @board.add(fx2)
        @board.move_capture(fx2, [3,2])
        sg = new Piece.Gi(Const.SECOND, Const.Status.MOTIGOMA)
        @board.add(sg)
        @board.move_capture(sg, [2,3])
        sg2 = new Piece.Gi(Const.SECOND, Const.Status.MOTIGOMA)
        @board.add(sg2)
        @board.move_capture(sg2, [1,2])
        sy = new Piece.Ky(Const.SECOND, Const.Status.MOTIGOMA)
        @board.add(sy)
        @board.move_capture(sy, [1,1])
        fo = new Piece.Ou(Const.FIRST, Const.Status.MOTIGOMA)
        @board.add(fo)
        so = new Piece.Ou(Const.SECOND, Const.Status.MOTIGOMA)
        @board.add(so)
        @board.move_capture(fo, [3,1])
        @board.move_capture(so, [1,3])

    set_arrange25: ->
        @board.pieces = []
        fo = new Piece.Ou(Const.FIRST, Const.Status.MOTIGOMA)
        @board.add(fo)
        so = new Piece.Ou(Const.SECOND, Const.Status.MOTIGOMA)
        @board.add(so)
        @board.move_capture(fo, [2,1])
        @board.move_capture(so, [2,3])
        ff = new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA)
        @board.add(ff)
        sf = new Piece.Fu(Const.SECOND, Const.Status.MOTIGOMA)
        @board.add(sf)

    set_arrange26: ->
        @board.pieces = []
        fo = new Piece.Ou(Const.FIRST, Const.Status.MOTIGOMA)
        @board.add(fo)
        so = new Piece.Ou(Const.SECOND, Const.Status.MOTIGOMA)
        @board.add(so)
        @board.move_capture(fo, [3,3])
        @board.move_capture(so, [1,1])
        fk = new Piece.Ke(Const.FIRST, Const.Status.MOTIGOMA)
        @board.add(fk)
        fy = new Piece.Ky(Const.FIRST, Const.Status.MOTIGOMA)
        @board.add(fy)
        sg = new Piece.Gi(Const.SECOND, Const.Status.MOTIGOMA)
        @board.add(sg)

    set_arrange27: ->
        @board.pieces = []
        fo = new Piece.Ou(Const.FIRST, Const.Status.MOTIGOMA)
        @board.add(fo)
        so = new Piece.Ou(Const.SECOND, Const.Status.MOTIGOMA)
        @board.add(so)
        @board.move_capture(fo, [1,3])
        @board.move_capture(so, [3,1])
        sy = new Piece.Ky(Const.SECOND, Const.Status.MOTIGOMA)
        @board.add(sy)
        @board.move_capture(sy, [2,1])
        fm = new Piece.Ka(Const.FIRST, Const.Status.MOTIGOMA)
        @board.add(fm)
        sm = new Piece.Ka(Const.SECOND, Const.Status.MOTIGOMA)
        @board.add(sm)
        ff = new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA)
        @board.add(ff)
        ff2 = new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA)
        @board.add(ff2)

    set_arrange28: ->
        @board.pieces = []
        fo = new Piece.Ou(Const.FIRST, Const.Status.MOTIGOMA)
        @board.add(fo)
        so = new Piece.Ou(Const.SECOND, Const.Status.MOTIGOMA)
        @board.add(so)
        @board.move_capture(fo, [2,3])
        @board.move_capture(so, [2,1])
        fm = new Piece.Ka(Const.FIRST, Const.Status.MOTIGOMA)
        @board.add(fm)
        sh = new Piece.Hi(Const.SECOND, Const.Status.MOTIGOMA)
        @board.add(sh)
        ff = new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA)
        @board.add(ff)
        sf = new Piece.Fu(Const.SECOND, Const.Status.MOTIGOMA)
        @board.add(sf)

    set_arrange29: ->
        @board.pieces = []
        fo = new Piece.Ou(Const.FIRST, Const.Status.MOTIGOMA)
        @board.add(fo)
        so = new Piece.Ou(Const.SECOND, Const.Status.MOTIGOMA)
        @board.add(so)
        @board.move_capture(fo, [2,3])
        @board.move_capture(so, [2,1])
        fm = new Piece.Ka(Const.FIRST, Const.Status.MOTIGOMA)
        @board.add(fm)
        @board.move_capture(fm, [3,3])
        sh = new Piece.Hi(Const.SECOND, Const.Status.MOTIGOMA)
        @board.add(sh)
        @board.move_capture(sh, [3,1])
        ff = new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA)
        @board.add(ff)
        sy = new Piece.Ky(Const.SECOND, Const.Status.MOTIGOMA)
        @board.add(sy)

    set_arrange30: ->
        @board.pieces = []
        fo = new Piece.Ou(Const.FIRST, Const.Status.MOTIGOMA)
        @board.add(fo)
        so = new Piece.Ou(Const.SECOND, Const.Status.MOTIGOMA)
        @board.add(so)
        @board.move_capture(fo, [2,3])
        @board.move_capture(so, [2,1])
        fh = new Piece.Hi(Const.FIRST, Const.Status.MOTIGOMA)
        @board.add(fh)
        @board.move_capture(fh, [3,3])
        sh = new Piece.Hi(Const.SECOND, Const.Status.MOTIGOMA)
        @board.add(sh)
        @board.move_capture(sh, [1,1])
        ff = new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA)
        @board.add(ff)
        sf = new Piece.Fu(Const.SECOND, Const.Status.MOTIGOMA)
        @board.add(sf)

    set_arrange31: ->
        @board.pieces = []
        fo = new Piece.Ou(Const.FIRST, Const.Status.MOTIGOMA)
        @board.add(fo)
        so = new Piece.Ou(Const.SECOND, Const.Status.MOTIGOMA)
        @board.add(so)
        @board.move_capture(fo, [3,3])
        @board.move_capture(so, [1,1])
        ff = new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA)
        @board.add(ff)
        sk = new Piece.Ke(Const.SECOND, Const.Status.MOTIGOMA)
        @board.add(sk)
        sy = new Piece.Ky(Const.SECOND, Const.Status.MOTIGOMA)
        @board.add(sy)

    set_arrange32: ->
        @board.pieces = []
        fo = new Piece.Ou(Const.FIRST, Const.Status.MOTIGOMA)
        @board.add(fo)
        so = new Piece.Ou(Const.SECOND, Const.Status.MOTIGOMA)
        @board.add(so)
        @board.move_capture(fo, [3,3])
        @board.move_capture(so, [1,1])
        sy = new Piece.Ky(Const.SECOND, Const.Status.MOTIGOMA)
        @board.add(sy)
        @board.move_capture(sy, [1,2])
        sk = new Piece.Ke(Const.SECOND, Const.Status.MOTIGOMA)
        @board.add(sk)
        @board.move_capture(sk, [2,1])
        sm = new Piece.Ka(Const.SECOND, Const.Status.MOTIGOMA)
        @board.add(sm)
        @board.move_capture(sm, [3,2])
        sg = new Piece.Gi(Const.SECOND, Const.Status.MOTIGOMA)
        @board.add(sg)
        @board.move_capture(sg, [2,3])
        ff2 = new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA)
        @board.add(ff2)
        @board.move_capture(ff2, [1,3])
        fh = new Piece.Hi(Const.FIRST, Const.Status.MOTIGOMA)
        @board.add(fh)
        @board.move_capture(fh, [3,1])
        ff = new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA)
        @board.add(ff)
        @board.move_capture(ff, [2,2])

    set_arrange33: ->
        @board.pieces = []
        fo = new Piece.Ou(Const.FIRST, Const.Status.MOTIGOMA)
        @board.add(fo)
        so = new Piece.Ou(Const.SECOND, Const.Status.MOTIGOMA)
        @board.add(so)
        @board.move_capture(fo, [3,3])
        @board.move_capture(so, [3,1])
        fh = new Piece.Hi(Const.FIRST, Const.Status.MOTIGOMA)
        @board.add(fh)
        @board.move_capture(fh, [2,3])
        sh = new Piece.Hi(Const.SECOND, Const.Status.MOTIGOMA)
        @board.add(sh)
        @board.move_capture(sh, [2,1])

    set_arrange34: ->
        @board.pieces = []
        fo = new Piece.Ou(Const.FIRST, Const.Status.MOTIGOMA)
        @board.add(fo)
        so = new Piece.Ou(Const.SECOND, Const.Status.MOTIGOMA)
        @board.add(so)
        @board.move_capture(fo, [2,3])
        @board.move_capture(so, [2,1])
        fm = new Piece.Ka(Const.FIRST, Const.Status.MOTIGOMA)
        @board.add(fm)
        sh = new Piece.Hi(Const.SECOND, Const.Status.MOTIGOMA)
        @board.add(sh)
        @board.move_capture(sh, [3,2])

    set_arrange35: ->
        @board.pieces = []
        fo = new Piece.Ou(Const.FIRST, Const.Status.MOTIGOMA)
        @board.add(fo)
        so = new Piece.Ou(Const.SECOND, Const.Status.MOTIGOMA)
        @board.add(so)
        @board.move_capture(fo, [3,3])
        @board.move_capture(so, [1,1])
        fy = new Piece.Ky(Const.FIRST, Const.Status.MOTIGOMA)
        @board.add(fy)
        @board.move_capture(fy, [2,3])
        sm = new Piece.Ka(Const.SECOND, Const.Status.MOTIGOMA)
        @board.add(sm)
        @board.move_capture(sm, [2,1])
        ff = new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA)
        @board.add(ff)
        @board.move_capture(ff, [1,3])
        sf = new Piece.Fu(Const.SECOND, Const.Status.MOTIGOMA)
        @board.add(sf)
        @board.move_capture(sf, [3,1])

    set_arrange36: ->
        @board.pieces = []
        fo = new Piece.Ou(Const.FIRST, Const.Status.MOTIGOMA)
        @board.add(fo)
        so = new Piece.Ou(Const.SECOND, Const.Status.MOTIGOMA)
        @board.add(so)
        @board.move_capture(fo, [3,3])
        @board.move_capture(so, [1,1])
        fm = new Piece.Ka(Const.FIRST, Const.Status.MOTIGOMA)
        @board.add(fm)
        sg = new Piece.Gi(Const.SECOND, Const.Status.MOTIGOMA)
        @board.add(sg)
        sg2 = new Piece.Gi(Const.SECOND, Const.Status.MOTIGOMA)
        @board.add(sg2)
        ff = new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA)
        @board.add(ff)

    set_arrange37: ->
        @board.pieces = []
        fo = new Piece.Ou(Const.FIRST, Const.Status.MOTIGOMA)
        @board.add(fo)
        so = new Piece.Ou(Const.SECOND, Const.Status.MOTIGOMA)
        @board.add(so)
        @board.move_capture(fo, [3,3])
        @board.move_capture(so, [1,1])
        sm = new Piece.Ka(Const.SECOND, Const.Status.MOTIGOMA)
        @board.add(sm)
        sm2 = new Piece.Ka(Const.SECOND, Const.Status.MOTIGOMA)
        @board.add(sm2)
        fg = new Piece.Gi(Const.FIRST, Const.Status.MOTIGOMA)
        @board.add(fg)
        fg2 = new Piece.Gi(Const.FIRST, Const.Status.MOTIGOMA)
        @board.add(fg2)
        ff = new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA)
        @board.add(ff)
        sf = new Piece.Fu(Const.SECOND, Const.Status.MOTIGOMA)
        @board.add(sf)
        @board.move_capture(sf, [2,1])

    set_arrange38: ->
        @board.pieces = []
        fo = new Piece.Ou(Const.FIRST, Const.Status.MOTIGOMA)
        @board.add(fo)
        so = new Piece.Ou(Const.SECOND, Const.Status.MOTIGOMA)
        @board.add(so)
        @board.move_capture(fo, [3,3])
        @board.move_capture(so, [1,1])
        fm = new Piece.Ka(Const.FIRST, Const.Status.MOTIGOMA)
        @board.add(fm)
        sh = new Piece.Hi(Const.SECOND, Const.Status.MOTIGOMA)
        @board.add(sh)
        ff = new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA)
        @board.add(ff)
        @board.move_capture(ff, [2,3])
        sf = new Piece.Fu(Const.SECOND, Const.Status.MOTIGOMA)
        @board.add(sf)
        @board.move_capture(sf, [2,1])

    set_arrange39: ->
        @board.pieces = []
        fo = new Piece.Ou(Const.FIRST, Const.Status.MOTIGOMA)
        @board.add(fo)
        so = new Piece.Ou(Const.SECOND, Const.Status.MOTIGOMA)
        @board.add(so)
        @board.move_capture(fo, [2,3])
        @board.move_capture(so, [2,1])
        fm = new Piece.Ka(Const.FIRST, Const.Status.MOTIGOMA)
        @board.add(fm)
        sh = new Piece.Hi(Const.SECOND, Const.Status.MOTIGOMA)
        @board.add(sh)
        ff = new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA)
        @board.add(ff)
        sf = new Piece.Fu(Const.SECOND, Const.Status.MOTIGOMA)
        @board.add(sf)

    set_arrange40: ->
        @board.pieces = []
        fo = new Piece.Ou(Const.FIRST, Const.Status.MOTIGOMA)
        @board.add(fo)
        so = new Piece.Ou(Const.SECOND, Const.Status.MOTIGOMA)
        @board.add(so)
        @board.move_capture(fo, [2,3])
        @board.move_capture(so, [2,1])
        fg = new Piece.Gi(Const.FIRST, Const.Status.MOTIGOMA)
        @board.add(fg)
        @board.move_capture(fg, [1,3])
        sh = new Piece.Hi(Const.SECOND, Const.Status.MOTIGOMA)
        @board.add(sh)
        @board.move_capture(sh, [3,2])
        ff = new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA)
        @board.add(ff)
        sf = new Piece.Fu(Const.SECOND, Const.Status.MOTIGOMA)
        @board.add(sf)

    set_arrange41: ->
        @board.pieces = []
        fo = new Piece.Ou(Const.FIRST, Const.Status.MOTIGOMA)
        @board.add(fo)
        so = new Piece.Ou(Const.SECOND, Const.Status.MOTIGOMA)
        @board.add(so)
        @board.move_capture(fo, [3,3])
        @board.move_capture(so, [1,1])
        fm = new Piece.Ka(Const.FIRST, Const.Status.MOTIGOMA)
        @board.add(fm)
        @board.move_capture(fm, [3,1])
        sm = new Piece.Ka(Const.SECOND, Const.Status.MOTIGOMA)
        @board.add(sm)
        @board.move_capture(sm, [1,3])
        ff = new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA)
        @board.add(ff)
        @board.move_capture(ff, [3,2])
        sf = new Piece.Fu(Const.SECOND, Const.Status.MOTIGOMA)
        @board.add(sf)
        @board.move_capture(sf, [1,2])

    set_arrange42: ->
        @board.pieces = []
        fo = new Piece.Ou(Const.FIRST, Const.Status.MOTIGOMA)
        @board.add(fo)
        so = new Piece.Ou(Const.SECOND, Const.Status.MOTIGOMA)
        @board.add(so)
        @board.move_capture(fo, [3,3])
        @board.move_capture(so, [1,1])
        fy = new Piece.Ky(Const.FIRST, Const.Status.MOTIGOMA)
        @board.add(fy)
        sx = new Piece.Ki(Const.SECOND, Const.Status.MOTIGOMA)
        @board.add(sx)
        sm = new Piece.Ka(Const.SECOND, Const.Status.MOTIGOMA)
        @board.add(sm)
        ff = new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA)
        @board.add(ff)
        @board.move_capture(ff, [2,2])

    set_arrange43: ->
        @board.pieces = []
        fo = new Piece.Ou(Const.FIRST, Const.Status.MOTIGOMA)
        @board.add(fo)
        so = new Piece.Ou(Const.SECOND, Const.Status.MOTIGOMA)
        @board.add(so)
        @board.move_capture(fo, [3,3])
        @board.move_capture(so, [1,1])
        fh = new Piece.Hi(Const.FIRST, Const.Status.MOTIGOMA)
        @board.add(fh)
        sg = new Piece.Gi(Const.SECOND, Const.Status.MOTIGOMA)
        @board.add(sg)
        sg2 = new Piece.Gi(Const.SECOND, Const.Status.MOTIGOMA)
        @board.add(sg2)
        ff = new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA)
        @board.add(ff)
        @board.move_capture(ff, [2,3])
        sf = new Piece.Fu(Const.SECOND, Const.Status.MOTIGOMA)
        @board.add(sf)
        @board.move_capture(sf, [2,1])

    set_arrange44: ->
        @board.pieces = []
        @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
        @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
        @board.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.OMOTE, [3,3]))
        @board.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.OMOTE, [1,1]))
        @board.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.OMOTE, [2,3]))
        @board.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.OMOTE, [2,1]))
        
    set_arrange45: ->
        @board.pieces = []
        @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
        @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
        @board.pieces.push(new Piece.Gi(Const.FIRST, Const.Status.MOTIGOMA))
        @board.pieces.push(new Piece.Gi(Const.SECOND, Const.Status.MOTIGOMA))
        @board.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.MOTIGOMA))
        @board.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA))

    set_arrange46: ->
        @board.pieces = []
        @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [2,1]))
        @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [2,3]))
        @board.pieces.push(new Piece.Ka(Const.FIRST, Const.Status.MOTIGOMA))
        @board.pieces.push(new Piece.Ka(Const.SECOND, Const.Status.MOTIGOMA))
        @board.pieces.push(new Piece.Gi(Const.FIRST, Const.Status.OMOTE, [3,1]))
        @board.pieces.push(new Piece.Gi(Const.SECOND, Const.Status.OMOTE, [1,3]))
        
    set_arrange47: ->
        @board.pieces = []
        @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [2,1]))
        @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [2,3]))
        @board.pieces.push(new Piece.Ka(Const.FIRST, Const.Status.MOTIGOMA))
        @board.pieces.push(new Piece.Ka(Const.SECOND, Const.Status.MOTIGOMA))
        @board.pieces.push(new Piece.Ky(Const.FIRST, Const.Status.OMOTE, [1,3]))
        @board.pieces.push(new Piece.Ky(Const.SECOND, Const.Status.OMOTE, [3,1]))

    set_arrange48: ->
        @board.pieces = []
        @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
        @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
        @board.pieces.push(new Piece.Ky(Const.FIRST, Const.Status.MOTIGOMA))
        @board.pieces.push(new Piece.Ky(Const.SECOND, Const.Status.MOTIGOMA))
        @board.pieces.push(new Piece.Gi(Const.FIRST, Const.Status.OMOTE, [3,3]))
        @board.pieces.push(new Piece.Gi(Const.SECOND, Const.Status.OMOTE, [1,1]))

    set_arrange49: ->
        @board.pieces = []
        @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
        @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
        @board.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.OMOTE, [2,3]))
        @board.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.OMOTE, [2,1]))
        @board.pieces.push(new Piece.Gi(Const.FIRST, Const.Status.OMOTE, [1,2]))
        @board.pieces.push(new Piece.Gi(Const.SECOND, Const.Status.OMOTE, [3,2]))

    set_arrange50: ->
        @board.pieces = []
        @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [1,2]))
        @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [3,2]))
        @board.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.OMOTE, [3,3]))
        @board.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.OMOTE, [1,1]))
        @board.pieces.push(new Piece.Ky(Const.FIRST, Const.Status.MOTIGOMA))
        @board.pieces.push(new Piece.Ky(Const.SECOND, Const.Status.MOTIGOMA))
                                
    setBoardSize: (w, h) ->
        if w <= h
            @board.width = w * 0.70
            @board.height = w * 0.70
        else
            @board.width = h * 0.70
            @board.height = h * 0.70
        return

    setEventListener: (special) ->
        $(window).on 'ai_thinking', (e) =>
            # console.log("ai_thinking")
            if @teban.turn == Const.FIRST
                player = @first
                oppo = @second
                player_threshold = Const.MAX_VALUE
                oppo_threshold = Const.MIN_VALUE
            else
                player = @second
                oppo = @first
                player_threshold = Const.MIN_VALUE
                oppo_threshold = Const.MAX_VALUE
            # 対人戦の場合は相手玉を取るまで指す
            temp = []; ret = []
            for i in [1,2,4,player.depth].unique()
                temp = []
                # if i >= 6
                #     temp = player.prepare(@board, oppo, i, player_threshold)
                # else
                temp = player.think(@board, oppo, i, player_threshold)
                # console.log("player = #{player.turn}: i = #{i}: temp = #{JSON.stringify(temp)}")
                if temp[0]?
                    ret = [].concat(temp)
                    break if (temp[2] >= Const.MAX_VALUE || temp[2] <= Const.MIN_VALUE)
                else
                    break
            if ret[0]
                # 一手前のハッシュ値ですでに千日手判定されていればreturn
                chk_sennitite =  @sennitite(@md5hash)
                if chk_sennitite
                    @board.display()
                    return
                # else if chk_sennitite == null && ret[4]["koma"]?
                #         ret[0] = ret[4]["koma"]
                #         ret[1] = ret[4]["posi"]
                #         ret[2] = ret[4]["score"]
                #         ret[3] = ret[4]["status"]
                if @board.check_move(ret[0], ret[1])
                    src_posi = @board.move_capture(ret[0], ret[1])
                    ret[0].status = ret[3]
                @md5hash = crypto.createHash('md5').update(JSON.stringify(@board.pieces)).digest("hex")
                @seq += 1
                @addState(@md5hash)
                if @sennitite(@md5hash)
                    @board.display()
                    return
                @teban = if (@seq % 2) == 0 then @first else @second
            else
                @board.statusarea.innerHTML = (if @teban.turn == Const.FIRST then "後手" else "先手") + "の勝ちです"
                @startbtn.disabled = false; $("#btnStop").val("再開").button("refresh")
                @naviA.style.display = "block"
                return

            # 詰みチェック
            ret = []
            ret = oppo.think(@board, player, 1, oppo_threshold)
            unless ret[0]
                switch ret[2]
                    when Const.MAX_VALUE
                        @board.statusarea.innerHTML = "先手の勝ちです"
                        @startbtn.disabled = false; $("#btnStop").val("再開").button("refresh")
                        @naviA.style.display = "block"
                    when Const.MIN_VALUE
                        @board.statusarea.innerHTML = "後手の勝ちです"
                        @startbtn.disabled = false; $("#btnStop").val("再開").button("refresh")
                        @naviA.style.display = "block"
                    else
                        console.log("Error!")
                @board.display()
                return
            # 相手玉が自爆しても指し手を進めてしまうのでゲーム終了チェック
            switch @board.gameover()
                when Const.FIRST
                    @board.statusarea.innerHTML = "先手の勝ちです"
                    @startbtn.disabled = false; $("#btnStop").val("再開").button("refresh")
                    @naviA.style.display = "block"
                when Const.SECOND
                    @board.statusarea.innerHTML = "後手の勝ちです"
                    @startbtn.disabled = false; $("#btnStop").val("再開").button("refresh")
                    @naviA.style.display = "block"
                else
                    @board.statusarea.innerHTML = (if @teban.turn == Const.FIRST then "先手" else "後手") + "の番です"
            @board.display()

        $(window).on 'load', (e) =>
            # console.log("=== Load ===")
            target = $(e.currentTarget)
            @setBoardSize(target.width(), target.height())
            @init()
            @board.init()
            @board.display()
        $(window).on special, (e) =>
            # console.log("=== Device Ready ===")
            target = $(e.currentTarget)
            # @setBoardSize(target.width(), target.height())

    is_oute = (piece, d_posi) ->
        oppo = if piece.turn == Const.FIRST then Const.SECOND else Const.FIRST
        oppo_king = (v for v in @board.pieces when v.turn == oppo && v.kind() == 'Ou')[0]
        buf = [].concat(d_posi)
        buf[0] += eval("Piece."+piece.kind()).getD(piece.turn, piece.status)[0].xd
        buf[1] += eval("Piece."+piece.kind()).getD(piece.turn, piece.status)[0].yd
        # check = piece.status == Const.Status.MOTIGOMA && piece.kind() == 'Fu' && oppo_king.posi.toString() == buf.toString()
        return (oppo_king.posi.toString() == buf.toString())

    launch = ->
        radio_checked = (v for v in @radio_arrange when v.checked == true)[0]
        switch parseInt(radio_checked.value|0, 10)
            when 0
                @set_standard()
            when 1
                @set_arrange1()
            when 2
                @set_arrange2()
            when 3
                @set_arrange3()
            when 4
                @set_arrange4()
            when 5
                @set_arrange5()
            when 6
                @set_arrange6()
            when 7
                @set_arrange7()
            when 8
                @set_arrange8()
            when 9
                @set_arrange9()
            when 10
                @set_arrange10()
            when 11
                @set_arrange11()
            when 12
                @set_arrange12()
            when 13
                @set_arrange13()
            when 14
                @set_arrange14()
            when 15
                @set_arrange15()
            when 16
                @set_arrange16()
            when 17
                @set_arrange17()
            when 18
                @set_arrange18()
            when 19
                @set_arrange19()
            when 20
                @set_arrange20()
            when 21
                @set_arrange21()
            when 22
                @set_arrange22()
            when 23
                @set_arrange23()
            when 24
                @set_arrange24()
            when 25
                @set_arrange25()
            when 26
                @set_arrange26()
            when 27
                @set_arrange27()
            when 28
                @set_arrange28()
            when 29
                @set_arrange29()
            when 30
                @set_arrange30()
            when 31
                @set_arrange31()
            when 32
                @set_arrange32()
            when 33
                @set_arrange33()
            when 34
                @set_arrange34()
            when 35
                @set_arrange35()
            when 36
                @set_arrange36()
            when 37
                @set_arrange37()
            when 38
                @set_arrange38()
            when 39
                @set_arrange39()
            when 40
                @set_arrange40()
            when 41
                @set_arrange41()
            when 42
                @set_arrange42()
            when 43
                @set_arrange43()
            when 44
                @set_arrange44()
            when 45
                @set_arrange45()
            when 46
                @set_arrange46()
            when 47
                @set_arrange47()
            when 48
                @set_arrange48()
            when 49
                @set_arrange49()
            when 50
                @set_arrange50()
            else
                console.log("--- Error ---")
        return
