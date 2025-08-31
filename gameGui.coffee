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
    @getImg: (piece, fonts) ->
        ret = ""
        switch piece.name
            when "Ou"
                if piece.turn == Const.FIRST
                    if fonts == 1 then ret = "./img/f_ou_m.svg" else ret = "./img/f_ou.svg"
                else
                    if fonts == 1 then ret = "./img/s_ou_m.svg" else ret = "./img/s_ou.svg"
            when "Hi"
                if piece.status == Const.Status.URA
                    if piece.turn == Const.FIRST
                        if fonts == 1 then ret = "./img/f_ry_m.svg" else ret = "./img/f_ry.svg"
                    else
                        if fonts == 1 then ret = "./img/s_ry_m.svg" else ret = "./img/s_ry.svg"
                else
                    if piece.turn == Const.FIRST
                        if fonts == 1 then ret = "./img/f_hi_m.svg" else ret = "./img/f_hi.svg"
                    else
                        if fonts == 1 then ret = "./img/s_hi_m.svg" else ret = "./img/s_hi.svg"
            when "Ka"
                if piece.status == Const.Status.URA
                    if piece.turn == Const.FIRST
                        if fonts == 1 then ret = "./img/f_um_m.svg" else ret = "./img/f_um.svg"
                    else
                        if fonts == 1 then ret = "./img/s_um_m.svg" else ret = "./img/s_um.svg"
                else
                    if piece.turn == Const.FIRST
                        if fonts == 1 then ret = "./img/f_ka_m.svg" else ret = "./img/f_ka.svg"
                    else
                        if fonts == 1 then ret = "./img/s_ka_m.svg" else ret = "./img/s_ka.svg"
            when "Ki"
                if piece.turn == Const.FIRST
                    if fonts == 1 then ret = "./img/f_ki_m.svg" else ret = "./img/f_ki.svg"
                else
                    if fonts == 1 then ret = "./img/s_ki_m.svg" else ret = "./img/s_ki.svg"
            when "Gi"
                if piece.status == Const.Status.URA
                    if piece.turn == Const.FIRST
                        if fonts == 1 then ret = "./img/f_ng_m.svg" else ret = "./img/f_ng.svg"
                    else
                        if fonts == 1 then ret = "./img/s_ng_m.svg" else ret = "./img/s_ng.svg"
                else
                    if piece.turn == Const.FIRST
                        if fonts == 1 then ret = "./img/f_gi_m.svg" else ret = "./img/f_gi.svg"
                    else
                        if fonts == 1 then ret = "./img/s_gi_m.svg" else ret = "./img/s_gi.svg"
            when "Ke"
                if piece.status == Const.Status.URA
                    if piece.turn == Const.FIRST
                        if fonts == 1 then ret = "./img/f_nk_m.svg" else ret = "./img/f_nk.svg"
                    else
                        if fonts == 1 then ret = "./img/s_nk_m.svg" else ret = "./img/s_nk.svg"
                else
                    if piece.turn == Const.FIRST
                        if fonts == 1 then ret = "./img/f_ke_m.svg" else ret = "./img/f_ke.svg"
                    else
                        if fonts == 1 then ret = "./img/s_ke_m.svg" else ret = "./img/s_ke.svg"
            when "Ky"
                if piece.status == Const.Status.URA
                    if piece.turn == Const.FIRST
                        if fonts == 1 then ret = "./img/f_ny_m.svg" else ret = "./img/f_ny.svg"
                    else
                        if fonts == 1 then ret = "./img/s_ny_m.svg" else ret = "./img/s_ny.svg"
                else
                    if piece.turn == Const.FIRST
                        if fonts == 1 then ret = "./img/f_ky_m.svg" else ret = "./img/f_ky.svg"
                    else
                        if fonts == 1 then ret = "./img/s_ky_m.svg" else ret = "./img/s_ky.svg"
            when "Fu"
                if piece.status == Const.Status.URA
                    if piece.turn == Const.FIRST
                        if fonts == 1 then ret = "./img/f_to_m.svg" else ret = "./img/f_to.svg"
                    else
                        if fonts == 1 then ret = "./img/s_to_m.svg" else ret = "./img/s_to.svg"
                else
                    if piece.turn == Const.FIRST
                        if fonts == 1 then ret = "./img/f_fu_m.svg" else ret = "./img/f_fu.svg"
                    else
                        if fonts == 1 then ret = "./img/s_fu_m.svg" else ret = "./img/s_fu.svg"
        return ret

    @appLocalize: ->
        lng = ''
        lng = localStorage.getItem('appLanguage')
        if !lng
            lng = 'ja'
        i18next.use(i18nextSprintfPostProcessor).init
            lng: lng
            fallbackLng: 'en'
            debug: true
            resources:
                en: translation:
                    title: '33 Shogi（3x3 shogi）'
                    btn_first: 'Black'
                    btn_second: 'White'
                    btn_start: 'New Game'
                    btn_stop: 'Interrupt'
                    btn_search: 'Search'
                    menu_title: 'Settings'
                    menu_turn: 'Turn / AI Level'
                    menu_first: 'Black'
                    menu_second: 'White'
                    menu_person: 'Man'
                    menu_ai: 'AI'
                    menu_level: 'AI Level'
                    menu_beginner: 'Novice'
                    menu_average: 'Intermediate'
                    menu_longtime: 'Senior'
                    menu_meditation: 'Expert'
                    menu_fonts: 'Fonts for Pieces'
                    menu_fonts_standard: 'sans-serif'
                    menu_fonts_kouzan: 'serif'
                    menu_placement: 'Initial Placement'
                    menu_about: 'About 33 Shogi'
                    menu_search: 'Arrangement Search'
                    menu_pieces: 'Select Pieces:'
                    menu_movement: 'Movement of piece'
                    menu_guide: 'Display movement guide'
                    menu_kifuinput: 'Input Record'
                    menu_btninput: 'Reading'
                    menu_kifudata: 'Please paste the record of CSA format (*.csa):'
                    dlg_promote: 'Promote?'
                    dlg_promote_yes: 'Promote'
                    dlg_promote_no: 'Not promote'
                    dlg_check: 'The king is in check!'
                    dlg_utifudume: 'Utifudume!'
                    msgBlack: 'Black'
                    msgWhite: 'White'
                    msgTurn: '%s turn '
                    msgEvaluate: '(Evaluation: %s)'
                    msgWinner: '%s Win'
                    msgRestart: 'Restart'
                    msgInterrupt: 'Interrupt'
                    msgFirstWin: 'Black Win'
                    msgSecondWin: 'White Win'
                    msgSennitite: 'Repetition Draw'
                    msgThinking: 'thinking...'
                    dlg2_exitTitle: 'Application Menu'
                    dlg2_exitItemYes: 'Exit'
                    dlg2_exitItemNo: 'Cancel'
                    dlg2_exit: 'Exit Application ?'
                    koma_front: '&emsp;Front&emsp;<br />Symbol'
                    koma_front_moves: 'Moves'
                    koma_back: 'Back(Promoted)<br />Symbol'
                    koma_back_moves: 'Moves'
                    koma_gyoku: '<img class="first" src="./img/f_ou.svg" alt=""><br />OU'
                    koma_hisya: '<img class="first" src="./img/f_hi.svg" alt=""><br />HI'
                    koma_ryu: '<img class="first" src="./img/f_ry.svg" alt=""><br />RY'
                    koma_kaku: '<img class="first" src="./img/f_ka.svg" alt=""><br />KA'
                    koma_uma: '<img class="first" src="./img/f_um.svg" alt=""><br />UM'
                    koma_kin: '<img class="first" src="./img/f_ki.svg" alt=""><br />KI'
                    koma_gin: '<img class="first" src="./img/f_gi.svg" alt=""><br />GI'
                    koma_narigin: '<img class="first" src="./img/f_ng.svg" alt=""><br />NG'
                    koma_keima: '<img class="first" src="./img/f_ke.svg" alt=""><br />KE'
                    koma_narikei: '<img class="first" src="./img/f_nk.svg" alt=""><br />NK'
                    koma_kyosya: '<img class="first" src="./img/f_ky.svg" alt=""><br />KY'
                    koma_narikyo: '<img class="first" src="./img/f_ny.svg" alt=""><br />NY'
                    koma_fu: '<img class="first" src="./img/f_fu.svg" alt=""><br />FU'
                    koma_tokin: '<img class="first" src="./img/f_to.svg" alt=""><br />TO'
                    menu_description_html: 'It is a mini Shogi playing on 3x3 board. Rules are also almost the same as Shogi.<br />&nbsp;I think that you can enjoy enough if you are a beginner in Shogi. You can also play with other people, so please try and enjoy Shogi`s various changes.<br />&nbsp;For detailed specifications please see <a href="https://happyclam.github.io/project/2018-01-01/33shogiapp"> blog post </a>. We used a free font <a href="https://forest.watch.impress.co.jp/library/software/aoyagifont/">"Kouzan brush pen font"</a> owned by <a href="http://www7a.biglobe.ne.jp/~kouzan/">"Aoyagi Kouzan"</a> who can redistribute it.',
                    btn_save: 'Save Pattern',
                    btn_cancel: 'Cancel',
                    msg_save: 'Saved',
                    msg_save_error: 'Saving failed',
                    msg_over_king: 'Each side needs only one king.',
                    msg_no_king: 'Two kings are required.'
                es: translation:
                    title: '33 Shogi（3x3 shogi）'
                    btn_first: 'Negro'
                    btn_second: 'Blanco'
                    btn_start: 'Nuevo juego'
                    btn_stop: 'Interrumpir'
                    btn_search: 'Buscar'
                    menu_title: 'Ajuste'
                    menu_turn: 'Giro / Nivel AI'
                    menu_first: 'Negro'
                    menu_second: 'Blanco'
                    menu_person: 'Humano'
                    menu_ai: 'AI'
                    menu_level: 'Nivel AI'
                    menu_beginner: 'Principiante'
                    menu_average: 'Intermedio'
                    menu_longtime: 'Mayor'
                    menu_meditation: 'Experto'
                    menu_fonts: 'Fuentes para piezas'
                    menu_fonts_standard: 'sans-serif'
                    menu_fonts_kouzan: 'sans-serif'
                    menu_placement: 'Colocación inicial'
                    menu_about: 'Cerca de 33 Shogi'
                    menu_search: 'Búsqueda de arreglos'
                    menu_pieces: 'Seleccionar piezas:'
                    menu_movement: 'Movimiento de pieza'
                    menu_guide: 'Pantalla de guía de movimiento'
                    menu_kifuinput: 'Registro de entrada'
                    menu_btninput: 'Leyendo'
                    menu_kifudata: 'Por favor, pegue el registro de formato CSA (* .csa):'
                    dlg_promote: '¿Promover'
                    dlg_promote_yes: 'Promover'
                    dlg_promote_no: 'No promocionar'
                    dlg_check: '¡El rey está en jaque'
                    dlg_utifudume: '¡Utifudume'
                    msgBlack: 'Negra'
                    msgWhite: 'Blanca'
                    msgTurn: 'Turno %s '
                    msgEvaluate: '(Evaluación: %s)'
                    msgWinner: 'Victoria %s'
                    msgRestart: 'Reinciar'
                    msgInterrupt: 'Interrumpir'
                    msgFirstWin: 'Victoria negra'
                    msgSecondWin: 'Victoria blanca'
                    msgSennitite: 'Dibujo de repetición'
                    msgThinking: 'Pensando...'
                    dlg2_exitTitle: 'Menú de aplicación'
                    dlg2_exitItemYes: 'Salida'
                    dlg2_exitItemNo: 'Cancelar'
                    dlg2_exit: '¿Salir de la aplicación'
                    koma_front: '&emsp;Frente&emsp;<br />Símbolo'
                    koma_front_moves: 'Movimiento'
                    koma_back: 'Atrás(Promovido)<br />Símbolo'
                    koma_back_moves: 'Movimiento'
                    koma_gyoku: '<img class="first" src="./img/f_ou.svg" alt=""><br />OU'
                    koma_hisya: '<img class="first" src="./img/f_hi.svg" alt=""><br />HI'
                    koma_ryu: '<img class="first" src="./img/f_ry.svg" alt=""><br />RY'
                    koma_kaku: '<img class="first" src="./img/f_ka.svg" alt=""><br />KA'
                    koma_uma: '<img class="first" src="./img/f_um.svg" alt=""><br />UM'
                    koma_kin: '<img class="first" src="./img/f_ki.svg" alt=""><br />KI'
                    koma_gin: '<img class="first" src="./img/f_gi.svg" alt=""><br />GI'
                    koma_narigin: '<img class="first" src="./img/f_ng.svg" alt=""><br />NG'
                    koma_keima: '<img class="first" src="./img/f_ke.svg" alt=""><br />KE'
                    koma_narikei: '<img class="first" src="./img/f_nk.svg" alt=""><br />NK'
                    koma_kyosya: '<img class="first" src="./img/f_ky.svg" alt=""><br />KY'
                    koma_narikyo: '<img class="first" src="./img/f_ny.svg" alt=""><br />NY'
                    koma_fu: '<img class="first" src="./img/f_fu.svg" alt=""><br />FU'
                    koma_tokin: '<img class="first" src="./img/f_to.svg" alt=""><br />TO'
                    menu_description_html: 'Es un mini shogi jugando en un tablero de 3x3. Las reglas también son casi las mismas que Shogi. <br /> &nbsp; Creo que puedes disfrutar lo suficiente si eres un principiante en Shogi. También puedes jugar con otras personas, así que prueba y disfruta los diversos cambios de Shogi. <br /> & nbsp; Para obtener especificaciones detalladas, consulta <a href = "https://happyclam.github.io/project/2018-01-01/33shogiapp"> publicación de blog </a>. Utilizamos una fuente gratuita <a href="https://forest.watch.impress.co.jp/library/software/aoyagifont/">"Kouzan brush pen font"</a> propiedad de <a href="http://www7a.biglobe.ne.jp/~kouzan/">"Aoyagi Kouzan"</a> que puede redistribuirla.',
                    btn_save: 'Guardar patrón',
                    btn_cancel: 'Cancelar',
                    msg_save: 'Guardado',
                    msg_save_error: 'Error al guardar',
                    msg_over_king: 'Cada lado necesita solo un rey.',
                    msg_no_king: 'Se requieren dos reyes.'
                zh: translation:
                    title: '三將棋（3x3 shogi）'
                    btn_first: '先手'
                    btn_second: '后手'
                    btn_start: '新遊戲'
                    btn_stop: '中斷'
                    btn_search: '搜索'
                    menu_title: '設置'
                    menu_turn: '先手・后手／AI級別'
                    menu_first: '先手'
                    menu_second: '后手'
                    menu_person: '人'
                    menu_ai: 'AI'
                    menu_level: 'AI級別'
                    menu_beginner: '新手'
                    menu_average: '中間'
                    menu_longtime: '高級'
                    menu_meditation: '專家'
                    menu_fonts: '件的字體'
                    menu_fonts_standard: '無襯線'
                    menu_fonts_kouzan: '襯線'
                    menu_placement: '初始安置'
                    menu_about: '關於三將棋'
                    menu_search: '初始安置搜索'
                    menu_pieces: '選擇棋子:'
                    menu_movement: '片斷的運動'
                    menu_guide: '顯示件的運動指南'
                    menu_kifuinput: '輸入記錄'
                    menu_btninput: '讀'
                    menu_kifudata: '請粘貼CSA格式的記錄（* .csa）：'
                    dlg_promote: '被翻过来？'
                    dlg_promote_yes: '被翻'
                    dlg_promote_no: '不被翻'
                    dlg_check: '將在檢查！'
                    dlg_utifudume: '放下典當是犯規的！'
                    msgBlack: '先手'
                    msgWhite: '后手'
                    msgTurn: '%s的順序'
                    msgEvaluate: '（評估價值: %s）'
                    msgWinner: '勝利是%s'
                    msgRestart: '重新開始'
                    msgInterrupt: '中断'
                    msgFirstWin: '勝利是先手'
                    msgSecondWin: '勝利是后手'
                    msgSennitite: '和棋'
                    msgThinking: '思維...'
                    dlg2_exitTitle: '应用菜单子'
                    dlg2_exitItemYes: '结束'
                    dlg2_exitItemNo: '取消'
                    dlg2_exit: '要结束应用？'
                    koma_front: '&emsp;&emsp;面前&emsp;&emsp;<br />縮略語'
                    koma_front_moves: '運動'
                    koma_back: '背部（被翻）　<br />縮略語'
                    koma_back_moves: '運動'
                    koma_gyoku: '<img class="first" src="./img/f_ou.svg" alt=""><br />OU'
                    koma_hisya: '<img class="first" src="./img/f_hi.svg" alt=""><br />HI'
                    koma_ryu: '<img class="first" src="./img/f_ry.svg" alt=""><br />RY'
                    koma_kaku: '<img class="first" src="./img/f_ka.svg" alt=""><br />KA'
                    koma_uma: '<img class="first" src="./img/f_um.svg" alt=""><br />UM'
                    koma_kin: '<img class="first" src="./img/f_ki.svg" alt=""><br />KI'
                    koma_gin: '<img class="first" src="./img/f_gi.svg" alt=""><br />GI'
                    koma_narigin: '<img class="first" src="./img/f_ng.svg" alt=""><br />NG'
                    koma_keima: '<img class="first" src="./img/f_ke.svg" alt=""><br />KE'
                    koma_narikei: '<img class="first" src="./img/f_nk.svg" alt=""><br />NK'
                    koma_kyosya: '<img class="first" src="./img/f_ky.svg" alt=""><br />KY'
                    koma_narikyo: '<img class="first" src="./img/f_ny.svg" alt=""><br />NY'
                    koma_fu: '<img class="first" src="./img/f_fu.svg" alt=""><br />FU'
                    koma_tokin: '<img class="first" src="./img/f_to.svg" alt=""><br />TO'
                    menu_description_html: '這是一個在3x3板上玩的迷你日本象棋。 規則也與日本象棋幾乎相同。<br />我認為如果你是日本象棋的初學者，你可以享受足夠的樂趣。 您也可以和其他人一起玩，所以請嘗試享受日本象棋的各種變化。<br />&nbsp;有關詳細規格，請參閱<a href =“https://happyclam.github.io/project/2018-01-01/33shogiapp“>博客文章</a>。我們使用了<a href="https://forest.watch.impress.co.jp/library/software/aoyagifont/">"Kouzan brush pen font"</a>擁有的免費字體<a href="http://www7a.biglobe.ne.jp/~kouzan/">"Aoyagi Kouzan"</a>，可以重新發布它。',
                    btn_save: '保存模式',
                    btn_cancel: '取消',
                    msg_save: '已保存',
                    msg_save_error: '保存失敗',
                    msg_over_king: '每一方只需要一位國王。',
                    msg_no_king: '需要兩個國王。'
                ja: translation:
                    title: '３三将棋（3x3 shogi）'
                    btn_first: '先手'
                    btn_second: '後手'
                    btn_start: '新規対局'
                    btn_stop: '中断'
                    btn_search: '検索'
                    menu_title: '設定'
                    menu_turn: '先手・後手／ＡＩレベル'
                    menu_first: '先手'
                    menu_second: '後手'
                    menu_person: '人'
                    menu_ai: 'ＡＩ'
                    menu_level: 'ＡＩレベル'
                    menu_beginner: '弱い'
                    menu_average: '普通'
                    menu_longtime: '長考'
                    menu_meditation: '瞑想'
                    menu_fonts: '駒のフォント'
                    menu_fonts_standard: 'ゴシック体'
                    menu_fonts_kouzan: '毛筆体'
                    menu_placement: '初期配置'
                    menu_about: '「３三将棋」について'
                    menu_search: '初期配置検索'
                    menu_pieces: '使用されている駒を選択:'
                    menu_movement: '駒の動き'
                    menu_guide: '駒の移動ガイドを表示する'
                    menu_kifuinput: '棋譜入力'
                    menu_btninput: '棋譜読込'
                    menu_kifudata: 'CSA形式(*.csa)の棋譜を貼り付けてください:'
                    dlg_promote: '成りますか？'
                    dlg_promote_yes: '成る'
                    dlg_promote_no: '成らない'
                    dlg_check: '玉が取られてしまいます'
                    dlg_utifudume: '打ち歩詰めです'
                    msgBlack: '先手'
                    msgWhite: '後手'
                    msgTurn: '%sの番です'
                    msgEvaluate: '（評価値: %s）'
                    msgWinner: '%sの勝ちです'
                    msgRestart: '再開'
                    msgInterrupt: '中断'
                    msgFirstWin: '先手の勝ちです'
                    msgSecondWin: '後手の勝ちです'
                    msgSennitite: '千日手です'
                    msgThinking: '考え中...'
                    dlg2_exitTitle: '終了メニュー'
                    dlg2_exitItemYes: '終了'
                    dlg2_exitItemNo: 'キャンセル'
                    dlg2_exit: 'アプリを終了しますか？'
                    koma_front: '&emsp;&emsp;表&emsp;&emsp;<br />略号'
                    koma_front_moves: '動き'
                    koma_back: '　裏（成駒）　<br />略号'
                    koma_back_moves: '動き'
                    koma_gyoku: '<img class="first" src="./img/f_ou.svg" alt=""><br />OU'
                    koma_hisya: '<img class="first" src="./img/f_hi.svg" alt=""><br />HI'
                    koma_ryu: '<img class="first" src="./img/f_ry.svg" alt=""><br />RY'
                    koma_kaku: '<img class="first" src="./img/f_ka.svg" alt=""><br />KA'
                    koma_uma: '<img class="first" src="./img/f_um.svg" alt=""><br />UM'
                    koma_kin: '<img class="first" src="./img/f_ki.svg" alt=""><br />KI'
                    koma_gin: '<img class="first" src="./img/f_gi.svg" alt=""><br />GI'
                    koma_narigin: '<img class="first" src="./img/f_ng.svg" alt=""><br />NG'
                    koma_keima: '<img class="first" src="./img/f_ke.svg" alt=""><br />KE'
                    koma_narikei: '<img class="first" src="./img/f_nk.svg" alt=""><br />NK'
                    koma_kyosya: '<img class="first" src="./img/f_ky.svg" alt=""><br />KY'
                    koma_narikyo: '<img class="first" src="./img/f_ny.svg" alt=""><br />NY'
                    koma_fu: '<img class="first" src="./img/f_fu.svg" alt=""><br />FU'
                    koma_tokin: '<img class="first" src="./img/f_to.svg" alt=""><br />TO'
                    menu_description_html: '　３×３の盤で遊ぶミニ将棋です。ルールも将棋とほぼ同じで二歩や打ち歩詰めの反則手は指せないようになっており千日手成立でゲームを中断するようにしています。通常の将棋では敵陣（３段目）に駒を移動した場合に駒を成ることが出来ますが、３三将棋では１段目（後手は３段目）に移動したり、１段目（後手は３段目）から移動する時に駒を成ることが出来ます。将棋のルールを知っている方であればすぐに遊ぶことができると思います。ネットの情報によると、本来の３三将棋は盤上に二つの玉を配置して先手・後手双方が銀と歩の持ち駒を一枚ずつ持って対戦するようですが、他にも初形パターンをいろいろ用意してみました。<br />　ＡＩは駒得重視の思考ルーチンでそれほど強くありませんが、将棋初心者の方なら十分楽しめると思います。人対人で遊ぶことも出来ますので是非いろいろな変化を楽しんでみてください。詳しい仕様については<a href="https://happyclam.github.io/project/2018-01-01/33shogiapp">ブログ記事</a>を参照してください。<br />将棋の駒に再配布可能な<a href="http://www7a.biglobe.ne.jp/~kouzan/">「青柳衡山」様</a>の<a href="https://forest.watch.impress.co.jp/library/software/aoyagifont/">「衡山毛筆フォント」</a>を利用させていただいてます。',
                    btn_save: '初期配置保存',
                    btn_cancel: '中止',
                    msg_save: '保存しました',
                    msg_save_error: '保存に失敗しました',
                    msg_over_king: '王と玉は一つまでです',
                    msg_no_king: '王と玉は必須です'
        # console.log '=== lng = ' + lng
        $ ->
            jqueryI18next.init i18next, $
            $('#home').localize()
            $('#win_menu').localize()
            # $('#popupNari').localize()
            # $('#popupCheckLeft').localize()
            $('[id=btnStart]').val(i18next.t('btn_start')).button 'refresh'
            $('[id=btnStop]').val(i18next.t('btn_stop')).button 'refresh'
            $('[id=btnSave]').val(i18next.t('btn_save')).button().button 'refresh'
            $('[id=btnCancel]').val(i18next.t('btn_cancel')).button().button 'refresh'
            return

    constructor: ->
        super()
        # console.log("BoardGUI.constructor")
        @width = 0
        @height = 0
        # @statusarea = null
        @fonts = 0
        @latest = []
    display: (rev = false, id = null, searched = null) ->
        # console.log("BoardGUI.display")
        if rev
            $("#surface").hide()
            $("#reverse").show()
            clsFName = 'firstR'
            clsSName = 'secondR'
        else
            $("#reverse").hide()
            $("#surface").show()
            clsFName = 'first'
            clsSName = 'second'

        if id == null
            ids = ""
        else
            if searched == null
                ids = "_" + id.toString()
            else
                ids = "_" + searched.toString()
        s_motigoma = {"Hi": 0, "Ka": 0, "Ki": 0, "Gi": 0, "Ke": 0, "Ky": 0, "Fu": 0}
        for v,i in @pieces when v.turn == Const.SECOND && v.status == Const.Status.MOTIGOMA
            s_motigoma[v.name] += 1
        if id == null
            for k,v of s_motigoma
                $('[id=s' + k + ids + ']').text(v.toString())
        else
            html = '<div id="btnSecond" class="ui-btn ui-no-icon ui-alt-icon ui-mini ui-nodisc-icon ui-btn-icon-right ui-btn-inline"><b>' + i18next.t('menu_second') + '</b></div>'
            if searched == null
                $('#group_s' + ids).html(html)
            else
                $('#search_s' + ids).html(html)
            for k,v of s_motigoma
                if v > 0
                    html = '<div class="ui-btn ui-icon-s' + k.toLowerCase() + ' ui-mini ui-nodisc-icon ui-btn-icon-left ui-btn-inline">' + v + '</div>'
                    if searched == null
                        $('#group_s' + ids).append(html)
                    else
                        $('#search_s' + ids).append(html)
        for row in [1..@rows]
            for col in [@cols..1] by -1
                $('[id=b' + row.toString() + col.toString() + ']').css('background-color', '#FFFACD')
                $('[id=b' + row.toString() + col.toString() + ']').css('border-style', 'solid')
                koma = (v for v in @pieces when v.posi? && v.posi.toString() == [col, row].toString())[0]
                if koma?
                    replace_src = BoardGUI.getImg(koma, @fonts)
                    replace_alt = koma.caption()
                    replace_class = if koma.turn == Const.FIRST then clsFName else clsSName
                    if searched == null
                        $('[id=b' + koma.posi[0] + koma.posi[1] + ids + ']').children('img').attr('src': replace_src, 'alt': replace_alt, 'class': replace_class)
                else
                    $('[id=b' + col + row + ids + ']').children('img').attr('src': './img/empty.svg', 'class': 'empty')
        $('[id=b' + @latest[0] + @latest[1] + ']').css('border-style', 'dashed') if @latest? && @latest.length == 2
        f_motigoma = {"Hi": 0, "Ka": 0, "Ki": 0, "Gi": 0, "Ke": 0, "Ky": 0, "Fu": 0}
        for v,i in @pieces when v.turn == Const.FIRST && v.status == Const.Status.MOTIGOMA
            f_motigoma[v.name] += 1
        if id == null
            for k,v of f_motigoma
                $('[id=f' + k + ids + ']').text(v.toString())
        else
            html = '<div id="btnFirst" class="ui-btn ui-no-icon ui-alt-icon ui-mini ui-nodisc-icon ui-btn-icon-right ui-btn-inline"><b>' + i18next.t('menu_first') + '</b></div>'
            if searched == null
                $('#group_f' + ids).html(html)
            else
                $('#search_f' + ids).html(html)
            for k,v of f_motigoma
                if v > 0
                    html = '<div class="ui-btn ui-icon-f' + k.toLowerCase() + ' ui-mini ui-nodisc-icon ui-btn-icon-left ui-btn-inline">' + v + '</div>'
                    if searched == null
                        $('#group_f' + ids).append(html)
                    else
                        $('#search_f' + ids).append(html)
        return

    # init: ->
    #     @statusarea = document.getElementById("spanStatus")

class State
    constructor:(@turn, @status, @posi = []) ->

class GameGUI
    # 同じ駒が複数使用されていることもあるので座標も含めてソート
    _sortCoordinate = (a, b) ->
        kinds = ["Fu", "Ky", "Ke", "Gi", "Ki", "Ka", "Hi", "Ou"]
        return kinds.indexOf(a["kind"]) - kinds.indexOf(b["kind"]) || a["turn"] - b["turn"] || a["status"] - b["status"] || a["posi0"] - b["posi0"] || a["posi1"] - b["posi1"]
    # 局面を比較するためHashを生成
    @make_hash = (board) ->
        rec = []
        for koma in board.pieces
            buf = {}
            buf["kind"] = koma.name
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
        @edit_flg = false
        @history = []; @seq = null
        @duplication = []
        @first_player = null; @second_player = null;
        @check_guide = null;
        @reverse = null;
        @radio_arrange = null;@radio_depth_f = null;@radio_depth_s = null;
        @radio_fonts = null
        @first = new Player(Const.FIRST, true, 3)
        @second = new Player(Const.SECOND, true, 3)
        @teban = @first
        @label_idx = 0
        @searchList = []; @searchResult = []
        @board = new BoardGUI(); @bkup = new BoardGUI()
        @md5hash = null
        @setEventListener()
        @originalBoardImage = ""
        @radioNo = -1
    viewState: ->
        # console.log("viewState")
        for v,i in @board.pieces
            v.turn = @history[@seq]["board"][i].turn
            v.status = @history[@seq]["board"][i].status
            v.posi = @history[@seq]["board"][i].posi
        $('[id=naviSeq]').text(@seq.toString())
        @board.latest = @history[@seq]["latest"]; @board.display(@reverse)
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
        $('[id=naviSeq]').text((@history.length - 1).toString())
        return
    makeRecord: ->
        # console.log("GameGUI.makeRecord")
        converted = @convert()
        linkStr = "https://play.google.com/store/apps/details?id=shogi33.io.github.happyclam"
        window.plugins.socialsharing.share('\' #３三将棋 ' + linkStr + ' \n' + converted, 'shogi33', null, null)
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
            for v,i in buf
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
                        if v.length == 1
                            @addState()
                            continue
                        from = [v[1], v[2]].map(Number)
                        turn = if v[0] == "+" then Const.FIRST else Const.SECOND
                        if v[1..2] == "00"
                            koma = (w for w in @board.pieces when w.posi.length == 0 && w.turn == turn && w.koma() == v[5..6])
                        else
                            koma = (w for w in @board.pieces when w.posi? && w.turn == turn && w.posi[0] == from[0] && w.posi[1] == from[1])
                        throw "05:Line = #{i + 1}: #{v}" if koma.length == 0
                        to = [v[3], v[4]].map(Number)
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
                @kifustatus.innerHTML = ""
                return true

    # ゲーム開始毎
    prepare: ->
        # console.log("GameGUI.prepare")
        @interrupt_flg = false; @auto_flg = false
        @history = []
        @duplication = []
        @seq = 0
        $('[id=naviSeq]').text('')
        $('#panelSave').hide()
        $('[id=naviA]').hide()
        $('[id=spanStatus]').html(i18next.t('msgTurn', {postProcess: 'sprintf', sprintf: [i18next.t('msgBlack')]}))
        @teban = @first
        radio_checked = (v for v in @radio_arrange when v.checked == true)[0]
        $('[id=patternNo]').text(radio_checked.value)
        @radioNo = parseInt(radio_checked.value|0, 10)
        launch.call @, @radioNo
        # 初期配置No.を@history[0]に保存することにした
        # 棋譜出力の際に実際の棋譜とラジオボタンの選択が相違していることがあるため
        @board.latest = []
        @addState(null, @radioNo)
        @board.display(@reverse)
        try
            @first_player.selectedIndex = parseInt(localStorage.getItem("first_player33")|0, 10)
            @second_player.selectedIndex = parseInt(localStorage.getItem("second_player33")|0, 10)
        catch err
            @first_player.selectedIndex = 0
            @second_player.selectedIndex = 0
        @first.human = if @first_player.selectedIndex == 1 then false else true
        @second.human = if @second_player.selectedIndex == 1 then false else true

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
        for i in [1,2,4,player.depth].unique()
            temp = []
            if i >= 6
                temp = player.prepare(@board, oppo, i, threshold)
            else
                player.pre_ahead = 0; oppo.pre_ahead = 0
                temp = player.think(@board, oppo, i, threshold)
            if @interrupt_flg
                @auto_flg = false
                $('[id=spanStatus]').html("")
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
                @board.latest = ret[1]; @board.display(@reverse)
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
            if @history[0]["latest"]?
                @writeFile(Const.TEMP_HISTORY, @history);@writeFile(Const.TEMP_DUPLICATION, @duplication)
            if @sennitite(@md5hash)
                @board.latest = ret[1]; @board.display(@reverse)
                @auto_flg = false
                return
            @teban = if (@seq % 2) == 0 then @first else @second
            if @teban.turn == Const.FIRST
                msgStr = i18next.t('msgTurn', {postProcess: 'sprintf', sprintf: [i18next.t('msgBlack')]})
                $('[id=spanStatus]').html(msgStr)
            else
                msgStr = i18next.t('msgTurn', {postProcess: 'sprintf', sprintf: [i18next.t('msgWhite')]})
                $('[id=spanStatus]').html(msgStr)
            $('[id=spanStatus]').html(msgStr + i18next.t('msgEvaluate', {postProcess: 'sprintf', sprintf: [ret[2].toString()]}))
        else
            if @teban.turn == Const.FIRST
                msgStr = i18next.t('msgWinner', {postProcess: 'sprintf', sprintf: [i18next.t('msgWhite')]})
                $('[id=spanStatus]').html(msgStr)
            else
                msgStr = i18next.t('msgWinner', {postProcess: 'sprintf', sprintf: [i18next.t('msgBlack')]})
                $('[id=spanStatus]').html(msgStr)
            $("[id=btnStart]").prop("disabled", false);@startbtn = false; $("[id=btnStop]").val(i18next.t('msgRestart')).button("refresh")
            $('[id=naviA]').show()
            @auto_flg = false
            return
        @board.latest = ret[1]; @board.display(@reverse)
        if @interrupt_flg
            @auto_flg = false
            $('[id=spanStatus]').html("")
            return
        else
            if @auto_flg
                setTimeout (=>
                    @auto_battle(@seq)
                    ), 1000
        return

    serverMsg: ->
        lng = localStorage.getItem("appLanguage")
        msg = JSON.parse(localStorage.getItem("serverMsg33"))
        toast.call @, msg["#{lng}"]
        return

    # 起動時
    init: ->
        # console.log("GameGUI.init")
        @startbtn = null
        @first_player = document.getElementById("first_player")
        @second_player = document.getElementById("second_player")
        @radio_arrange = document.getElementsByName("radio-arrange")
        @radio_depth_f = document.getElementsByName("f-radio-depth")
        @radio_depth_s = document.getElementsByName("s-radio-depth")
        @radio_fonts = document.getElementsByName("radio-fonts")
        @kifustatus = document.getElementById("kifuStatus")
        # @naviA = document.getElementById("naviA")
        # @naviA.style.display = "none"
        try
            @reverse = false
            temp = JSON.parse(localStorage.getItem("movement_guide33"))
            if temp == false
                @check_guide = false
                $("#check-guide").prop("checked", false)
            else
                @check_guide = true
                $("#check-guide").prop("checked", true)
            @first_player.selectedIndex = parseInt(localStorage.getItem("first_player33")|0, 10)
            @second_player.selectedIndex = parseInt(localStorage.getItem("second_player33")|0, 10)
            idx = parseInt(localStorage.getItem("radio-arrange")|0, 10)
            @radio_arrange[idx].checked = true
            radio_checked = (v for v in @radio_arrange when v.checked == true)[0]
            $('[id=patternNo]').text(radio_checked.value)
            depth_f = parseInt(localStorage.getItem("f-radio-depth33")|0, 10)
            depth_s = parseInt(localStorage.getItem("s-radio-depth33")|0, 10)
            if depth_f == 3
                @radio_depth_f[3].checked = true
                @first.depth = 9; @first.pre_select = 4
            else if depth_f == 2
                @radio_depth_f[2].checked = true
                @first.depth = 8; @first.pre_select = 4
            else if depth_f == 1
                @radio_depth_f[1].checked = true
                @first.depth = 6; @first.pre_select = 4
            else
                @radio_depth_f[0].checked = true
                @first.depth = 4; @first.pre_select = 4
            if depth_s == 3
                @radio_depth_s[3].checked = true
                @second.depth = 9; @second.pre_select = 4
            else if depth_s == 2
                @radio_depth_s[2].checked = true
                @second.depth = 8; @second.pre_select = 4
            else if depth_s == 1
                @radio_depth_s[1].checked = true
                @second.depth = 6; @second.pre_select = 4
            else
                @radio_depth_s[0].checked = true
                @second.depth = 4; @second.pre_select = 4
            $("#level-first input[type='radio']").checkboxradio()
            $("#level-first input[type='radio']").checkboxradio('refresh')
            $("#level-second input[type='radio']").checkboxradio()
            $("#level-second input[type='radio']").checkboxradio('refresh')
            if @first_player.selectedIndex == 0
                $("#level-first input[type='radio']").checkboxradio('disable')
            else
                $("#level-first input[type='radio']").checkboxradio('enable')
            if @second_player.selectedIndex == 0
                $("#level-second input[type='radio']").checkboxradio('disable');
            else
                $("#level-second input[type='radio']").checkboxradio('enable');
            @board.fonts = parseInt(localStorage.getItem("radio-fonts33")|0, 10)
            if @board.fonts == 1
                @radio_fonts[1].checked = true
            else
                @radio_fonts[0].checked = true
            $("#boardImage input[type='radio']").checkboxradio()
            setTimeout (=>
                event = new ($.Event)('special')
                $(document).trigger event
                ),500
        catch err
            console.log("=== Error ===")
            console.log(err)
            @first_player.selectedIndex = 0
            @second_player.selectedIndex = 0
            @radio_arrange[0].checked = true
            @radio_depth_f[0].checked = true
            @radio_depth_s[0].checked = true
            @radio_fonts[0].checked = true

        $('#btnRecord1').on 'click', (e) =>
            @makeRecord()
            return
        $('#btnRecord2').on 'click', (e) =>
            @makeRecord()
            return
        $('#btnReverse').on 'click', (e) =>
            return if @edit_flg
            @reverse = if @reverse then false else true
            @board.display(@reverse)
            return
        $('#btnInfo1').on 'click', (e) =>
            @serverMsg()
            return
        $('#btnInfo2').on 'click', (e) =>
            @serverMsg()
            return
        $('#btnKifu').on 'click', (e) =>
            # console.log("btnKifu onClick")
            # window.admob.interstitial.prepare()
            if @inputRecord()
                $('[id=naviSeq]').text('')
                @interrupt_flg = true
                $("[id=btnStop]").val(i18next.t('msgRestart')).button("refresh")
                $("[id=btnStart]").prop("disabled", false); @startbtn = false
                $('[id=naviA]').show()
                $('[id=spanStatus]').html("")
                $('body').pagecontainer('change', '#home', { transition: 'slideup', changeHash: false, allowSamePageTransition: true } )
                # location.href = "#home"
                @viewState()
            return
        $('[id=btnStart]').on 'click', (e) =>
            return if @edit_flg
            target = $(e.currentTarget)
            $("[id=btnStart]").prop("disabled", true);@startbtn = true; $("[id=btnStop]").val(i18next.t('msgInterrupt')).button("refresh")
            @prepare()
            @first.human = if @first_player.selectedIndex == 1 then false else true
            @second.human = if @second_player.selectedIndex == 1 then false else true
            if !@first.human && !@second.human
                $('[id=spanStatus]').html(i18next.t('msgThinking'))
                @board.display(@reverse)
                setTimeout (=>
                    @auto_battle(@seq)
                    ), 1000
            else if not @first.human
                $('[id=spanStatus]').html(i18next.t('msgThinking'))
                setTimeout (=>
                    event = new ($.Event)('ai_thinking')
                    $(window).trigger event
                    ),500
            return

        $('[id=naviStart]').on 'click', (e) =>
            return if @edit_flg
            @seq = 0
            @viewState()
            return
        $('[id=naviPrev]').on 'click', (e) =>
            return if @edit_flg
            @seq -= 1 if @seq > 0
            @viewState()
            return
        $('[id=naviFollow]').on 'click', (e) =>
            return if @edit_flg
            @seq += 1 if @seq < (@history.length - 1)
            @viewState()
            return
        $('[id=naviEnd]').on 'click', (e) =>
            return if @edit_flg
            @seq = @history.length - 1
            @viewState()
            return
        $('[id=b11]').on 'click', (e) =>
            @select([Number(e.currentTarget.dataset.col), Number(e.currentTarget.dataset.row)])
            return
        $('[id=b21]').on 'click', (e) =>
            @select([Number(e.currentTarget.dataset.col), Number(e.currentTarget.dataset.row)])
            return
        $('[id=b31]').on 'click', (e) =>
            @select([Number(e.currentTarget.dataset.col), Number(e.currentTarget.dataset.row)])
            return
        $('[id=b12]').on 'click', (e) =>
            @select([Number(e.currentTarget.dataset.col), Number(e.currentTarget.dataset.row)])
            return
        $('[id=b22]').on 'click', (e) =>
            @select([Number(e.currentTarget.dataset.col), Number(e.currentTarget.dataset.row)])
            return
        $('[id=b32]').on 'click', (e) =>
            @select([Number(e.currentTarget.dataset.col), Number(e.currentTarget.dataset.row)])
            return
        $('[id=b13]').on 'click', (e) =>
            @select([Number(e.currentTarget.dataset.col), Number(e.currentTarget.dataset.row)])
            return
        $('[id=b23]').on 'click', (e) =>
            @select([Number(e.currentTarget.dataset.col), Number(e.currentTarget.dataset.row)])
            return
        $('[id=b33]').on 'click', (e) =>
            @select([Number(e.currentTarget.dataset.col), Number(e.currentTarget.dataset.row)])
            return
        $('[id=sFu]').on 'click', (e) =>
            if @edit_flg
                @editMotigoma((if e.currentTarget.id[0] == "s" then Const.SECOND else Const.FIRST), e.currentTarget.id[1..2], Number(e.currentTarget.innerHTML))
            else
                @motigoma((if e.currentTarget.id[0] == "s" then Const.SECOND else Const.FIRST), e.currentTarget.id[1..2])
            return
        $('[id=sHi]').on 'click', (e) =>
            if @edit_flg
                @editMotigoma((if e.currentTarget.id[0] == "s" then Const.SECOND else Const.FIRST), e.currentTarget.id[1..2], Number(e.currentTarget.innerHTML))
            else
                @motigoma((if e.currentTarget.id[0] == "s" then Const.SECOND else Const.FIRST), e.currentTarget.id[1..2])
            return
        $('[id=sKa]').on 'click', (e) =>
            if @edit_flg
                @editMotigoma((if e.currentTarget.id[0] == "s" then Const.SECOND else Const.FIRST), e.currentTarget.id[1..2], Number(e.currentTarget.innerHTML))
            else
                @motigoma((if e.currentTarget.id[0] == "s" then Const.SECOND else Const.FIRST), e.currentTarget.id[1..2])
            return
        $('[id=sKi]').on 'click', (e) =>
            if @edit_flg
                @editMotigoma((if e.currentTarget.id[0] == "s" then Const.SECOND else Const.FIRST), e.currentTarget.id[1..2], Number(e.currentTarget.innerHTML))
            else
                @motigoma((if e.currentTarget.id[0] == "s" then Const.SECOND else Const.FIRST), e.currentTarget.id[1..2])
            return
        $('[id=sGi]').on 'click', (e) =>
            if @edit_flg
                @editMotigoma((if e.currentTarget.id[0] == "s" then Const.SECOND else Const.FIRST), e.currentTarget.id[1..2], Number(e.currentTarget.innerHTML))
            else
                @motigoma((if e.currentTarget.id[0] == "s" then Const.SECOND else Const.FIRST), e.currentTarget.id[1..2])
            return
        $('[id=sKe]').on 'click', (e) =>
            if @edit_flg
                @editMotigoma((if e.currentTarget.id[0] == "s" then Const.SECOND else Const.FIRST), e.currentTarget.id[1..2], Number(e.currentTarget.innerHTML))
            else
                @motigoma((if e.currentTarget.id[0] == "s" then Const.SECOND else Const.FIRST), e.currentTarget.id[1..2])
            return
        $('[id=sKy]').on 'click', (e) =>
            if @edit_flg
                @editMotigoma((if e.currentTarget.id[0] == "s" then Const.SECOND else Const.FIRST), e.currentTarget.id[1..2], Number(e.currentTarget.innerHTML))
            else
                @motigoma((if e.currentTarget.id[0] == "s" then Const.SECOND else Const.FIRST), e.currentTarget.id[1..2])
            return
        $('[id=fFu]').on 'click', (e) =>
            if @edit_flg
                @editMotigoma((if e.currentTarget.id[0] == "s" then Const.SECOND else Const.FIRST), e.currentTarget.id[1..2], Number(e.currentTarget.innerHTML))
            else
                @motigoma((if e.currentTarget.id[0] == "s" then Const.SECOND else Const.FIRST), e.currentTarget.id[1..2])
            return
        $('[id=fHi]').on 'click', (e) =>
            if @edit_flg
                @editMotigoma((if e.currentTarget.id[0] == "s" then Const.SECOND else Const.FIRST), e.currentTarget.id[1..2], Number(e.currentTarget.innerHTML))
            else
                @motigoma((if e.currentTarget.id[0] == "s" then Const.SECOND else Const.FIRST), e.currentTarget.id[1..2])
            return
        $('[id=fKa]').on 'click', (e) =>
            if @edit_flg
                @editMotigoma((if e.currentTarget.id[0] == "s" then Const.SECOND else Const.FIRST), e.currentTarget.id[1..2], Number(e.currentTarget.innerHTML))
            else
                @motigoma((if e.currentTarget.id[0] == "s" then Const.SECOND else Const.FIRST), e.currentTarget.id[1..2])
            return
        $('[id=fKi]').on 'click', (e) =>
            if @edit_flg
                @editMotigoma((if e.currentTarget.id[0] == "s" then Const.SECOND else Const.FIRST), e.currentTarget.id[1..2], Number(e.currentTarget.innerHTML))
            else
                @motigoma((if e.currentTarget.id[0] == "s" then Const.SECOND else Const.FIRST), e.currentTarget.id[1..2])
            return
        $('[id=fGi]').on 'click', (e) =>
            if @edit_flg
                @editMotigoma((if e.currentTarget.id[0] == "s" then Const.SECOND else Const.FIRST), e.currentTarget.id[1..2], Number(e.currentTarget.innerHTML))
            else
                @motigoma((if e.currentTarget.id[0] == "s" then Const.SECOND else Const.FIRST), e.currentTarget.id[1..2])
            return
        $('[id=fKe]').on 'click', (e) =>
            if @edit_flg
                @editMotigoma((if e.currentTarget.id[0] == "s" then Const.SECOND else Const.FIRST), e.currentTarget.id[1..2], Number(e.currentTarget.innerHTML))
            else
                @motigoma((if e.currentTarget.id[0] == "s" then Const.SECOND else Const.FIRST), e.currentTarget.id[1..2])
            return
        $('[id=fKy]').on 'click', (e) =>
            if @edit_flg
                @editMotigoma((if e.currentTarget.id[0] == "s" then Const.SECOND else Const.FIRST), e.currentTarget.id[1..2], Number(e.currentTarget.innerHTML))
            else
                @motigoma((if e.currentTarget.id[0] == "s" then Const.SECOND else Const.FIRST), e.currentTarget.id[1..2])
            return
        $('#btnSave').on 'click', (e) =>
            # console.log("btnSave click")
            try
                chk_f_ou = (v for v in @board.pieces when v.name == 'Ou' && v.turn == Const.FIRST)
                chk_s_ou = (v for v in @board.pieces when v.name == 'Ou' && v.turn == Const.SECOND)
                if chk_f_ou.length > 1 || chk_s_ou.length > 1
                    throw i18next.t('msg_over_king')
                if chk_f_ou.length <= 0 || chk_s_ou.length <= 0
                    throw i18next.t('msg_no_king')
                if @radioNo >= 0
                    localStorage.setItem("shogi33_pattern" + @radioNo.toString(), JSON.stringify(@board.pieces))
                    @boardList()
                else
                    throw i18next.t('msg_save_error')
                # window.admob.interstitial.prepare()
                # ------------------------------
                @seq = 0
                @history = []
                @duplication = []
                @board.latest = []
                launch.call @, @radioNo
                @addState(null, @radioNo)
                $('[id=naviSeq]').text('')
                @interrupt_flg = true
                $("[id=btnStop]").val(i18next.t('msgRestart')).button("refresh")
                $("[id=btnStart]").prop("disabled", false);@startbtn = false
                $('[id=naviA]').show()
                @viewState()
                if @history[0]["latest"]?
                    @writeFile(Const.TEMP_HISTORY, @history);@writeFile(Const.TEMP_DUPLICATION, @duplication)
                # ------------------------------
                $('[id=spanStatus]').html(i18next.t('msg_save'))
                $('#panelSave').hide()
                @edit_flg = false
                return
            catch err
                console.log(err)
                $('[id=spanStatus]').html("#{err}")
            return
        $('#btnCancel').on 'click', (e) =>
            # console.log("btnCancel click")
            @edit_flg = false
            @board.pieces = []
            for koma in @bkup.pieces
                @board.pieces.push(koma)
            @board.display(@reverse)
            $('#panelSave').hide()
            $("[id=btnStart]").prop("disabled", false);@startbtn = false
        $('#btnEdit').on 'click', (e) =>
            # console.log("btnEdit click")
            return if @edit_flg
            if @startbtn
                @interrupted()
            @seq = 0
            @viewState()
            @edit_flg = true
            # ----------------
            @radioNo = parseInt($('input[name=radio-arrange]:checked').val()|0, 10)
            launch.call @, @radioNo
            # ----------------
            @bkup.pieces = []
            for koma in @board.pieces
                cls = getClass(koma.name)
                @bkup.pieces.push(new cls(koma.turn, koma.status, koma.posi))
            @reverse = false
            @board.display(@reverse)
            $('#panelSave').show()
            $("[id=btnStart]").prop("disabled", true);@startbtn = true
            return
        kinds = ["Ou", "Hi", "Ry", "Ka", "Um", "Ki", "Gi", "Ng", "Ke", "Nk", "Ky", "Ny", "Fu", "To"]
        for v in kinds
            $('#tgl_f' + v).on 'click', (e) =>
                @editPiece(e.currentTarget.dataset.kind, Number(e.currentTarget.dataset.turn), Number(e.currentTarget.dataset.status))
                return
        for v in kinds
            $('#tgl_s' + v).on 'click', (e) =>
                @editPiece(e.currentTarget.dataset.kind, Number(e.currentTarget.dataset.turn), Number(e.currentTarget.dataset.status))
                return
        $('#btnMenu').on 'click', (e) =>
            return if @edit_flg
            if @startbtn
                @interrupted()
            $('body').pagecontainer('change', '#win_menu', { transition: 'slideup', changeHash: false, allowSamePageTransition: true } )
            # location.href = "#win_menu"
            return
        $('[id=btnStop]').on 'click', (e) =>
            return if @edit_flg
            @interrupted()
        $('#btnNari').on 'click', (e) =>
            @routine(@selected, @posi, true)
        $('#btnNarazu').on 'click', (e) =>
            @routine(@selected, @posi, false)
        $('input[name=radio-fonts]').change ->
            idx = $('input[name=radio-fonts]:checked').val()
            try
                localStorage.setItem("radio-fonts33", idx)
                setTimeout (=>
                    event = new ($.Event)('after_fonts')
                    $(document).trigger event
                ),500
            catch err
                console.log(err)
        $('input[name=radio-arrange]').change ->
            idx = $('input[name=radio-arrange]:checked').val()
            try
                localStorage.setItem("radio-arrange", idx)
                $('[id=patternNo]').text(idx)
            catch err
                console.log(err)
        $('input[name="f-radio-depth"]').on 'change', (e) =>
            target = $(e.currentTarget)
            try
                if @radio_depth_f[3].checked
                    localStorage.setItem("f-radio-depth33", 3)
                    @first.depth = 9; @first.pre_select = 4
                else if @radio_depth_f[2].checked
                    localStorage.setItem("f-radio-depth33", 2)
                    @first.depth = 8; @first.pre_select = 4
                else if @radio_depth_f[1].checked
                    localStorage.setItem("f-radio-depth33", 1)
                    @first.depth = 6; @first.pre_select = 4
                else
                    localStorage.setItem("f-radio-depth33", 0)
                    @first.depth = 4; @first.pre_select = 4
            catch err
                console.log(err)
        $('input[name="s-radio-depth"]').on 'change', (e) =>
            target = $(e.currentTarget)
            try
                if @radio_depth_s[3].checked
                    localStorage.setItem("s-radio-depth33", 3)
                    @second.depth = 9; @second.pre_select = 4
                else if @radio_depth_s[2].checked
                    localStorage.setItem("s-radio-depth33", 2)
                    @second.depth = 8; @second.pre_select = 4
                else if @radio_depth_s[1].checked
                    localStorage.setItem("s-radio-depth33", 1)
                    @second.depth = 6; @second.pre_select = 4
                else
                    localStorage.setItem("s-radio-depth33", 0)
                    @second.depth = 4; @second.pre_select = 4
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
                if target.context.selectedIndex == 0
                    $("#level-first input[type='radio']").checkboxradio('disable');
                else
                    $("#level-first input[type='radio']").checkboxradio('enable');
                localStorage.setItem("first_player33", target.context.selectedIndex)
            catch err
                console.log(err)
        $('#second_player').on 'change', (e) =>
            target = $(e.currentTarget)
            try
                if target.context.selectedIndex == 0
                    $("#level-second input[type='radio']").checkboxradio('disable');
                else
                    $("#level-second input[type='radio']").checkboxradio('enable');
                localStorage.setItem("second_player33", target.context.selectedIndex)
            catch err
                console.log(err)
        $('#btnSearch').on 'click', (e) =>
            # console.log("btnSearch.click")
            @bkup.pieces = []
            for koma in @board.pieces
                cls = getClass(koma.name)
                @bkup.pieces.push(new cls(koma.turn, koma.status, koma.posi))
            @listUp()

    boardList: ->
        @searchList = []
        @set_standard()
        @searchList.push((v.name for v in @board.pieces).unique())
        # BoardGUI.appLocalize()
        @board.display(@reverse, 0, null)
        for i in [1..145]
            launch.call @, i
            @searchList.push((v.name for v in @board.pieces).unique())
            @board.display(@reverse, i, null)

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
                        r[col - 1][row - 1] = {src: BoardGUI.getImg(koma, @board.fonts), alt: koma.caption(), cls: (if koma.turn == Const.FIRST then 'first' else 'second')}
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
            title = 'Pattern' + @searchResult[idx].toString() + ':'
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
        if @startbtn
            # window.admob.interstitial.prepare()
            @interrupt_flg = true
            $("[id=btnStop]").val(i18next.t('msgRestart')).button("refresh")
            $("[id=btnStart]").prop("disabled", false);@startbtn = false
            $('[id=naviA]').show()
            $('[id=spanStatus]').html("")
        else
            @interrupt_flg = false
            $("[id=btnStop]").val(i18next.t('msgInterrupt')).button("refresh")
            $("[id=btnStart]").prop("disabled", true);@startbtn = true
            $('[id=naviA]').hide()
            if (@seq % 2) == 0
                $('[id=spanStatus]').html(i18next.t('msgTurn', {postProcess: 'sprintf', sprintf: [i18next.t('msgBlack')]}))
            else
                $('[id=spanStatus]').html(i18next.t('msgTurn', {postProcess: 'sprintf', sprintf: [i18next.t('msgWhite')]}))
            @teban = if (@seq % 2) == 0 then @first else @second
            @first_player.selectedIndex = parseInt(localStorage.getItem("first_player33")|0, 10)
            @second_player.selectedIndex = parseInt(localStorage.getItem("second_player33")|0, 10)
            @first.human = if @first_player.selectedIndex == 1 then false else true
            @second.human = if @second_player.selectedIndex == 1 then false else true
            @history.splice(@seq + 1); @duplication.splice(@seq + 1)
            if !@first.human && !@second.human
                $('[id=spanStatus]').html(i18next.t('msgThinking'))
                setTimeout (=>
                    @auto_battle(@seq)
                    ), 1000
            else if not @teban.human
                $('[id=spanStatus]').html(i18next.t('msgThinking'))
                setTimeout (=>
                    event = new ($.Event)('ai_thinking')
                    $(window).trigger event
                    ),500
            else
                return if @sennitite(GameGUI.make_hash(@board))
                ret = []
                oppo = if (@teban.turn == Const.FIRST) then @second else @first
                threshold = if (@teban.turn == Const.FIRST) then Const.MAX_VALUE else Const.MIN_VALUE
                @teban.pre_ahead = 0; oppo.pre_ahead = 0
                ret = @teban.think(@board, oppo, 1, threshold)
                unless ret[0]
                    switch ret[2]
                        when Const.MAX_VALUE
                            $('[id=spanStatus]').html(i18next.t('msgFirstWin'))
                            $("[id=btnStart]").prop("disabled", false);@startbtn = false; $("[id=btnStop]").val(i18next.t('msgRestart')).button("refresh")
                            $('[id=naviA]').show()
                        when Const.MIN_VALUE
                            $('[id=spanStatus]').html(i18next.t('msgSecondWin'))
                            $("[id=btnStart]").prop("disabled", false);@startbtn = false; $("[id=btnStop]").val(i18next.t('msgRestart')).button("refresh")
                            $('[id=naviA]').show()
                        else
                            console.log("Error!")
                    @board.display(@reverse)
        return

    sennitite: (h) ->
        b = (v for v in @duplication when v == h)
        if b.length == 3
            return null
        else if b.length >= 4
            $('[id=spanStatus]').html(i18next.t('msgSennitite'))
            $("[id=btnStart]").prop("disabled", false);@startbtn = false; $("[id=btnStop]").val(i18next.t('msgRestart')).button("refresh")
            $('[id=naviA]').show()
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
        if @history[0]["latest"]?
            @writeFile(Const.TEMP_HISTORY, @history);@writeFile(Const.TEMP_DUPLICATION, @duplication)
        if @sennitite(@md5hash)
            @board.latest = posi; @board.display(@reverse)
            return
        @teban = if (@seq % 2) == 0 then @first else @second
        threshold = if @teban.turn == Const.FIRST then Const.MAX_VALUE else Const.MIN_VALUE
        switch @board.gameover()
            when Const.FIRST
                $('[id=spanStatus]').html(i18next.t('msgFirstWin'))
                $("[id=btnStart]").prop("disabled", false);@startbtn = false; $("[id=btnStop]").val(i18next.t('msgRestart')).button("refresh")
                $('[id=naviA]').show()
                @board.latest = posi; @board.display(@reverse)
                return
            when Const.SECOND
                $('[id=spanStatus]').html(i18next.t('msgSecondWin'))
                $("[id=btnStart]").prop("disabled", false);@startbtn = false; $("[id=btnStop]").val(i18next.t('msgRestart')).button("refresh")
                $('[id=naviA]').show()
                @board.latest = posi; @board.display(@reverse)
                return
            else
                if @teban.turn == Const.FIRST
                    $('[id=spanStatus]').html(i18next.t('msgTurn', {postProcess: 'sprintf', sprintf: [i18next.t('msgBlack')]}))
                else
                    $('[id=spanStatus]').html(i18next.t('msgTurn', {postProcess: 'sprintf', sprintf: [i18next.t('msgWhite')]}))
        @s_posi = null; @d_posi = null
        @board.latest = posi; @board.display(@reverse)
        if @teban.human
            oppo = if @teban.turn == Const.FIRST then @second else @first
            ret = []
            # 詰みチェック
            @teban.pre_ahead = 0; oppo.pre_ahead = 0
            ret = @teban.think(@board, oppo, 1, threshold)
            unless ret[0]
                if @teban.turn == Const.FIRST
                    $('[id=spanStatus]').html(i18next.t('msgWinner', {postProcess: 'sprintf', sprintf: [i18next.t('msgWhite')]}))
                else
                    $('[id=spanStatus]').html(i18next.t('msgWinner', {postProcess: 'sprintf', sprintf: [i18next.t('msgBlack')]}))
                $("[id=btnStart]").prop("disabled", false);@startbtn = false; $("[id=btnStop]").val(i18next.t('msgRestart')).button("refresh")
                $('[id=naviA]').show()
                return
        else
            $('[id=spanStatus]').html(i18next.t('msgThinking'))
            setTimeout (=>
                event = new ($.Event)('ai_thinking')
                $(window).trigger event
                ),500

    touch: (piece, posi) ->
        # console.log("touch")
        return unless @startbtn
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
        king = (v for v in @board.pieces when v.name == 'Ou' && v.turn == @teban.turn)[0]

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

        if piece.name == 'Fu' && move_piece.status == Const.Status.MOTIGOMA
            ret = []
            player.pre_ahead = 0; oppo.pre_ahead = 0
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

    editMotigoma: (turn, kind, count) ->
        # console.log("editMotigoma")
        idx = (i for v,i in @board.pieces when v.turn == turn && v.name == kind && v.status == Const.Status.MOTIGOMA)
        if count == 7
            @tglDirect = -1
        else if count == 0
            @tglDirect = 1
        if @tglDirect < 0
            @board.pieces.splice(idx[0], 1)
        else
            cls = getClass(kind)
            @board.pieces.push(new cls(turn, Const.Status.MOTIGOMA))
        @board.display(@reverse)
        return
    editPiece: (kind, turn, status) ->
        # console.log("editPiece")
        unless @tglPosi.length == 0
            cls = getClass(kind)
            @board.pieces.push(new cls(turn, status, @tglPosi))
            @board.display(@reverse)
        $('#popupPanel').popup("close")
        return
    motigoma: (turn, kind) ->
        # console.log("motigoma")
        return unless @startbtn
        $('[id=b' + @pre_posi[0] + @pre_posi[1] + ']').css('background-color', '#FFFACD') if @pre_posi
        @selected = (v for v in @board.pieces when v.turn == turn && v.name == kind && v.status == Const.Status.MOTIGOMA && v.turn == @teban.turn)[0]
        if @selected?
            @s_posi = not null
        return

    select: (posi) ->
        # console.log("select")
        $('[id=b' + posi[0] + posi[1] + ']').css('background-color', '#FFFACD')
        if @edit_flg
            idx = (i for v,i in @board.pieces when v.posi[0] == posi[0] && v.posi[1] == posi[1])
            if idx.length > 0
                @board.pieces.splice(idx[0], 1)
                @board.display(@reverse)
            else
                @tglPosi = [].concat(posi)
                $('#popupPanel').popup("open")
            return
        if !@s_posi
            @s_posi = posi
            @selected = (v for v in @board.pieces when v.posi? && v.posi.toString() == posi.toString() && v.turn == @teban.turn)[0]
            if @selected?
                $('[id=b' + posi[0] + posi[1] + ']').css('background-color', '#E3D7A6')
                @pre_posi = posi
                @guide(@selected) if @check_guide
            else
                @s_posi = null
        else
            @d_posi = posi
            if @pre_posi
                $('[id=b' + @pre_posi[0] + @pre_posi[1] + ']').css('background-color', '#FFFACD')
                for c in [1..@board.cols]
                    for r in [1..@board.rows]
                        unless ((r == posi[1]) && (c == posi[0]))
                            $('[id=b' + c.toString() + r.toString() + ']').css('background-color', '#FFFACD')
            @touch(@selected, @d_posi)
        return

    guide: (piece) ->
        # console.log("GameGUI.guide")
        for v in getClass(piece.name).getD(piece.turn, piece.status)
            buf = [].concat(piece.posi)
            buf[0] += v.xd; buf[1] += v.yd
            if v.series
                while (buf[0] in [1..@board.cols]) && (buf[1] in [1..@board.rows])
                    dest = (w for w in @board.pieces when w.posi? && w.posi[0] == buf[0] && w.posi[1] == buf[1])
                    if dest.length != 0
                        if (piece.turn != dest[0].turn)
                            $('[id=b' + buf[0].toString() + buf[1].toString() + ']').css('background-color', '#E6E6E6')
                        break
                    else
                        $('[id=b' + buf[0].toString() + buf[1].toString() + ']').css('background-color', '#E6E6E6')
                    buf[0] += v.xd; buf[1] += v.yd
            else
                dest = (w for w in @board.pieces when w.posi? && w.posi[0] == buf[0] && w.posi[1] == buf[1])
                if dest.length != 0
                    if (piece.turn != dest[0].turn)
                        $('[id=b' + buf[0].toString() + buf[1].toString() + ']').css('background-color', '#E6E6E6')
                else
                    if (buf[0] in [1..@board.cols]) && (buf[1] in [1..@board.rows])
                        $('[id=b' + buf[0].toString() + buf[1].toString() + ']').css('background-color', '#E6E6E6')
        return

    set_standard: ->
        # console.log("set_standard")
        @board.pieces = []
        data = localStorage.getItem("shogi33_pattern0")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
            @board.set_standard()
        return
    set_arrange1: ->
        # console.log("set_arrange1")
        @board.pieces = []
        data = localStorage.getItem("shogi33_pattern1")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
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
        # console.log("set_arrange2")
        @board.pieces = []
        data = localStorage.getItem("shogi33_pattern2")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
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
        data = localStorage.getItem("shogi33_pattern3")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
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
        data = localStorage.getItem("shogi33_pattern4")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
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
        data = localStorage.getItem("shogi33_pattern5")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
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
        data = localStorage.getItem("shogi33_pattern6")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
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
        data = localStorage.getItem("shogi33_pattern7")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
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
        data = localStorage.getItem("shogi33_pattern8")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
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
        data = localStorage.getItem("shogi33_pattern9")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
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
        data = localStorage.getItem("shogi33_pattern10")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
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
        data = localStorage.getItem("shogi33_pattern11")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
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
        data = localStorage.getItem("shogi33_pattern12")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
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
        data = localStorage.getItem("shogi33_pattern13")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
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
        data = localStorage.getItem("shogi33_pattern14")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
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
        data = localStorage.getItem("shogi33_pattern15")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
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
        data = localStorage.getItem("shogi33_pattern16")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
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
        data = localStorage.getItem("shogi33_pattern17")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
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
        data = localStorage.getItem("shogi33_pattern18")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
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
        data = localStorage.getItem("shogi33_pattern19")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
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
        data = localStorage.getItem("shogi33_pattern20")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
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
        data = localStorage.getItem("shogi33_pattern21")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
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
        data = localStorage.getItem("shogi33_pattern22")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
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
        data = localStorage.getItem("shogi33_pattern23")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
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
        data = localStorage.getItem("shogi33_pattern24")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
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
        data = localStorage.getItem("shogi33_pattern25")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
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
        data = localStorage.getItem("shogi33_pattern26")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
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
        data = localStorage.getItem("shogi33_pattern27")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
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
        data = localStorage.getItem("shogi33_pattern28")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
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
        data = localStorage.getItem("shogi33_pattern29")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
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
        data = localStorage.getItem("shogi33_pattern30")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
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
        data = localStorage.getItem("shogi33_pattern31")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
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
        data = localStorage.getItem("shogi33_pattern32")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
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
        data = localStorage.getItem("shogi33_pattern33")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
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
        data = localStorage.getItem("shogi33_pattern34")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
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
        data = localStorage.getItem("shogi33_pattern35")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
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
        data = localStorage.getItem("shogi33_pattern36")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
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
        data = localStorage.getItem("shogi33_pattern37")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
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
        data = localStorage.getItem("shogi33_pattern38")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
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
        data = localStorage.getItem("shogi33_pattern39")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
            @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,2]))
            @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,2]))
            @board.pieces.push(new Piece.Ka(Const.FIRST, Const.Status.MOTIGOMA))
            @board.pieces.push(new Piece.Hi(Const.SECOND, Const.Status.MOTIGOMA))
            @board.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange40: ->
        @board.pieces = []
        data = localStorage.getItem("shogi33_pattern40")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
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
        data = localStorage.getItem("shogi33_pattern41")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
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
        data = localStorage.getItem("shogi33_pattern42")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
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
        data = localStorage.getItem("shogi33_pattern43")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
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
        data = localStorage.getItem("shogi33_pattern44")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
            @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
            @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
            @board.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.OMOTE, [3,3]))
            @board.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.OMOTE, [1,1]))
            @board.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.OMOTE, [2,3]))
            @board.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.OMOTE, [2,1]))
        return
    set_arrange45: ->
        @board.pieces = []
        data = localStorage.getItem("shogi33_pattern45")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
            @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
            @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
            @board.pieces.push(new Piece.Gi(Const.FIRST, Const.Status.MOTIGOMA))
            @board.pieces.push(new Piece.Gi(Const.SECOND, Const.Status.MOTIGOMA))
            @board.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.MOTIGOMA))
            @board.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA))
        return
    set_arrange46: ->
        @board.pieces = []
        data = localStorage.getItem("shogi33_pattern46")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
            @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [2,1]))
            @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [2,3]))
            @board.pieces.push(new Piece.Ka(Const.FIRST, Const.Status.MOTIGOMA))
            @board.pieces.push(new Piece.Ka(Const.SECOND, Const.Status.MOTIGOMA))
            @board.pieces.push(new Piece.Gi(Const.FIRST, Const.Status.OMOTE, [3,1]))
            @board.pieces.push(new Piece.Gi(Const.SECOND, Const.Status.OMOTE, [1,3]))
        return
    set_arrange47: ->
        @board.pieces = []
        data = localStorage.getItem("shogi33_pattern47")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
            @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [2,1]))
            @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [2,3]))
            @board.pieces.push(new Piece.Ka(Const.FIRST, Const.Status.MOTIGOMA))
            @board.pieces.push(new Piece.Ka(Const.SECOND, Const.Status.MOTIGOMA))
            @board.pieces.push(new Piece.Ky(Const.FIRST, Const.Status.OMOTE, [1,3]))
            @board.pieces.push(new Piece.Ky(Const.SECOND, Const.Status.OMOTE, [3,1]))
        return
    set_arrange48: ->
        @board.pieces = []
        data = localStorage.getItem("shogi33_pattern48")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
            @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
            @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
            @board.pieces.push(new Piece.Ky(Const.FIRST, Const.Status.MOTIGOMA))
            @board.pieces.push(new Piece.Ky(Const.SECOND, Const.Status.MOTIGOMA))
            @board.pieces.push(new Piece.Gi(Const.FIRST, Const.Status.OMOTE, [3,3]))
            @board.pieces.push(new Piece.Gi(Const.SECOND, Const.Status.OMOTE, [1,1]))
        return
    set_arrange49: ->
        @board.pieces = []
        data = localStorage.getItem("shogi33_pattern49")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
            @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
            @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
            @board.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.OMOTE, [2,3]))
            @board.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.OMOTE, [2,1]))
            @board.pieces.push(new Piece.Gi(Const.FIRST, Const.Status.OMOTE, [1,2]))
            @board.pieces.push(new Piece.Gi(Const.SECOND, Const.Status.OMOTE, [3,2]))
        return
    set_arrange50: ->
        @board.pieces = []
        data = localStorage.getItem("shogi33_pattern50")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
            @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [1,2]))
            @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [3,2]))
            @board.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.OMOTE, [3,3]))
            @board.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.OMOTE, [1,1]))
            @board.pieces.push(new Piece.Ky(Const.FIRST, Const.Status.MOTIGOMA))
            @board.pieces.push(new Piece.Ky(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange51: ->
        @board.pieces = []
        data = localStorage.getItem("shogi33_pattern51")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
            @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [2,3]))
            @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [2,1]))
            @board.pieces.push(new Piece.Ka(Const.FIRST, Const.Status.MOTIGOMA))
            @board.pieces.push(new Piece.Ka(Const.SECOND, Const.Status.MOTIGOMA))
            @board.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.OMOTE, [3,3]))
            @board.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.OMOTE, [1,1]))
        return
    set_arrange52: ->
        @board.pieces = []
        data = localStorage.getItem("shogi33_pattern52")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
            @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
            @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
            @board.pieces.push(new Piece.Ka(Const.FIRST, Const.Status.OMOTE, [2,3]))
            @board.pieces.push(new Piece.Ka(Const.SECOND, Const.Status.OMOTE, [2,1]))
            @board.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.MOTIGOMA))
            @board.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange53: ->
        @board.pieces = []
        data = localStorage.getItem("shogi33_pattern53")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
            @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,2]))
            @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,2]))
            @board.pieces.push(new Piece.Hi(Const.FIRST, Const.Status.OMOTE, [3,3]))
            @board.pieces.push(new Piece.Hi(Const.SECOND, Const.Status.OMOTE, [1,1]))
            @board.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.OMOTE, [2,3]))
            @board.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.OMOTE, [2,1]))
        return
    set_arrange54: ->
        @board.pieces = []
        data = localStorage.getItem("shogi33_pattern54")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
            @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [1,2]))
            @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [3,2]))
            @board.pieces.push(new Piece.Gi(Const.FIRST, Const.Status.OMOTE, [1,3]))
            @board.pieces.push(new Piece.Gi(Const.SECOND, Const.Status.OMOTE, [3,1]))
            @board.pieces.push(new Piece.Hi(Const.FIRST, Const.Status.MOTIGOMA))
            @board.pieces.push(new Piece.Hi(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange55: ->
        @board.pieces = []
        data = localStorage.getItem("shogi33_pattern55")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
            @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
            @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
            @board.pieces.push(new Piece.Ky(Const.FIRST, Const.Status.OMOTE, [3,3]))
            @board.pieces.push(new Piece.Ky(Const.SECOND, Const.Status.OMOTE, [1,1]))
            @board.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.MOTIGOMA))
            @board.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange56: ->
        @board.pieces = []
        data = localStorage.getItem("shogi33_pattern56")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
            @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
            @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
            @board.pieces.push(new Piece.Ka(Const.FIRST, Const.Status.OMOTE, [2,3]))
            @board.pieces.push(new Piece.Ka(Const.SECOND, Const.Status.OMOTE, [2,1]))
            @board.pieces.push(new Piece.Gi(Const.FIRST, Const.Status.OMOTE, [1,2]))
            @board.pieces.push(new Piece.Gi(Const.SECOND, Const.Status.OMOTE, [3,2]))
        return
    set_arrange57: ->
        @board.pieces = []
        data = localStorage.getItem("shogi33_pattern57")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
            @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [1,3]))
            @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [3,1]))
            @board.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.OMOTE, [2,3]))
            @board.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.OMOTE, [2,1]))
            @board.pieces.push(new Piece.Hi(Const.FIRST, Const.Status.URA, [1,1]))
            @board.pieces.push(new Piece.Hi(Const.SECOND, Const.Status.URA, [3,3]))
        return
    set_arrange58: ->
        @board.pieces = []
        data = localStorage.getItem("shogi33_pattern58")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
            @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [2,3]))
            @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [2,1]))
            @board.pieces.push(new Piece.Ky(Const.FIRST, Const.Status.OMOTE, [3,3]))
            @board.pieces.push(new Piece.Ky(Const.SECOND, Const.Status.OMOTE, [1,1]))
            @board.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA))
            @board.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange59: ->
        @board.pieces = []
        data = localStorage.getItem("shogi33_pattern59")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
            @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [1,2]))
            @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [3,2]))
            @board.pieces.push(new Piece.Gi(Const.FIRST, Const.Status.OMOTE, [3,1]))
            @board.pieces.push(new Piece.Gi(Const.SECOND, Const.Status.OMOTE, [1,3]))
            @board.pieces.push(new Piece.Ky(Const.FIRST, Const.Status.MOTIGOMA))
            @board.pieces.push(new Piece.Ky(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange60: ->
        @board.pieces = []
        data = localStorage.getItem("shogi33_pattern60")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
            @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
            @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
            @board.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.OMOTE, [3,2]))
            @board.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.OMOTE, [1,2]))
            @board.pieces.push(new Piece.Ky(Const.FIRST, Const.Status.MOTIGOMA))
            @board.pieces.push(new Piece.Ky(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange61: ->
        @board.pieces = []
        data = localStorage.getItem("shogi33_pattern61")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
            @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,3]))
            @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,1]))
            @board.pieces.push(new Piece.Ky(Const.FIRST, Const.Status.MOTIGOMA))
            @board.pieces.push(new Piece.Ky(Const.SECOND, Const.Status.MOTIGOMA))
            @board.pieces.push(new Piece.Ka(Const.FIRST, Const.Status.OMOTE, [1,2]))
            @board.pieces.push(new Piece.Ka(Const.SECOND, Const.Status.OMOTE, [3,2]))
        return
    set_arrange62: ->
        @board.pieces = []
        data = localStorage.getItem("shogi33_pattern62")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
            @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
            @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
            @board.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.OMOTE, [2,3]))
            @board.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.OMOTE, [2,1]))
            @board.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.MOTIGOMA))
            @board.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange63: ->
        @board.pieces = []
        data = localStorage.getItem("shogi33_pattern63")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
            @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
            @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
            @board.pieces.push(new Piece.Gi(Const.FIRST, Const.Status.OMOTE, [3,2]))
            @board.pieces.push(new Piece.Gi(Const.SECOND, Const.Status.OMOTE, [1,2]))
            @board.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.OMOTE, [2,3]))
            @board.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.OMOTE, [2,1]))
        return
    set_arrange64: ->
        @board.pieces = []
        data = localStorage.getItem("shogi33_pattern64")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
            @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,3]))
            @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,1]))
            @board.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.OMOTE, [2,3]))
            @board.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.OMOTE, [2,1]))
            @board.pieces.push(new Piece.Gi(Const.FIRST, Const.Status.MOTIGOMA))
            @board.pieces.push(new Piece.Gi(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange65: ->
        @board.pieces = []
        data = localStorage.getItem("shogi33_pattern65")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
            @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,3]))
            @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,1]))
            @board.pieces.push(new Piece.Ky(Const.FIRST, Const.Status.OMOTE, [2,3]))
            @board.pieces.push(new Piece.Ky(Const.SECOND, Const.Status.OMOTE, [2,1]))
            @board.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.MOTIGOMA))
            @board.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange66: ->
        @board.pieces = []
        data = localStorage.getItem("shogi33_pattern66")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
            @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
            @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
            @board.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.OMOTE, [2,3]))
            @board.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.OMOTE, [2,1]))
            @board.pieces.push(new Piece.Gi(Const.FIRST, Const.Status.MOTIGOMA))
            @board.pieces.push(new Piece.Gi(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange67: ->
        @board.pieces = []
        data = localStorage.getItem("shogi33_pattern67")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
            @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [1,1]))
            @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
            @board.pieces.push(new Piece.Gi(Const.FIRST, Const.Status.OMOTE, [2,3]))
            @board.pieces.push(new Piece.Gi(Const.SECOND, Const.Status.OMOTE, [3,1]))
            @board.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.OMOTE, [2,1]))
            @board.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.OMOTE, [1,2]))
        return
    set_arrange68: ->
        @board.pieces = []
        data = localStorage.getItem("shogi33_pattern68")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
            @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [1,2]))
            @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [3,2]))
            @board.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.OMOTE, [2,3]))
            @board.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.OMOTE, [2,1]))
            @board.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.MOTIGOMA))
            @board.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange69: ->
        @board.pieces = []
        data = localStorage.getItem("shogi33_pattern69")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
            @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,2]))
            @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,2]))
            @board.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.OMOTE, [2,3]))
            @board.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.OMOTE, [2,1]))
            @board.pieces.push(new Piece.Ka(Const.FIRST, Const.Status.MOTIGOMA))
            @board.pieces.push(new Piece.Ka(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange70: ->
        @board.pieces = []
        data = localStorage.getItem("shogi33_pattern70")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
            @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [1,2]))
            @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [3,2]))
            @board.pieces.push(new Piece.Ky(Const.FIRST, Const.Status.OMOTE, [1,3]))
            @board.pieces.push(new Piece.Ky(Const.SECOND, Const.Status.OMOTE, [3,1]))
            @board.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.MOTIGOMA))
            @board.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange71: ->
        @board.pieces = []
        data = localStorage.getItem("shogi33_pattern71")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
            @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,2]))
            @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,2]))
            @board.pieces.push(new Piece.Ki(Const.FIRST, Const.Status.OMOTE, [2,1]))
            @board.pieces.push(new Piece.Ki(Const.SECOND, Const.Status.OMOTE, [2,3]))
            @board.pieces.push(new Piece.Ky(Const.FIRST, Const.Status.OMOTE, [3,3]))
            @board.pieces.push(new Piece.Ky(Const.SECOND, Const.Status.OMOTE, [1,1]))
        return
    set_arrange72: ->
        @board.pieces = []
        data = localStorage.getItem("shogi33_pattern72")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
            @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [2,1]))
            @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [2,3]))
            @board.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.OMOTE, [3,3]))
            @board.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.OMOTE, [1,1]))
            @board.pieces.push(new Piece.Ky(Const.FIRST, Const.Status.MOTIGOMA))
            @board.pieces.push(new Piece.Ky(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange73: ->
        @board.pieces = []
        data = localStorage.getItem("shogi33_pattern73")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
            @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [1,3]))
            @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [3,1]))
            @board.pieces.push(new Piece.Gi(Const.FIRST, Const.Status.OMOTE, [2,1]))
            @board.pieces.push(new Piece.Gi(Const.SECOND, Const.Status.OMOTE, [2,3]))
            @board.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.OMOTE, [3,3]))
            @board.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.OMOTE, [1,1]))
        return
    set_arrange74: ->
        @board.pieces = []
        data = localStorage.getItem("shogi33_pattern74")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
            @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,2]))
            @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,2]))
            @board.pieces.push(new Piece.Hi(Const.FIRST, Const.Status.OMOTE, [3,3]))
            @board.pieces.push(new Piece.Hi(Const.SECOND, Const.Status.OMOTE, [1,1]))
            @board.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.MOTIGOMA))
            @board.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange75: ->
        @board.pieces = []
        data = localStorage.getItem("shogi33_pattern75")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
            @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [1,2]))
            @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [3,2]))
            @board.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.OMOTE, [1,3]))
            @board.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.OMOTE, [3,1]))
            @board.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.MOTIGOMA))
            @board.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange76: ->
        @board.pieces = []
        data = localStorage.getItem("shogi33_pattern76")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
            @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
            @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
            @board.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.OMOTE, [3,3]))
            @board.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.OMOTE, [1,1]))
            @board.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA))
            @board.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange77: ->
        @board.pieces = []
        data = localStorage.getItem("shogi33_pattern77")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
            @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
            @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
            @board.pieces.push(new Piece.Ky(Const.FIRST, Const.Status.OMOTE, [3,2]))
            @board.pieces.push(new Piece.Ky(Const.SECOND, Const.Status.OMOTE, [1,2]))
            @board.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.OMOTE, [2,3]))
            @board.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.OMOTE, [2,1]))
        return
    set_arrange78: ->
        @board.pieces = []
        data = localStorage.getItem("shogi33_pattern78")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
            @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [2,1]))
            @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [2,3]))
            @board.pieces.push(new Piece.Ki(Const.FIRST, Const.Status.OMOTE, [1,2]))
            @board.pieces.push(new Piece.Ki(Const.SECOND, Const.Status.OMOTE, [3,2]))
            @board.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.MOTIGOMA))
            @board.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange79: ->
        @board.pieces = []
        data = localStorage.getItem("shogi33_pattern79")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
            @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,2]))
            @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,2]))
            @board.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.OMOTE, [1,3]))
            @board.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.OMOTE, [3,1]))
            @board.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.OMOTE, [3,3]))
            @board.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.OMOTE, [1,1]))
        return
    set_arrange80: ->
        @board.pieces = []
        data = localStorage.getItem("shogi33_pattern80")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
            @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
            @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
            @board.pieces.push(new Piece.Ki(Const.FIRST, Const.Status.OMOTE, [3,2]))
            @board.pieces.push(new Piece.Ki(Const.SECOND, Const.Status.OMOTE, [1,2]))
            @board.pieces.push(new Piece.Hi(Const.FIRST, Const.Status.MOTIGOMA))
            @board.pieces.push(new Piece.Hi(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange81: ->
        @board.pieces = []
        data = localStorage.getItem("shogi33_pattern81")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
            @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [1,3]))
            @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [3,1]))
            @board.pieces.push(new Piece.Ky(Const.FIRST, Const.Status.MOTIGOMA))
            @board.pieces.push(new Piece.Ky(Const.SECOND, Const.Status.MOTIGOMA))
            @board.pieces.push(new Piece.Ka(Const.FIRST, Const.Status.OMOTE, [2,3]))
            @board.pieces.push(new Piece.Ka(Const.SECOND, Const.Status.OMOTE, [2,1]))
        return
    set_arrange82: ->
        @board.pieces = []
        data = localStorage.getItem("shogi33_pattern82")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
            @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [1,3]))
            @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [3,1]))
            @board.pieces.push(new Piece.Ky(Const.FIRST, Const.Status.MOTIGOMA))
            @board.pieces.push(new Piece.Ky(Const.SECOND, Const.Status.MOTIGOMA))
            @board.pieces.push(new Piece.Ka(Const.FIRST, Const.Status.OMOTE, [1,2]))
            @board.pieces.push(new Piece.Ka(Const.SECOND, Const.Status.OMOTE, [3,2]))
        return
    set_arrange83: ->
        @board.pieces = []
        data = localStorage.getItem("shogi33_pattern83")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
            @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,3]))
            @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,1]))
            @board.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.OMOTE, [1,3]))
            @board.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.OMOTE, [3,1]))
            @board.pieces.push(new Piece.Ky(Const.FIRST, Const.Status.MOTIGOMA))
            @board.pieces.push(new Piece.Ky(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange84: ->
        @board.pieces = []
        data = localStorage.getItem("shogi33_pattern84")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
            @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [2,1]))
            @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [2,3]))
            @board.pieces.push(new Piece.Gi(Const.FIRST, Const.Status.OMOTE, [3,1]))
            @board.pieces.push(new Piece.Gi(Const.SECOND, Const.Status.OMOTE, [1,3]))
            @board.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.MOTIGOMA))
            @board.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange85: ->
        @board.pieces = []
        data = localStorage.getItem("shogi33_pattern85")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
            @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [1,3]))
            @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [2,1]))
            @board.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.OMOTE, [1,2]))
            @board.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.URA, [1,1]))
        return
    set_arrange86: ->
        @board.pieces = []
        data = localStorage.getItem("shogi33_pattern86")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
            @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
            @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
            @board.pieces.push(new Piece.Ka(Const.FIRST, Const.Status.OMOTE, [3,2]))
            @board.pieces.push(new Piece.Ka(Const.SECOND, Const.Status.OMOTE, [1,2]))
            @board.pieces.push(new Piece.Ky(Const.FIRST, Const.Status.MOTIGOMA))
            @board.pieces.push(new Piece.Ky(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange87: ->
        @board.pieces = []
        data = localStorage.getItem("shogi33_pattern87")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
            @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,3]))
            @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,1]))
            @board.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.OMOTE, [1,3]))
            @board.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.OMOTE, [3,1]))
            @board.pieces.push(new Piece.Hi(Const.FIRST, Const.Status.MOTIGOMA))
            @board.pieces.push(new Piece.Hi(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange88: ->
        @board.pieces = []
        data = localStorage.getItem("shogi33_pattern88")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
            @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
            @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,1]))
            @board.pieces.push(new Piece.Gi(Const.SECOND, Const.Status.URA, [1,2]))
            @board.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.URA, [2,3]))
            @board.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.OMOTE, [2,2]))
        return
    set_arrange89: ->
        @board.pieces = []
        data = localStorage.getItem("shogi33_pattern89")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
            @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [2,1]))
            @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [2,3]))
            @board.pieces.push(new Piece.Ky(Const.FIRST, Const.Status.OMOTE, [1,2]))
            @board.pieces.push(new Piece.Ky(Const.SECOND, Const.Status.OMOTE, [3,2]))
            @board.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.MOTIGOMA))
            @board.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange90: ->
        @board.pieces = []
        data = localStorage.getItem("shogi33_pattern90")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
            @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
            @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
            @board.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.OMOTE, [3,3]))
            @board.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.OMOTE, [1,1]))
            @board.pieces.push(new Piece.Ka(Const.FIRST, Const.Status.MOTIGOMA))
            @board.pieces.push(new Piece.Ka(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange91: ->
        @board.pieces = []
        data = localStorage.getItem("shogi33_pattern91")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
            @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
            @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
            @board.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.OMOTE, [1,2]))
            @board.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.OMOTE, [3,2]))
            @board.pieces.push(new Piece.Gi(Const.FIRST, Const.Status.MOTIGOMA))
            @board.pieces.push(new Piece.Gi(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange92: ->
        @board.pieces = []
        data = localStorage.getItem("shogi33_pattern92")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
            @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
            @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
            @board.pieces.push(new Piece.Ka(Const.FIRST, Const.Status.OMOTE, [2,3]))
            @board.pieces.push(new Piece.Ka(Const.SECOND, Const.Status.OMOTE, [2,1]))
            @board.pieces.push(new Piece.Ky(Const.FIRST, Const.Status.OMOTE, [3,3]))
            @board.pieces.push(new Piece.Ky(Const.SECOND, Const.Status.OMOTE, [1,1]))
        return
    set_arrange93: ->
        @board.pieces = []
        data = localStorage.getItem("shogi33_pattern93")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
            @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,2]))
            @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,2]))
            @board.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.OMOTE, [3,3]))
            @board.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.OMOTE, [1,1]))
            @board.pieces.push(new Piece.Hi(Const.FIRST, Const.Status.MOTIGOMA))
            @board.pieces.push(new Piece.Hi(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange94: ->
        @board.pieces = []
        data = localStorage.getItem("shogi33_pattern94")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
            @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
            @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
            @board.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.OMOTE, [2,3]))
            @board.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.OMOTE, [2,1]))
            @board.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA))
            @board.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange95: ->
        @board.pieces = []
        data = localStorage.getItem("shogi33_pattern95")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
            @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [1,2]))
            @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [3,2]))
            @board.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.OMOTE, [1,3]))
            @board.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.OMOTE, [3,1]))
            @board.pieces.push(new Piece.Ka(Const.FIRST, Const.Status.MOTIGOMA))
            @board.pieces.push(new Piece.Ka(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange96: ->
        @board.pieces = []
        data = localStorage.getItem("shogi33_pattern96")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
            @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,2]))
            @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,2]))
            @board.pieces.push(new Piece.Ki(Const.FIRST, Const.Status.OMOTE, [3,1]))
            @board.pieces.push(new Piece.Ki(Const.SECOND, Const.Status.OMOTE, [1,3]))
            @board.pieces.push(new Piece.Ky(Const.FIRST, Const.Status.MOTIGOMA))
            @board.pieces.push(new Piece.Ky(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange97: ->
        @board.pieces = []
        data = localStorage.getItem("shogi33_pattern97")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
            @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,3]))
            @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,1]))
            @board.pieces.push(new Piece.Ki(Const.FIRST, Const.Status.OMOTE, [1,3]))
            @board.pieces.push(new Piece.Ki(Const.SECOND, Const.Status.OMOTE, [3,1]))
            @board.pieces.push(new Piece.Ky(Const.FIRST, Const.Status.MOTIGOMA))
            @board.pieces.push(new Piece.Ky(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange98: ->
        @board.pieces = []
        data = localStorage.getItem("shogi33_pattern98")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
            @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,2]))
            @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,2]))
            @board.pieces.push(new Piece.Ky(Const.FIRST, Const.Status.OMOTE, [3,3]))
            @board.pieces.push(new Piece.Ky(Const.SECOND, Const.Status.OMOTE, [1,1]))
            @board.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.OMOTE, [1,3]))
            @board.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.OMOTE, [3,1]))
        return
    set_arrange99: ->
        @board.pieces = []
        data = localStorage.getItem("shogi33_pattern99")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
            @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,3]))
            @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,1]))
            @board.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.OMOTE, [1,3]))
            @board.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.OMOTE, [3,1]))
            @board.pieces.push(new Piece.Ky(Const.FIRST, Const.Status.MOTIGOMA))
            @board.pieces.push(new Piece.Ky(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange100: ->
        @board.pieces = []
        data = localStorage.getItem("shogi33_pattern100")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
            @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,3]))
            @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,1]))
            @board.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.OMOTE, [3,2]))
            @board.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.OMOTE, [1,2]))
            @board.pieces.push(new Piece.Hi(Const.FIRST, Const.Status.MOTIGOMA))
            @board.pieces.push(new Piece.Hi(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange101: ->
        @board.pieces = []
        data = localStorage.getItem("shogi33_pattern101")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
            @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
            @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
            @board.pieces.push(new Piece.Ka(Const.FIRST, Const.Status.OMOTE, [2,1]))
            @board.pieces.push(new Piece.Ka(Const.SECOND, Const.Status.OMOTE, [2,3]))
            @board.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA))
            @board.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange102: ->
        @board.pieces = []
        data = localStorage.getItem("shogi33_pattern102")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
            @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
            @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
            @board.pieces.push(new Piece.Ky(Const.FIRST, Const.Status.OMOTE, [1,2]))
            @board.pieces.push(new Piece.Ky(Const.SECOND, Const.Status.OMOTE, [3,2]))
            @board.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA))
            @board.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange103: ->
        @board.pieces = []
        data = localStorage.getItem("shogi33_pattern103")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
            @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,2]))
            @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,2]))
            @board.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.MOTIGOMA))
            @board.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.MOTIGOMA))
            @board.pieces.push(new Piece.Gi(Const.FIRST, Const.Status.OMOTE, [3,1]))
            @board.pieces.push(new Piece.Gi(Const.SECOND, Const.Status.OMOTE, [1,3]))
        return
    set_arrange104: ->
        @board.pieces = []
        data = localStorage.getItem("shogi33_pattern104")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
            @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [1,3]))
            @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [3,1]))
            @board.pieces.push(new Piece.Ka(Const.FIRST, Const.Status.OMOTE, [2,3]))
            @board.pieces.push(new Piece.Ka(Const.SECOND, Const.Status.OMOTE, [2,1]))
            @board.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.MOTIGOMA))
            @board.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange105: ->
        @board.pieces = []
        data = localStorage.getItem("shogi33_pattern105")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
            @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,2]))
            @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,2]))
            @board.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.OMOTE, [2,3]))
            @board.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.OMOTE, [2,1]))
            @board.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA))
            @board.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange106: ->
        @board.pieces = []
        data = localStorage.getItem("shogi33_pattern106")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
            @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [2,1]))
            @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [2,3]))
            @board.pieces.push(new Piece.Gi(Const.FIRST, Const.Status.OMOTE, [3,1]))
            @board.pieces.push(new Piece.Gi(Const.SECOND, Const.Status.OMOTE, [1,3]))
            @board.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA))
            @board.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange107: ->
        @board.pieces = []
        data = localStorage.getItem("shogi33_pattern107")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
            @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [1,2]))
            @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [3,2]))
            @board.pieces.push(new Piece.Hi(Const.FIRST, Const.Status.OMOTE, [1,3]))
            @board.pieces.push(new Piece.Hi(Const.SECOND, Const.Status.OMOTE, [3,1]))
            @board.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA))
            @board.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange108: ->
        @board.pieces = []
        data = localStorage.getItem("shogi33_pattern108")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
            @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [1,2]))
            @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [3,2]))
            @board.pieces.push(new Piece.Ky(Const.FIRST, Const.Status.OMOTE, [1,3]))
            @board.pieces.push(new Piece.Ky(Const.SECOND, Const.Status.OMOTE, [3,1]))
            @board.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.OMOTE, [2,3]))
            @board.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.OMOTE, [2,1]))
        return
    set_arrange109: ->
        @board.pieces = []
        data = localStorage.getItem("shogi33_pattern109")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
            @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [2,1]))
            @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [2,3]))
            @board.pieces.push(new Piece.Ky(Const.FIRST, Const.Status.OMOTE, [3,3]))
            @board.pieces.push(new Piece.Ky(Const.SECOND, Const.Status.OMOTE, [1,1]))
            @board.pieces.push(new Piece.Hi(Const.FIRST, Const.Status.MOTIGOMA))
            @board.pieces.push(new Piece.Hi(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange110: ->
        @board.pieces = []
        data = localStorage.getItem("shogi33_pattern110")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
            @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [2,1]))
            @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [2,3]))
            @board.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.URA, [1,2]))
            @board.pieces.push(new Piece.Ki(Const.SECOND, Const.Status.OMOTE, [3,2]))
            @board.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.MOTIGOMA))
            @board.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange111: ->
        @board.pieces = []
        data = localStorage.getItem("shogi33_pattern111")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
            @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,3]))
            @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,1]))
            @board.pieces.push(new Piece.Hi(Const.FIRST, Const.Status.OMOTE, [3,2]))
            @board.pieces.push(new Piece.Ka(Const.SECOND, Const.Status.OMOTE, [1,3]))
        return
    set_arrange112: ->
        @board.pieces = []
        data = localStorage.getItem("shogi33_pattern112")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
            @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [2,1]))
            @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [2,3]))
            @board.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.OMOTE, [3,3]))
            @board.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.OMOTE, [1,1]))
            @board.pieces.push(new Piece.Hi(Const.FIRST, Const.Status.MOTIGOMA))
            @board.pieces.push(new Piece.Hi(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange113: ->
        @board.pieces = []
        data = localStorage.getItem("shogi33_pattern113")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
            @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [2,1]))
            @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [2,3]))
            @board.pieces.push(new Piece.Ki(Const.FIRST, Const.Status.OMOTE, [3,1]))
            @board.pieces.push(new Piece.Ki(Const.SECOND, Const.Status.OMOTE, [1,3]))
            @board.pieces.push(new Piece.Ky(Const.FIRST, Const.Status.MOTIGOMA))
            @board.pieces.push(new Piece.Ky(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange114: ->
        @board.pieces = []
        data = localStorage.getItem("shogi33_pattern114")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
            @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,2]))
            @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,2]))
            @board.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.OMOTE, [1,3]))
            @board.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.OMOTE, [3,1]))
            @board.pieces.push(new Piece.Gi(Const.FIRST, Const.Status.MOTIGOMA))
            @board.pieces.push(new Piece.Gi(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange115: ->
        @board.pieces = []
        data = localStorage.getItem("shogi33_pattern115")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
            @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
            @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
            @board.pieces.push(new Piece.Ky(Const.FIRST, Const.Status.OMOTE, [3,3]))
            @board.pieces.push(new Piece.Ky(Const.SECOND, Const.Status.OMOTE, [1,1]))
            @board.pieces.push(new Piece.Gi(Const.FIRST, Const.Status.MOTIGOMA))
            @board.pieces.push(new Piece.Gi(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange116: ->
        @board.pieces = []
        data = localStorage.getItem("shogi33_pattern116")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
            @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [1,2]))
            @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [3,2]))
            @board.pieces.push(new Piece.Ki(Const.FIRST, Const.Status.OMOTE, [1,3]))
            @board.pieces.push(new Piece.Ki(Const.SECOND, Const.Status.OMOTE, [3,1]))
            @board.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.OMOTE, [3,3]))
            @board.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.OMOTE, [1,1]))
        return
    set_arrange117: ->
        @board.pieces = []
        data = localStorage.getItem("shogi33_pattern117")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
            @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [2,1]))
            @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [2,3]))
            @board.pieces.push(new Piece.Ki(Const.FIRST, Const.Status.OMOTE, [3,2]))
            @board.pieces.push(new Piece.Ki(Const.SECOND, Const.Status.OMOTE, [1,2]))
            @board.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.OMOTE, [1,3]))
            @board.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.OMOTE, [3,1]))
        return
    set_arrange118: ->
        @board.pieces = []
        data = localStorage.getItem("shogi33_pattern118")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
            @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [2,1]))
            @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [2,3]))
            @board.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.OMOTE, [1,3]))
            @board.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.OMOTE, [3,1]))
            @board.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA))
            @board.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange119: ->
        @board.pieces = []
        data = localStorage.getItem("shogi33_pattern119")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
            @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [2,3]))
            @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [2,1]))
            @board.pieces.push(new Piece.Ky(Const.FIRST, Const.Status.OMOTE, [1,3]))
            @board.pieces.push(new Piece.Ky(Const.SECOND, Const.Status.OMOTE, [3,1]))
            @board.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.MOTIGOMA))
            @board.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange120: ->
        @board.pieces = []
        data = localStorage.getItem("shogi33_pattern120")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
            @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [1,2]))
            @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [3,2]))
            @board.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.OMOTE, [2,3]))
            @board.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.OMOTE, [2,1]))
            @board.pieces.push(new Piece.Ky(Const.FIRST, Const.Status.MOTIGOMA))
            @board.pieces.push(new Piece.Ky(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange121: ->
        @board.pieces = []
        data = localStorage.getItem("shogi33_pattern121")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
            @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [2,1]))
            @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [2,3]))
            @board.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.OMOTE, [1,3]))
            @board.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.OMOTE, [3,1]))
            @board.pieces.push(new Piece.Gi(Const.FIRST, Const.Status.MOTIGOMA))
            @board.pieces.push(new Piece.Gi(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange122: ->
        @board.pieces = []
        data = localStorage.getItem("shogi33_pattern122")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
            @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
            @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
            @board.pieces.push(new Piece.Gi(Const.FIRST, Const.Status.OMOTE, [2,3]))
            @board.pieces.push(new Piece.Gi(Const.SECOND, Const.Status.OMOTE, [2,1]))
            @board.pieces.push(new Piece.Ky(Const.FIRST, Const.Status.MOTIGOMA))
            @board.pieces.push(new Piece.Ky(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange123: ->
        @board.pieces = []
        data = localStorage.getItem("shogi33_pattern123")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
            @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,3]))
            @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,1]))
            @board.pieces.push(new Piece.Gi(Const.FIRST, Const.Status.OMOTE, [1,3]))
            @board.pieces.push(new Piece.Gi(Const.SECOND, Const.Status.OMOTE, [3,1]))
            @board.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA))
            @board.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange124: ->
        @board.pieces = []
        data = localStorage.getItem("shogi33_pattern124")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
            @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,3]))
            @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,1]))
            @board.pieces.push(new Piece.Ka(Const.FIRST, Const.Status.OMOTE, [2,1]))
            @board.pieces.push(new Piece.Ka(Const.SECOND, Const.Status.OMOTE, [2,3]))
            @board.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.MOTIGOMA))
            @board.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange125: ->
        @board.pieces = []
        data = localStorage.getItem("shogi33_pattern125")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
            @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,3]))
            @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,1]))
            @board.pieces.push(new Piece.Ka(Const.FIRST, Const.Status.OMOTE, [3,1]))
            @board.pieces.push(new Piece.Ka(Const.SECOND, Const.Status.OMOTE, [1,3]))
            @board.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.MOTIGOMA))
            @board.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange126: ->
        @board.pieces = []
        data = localStorage.getItem("shogi33_pattern126")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
            @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
            @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
            @board.pieces.push(new Piece.Ka(Const.FIRST, Const.Status.OMOTE, [2,3]))
            @board.pieces.push(new Piece.Ka(Const.SECOND, Const.Status.OMOTE, [2,1]))
            @board.pieces.push(new Piece.Ky(Const.FIRST, Const.Status.MOTIGOMA))
            @board.pieces.push(new Piece.Ky(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange127: ->
        @board.pieces = []
        data = localStorage.getItem("shogi33_pattern127")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
            @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,3]))
            @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,1]))
            @board.pieces.push(new Piece.Ka(Const.FIRST, Const.Status.OMOTE, [1,2]))
            @board.pieces.push(new Piece.Ka(Const.SECOND, Const.Status.OMOTE, [3,2]))
            @board.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.MOTIGOMA))
            @board.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange128: ->
        @board.pieces = []
        data = localStorage.getItem("shogi33_pattern128")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
            @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [1,2]))
            @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [3,2]))
            @board.pieces.push(new Piece.Gi(Const.FIRST, Const.Status.OMOTE, [3,1]))
            @board.pieces.push(new Piece.Gi(Const.SECOND, Const.Status.OMOTE, [1,3]))
            @board.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.MOTIGOMA))
            @board.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange129: ->
        @board.pieces = []
        data = localStorage.getItem("shogi33_pattern129")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
            @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
            @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
            @board.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.OMOTE, [2,3]))
            @board.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.OMOTE, [2,1]))
            @board.pieces.push(new Piece.Hi(Const.FIRST, Const.Status.MOTIGOMA))
            @board.pieces.push(new Piece.Hi(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange130: ->
        @board.pieces = []
        data = localStorage.getItem("shogi33_pattern130")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
            @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
            @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
            @board.pieces.push(new Piece.Ka(Const.FIRST, Const.Status.OMOTE, [2,1]))
            @board.pieces.push(new Piece.Ka(Const.SECOND, Const.Status.OMOTE, [2,3]))
            @board.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.MOTIGOMA))
            @board.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange131: ->
        @board.pieces = []
        data = localStorage.getItem("shogi33_pattern131")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
            @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
            @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
            @board.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.OMOTE, [3,3]))
            @board.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.OMOTE, [1,1]))
            @board.pieces.push(new Piece.Hi(Const.FIRST, Const.Status.MOTIGOMA))
            @board.pieces.push(new Piece.Hi(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange132: ->
        @board.pieces = []
        data = localStorage.getItem("shogi33_pattern132")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
            @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
            @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
            @board.pieces.push(new Piece.Hi(Const.FIRST, Const.Status.OMOTE, [3,2]))
            @board.pieces.push(new Piece.Hi(Const.SECOND, Const.Status.OMOTE, [1,2]))
            @board.pieces.push(new Piece.Gi(Const.FIRST, Const.Status.MOTIGOMA))
            @board.pieces.push(new Piece.Gi(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange133: ->
        @board.pieces = []
        data = localStorage.getItem("shogi33_pattern133")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
            @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
            @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
            @board.pieces.push(new Piece.Gi(Const.FIRST, Const.Status.OMOTE, [3,2]))
            @board.pieces.push(new Piece.Gi(Const.SECOND, Const.Status.OMOTE, [1,2]))
            @board.pieces.push(new Piece.Hi(Const.FIRST, Const.Status.MOTIGOMA))
            @board.pieces.push(new Piece.Hi(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange134: ->
        @board.pieces = []
        data = localStorage.getItem("shogi33_pattern134")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
            @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
            @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
            @board.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.URA, [3,2]))
            @board.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.URA, [1,2]))
            @board.pieces.push(new Piece.Hi(Const.FIRST, Const.Status.MOTIGOMA))
            @board.pieces.push(new Piece.Hi(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange135: ->
        @board.pieces = []
        data = localStorage.getItem("shogi33_pattern135")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
            @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
            @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
            @board.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.URA, [3,2]))
            @board.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.URA, [1,2]))
            @board.pieces.push(new Piece.Ka(Const.FIRST, Const.Status.MOTIGOMA))
            @board.pieces.push(new Piece.Ka(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange136: ->
        @board.pieces = []
        data = localStorage.getItem("shogi33_pattern136")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
            @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
            @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
            @board.pieces.push(new Piece.Ki(Const.FIRST, Const.Status.OMOTE, [3,2]))
            @board.pieces.push(new Piece.Ki(Const.SECOND, Const.Status.OMOTE, [1,2]))
            @board.pieces.push(new Piece.Ka(Const.FIRST, Const.Status.MOTIGOMA))
            @board.pieces.push(new Piece.Ka(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange137: ->
        @board.pieces = []
        data = localStorage.getItem("shogi33_pattern137")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
            @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
            @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
            @board.pieces.push(new Piece.Ki(Const.FIRST, Const.Status.OMOTE, [2,1]))
            @board.pieces.push(new Piece.Ki(Const.SECOND, Const.Status.OMOTE, [2,3]))
            @board.pieces.push(new Piece.Ka(Const.FIRST, Const.Status.MOTIGOMA))
            @board.pieces.push(new Piece.Ka(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange138: ->
        @board.pieces = []
        data = localStorage.getItem("shogi33_pattern138")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
            @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
            @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
            @board.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.URA, [2,1]))
            @board.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.URA, [2,3]))
            @board.pieces.push(new Piece.Ka(Const.FIRST, Const.Status.MOTIGOMA))
            @board.pieces.push(new Piece.Ka(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange139: ->
        @board.pieces = []
        data = localStorage.getItem("shogi33_pattern139")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
            @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
            @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
            @board.pieces.push(new Piece.Ki(Const.FIRST, Const.Status.OMOTE, [3,3]))
            @board.pieces.push(new Piece.Ki(Const.SECOND, Const.Status.OMOTE, [1,1]))
            @board.pieces.push(new Piece.Hi(Const.FIRST, Const.Status.MOTIGOMA))
            @board.pieces.push(new Piece.Hi(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange140: ->
        @board.pieces = []
        data = localStorage.getItem("shogi33_pattern140")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
            @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,1]))
            @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,3]))
            @board.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.URA, [3,3]))
            @board.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.URA, [1,1]))
            @board.pieces.push(new Piece.Hi(Const.FIRST, Const.Status.MOTIGOMA))
            @board.pieces.push(new Piece.Hi(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange141: ->
        @board.pieces = []
        data = localStorage.getItem("shogi33_pattern141")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
            @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [2,1]))
            @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [2,3]))
            @board.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.OMOTE, [3,3]))
            @board.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.OMOTE, [1,1]))
            @board.pieces.push(new Piece.Ky(Const.FIRST, Const.Status.MOTIGOMA))
            @board.pieces.push(new Piece.Ky(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange142: ->
        @board.pieces = []
        data = localStorage.getItem("shogi33_pattern142")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
            @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,3]))
            @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,1]))
            @board.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.MOTIGOMA))
            @board.pieces.push(new Piece.Ky(Const.FIRST, Const.Status.MOTIGOMA))
            @board.pieces.push(new Piece.Gi(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange143: ->
        @board.pieces = []
        data = localStorage.getItem("shogi33_pattern143")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
            @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,3]))
            @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,1]))
            @board.pieces.push(new Piece.Ka(Const.FIRST, Const.Status.MOTIGOMA))
            @board.pieces.push(new Piece.Ka(Const.SECOND, Const.Status.MOTIGOMA))
            @board.pieces.push(new Piece.Gi(Const.FIRST, Const.Status.OMOTE, [1,3]))
            @board.pieces.push(new Piece.Gi(Const.SECOND, Const.Status.OMOTE, [3,1]))
            @board.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA))
            @board.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.OMOTE, [2,2]))
        return
    set_arrange144: ->
        @board.pieces = []
        data = localStorage.getItem("shogi33_pattern144")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
            @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,3]))
            @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,1]))
            @board.pieces.push(new Piece.Ka(Const.FIRST, Const.Status.MOTIGOMA))
            @board.pieces.push(new Piece.Ka(Const.SECOND, Const.Status.MOTIGOMA))
            @board.pieces.push(new Piece.Gi(Const.FIRST, Const.Status.OMOTE, [1,3]))
            @board.pieces.push(new Piece.Gi(Const.SECOND, Const.Status.OMOTE, [3,1]))
            @board.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.OMOTE, [2,2]))
            @board.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.OMOTE, [1,2]))
        return
    set_arrange145: ->
        @board.pieces = []
        data = localStorage.getItem("shogi33_pattern145")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
            @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [3,3]))
            @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [1,1]))
            @board.pieces.push(new Piece.Ki(Const.FIRST, Const.Status.OMOTE, [2,3]))
            @board.pieces.push(new Piece.Ki(Const.SECOND, Const.Status.OMOTE, [2,1]))
            @board.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.MOTIGOMA))
            @board.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange146: ->
        @board.pieces = []
        data = localStorage.getItem("shogi33_pattern146")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
            @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [1,2]))
            @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [3,2]))
            @board.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.OMOTE, [2,3]))
            @board.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.OMOTE, [2,1]))
            @board.pieces.push(new Piece.Ky(Const.FIRST, Const.Status.MOTIGOMA))
            @board.pieces.push(new Piece.Ky(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange147: ->
        @board.pieces = []
        data = localStorage.getItem("shogi33_pattern147")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
            @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [1,3]))
            @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [3,1]))
            @board.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.OMOTE, [3,3]))
            @board.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.OMOTE, [1,1]))
            @board.pieces.push(new Piece.Fu(Const.FIRST, Const.Status.MOTIGOMA))
            @board.pieces.push(new Piece.Fu(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange148: ->
        @board.pieces = []
        data = localStorage.getItem("shogi33_pattern148")
        if data?
            try
                temp = JSON.parse(data)
                for v in temp
                    cls = getClass(v.name)
                    @board.pieces.push(new cls(v.turn, v.status, v.posi))
            catch err
                console.log(err)
        else
            @board.pieces.push(new Piece.Ou(Const.FIRST, Const.Status.OMOTE, [2,1]))
            @board.pieces.push(new Piece.Ou(Const.SECOND, Const.Status.OMOTE, [2,3]))
            @board.pieces.push(new Piece.Ke(Const.FIRST, Const.Status.OMOTE, [1,3]))
            @board.pieces.push(new Piece.Ke(Const.SECOND, Const.Status.OMOTE, [3,1]))
            @board.pieces.push(new Piece.Hi(Const.FIRST, Const.Status.MOTIGOMA))
            @board.pieces.push(new Piece.Hi(Const.SECOND, Const.Status.MOTIGOMA))
        return
    set_arrange149: ->
    set_arrange150: ->

    setBoardSize: (w, h) ->
        if w <= h
            @board.width = w * 0.70
            @board.height = w * 0.70
        else
            @board.width = h * 0.70
            @board.height = h * 0.70
        return

    checkHistoryFile: ->
        # console.log("GameGUI.checkHistoryFile")
        fail = ->
            alert JSON.stringify(arguments)
            return
        window.requestFileSystem LocalFileSystem.PERSISTENT, 0, ((fileSystem) ->
            fileSystem.root.getFile Const.TEMP_HISTORY, { create: true, exclusive: false }, ((fileEntry) ->
                fileEntry.file ((file) ->
                    reader = new FileReader
                    reader.onloadend = (evt) ->
                        # console.log 'fileEntry is file?' + fileEntry.isFile.toString()
                        # console.log 'fileEntry name?' + fileEntry.name
                        # console.log 'fileEntry path?' + fileEntry.fullPath
                        # alert 'text from file:' + reader.result
                        setTimeout (=>
                            event = new ($.Event)('fileHist')
                            $(document).trigger event, reader.result
                        ),500
                        return
                    reader.onerror = ->
                        alert 'error: ' + JSON.stringify(reader.error)
                        return
                    reader.readAsText file
                    return
                ), fail
                return
            ), fail
            return
        ), fail
        return

    checkDuplicationFile: ->
        # console.log("GameGUI.checkDuplicationFile")
        fail = ->
            alert JSON.stringify(arguments)
            return
        window.requestFileSystem LocalFileSystem.PERSISTENT, 0, ((fileSystem) ->
            fileSystem.root.getFile Const.TEMP_DUPLICATION, { create: true, exclusive: false }, ((fileEntry) ->
                fileEntry.file ((file) ->
                    reader = new FileReader
                    reader.onloadend = (evt) ->
                        # console.log 'fileEntry is file?' + fileEntry.isFile.toString()
                        # console.log 'fileEntry name?' + fileEntry.name
                        # console.log 'fileEntry path?' + fileEntry.fullPath
                        # alert 'text from file:' + reader.result
                        setTimeout (=>
                            event = new ($.Event)('fileDup')
                            $(document).trigger event, reader.result
                        ),500
                        return
                    reader.onerror = ->
                        alert 'error: ' + JSON.stringify(reader.error)
                        return
                    reader.readAsText file
                    return
                ), fail
                return
            ), fail
            return
        ), fail
        return

    writeFile: (fname, data) ->
        # console.log("GameGUI.writeFile")
        fail = ->
            alert JSON.stringify(arguments)
            return
        window.requestFileSystem LocalFileSystem.PERSISTENT, 0, ((fileSystem) ->
            fileSystem.root.getFile fname, { create: true, exclusive: false }, (fileEntry) ->
                fileEntry.createWriter ((writer) ->
                    # console.log 'fileEntry is file?' + fileEntry.isFile.toString()
                    # console.log 'fileEntry name?' + fileEntry.name
                    # console.log 'fileEntry path?' + fileEntry.fullPath
                    # console.log("data.length = #{data.length}")
                    writer.write JSON.stringify(data)
                    return
                ), fail
                return
            return
        ), fail
        return

    setEventListener: ->
        $(document).on 'special', (e) =>
            # console.log("special")
            BoardGUI.appLocalize()
            @boardList()
            @board.pieces = []
            $.mobile.loading 'show',
                text: Const.SAVING_MESSAGE
                textVisible: true
                textonly: false
            @prepare()
            @checkHistoryFile()
            return
        $(document).on 'fileHist', (e, data) =>
            # console.log("fileHist")
            # console.log("data.length = #{data.length}")
            if data.length != 0
                @history = JSON.parse(data)
                if @radioNo == @history[0]["latest"][0]
                    @seq = @history.length - 1
                    @checkDuplicationFile()
                else
                    @seq = 0
                    @history = []
                    @duplication = []
                    @board.latest = []
                    @addState(null, @radioNo)
            else
                @board.display(false)
            $('[id=naviSeq]').text('')
            @interrupt_flg = true
            $("[id=btnStop]").val(i18next.t('msgRestart')).button("refresh")
            $("[id=btnStart]").prop("disabled", false);@startbtn = false
            $('[id=naviA]').show()
            $('[id=spanStatus]').html("")
            @viewState()
            $.mobile.loading 'hide'
            return
        $(document).on 'fileDup', (e, data) =>
            # console.log("fileDup")
            if data.length != 0
                @duplication = JSON.parse(data)
                @md5hash = @duplication[@duplication.length - 1]
            $.mobile.loading 'hide'
            return
        $(document).on 'after_fonts', (e) =>
            # console.log("after_fonts")
            @board.fonts = parseInt(localStorage.getItem("radio-fonts33")|0, 10)
            @bkup.pieces = []
            for koma in @board.pieces
                cls = getClass(koma.name)
                @bkup.pieces.push(new cls(koma.turn, koma.status, koma.posi))
            @boardList()
            @board.pieces = []
            for koma in @bkup.pieces
                @board.pieces.push(koma)

        $(document).on 'after_search', (e) =>
            # console.log("after_search")
            for v,i in @searchResult
                launch.call @, v
                @board.display(@reverse, i, @searchResult[i])
            @board.pieces = []
            for koma in @bkup.pieces
                @board.pieces.push(koma)

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
            temp = []; ret = []
            # 対人戦の場合は相手玉を取るまで指す
            for i in [1,2,4,player.depth].unique()
                temp = []
                if i >= 6
                    temp = player.prepare(@board, oppo, i, player_threshold)
                else
                    player.pre_ahead = 0; oppo.pre_ahead = 0
                    temp = player.think(@board, oppo, i, player_threshold)
                if temp[0]?
                    ret = [].concat(temp)
                    break if (temp[2] >= Const.MAX_VALUE || temp[2] <= Const.MIN_VALUE)
                else
                    break
            if ret[0]
                # 一手前のハッシュ値ですでに千日手判定されていればreturn
                chk_sennitite =  @sennitite(@md5hash)
                if chk_sennitite
                    @board.latest = ret[1]; @board.display(@reverse)
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
                if @history[0]["latest"]?
                    @writeFile(Const.TEMP_HISTORY, @history);@writeFile(Const.TEMP_DUPLICATION, @duplication)
                if @sennitite(@md5hash)
                    @board.latest = ret[1]; @board.display(@reverse)
                    return
                @teban = if (@seq % 2) == 0 then @first else @second
            else
                if @teban.turn == Const.FIRST
                    $('[id=spanStatus]').html(i18next.t('msgWinner', {postProcess: 'sprintf', sprintf: [i18next.t('msgWhite')]}))
                else
                    $('[id=spanStatus]').html(i18next.t('msgWinner', {postProcess: 'sprintf', sprintf: [i18next.t('msgBlack')]}))
                $("[id=btnStart]").prop("disabled", false);@startbtn = false; $("[id=btnStop]").val(i18next.t('msgRestart')).button("refresh")
                $('[id=naviA]').show()
                return

            # 詰みチェック
            tumi = []
            player.pre_ahead = 0; oppo.pre_ahead = 0
            tumi = oppo.think(@board, player, 1, oppo_threshold)
            unless tumi[0]
                switch tumi[2]
                    when Const.MAX_VALUE
                        $('[id=spanStatus]').html(i18next.t('msgFirstWin'))
                        $("[id=btnStart]").prop("disabled", false);@startbtn = false; $("[id=btnStop]").val(i18next.t('msgRestart')).button("refresh")
                        $('[id=naviA]').show()
                    when Const.MIN_VALUE
                        $('[id=spanStatus]').html(i18next.t('msgSecondWin'))
                        $("[id=btnStart]").prop("disabled", false);@startbtn = false; $("[id=btnStop]").val(i18next.t('msgRestart')).button("refresh")
                        $('[id=naviA]').show()
                    else
                        console.log("Error!")
                @board.display(@reverse)
                return
            # 相手玉が自爆しても指し手を進めてしまうのでゲーム終了チェック
            switch @board.gameover()
                when Const.FIRST
                    $('[id=spanStatus]').html(i18next.t('msgFirstWin'))
                    $("[id=btnStart]").prop("disabled", false);@startbtn = false; $("[id=btnStop]").val(i18next.t('msgRestart')).button("refresh")
                    $('[id=naviA]').show()
                when Const.SECOND
                    $('[id=spanStatus]').html(i18next.t('msgSecondWin'))
                    $("[id=btnStart]").prop("disabled", false);@startbtn = false; $("[id=btnStop]").val(i18next.t('msgRestart')).button("refresh")
                    $('[id=naviA]').show()
                else
                    if @teban.turn == Const.FIRST
                        msgStr = i18next.t('msgTurn', {postProcess: 'sprintf', sprintf: [i18next.t('msgBlack')]})
                        $('[id=spanStatus]').html(msgStr)
                    else
                        msgStr = i18next.t('msgTurn', {postProcess: 'sprintf', sprintf: [i18next.t('msgWhite')]})
                        $('[id=spanStatus]').html(msgStr)
                    $('[id=spanStatus]').html(msgStr + i18next.t('msgEvaluate', {postProcess: 'sprintf', sprintf: [ret[2].toString()]}))
            @board.latest = ret[1]; @board.display(@reverse)

        $(window).on 'load', (e) =>
            # console.log("=== Load ===")
            target = $(e.currentTarget)
            @setBoardSize(target.width(), target.height())
            @init()
            # unless navigator.userAgent.match(/(iPhone|iPod|iPad|Android|BlackBerry)/)
            #     setTimeout (=>
            #         event = new ($.Event)('special')
            #         $(document).trigger event
            #         ),500

        # $(boardSearch).on 'updatelayout', (e) =>
        #     # console.log("boardSearch updatelayout")
        #     target = $(e.currentTarget)

        $(boardList).on 'updatelayout', (e) =>
            # console.log("updatelayout")
            if window.myVersionString? && parseInt(window.myVersionString[0]|0, 10) >= 6
                scrollHeight = $("boardImage").context.scrollingElement.scrollHeight
                $('html,body').animate({ scrollTop: (scrollHeight / (145 + 1)) * @label_idx }, queue: false)

        $(document).on 'pagecontainershow', (e) =>
            # console.log("pagecontainershow")
            @label_idx = $('input[name=radio-arrange]:checked').val()

    is_oute = (piece, d_posi) ->
        oppo = if piece.turn == Const.FIRST then Const.SECOND else Const.FIRST
        oppo_king = (v for v in @board.pieces when v.turn == oppo && v.name == 'Ou')[0]
        buf = [].concat(d_posi)
        buf[0] += getClass(piece.name).getD(piece.turn, piece.status)[0].xd
        buf[1] += getClass(piece.name).getD(piece.turn, piece.status)[0].yd
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
            when 141
                @set_arrange141()
            when 142
                @set_arrange142()
            when 143
                @set_arrange143()
            when 144
                @set_arrange144()
            when 145
                @set_arrange145()
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
        launch.call @, pattern
        p31 = (v for v in @board.pieces when v.posi[0] == 3 && v.posi[1] == 1)[0]
        p21 = (v for v in @board.pieces when v.posi[0] == 2 && v.posi[1] == 1)[0]
        p11 = (v for v in @board.pieces when v.posi[0] == 1 && v.posi[1] == 1)[0]
        p32 = (v for v in @board.pieces when v.posi[0] == 3 && v.posi[1] == 2)[0]
        p22 = (v for v in @board.pieces when v.posi[0] == 2 && v.posi[1] == 2)[0]
        p12 = (v for v in @board.pieces when v.posi[0] == 1 && v.posi[1] == 2)[0]
        p33 = (v for v in @board.pieces when v.posi[0] == 3 && v.posi[1] == 3)[0]
        p23 = (v for v in @board.pieces when v.posi[0] == 2 && v.posi[1] == 3)[0]
        p13 = (v for v in @board.pieces when v.posi[0] == 1 && v.posi[1] == 3)[0]
        f_motigoma = (v for v in @board.pieces when v.turn == Const.FIRST && v.status == Const.Status.MOTIGOMA)
        s_motigoma = (v for v in @board.pieces when v.turn == Const.SECOND && v.status == Const.Status.MOTIGOMA)
        if f_motigoma.length > 0
            pf = "P+"
            for v,i in f_motigoma
                pf += "00" + v.koma()
        else
            pf = ""
        if s_motigoma.length > 0
            ps = "P-"
            for v,i in s_motigoma
                ps += "00" + v.koma()
        else
            ps = ""

        b = ""
        b += "P1"
        if p31?
            if p31.turn == Const.FIRST
                b += "+"
            else
                b += "-"
            b += p31.koma()
        else
            b += " * "
        if p21?
            if p21.turn == Const.FIRST
                b += "+"
            else
                b += "-"
            b += p21.koma()
        else
            b += " * "
        if p11?
            if p11.turn == Const.FIRST
                b += "+"
            else
                b += "-"
            b += p11.koma()
        else
            b += " * "
        b += "\n"
        b += "P2"
        if p32?
            if p32.turn == Const.FIRST
                b += "+"
            else
                b += "-"
            b += p32.koma()
        else
            b += " * "
        if p22?
            if p22.turn == Const.FIRST
                b += "+"
            else
                b += "-"
            b += p22.koma()
        else
            b += " * "
        if p12?
            if p12.turn == Const.FIRST
                b += "+"
            else
                b += "-"
            b += p12.koma()
        else
            b += " * "
        b += "\n"
        b += "P3"
        if p33?
            if p33.turn == Const.FIRST
                b += "+"
            else
                b += "-"
            b += p33.koma()
        else
            b += " * "
        if p23?
            if p23.turn == Const.FIRST
                b += "+"
            else
                b += "-"
            b += p23.koma()
        else
            b += " * "
        if p13?
            if p13.turn == Const.FIRST
                b += "+"
            else
                b += "-"
            b += p13.koma()
        else
            b += " * "
        b += "\n"
        b += pf + "\n" if pf.length > 0
        b += ps + "\n" if ps.length > 0
        return b

    toast = (toastStr) ->
        # console.log("toast")
        return unless toastStr
        window.plugins.toast.showWithOptions
            message: toastStr
            duration: '15000'
            position: 'center'
            styling:
                opacity: 0.75
                backgroundColor: '#E6E6E6'
                textColor: '#000000'
                textSize: 28
                cornerRadius: 16
        return
