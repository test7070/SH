<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title></title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"></script>
		<script src="css/jquery/ui/jquery.ui.widget.js"></script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"></script>
		<script type="text/javascript">
            q_tables = 's';
            var q_name = "tran";
            var q_readonly = ['txtNoa', 'txtMount', 'txtVolume', 'txtWeight','txtTotal','txtTotal2', 'txtWorker', 'txtWorker2'];
            var q_readonlys = ['txtOrdeno', 'txtCaseno2',];
            var bbmNum = [['txtTotal', 10, 2, 1],['txtTotal2', 10, 0, 1]];
            var bbsNum = [['txtMount', 10, 0, 1],['txtVolume', 10, 3, 1],['txtWeight', 10, 2, 1],['txtTotal', 10, 0, 1],['txtTotal2', 10, 0, 1]];
            var bbmMask = [['txtDatea','999/99/99'],['textMon','999/99']];
            var bbsMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            q_desc = 1;
            aPop = new Array(['txtDriverno', 'lblDriverno', 'driver', 'noa,namea', 'txtDriverno,txtDriver', 'driver_b.aspx']
            , ['txtCarno', 'lblCarno', 'car2', 'a.noa,driverno,driver', 'txtCarno,txtDriverno,txtDriver', 'car2_b.aspx']
            , ['txtAddrno', 'lblAddr', 'cust', 'noa,comp', 'txtAddrno,txtAddr', 'cust_b.aspx']
            , ['txtCno', 'lblCno', 'acomp', 'noa,acomp', 'txtCno,txtAcomp', 'acomp_b.aspx']
            , ['txtUccno_', 'btnProduct_', 'ucc', 'noa,product', 'txtUccno_,txtProduct_', 'ucc_b.aspx']
            , ['txtStraddrno_', 'btnStraddr_', 'addr', 'noa,addr', 'txtStraddrno_,txtStraddr_', 'addr_b.aspx']
            , ['txtEndaddrno_', 'btnEndaddr_', 'addr', 'noa,addr', 'txtEndaddrno_,txtEndaddr_', 'addr_b.aspx']
            , ['txtCustno_', 'btnCust_', 'cust', 'noa,comp,nick', 'txtCustno_,txtComp_,txtNick_', 'cust_b.aspx']
            , ['txtDriverno_', 'btnDriver_', 'driver', 'noa,namea', 'txtDriverno_,txtDriver_', 'driver_b.aspx']
            , ['txtCarno_', 'btnCarno_', 'car2', 'a.noa,driverno,driver', 'txtCarno_,txtDriverno_,txtDriver_', 'car2_b.aspx']);

            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);

            });

            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                mainForm(0);
                window.parent.document.title='出車作業'
            }

            function sum() {
                
            }

            function mainPost() {
                q_mask(bbmMask);
                bbsMask = [['txtDatea', r_picd],['txtTrandate', r_picd],['txtLtime','99:99'],['txtStime','99:99'],['txtDtime','99:99']];
                $('#txtDatea').datepicker();
                q_cmbParse("cmbUnit2",'@,cm^3@cm^3,m^3@m^3,材@材,CBM@CBM','s');
                q_gt('carteam', '', 0, 0, 0, 'transInit_1');
                
                $('#btnOrde').click(function(e){
                    t_custno=$('#txtAddrno').val();
                    var t_where = "chk1=1 and chk2=1 and custno='"+t_custno+"' and not exists(select noa,noq from view_trans where view_tranvcces.noa=ordeno and view_tranvcces.noq=caseno)";
                    q_box("tranvcce_sh_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'tranvcce_tran', "95%", "650px");
                });
                
            }
            
            function q_funcPost(t_func, result) {
                switch(t_func) {
                    case 'qtxt.query.tranpayb_jr':
                        var as = _q_appendData("tmp0", "", true, true);
                        alert(as[0].msg);
                        break;
                    default:
                        break;
                }
            }

            function q_boxClose(s2) {
                 var ret;
                switch (b_pop) {
                    case 'tranvcce_tran':
                        if (q_cur > 0 && q_cur < 4) {
                            b_ret = getb_ret();
                            if (!b_ret || b_ret.length == 0)
                                return;
                                ret = q_gridAddRow(bbsHtm, 'tbbs', 
                                'txtOrdeno,txtCaseno2,txtTrandate,txtCustno,txtNick,txtUccno,txtProduct,txtMount,txtUnit,txtVolume,txtTotal,txtCarno,txtDriverno,txtDriver,txtMemo,txtStraddrno,txtStraddr,txtEndaddrno,txtEndaddr,txtTotal2,txtCaseno,txtPo,txtCasecustno,txtCasecust,txtWeight,cmbUnit2', b_ret.length, b_ret, 
                                'noa,noq,time1,custno,cust,productno,product,mount,unit,volume,total,carno,driverno,driver,memo,addrno,addr,addrno2,addr2,total2,tranno,productno2,addrno3,addr3,weight,unit2', 'txtCustno,txtProductno,txtTrandate,txtMount');
                            }
                        break;
                    case q_name + '_s':
                        q_boxClose2(s2);
                        break;
                }
                b_pop='';
            }

            function q_gtPost(t_name) {
                switch (t_name) {
                case 'transInit_1':
                        var as = _q_appendData("carteam", "", true);
                        if (as[0] != undefined) {
                            var t_item = "";
                            for ( i = 0; i < as.length; i++) {
                                t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].team;
                            }
                            q_cmbParse("cmbPort", t_item);
                            if(abbm[q_recno]!=undefined)
                                $("#cmbPort").val(abbm[q_recno].carteamno);
                        }
                        q_gt('calctype2', '', 0, 0, 0, 'transInit_2');
                        break;
                case q_name:
                    if (q_cur == 4)
                        q_Seek_gtPost();
                    break;
                }
            }

            function q_popPost(s1) {
            }

            function btnOk() {
            	sum();
            	
            	for(var i=0;i<q_bbsCount;i++){
                //數量 重量 材積需為數字
                    if((($('#txtMount_'+i).val().length > 0 && !((/^[0-9]+$/g).test($('#txtMount_'+i).val()) || (/^[0-9]+\,[0-9]+$/g).test($('#txtMount_'+i).val()))))){
                        alert('數量輸入錯誤，內有含有中文!');   
                        Unlock(1);
                        return;
                    }
                    if((($('#txtVolume_'+i).val().length > 0 && !((/^[0-9]+$/g).test($('#txtVolume_'+i).val()) || (/^[0-9]+\,[0-9]+$/g).test($('#txtVolume_'+i).val()) || (/^[0-9]+\.[0-9]+$/g).test($('#txtVolume_'+i).val()) || (/^[0-9]+\,[0-9]+\.[0-9]+$/g).test($('#txtVolume_'+i).val()))))){
                        alert('材積輸入錯誤，內有含有中文!');   
                        Unlock(1);
                        return;
                    }
                    if((($('#txtWeight_'+i).val().length > 0 && !((/^[0-9]+$/g).test($('#txtWeight_'+i).val()) || (/^[0-9]+\,[0-9]+$/g).test($('#txtWeight_'+i).val()) || (/^[0-9]+\.[0-9]+$/g).test($('#txtWeight_'+i).val()) || (/^[0-9]+\,[0-9]+\.[0-9]+$/g).test($('#txtWeight_'+i).val()))))){
                        alert('重量輸入錯誤，內有含有中文!');   
                        Unlock(1);
                        return;
                    }
                }
                
                if (q_cur == 1)
                    $('#txtWorker').val(r_name);
                else
                    $('#txtWorker2').val(r_name);
                var t_noa = trim($('#txtNoa').val());
                var t_date = trim($('#txtOdate').val());
                if (q_cur ==1)
					q_gtnoa(q_name, replaceAll(q_getPara('sys.key_trans') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
				else
					wrServer(t_noa);
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)
                    return;
                q_box('tran_jr_s.aspx', q_name + '_s', "500px", "600px", '查詢視窗');
            }

            function bbsAssign() {
                for (var i = 0; i < q_bbsCount; i++) {
					$('#lblNo_' + i).text(i + 1);
                    if($('#btnMinus_' + i).hasClass('isAssign'))
                    	continue;
                    $('#txtCustno_' + i).bind('contextmenu', function(e) {
                        /*滑鼠右鍵*/
                        e.preventDefault();
                        var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
                        $('#btnCust_'+n).click();
                    });
                    $('#txtUccno_' + i).bind('contextmenu', function(e) {
                        /*滑鼠右鍵*/
                        e.preventDefault();
                        var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
                        $('#btnProduct_'+n).click();
                    });
                    $('#txtStraddrno_' + i).bind('contextmenu', function(e) {
                        /*滑鼠右鍵*/
                        e.preventDefault();
                        var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
                        $('#btnStraddr_'+n).click();
                    });
                    $('#txtEndaddrno_' + i).bind('contextmenu', function(e) {
                        /*滑鼠右鍵*/
                        e.preventDefault();
                        var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
                        $('#btnEndaddr_'+n).click();
                    });
                    $('#txtCarno_' + i).bind('contextmenu', function(e) {
                        /*滑鼠右鍵*/
                        e.preventDefault();
                        var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
                        $('#btnCarno_'+n).click();
                    });
                    $('#txtDriverno_' + i).bind('contextmenu', function(e) {
                        /*滑鼠右鍵*/
                        e.preventDefault();
                        var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
                        $('#btnDriver_'+n).click();
                    });
                    $('#txtWeight_' + i).change(function() {
                        sum();
                    });
                    $('#txtWeight2_' + i).change(function() {
                        sum();
                    });
                    $('#txtPrice_' + i).change(function() {
                        sum();
                    });
                    $('#txtPrice2_' + i).change(function() {
                        sum();
                    });
                    $('#txtMount3_' + i).change(function() {
                        sum();
                    });
                }
                _bbsAssign();
                $('#tbbs').find('tr.data').children().hover(function(e){
					$(this).parent().css('background','#F2F5A9');
				},function(e){
					$(this).parent().css('background','#cad3ff');
				});
            }

            function btnIns() {
                _btnIns();
                $('#txtNoa').val('AUTO');
                $('#txttrandate').val(q_date());
                $('#txtDatea').val(q_date()).focus();
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                _btnModi();
            }

            function btnPrint() {
            	q_box('z_tran_sh.aspx' + "?;;;noa=" + trim($('#txtNoa').val()) + ";" + r_accy, '', "95%", "95%", q_getMsg("popPrint"));
            }

            function wrServer(key_value) {
                var i;
                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
            }

            function bbsSave(as) {
                if (!as['straddrno'] && !as['trandate']  && !as['custno']  && !as['nick'] && !as['uccno'] && !as['product'] && !as['mount'] ) {
                    as[bbsKey[1]] = '';
                    return;
                }
                q_nowf();
                as['datea'] = abbm2['datea'];
                as['cno'] = abbm2['cno'];
                as['acomp'] = abbm2['acomp'];
                as['carteamno'] = abbm2['port'];
                return true;
            }

            function refresh(recno) {
                _refresh(recno);
            }

            function readonly(t_para, empty) {
                _readonly(t_para, empty);
            }

            function btnMinus(id) {
                _btnMinus(id);
            }

            function btnPlus(org_htm, dest_tag, afield) {
                _btnPlus(org_htm, dest_tag, afield);
            }

            function q_appendData(t_Table) {
                return _q_appendData(t_Table);
            }

            function btnSeek() {
                _btnSeek();
                q_box('tran_s.aspx', q_name + '_s', "500px", "600px", q_getMsg("popSeek"));
            }

            function btnTop() {
                _btnTop();
            }

            function btnPrev() {
                _btnPrev();
            }

            function btnPrevPage() {
                _btnPrevPage();
            }

            function btnNext() {
                _btnNext();
            }

            function btnNextPage() {
                _btnNextPage();
            }

            function btnBott() {
                _btnBott();
            }

            function q_brwAssign(s1) {
                _q_brwAssign(s1);
            }

            function btnDele() {
                _btnDele();
            }

            function btnCancel() {
                _btnCancel();
            }

		</script>
		<style type="text/css">
            #dmain {
                overflow: auto;
            }
            .dview {
                float: left;
                width: 400px;
                border-width: 0px;
            }
            .tview {
                border: 5px solid gray;
                font-size: medium;
                background-color: black;
            }
            .tview tr {
                height: 30px;
            }
            .tview td {
                padding: 2px;
                text-align: center;
                border-width: 0px;
                background-color: #FFFF66;
                color: blue;
            }
            .dbbm {
                float: left;
                width: 680px;
                /*margin: -1px;
                 border: 1px black solid;*/
                border-radius: 5px;
            }
            .tbbm {
                padding: 0px;
                border: 1px white double;
                border-spacing: 0;
                border-collapse: collapse;
                font-size: medium;
                color: blue;
                background: #cad3ff;
                width: 100%;
            }
            .tbbm tr {
                height: 35px;
            }
            .tbbm tr td {
                width: 12%;
            }
            .tbbm .tr2, .tbbm .tr3, .tbbm .tr4 {
                background-color: #FFEC8B;
            }
            .tbbm .tdZ {
                width: 1%;
            }
            .tbbm tr td span {
                float: right;
                display: block;
                width: 5px;
                height: 10px;
            }
            .tbbm tr td .lbl {
                float: right;
                color: blue;
                font-size: medium;
            }
            .tbbm tr td .lbl.btn {
                color: #4297D7;
                font-weight: bolder;
            }
            .tbbm tr td .lbl.btn:hover {
                color: #FF8F19;
            }
            .txt.c1 {
                width: 100%;
                float: left;
            }
            .txt.num {
                text-align: right;
            }
            .tbbm td {
                margin: 0 -1px;
                padding: 0;
            }
            .tbbm td input[type="text"] {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
                float: left;
            }
            .tbbm select {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
            }
            .dbbs {
                width: 1800px;
            }
            .tbbs a {
                font-size: medium;
            }
            input[type="text"], input[type="button"] {
                font-size: medium;
            }
            .num {
                text-align: right;
            }
            select {
                font-size: medium;
            }
            .font1 {
                font-family: "細明體", Arial, sans-serif;
            }
            #tableTranordet tr td input[type="text"] {
                width: 80px;
            }
            #tbbt {
                margin: 0;
                padding: 2px;
                border: 2px pink double;
                border-spacing: 1;
                border-collapse: collapse;
                font-size: medium;
                color: blue;
                background: pink;
                width: 100%;
            }
            #tbbt tr {
                height: 35px;
            }
            #tbbt tr td {
                text-align: center;
                border: 2px pink double;
            }
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
	<div id="divImport" style="position:absolute; top:250px; left:600px; display:none; width:400px; height:200px; background-color: #cad3ff; border: 5px solid gray;">
            <table style="width:100%;">
                <tr style="height:1px;">
                    <td style="width:150px;"></td>
                    <td style="width:80px;"></td>
                    <td style="width:80px;"></td>
                    <td style="width:80px;"></td>
                    <td style="width:80px;"></td>
                </tr>
                <tr style="height:35px;">
                    <td><span> </span><a id="lblMon" style="float:right; color: blue; font-size: medium;">月份</a></td>
                    <td colspan="4">
                    <input id="textMon"  type="text" style="float:left; width:100px; font-size: medium;"/>
                    </td>
                </tr>               
                <tr style="height:35px;">
                    <td> </td>
                    <td><input id="btnImport_trans" type="button" value="付款"/></td>
                    <td></td>
                    <td></td>
                    <td><input id="btnCancel_import" type="button" value="關閉"/></td>
                </tr>
            </table>
        </div>
		<!--#include file="../inc/toolbar.inc"-->
		<div id="dmain" >
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:5%"><a id="vewChk"> </a></td>
						<td align="center" style="display:none;"><a> </a></td>
						<td align="center" style="width:20%"><a>日期</a></td>
						<td align="center" style="width:20%"><a>出車單號</a></td>
					</tr>
					<tr>
						<td>
						<input id="chkBrow.*" type="checkbox"/>
						</td>
						<td align="center" id='datea'>~datea</td>
						<td align="center" id='noa'>~noa</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm"  id="tbbm">
					<tr class="tr0" style="height:1px;">
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td class="tdZ"></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblNoa" class="lbl" > </a></td>
						<td>
						<input id="txtNoa" type="text" class="txt c1"/>
						</td>
						<td><span> </span><a id="lblDatea" class="lbl" > </a></td>
						<td>
						<input id="txtDatea" type="text" class="txt c1" />
						</td>
					</tr>
					<!--<tr>
                        <td><span> </span><a id="lblCno" class="lbl btn" >公司</a></td>
                        <td colspan="3">
                            <input type="text" id="txtCno" class="txt" style="float:left;width:40%;"/>
                            <input type="text" id="txtAcomp" class="txt" style="float:left;width:60%;"/>
                        </td>
                    </tr>-->
                    <tr>
                        <td><span> </span><a id="lblCarteam" class="lbl">車隊</a></td>
                        <td>
                            <select id="cmbPort" class="txt c1"> </select>
                        </td>
                    </tr>
                    <tr>
                        <td><span> </span><a id="lblAddr" class="lbl btn" >客戶</a></td>
                        <td colspan="3">
                            <input type="text" id="txtAddrno" class="txt" style="float:left;width:40%;"/>
                            <input type="text" id="txtAddr" class="txt" style="float:left;width:60%;"/>
                        </td>
                    </tr>
					<tr>
                        <td><span> </span><a id="lbl" class="lbl" >應收金額</a></td>
                        <td><input id="txtTotal" type="text" class="txt c1 num" /></td>
                        <td><span> </span><a id="lbl" class="lbl" >應付金額</a></td>
                        <td><input id="txtTotal2" type="text" class="txt c1 num" /></td>
                    </tr>
					<!--<tr>
					    <td><span> </span><a id="lbl" class="lbl" >發票號碼</a></td>
                        <td>
                        <input id="txtDeparture" type="text" class="txt c1" />
                        </td>
						<td><span> </span><a id="lbl" class="lbl" >稅金</a></td>
						<td>
						<input id="txtTotal2" type="text" class="txt c1 num" />
						</td>
					</tr>-->
					<tr>
						<td><span> </span><a id="lblMemo" class="lbl" > </a></td>
						<td colspan="4"><textarea id="txtMemo" style="height:40px;" class="txt c1"> </textarea></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblWorker" class="lbl" > </a></td>
						<td>
						<input id="txtWorker" type="text" class="txt c1"/>
						</td>
						<td><span> </span><a id="lblWorker2" class="lbl" > </a></td>
						<td>
						<input id="txtWorker2" type="text" class="txt c1" />
						</td>
						<td><input id="btnOrde" type="button" value="派車匯入" style="width:100%;"/></td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs' >
			<table id="tbbs" class='tbbs' >
				<tr style='color:white; background:#003366;' >
					<td align="center" style="width:25px"><input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  /></td>
					<td align="center" style="width:20px;"> </td>
					<td align="center" style="width:90px"><a>出車日期</a></td>
					<td align="center" style="width:80px"><a>客戶</a></td>
					<td align="center" style="width:100px"><a>品項</a></td>
					<td align="center" style="width:70px"><a>數量</a></td>
					<td align="center" style="width:50px"><a>單位</a></td>
					<td align="center" style="width:70px"><a>材積</a></td>
					<td align="center" style="width:70px"><a>材積重量</a></td>
					<td align="center" style="width:70px"><a>重量</a></td>
					<td align="center" style="width:100px"><a>起點</a></td>
                    <td align="center" style="width:100px"><a>迄點</a></td>
                    <td align="center" style="width:120px"><a>櫃號</a></td>
                    <td align="center" style="width:120px"><a>S/O</a></td>
                    <td align="center" style="width:80px"><a>貨主</a></td>
					<td align="center" style="width:80px"><a>應收運費</a></td>
					<td align="center" style="width:80px"><a>應付運費</a></td>
					<td align="center" style="width:90px"><a>出車車號</a></td>
					<td align="center" style="width:80px"><a>司機</a></td>
					<td align="center" style="width:170px"><a>派車單號</a></td>
					<td align="center" style="width:100px"><a>備註</a></td>
				</tr>
				<tr class="data" style='background:#cad3ff;'>
					<td align="center">
						<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
						<input type="text" id="txtNoq.*" style="display:none;"/>
					</td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td><input type="text" id="txtTrandate.*" style="width:95%;"/></td>
					<td>
						<input type="text" id="txtCustno.*" style="float:left;width:95%;" />
						<input type="text" id="txtComp.*" style="display:none;">
						<input type="text" id="txtNick.*" style="float:left;width:95%;">
						<input type="button" id="btnCust.*" style="display:none;">
					</td>
					<td>
                        <input type="text" id="txtUccno.*" style="float:left;width:95%;" />
                        <input type="text" id="txtProduct.*" style="float:left;width:95%;">
                        <input type="button" id="btnProduct.*" style="display:none;">
                    </td>
					<td><input type="text" id="txtMount.*" class="num" style="width:95%;"/></td>
					<td><input type="text" id="txtUnit.*" style="width:95%;"/></td>
					<td><input type="text" id="txtVolume.*" class="num" style="width:95%;"/></td>
					<td><select id="cmbUnit2.*" class="txt" style="width:95%;"> </select></td>
					<td><input type="text" id="txtWeight.*" class="num" style="width:95%;"/></td>
					<td>
                        <input type="text" id="txtStraddrno.*" style="float:left;width:95%;"/>
                        <input type="text" id="txtStraddr.*" style="float:left;width:95%;"/>
                        <input type="button" id="btnStraddr.*" style="display:none;"/>
                    </td>
                    <td>
                        <input type="text" id="txtEndaddrno.*" style="float:left;width:95%;"/>
                        <input type="text" id="txtEndaddr.*" style="float:left;width:95%;"/>
                        <input type="button" id="btnEndaddr.*" style="display:none;"/>
                    </td>
                    <td><input type="text" id="txtCaseno.*" style="width:95%;"/></td>
                    <td><input type="text" id="txtPo.*" style="width:95%;"/></td>
                    <td>
                        <input type="text" id="txtCasecustno.*" style="float:left;width:95%;"/>
                        <input type="text" id="txtCasecust.*" style="float:left;width:95%;"/>
                        <input type="button" id="btnCasecust.*" style="display:none;"/>
                    </td>
					<td><input type="text" id="txtTotal.*" class="num" style="width:95%;"/></td>
					<td><input type="text" id="txtTotal2.*" class="num" style="width:95%;"/></td>
					<td>
						<input type="text" id="txtCarno.*" style="float:left;width:95%;"/>
						<input type="button" id="btnCarno.*" style="display:none;"/>
					</td>
					<td>
                        <input type="text" id="txtDriverno.*" style="float:left;width:95%;"/>
                        <input type="text" id="txtDriver.*" style="float:left;width:95%;"/>
                        <input type="button" id="btnDriver.*" style="display:none;"/>
                    </td>
					<td align="center">
					    <input type="text" id="txtOrdeno.*" style="width:95%;"/>
					    <input type="text" id="txtCaseno2.*" style="width:30%;"/>
					</td>
					<td><input type="text" id="txtMemo.*" style="width:95%;"/></td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden"/>
	</body>
</html>