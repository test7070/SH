<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"></script>
		<script src="css/jquery/ui/jquery.ui.widget.js"></script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"></script>
		<script type="text/javascript">
			var q_name = "tranvcces";
			var q_readonly = ['txtNoa','txtNoq','txtTime1','txtWorker','txtWorker2','txtConn'];
			var bbmNum = [['txtTotal',10,0,1],['txtTotal2',10,0,1]];
			var bbmMask = [];
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'noa,noq';
			q_desc = 1;
            q_xchg = 1;
            brwCount2 = 20;

            aPop = new Array(
             ['txtCustno', 'lblCustno', 'cust', 'noa,paytype,nick', 'txtCustno,cmbTypea,txtCust', 'cust_b.aspx']
            , ['txtProductno_', 'lblProductno', 'ucc', 'noa,product', 'txtProductno,txtProduct', 'ucc_b.aspx']
            , ['txtCarno', 'lblCarno', 'car2', 'driverno,a.noa,driver', 'txtDriverno,txtCarno,txtDriver', 'car2_b.aspx']
            , ['txtAddrno', '', 'addr', 'noa,addr', '0txtAddrno,txtAddr', 'addr_b.aspx']
            , ['txtAddrno2', '',  'addr', 'noa,addr', '0txtAddrno2,txtAddr2', 'addr_b.aspx']
            , ['txtDriverno', 'lblDriver', 'driver', 'noa,namea', 'txtDriverno,txtDriver', 'driver_b.aspx']);
            	
			$(document).ready(function() {
				bbmKey = ['noa','noq'];
				q_brwCount();
				q_content='order=^^noa desc,no2^^'
				q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);

			});
			function main() {
				if (dataErr) {
					dataErr = false;
					return;
				}
				mainForm(0);
				window.parent.document.title='讀單作業';
			}
            
			function mainPost() {
			    q_getFormat();
                q_mask(bbmMask);
			    $('#btnIns').hide();
			    q_cmbParse("cmbTypea",'月結@月結,付清@付清');
			    $('#lblNoa').click(function() {
                    q_pop('txtNoa', "tranvcce_sh.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";charindex(noa,'" + $('#txtNoa').val() + "')>0;" + r_accy + '_' + r_cno, 'tranvcce', 'noa', '', "100%", "1024px", q_getMsg('lblNoa'), true);
                });
                
                $('#btnApv').click(function() {
                    var t_noa = $('#txtNoa').val();
                    var t_noq = $('#txtNoq').val();
                    var t_chk1='1';
                    q_func('qtxt.query.tranvccesh_chk1', 'tranvcce.txt,tranvccesh_chk1,' + encodeURI(t_noa) + ';' + encodeURI(t_noq)+ ';' + encodeURI(r_name)+ ';' + encodeURI(t_chk1));
                    
                    $('#chkChk1').prop('checked', true);
                    
                    for (var i = 0; i < brwCount; i++) {
                        if($('#vtnoa_'+i).text()!=''){
                             if($('#vtnoa_'+i).text()==$('#txtNoa').val() && $('#vtnoq_'+i).text()==$('#txtNoq').val()){
                                 $('#vtchk1_'+i).text('V');
                             }
                        }
                        $('#chkBrow_'+i).focus();
                    }
                });
			}
			
			function q_funcPost(t_func, result) {
                switch(t_func) {
                    case 'qtxt.query.tranvccesh_chk1':
                        var as = _q_appendData("tmp0", "", true, true);
                        alert(as[0].msg);
                        break;
                    default:
                        break;
                }
            }

			function sum() {
				
			}

			function q_boxClose(s2) {
				var ret;
				switch (b_pop) {
					case q_name + '_s':
						q_boxClose2(s2);
						break;
				}
			}

			function q_gtPost(t_name) {
				switch (t_name) {
					case q_name:
						if (q_cur == 4)
							q_Seek_gtPost();
						break;
					default:
						break;
				}
			}
			function q_popPost(id) {
				switch(id) {
				}
			}

			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)
					return;
				q_box('tranvcces_sh_s.aspx', q_name + '_s', "550px", "600px", q_getMsg("popSeek"));
			}
			function btnIns() {
				_btnIns();
				$('#txtNoa').val('AUTO');
			}
			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				_btnModi();
				sum();
			}
			function btnPrint() {
				q_box('z_tran_sh.aspx' + "?;;;;" + r_accy, '', "95%", "95%", q_getMsg("popPrint"));
			}
			function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
            }
			function btnOk() {
                sum();
                if(q_cur ==2){
                    $('#txtConn').val(r_name);
                }else{
                    alert("error: btnok!");
                }
                var t_noa = trim($('#txtNoa').val());
                var t_date = trim($('#txtDatea').val());
                if (t_noa.length == 0 || t_noa == "AUTO")
                    q_gtnoa(q_name, replaceAll(q_getPara('sys.key_tranvcce') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
                else
                    wrServer(t_noa);		
			}

			function wrServer(key_value) {  
				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], '', '', 2);
			}

			function refresh(recno) {
				_refresh(recno);
				for (var i = 0; i < brwCount; i++) {
                        if($('#vtchk1_'+i).text()=='V'){
                            if($('#vtnoa_'+i).text()==$('#txtNoa').val() && $('#vtnoq_'+i).text()==$('#txtNoq').val()){
                                 $('#chkChk1').prop('checked', true);
                             }                           
                        }
                        $('#chkBrow_'+i).focus();
                }
			}

			function readonly(t_para, empty) {
				_readonly(t_para, empty);
				if(t_para){
					$('#txtDatea').datepicker('destroy');
				}else{
					$('#txtDatea').datepicker();
				}            
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
            function FormatNumber(n) {
            	var xx = "";
            	if(n<0){
            		n = Math.abs(n);
            		xx = "-";
            	}     		
                n += "";
                var arr = n.split(".");
                var re = /(\d{1,3})(?=(\d{3})+$)/g;
                return xx+arr[0].replace(re, "$1,") + (arr.length == 2 ? "." + arr[1] : "");
            }
		</script>
		<style type="text/css">
			#dmain {
                overflow: auto;
            }
            .dview {
                float: left;
                width: 1900px;
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
                background-color: #cad3ff;
                color: blue;
            }
            .dbbm {
                float: left;
                width: 800px;
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
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
    ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
    ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
    ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
    >
		<!--#include file="../inc/toolbar.inc"-->
		<div id="dmain">
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:20px; color:black;"><a id="vewChk"> </a></td>
						<td align="center" style="width:30px"><a>讀單</a></td>
						<td align="center" style="width:30px"><a>列印</a></td>
						<td align="center" style="width:100px"><a>電腦編號 </a></td>
						<td align="center" style="width:40px"><a>項次</a></td>
                        <td align="center" style="width:40px"><a>付款</a></td>
                        <td align="center" style="width:90px;"><a>出車日期</a></td>
                        <td align="center" style="width:90px"><a>客戶</a></td>
                        <td align="center" style="width:100px"><a>品項</a></td>
                        <td align="center" style="width:75px"><a>數量</a></td>
                        <td align="center" style="width:50px"><a>單位</a></td>
                        <td align="center" style="width:75px"><a>材積</a></td>
                        <td align="center" style="width:55px"><a>材積單位</a></td>
                        <td align="center" style="width:75px"><a>重量(KG)</a></td>
                        <td align="center" style="width:120px"><a>起點</a></td>
                        <td align="center" style="width:120px"><a>迄點</a></td>
                        <td align="center" style="width:120px"><a>櫃號</a></td>
                        <td align="center" style="width:80px"><a>金額</a></td>
                        <td align="center" style="width:90px"><a>車牌</a></td>
                        <td align="center" style="width:70px"><a>司機編號</a></td>
                        <td align="center" style="width:70px"><a>司機</a></td>
                        <td align="center" style="width:80px"><a>司機運費</a></td>
                        <td align="center" style="width:250px"><a>備註</a></td>
					</tr>
					<tr>
						<td ><input id="chkBrow.*" type="checkbox"/></td>
						<td id="chk1" style="text-align: center;">~chk1</td>
						<td id="chk2" style="text-align: center;">~chk2</td>
						<td id="noa" style="text-align: center;">~noa</td>
						<td id="noq" style="text-align: center; display: none">~noq</td>
						<td id="no2" style="text-align: center;">~no2</td>
						<td id="typea" style="text-align: center;">~typea</td>
						<td id="time1" style="text-align: center;">~time1</td>
						<td id="comp" style="text-align: center;">~comp</td>
						<td id="product" style="text-align: center;">~product</td>
						<td id="mount" style="text-align: center;">~mount</td>
						<td id="unit" style="text-align: center;">~unit</td>
						<td id="volume" style="text-align: center;">~volume</td>
						<td id="unit2" style="text-align: center;">~unit2</td>
						<td id="weight" style="text-align: center;">~weight</td>
						<td id="addr" style="text-align: center;">~addr</td>
						<td id="addr2" style="text-align: center;">~addr2</td>
						<td id="tranno" style="text-align: center;">~tranno</td>
						<td id="total" style="text-align: center;">~total</td>
						<td id="carno" style="text-align: center;">~carno</td>
						<td id="driverno" style="text-align: center;">~driverno</td>
						<td id="driver" style="text-align: center;">~driver</td>
						<td id="total2" style="text-align: center;">~total2</td>
						<td id="memo" style="text-align: center;">~memo</td>
					</tr>
				</table>
			</div>
			<div class="dbbm">
				<table class="tbbm"  id="tbbm">
					<tr style="height:1px;">
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
                        <td> </td>
                        <td> </td>
						<td class="tdZ"> </td>
					</tr>
					<tr>
					    <td><span> </span><a id="lblNoa" class="lbl btn" >電腦編號</a></td>
					    <td colspan="2"><input id="txtNoa" type="text" class="txt" style="width: 70%"/>
                            <input id="txtNoq" type="text" class="txt" style="width:30%"/>
                            
                        </td>
                        <td><span> </span><a id="lblN2" class="lbl" >項次</a></td>
                        <td><input id="txtNo2" type="text" class="txt" style="width:40%"/> </td>
                        <td style="text-align: right;"><input id="chkChk1" type="checkbox" style="zoom:1.2"/>
                            <span> </span><a id='lblChk1'>讀單</a></td>
                        <td><input id="btnApv" type="button" value="讀單"/></td>
                    </tr>
                    <tr>
                        <td><span> </span><a id="lblTime1" class="lbl" >日期</a></td>
                        <td colspan="2"><input id="txtTime1" type="text" class="txt c1" /></td>
                        <td><span> </span><a id="lblTypea" class="lbl" >付款</a></td>
                        <td><select id="cmbTypea" class="txt c1"> </select></td>
                        <td style="text-align: right;"><input id="chkChk2" type="checkbox" style="zoom:1.2"/>
                        <span> </span><a id='lblChk2'>列印</a></td>
                    </tr>
                    <tr>
                        <td><span> </span><a id="lblCustno" class="lbl btn" >客戶</a></td>
                        <td colspan="2"><input id="txtCustno" type="text" class="txt" style="width: 40%"/>
                            <input id="txtCust" type="text" class="txt" style="width:60%"/>
                        </td>
                        <td><span> </span><a id="lblTotal" class="lbl" >金額</a></td>
                        <td><input id="txtTotal" type="text" class="txt c1 num" /></td>
                    </tr>
                    <tr>
                        <td><span> </span><a id="lblProductno" class="lbl btn" >品項</a></td>
                        <td colspan="2"><input id="txtProductno" type="text" class="txt" style="width: 40%"/>
                            <input id="txtProduct" type="text" class="txt" style="width:60%"/>
                        </td>
                        <td><span> </span><a id="lblMount" class="lbl" >數量</a></td>
                        <td><input id="txtMount" type="text" class="txt c1 num" /></td>
                        <td><span> </span><a id="lblUnit" class="lbl" >單位</a></td>
                        <td><input id="txtUnit" type="text" class="txt c1" /></td>
                    </tr>
                    <tr>
                        <td><span> </span><a id="lblAddrno" class="lbl" >起點</a></td>
                        <td colspan="2"><input id="txtAddrno" type="text" class="txt" style="width: 40%"/>
                            <input id="txtAddr" type="text" class="txt" style="width:60%"/>
                        </td>
                        <td><span> </span><a id="lblVolume" class="lbl" >材積</a></td>
                        <td><input id="txtVolume" type="text" class="txt c1 num" /></td>
                        <td><span> </span><a id="lblUnit2" class="lbl" >材積單位</a></td>
                        <td><input id="txtUnit2" type="text" class="txt c1" /></td>
                    </tr>
                    <tr>
                        <td><span> </span><a id="lblAddrno2" class="lbl" >迄點</a></td>
                        <td colspan="2"><input id="txtAddrno2" type="text" class="txt" style="width: 40%"/>
                            <input id="txtAddr2" type="text" class="txt" style="width:60%"/>
                        </td>                           
                        <td><span> </span><a id="lblWeight" class="lbl" >重量(KG)</a></td>
                        <td><input id="txtWeight" type="text" class="txt c1 num" /></td>
                        <td><span> </span><a id="lblTranno" class="lbl" >櫃號</a></td>
                        <td><input id="txtTranno" type="text" class="txt c1" /></td>
                    </tr>
                    <tr>
                        <td><span> </span><a id="lblCarno" class="lbl btn" >車牌</a></td>
                        <td><input id="txtCarno" type="text" class="txt c1" /></td>
                        <td><span> </span><a id="lblDriverno" class="lbl btn" >司機</a></td>
                        <td colspan="2"><input id="txtDriverno" type="text" class="txt" style="width: 50%"/>
                            <input id="txtDriver" type="text" class="txt" style="width:50%"/>
                        </td>
                        <td><span> </span><a id="lblTotal2" class="lbl" >司機運費</a></td>
                        <td><input id="txtTotal2" type="text" class="txt c1 num" /></td>
                    </tr>
                    <tr>
                        <td><span> </span><a id="lblMemo" class="lbl" >備註</a></td>
                        <td colspan="6"><input id="txtMemo" type="text" class="txt c1" /></td>
                    </tr>
                    <tr>
                        <td><span> </span><a id="lblConn" class="lbl" >修改者</a></td>
                        <td colspan="2"><input id="txtConn" type="text" class="txt c1" /></td>
                    </tr>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
