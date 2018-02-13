<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title></title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
			this.errorHandler = null;
			function onPageError(error) {
				alert("An error occurred:\r\n" + error.Message);
			}

			q_tables = 's';
			var q_name = "get";
			var q_readonly = ['txtNoa', 'txtWorker','txtStation','txtComp','txtStore','txtCardeal','txtWorker2'];
			var q_readonlys = ['txtOrdeno','txtNo2'];
			var bbmNum = [['txtTotal', 15, 1,1],['txtPrice', 10, 2 ,1],['txtTranmoney', 15, 0,1]];
			var bbsNum = [
				['txtSize1', 10, 3], ['txtSize2', 10, 2], ['txtSize3', 10, 3],
				['txtSize4', 10, 2], ['txtRadius', 10, 3], ['txtWidth', 10, 2],
				['txtDime', 10, 3], ['txtLengthb', 10, 2], ['txtMount', 10, 0],
				['txtWeight', 10, 1]
			];
			var bbmMask = [];
			var bbsMask = [];
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'Datea';

			aPop = new Array(
				['txtStoreno', 'lblStore', 'store', 'noa,store', 'txtStoreno,txtStore', 'store_b.aspx'],
				['txtProductno_', 'btnProductno_', 'ucc', 'noa,product,unit', 'txtProductno_,txtProduct_,txtUnit_', 'ucc_b.aspx'],
				['txtCardealno', 'lblCardeals', 'driver', 'noa,namea', 'txtCardealno,txtCardeal', 'driver_b.aspx'],
				['txtCustno', 'lblCustno', 'cust', 'noa,comp', 'txtCustno,txtComp', 'cust_b.aspx'],
				['txtTranstartno', 'lblTranstartno', 'conn', 'namea,addr,tel,fax', 'txtTranstartno,txtTranstart,txtTrantype,txtTranstyle', '']
			);

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
				mainForm(1);
			}

			function mainPost() {
				q_getFormat();
				bbmMask = [['txtDatea', r_picd], ['txtCucdate', r_picd]];
				q_mask(bbmMask);
				q_cmbParse("cmbSpec",'坪@坪,M^3@M^3,噸@噸,材@材','s');
				$('#txtCustno').change(function() {
                    if (!emp($('#txtCustno').val())) {
                        var t_where = "custno='" + $('#txtCustno').val() + "' and datea>='"+q_cdn(q_date(),-183)+"' ^^ stop=999";
                        q_gt('view_get', t_where, 0, 0, 0, "custgetaddr", r_accy);
                    }
                });
                
                $('#btnPrice').click(function(e) {//價格
                      t_where = "custno='" + $('#txtCustno').val() + "'";
                      q_box("contdc_sh.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'etc', "95%", "95%", q_getMsg('btnPirce'));
                });
                
                $('#btnOrde').click(function(e){
                    t_custno=$('#txtCustno').val();
                    var t_where = "(noa+noq in (select sa.noa+sa.noq from view_inas sa left join view_ina sb on sa.noa=sb.noa outer apply(select sum(isnull(mount,0))mount from view_gets where sa.noa=ordeno and sa.noq=no2 group by ordeno,no2)b where sa.mount!=ISNULL(b.mount,0) and sb.custno='"+t_custno+"' group by sa.noa,sa.noq))";
                    q_box("ina_sh_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'ordes', "75%", "650px");
                });
                
                $('#lblTranstartno').click(function(e){
                    t_custno=$('#txtCustno').val();
                    var t_where = "noa='"+t_custno+"'";
                    q_box("conn_b_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'conn', "75%", "650px");
                });
			}

			function q_boxClose(s2) {
				var ret;
				switch (b_pop) {
					case 'ordes':
						if (q_cur > 0 && q_cur < 4) {
							b_ret = getb_ret();
							if (!b_ret || b_ret.length == 0){
								b_pop = '';
								return;
							}
							var i, j = 0;
							ret = q_gridAddRow(bbsHtm, 'tbbs', 'txtProductno,txtProduct,txtSpec,txtWeight,txtMount,txtUnit,txtOrdeno,txtNo2', b_ret.length, b_ret, 'productno,product,spec,mweight,mount,unit,noa,noq', 'txtProductno,txtProduct,txtSpec');
							bbsAssign();
						}
						break;
					case q_name + '_s':
						q_boxClose2(s2);
						break;
				}
				b_pop = '';
			}
			var carnoList = [];
			var thisCarSpecno = '';

			function q_gtPost(t_name) {
				switch (t_name) {
                    case 'btnModi':
                        var as = _q_appendData("get", "", true);
                        if (as[0] != undefined) {
                            if(r_rank<=7 && $('#txtDatea').val()<=q_cdn(q_date(),-1*40)){
                                alert('只能修改40天內資料!');
                                Unlock(1);
                                return;
                            }
                        }
                        _btnModi();
                        Unlock(1);
                        $('#txtDatea').focus();
                        break;
					case q_name:
						if (q_cur == 4)
							q_Seek_gtPost();
						break;
				}
			}

			function btnOk() {
				t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')]]);
				if (t_err.length > 0) {
					alert(t_err);
					return;
				}
				if (q_cur == 1)
					$('#txtWorker').val(r_name);
				else
					$('#txtWorker2').val(r_name);
					
				sum();
				var s1 = $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val();
				if (s1.length == 0 || s1 == "AUTO")
					q_gtnoa(q_name, replaceAll(q_getPara('sys.key_get') + $('#txtDatea').val(), '/', ''));
				else
					wrServer(s1);
			}

			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)
					return;
				q_box('get_s.aspx', q_name + '_s', "500px", "330px", q_getMsg("popSeek"));
			}

			function bbsAssign() {
				for (var j = 0; j < (q_bbsCount == 0 ? 1 : q_bbsCount); j++) {
					if (!$('#btnMinus_' + j).hasClass('isAssign')) {
						$('#btnMinus_' + j).click(function() {
							btnMinus($(this).attr('id'));
						});
						
						$('#txtMount_' + j).change(function() {
                           sum();
                        });
                        
                        $('#txtMount_' + i).focusin(function(e) {
                            if (q_cur == 1 || q_cur == 2) {
                                t_IdSeq = -1;
                                q_bodyId($(this).attr('id'));
                                b_seq = t_IdSeq;
                                if (!emp($('#txtNoa_' + b_seq).val())) {
                                    //庫存
                                    mouse_point=e;
                                    mouse_point.pageY=$('#txtMount_'+b_seq).offset().top;
                                    mouse_point.pageX=$('#txtMount_'+b_seq).offset().left;
                                    document.getElementById("stk_Noa").innerHTML = $('#txtNoa_' + b_seq).val();
                                    document.getElementById("stk_Noq").innerHTML = $('#txtNoq_' + b_seq).val();
                                    //庫存
                                    var t_where = "where=^^  ^^";
                                    q_gt('calstk', t_where, 0, 0, 0, "msg_stk_all", r_accy);
                                }
                            }
                        });
					}
				}
				_bbsAssign();
			}

			function btnIns() {
				_btnIns();
				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val('AUTO');
				$('#txtDatea').val(q_date());
				$('#txtDatea').focus();
			}

			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				var t_where = " where=^^ noa='" + $('#txtNoa').val() + "'^^";
                q_gt('get', t_where, 0, 0, 0, 'btnModi', r_accy);
			}

			function btnPrint() {
				q_box('z_ina_sh.aspx' + "?;;;;" + r_accy + ";noa=" + trim($('#txtNoa').val()), '', "95%", "95%", q_getMsg("popPrint"));
			}

			function wrServer(key_value) {
				var i;
				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
			}

			function bbsSave(as) {
				if (!as['productno']) {
					as[bbsKey[1]] = '';
					return;
				}

				q_nowf();
				as['datea'] = abbm2['datea'];
				as['custno'] = abbm2['custno'];
				return true;
			}

			function sum() {
                var t_mount= 0;
                for (var j = 0; j < q_bbsCount; j++) {
                    t_mount =t_mount+q_float('txtMount_' + j);
                }
                $('#txtTotal').val(dec(t_mount));
            }
            
			function refresh(recno) {
				_refresh(recno);
			}

			function readonly(t_para, empty) {
				_readonly(t_para, empty);
			}

			function btnMinus(id) {
				_btnMinus(id);
				sum();
			}

			function btnPlus(org_htm, dest_tag, afield) {
				_btnPlus(org_htm, dest_tag, afield);
			}

			function q_appendData(t_Table) {
				return _q_appendData(t_Table);
			}

			function btnSeek() {
				_btnSeek();
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
			
			function q_popPost(s1) {
                switch (s1) {
                    case 'txtCustno':
                        if (!emp($('#txtCustno').val())) {
                            var t_where = "where=^^ custno='" + $('#txtCustno').val() + "' and datea<='"+q_date()+"' ^^ stop=999";
                            q_gt('view_get', t_where, 0, 0, 0, "custgetaddr", r_accy);
                        }
                        break;
                }
            }
			
			function combAddr_chg() {
                if (q_cur == 1 || q_cur == 2) {
                    $('#txtTranstart').val($('#combAddr').find("option:selected").text());
                    $('#txtTranstartno').val($('#combAddr').find("option:selected").val());
                }
            }
		</script>
		<style type="text/css">
			#dmain {
				overflow: hidden;
			}
			.dview {
				float: left;
				width: 98%;
			}
			.tview {
				margin: 0;
				padding: 2px;
				border: 1px black double;
				border-spacing: 0;
				font-size: medium;
				background-color: #FFFF66;
				color: blue;
			}
			.tview td {
				padding: 2px;
				text-align: center;
				border: 1px black solid;
			}
			.dbbm {
				float: left;
				width: 98%;
				margin: -1px;
				border: 1px black solid;
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
				width: 9%;
			}
			.tbbm .tdZ {
				width: 2%;
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
				font-size: medium;
			}
			.tbbm tr td .lbl.btn:hover {
				color: #FF8F19;
			}
			.txt.c1 {
				width: 98%;
				float: left;
			}
			.txt.c2 {
				width: 38%;
				float: left;
			}
			.txt.c3 {
				width: 60%;
				float: left;
			}
			.txt.num {
				text-align: right;
			}
			.tbbm td {
				margin: 0 -1px;
				padding: 0;
			}
			
			num {
                text-align: right;
            }
            
            select {
                font-size: medium;
            }
            
            .font1 {
                font-family: "細明體", Arial, sans-serif;
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
				font-size: medium;
			}

			input[type="text"], input[type="button"] {
				font-size: medium;
			}
			.dbbs .tbbs {
				margin: 0;
				padding: 2px;
				border: 2px lightgrey double;
				border-spacing: 1px;
				border-collapse: collapse;
				font-size: medium;
				color: blue;
				background: #cad3ff;
				width: 100%;
			}
			.dbbs .tbbs tr {
				height: 35px;
			}
			.dbbs .tbbs tr td {
				text-align: center;
				border: 2px lightgrey double;
			}
		</style>
	</head>
	<body>
	   <div id="div_stk" style="position:absolute; top:300px; left:400px; display:none; width:400px; background-color: #CDFFCE; border: 5px solid gray;">
            <table id="table_stk" style="width:100%;" border="1" cellpadding='2'  cellspacing='0'>
                <tr>
                    <td style="background-color: #f8d463;" align="center">單據編號</td>
                    <td style="background-color: #f8d463;" colspan="2" id='stk_noa'> </td>
                </tr>
                <tr>
                    <td style="background-color: #f8d463;" align="center">項次</td>
                    <td style="background-color: #f8d463;" colspan="2" id='stk_noq'> </td>
                </tr>
                <tr>
                    <td style="background-color: #f8d463;" align="center">品名</td>
                    <td style="background-color: #f8d463;" colspan="2" id='stk_product'> </td>
                </tr>
                <tr>
                    <td style="background-color: #f8d463;" align="center">貨物數量</td>
                    <td style="background-color: #f8d463;" colspan="2" id='stk_mount'> </td>
                </tr>
                <tr id='stk_close'>
                    <td align="center" colspan='3'>
                        <input id="btnClose_div_stk" type="button" value="關閉視窗">
                    </td>
                </tr>
            </table>
        </div>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' style="width: 1260px;">
			<div class="dview" id="dview" style="float: left; width:32%;" >
				<table class="tview" id="tview" border="1" cellpadding='2' cellspacing='0' style="background-color: #FFFF66;">
					<tr>
						<td align="center" style="width:5%"><a id='vewChk'> </a></td>
						<td align="center" style="width:20%"><a id='vewDatea'> </a></td>
						<td align="center" style="width:25%"><a id='vewCust'>客戶</a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" style=' '/></td>
						<td align="center" id='datea'>~datea</td>
						<td align="center" id='comp'>~comp</td>
					</tr>
				</table>
			</div>
			<div class='dbbm' style="width: 55%;float:left">
				<table class="tbbm" id="tbbm" border="0" cellpadding='2' cellspacing='0'>
					<tr class="tr1">
						<td class='td1'><span> </span><a id="lblDatea_sh" class="lbl" >出貨日期</a></td>
						<td class="td2"><input id="txtDatea" type="text" class="txt c1"/></td>
						<td class='td3'><span> </span><a id="lblNoa_sh" class="lbl" >出貨單號</a></td>
						<td class="td4"><input id="txtNoa" type="text" class="txt c1"/></td>
					</tr>
					<tr class="tr2">
						<td class='td1'><span> </span><a id="lblCustno" class="lbl btn" > </a></td>
						<td class="td2" colspan="3">
							<input id="txtCustno" type="text" class="txt c2"/>
							<input id="txtComp" type="text" class="txt c3"/>
						</td>
						<td colspan="2"><input type="button" id="btnPrice" value="合約價格"/>
						                <input id="btnOrde" type="button" value="入庫匯入"/>
						</td>
					</tr>
					<!--<tr class="tr4">
						<td class="td1"><span> </span><a id="lblStore" class="lbl btn"> </a></td>
						<td class="td2" colspan="3">
							<input id="txtStoreno" type="text" class="txt c2" />
							<input id="txtStore" type="text" class="txt c3"/>
						</td>
					</tr>-->
					<tr class="tr3">
						<td class="td1"><span> </span><a id="lblAddr" class="lbl">地址</a></td>
						<td class="td2" colspan="3">
							<input id="txtAddr" type="text" class="txt c1"/>
						</td>
					</tr>
					<tr class="tr4">
						<td class="td1"><span> </span><a id="lblTranstartno" class="lbl btn">受貨商</a></td>
						<td class="td2" colspan="3"><input id="txtTranstartno" type="text" class="txt c3"/></td>
						<td class="td1"><span> </span><a id="lblTrantype_sh" class="lbl">電話</a></td>
						<td class="td2" colspan="3"><input id="txtTrantype" type="text" class="txt c3" style="width:95%;"/></td>
					</tr>
					<tr class="tr4">
                        <td class="td3"><span> </span><a id="lblTranstart" class="lbl">受貨商地址</a></td>
                        <td class="td4" colspan="3">
                            <input id="txtTranstart" type="text" class="txt c1" style="width:95%;"/>
                        </td>
                        <td class="td1"><span> </span><a id="lblTranstyle_sh" class="lbl">傳真</a></td>
                        <td class="td2" colspan="3"><input id="txtTranstyle" type="text" class="txt" style="width:95%;"/></td>
                    </tr>
                    <tr class="tr4">
                        <td><span> </span><a id="lblCardeals" class="lbl btn">司機</a></td>
                        <td colspan="2">
                            <input type="text" id="txtCardealno" class="txt" style="float:left;width:40%;"/>
                            <input type="text" id="txtCardeal" class="txt" style="float:left;width:60%;"/>
                        </td>
                    </tr>
					<tr class="tr5">
						<td class="td1"><span> </span><a id="lblPrice_sh" class="lbl">理貨費</a></td>
						<td class="td2"><input id="txtPrice" type="text" class="txt c1 num" /></td>
						<td class="td3"><span> </span><a id="lblTranmoney_sh" class="lbl">推高費</a></td>
						<td class="td4"><input id="txtTranmoney" type="text" class="txt c1 num" /></td>
						<td class="td5"><span> </span><a id="lblMoney" class="lbl">加班費</a></td>
                        <td class="td6"><input id="txtMoney" type="text" class="txt c1 num" /></td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id="lblTotal_sh" class="lbl">總數量</a></td>
						<td class="td2"><input id="txtTotal" type="text" class="txt c1 num" /></td>
						<td class='td3'><span> </span><a id="lblWorker" class="lbl"> </a></td>
						<td class="td4" colspan="2"><input id="txtWorker" type="text" class="txt" style="width: 50%"/>
						                <input id="txtWorker2" type="text" class="txt" style="width: 50%"/></td>
					</tr>
					<tr class="tr9">
						<td class='td1'><span> </span><a id="lblMemo" class="lbl" > </a></td>
						<td class="td2" colspan='5'>
							<textarea id="txtMemo" cols="10" rows="5" style="width: 99%; height: 50px;" > </textarea>
						</td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs' style="width: 1260px;">
			<table id="tbbs" class='tbbs' border="1" cellpadding='2' cellspacing='1' >
				<tr style='color:White; background:#003366;' >
                    <td align="center" style="width:1%;"><input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  /> </td>
                    <td align="center" style="width:10%;"><a id='lblProductno_s'> </a></td>
                    <td align="center" style="width:20%;"><a id='lblProduct_sh'>品名</a></td>
                    <td align="center" style="width:8%;"><a id='lblSpec_sh'>計價單位</a></td>
                    <td align="center" style="width:8%;"><a id='lblWeight_sh'>計價量(面積)</a></td>
                    <td align="center" style="width:8%;"><a id='lblUnit_sh'>貨物單位</a></td>
                    <td align="center" style="width:8%;"><a id='lblMount_sh'>貨物數量</a></td>
                    <td align="center" style="width:10%;"><a id='lblType_sh'>儲位</a></td>
                    <td align="center" style="width:10%;"><a id='lblOrdeno_sh'>入庫單號</a></td>
                    <td align="center" id='Memo'><a id='lblMemo_s'> </a></td>
                </tr>
                <tr  style='background:#cad3ff;'>
                    <td><input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" /></td>
                    <td><input id="txtProductno.*" type="text" style="width:75%;" />
                        <input class="btn"  id="btnProductno.*" type="button" value='...' style="width:15%;"/>
                    </td>
                    <td><input class="txt c1" id="txtProduct.*" type="text" /></td>
                    <td><select id="cmbSpec.*" class="txt" style="width:95%;"> </select></td>
                    <td><input class="txt num c1" id="txtWeight.*" type="text"/></td>
                    <td><input class="txt c1" id="txtUnit.*" type="text"/></td>
                    <td><input class="txt num c1" id="txtMount.*" type="text"/></td>
                    <td><input class="txt  c1" id="txtTypea.*" type="text"/></td>
                    <td><input class="txt c1" id="txtOrdeno.*" type="text" />
                        <input class="txt c1" id="txtNo2.*" type="text" />   
                        <input id="txtNoq.*" type="hidden" /><input id="recno.*" type="hidden" /></td>
                    <td><input class="txt c1" id="txtMemo.*" type="text" />
                </tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>