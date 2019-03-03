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
    @getImg: (piece) ->
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

    constructor: ->
        super()
        # console.log("BoardGUI.constructor")
        @width = 0
        @height = 0
        @statusarea = null
    display: (id = null, searched = null) ->
        # console.log("BoardGUI.display")
        if id == null
            ids = ""
        else
            if searched == null
                ids = "_" + id.toString()
            else
                ids = "_" + searched.toString()
        # console.log("ids = #{ids}")
        s_motigoma = {"Hi": 0, "Ka": 0, "Ki": 0, "Gi": 0, "Ke": 0, "Ky": 0, "Fu": 0}
        for v,i in @pieces when v.turn == Const.SECOND && v.status == Const.Status.MOTIGOMA
            s_motigoma[v.kind()] += 1
        if id == null
            for k,v of s_motigoma
                $('#s' + k + ids).text(v.toString())
        else
            html = '<div id="btnSecond" class="ui-btn ui-no-icon ui-alt-icon ui-mini ui-nodisc-icon ui-btn-icon-right ui-btn-inline"><b>' + i18next.t('menu_second') + '</b></div>'
            if searched == null
                $('#group_s' + ids).append(html)
            else
                $('#search_s' + ids).append(html)
            for k,v of s_motigoma
                if v > 0
                    html = '<div class="ui-btn ui-icon-s' + k.toLowerCase() + ' ui-mini ui-nodisc-icon ui-btn-icon-left ui-btn-inline">' + v + '</div>'
                    if searched == null
                        $('#group_s' + ids).append(html)
                    else
                        $('#search_s' + ids).append(html)
        for row in [1..@rows]
            for col in [@cols..1] by -1
                $('#b' + row.toString() + col.toString()).css('background-color', '#FFFACD')
                $('#b' + row.toString() + col.toString()).css('border-style', 'solid')
                koma = (v for v in @pieces when v.posi? && v.posi.toString() == [col, row].toString())[0]
                if koma?
                    # $('#b' + koma.posi[0] + koma.posi[1] + ids).children('img').attr('src': BoardGUI.getImg(koma), 'alt': koma.caption(), 'class': (if koma.turn == Const.FIRST then 'first' else 'second'))
                    replace_src = BoardGUI.getImg(koma)
                    replace_alt = koma.caption()
                    replace_class = if koma.turn == Const.FIRST then 'first' else 'second'
                    if searched == null
                        $('#b' + koma.posi[0] + koma.posi[1] + ids).children('img').attr('src': replace_src, 'alt': replace_alt, 'class': replace_class)
                else
                    $('#b' + col + row + ids).children('img').attr('src': './img/empty.svg', 'class': 'empty')
        f_motigoma = {"Hi": 0, "Ka": 0, "Ki": 0, "Gi": 0, "Ke": 0, "Ky": 0, "Fu": 0}
        for v,i in @pieces when v.turn == Const.FIRST && v.status == Const.Status.MOTIGOMA
            f_motigoma[v.kind()] += 1
        if id == null
            for k,v of f_motigoma
                $('#f' + k + ids).text(v.toString())
        else
            html = '<div id="btnFirst" class="ui-btn ui-no-icon ui-alt-icon ui-mini ui-nodisc-icon ui-btn-icon-right ui-btn-inline"><b>' + i18next.t('menu_first') + '</b></div>'
            if searched == null
                $('#group_f' + ids).append(html)
            else
                $('#search_f' + ids).append(html)
            for k,v of f_motigoma
                if v > 0
                    html = '<div class="ui-btn ui-icon-f' + k.toLowerCase() + ' ui-mini ui-nodisc-icon ui-btn-icon-left ui-btn-inline">' + v + '</div>'
                    if searched == null
                        $('#group_f' + ids).append(html)
                    else
                        $('#search_f' + ids).append(html)
        return

    init: ->
        @statusarea = document.getElementById("spanStatus")

class State
    constructor:(@turn, @status, @posi = []) ->

class GameGUI
    # 同じ駒が複数使用されていることもあるので座標も含めてソート
    _sortCoordinate = (a, b) ->
        kinds = ["Ou", "Hi", "Ka", "Ki", "Gi", "Ke", "Ky", "Fu"]
        return kinds.indexOf(a["kind"]) - kinds.indexOf(b["kind"]) || a["posi0"] - b["posi0"] || a["posi1"] - b["posi1"]
    # 局面を比較するためHashを生成
    @make_hash = (board) ->
        rec = []
        for koma in board.pieces
            buf = {}
            buf["kind"] = koma.kind()
            buf["turn"] = koma.turn
            buf["status"] = koma.status
            buf["posi0"] = koma.posi[0]
            buf["posi1"] = koma.posi[1]
            rec.push(buf)
        rec.sort _sortCoordinate
        return crypto.createHash('md5').update(JSON.stringify(rec)).digest("hex")
    constructor: ->
        # console.log("GameGUI.constructor")
        @selected = null; @posi = null
        @s_posi = null; @d_posi = null;@pre_posi = null;
        @interrupt_flg = false;  @auto_flg = false
        @history = []; @seq = 0
        @duplication = []
        @first_player = null; @second_player = null;
        @check_guide = null;
        @radio_arrange = null;@radio_depth = null;
        @first = new Player(Const.FIRST, true, 3)
        @second = new Player(Const.SECOND, true, 3)
        @teban = @first
        @label_idx = 0
        @searchList = []; @searchResult = []
        @board = new BoardGUI(); @bkup = new BoardGUI()
        @md5hash = null
        special_event = if typeof(cordova)=="undefined" then "DOMContentLoaded" else "deviceready"
        @setEventListener(special_event)
        @originalBoardImage = ""
    viewState: ->
        # console.log("viewState")
        for v,i in @board.pieces
            # console.log("class = #{v.constructor.name}")
            v.turn = @history[@seq]["board"][i].turn
            v.status = @history[@seq]["board"][i].status
            v.posi = @history[@seq]["board"][i].posi
        $('#naviSeq').text(@seq.toString())
        @board.display()
        $('#b' + @history[@seq]["latest"][0].toString() + @history[@seq]["latest"][1].toString()).css('border-style', 'dashed') if @seq > 0
        return

    addState: (md5hash = null, latest = null, from = null, to = null, koma = null) ->
        # console.log("GameGUI.addState")
        record = {}
        record["latest"] = if latest? then [].concat(latest) else null
        record["from"] = if from? then [].concat(from) else null
        record["to"] = if to? then [].concat(to) else null
        record["koma"] = if koma? then koma else null
        record["board"] = []
        for v in @board.pieces
            record["board"].push(new State(v.turn, v.status, [].concat(v.posi)))
        @history.push(record)
        @duplication.push(md5hash)
        $('#naviSeq').text((@history.length - 1).toString())

    makeRecord: ->
        # console.log("GameGUI.makeRecord")
        # console.log(@history)
        converted = @convert()
        linkStr = "https://play.google.com/store/apps/details?id=shogi33.io.github.happyclam"
        # window.plugins.socialsharing.share('\' #３三将棋 ' + linkStr + ' \n' + converted, 'shogi33', null, null);

        output = window.open('', '３三将棋')
        output.document.open()
        output.document.write '<HTML><HEAD>'
        output.document.write '<TITLE>３三将棋</TITLE>'
        output.document.writeln '<BODY>'
        output.document.write '\' #３三将棋 ' + linkStr + ' <br /><pre>'
        output.document.write converted
        output.document.write '</pre></BODY></HTML>'
        output.document.close()
        return

    convert: ->
        # console.log("GameGUI.convert")
        return "" if @history.length <= 0
        if @history[0]["latest"]?
            radioNo = @history[0]["latest"][0]
            records = "'No. #{radioNo.toString()}\n"
        else
            radioNo = -1
            records = "'\n"
        records += "'\n"
        records += "V2.2\n"
        if @first.human
            records += "N+Player\n"
        else
            records += "N+AI\n"
        if @second.human
            records += "N-Player\n"
        else
            records += "N-AI\n"
        if radioNo == -1
            records += @originalBoardImage
        else
            records += initialBoardImage.call @, radioNo
        if @teban.turn == Const.SECOND
            records += "-\n"
        else
            records += "+\n"
        for v,i in @history
            continue if i == 0
            teban = if (i % 2) == 1 then "+" else "-"
            from = if v.from.length!=0 then v.from.toString().replace(",", "") else "00"
            to = if v.to.length!=0 then v.to.toString().replace(",", "") else ""
            records += teban + from + to + v.koma + "\n"
        return records

    inputRecord: ->
        # console.log("GameGUI.inputRecord")
        @board.pieces = []
        @history = []
        @duplication = []
        @seq = 0
        @originalBoardImage = ""
        try
            buf = $('#textKifu').val().split(/\r\n|\r|\n/)
            # console.log("buf = #{buf}")
            # console.log(buf)
            # console.log(buf.length)
            for v,i in buf
                # console.log(v)
                continue if v.length == 0
                continue if v[0] == "\'"
                continue if v[0] == "V"
                continue if v[0] == "T"
                continue if v[0] == "%"
                continue if v[0] == "N"
                continue if v[0] == "$"
                switch v[0]
                    when "P"
                        # throw "1:Line = #{i + 1}: #{v}" unless isFinite(v[1])
                        @originalBoardImage += v + "\n"
                        if isFinite(v[1])
                            row = parseInt(v[1], 10)
                            cols = v.slice(2)
                            throw "01:Line = #{i + 1}: #{v}" unless (cols.length == Const.KIFU_ROW_LENGTH || cols.length == Const.KIFU_ROW_LENGTH_SUB)
                            for j in [1..@board.cols]
                                y = Const.KIFU_ROW_LENGTH - (Const.KIFU_KOMA_LENGTH * j)
                                col = cols[y..y+2]
                                continue if col.indexOf("*") >= 0
                                piece = makePiece.call @, col, [j, row]
                                if piece?
                                    @board.pieces.push(piece)
                                else
                                    throw "02:Line = #{i + 1}: #{v}"
                        else if (v[1] == "+" || v[1] == "-")
                            cols = v.split("00")
                            # console.log(cols)
                            for j,k in cols
                                continue if k == 0
                                piece = makePiece.call @, v[1] + j
                                if piece?
                                    @board.pieces.push(piece)
                                else
                                    throw "03:Line = #{i + 1}: #{v}"
                        else
                            throw "04:Line = #{i + 1}: #{v}"
                        throw "09:Line = #{i}: #{v}" if @history.length > 0
                    when "+", "-"
                        # console.log(@board.pieces)
                        if v.length == 1
                            @addState()
                            continue
                        from = [v[1], v[2]].map(Number)
                        turn = if v[0] == "+" then Const.FIRST else Const.SECOND
                        # console.log("v = #{v}")
                        if v[1..2] == "00"
                            koma = (w for w in @board.pieces when w.posi.length == 0 && w.turn == turn && w.koma() == v[5..6])
                        else
                            koma = (w for w in @board.pieces when w.posi? && w.turn == turn && w.posi[0] == from[0] && w.posi[1] == from[1])
                        throw "05:Line = #{i + 1}: #{v}" if koma.length == 0
                        to = [v[3], v[4]].map(Number)
                        # console.log(koma[0])
                        # console.log(from)
                        # console.log(to)
                        throw "08:Line = #{i + 1}: #{v}" unless checkKind.call @, v[5..6]
                        if @board.check_move(koma[0], to)
                            from = @board.move_capture(koma[0], to)
                            # 駒の種類が変わっていたら成ったと見做す
                            koma[0].status = Const.Status.URA if koma[0].koma() != v[5..6]
                        else
                            throw "06:Line = #{i + 1}: #{v}"
                        @md5hash = GameGUI.make_hash(@board)
                        @seq += 1
                        @addState(@md5hash, to, from, to, koma[0].koma())
                    else
                        throw "07:Line= #{i + 1}: #{v}"
        catch err
            console.log("Error: #{err}")
            @kifustatus.innerHTML = "Error: #{err}"
        finally
            if err?
                return false
            else
                # console.log(@history)
                # console.log(@seq)
                @kifustatus.innerHTML = ""
                return true

    # ゲーム開始毎
    prepare: ->
        # console.log("GameGUI.prepare")
        @interrupt_flg = false; @auto_flg = false
        @history = []
        @duplication = []
        @seq = 0
        $('#naviSeq').text('')
        @startbtn.disabled = true; $("#btnStop").val(i18next.t('msgInterrupt')).button("refresh")
        @naviA.style.display = "none"
        @board.statusarea.innerHTML = i18next.t('msgTurn', {postProcess: 'sprintf', sprintf: [i18next.t('msgBlack')]})
        @teban = @first
        radio_checked = (v for v in @radio_arrange when v.checked == true)[0]
        $('#patternNo').text(radio_checked.value)
        radioNo = parseInt(radio_checked.value|0, 10)
        launch.call @, radioNo
        # 初期配置No.を@history[0]に保存することにした
        # 棋譜出力の際に実際の棋譜とラジオボタンの選択が相違していることがあるため
        @addState(null, radioNo)
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
        temp = []; ret = []
        for i in [1,2,player.depth].unique()
            temp = []
            temp = player.think(@board, oppo, i, threshold)
            if @interrupt_flg
                # @interrupt_flg = false
                @auto_flg = false
                @board.statusarea.innerHTML = ""
                return
            if temp[0]?
                ret = [].concat(temp)
                break if (temp[2] >= Const.MAX_VALUE || temp[2] <= Const.MIN_VALUE)
            else
                break
        if ret[0]
            # 一手前のハッシュ値ですでに千日手判定されていればreturn
            chk_sennitite =  @sennitite(@md5hash)
            if chk_sennitite
                @board.display(); $('#b' + ret[1][0] + ret[1][1]).css('border-style', 'dashed')
                @auto_flg = false
                return
            # else if chk_sennitite == null && ret[4]["koma"]?
            #     ret[0] = ret[4]["koma"]
            #     ret[1] = ret[4]["posi"]
            #     ret[2] = ret[4]["score"]
            #     ret[3] = ret[4]["status"]
            if @board.check_move(ret[0], ret[1])
                src_posi = @board.move_capture(ret[0], ret[1])
                ret[0].status = ret[3]
            @md5hash = GameGUI.make_hash(@board)
            @seq += 1
            @addState(@md5hash, ret[1], src_posi, ret[1], ret[0].koma())
            if @sennitite(@md5hash)
                @board.display(); $('#b' + ret[1][0] + ret[1][1]).css('border-style', 'dashed')
                @auto_flg = false
                return
            @teban = if (@seq % 2) == 0 then @first else @second
            if @teban.turn == Const.FIRST
                @board.statusarea.innerHTML = i18next.t('msgTurn', {postProcess: 'sprintf', sprintf: [i18next.t('msgBlack')]})
            else
                @board.statusarea.innerHTML = i18next.t('msgTurn', {postProcess: 'sprintf', sprintf: [i18next.t('msgWhite')]})
            @board.statusarea.innerHTML = @board.statusarea.innerHTML + i18next.t('msgEvaluate', {postProcess: 'sprintf', sprintf: [ret[2].toString()]})
        else
            if @teban.turn == Const.FIRST
                @board.statusarea.innerHTML = i18next.t('msgWinner', {postProcess: 'sprintf', sprintf: [i18next.t('msgWhite')]})
            else
                @board.statusarea.innerHTML = i18next.t('msgWinner', {postProcess: 'sprintf', sprintf: [i18next.t('msgBlack')]})
            # @board.display()
            @startbtn.disabled = false; $("#btnStop").val(i18next.t('msgRestart')).button("refresh")
            @naviA.style.display = "block"
            @auto_flg = false
            return
        @board.display(); $('#b' + ret[1][0] + ret[1][1]).css('border-style', 'dashed')
        if @interrupt_flg
            # @interrupt_flg = false
            @auto_flg = false
            @board.statusarea.innerHTML = ""
            return
        else
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
        @kifustatus = document.getElementById("kifuStatus")
        @naviA = document.getElementById("naviA")
        @naviA.style.display = "none"
        @boardList()
        try
            @first_player.selectedIndex = parseInt(localStorage.getItem("first_player")|0, 10)
            @second_player.selectedIndex = parseInt(localStorage.getItem("second_player")|0, 10)
            temp = JSON.parse(localStorage.getItem("movement_guide33"))
            if temp == true
                @check_guide = true
            else
                @check_guide = false

            idx = parseInt(localStorage.getItem("radio-arrange")|0, 10)
            @radio_arrange[idx].checked = true
            radio_checked = (v for v in @radio_arrange when v.checked == true)[0]
            $('#patternNo').text(radio_checked.value)
            depth = parseInt(localStorage.getItem("radio-depth")|0, 10)
            if depth == 3
                @radio_depth[3].checked = true
                @first.depth = 4; @second.depth = 4
            else if depth == 2
                @radio_depth[2].checked = true
                @first.depth = 4; @second.depth = 4
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

        $('#btnRecord1').on 'click', (e) =>
            @makeRecord()
            return
        $('#btnRecord2').on 'click', (e) =>
            @makeRecord()
            return
        $('#btnKifu').on 'click', (e) =>
            # console.log("btnKifu onClick")
            if @inputRecord()
                $('#naviSeq').text('')
                @interrupt_flg = true
                $("#btnStop").val(i18next.t('msgRestart')).button("refresh")
                @startbtn.disabled = false
                @naviA.style.display = "block"
                @board.statusarea.innerHTML = ""
                location.href = "#home"
                @viewState()
            return
        $('#btnStart').on 'click', (e) =>
            target = $(e.currentTarget)
            @prepare()
            @first.human = if @first_player.selectedIndex == 1 then false else true
            @second.human = if @second_player.selectedIndex == 1 then false else true
            if !@first.human && !@second.human
                @board.statusarea.innerHTML = i18next.t('msgThinking')
                @board.display()
                setTimeout (=>
                    @auto_battle(@seq)
                    ), 1000
            else if not @first.human
                @board.statusarea.innerHTML = i18next.t('msgThinking')
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
            # console.log("radio-arrange.change")
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
                    @first.depth = 4; @second.depth = 4
                else if @radio_depth[2].checked
                    localStorage.setItem("radio-depth", 2)
                    @first.depth = 4; @second.depth = 4
                else if @radio_depth[1].checked
                    localStorage.setItem("radio-depth", 1)
                    @first.depth = 4; @second.depth = 4
                else
                    localStorage.setItem("radio-depth", 0)
                    @first.depth = 3; @second.depth = 3
            catch err
                console.log(err)
        $('#check-guide').on 'change', (e) =>
            try
                @check_guide = e.currentTarget.checked
                localStorage.setItem("movement_guide33", @check_guide)
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
        $('#btnSearch').on 'click', (e) =>
            # console.log("btnSearch.click")
            # console.log("before pieces = #{JSON.stringify(@board.pieces)}")
            @bkup.pieces = []
            for koma in @board.pieces
                @bkup.pieces.push(eval("new Piece." + koma.kind() + "(" + koma.turn + "," + koma.status + ",[" + koma.posi.toString() + "])"))
            @listUp()
            # console.log("after pieces = #{JSON.stringify(@board.pieces)}")

    boardList: ->
        @searchList = []
        @set_standard()
        @searchList.push((v.kind() for v in @board.pieces).unique())
        @board.display(0, null)
        for i in [1..140]
            launch.call @, i
            @searchList.push((v.kind() for v in @board.pieces).unique())
            @board.display(i, null)

    listUp: ->
        # console.log("listUp")
        @searchResult = []
        checked = []
        checked.push($("#check-hi").val()) if $("#check-hi").prop("checked")
        checked.push($("#check-ka").val()) if $("#check-ka").prop("checked")
        checked.push($("#check-ki").val()) if $("#check-ki").prop("checked")
        checked.push($("#check-gi").val()) if $("#check-gi").prop("checked")
        checked.push($("#check-ke").val()) if $("#check-ke").prop("checked")
        checked.push($("#check-ky").val()) if $("#check-ky").prop("checked")
        checked.push($("#check-fu").val()) if $("#check-fu").prop("checked")
        for v,i in @searchList
            if (w for w in checked when w in v).length == checked.length
                @searchResult.push(i)
        document.getElementById("spanSearch").innerHTML = ""
        mydiv = document.getElementById("searchImage")
        while mydiv.firstChild
            mydiv.removeChild mydiv.firstChild
        e = document.createElement("div")
        e.setAttribute "class", "ui-controlgroup-controls"
        idx = 0
        while idx < @searchResult.length
            launch.call @, @searchResult[idx]
            r = [[null,null,null],[null,null,null],[null,null,null]]
            for row in [1..@board.rows]
                for col in [@board.cols..1] by -1
                    koma = (v for v in @board.pieces when v.posi? && v.posi.toString() == [col, row].toString())[0]
                    if koma?
                        r[col - 1][row - 1] = {src: BoardGUI.getImg(koma), alt: koma.caption(), cls: (if koma.turn == Const.FIRST then 'first' else 'second')}
                    else
                        r[col - 1][row - 1] = {src: "./img/empty.svg", alt: "", cls: "empty"}
            e2 = document.createElement("div")
            e2.setAttribute "class", "ui-radio ui-mini"
            input = document.createElement('input')
            input.setAttribute "type", "radio"
            input.setAttribute "id", "radioSearch" + @searchResult[idx].toString()
            input.setAttribute "name", "radioSearch"
            input.setAttribute "value", @searchResult[idx]
            input.setAttribute "checked", true if @searchResult[idx].toString() == @label_idx
            # input.setAttribute "checked", true if idx == 0
            input.onclick = =>
                patternNo = $('input[name=\'radioSearch\']:checked').val()
                $('#radio-arrange' + patternNo).prop 'checked', true
                $('input[name="radio-arrange"]').checkboxradio('refresh');
                $('input[name=\'radio-arrange\'][value=\'' + patternNo + '\']').prop('checked', true).trigger 'change'

            label = document.createElement('label')
            label.setAttribute "class", "ui-btn ui-corner-all ui-btn-inherit ui-btn-icon-left ui-first-child ui-radio-on"
            label.htmlFor = 'radioSearch' + @searchResult[idx].toString()
            if @searchResult[idx] == 0
                title = 'Standard:'
            else
                title = 'Arrange' + @searchResult[idx].toString() + ':'
            label.innerHTML = title + '    <div class="ui-grid-solo-second">' + '      <div class="ui-block-a">' + '\u0009     <div id="search_s_' + @searchResult[idx].toString() + '" data-role="controlgroup" data-type="horizontal">' + '        </div>' + '      </div>' + '    </div>' + '    <div id="mainboard" class="ui-grid-d-board">' + '      <div class="ui-block-a"></div>' + '      <div class="ui-block-b">３</div>' + '      <div class="ui-block-c">２</div>' + '      <div class="ui-block-d">１</div>' + '      <div class="ui-block-e"></div>' + '      <div class="ui-block-a">' + '      </div>' + '      <div class="ui-block-b"><div id="b31_' + @searchResult[idx].toString() + '" data-col="3" data-row="1" class="ui-bar-board"><img class="' + r[2][0]["cls"] + '" src="' + r[2][0]["src"] + '" alt="' + r[2][0]["alt"] + '"></div></div>' + '      <div class="ui-block-c"><div id="b21_' + @searchResult[idx].toString() + '" data-col="2" data-row="1" class="ui-bar-board"><img class="' + r[1][0]["cls"] + '" src="' + r[1][0]["src"] + '" alt="' + r[1][0]["alt"] + '"></div></div>' + '      <div class="ui-block-d"><div id="b11_' + @searchResult[idx].toString() + '" data-col="1" data-row="1" class="ui-bar-board"><img class="' + r[0][0]["cls"] + '" src="' + r[0][0]["src"] + '" alt="' + r[0][0]["alt"] + '"></div></div>' + '      <div class="ui-block-e">一</div>' + '      <div class="ui-block-a">' + '      </div>' + '      <div class="ui-block-b"><div id="b32_' + @searchResult[idx].toString() + '" data-col="3" data-row="2" class="ui-bar-board"><img class="' + r[2][1]["cls"] + '" src="' + r[2][1]["src"] + '" alt="' + r[2][1]["alt"] + '"></div></div>' + '      <div class="ui-block-c"><div id="b22_' + @searchResult[idx].toString() + '" data-col="2" data-row="2" class="ui-bar-board"><img class="' + r[1][1]["cls"] + '" src="' + r[1][1]["src"] + '" alt="' + r[1][1]["alt"] + '"></div></div>' + '      <div class="ui-block-d"><div id="b12_' + @searchResult[idx].toString() + '" data-col="1" data-row="2" class="ui-bar-board"><img class="' + r[0][1]["cls"] + '" src="' + r[0][1]["src"] + '" alt="' + r[0][1]["alt"] + '"></div></div>' + '      <div class="ui-block-e">二</div>' + '      <div class="ui-block-a"></div>' + '      <div class="ui-block-b"><div id="b33_' + @searchResult[idx].toString() + '" data-col="3" data-row="3" class="ui-bar-board"><img class="' + r[2][2]["cls"] + '" src="' + r[2][2]["src"] + '" alt="' + r[2][2]["alt"] + '"></div></div>' + '      <div class="ui-block-c"><div id="b23_' + @searchResult[idx].toString() + '" data-col="2" data-row="3" class="ui-bar-board"><img class="' + r[1][2]["cls"] + '" src="' + r[1][2]["src"] + '" alt="' + r[1][2]["alt"] + '"></div></div>' + '      <div class="ui-block-d"><div id="b13_' + @searchResult[idx].toString() + '" data-col="1" data-row="3" class="ui-bar-board"><img class="' + r[0][2]["cls"] + '" src="' + r[0][2]["src"] + '" alt="' + r[0][2]["alt"] + '"></div></div>' + '      <div class="ui-block-e">三</div>' + '    </div>' + '    <div class="ui-grid-solo-first">' + '      <div class="ui-block-a">' + '        <div id="search_f_' + @searchResult[idx].toString() + '" data-role="controlgroup" data-type="horizontal">' + '        </div>' + '      </div>' + '    </div>'
            label.appendChild(input)
            e2.appendChild(label)
            e.appendChild(e2)
            idx++

        document.getElementById("searchImage").appendChild(e)

        setTimeout (=>
            event = new ($.Event)('after_search')
            $(document).trigger event
        ),500
        return

    interrupted: ->
        # console.log("Game.interrupted")
        return unless @seq?
        if @startbtn.disabled
            @interrupt_flg = true
            $("#btnStop").val(i18next.t('msgRestart')).button("refresh")
            @startbtn.disabled = false
            @naviA.style.display = "block"
            @board.statusarea.innerHTML = ""
        else
            @interrupt_flg = false
            $("#btnStop").val(i18next.t('msgInterrupt')).button("refresh")
            @startbtn.disabled = true
            @naviA.style.display = "none"
            if (@seq % 2) == 0
                @board.statusarea.innerHTML = i18next.t('msgTurn', {postProcess: 'sprintf', sprintf: [i18next.t('msgBlack')]})
            else
                @board.statusarea.innerHTML = i18next.t('msgTurn', {postProcess: 'sprintf', sprintf: [i18next.t('msgWhite')]})
            @teban = if (@seq % 2) == 0 then @first else @second
            @first_player.selectedIndex = parseInt(localStorage.getItem("first_player")|0, 10)
            @second_player.selectedIndex = parseInt(localStorage.getItem("second_player")|0, 10)
            @first.human = if first_player.selectedIndex == 1 then false else true
            @second.human = if second_player.selectedIndex == 1 then false else true
            @history.splice(@seq + 1); @duplication.splice(@seq + 1)
            if !@first.human && !@second.human
                @board.statusarea.innerHTML = i18next.t('msgThinking')
                setTimeout (=>
                    @auto_battle(@seq)
                    ), 1000
            else if not @teban.human
                @board.statusarea.innerHTML = i18next.t('msgThinking')
                setTimeout (=>
                    event = new ($.Event)('ai_thinking')
                    $(window).trigger event
                    ),500
            else
                return if @sennitite(GameGUI.make_hash(@board))
                ret = []
                oppo = if (@teban.turn == Const.FIRST) then @second else @first
                threshold = if (@teban.turn == Const.FIRST) then Const.MAX_VALUE else Const.MIN_VALUE
                ret = @teban.think(@board, oppo, 1, threshold)
                unless ret[0]
                    switch ret[2]
                        when Const.MAX_VALUE
                            @board.statusarea.innerHTML = i18next.t('msgFirstWin')
                            @startbtn.disabled = false; $("#btnStop").val(i18next.t('msgRestart')).button("refresh")
                            @naviA.style.display = "block"
                        when Const.MIN_VALUE
                            @board.statusarea.innerHTML = i18next.t('msgSecondWin')
                            @startbtn.disabled = false; $("#btnStop").val(i18next.t('msgRestart')).button("refresh")
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
            @board.statusarea.innerHTML = i18next.t('msgSennitite')
            @startbtn.disabled = false; $("#btnStop").val(i18next.t('msgRestart')).button("refresh")
            @naviA.style.display = "block"
            return true
        else
            return false

    routine: (piece, posi, nari) ->
        # console.log("routine")
        src_posi = @board.move_capture(piece, posi)
        piece.status = Const.Status.URA if nari
        @md5hash = GameGUI.make_hash(@board)
        @seq += 1
        @addState(@md5hash, posi, src_posi, posi, piece.koma())
        if @sennitite(@md5hash)
            @board.display(); $('#b' + posi[0] + posi[1]).css('border-style', 'dashed')
            return
        @teban = if (@seq % 2) == 0 then @first else @second
        threshold = if @teban.turn == Const.FIRST then Const.MAX_VALUE else Const.MIN_VALUE
        switch @board.gameover()
            when Const.FIRST
                @board.statusarea.innerHTML = i18next.t('msgFirstWin')
                @startbtn.disabled = false; $("#btnStop").val(i18next.t('msgRestart')).button("refresh")
                @naviA.style.display = "block"
                @board.display(); $('#b' + posi[0] + posi[1]).css('border-style', 'dashed')
                return
            when Const.SECOND
                @board.statusarea.innerHTML = i18next.t('msgSecondWin')
                @startbtn.disabled = false; $("#btnStop").val(i18next.t('msgRestart')).button("refresh")
                @naviA.style.display = "block"
                @board.display(); $('#b' + posi[0] + posi[1]).css('border-style', 'dashed')
                return
            else
                if @teban.turn == Const.FIRST
                    @board.statusarea.innerHTML = i18next.t('msgTurn', {postProcess: 'sprintf', sprintf: [i18next.t('msgBlack')]})
                else
                    @board.statusarea.innerHTML = i18next.t('msgTurn', {postProcess: 'sprintf', sprintf: [i18next.t('msgWhite')]})
        @s_posi = null; @d_posi = null
        @board.display(); $('#b' + posi[0] + posi[1]).css('border-style', 'dashed')
        if @teban.human
            oppo = if @teban.turn == Const.FIRST then @second else @first
            ret = []
            # 詰みチェック
            ret = @teban.think(@board, oppo, 1, threshold)
            unless ret[0]
                if @teban.turn == Const.FIRST
                    @board.statusarea.innerHTML = i18next.t('msgWinner', {postProcess: 'sprintf', sprintf: [i18next.t('msgWhite')]})
                else
                    @board.statusarea.innerHTML = i18next.t('msgWinner', {postProcess: 'sprintf', sprintf: [i18next.t('msgBlack')]})
                @startbtn.disabled = false; $("#btnStop").val(i18next.t('msgRestart')).button("refresh")
                @naviA.style.display = "block"
                return
        else
            @board.statusarea.innerHTML = i18next.t('msgThinking')
            setTimeout (=>
                event = new ($.Event)('ai_thinking')
                $(window).trigger event
                ),500

    touch: (piece, posi) ->
        # console.log("touch")
        return unless @startbtn.disabled
        return if @auto_flg
        unless piece?
            @s_posi = null
            return
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
        if @selected?
            @s_posi = not null
        return

    select: (posi) ->
        # console.log("select")
        $('#b' + posi[0] + posi[1]).css('background-color', '#FFFACD')
        if !@s_posi
            @s_posi = posi
            @selected = (v for v in @board.pieces when v.posi? && v.posi.toString() == posi.toString() && v.turn == @teban.turn)[0]
            if @selected?
                $('#b' + posi[0] + posi[1]).css('background-color', '#E3D7A6')
                @pre_posi = posi
                # @guide(@selected) if @check_guide
            else
                @s_posi = null
        else
            @d_posi = posi
            if @pre_posi
                $('#b' + @pre_posi[0] + @pre_posi[1]).css('background-color', '#FFFACD')
                # for c in [1..@board.cols]
                #     for r in [1..@board.rows]
                #         unless ((r == posi[1]) && (c == posi[0]))
                #             $('#b' + c.toString() + r.toString()).css('background-color', '#FFFACD')
            @touch(@selected, @d_posi)
        return

    guide: (piece) ->
        # console.log("GameGUI.guide")
        for v in eval("Piece." + piece.kind()).getD(piece.turn, piece.status)
            buf = [].concat(piece.posi)
            buf[0] += v.xd; buf[1] += v.yd
            if v.series
                while (buf[0] in [1..@board.cols]) && (buf[1] in [1..@board.rows])
                    dest = (w for w in @board.pieces when w.posi? && w.posi[0] == buf[0] && w.posi[1] == buf[1])
                    if dest.length != 0
                        if (piece.turn != dest[0].turn)
                            $('#b' + buf[0].toString() + buf[1].toString()).css('background-color', '#E6E6E6')
                            # $('#b' + buf[0].toString() + buf[1].toString()).css('border-style', 'dotted')
                        break
                    else
                        $('#b' + buf[0].toString() + buf[1].toString()).css('background-color', '#E6E6E6')
                        # $('#b' + buf[0].toString() + buf[1].toString()).css('border-style', 'dotted')
                    buf[0] += v.xd; buf[1] += v.yd
            else
                dest = (w for w in @board.pieces when w.posi? && w.posi[0] == buf[0] && w.posi[1] == buf[1])
                if dest.length != 0
                    if (piece.turn != dest[0].turn)
                        $('#b' + buf[0].toString() + buf[1].toString()).css('background-color', '#E6E6E6')
                        # $('#b' + buf[0].toString() + buf[1].toString()).css('border-style', 'dotted')
                else
                    if (buf[0] in [1..@board.cols]) && (buf[1] in [1..@board.rows])
                        $('#b' + buf[0].toString() + buf[1].toString()).css('background-color', '#E6E6E6')
                        # $('#b' + buf[0].toString() + buf[1].toString()).css('border-style', 'dotted')
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
        return
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
        return
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
        return
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
        return
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
        return
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
        return
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
        return
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
        return
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
        return
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
        return
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
        return
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
        return
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
        return
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
        return
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
        return
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
        return
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
        return
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
        return
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
        return
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
        return
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
        return
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
        return
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
        return
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
        return
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
        return
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
        return
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
        return
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
        return
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
        return
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
        return
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
        return
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
        return
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
        return
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
        return
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
        return
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
        return
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
        return
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
        return
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
        return
    set_arrange39: ->
        @board.pieces = []
        @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,2]))
        @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,2]))
        @board.pieces.push(new Piece.Ka(Const.FIRST, Const.Status.MOTIGOMA))
        @board.pieces.push(new Piece.Hi(Const.SECOND, Const.Status.MOTIGOMA))
        @board.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.MOTIGOMA))
        return
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
        return
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
        return
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
        return
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
        return
    set_arrange44: ->
        @board.pieces = []
        @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
        @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
        @board.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.OMOTE, [3,3]))
        @board.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.OMOTE, [1,1]))
        @board.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.OMOTE, [2,3]))
        @board.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.OMOTE, [2,1]))
        return
    set_arrange45: ->
        @board.pieces = []
        @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
        @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
        @board.pieces.push(new Piece.Gi(Const.FIRST, Const.Status.MOTIGOMA))
        @board.pieces.push(new Piece.Gi(Const.SECOND, Const.Status.MOTIGOMA))
        @board.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.MOTIGOMA))
        @board.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA))
        return
    set_arrange46: ->
        @board.pieces = []
        @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [2,1]))
        @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [2,3]))
        @board.pieces.push(new Piece.Ka(Const.FIRST, Const.Status.MOTIGOMA))
        @board.pieces.push(new Piece.Ka(Const.SECOND, Const.Status.MOTIGOMA))
        @board.pieces.push(new Piece.Gi(Const.FIRST, Const.Status.OMOTE, [3,1]))
        @board.pieces.push(new Piece.Gi(Const.SECOND, Const.Status.OMOTE, [1,3]))
        return
    set_arrange47: ->
        @board.pieces = []
        @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [2,1]))
        @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [2,3]))
        @board.pieces.push(new Piece.Ka(Const.FIRST, Const.Status.MOTIGOMA))
        @board.pieces.push(new Piece.Ka(Const.SECOND, Const.Status.MOTIGOMA))
        @board.pieces.push(new Piece.Ky(Const.FIRST, Const.Status.OMOTE, [1,3]))
        @board.pieces.push(new Piece.Ky(Const.SECOND, Const.Status.OMOTE, [3,1]))
        return
    set_arrange48: ->
        @board.pieces = []
        @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
        @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
        @board.pieces.push(new Piece.Ky(Const.FIRST, Const.Status.MOTIGOMA))
        @board.pieces.push(new Piece.Ky(Const.SECOND, Const.Status.MOTIGOMA))
        @board.pieces.push(new Piece.Gi(Const.FIRST, Const.Status.OMOTE, [3,3]))
        @board.pieces.push(new Piece.Gi(Const.SECOND, Const.Status.OMOTE, [1,1]))
        return
    set_arrange49: ->
        @board.pieces = []
        @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
        @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
        @board.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.OMOTE, [2,3]))
        @board.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.OMOTE, [2,1]))
        @board.pieces.push(new Piece.Gi(Const.FIRST, Const.Status.OMOTE, [1,2]))
        @board.pieces.push(new Piece.Gi(Const.SECOND, Const.Status.OMOTE, [3,2]))
        return
    set_arrange50: ->
        @board.pieces = []
        @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [1,2]))
        @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [3,2]))
        @board.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.OMOTE, [3,3]))
        @board.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.OMOTE, [1,1]))
        @board.pieces.push(new Piece.Ky(Const.FIRST, Const.Status.MOTIGOMA))
        @board.pieces.push(new Piece.Ky(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange51: ->
        @board.pieces = []
        @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [2,3]))
        @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [2,1]))
        @board.pieces.push(new Piece.Ka(Const.FIRST, Const.Status.MOTIGOMA))
        @board.pieces.push(new Piece.Ka(Const.SECOND, Const.Status.MOTIGOMA))
        @board.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.OMOTE, [3,3]))
        @board.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.OMOTE, [1,1]))
        return
    set_arrange52: ->
        @board.pieces = []
        @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
        @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
        @board.pieces.push(new Piece.Ka(Const.FIRST, Const.Status.OMOTE, [2,3]))
        @board.pieces.push(new Piece.Ka(Const.SECOND, Const.Status.OMOTE, [2,1]))
        @board.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.MOTIGOMA))
        @board.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange53: ->
        @board.pieces = []
        @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,2]))
        @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,2]))
        @board.pieces.push(new Piece.Hi(Const.FIRST, Const.Status.OMOTE, [3,3]))
        @board.pieces.push(new Piece.Hi(Const.SECOND, Const.Status.OMOTE, [1,1]))
        @board.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.OMOTE, [2,3]))
        @board.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.OMOTE, [2,1]))
        return
    set_arrange54: ->
        @board.pieces = []
        @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [1,2]))
        @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [3,2]))
        @board.pieces.push(new Piece.Gi(Const.FIRST, Const.Status.OMOTE, [1,3]))
        @board.pieces.push(new Piece.Gi(Const.SECOND, Const.Status.OMOTE, [3,1]))
        @board.pieces.push(new Piece.Hi(Const.FIRST, Const.Status.MOTIGOMA))
        @board.pieces.push(new Piece.Hi(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange55: ->
        @board.pieces = []
        @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
        @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
        @board.pieces.push(new Piece.Ky(Const.FIRST, Const.Status.OMOTE, [3,3]))
        @board.pieces.push(new Piece.Ky(Const.SECOND, Const.Status.OMOTE, [1,1]))
        @board.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.MOTIGOMA))
        @board.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange56: ->
        @board.pieces = []
        @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
        @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
        @board.pieces.push(new Piece.Ka(Const.FIRST, Const.Status.OMOTE, [2,3]))
        @board.pieces.push(new Piece.Ka(Const.SECOND, Const.Status.OMOTE, [2,1]))
        @board.pieces.push(new Piece.Gi(Const.FIRST, Const.Status.OMOTE, [1,2]))
        @board.pieces.push(new Piece.Gi(Const.SECOND, Const.Status.OMOTE, [3,2]))
        return
    set_arrange57: ->
        @board.pieces = []
        @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [1,3]))
        @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [3,1]))
        @board.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.OMOTE, [2,3]))
        @board.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.OMOTE, [2,1]))
        @board.pieces.push(new Piece.Hi(Const.FIRST, Const.Status.URA, [1,1]))
        @board.pieces.push(new Piece.Hi(Const.SECOND, Const.Status.URA, [3,3]))
        return
    set_arrange58: ->
        @board.pieces = []
        @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [2,3]))
        @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [2,1]))
        @board.pieces.push(new Piece.Ky(Const.FIRST, Const.Status.OMOTE, [3,3]))
        @board.pieces.push(new Piece.Ky(Const.SECOND, Const.Status.OMOTE, [1,1]))
        @board.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA))
        @board.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange59: ->
        @board.pieces = []
        @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [1,2]))
        @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [3,2]))
        @board.pieces.push(new Piece.Gi(Const.FIRST, Const.Status.OMOTE, [3,1]))
        @board.pieces.push(new Piece.Gi(Const.SECOND, Const.Status.OMOTE, [1,3]))
        @board.pieces.push(new Piece.Ky(Const.FIRST, Const.Status.MOTIGOMA))
        @board.pieces.push(new Piece.Ky(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange60: ->
        @board.pieces = []
        @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
        @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
        @board.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.OMOTE, [3,2]))
        @board.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.OMOTE, [1,2]))
        @board.pieces.push(new Piece.Ky(Const.FIRST, Const.Status.MOTIGOMA))
        @board.pieces.push(new Piece.Ky(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange61: ->
        @board.pieces = []
        @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,3]))
        @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,1]))
        @board.pieces.push(new Piece.Ky(Const.FIRST, Const.Status.MOTIGOMA))
        @board.pieces.push(new Piece.Ky(Const.SECOND, Const.Status.MOTIGOMA))
        @board.pieces.push(new Piece.Ka(Const.FIRST, Const.Status.OMOTE, [1,2]))
        @board.pieces.push(new Piece.Ka(Const.SECOND, Const.Status.OMOTE, [3,2]))
        return
    set_arrange62: ->
        @board.pieces = []
        @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
        @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
        @board.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.OMOTE, [2,3]))
        @board.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.OMOTE, [2,1]))
        @board.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.MOTIGOMA))
        @board.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange63: ->
        @board.pieces = []
        @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
        @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
        @board.pieces.push(new Piece.Gi(Const.FIRST, Const.Status.OMOTE, [3,2]))
        @board.pieces.push(new Piece.Gi(Const.SECOND, Const.Status.OMOTE, [1,2]))
        @board.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.OMOTE, [2,3]))
        @board.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.OMOTE, [2,1]))
        return
    set_arrange64: ->
        @board.pieces = []
        @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,3]))
        @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,1]))
        @board.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.OMOTE, [2,3]))
        @board.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.OMOTE, [2,1]))
        @board.pieces.push(new Piece.Gi(Const.FIRST, Const.Status.MOTIGOMA))
        @board.pieces.push(new Piece.Gi(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange65: ->
        @board.pieces = []
        @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,3]))
        @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,1]))
        @board.pieces.push(new Piece.Ky(Const.FIRST, Const.Status.OMOTE, [2,3]))
        @board.pieces.push(new Piece.Ky(Const.SECOND, Const.Status.OMOTE, [2,1]))
        @board.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.MOTIGOMA))
        @board.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange66: ->
        @board.pieces = []
        @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
        @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
        @board.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.OMOTE, [2,3]))
        @board.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.OMOTE, [2,1]))
        @board.pieces.push(new Piece.Gi(Const.FIRST, Const.Status.MOTIGOMA))
        @board.pieces.push(new Piece.Gi(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange67: ->
        @board.pieces = []
        @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [1,1]))
        @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
        @board.pieces.push(new Piece.Gi(Const.FIRST, Const.Status.OMOTE, [2,3]))
        @board.pieces.push(new Piece.Gi(Const.SECOND, Const.Status.OMOTE, [3,1]))
        @board.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.OMOTE, [2,1]))
        @board.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.OMOTE, [1,2]))
        return
    set_arrange68: ->
        @board.pieces = []
        @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [1,2]))
        @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [3,2]))
        @board.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.OMOTE, [2,3]))
        @board.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.OMOTE, [2,1]))
        @board.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.MOTIGOMA))
        @board.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange69: ->
        @board.pieces = []
        @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,2]))
        @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,2]))
        @board.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.OMOTE, [2,3]))
        @board.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.OMOTE, [2,1]))
        @board.pieces.push(new Piece.Ka(Const.FIRST, Const.Status.MOTIGOMA))
        @board.pieces.push(new Piece.Ka(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange70: ->
        @board.pieces = []
        @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [1,2]))
        @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [3,2]))
        @board.pieces.push(new Piece.Ky(Const.FIRST, Const.Status.OMOTE, [1,3]))
        @board.pieces.push(new Piece.Ky(Const.SECOND, Const.Status.OMOTE, [3,1]))
        @board.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.MOTIGOMA))
        @board.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange71: ->
        @board.pieces = []
        @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,2]))
        @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,2]))
        @board.pieces.push(new Piece.Ki(Const.FIRST, Const.Status.OMOTE, [2,1]))
        @board.pieces.push(new Piece.Ki(Const.SECOND, Const.Status.OMOTE, [2,3]))
        @board.pieces.push(new Piece.Ky(Const.FIRST, Const.Status.OMOTE, [3,3]))
        @board.pieces.push(new Piece.Ky(Const.SECOND, Const.Status.OMOTE, [1,1]))
        return
    set_arrange72: ->
        @board.pieces = []
        @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [2,1]))
        @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [2,3]))
        @board.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.OMOTE, [3,3]))
        @board.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.OMOTE, [1,1]))
        @board.pieces.push(new Piece.Ky(Const.FIRST, Const.Status.MOTIGOMA))
        @board.pieces.push(new Piece.Ky(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange73: ->
        @board.pieces = []
        @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [1,3]))
        @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [3,1]))
        @board.pieces.push(new Piece.Gi(Const.FIRST, Const.Status.OMOTE, [2,1]))
        @board.pieces.push(new Piece.Gi(Const.SECOND, Const.Status.OMOTE, [2,3]))
        @board.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.OMOTE, [3,3]))
        @board.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.OMOTE, [1,1]))
        return
    set_arrange74: ->
        @board.pieces = []
        @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,2]))
        @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,2]))
        @board.pieces.push(new Piece.Hi(Const.FIRST, Const.Status.OMOTE, [3,3]))
        @board.pieces.push(new Piece.Hi(Const.SECOND, Const.Status.OMOTE, [1,1]))
        @board.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.MOTIGOMA))
        @board.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange75: ->
        @board.pieces = []
        @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [1,2]))
        @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [3,2]))
        @board.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.OMOTE, [1,3]))
        @board.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.OMOTE, [3,1]))
        @board.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.MOTIGOMA))
        @board.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange76: ->
        @board.pieces = []
        @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
        @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
        @board.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.OMOTE, [3,3]))
        @board.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.OMOTE, [1,1]))
        @board.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA))
        @board.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange77: ->
        @board.pieces = []
        @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
        @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
        @board.pieces.push(new Piece.Ky(Const.FIRST, Const.Status.OMOTE, [3,2]))
        @board.pieces.push(new Piece.Ky(Const.SECOND, Const.Status.OMOTE, [1,2]))
        @board.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.OMOTE, [2,3]))
        @board.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.OMOTE, [2,1]))
        return
    set_arrange78: ->
        @board.pieces = []
        @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [2,1]))
        @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [2,3]))
        @board.pieces.push(new Piece.Ki(Const.FIRST, Const.Status.OMOTE, [1,2]))
        @board.pieces.push(new Piece.Ki(Const.SECOND, Const.Status.OMOTE, [3,2]))
        @board.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.MOTIGOMA))
        @board.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange79: ->
        @board.pieces = []
        @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,2]))
        @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,2]))
        @board.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.OMOTE, [1,3]))
        @board.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.OMOTE, [3,1]))
        @board.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.OMOTE, [3,3]))
        @board.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.OMOTE, [1,1]))
        return
    set_arrange80: ->
        @board.pieces = []
        @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
        @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
        @board.pieces.push(new Piece.Ki(Const.FIRST, Const.Status.OMOTE, [3,2]))
        @board.pieces.push(new Piece.Ki(Const.SECOND, Const.Status.OMOTE, [1,2]))
        @board.pieces.push(new Piece.Hi(Const.FIRST, Const.Status.MOTIGOMA))
        @board.pieces.push(new Piece.Hi(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange81: ->
        @board.pieces = []
        @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [1,3]))
        @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [3,1]))
        @board.pieces.push(new Piece.Ky(Const.FIRST, Const.Status.MOTIGOMA))
        @board.pieces.push(new Piece.Ky(Const.SECOND, Const.Status.MOTIGOMA))
        @board.pieces.push(new Piece.Ka(Const.FIRST, Const.Status.OMOTE, [2,3]))
        @board.pieces.push(new Piece.Ka(Const.SECOND, Const.Status.OMOTE, [2,1]))
        return
    set_arrange82: ->
        @board.pieces = []
        @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [1,3]))
        @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [3,1]))
        @board.pieces.push(new Piece.Ky(Const.FIRST, Const.Status.MOTIGOMA))
        @board.pieces.push(new Piece.Ky(Const.SECOND, Const.Status.MOTIGOMA))
        @board.pieces.push(new Piece.Ka(Const.FIRST, Const.Status.OMOTE, [1,2]))
        @board.pieces.push(new Piece.Ka(Const.SECOND, Const.Status.OMOTE, [3,2]))
        return
    set_arrange83: ->
        @board.pieces = []
        @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,3]))
        @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,1]))
        @board.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.OMOTE, [1,3]))
        @board.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.OMOTE, [3,1]))
        @board.pieces.push(new Piece.Ky(Const.FIRST, Const.Status.MOTIGOMA))
        @board.pieces.push(new Piece.Ky(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange84: ->
        @board.pieces = []
        @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [2,1]))
        @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [2,3]))
        @board.pieces.push(new Piece.Gi(Const.FIRST, Const.Status.OMOTE, [3,1]))
        @board.pieces.push(new Piece.Gi(Const.SECOND, Const.Status.OMOTE, [1,3]))
        @board.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.MOTIGOMA))
        @board.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange85: ->
        @board.pieces = []
        @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [1,3]))
        @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [2,1]))
        @board.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.OMOTE, [1,2]))
        @board.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.URA, [1,1]))
        return
    set_arrange86: ->
        @board.pieces = []
        @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
        @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
        @board.pieces.push(new Piece.Ka(Const.FIRST, Const.Status.OMOTE, [3,2]))
        @board.pieces.push(new Piece.Ka(Const.SECOND, Const.Status.OMOTE, [1,2]))
        @board.pieces.push(new Piece.Ky(Const.FIRST, Const.Status.MOTIGOMA))
        @board.pieces.push(new Piece.Ky(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange87: ->
        @board.pieces = []
        @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,3]))
        @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,1]))
        @board.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.OMOTE, [1,3]))
        @board.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.OMOTE, [3,1]))
        @board.pieces.push(new Piece.Hi(Const.FIRST, Const.Status.MOTIGOMA))
        @board.pieces.push(new Piece.Hi(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange88: ->
        @board.pieces = []
        @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
        @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,1]))
        @board.pieces.push(new Piece.Gi(Const.SECOND, Const.Status.URA, [1,2]))
        @board.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.URA, [2,3]))
        @board.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.OMOTE, [2,2]))
        return
    set_arrange89: ->
        @board.pieces = []
        @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [2,1]))
        @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [2,3]))
        @board.pieces.push(new Piece.Ky(Const.FIRST, Const.Status.OMOTE, [1,2]))
        @board.pieces.push(new Piece.Ky(Const.SECOND, Const.Status.OMOTE, [3,2]))
        @board.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.MOTIGOMA))
        @board.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange90: ->
        @board.pieces = []
        @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
        @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
        @board.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.OMOTE, [3,3]))
        @board.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.OMOTE, [1,1]))
        @board.pieces.push(new Piece.Ka(Const.FIRST, Const.Status.MOTIGOMA))
        @board.pieces.push(new Piece.Ka(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange91: ->
        @board.pieces = []
        @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
        @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
        @board.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.OMOTE, [1,2]))
        @board.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.OMOTE, [3,2]))
        @board.pieces.push(new Piece.Gi(Const.FIRST, Const.Status.MOTIGOMA))
        @board.pieces.push(new Piece.Gi(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange92: ->
        @board.pieces = []
        @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
        @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
        @board.pieces.push(new Piece.Ka(Const.FIRST, Const.Status.OMOTE, [2,3]))
        @board.pieces.push(new Piece.Ka(Const.SECOND, Const.Status.OMOTE, [2,1]))
        @board.pieces.push(new Piece.Ky(Const.FIRST, Const.Status.OMOTE, [3,3]))
        @board.pieces.push(new Piece.Ky(Const.SECOND, Const.Status.OMOTE, [1,1]))
        return
    set_arrange93: ->
        @board.pieces = []
        @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,2]))
        @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,2]))
        @board.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.OMOTE, [3,3]))
        @board.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.OMOTE, [1,1]))
        @board.pieces.push(new Piece.Hi(Const.FIRST, Const.Status.MOTIGOMA))
        @board.pieces.push(new Piece.Hi(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange94: ->
        @board.pieces = []
        @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
        @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
        @board.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.OMOTE, [2,3]))
        @board.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.OMOTE, [2,1]))
        @board.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA))
        @board.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange95: ->
        @board.pieces = []
        @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [1,2]))
        @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [3,2]))
        @board.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.OMOTE, [1,3]))
        @board.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.OMOTE, [3,1]))
        @board.pieces.push(new Piece.Ka(Const.FIRST, Const.Status.MOTIGOMA))
        @board.pieces.push(new Piece.Ka(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange96: ->
        @board.pieces = []
        @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,2]))
        @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,2]))
        @board.pieces.push(new Piece.Ki(Const.FIRST, Const.Status.OMOTE, [3,1]))
        @board.pieces.push(new Piece.Ki(Const.SECOND, Const.Status.OMOTE, [1,3]))
        @board.pieces.push(new Piece.Ky(Const.FIRST, Const.Status.MOTIGOMA))
        @board.pieces.push(new Piece.Ky(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange97: ->
        @board.pieces = []
        @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,3]))
        @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,1]))
        @board.pieces.push(new Piece.Ki(Const.FIRST, Const.Status.OMOTE, [1,3]))
        @board.pieces.push(new Piece.Ki(Const.SECOND, Const.Status.OMOTE, [3,1]))
        @board.pieces.push(new Piece.Ky(Const.FIRST, Const.Status.MOTIGOMA))
        @board.pieces.push(new Piece.Ky(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange98: ->
        @board.pieces = []
        @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,2]))
        @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,2]))
        @board.pieces.push(new Piece.Ky(Const.FIRST, Const.Status.OMOTE, [3,3]))
        @board.pieces.push(new Piece.Ky(Const.SECOND, Const.Status.OMOTE, [1,1]))
        @board.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.OMOTE, [1,3]))
        @board.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.OMOTE, [3,1]))
        return
    set_arrange99: ->
        @board.pieces = []
        @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,3]))
        @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,1]))
        @board.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.OMOTE, [1,3]))
        @board.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.OMOTE, [3,1]))
        @board.pieces.push(new Piece.Ky(Const.FIRST, Const.Status.MOTIGOMA))
        @board.pieces.push(new Piece.Ky(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange100: ->
        @board.pieces = []
        @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,3]))
        @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,1]))
        @board.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.OMOTE, [3,2]))
        @board.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.OMOTE, [1,2]))
        @board.pieces.push(new Piece.Hi(Const.FIRST, Const.Status.MOTIGOMA))
        @board.pieces.push(new Piece.Hi(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange101: ->
        @board.pieces = []
        @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
        @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
        @board.pieces.push(new Piece.Ka(Const.FIRST, Const.Status.OMOTE, [2,1]))
        @board.pieces.push(new Piece.Ka(Const.SECOND, Const.Status.OMOTE, [2,3]))
        @board.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA))
        @board.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange102: ->
        @board.pieces = []
        @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
        @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
        @board.pieces.push(new Piece.Ky(Const.FIRST, Const.Status.OMOTE, [1,2]))
        @board.pieces.push(new Piece.Ky(Const.SECOND, Const.Status.OMOTE, [3,2]))
        @board.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA))
        @board.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange103: ->
        @board.pieces = []
        @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,2]))
        @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,2]))
        @board.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.MOTIGOMA))
        @board.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.MOTIGOMA))
        @board.pieces.push(new Piece.Gi(Const.FIRST, Const.Status.OMOTE, [3,1]))
        @board.pieces.push(new Piece.Gi(Const.SECOND, Const.Status.OMOTE, [1,3]))
        return
    set_arrange104: ->
        @board.pieces = []
        @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [1,3]))
        @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [3,1]))
        @board.pieces.push(new Piece.Ka(Const.FIRST, Const.Status.OMOTE, [2,3]))
        @board.pieces.push(new Piece.Ka(Const.SECOND, Const.Status.OMOTE, [2,1]))
        @board.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.MOTIGOMA))
        @board.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange105: ->
        @board.pieces = []
        @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,2]))
        @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,2]))
        @board.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.OMOTE, [2,3]))
        @board.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.OMOTE, [2,1]))
        @board.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA))
        @board.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange106: ->
        @board.pieces = []
        @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [2,1]))
        @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [2,3]))
        @board.pieces.push(new Piece.Gi(Const.FIRST, Const.Status.OMOTE, [3,1]))
        @board.pieces.push(new Piece.Gi(Const.SECOND, Const.Status.OMOTE, [1,3]))
        @board.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA))
        @board.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange107: ->
        @board.pieces = []
        @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [1,2]))
        @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [3,2]))
        @board.pieces.push(new Piece.Hi(Const.FIRST, Const.Status.OMOTE, [1,3]))
        @board.pieces.push(new Piece.Hi(Const.SECOND, Const.Status.OMOTE, [3,1]))
        @board.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA))
        @board.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange108: ->
        @board.pieces = []
        @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [1,2]))
        @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [3,2]))
        @board.pieces.push(new Piece.Ky(Const.FIRST, Const.Status.OMOTE, [1,3]))
        @board.pieces.push(new Piece.Ky(Const.SECOND, Const.Status.OMOTE, [3,1]))
        @board.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.OMOTE, [2,3]))
        @board.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.OMOTE, [2,1]))
        return
    set_arrange109: ->
        @board.pieces = []
        @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [2,1]))
        @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [2,3]))
        @board.pieces.push(new Piece.Ky(Const.FIRST, Const.Status.OMOTE, [3,3]))
        @board.pieces.push(new Piece.Ky(Const.SECOND, Const.Status.OMOTE, [1,1]))
        @board.pieces.push(new Piece.Hi(Const.FIRST, Const.Status.MOTIGOMA))
        @board.pieces.push(new Piece.Hi(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange110: ->
        @board.pieces = []
        @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [2,1]))
        @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [2,3]))
        @board.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.URA, [1,2]))
        @board.pieces.push(new Piece.Ki(Const.SECOND, Const.Status.OMOTE, [3,2]))
        @board.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.MOTIGOMA))
        @board.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange111: ->
        @board.pieces = []
        @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,3]))
        @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,1]))
        @board.pieces.push(new Piece.Hi(Const.FIRST, Const.Status.OMOTE, [3,2]))
        @board.pieces.push(new Piece.Ka(Const.SECOND, Const.Status.OMOTE, [1,3]))
        return
    set_arrange112: ->
        @board.pieces = []
        @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [2,1]))
        @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [2,3]))
        @board.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.OMOTE, [3,3]))
        @board.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.OMOTE, [1,1]))
        @board.pieces.push(new Piece.Hi(Const.FIRST, Const.Status.MOTIGOMA))
        @board.pieces.push(new Piece.Hi(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange113: ->
        @board.pieces = []
        @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [2,1]))
        @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [2,3]))
        @board.pieces.push(new Piece.Ki(Const.FIRST, Const.Status.OMOTE, [3,1]))
        @board.pieces.push(new Piece.Ki(Const.SECOND, Const.Status.OMOTE, [1,3]))
        @board.pieces.push(new Piece.Ky(Const.FIRST, Const.Status.MOTIGOMA))
        @board.pieces.push(new Piece.Ky(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange114: ->
        @board.pieces = []
        @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,2]))
        @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,2]))
        @board.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.OMOTE, [1,3]))
        @board.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.OMOTE, [3,1]))
        @board.pieces.push(new Piece.Gi(Const.FIRST, Const.Status.MOTIGOMA))
        @board.pieces.push(new Piece.Gi(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange115: ->
        @board.pieces = []
        @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
        @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
        @board.pieces.push(new Piece.Ky(Const.FIRST, Const.Status.OMOTE, [3,3]))
        @board.pieces.push(new Piece.Ky(Const.SECOND, Const.Status.OMOTE, [1,1]))
        @board.pieces.push(new Piece.Gi(Const.FIRST, Const.Status.MOTIGOMA))
        @board.pieces.push(new Piece.Gi(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange116: ->
        @board.pieces = []
        @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [1,2]))
        @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [3,2]))
        @board.pieces.push(new Piece.Ki(Const.FIRST, Const.Status.OMOTE, [1,3]))
        @board.pieces.push(new Piece.Ki(Const.SECOND, Const.Status.OMOTE, [3,1]))
        @board.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.OMOTE, [3,3]))
        @board.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.OMOTE, [1,1]))
        return
    set_arrange117: ->
        @board.pieces = []
        @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [2,1]))
        @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [2,3]))
        @board.pieces.push(new Piece.Ki(Const.FIRST, Const.Status.OMOTE, [3,2]))
        @board.pieces.push(new Piece.Ki(Const.SECOND, Const.Status.OMOTE, [1,2]))
        @board.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.OMOTE, [1,3]))
        @board.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.OMOTE, [3,1]))
        return
    set_arrange118: ->
        @board.pieces = []
        @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [2,1]))
        @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [2,3]))
        @board.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.OMOTE, [1,3]))
        @board.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.OMOTE, [3,1]))
        @board.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA))
        @board.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange119: ->
        @board.pieces = []
        @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [2,3]))
        @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [2,1]))
        @board.pieces.push(new Piece.Ky(Const.FIRST, Const.Status.OMOTE, [1,3]))
        @board.pieces.push(new Piece.Ky(Const.SECOND, Const.Status.OMOTE, [3,1]))
        @board.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.MOTIGOMA))
        @board.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange120: ->
        @board.pieces = []
        @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [1,2]))
        @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [3,2]))
        @board.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.OMOTE, [2,3]))
        @board.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.OMOTE, [2,1]))
        @board.pieces.push(new Piece.Ky(Const.FIRST, Const.Status.MOTIGOMA))
        @board.pieces.push(new Piece.Ky(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange121: ->
        @board.pieces = []
        @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [2,1]))
        @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [2,3]))
        @board.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.OMOTE, [1,3]))
        @board.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.OMOTE, [3,1]))
        @board.pieces.push(new Piece.Gi(Const.FIRST, Const.Status.MOTIGOMA))
        @board.pieces.push(new Piece.Gi(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange122: ->
        @board.pieces = []
        @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
        @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
        @board.pieces.push(new Piece.Gi(Const.FIRST, Const.Status.OMOTE, [2,3]))
        @board.pieces.push(new Piece.Gi(Const.SECOND, Const.Status.OMOTE, [2,1]))
        @board.pieces.push(new Piece.Ky(Const.FIRST, Const.Status.MOTIGOMA))
        @board.pieces.push(new Piece.Ky(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange123: ->
        @board.pieces = []
        @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,3]))
        @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,1]))
        @board.pieces.push(new Piece.Gi(Const.FIRST, Const.Status.OMOTE, [1,3]))
        @board.pieces.push(new Piece.Gi(Const.SECOND, Const.Status.OMOTE, [3,1]))
        @board.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA))
        @board.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange124: ->
        @board.pieces = []
        @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,3]))
        @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,1]))
        @board.pieces.push(new Piece.Ka(Const.FIRST, Const.Status.OMOTE, [2,1]))
        @board.pieces.push(new Piece.Ka(Const.SECOND, Const.Status.OMOTE, [2,3]))
        @board.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.MOTIGOMA))
        @board.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange125: ->
        @board.pieces = []
        @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,3]))
        @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,1]))
        @board.pieces.push(new Piece.Ka(Const.FIRST, Const.Status.OMOTE, [3,1]))
        @board.pieces.push(new Piece.Ka(Const.SECOND, Const.Status.OMOTE, [1,3]))
        @board.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.MOTIGOMA))
        @board.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange126: ->
        @board.pieces = []
        @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
        @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
        @board.pieces.push(new Piece.Ka(Const.FIRST, Const.Status.OMOTE, [2,3]))
        @board.pieces.push(new Piece.Ka(Const.SECOND, Const.Status.OMOTE, [2,1]))
        @board.pieces.push(new Piece.Ky(Const.FIRST, Const.Status.MOTIGOMA))
        @board.pieces.push(new Piece.Ky(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange127: ->
        @board.pieces = []
        @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,3]))
        @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,1]))
        @board.pieces.push(new Piece.Ka(Const.FIRST, Const.Status.OMOTE, [1,2]))
        @board.pieces.push(new Piece.Ka(Const.SECOND, Const.Status.OMOTE, [3,2]))
        @board.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.MOTIGOMA))
        @board.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange128: ->
        @board.pieces = []
        @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [1,2]))
        @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [3,2]))
        @board.pieces.push(new Piece.Gi(Const.FIRST, Const.Status.OMOTE, [3,1]))
        @board.pieces.push(new Piece.Gi(Const.SECOND, Const.Status.OMOTE, [1,3]))
        @board.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.MOTIGOMA))
        @board.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange129: ->
        @board.pieces = []
        @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
        @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
        @board.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.OMOTE, [2,3]))
        @board.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.OMOTE, [2,1]))
        @board.pieces.push(new Piece.Hi(Const.FIRST, Const.Status.MOTIGOMA))
        @board.pieces.push(new Piece.Hi(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange130: ->
        @board.pieces = []
        @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
        @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
        @board.pieces.push(new Piece.Ka(Const.FIRST, Const.Status.OMOTE, [2,1]))
        @board.pieces.push(new Piece.Ka(Const.SECOND, Const.Status.OMOTE, [2,3]))
        @board.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.MOTIGOMA))
        @board.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.MOTIGOMA))
        return

    set_arrange131: ->
        @board.pieces = []
        @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
        @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
        @board.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.OMOTE, [3,3]))
        @board.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.OMOTE, [1,1]))
        @board.pieces.push(new Piece.Hi(Const.FIRST, Const.Status.MOTIGOMA))
        @board.pieces.push(new Piece.Hi(Const.SECOND, Const.Status.MOTIGOMA))

    set_arrange132: ->
        @board.pieces = []
        @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
        @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
        @board.pieces.push(new Piece.Hi(Const.FIRST, Const.Status.OMOTE, [3,2]))
        @board.pieces.push(new Piece.Hi(Const.SECOND, Const.Status.OMOTE, [1,2]))
        @board.pieces.push(new Piece.Gi(Const.FIRST, Const.Status.MOTIGOMA))
        @board.pieces.push(new Piece.Gi(Const.SECOND, Const.Status.MOTIGOMA))

    set_arrange133: ->
        @board.pieces = []
        @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
        @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
        @board.pieces.push(new Piece.Gi(Const.FIRST, Const.Status.OMOTE, [3,2]))
        @board.pieces.push(new Piece.Gi(Const.SECOND, Const.Status.OMOTE, [1,2]))
        @board.pieces.push(new Piece.Hi(Const.FIRST, Const.Status.MOTIGOMA))
        @board.pieces.push(new Piece.Hi(Const.SECOND, Const.Status.MOTIGOMA))

    set_arrange134: ->
        @board.pieces = []
        @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
        @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
        @board.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.URA, [3,2]))
        @board.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.URA, [1,2]))
        @board.pieces.push(new Piece.Hi(Const.FIRST, Const.Status.MOTIGOMA))
        @board.pieces.push(new Piece.Hi(Const.SECOND, Const.Status.MOTIGOMA))

    set_arrange135: ->
        @board.pieces = []
        @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
        @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
        @board.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.URA, [3,2]))
        @board.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.URA, [1,2]))
        @board.pieces.push(new Piece.Ka(Const.FIRST, Const.Status.MOTIGOMA))
        @board.pieces.push(new Piece.Ka(Const.SECOND, Const.Status.MOTIGOMA))

    set_arrange136: ->
        @board.pieces = []
        @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
        @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
        @board.pieces.push(new Piece.Ki(Const.FIRST, Const.Status.OMOTE, [3,2]))
        @board.pieces.push(new Piece.Ki(Const.SECOND, Const.Status.OMOTE, [1,2]))
        @board.pieces.push(new Piece.Ka(Const.FIRST, Const.Status.MOTIGOMA))
        @board.pieces.push(new Piece.Ka(Const.SECOND, Const.Status.MOTIGOMA))

    set_arrange137: ->
        @board.pieces = []
        @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
        @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
        @board.pieces.push(new Piece.Ki(Const.FIRST, Const.Status.OMOTE, [2,1]))
        @board.pieces.push(new Piece.Ki(Const.SECOND, Const.Status.OMOTE, [2,3]))
        @board.pieces.push(new Piece.Ka(Const.FIRST, Const.Status.MOTIGOMA))
        @board.pieces.push(new Piece.Ka(Const.SECOND, Const.Status.MOTIGOMA))

    set_arrange138: ->
        @board.pieces = []
        @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
        @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
        @board.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.URA, [2,1]))
        @board.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.URA, [2,3]))
        @board.pieces.push(new Piece.Ka(Const.FIRST, Const.Status.MOTIGOMA))
        @board.pieces.push(new Piece.Ka(Const.SECOND, Const.Status.MOTIGOMA))

    set_arrange139: ->
        @board.pieces = []
        @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
        @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
        @board.pieces.push(new Piece.Ki(Const.FIRST, Const.Status.OMOTE, [3,3]))
        @board.pieces.push(new Piece.Ki(Const.SECOND, Const.Status.OMOTE, [1,1]))
        @board.pieces.push(new Piece.Hi(Const.FIRST, Const.Status.MOTIGOMA))
        @board.pieces.push(new Piece.Hi(Const.SECOND, Const.Status.MOTIGOMA))

    set_arrange140: ->
        @board.pieces = []
        @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
        @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
        @board.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.URA, [3,3]))
        @board.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.URA, [1,1]))
        @board.pieces.push(new Piece.Hi(Const.FIRST, Const.Status.MOTIGOMA))
        @board.pieces.push(new Piece.Hi(Const.SECOND, Const.Status.MOTIGOMA))

    setBoardSize: (w, h) ->
        if w <= h
            @board.width = w * 0.70
            @board.height = w * 0.70
        else
            @board.width = h * 0.70
            @board.height = h * 0.70
        return

    setEventListener: (special) ->
        $(document).on 'after_search', (e) =>
            # console.log("after_search")
            for v,i in @searchResult
                launch.call @, v
                @board.display(i, @searchResult[i])
            @board.pieces = []
            for koma in @bkup.pieces
                @board.pieces.push(koma)
            # console.log("revert pieces = #{JSON.stringify(@board.pieces)}")

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
            for i in [1,2,player.depth].unique()
                temp = []
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
                    @board.display(); $('#b' + ret[1][0] + ret[1][1]).css('border-style', 'dashed')
                    return
                # else if chk_sennitite == null && ret[4]["koma"]?
                #         ret[0] = ret[4]["koma"]
                #         ret[1] = ret[4]["posi"]
                #         ret[2] = ret[4]["score"]
                #         ret[3] = ret[4]["status"]
                if @board.check_move(ret[0], ret[1])
                    src_posi = @board.move_capture(ret[0], ret[1])
                    ret[0].status = ret[3]
                @md5hash = GameGUI.make_hash(@board)
                @seq += 1
                @addState(@md5hash, ret[1], src_posi, ret[1], ret[0].koma())
                if @sennitite(@md5hash)
                    @board.display(); $('#b' + ret[1][0] + ret[1][1]).css('border-style', 'dashed')
                    return
                @teban = if (@seq % 2) == 0 then @first else @second
            else
                if @teban.turn == Const.FIRST
                    @board.statusarea.innerHTML = i18next.t('msgWinner', {postProcess: 'sprintf', sprintf: [i18next.t('msgWhite')]})
                else
                    @board.statusarea.innerHTML = i18next.t('msgWinner', {postProcess: 'sprintf', sprintf: [i18next.t('msgBlack')]})
                @startbtn.disabled = false; $("#btnStop").val(i18next.t('msgRestart')).button("refresh")
                @naviA.style.display = "block"
                return

            # 詰みチェック
            tumi = []
            tumi = oppo.think(@board, player, 1, oppo_threshold)
            unless tumi[0]
                switch tumi[2]
                    when Const.MAX_VALUE
                        @board.statusarea.innerHTML = i18next.t('msgFirstWin')
                        @startbtn.disabled = false; $("#btnStop").val(i18next.t('msgRestart')).button("refresh")
                        @naviA.style.display = "block"
                    when Const.MIN_VALUE
                        @board.statusarea.innerHTML = i18next.t('msgSecondWin')
                        @startbtn.disabled = false; $("#btnStop").val(i18next.t('msgRestart')).button("refresh")
                        @naviA.style.display = "block"
                    else
                        console.log("Error!")
                @board.display()
                return
            # 相手玉が自爆しても指し手を進めてしまうのでゲーム終了チェック
            switch @board.gameover()
                when Const.FIRST
                    @board.statusarea.innerHTML = i18next.t('msgFirstWin')
                    @startbtn.disabled = false; $("#btnStop").val(i18next.t('msgRestart')).button("refresh")
                    @naviA.style.display = "block"
                when Const.SECOND
                    @board.statusarea.innerHTML = i18next.t('msgSecondWin')
                    @startbtn.disabled = false; $("#btnStop").val(i18next.t('msgRestart')).button("refresh")
                    @naviA.style.display = "block"
                else
                    if @teban.turn == Const.FIRST
                        @board.statusarea.innerHTML = i18next.t('msgTurn', {postProcess: 'sprintf', sprintf: [i18next.t('msgBlack')]})
                    else
                        @board.statusarea.innerHTML = i18next.t('msgTurn', {postProcess: 'sprintf', sprintf: [i18next.t('msgWhite')]})
                    @board.statusarea.innerHTML = @board.statusarea.innerHTML + i18next.t('msgEvaluate', {postProcess: 'sprintf', sprintf: [ret[2].toString()]})

            @board.display(); $('#b' + ret[1][0] + ret[1][1]).css('border-style', 'dashed')

        $(window).on 'load', (e) =>
            # console.log("=== Load ===")
            target = $(e.currentTarget)
            @setBoardSize(target.width(), target.height())
            @init()
            @board.init()

        $(window).on special, (e) =>
            # console.log("=== Device Ready ===")
            target = $(e.currentTarget)

        $(boardSearch).on 'updatelayout', (e) =>
            # console.log("boardSearch updatelayout")
            target = $(e.currentTarget)

        $(boardList).on 'updatelayout', (e) =>
            # console.log("updatelayout")
            if window.myVersionString? && parseInt(window.myVersionString[0]|0, 10) >= 6
                scrollHeight = $("boardImage").context.scrollingElement.scrollHeight
                $('html,body').animate({ scrollTop: (scrollHeight / (140 + 1)) * @label_idx }, queue: false)

        $(document).on 'pagecontainershow', (e) =>
            # console.log("pagecontainershow")
            @label_idx = $('input[name=radio-arrange]:checked').val()

    is_oute = (piece, d_posi) ->
        oppo = if piece.turn == Const.FIRST then Const.SECOND else Const.FIRST
        oppo_king = (v for v in @board.pieces when v.turn == oppo && v.kind() == 'Ou')[0]
        buf = [].concat(d_posi)
        buf[0] += eval("Piece."+piece.kind()).getD(piece.turn, piece.status)[0].xd
        buf[1] += eval("Piece."+piece.kind()).getD(piece.turn, piece.status)[0].yd
        # check = piece.status == Const.Status.MOTIGOMA && piece.kind() == 'Fu' && oppo_king.posi.toString() == buf.toString()
        return (oppo_king.posi.toString() == buf.toString())

    launch = (idx = 0) ->
        switch idx
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
            when 51
                @set_arrange51()
            when 52
                @set_arrange52()
            when 53
                @set_arrange53()
            when 54
                @set_arrange54()
            when 55
                @set_arrange55()
            when 56
                @set_arrange56()
            when 57
                @set_arrange57()
            when 58
                @set_arrange58()
            when 59
                @set_arrange59()
            when 60
                @set_arrange60()
            when 61
                @set_arrange61()
            when 62
                @set_arrange62()
            when 63
                @set_arrange63()
            when 64
                @set_arrange64()
            when 65
                @set_arrange65()
            when 66
                @set_arrange66()
            when 67
                @set_arrange67()
            when 68
                @set_arrange68()
            when 69
                @set_arrange69()
            when 70
                @set_arrange70()
            when 71
                @set_arrange71()
            when 72
                @set_arrange72()
            when 73
                @set_arrange73()
            when 74
                @set_arrange74()
            when 75
                @set_arrange75()
            when 76
                @set_arrange76()
            when 77
                @set_arrange77()
            when 78
                @set_arrange78()
            when 79
                @set_arrange79()
            when 80
                @set_arrange80()
            when 81
                @set_arrange81()
            when 82
                @set_arrange82()
            when 83
                @set_arrange83()
            when 84
                @set_arrange84()
            when 85
                @set_arrange85()
            when 86
                @set_arrange86()
            when 87
                @set_arrange87()
            when 88
                @set_arrange88()
            when 89
                @set_arrange89()
            when 90
                @set_arrange90()
            when 91
                @set_arrange91()
            when 92
                @set_arrange92()
            when 93
                @set_arrange93()
            when 94
                @set_arrange94()
            when 95
                @set_arrange95()
            when 96
                @set_arrange96()
            when 97
                @set_arrange97()
            when 98
                @set_arrange98()
            when 99
                @set_arrange99()
            when 100
                @set_arrange100()
            when 101
                @set_arrange101()
            when 102
                @set_arrange102()
            when 103
                @set_arrange103()
            when 104
                @set_arrange104()
            when 105
                @set_arrange105()
            when 106
                @set_arrange106()
            when 107
                @set_arrange107()
            when 108
                @set_arrange108()
            when 109
                @set_arrange109()
            when 110
                @set_arrange110()
            when 111
                @set_arrange111()
            when 112
                @set_arrange112()
            when 113
                @set_arrange113()
            when 114
                @set_arrange114()
            when 115
                @set_arrange115()
            when 116
                @set_arrange116()
            when 117
                @set_arrange117()
            when 118
                @set_arrange118()
            when 119
                @set_arrange119()
            when 120
                @set_arrange120()
            when 121
                @set_arrange121()
            when 122
                @set_arrange122()
            when 123
                @set_arrange123()
            when 124
                @set_arrange124()
            when 125
                @set_arrange125()
            when 126
                @set_arrange126()
            when 127
                @set_arrange127()
            when 128
                @set_arrange128()
            when 129
                @set_arrange129()
            when 130
                @set_arrange130()
            when 131
                @set_arrange131()
            when 132
                @set_arrange132()
            when 133
                @set_arrange133()
            when 134
                @set_arrange134()
            when 135
                @set_arrange135()
            when 136
                @set_arrange136()
            when 137
                @set_arrange137()
            when 138
                @set_arrange138()
            when 139
                @set_arrange139()
            when 140
                @set_arrange140()
            else
                console.log("--- Error ---")
        return

    checkKind = (str) ->
        return str in ["OU", "HI", "KA", "KI", "GI", "KE", "KY", "FU", "RY", "UM", "NG", "NK", "NY", "TO"]

    makePiece = (str, posi = null) ->
        ret = null
        switch str[1..2]
            when "OU"
                if posi == null
                    if str[0] == "+"
                        ret = new Piece.Ou(Const.FIRST, Const.Status.MOTIGOMA)
                    else
                        ret = new Piece.Ou(Const.SECOND, Const.Status.MOTIGOMA)
                else
                    if str[0] == "+"
                        ret = new Piece.Ou(Const.FIRST, Const.Status.OMOTE, posi)
                    else
                        ret = new Piece.Ou(Const.SECOND, Const.Status.OMOTE, posi)
            when "RY"
                if posi == null
                    if str[0] == "+"
                        ret = new Piece.Hi(Const.FIRST, Const.Status.MOTIGOMA)
                    else
                        ret = new Piece.Hi(Const.SECOND, Const.Status.MOTIGOMA)
                else
                    if str[0] == "+"
                        ret = new Piece.Hi(Const.FIRST, Const.Status.URA, posi)
                    else
                        ret = new Piece.Hi(Const.SECOND, Const.Status.URA, posi)
            when "HI"
                if posi == null
                    if str[0] == "+"
                        ret = new Piece.Hi(Const.FIRST, Const.Status.MOTIGOMA)
                    else
                        ret = new Piece.Hi(Const.SECOND, Const.Status.MOTIGOMA)
                else
                    if str[0] == "+"
                        ret = new Piece.Hi(Const.FIRST, Const.Status.OMOTE, posi)
                    else
                        ret = new Piece.Hi(Const.SECOND, Const.Status.OMOTE, posi)
            when "UM"
                if posi == null
                    if str[0] == "+"
                        ret = new Piece.Ka(Const.FIRST, Const.Status.MOTIGOMA)
                    else
                        ret = new Piece.Ka(Const.SECOND, Const.Status.MOTIGOMA)
                else
                    if str[0] == "+"
                        ret = new Piece.Ka(Const.FIRST, Const.Status.URA, posi)
                    else
                        ret = new Piece.Ka(Const.SECOND, Const.Status.URA, posi)
            when "KA"
                if posi == null
                    if str[0] == "+"
                        ret = new Piece.Ka(Const.FIRST, Const.Status.MOTIGOMA)
                    else
                        ret = new Piece.Ka(Const.SECOND, Const.Status.MOTIGOMA)
                else
                    if str[0] == "+"
                        ret = new Piece.Ka(Const.FIRST, Const.Status.OMOTE, posi)
                    else
                        ret = new Piece.Ka(Const.SECOND, Const.Status.OMOTE, posi)
            when "KI"
                if posi == null
                    if str[0] == "+"
                        ret = new Piece.Ki(Const.FIRST, Const.Status.MOTIGOMA)
                    else
                        ret = new Piece.Ki(Const.SECOND, Const.Status.MOTIGOMA)
                else
                    if str[0] == "+"
                        ret = new Piece.Ki(Const.FIRST, Const.Status.OMOTE, posi)
                    else
                        ret = new Piece.Ki(Const.SECOND, Const.Status.OMOTE, posi)
            when "NG"
                if posi == null
                    if str[0] == "+"
                        ret = new Piece.Gi(Const.FIRST, Const.Status.MOTIGOMA)
                    else
                        ret = new Piece.Gi(Const.SECOND, Const.Status.MOTIGOMA)
                else
                    if str[0] == "+"
                        ret = new Piece.Gi(Const.FIRST, Const.Status.URA, posi)
                    else
                        ret = new Piece.Gi(Const.SECOND, Const.Status.URA, posi)
            when "GI"
                if posi == null
                    if str[0] == "+"
                        ret = new Piece.Gi(Const.FIRST, Const.Status.MOTIGOMA)
                    else
                        ret = new Piece.Gi(Const.SECOND, Const.Status.MOTIGOMA)
                else
                    if str[0] == "+"
                        ret = new Piece.Gi(Const.FIRST, Const.Status.OMOTE, posi)
                    else
                        ret = new Piece.Gi(Const.SECOND, Const.Status.OMOTE, posi)
            when "NK"
                if posi == null
                    if str[0] == "+"
                        ret = new Piece.Ke(Const.FIRST, Const.Status.MOTIGOMA)
                    else
                        ret = new Piece.Ke(Const.SECOND, Const.Status.MOTIGOMA)
                else
                    if str[0] == "+"
                        ret = new Piece.Ke(Const.FIRST, Const.Status.URA, posi)
                    else
                        ret = new Piece.Ke(Const.SECOND, Const.Status.URA, posi)
            when "KE"
                if posi == null
                    if str[0] == "+"
                        ret = new Piece.Ke(Const.FIRST, Const.Status.MOTIGOMA)
                    else
                        ret = new Piece.Ke(Const.SECOND, Const.Status.MOTIGOMA)
                else
                    if str[0] == "+"
                        ret = new Piece.Ke(Const.FIRST, Const.Status.OMOTE, posi)
                    else
                        ret = new Piece.Ke(Const.SECOND, Const.Status.OMOTE, posi)
            when "NY"
                if posi == null
                    if str[0] == "+"
                        ret = new Piece.Ky(Const.FIRST, Const.Status.MOTIGOMA)
                    else
                        ret = new Piece.Ky(Const.SECOND, Const.Status.MOTIGOMA)
                else
                    if str[0] == "+"
                        ret = new Piece.Ky(Const.FIRST, Const.Status.URA, posi)
                    else
                        ret = new Piece.Ky(Const.SECOND, Const.Status.URA, posi)
            when "KY"
                if posi == null
                    if str[0] == "+"
                        ret = new Piece.Ky(Const.FIRST, Const.Status.MOTIGOMA)
                    else
                        ret = new Piece.Ky(Const.SECOND, Const.Status.MOTIGOMA)
                else
                    if str[0] == "+"
                        ret = new Piece.Ky(Const.FIRST, Const.Status.OMOTE, posi)
                    else
                        ret = new Piece.Ky(Const.SECOND, Const.Status.OMOTE, posi)
            when "TO"
                if posi == null
                    if str[0] == "+"
                        ret = new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA)
                    else
                        ret = new Piece.Fu(Const.SECOND, Const.Status.MOTIGOMA)
                else
                    if str[0] == "+"
                        ret = new Piece.Fu(Const.FIRST, Const.Status.URA, posi)
                    else
                        ret = new Piece.Fu(Const.SECOND, Const.Status.URA, posi)
            when "FU"
                if posi == null
                    if str[0] == "+"
                        ret = new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA)
                    else
                        ret = new Piece.Fu(Const.SECOND, Const.Status.MOTIGOMA)
                else
                    if str[0] == "+"
                        ret = new Piece.Fu(Const.FIRST, Const.Status.OMOTE, posi)
                    else
                        ret = new Piece.Fu(Const.SECOND, Const.Status.OMOTE, posi)
        return ret

    initialBoardImage = (pattern) ->
        # console.log("GameGUI.initialBoardImage")
        b = ""
        switch pattern
            when 0
                b += "P1 *  * -OU\n"
                b += "P2 *  *  * \n"
                b += "P3+OU *  * \n"
                b += "P+00GI00FU\n"
                b += "P-00GI00FU\n"
            when 1
                b += "P1-KA-OU * \n"
                b += "P2 *  *  * \n"
                b += "P3 * +OU+KA\n"
                b += "P+00FU\n"
                b += "P-00FU\n"
            when 2
                b += "P1 * -OU-KA\n"
                b += "P2 *  *  * \n"
                b += "P3+HI+OU * \n"
                b += "P+00FU\n"
                b += "P-00FU\n"
            when 3
                b += "P1 *  * -OU\n"
                b += "P2+KA * -KA\n"
                b += "P3+OU *  * \n"
                b += "P+00FU\n"
                b += "P-00FU\n"
            when 4
                b += "P1 * -KA-OU\n"
                b += "P2 *  *  * \n"
                b += "P3+OU+KA * \n"
                b += "P+00HI00FU\n"
                b += "P-00HI00FU\n"
            when 5
                b += "P1 * -FU-OU\n"
                b += "P2+HI * -HI\n"
                b += "P3+OU+FU * \n"
                b += "P+00KA\n"
                b += "P-00KA\n"
            when 6
                b += "P1-HI-OU * \n"
                b += "P2 *  *  * \n"
                b += "P3 * +OU+HI\n"
            when 7
                b += "P1 *  * -OU\n"
                b += "P2 *  *  * \n"
                b += "P3+OU *  * \n"
                b += "P+00HI00FU\n"
                b += "P-00HI00FU\n"
            when 8
                b += "P1 *  * -OU\n"
                b += "P2 *  *  * \n"
                b += "P3+OU *  * \n"
                b += "P+00KA\n"
                b += "P-00HI\n"
            when 9
                b += "P1-FU-KI-OU\n"
                b += "P2 *  *  * \n"
                b += "P3+OU+KI+FU\n"
            when 10
                b += "P1-KE-FU-OU\n"
                b += "P2 *  *  * \n"
                b += "P3+OU+FU+KE\n"
                b += "P+00GI00FU\n"
                b += "P-00GI00FU\n"
            when 11
                b += "P1 *  * -OU\n"
                b += "P2 *  *  * \n"
                b += "P3+OU *  * \n"
                b += "P+00KE00FU\n"
                b += "P-00KE00FU\n"
            when 12
                b += "P1 *  * -OU\n"
                b += "P2 *  *  * \n"
                b += "P3+OU *  * \n"
                b += "P+00KY00FU\n"
                b += "P-00KY00FU\n"
            when 13
                b += "P1 *  * -OU\n"
                b += "P2+OU *  * \n"
                b += "P3 *  *  * \n"
                b += "P+00KY\n"
                b += "P-00KI\n"
            when 14
                b += "P1 *  * -OU\n"
                b += "P2 *  *  * \n"
                b += "P3+OU *  * \n"
                b += "P+00KE00KY\n"
                b += "P-00KE00KY\n"
            when 15
                b += "P1-FU-KA-OU\n"
                b += "P2 *  *  * \n"
                b += "P3+OU+KA+FU\n"
            when 16
                b += "P1+OU *  * \n"
                b += "P2 * -KI * \n"
                b += "P3 *  * -OU\n"
                b += "P+00KI00GI\n"
                b += "P-00GI\n"
            when 17
                b += "P1 *  * -OU\n"
                b += "P2 *  *  * \n"
                b += "P3+OU *  * \n"
                b += "P+00GI\n"
                b += "P-00KI\n"
            when 18
                b += "P1 * -OU * \n"
                b += "P2 *  *  * \n"
                b += "P3 * +OU * \n"
                b += "P+00HI\n"
                b += "P-00KA00FU\n"
            when 19
                b += "P1 * -OU * \n"
                b += "P2 *  *  * \n"
                b += "P3 * +OU * \n"
                b += "P+00KE\n"
                b += "P-00FU\n"
            when 20
                b += "P1 *  * -OU\n"
                b += "P2 *  *  * \n"
                b += "P3+OU *  * \n"
                b += "P+00KE00KE\n"
                b += "P-00KA\n"
            when 21
                b += "P1 *  * -OU\n"
                b += "P2 * -FU * \n"
                b += "P3+OU *  * \n"
                b += "P+00HI\n"
                b += "P-00KI\n"
            when 22
                b += "P1-FU-KA-OU\n"
                b += "P2 *  *  * \n"
                b += "P3+OU+HI+FU\n"
            when 23
                b += "P1 *  * -OU\n"
                b += "P2 *  *  * \n"
                b += "P3+OU *  * \n"
                b += "P+00KA00FU\n"
                b += "P-00HI00FU\n"
            when 24
                b += "P1+OU+KI-KY\n"
                b += "P2+KI+FU-GI\n"
                b += "P3+FU-GI-OU\n"
            when 25
                b += "P1 * +OU * \n"
                b += "P2 *  *  * \n"
                b += "P3 * -OU * \n"
                b += "P+00FU\n"
                b += "P-00FU\n"
            when 26
                b += "P1 *  * -OU\n"
                b += "P2 *  *  * \n"
                b += "P3+OU *  * \n"
                b += "P+00KE00KY\n"
                b += "P-00GI\n"
            when 27
                b += "P1-OU-KY * \n"
                b += "P2 *  *  * \n"
                b += "P3 *  * +OU\n"
                b += "P+00KA00FU00FU\n"
                b += "P-00KA\n"
            when 28
                b += "P1 * -OU * \n"
                b += "P2 *  *  * \n"
                b += "P3 * +OU * \n"
                b += "P+00KA00FU\n"
                b += "P-00HI00FU\n"
            when 29
                b += "P1-HI-OU * \n"
                b += "P2 *  *  * \n"
                b += "P3+KA+OU * \n"
                b += "P+00FU\n"
                b += "P-00KY\n"
            when 30
                b += "P1 * -OU-HI\n"
                b += "P2 *  *  * \n"
                b += "P3+HI+OU * \n"
                b += "P+00FU\n"
                b += "P-00FU\n"
            when 31
                b += "P1 *  * -OU\n"
                b += "P2 *  *  * \n"
                b += "P3+OU *  * \n"
                b += "P+00FU\n"
                b += "P-00KE00KY\n"
            when 32
                b += "P1+HI-KE-OU\n"
                b += "P2-KA+FU-KY\n"
                b += "P3+OU-GI+FU\n"
            when 33
                b += "P1-OU-HI * \n"
                b += "P2 *  *  * \n"
                b += "P3+OU+HI * \n"
            when 34
                b += "P1 * -OU * \n"
                b += "P2-HI *  * \n"
                b += "P3 * +OU * \n"
                b += "P+00KA\n"
            when 35
                b += "P1-FU-KA-OU\n"
                b += "P2 *  *  * \n"
                b += "P3+OU+KY+FU\n"
            when 36
                b += "P1 *  * -OU\n"
                b += "P2 *  *  * \n"
                b += "P3+OU *  * \n"
                b += "P+00KA00FU\n"
                b += "P-00GI00GI\n"
            when 37
                b += "P1 * -FU-OU\n"
                b += "P2 *  *  * \n"
                b += "P3+OU *  * \n"
                b += "P+00GI00GI00FU\n"
                b += "P-00KA00KA\n"
            when 38
                b += "P1 * -FU-OU\n"
                b += "P2 *  *  * \n"
                b += "P3+OU+FU * \n"
                b += "P+00KA\n"
                b += "P-00HI\n"
            when 39
                b += "P1 *  *  * \n"
                b += "P2+OU * -OU\n"
                b += "P3 *  *  * \n"
                b += "P+00KA\n"
                b += "P-00HI00FU\n"
            when 40
                b += "P1 * -OU * \n"
                b += "P2-HI *  * \n"
                b += "P3 * +OU+GI\n"
                b += "P+00FU\n"
                b += "P-00FU\n"
            when 41
                b += "P1+KA * -OU\n"
                b += "P2+FU * -FU\n"
                b += "P3+OU * -KA\n"
            when 42
                b += "P1 *  * -OU\n"
                b += "P2 * +FU * \n"
                b += "P3+OU *  * \n"
                b += "P+00KY\n"
                b += "P-00KA00KI\n"
            when 43
                b += "P1 * -FU-OU\n"
                b += "P2 *  *  * \n"
                b += "P3+OU+FU * \n"
                b += "P+00HI\n"
                b += "P-00GI00GI\n"
            when 44
                b += "P1+OU-KE-FU\n"
                b += "P2 *  *  * \n"
                b += "P3+FU+KE-OU\n"
            when 45
                b += "P1+OU *  * \n"
                b += "P2 *  *  * \n"
                b += "P3 *  * -OU\n"
                b += "P+00GI00FU\n"
                b += "P-00GI00FU\n"
            when 46
                b += "P1+GI+OU * \n"
                b += "P2 *  *  * \n"
                b += "P3 * -OU-GI\n"
                b += "P+00KA\n"
                b += "P-00KA\n"
            when 47
                b += "P1-KY+OU * \n"
                b += "P2 *  *  * \n"
                b += "P3 * -OU+KY\n"
                b += "P+00KA\n"
                b += "P-00KA\n"
            when 48
                b += "P1+OU * -GI\n"
                b += "P2 *  *  * \n"
                b += "P3+GI * -OU\n"
                b += "P+00KY\n"
                b += "P-00KY\n"
            when 49
                b += "P1+OU-FU * \n"
                b += "P2-GI * +GI\n"
                b += "P3 * +FU-OU\n"
            when 50
                b += "P1 *  * -KE\n"
                b += "P2-OU * +OU\n"
                b += "P3+KE *  * \n"
                b += "P+00KY\n"
                b += "P-00KY\n"
            when 51
                b += "P1 * -OU-FU\n"
                b += "P2 *  *  * \n"
                b += "P3+FU+OU * \n"
                b += "P+00KA\n"
                b += "P-00KA\n"
            when 52
                b += "P1+OU-KA * \n"
                b += "P2 *  *  * \n"
                b += "P3 * +KA-OU\n"
                b += "P+00KE\n"
                b += "P-00KE\n"
            when 53
                b += "P1 * -FU-HI\n"
                b += "P2+OU * -OU\n"
                b += "P3+HI+FU * \n"
            when 54
                b += "P1-GI *  * \n"
                b += "P2-OU * +OU\n"
                b += "P3 *  * +GI\n"
                b += "P+00HI\n"
                b += "P-00HI\n"
            when 55
                b += "P1+OU * -KY\n"
                b += "P2 *  *  * \n"
                b += "P3+KY * -OU\n"
                b += "P+00KE\n"
                b += "P-00KE\n"
            when 56
                b += "P1+OU-KA * \n"
                b += "P2-GI * +GI\n"
                b += "P3 * +KA-OU\n"
            when 57
                b += "P1-OU-FU+RY\n"
                b += "P2 *  *  * \n"
                b += "P3-RY+FU+OU\n"
            when 58
                b += "P1 * -OU-KY\n"
                b += "P2 *  *  * \n"
                b += "P3+KY+OU * \n"
                b += "P+00FU\n"
                b += "P-00FU\n"
            when 59
                b += "P1+GI *  * \n"
                b += "P2-OU * +OU\n"
                b += "P3 *  * -GI\n"
                b += "P+00KY\n"
                b += "P-00KY\n"
            when 60
                b += "P1+OU *  * \n"
                b += "P2+FU * -FU\n"
                b += "P3 *  * -OU\n"
                b += "P+00KY\n"
                b += "P-00KY\n"
            when 61
                b += "P1 *  * -OU\n"
                b += "P2-KA * +KA\n"
                b += "P3+OU *  * \n"
                b += "P+00KY\n"
                b += "P-00KY\n"
            when 62
                b += "P1+OU-FU * \n"
                b += "P2 *  *  * \n"
                b += "P3 * +FU-OU\n"
                b += "P+00KE\n"
                b += "P-00KE\n"
            when 63
                b += "P1+OU-KE * \n"
                b += "P2+GI * -GI\n"
                b += "P3 * +KE-OU\n"
            when 64
                b += "P1 * -FU-OU\n"
                b += "P2 *  *  * \n"
                b += "P3+OU+FU * \n"
                b += "P+00GI\n"
                b += "P-00GI\n"
            when 65
                b += "P1 * -KY-OU\n"
                b += "P2 *  *  * \n"
                b += "P3+OU+KY * \n"
                b += "P+00KE\n"
                b += "P-00KE\n"
            when 66
                b += "P1+OU-FU * \n"
                b += "P2 *  *  * \n"
                b += "P3 * +FU-OU\n"
                b += "P+00GI\n"
                b += "P-00GI\n"
            when 67
                b += "P1-GI-FU+OU\n"
                b += "P2 *  * -FU\n"
                b += "P3 * +GI-OU\n"
            when 68
                b += "P1 * -FU * \n"
                b += "P2-OU * +OU\n"
                b += "P3 * +FU * \n"
                b += "P+00KE\n"
                b += "P-00KE\n"
            when 69
                b += "P1 * -FU * \n"
                b += "P2+OU * -OU\n"
                b += "P3 * +FU * \n"
                b += "P+00KA\n"
                b += "P-00KA\n"
            when 70
                b += "P1-KY *  * \n"
                b += "P2-OU * +OU\n"
                b += "P3 *  * +KY\n"
                b += "P+00KE\n"
                b += "P-00KE\n"
            when 71
                b += "P1 * +KI-KY\n"
                b += "P2+OU * -OU\n"
                b += "P3+KY-KI * \n"
            when 72
                b += "P1 * +OU-FU\n"
                b += "P2 *  *  * \n"
                b += "P3+FU-OU * \n"
                b += "P+00KY\n"
                b += "P-00KY\n"
            when 73
                b += "P1-OU+GI-KE\n"
                b += "P2 *  *  * \n"
                b += "P3+KE-GI+OU\n"
            when 74
                b += "P1 *  * -HI\n"
                b += "P2+OU * -OU\n"
                b += "P3+HI *  * \n"
                b += "P+00KE\n"
                b += "P-00KE\n"
            when 75
                b += "P1-FU *  * \n"
                b += "P2-OU * +OU\n"
                b += "P3 *  * +FU\n"
                b += "P+00KE\n"
                b += "P-00KE\n"
            when 76
                b += "P1+OU * -KE\n"
                b += "P2 *  *  * \n"
                b += "P3+KE * -OU\n"
                b += "P+00FU\n"
                b += "P-00FU\n"
            when 77
                b += "P1+OU-FU * \n"
                b += "P2+KY * -KY\n"
                b += "P3 * +FU-OU\n"
            when 78
                b += "P1 * +OU * \n"
                b += "P2-KI * +KI\n"
                b += "P3 * -OU * \n"
                b += "P+00KE\n"
                b += "P-00KE\n"
            when 79
                b += "P1-KE * -FU\n"
                b += "P2+OU * -OU\n"
                b += "P3+FU * +KE\n"
            when 80
                b += "P1+OU *  * \n"
                b += "P2+KI * -KI\n"
                b += "P3 *  * -OU\n"
                b += "P+00HI\n"
                b += "P-00HI\n"
            when 81
                b += "P1-OU-KA * \n"
                b += "P2 *  *  * \n"
                b += "P3 * +KA+OU\n"
                b += "P+00KY\n"
                b += "P-00KY\n"
            when 82
                b += "P1-OU *  * \n"
                b += "P2-KA * +KA\n"
                b += "P3 *  * +OU\n"
                b += "P+00KY\n"
                b += "P-00KY\n"
            when 83
                b += "P1-KE * -OU\n"
                b += "P2 *  *  * \n"
                b += "P3+OU * +KE\n"
                b += "P+00KY\n"
                b += "P-00KY\n"
            when 84
                b += "P1+GI+OU * \n"
                b += "P2 *  *  * \n"
                b += "P3 * -OU-GI\n"
                b += "P+00KE\n"
                b += "P-00KE\n"
            when 85
                b += "P1 * -OU-TO\n"
                b += "P2 *  * +FU\n"
                b += "P3 *  * +OU\n"
            when 86
                b += "P1+OU *  * \n"
                b += "P2+KA * -KA\n"
                b += "P3 *  * -OU\n"
                b += "P+00KY\n"
                b += "P-00KY\n"
            when 87
                b += "P1-FU * -OU\n"
                b += "P2 *  *  * \n"
                b += "P3+OU * +FU\n"
                b += "P+00HI\n"
                b += "P-00HI\n"
            when 88
                b += "P1+OU * -OU\n"
                b += "P2 * -FU-NG\n"
                b += "P3 * +TO * \n"
            when 89
                b += "P1 * +OU * \n"
                b += "P2-KY * +KY\n"
                b += "P3 * -OU * \n"
                b += "P+00KE\n"
                b += "P-00KE\n"
            when 90
                b += "P1+OU * -FU\n"
                b += "P2 *  *  * \n"
                b += "P3+FU * -OU\n"
                b += "P+00KA\n"
                b += "P-00KA\n"
            when 91
                b += "P1+OU *  * \n"
                b += "P2-FU * +FU\n"
                b += "P3 *  * -OU\n"
                b += "P+00GI\n"
                b += "P-00GI\n"
            when 92
                b += "P1+OU-KA-KY\n"
                b += "P2 *  *  * \n"
                b += "P3+KY+KA-OU\n"
            when 93
                b += "P1 *  * -KE\n"
                b += "P2+OU * -OU\n"
                b += "P3+KE *  * \n"
                b += "P+00HI\n"
                b += "P-00HI\n"
            when 94
                b += "P1+OU-KE * \n"
                b += "P2 *  *  * \n"
                b += "P3 * +KE-OU\n"
                b += "P+00FU\n"
                b += "P-00FU\n"
            when 95
                b += "P1-KE *  * \n"
                b += "P2-OU * +OU\n"
                b += "P3 *  * +KE\n"
                b += "P+00KA\n"
                b += "P-00KA\n"
            when 96
                b += "P1+KI *  * \n"
                b += "P2+OU * -OU\n"
                b += "P3 *  * -KI\n"
                b += "P+00KY\n"
                b += "P-00KY\n"
            when 97
                b += "P1-KI * -OU\n"
                b += "P2 *  *  * \n"
                b += "P3+OU * +KI\n"
                b += "P+00KY\n"
                b += "P-00KY\n"
            when 98
                b += "P1-KE * -KY\n"
                b += "P2+OU * -OU\n"
                b += "P3+KY * +KE\n"
            when 99
                b += "P1-FU * -OU\n"
                b += "P2 *  *  * \n"
                b += "P3+OU * +FU\n"
                b += "P+00KY\n"
                b += "P-00KY\n"
            when 100
                b += "P1 *  * -OU\n"
                b += "P2+FU * -FU\n"
                b += "P3+OU *  * \n"
                b += "P+00HI\n"
                b += "P-00HI\n"
            when 101
                b += "P1+OU+KA * \n"
                b += "P2 *  *  * \n"
                b += "P3 * -KA-OU\n"
                b += "P+00FU\n"
                b += "P-00FU\n"
            when 102
                b += "P1+OU *  * \n"
                b += "P2-KY * +KY\n"
                b += "P3 *  * -OU\n"
                b += "P+00FU\n"
                b += "P-00FU\n"
            when 103
                b += "P1+GI *  * \n"
                b += "P2+OU * -OU\n"
                b += "P3 *  * -GI\n"
                b += "P+00KE\n"
                b += "P-00KE\n"
            when 104
                b += "P1-OU-KA * \n"
                b += "P2 *  *  * \n"
                b += "P3 * +KA+OU\n"
                b += "P+00KE\n"
                b += "P-00KE\n"
            when 105
                b += "P1 * -KE * \n"
                b += "P2+OU * -OU\n"
                b += "P3 * +KE * \n"
                b += "P+00FU\n"
                b += "P-00FU\n"
            when 106
                b += "P1+GI+OU * \n"
                b += "P2 *  *  * \n"
                b += "P3 * -OU-GI\n"
                b += "P+00FU\n"
                b += "P-00FU\n"
            when 107
                b += "P1-HI *  * \n"
                b += "P2-OU * +OU\n"
                b += "P3 *  * +HI\n"
                b += "P+00FU\n"
                b += "P-00FU\n"
            when 108
                b += "P1-KY-FU * \n"
                b += "P2-OU * +OU\n"
                b += "P3 * +FU+KY\n"
            when 109
                b += "P1 * +OU-KY\n"
                b += "P2 *  *  * \n"
                b += "P3+KY-OU * \n"
                b += "P+00HI\n"
                b += "P-00HI\n"
            when 110
                b += "P1 * +OU * \n"
                b += "P2-KI * +TO\n"
                b += "P3 * -OU * \n"
                b += "P+00KE\n"
                b += "P-00KE\n"
            when 111
                b += "P1 *  * -OU\n"
                b += "P2+HI *  * \n"
                b += "P3+OU * -KA\n"
            when 112
                b += "P1 * +OU-FU\n"
                b += "P2 *  *  * \n"
                b += "P3+FU-OU * \n"
                b += "P+00HI\n"
                b += "P-00HI\n"
            when 113
                b += "P1+KI+OU * \n"
                b += "P2 *  *  * \n"
                b += "P3 * -OU-KI\n"
                b += "P+00KY\n"
                b += "P-00KY\n"
            when 114
                b += "P1-KE *  * \n"
                b += "P2+OU * -OU\n"
                b += "P3 *  * +KE\n"
                b += "P+00GI\n"
                b += "P-00GI\n"
            when 115
                b += "P1+OU * -KY\n"
                b += "P2 *  *  * \n"
                b += "P3+KY * -OU\n"
                b += "P+00GI\n"
                b += "P-00GI\n"
            when 116
                b += "P1-KI * -KE\n"
                b += "P2-OU * +OU\n"
                b += "P3+KE * +KI\n"
            when 117
                b += "P1-KE+OU * \n"
                b += "P2+KI * -KI\n"
                b += "P3 * -OU+KE\n"
            when 118
                b += "P1-KE+OU * \n"
                b += "P2 *  *  * \n"
                b += "P3 * -OU+KE\n"
                b += "P+00FU\n"
                b += "P-00FU\n"
            when 119
                b += "P1-KY-OU * \n"
                b += "P2 *  *  * \n"
                b += "P3 * +OU+KY\n"
                b += "P+00KE\n"
                b += "P-00KE\n"
            when 120
                b += "P1 * -FU * \n"
                b += "P2-OU * +OU\n"
                b += "P3 * +FU * \n"
                b += "P+00KY\n"
                b += "P-00KY\n"
            when 121
                b += "P1-FU+OU * \n"
                b += "P2 *  *  * \n"
                b += "P3 * -OU+FU\n"
                b += "P+00GI\n"
                b += "P-00GI\n"
            when 122
                b += "P1+OU-GI * \n"
                b += "P2 *  *  * \n"
                b += "P3 * +GI-OU\n"
                b += "P+00KY\n"
                b += "P-00KY\n"
            when 123
                b += "P1-GI * -OU\n"
                b += "P2 *  *  * \n"
                b += "P3+OU * +GI\n"
                b += "P+00FU\n"
                b += "P-00FU\n"
            when 124
                b += "P1 * +KA-OU\n"
                b += "P2 *  *  * \n"
                b += "P3+OU-KA * \n"
                b += "P+00KE\n"
                b += "P-00KE\n"
            when 125
                b += "P1+KA * -OU\n"
                b += "P2 *  *  * \n"
                b += "P3+OU * -KA\n"
                b += "P+00KE\n"
                b += "P-00KE\n"
            when 126
                b += "P1+OU-KA * \n"
                b += "P2 *  *  * \n"
                b += "P3 * +KA-OU\n"
                b += "P+00KY\n"
                b += "P-00KY\n"
            when 127
                b += "P1 *  * -OU\n"
                b += "P2-KA * +KA\n"
                b += "P3+OU *  * \n"
                b += "P+00KE\n"
                b += "P-00KE\n"
            when 128
                b += "P1+GI *  * \n"
                b += "P2-OU * +OU\n"
                b += "P3 *  * -GI\n"
                b += "P+00KE\n"
                b += "P-00KE\n"
            when 129
                b += "P1+OU-KE * \n"
                b += "P2 *  *  * \n"
                b += "P3 * +KE-OU\n"
                b += "P+00HI\n"
                b += "P-00HI\n"
            when 130
                b += "P1+OU+KA * \n"
                b += "P2 *  *  * \n"
                b += "P3 * -KA-OU\n"
                b += "P+00KE\n"
                b += "P-00KE\n"
            when 131
                b += "P1+OU * -KE\n"
                b += "P2 *  *  * \n"
                b += "P3+KE * -OU\n"
                b += "P+00HI\n"
                b += "P-00HI\n"
            when 132
                b += "P1+OU *  * \n"
                b += "P2+HI * -HI\n"
                b += "P3 *  * -OU\n"
                b += "P+00GI\n"
                b += "P-00GI\n"
            when 133
                b += "P1+OU *  * \n"
                b += "P2+GI * -GI\n"
                b += "P3 *  * -OU\n"
                b += "P+00HI\n"
                b += "P-00HI\n"
            when 134
                b += "P1+OU *  * \n"
                b += "P2+TO * -TO\n"
                b += "P3 *  * -OU\n"
                b += "P+00HI\n"
                b += "P-00HI\n"
            when 135
                b += "P1+OU *  * \n"
                b += "P2+TO * -TO\n"
                b += "P3 *  * -OU\n"
                b += "P+00KA\n"
                b += "P-00KA\n"
            when 136
                b += "P1+OU *  * \n"
                b += "P2+KI * -KI\n"
                b += "P3 *  * -OU\n"
                b += "P+00KA\n"
                b += "P-00KA\n"
            when 137
                b += "P1+OU+KI * \n"
                b += "P2 *  *  * \n"
                b += "P3 * -KI-OU\n"
                b += "P+00KA\n"
                b += "P-00KA\n"
            when 138
                b += "P1+OU+TO * \n"
                b += "P2 *  *  * \n"
                b += "P3 * -TO-OU\n"
                b += "P+00KA\n"
                b += "P-00KA\n"
            when 139
                b += "P1+OU * -KI\n"
                b += "P2 *  *  * \n"
                b += "P3+KI * -OU\n"
                b += "P+00HI\n"
                b += "P-00HI\n"
            when 140
                b += "P1+OU * -TO\n"
                b += "P2 *  *  * \n"
                b += "P3+TO * -OU\n"
                b += "P+00HI\n"
                b += "P-00HI\n"
            else
                b += "P1 *  * -OU\n"
                b += "P2 *  *  * \n"
                b += "P3+OU *  * \n"
                b += "P+00GI00FU\n"
                b += "P-00GI00FU\n"
        return b
