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
		<script type="text/javascript">
			this.errorHandler = null;
			function onPageError(error) {
				alert("An error occurred:\r\n" + error.Message);
			}
 
			q_tables = 's';
			var q_name = "vcc";
			var q_readonly = ['txtNoa', 'txtAccno', 'txtComp','txtCardeal','txtSales', 'txtAcomp', 'txtMoney', 'txtTotal', 'txtWorker', 'txtWorker2','txtAcc2'];
			var q_readonlys = ['txtTotal', 'txtOrdeno', 'txtNo2','txtNoq','txtStore','txtStore2'];
			var bbmNum = [['txtMoney', 15, 0, 1], ['txtTax', 15, 0, 1],['txtTotal', 15, 0, 1]];
			var bbsNum = [];
			var bbmMask = [];
			var bbsMask = [];
			q_sqlCount = 6;
			brwCount = 6;
			brwCount2 = 9;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'datea';
			aPop = new Array(
				['txtCustno', 'lblCust', 'cust', 'noa,comp,nick,tel,invoicetitle', 'txtCustno,txtComp,txtNick,txtTel', 'cust_b.aspx'],
				['txtStoreno_', 'btnStoreno_', 'store', 'noa,store', 'txtStoreno_,txtStore_', 'store_b.aspx'],
				['txtStoreno2_', 'btnStoreno2_', 'store', 'noa,store', 'txtStoreno2_,txtStore2_', 'store_b.aspx'],
				['txtRackno_', 'btnRackno_', 'rack', 'noa,rack,storeno,store', 'txtRackno_', 'rack_b.aspx'],
				['txtCno', 'lblAcomp', 'acomp', 'noa,acomp', 'txtCno,txtAcomp', 'acomp_b.aspx'],
				['txtSalesno', 'lblSales', 'sss', 'noa,namea', 'txtSalesno,txtSales', 'sss_b.aspx'],
				['txtProductno_', 'btnProductno_', 'ucaucc', 'noa,product,unit,spec', 'txtProductno_,txtProduct_,txtUnit_,txtSpec_,txtMount_', 'ucaucc_b.aspx'],
				['txtAcc1', 'lblAcc1', 'acc', 'acc1,acc2', 'txtAcc1,txtAcc2,txtMount', "acc_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno]
			);

			$(document).ready(function() {
				q_desc = 1;
				bbmKey = ['noa'];
				bbsKey = ['noa', 'noq'];
				q_brwCount();
				//q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);
				q_gt('acomp', 'stop=1 ', 0, 0, 0, "cno_acomp");
				q_gt('sss', "where=^^noa='"+r_userno+"'^^", 0, 0, 0, "sssissales");
				//104/05/13取得預設倉庫
				q_gt('store', "where=^^noa='1'^^", 0, 0, 0, "d4store");
			});
			var d4storeno='',d4store='';
			
			function main() {
				if (dataErr) {
					dataErr = false;
					return;
				}
				mainForm(1);
			}

			function sum() {
				var t1 = 0, t_unit, t_mount = 0;
				var t_money = 0, t_tax = 0, t_total = 0;
				for (var j = 0; j < q_bbsCount; j++) {
					if(q_float('txtWidth_' + j)!=0)
						t_mount = q_float('txtWidth_' + j);
					else
						t_mount = q_float('txtMount_' + j);
						
					$('#txtTotal_' + j).val(round(q_mul(q_float('txtPrice_' + j), dec(t_mount)), 0));
					t_money = q_add(t_money, dec(q_float('txtTotal_' + j)));
				}
				q_tr('txtMoney',round(t_money, 0));
				
				if($('#chkAtax').prop('checked')){
					var t_taxrate = q_div(parseFloat(q_getPara('sys.taxrate')), 100);
					t_tax = round(q_mul(t_money, t_taxrate), 0);
					t_total = q_add(t_money, t_tax);
				}else{
					t_tax = q_float('txtTax');
					t_total = q_add(t_money, t_tax);
				}
				
				$('#txtMoney').val(FormatNumber(t_money));
				$('#txtTax').val(FormatNumber(t_tax));
				q_tr('txtTotal', q_sub(q_sub(q_add(t_money,t_tax),q_float('txtMount')),q_float('txtDiscount')));
			}

			function mainPost() {
				q_getFormat();
				bbmMask = [['txtDatea', r_picd], ['txtMon', r_picm]];
				q_mask(bbmMask);
				bbmNum = [['txtMoney', 15, 0, 1], ['txtTax', 15, 0, 1], ['txtTotal', 15, 0, 1],['txtMount',15,0,1],['txtDiscount',15,0,1]];
				bbsNum = [['txtPrice', 12, q_getPara('vcc.pricePrecision'), 1], ['txtMount', 9, q_getPara('vcc.mountPrecision'), 1], ['txtWidth', 9, q_getPara('vcc.mountPrecision'), 1], ['txtTotal', 15, 0, 1], ['txtTranmoney2', 9, q_getPara('vcc.mountPrecision'), 1], ['txtTranmoney3', 9, q_getPara('vcc.mountPrecision'), 1]];
				//q_cmbParse("cmbTranstyle", q_getPara('sys.transtyle'));
				q_cmbParse("cmbTypea", q_getPara('vcc.typea'));
				q_cmbParse("cmbStype", q_getPara('vcc.stype'));
				//q_cmbParse("cmbTaxtype", q_getPara('sys.taxtype'));
				q_cmbParse("combPay", q_getPara('vcc.paytype'));
				q_cmbParse("cmbTrantype", q_getPara('sys.tran'));
				var t_where = "where=^^ 1=1  ^^";
				q_gt('custaddr', t_where, 0, 0, 0, "");
				$('#lblCash').text('收款金額');
				
				//限制帳款月份的輸入 只有在備註的第一個字為*才能手動輸入					
				$('#txtMemo').change(function(){
					if ($('#txtMemo').val().substr(0,1)=='*')
						$('#txtMon').removeAttr('readonly');
					else
						$('#txtMon').attr('readonly', 'readonly');
				});
				
				$('#txtMon').click(function(){
					if ($('#txtMon').attr("readonly")=="readonly" && (q_cur==1 || q_cur==2))
						q_msg($('#txtMon'), "月份要另外設定，請在"+q_getMsg('lblMemo')+"的第一個字打'*'字");
				});
				
				$('#chkAtax').click(function() {
					refreshBbm();
					sum();
				});
				
				$('#txtTax').change(function() {
					sum();
				});
				
				$('#btnOrdes').click(function() {
					var t_custno = trim($('#txtCustno').val());
					var t_where = '';
					if (t_custno.length > 0) {
						t_where = " isnull(enda,0)!=1 and mount!=0 ";
						t_where += " and productno!='' ";
						t_where += " and (custno='"+t_custno+"')";
						if (!emp($('#txtOrdeno').val()))
							t_where += " and charindex(noa,'" + $('#txtOrdeno').val() + "')>0";
						t_where = t_where;
					} else {
						alert(q_getMsg('msgCustEmp'));
						return;
					}
					q_box("ordes_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'ordes', "95%", "650px", q_getMsg('popOrde'));
				});
				
				$('#btnStore2report').click(function() {
					q_box("z_vcc_sh.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";custno='" +$('#txtCustno').val()+"' and comp='" +$('#txtComp').val()+"';"+r_accy, 'ordes', "95%", "650px", "寄庫報表");
				});

				$('#lblOrdeno').click(function() {
					q_pop('txtOrdeno', "orde_xy.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";charindex(noa,'" + $('#txtOrdeno').val() + "')>0;" + r_accy + '_' + r_cno, 'orde', 'noa', '', "92%", "1024px", q_getMsg('lblOrdeno'), true);
				});

				$('#lblAccc').click(function() {
					q_pop('txtAccno', "accc.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";accc3='" + $('#txtAccno').val() + "';" + $('#txtDatea').val().substring(0, 3) + '_' + r_cno, 'accc', 'accc3', 'accc2', "92%", "1054px", q_getMsg('lblAccc'), true);
				});
				
				$('#txtAcc1').change(function() {
					var patt = /^(\d{4})([^\.,.]*)$/g;
					$(this).val($(this).val().replace(patt,"$1.$2"));
	            	sum();
				});
				
				$('#txtMount').change(function() {
					sum();
				});
				
				$('#txtDiscount').change(function() {
					sum();
				});

				$('#lblInvono').click(function() {
					t_where = '';
					t_invo = $('#txtInvono').val();
					if (t_invo.length > 0) {
						t_where = "noa='" + t_invo + "'";
						q_box("vcca.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'vcca', "95%", "95%", $('#lblInvono').val());
					}
				});
				
				$('#lblInvo').click(function() {
					t_where = '';
					t_invo = $('#txtInvo').val();
					if (t_invo.length > 0) {
						t_where = "noa='" + t_invo + "'";
						q_box("invo.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'invo', "95%", "95%", $('#lblInvo').val());
					}
				});
				
				$('#cmbStype').change(function() {
					stype_chang();
				});
				
				$('#txtAddr').change(function() {
					var t_custno = trim($(this).val());
					if (!emp(t_custno)) {
						focus_addr = $(this).attr('id');
						var t_where = "where=^^ noa='" + t_custno + "' ^^";
						q_gt('cust', t_where, 0, 0, 0, "cust_addr");
					}
				});

				$('#txtAddr2').change(function() {
					var t_custno = trim($(this).val());
					if (!emp(t_custno)) {
						focus_addr = $(this).attr('id');
						var t_where = "where=^^ noa='" + t_custno + "' ^^";
						q_gt('cust', t_where, 0, 0, 0, "cust_addr");
					}
				});

				$('#txtCustno').change(function() {
					if (!emp($('#txtCustno').val())) {
						var t_where = "where=^^ noa='" + $('#txtCustno').val() + "'^^";
						q_gt('custaddr', t_where, 0, 0, 0, "");
					}
				});
				
				$('#btnClose_div_stk').click(function() {
					$('#div_stk').toggle();
				});
				
				$('#btnStore2').click(function() {
					if(!emp($('#txtCustno').val())){
						var t_custno=$('#txtCustno').val();
						if(q_cur==1 || q_cur==2)
							var t_where = "where=^^ a.custno='"+t_custno +"' and a.noa !='"+$('#txtNoa').val()+"' and isnull(a.productno,'')!='' ^^";
						else
							var t_where = "where=^^ a.custno='"+t_custno +"' and isnull(a.productno,'')!='' ^^";
						q_gt('vcc_sh_store2', t_where, 0, 0, 0, "store2_store2", r_accy);
					}else{
						alert("請輸入客戶編號!!");
					}
					$('#div_store2').hide();
				});
				$('#btnClose_div_store2').click(function() {
					$('#div_store2').hide();
				});
				
				$('#btnImport_div_store2').click(function() {
					var t_store2=[];
					var store2_row=document.getElementById("table_store2").rows.length-2;
					if(store2_row>0){//有資料
						for(var i=0 ;i<store2_row;i++){
							if($('#store2_chkSel_'+i).prop('checked'))
								t_store2.push({
									productno:$('#store2_txtProductno_'+i).val(),
									product:$('#store2_txtProduct_'+i).val(),
									uno:$('#store2_txtUno_'+i).val(),
									unit:$('#store2_txtUnit_'+i).val(),
									storeno:$('#store2_txtStoreno_'+i).val(),
									store:$('#store2_txtStore_'+i).val(),
									mount:$('#store2_txtMount_'+i).val()
								});
						}
						if(t_store2.length>0){
							q_gridAddRow(bbsHtm, 'tbbs', 'txtProductno,txtProduct,txtUnit,txtTranmoney3,txtUno,txtStoreno2,txtStore2', t_store2.length, t_store2
							, 'productno,product,unit,mount,uno,storeno,store', 'txtProductno,txtProduct,txtUno');
							AutoNoq();	
						}
					}
					$('#div_store2').hide();
				});
			}
			
			function refreshBbm() {
                if (q_cur == 1 || q_cur==2) {
					if($('#chkAtax').prop('checked'))
						$('#txtTax').css('color', 'green').css('background', 'RGB(237,237,237)').attr('readonly', 'readonly');
					else
						$('#txtTax').css('color', 'black').css('background', 'white').removeAttr('readonly');  
                }else{
                	$('#txtTax').css('color', 'green').css('background', 'RGB(237,237,237)').attr('readonly', 'readonly');
                }
            }

			function q_funcPost(t_func, result) {
				if (result.substr(0, 5) == '<Data') {
					var Asss = _q_appendData('sss', '', true);
					var Acar = _q_appendData('car', '', true);
					var Acust = _q_appendData('cust', '', true);
					alert(Asss[0]['namea'] + '^' + Acar[0]['car'] + '^' + Acust[0]['comp']);
				} else
					alert(t_func + '\r' + result);
			}

			function q_boxClose(s2) {
				var ret;
				switch (b_pop) {
					case 'ordes':
						if (q_cur > 0 && q_cur < 4) {
							b_ret = getb_ret();
							if (!b_ret || b_ret.length == 0)
								return;
							
							ret = q_gridAddRow(bbsHtm, 'tbbs', 'txtProductno,txtProduct,txtSpec,txtUnit,txtMount,txtWidth,txtPrice,txtMemo,txtOrdeno,txtNo2', b_ret.length, b_ret
							, 'productno,product,spec,unit,notv,notv,price,memo,noa,no2', 'txtProductno,txtProduct,txtSpec');
							
							//寫入訂單號碼
							var t_oredeno = '';
							for (var i = 0; i < b_ret.length; i++) {
								if (t_oredeno.indexOf(b_ret[i].noa) == -1)
									t_oredeno = t_oredeno + (t_oredeno.length > 0 ? (',' + b_ret[i].noa) : b_ret[i].noa);
							}
							
							//取得訂單備註 + 指定地址
							if (t_oredeno.length > 0) {
								var t_where = "where=^^ charindex(noa,'" + t_oredeno + "')>0 ^^";
								q_gt('orde', t_where, 0, 0, 0, "", r_accy);
							}

							$('#txtOrdeno').val(t_oredeno);
							sum();
							
						}
						break;
					case q_name + '_s':
						q_boxClose2(s2);
						break;
				}
				b_pop = '';
				AutoNoq();
			}
			
			var t_msg = '';
			var focus_addr = '';
			var z_cno = r_cno, z_acomp = r_comp, z_nick = r_comp.substr(0, 2);
			var carnoList = [];
			var thisCarSpecno = '';
			var issales=false;
			function q_gtPost(t_name) {
				var as;
				switch (t_name) {
					case 'd4store':
						var as = _q_appendData("store", "", true);
	                        if (as[0] != undefined) {
								d4storeno=as[0].noa,d4store=as[0].store;
							}
						break;
					case 'sssissales':
						var as = _q_appendData("sss", "", true);
	                        if (as[0] != undefined) {
	                        	issales=(as[0].issales=="true"?true:false);
	                        	if(issales)
	                        		q_content = "where=^^salesno='" + r_userno + "'^^";
							}
							q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);
						break;
					case 'msg_stk_all':
						var as = _q_appendData("stkucc", "", true);
						var rowslength=document.getElementById("table_stk").rows.length-3;
							for (var j = 1; j < rowslength; j++) {
								document.getElementById("table_stk").deleteRow(3);
							}
						var stk_row=0;
						
						var stkmount = 0;
						for (var i = 0; i < as.length; i++) {
							//倉庫庫存
							if(dec(as[i].mount)!=0){
								var tr = document.createElement("tr");
								tr.id = "bbs_"+j;
								tr.innerHTML = "<td id='assm_tdStoreno_"+stk_row+"'><input id='assm_txtStoreno_"+stk_row+"' type='text' class='txt c1' value='"+as[i].storeno+"' disabled='disabled'/></td>";
								tr.innerHTML+="<td id='assm_tdStore_"+stk_row+"'><input id='assm_txtStore_"+stk_row+"' type='text' class='txt c1' value='"+as[i].store+"' disabled='disabled' /></td>";
								tr.innerHTML+="<td id='assm_tdMount_"+stk_row+"'><input id='assm_txtMount_"+stk_row+"' type='text' class='txt c1 num' value='"+as[i].mount+"' disabled='disabled'/></td>";
								var tmp = document.getElementById("stk_close");
								tmp.parentNode.insertBefore(tr,tmp);
								stk_row++;
							}
							//庫存總計
							stkmount = stkmount + dec(as[i].mount);
						}
						var tr = document.createElement("tr");
						tr.id = "bbs_"+j;
						tr.innerHTML="<td colspan='2' id='stk_tdStore_"+stk_row+"' style='text-align: right;'><span id='stk_txtStore_"+stk_row+"' class='txt c1' >倉庫總計：</span></td>";
						tr.innerHTML+="<td id='stk_tdMount_"+stk_row+"'><span id='stk_txtMount_"+stk_row+"' type='text' class='txt c1 num' > "+stkmount+"</span></td>";
						var tmp = document.getElementById("stk_close");
						tmp.parentNode.insertBefore(tr,tmp);
						stk_row++;
						
						$('#div_stk').css('top',mouse_point.pageY-parseInt($('#div_stk').css('height')));
						$('#div_stk').css('left',mouse_point.pageX-parseInt($('#div_stk').css('width')));
						$('#div_stk').toggle();
						break;
					case 'store2_store2':
						var as = _q_appendData("view_vccs", "", true);
						for (var i = 0; i < as.length; i++) {
							if(dec(as[i].stkmount)==0){
								as.splice(i, 1);
								i--;
							}
						}
						if (as[0] == undefined) {
							alert("無寄庫量");
							break;
						}
						var rowslength=document.getElementById("table_store2").rows.length-1;
							for (var j = 1; j < rowslength; j++) {
								document.getElementById("table_store2").deleteRow(1);
							}
						var store2_row=0;
					
						for (var i = 0; i < as.length; i++) {
							//倉庫庫存
							var tr = document.createElement("tr");
							tr.id = "store2_"+j;
							if(q_cur==1 || q_cur==2)
								tr.innerHTML = "<td><input id='store2_chkSel_"+store2_row+"' type='checkbox' /></td>";
							else
								tr.innerHTML = "<td><input id='store2_chkSel_"+store2_row+"' type='checkbox' disabled='disabled'/></td>";
								
							tr.innerHTML+="<td><input id='store2_txtProductno_"+store2_row+"' type='text' class='txt c1' value='"+as[i].productno+"' disabled='disabled'/></td>";
							tr.innerHTML+="<td><input id='store2_txtProduct_"+store2_row+"' type='text' class='txt c1' value='"+as[i].product+"' disabled='disabled' /></td>";
							tr.innerHTML+="<td><input id='store2_txtUnit_"+store2_row+"' type='text' class='txt c1' value='"+as[i].unit+"' disabled='disabled' /></td>";
							tr.innerHTML+= "<td><input id='store2_txtUno_"+store2_row+"' type='text' class='txt c1' value='"+as[i].uno+"' disabled='disabled'/></td>";
							//tr.innerHTML+= "<td><input id='store2_txtSpec_"+store2_row+"' type='text' class='txt c1' value='"+as[i].spec+"' disabled='disabled'/></td>";
							tr.innerHTML+="<td><input id='store2_txtStore_"+store2_row+"' type='text' class='txt c1' value='"+as[i].store2+"' disabled='disabled' /><input id='store2_txtStoreno_"+store2_row+"' type='hidden' value='"+as[i].storeno2+"'  /></td>";
							tr.innerHTML+="<td><input id='store2_txtMount_"+store2_row+"' type='text' class='txt c1 num' value='"+dec(as[i].stkmount)+"' disabled='disabled'/></td>";
							var tmp = document.getElementById("store2_close");
							tmp.parentNode.insertBefore(tr,tmp);
							store2_row++;
						}
						$('#div_store2').css('top', $('#btnStore2').offset().top+25);
						$('#div_store2').css('left', $('#btnStore2').offset().left-parseInt($('#div_store2').css('width'))-5);
						
						if(q_cur==1 || q_cur==2)
							$('#btnImport_div_store2').removeAttr('disabled');
						else
							$('#btnImport_div_store2').attr('disabled', 'disabled');
							
						$('#div_store2').toggle();
						break;
					case 'cno_acomp':
						var as = _q_appendData("acomp", "", true);
						if (as[0] != undefined) {
							z_cno = as[0].noa;
							z_acomp = as[0].acomp;
							z_nick = as[0].nick;
						}
						break;
					case 'msg_stk':
						var as = _q_appendData("stkucc", "", true);
						var stkmount = 0;
						t_msg = '';
						for (var i = 0; i < as.length; i++) {
							stkmount = stkmount + dec(as[i].mount);
						}
						t_msg = "庫存量：" + stkmount;
						
						//取得寄庫量
						if(!emp($('#txtCustno').val()) && !emp($('#txtProductno_' + b_seq).val())){
							var t_custno=$('#txtCustno').val();
							var t_where = "where=^^ a.noa!='"+$('#txtNoa').val()+"' and a.custno='" + t_custno + "' and productno='" + $('#txtProductno_' + b_seq).val() + "' ^^";
							q_gt('vcc_sh_store2', t_where, 0, 0, 0, "store2", r_accy);
						}else{
							q_msg($('#txtMount_' + b_seq), t_msg);
						}
						$('#q_acDiv').css("width",'200px');
						break;
					case 'store2':
						var as = _q_appendData("view_vccs", "", true);
						var stkmount = 0;
						for (var i = 0; i < as.length; i++) {
							stkmount = stkmount + dec(as[i].stkmount);
						}
						if(stkmount!=0)
							t_msg = t_msg + "<BR>寄庫量：" + stkmount;
						q_msg($('#txtMount_' + b_seq), t_msg);
						$('#q_acDiv').css("width",'200px');
						break;
					case 'check_store2':
						var as = _q_appendData("view_vccs", "", true);
						if (as[0] != undefined) {
							if(dec(as[0].stkmount)==0){
								alert("無寄庫量，不得寄出貨!!");
								$('#txtTranmoney3_' + store2_seq).val(0);
							}else if (dec($('#txtTranmoney3_' + store2_seq).val())>dec(as[0].stkmount)){
								alert("【"+q_getMsg('lblTranmoney3_s')+"】不得大於【寄庫量】!!");
								$('#txtTranmoney3_' + store2_seq).val(dec(as[0].stkmount));
							}
						}else{
							alert("無寄庫量，不得寄出貨!!");
							$('#txtTranmoney3_' + store2_seq).val(0);	
						}
						break;	
					case 'store2_stk':
						var as = _q_appendData("view_vccs", "", true);
						t_msg='';
						for (var i = 0; i < as.length; i++) {
							if(dec(as[i].stkmount)!=0){
								if(t_msg.length==0)
									t_msg =(as[i].storeno2!=''?(as[i].storeno2+' '+as[i].store2):'(無倉庫名稱)')+" 寄庫量：" +as[i].stkmount;
								else 
									t_msg ="<BR>"+(as[i].storeno2!=''?(as[i].storeno2+' '+as[i].store2):'(無倉庫名稱)')+" 寄庫量：" +as[i].stkmount;
							}
						}
						
						if(t_msg.length>0)
							q_msg($('#txtStoreno2_' + b_seq), t_msg);
						break;
					case 'msg_ucc':
						var as = _q_appendData("ucc", "", true);
						t_msg = '';
						if (as[0] != undefined) {
							t_msg = "銷售單價：" + dec(as[0].saleprice) + "<BR>";
						}
						//最新出貨單價
						var t_where = "where=^^ custno='" + $('#txtCustno').val() + "' and noa in (select noa from vccs" + r_accy + " where productno='" + $('#txtProductno_' + b_seq).val() + "' and price>0 ) ^^ stop=1";
						q_gt('vcc', t_where, 0, 0, 0, "msg_vcc", r_accy);
						break;
					case 'msg_vcc':
						var as = _q_appendData("vccs", "", true);
						var vcc_price = 0;
						if (as[0] != undefined) {
							for (var i = 0; i < as.length; i++) {
								if (as[0].productno == $('#txtProductno_' + b_seq).val())
									vcc_price = dec(as[i].price);
							}
						}
						t_msg = t_msg + "最近出貨單價：" + vcc_price;
						q_msg($('#txtPrice_' + b_seq), t_msg);
						break;
					case 'custaddr':
						var as = _q_appendData("custaddr", "", true);
						var t_item = " @ ";
						if (as[0] != undefined) {
							for ( i = 0; i < as.length; i++) {
								t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].post + '@' + as[i].addr;
							}
						}
						document.all.combAddr.options.length = 0;
						q_cmbParse("combAddr", t_item);
						break;
					case 'orde':
						var as = _q_appendData("orde", "", true);
						var t_memo = $('#txtMemo').val();
						var t_post2 = '';
						var t_addr2 = '';
						var t_custorde = '';
						for ( i = 0; i < as.length; i++) {
							t_memo = t_memo + as[i].noa + (as[i].memo.length>0? ':':'') + as[i].memo + (as[i].memo.length>0? '\n':(as.length-1==i?'':','));
							t_post2 = t_post2+(t_post2.length>0?';':'')+as[i].post2;
							t_addr2 = t_addr2+(t_addr2.length>0?';':'')+as[i].addr;
							t_custorde = t_custorde+(t_custorde.length>0?';':'')+as[i].custorde;
						}
						$('#txtMemo').val((t_custorde.length>0?('客戶訂單編號：'+t_custorde+'\n'):'')+t_memo);
						$('#txtPost2').val(t_post2);
						$('#txtAddr2').val(t_addr2);
						
						break;
					case 'cust_addr':
						var as = _q_appendData("cust", "", true);
						if (as[0] != undefined && focus_addr != '') {
							$('#' + focus_addr).val(as[0].addr_fact);
							focus_addr = '';
						}
						break;
					case 'btnDele':
						var as = _q_appendData("umms", "", true);
						if (as[0] != undefined) {
							var z_msg = "", t_paysale = 0;
							for (var i = 0; i < as.length; i++) {
								t_paysale = parseFloat(as[i].paysale.length == 0 ? "0" : as[i].paysale);
								if (t_paysale != 0)
									z_msg += String.fromCharCode(13) + '收款單號【' + as[i].noa + '】 ' + FormatNumber(t_paysale);
							}
							if (z_msg.length > 0) {
								alert('已沖帳:' + z_msg);
								Unlock(1);
								return;
							}
						}
						_btnDele();
						Unlock(1);
						break;
					case 'btnModi':
						var as = _q_appendData("umms", "", true);
						if (as[0] != undefined) {
							var z_msg = "", t_paysale = 0;
							for (var i = 0; i < as.length; i++) {
								t_paysale = parseFloat(as[i].paysale.length == 0 ? "0" : as[i].paysale);
								if (t_paysale != 0)
									z_msg += String.fromCharCode(13) + '收款單號【' + as[i].noa + '】 ' + FormatNumber(t_paysale);
							}
							if (z_msg.length > 0) {
								alert('已沖帳:' + z_msg);
								Unlock(1);
								return;
							}
						}
						_btnModi();
						Unlock(1);
						$('#txtDatea').focus();

						if (!emp($('#txtCustno').val())) {
							var t_where = "where=^^ noa='" + $('#txtCustno').val() + "' ^^";
							q_gt('custaddr', t_where, 0, 0, 0, "");
						}
						break;
					case q_name:
						if (q_cur == 4)
							q_Seek_gtPost();
						break;
					case 'sss':
						as = _q_appendData('sss', '', true);
						break;
					case 'startdate':
						var as = _q_appendData('cust', '', true);
						var t_startdate='';
						if (as[0] != undefined) {
							t_startdate=as[0].startdate;
						}
						if(t_startdate.length==0 || ('00'+t_startdate).slice(-2)=='00' || $('#txtDatea').val().substr(7, 2)<('00'+t_startdate).slice(-2)){
							$('#txtMon').val($('#txtDatea').val().substr(0, 6));
						}else{
							var t_date=$('#txtDatea').val();
							var nextdate=new Date(dec(t_date.substr(0,3))+1911,dec(t_date.substr(4,2))-1,1);
				    		nextdate.setMonth(nextdate.getMonth() +1)
				    		t_date=''+(nextdate.getFullYear()-1911)+'/'+(nextdate.getMonth()<9?'0':'')+(nextdate.getMonth()+1);
							$('#txtMon').val(t_date);
						}
						check_startdate=true;
						btnOk();
						break;
				}
			}
			
			var check_startdate=false;
			function btnOk() {
				var t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')],['txtDatea', q_getMsg('lblDatea')], ['txtCustno', q_getMsg('lblCust')], ['txtCno', q_getMsg('lblAcomp')]]);
				if (t_err.length > 0) {
					alert(t_err);
					return;
				}
				//帶入預設倉庫
				for (var i = 0; i < q_bbsCount; i++) {
					if(emp($('#txtStoreno_'+i).val())){
						$('#txtStoreno_'+i).val(d4storeno);
						$('#txtStore_'+i).val(d4store);
					}
				}
				
				//判斷只要有商品 數量(出貨 寄庫/出) 為0 彈出警告視窗
				/*t_err='';
				
					if(!emp($('#txtProductno_'+i).val()) && q_float('txtMount_'+i)==0 && q_float('txtTranmoney2_'+i)==0 && q_float('txtTranmoney3_'+i)==0){
						t_err=t_err+(t_err.length>0?'\n':'')+$('#txtProduct_'+i).val()+'數量為0，請確認出貨、寄庫、寄出數量!!';
					}
				}
				
				if (t_err.length > 0) {
					alert(t_err);
					return;
				}*/
				
				//104/02/26 判斷寄庫倉編號要與客戶編號相似
				/*t_err='';
				var t_custno=$('#txtCustno').val().substr(0,$('#txtCustno').val().indexOf('-'));
				for (var i = 0; i < q_bbsCount; i++) {
					if(!emp($('#txtProductno_'+i).val()) && !emp($('#txtStoreno2_'+i).val()) && $('#txtStoreno2_'+i).val().indexOf(t_custno)==-1 && (q_float('txtTranmoney2_'+i)!=0 || q_float('txtTranmoney3_'+i)!=0)){
						t_err=t_err+(t_err.length>0?'\n':'')+$('#txtProduct_'+i).val()+'寄庫/出倉與寄庫客戶不同!!';
					}
				}
				if (t_err.length > 0) {
					alert(t_err);
					return;
				}*/
				
				//判斷起算日,寫入帳款月份
				//104/09/30 如果備註沒有*字就重算帳款月份
				//if(!check_startdate && emp($('#txtMon').val())){
				if(!check_startdate && $('#txtMemo').val().substr(0,1)!='*'){	
					var t_where = "where=^^ noa='"+$('#txtCustno').val()+"' ^^";
					q_gt('cust', t_where, 0, 0, 0, "startdate", r_accy);
					return;
				}
				
				check_startdate=false;
					
				if (q_cur == 1)
					$('#txtWorker').val(r_name);
				else
					$('#txtWorker2').val(r_name);
					
				sum();

				var s1 = $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val();
				if (s1.length == 0 || s1 == "AUTO")
					q_gtnoa(q_name, replaceAll(q_getPara('sys.key_vcc') + $('#txtDatea').val(), '/', ''));
				else
					wrServer(s1);
			}

			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)// 1-3
					return;
				q_box('vcc_xy_s.aspx', q_name + '_s', "500px", "700px", q_getMsg("popSeek"));
			}

			function combPay_chg() {
				var cmb = document.getElementById("combPay");
				if (!q_cur)
					cmb.value = '';
				else
					$('#txtPaytype').val(cmb.value);
				cmb.value = '';
			}

			function combAddr_chg() {
				if (q_cur == 1 || q_cur == 2) {
					$('#txtAddr2').val($('#combAddr').find("option:selected").text());
					$('#txtPost2').val($('#combAddr').find("option:selected").val());
				}
			}
			
			var mouse_point,store2_seq='';
			function bbsAssign() {
				for (var i = 0; i < q_bbsCount; i++) {
					if (!$('#btnMinus_' + i).hasClass('isAssign')) {
						
						$('#txtUnit_' + i).focusout(function() {
							sum();
						});
						
						$('#txtPrice_' + i).focusout(function() {
							sum();
						}).focusin(function() {
							if (q_cur == 1 || q_cur == 2) {
								t_IdSeq = -1;
								q_bodyId($(this).attr('id'));
								b_seq = t_IdSeq;
								if (!emp($('#txtProductno_' + b_seq).val())) {
									//金額
									var t_where = "where=^^ noa='" + $('#txtProductno_' + b_seq).val() + "' ^^ stop=1";
									q_gt('ucc', t_where, 0, 0, 0, "msg_ucc", r_accy);
								}
							}
						});
						
						$('#txtMount_' + i).focusout(function() {
							if (q_cur == 1 || q_cur == 2){
								sum();
							}
						}).focusin(function() {
							if (q_cur == 1 || q_cur == 2) {
								t_IdSeq = -1;
								q_bodyId($(this).attr('id'));
								b_seq = t_IdSeq;
								if (!emp($('#txtProductno_' + b_seq).val())) {
									//庫存
									var t_where = "where=^^ ['" + q_date() + "','','" + $('#txtProductno_' + b_seq).val() + "')  ^^";
									q_gt('calstk', t_where, 0, 0, 0, "msg_stk", r_accy);
								}
							}
						});
						
						$('#txtWidth_' + i).focusout(function() {
							if (q_cur == 1 || q_cur == 2){
								sum();
							}
						});
						
						$('#txtProductno_' + i).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							AutoNoq();
							//判斷寄出量是否大於寄庫量
							store2_seq=b_seq.toString();
							check_store2(b_seq);
						});
						
						$('#txtTranmoney2_' + i).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							var t_err = q_chkEmpField([['txtCustno', q_getMsg('lblCust')],['txtProductno_'+ b_seq, q_getMsg('lblProductno_s')]]);
							if (t_err.length > 0) {
								alert(t_err);
								$(this).val('');
								return;
							}
							if(q_float('txtTranmoney2_' + b_seq)!=0 && q_float('txtTranmoney3_' + b_seq)!=0){
								alert('禁止同時寄庫與寄出貨!!');
								$(this).val('');
								return;
							}
							sum();
							if(dec($('#txtTranmoney2_' + b_seq).val()) > dec($('#txtMount_' + b_seq).val())){
								alert("【"+q_getMsg('lblTranmoney2_s')+"】不得大於【出貨"+q_getMsg('lblMount_s')+"】!!");
								$('#txtTranmoney2_' + b_seq).val($('#txtMount_' + b_seq).val());
							}
						});
						
						$('#txtTranmoney3_' + i).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							var t_err = q_chkEmpField([['txtCustno', q_getMsg('lblCust')],['txtProductno_'+ b_seq, q_getMsg('lblProductno_s')]]);
							if (t_err.length > 0) {
								alert(t_err);
								$(this).val('');
								return;
							}
							
							if(q_float('txtTranmoney2_' + b_seq)!=0 && q_float('txtTranmoney3_' + b_seq)!=0){
								alert('禁止同時寄庫與寄出貨!!');
								$(this).val('');
								return;
							}
							
							sum();
							//判斷寄出量是否大於寄庫量
							store2_seq=b_seq.toString();
							check_store2(b_seq);
						});
						
						$('#txtUno_' + i).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							sum();
							//判斷寄出量是否大於寄庫量
							store2_seq=b_seq.toString();
							check_store2(b_seq);
						});
						
						$('#txtStoreno2_' + i).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							var t_err = q_chkEmpField([['txtCustno', q_getMsg('lblCust')],['txtProductno_'+ b_seq, q_getMsg('lblProductno_s')]]);
							if (t_err.length > 0) {
								alert(t_err);
								return;
							}
							//判斷寄出量是否大於寄庫量
							store2_seq=b_seq.toString();
							check_store2(b_seq);
						}).focusin(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;								
							sum();
							//顯示寄庫資料
							if(!emp($('#txtProductno_' + b_seq).val()) ){						
								var t_where = "where=^^ a.custno !='"+$('#txtNoa').val() +"' and a.productno='" + $('#txtProductno_' + b_seq).val() + "' and a.uno='" + $('#txtUno_' + b_seq).val() + "' and a.noa !='"+$('#txtNoa').val()+"' ^^";
								q_gt('vcc_sh_store2', t_where, 0, 0, 0, "store2_stk", r_accy);
							}
						});
						
						$('#btnRecord_' + i).click(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							t_where = "cust='" + $('#txtCustno').val() + "' and noq='" + $('#txtProductno_' + b_seq).val() + "'";
							q_box("z_vccrecord.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'vccrecord', "95%", "95%", q_getMsg('lblRecord_s'));
						});
						
						$('#btnStk_' + i).mousedown(function(e) {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if (!emp($('#txtProductno_' + b_seq).val()) && $("#div_stk").is(":hidden")) {
								mouse_point=e;
								document.getElementById("stk_productno").innerHTML = $('#txtProductno_' + b_seq).val();
								document.getElementById("stk_product").innerHTML = $('#txtProduct_' + b_seq).val();
								//庫存
								var t_where = "where=^^ ['" + q_date() + "','','" + $('#txtProductno_' + b_seq).val() + "') ^^";
								q_gt('calstk', t_where, 0, 0, 0, "msg_stk_all", r_accy);
							}
						});
					}
				}
				_bbsAssign();
				HiddenTreat();
				refreshBbm();
				
				/*if((q_cur==1 || q_cur==2)){
					if(q_bbsCount>=10){
						$('#btnPlus').attr('disabled', 'disabled');
					}else{
						$('#btnPlus').removeAttr('disabled');
					}
				}
				for (var i = 10; i < q_bbsCount; i++) {
					$('#bbsseq_'+i).hide();
				}*/
			}
			
			function check_store2(t_seq) {
				if(dec($('#txtTranmoney3_'+t_seq).val())!=0 && store2_seq!=''){
					var t_custno=$('#txtCustno').val();
					var t_noa=$('#txtNoa').val();
					var t_uno=$('#txtUno_'+t_seq).val();
					var t_pno=$('#txtProductno_'+t_seq).val();
					var t_sno=$('#txtStoreno2_'+t_seq).val();
					var t_where = "where=^^ a.noa !='"+ t_noa +"' and  isnull(a.custno,'')='" + t_custno + "' and isnull(a.uno,'')='" + t_uno + "' and isnull(a.productno,'')='" + t_pno + "' and isnull(a.storeno2,'')='" + t_sno + "' ^^";
						q_gt('vcc_sh_store2', t_where, 0, 0, 0, "check_store2", r_accy);
				}
			}

			function btnIns() {
				$('#div_store2').hide();
				_btnIns();
				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val('AUTO');
				$('#txtCno').val(z_cno);
				$('#txtAcomp').val(z_acomp);
				$('#txtDatea').val(q_date());
				$('#cmbTypea').val('1');
				$('#txtDatea').focus();
				//$('#cmbTaxtype').val('0');
				var t_where = "where=^^ 1=1  ^^";
				q_gt('custaddr', t_where, 0, 0, 0, "");
			}

			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				$('#div_store2').hide();
				
				//104/05/13測試中暫時不判斷是否收款
				/*Lock(1, {
					opacity : 0
				});
				$('#txtCustno').focus();
				var t_where = " where=^^ vccno='" + $('#txtNoa').val() + "'^^";
				q_gt('umms', t_where, 0, 0, 0, 'btnModi', r_accy);
				*/
				
				_btnModi();
				$('#txtDatea').focus();
				if (!emp($('#txtCustno').val())) {
					var t_where = "where=^^ noa='" + $('#txtCustno').val() + "'  ^^";
					q_gt('custaddr', t_where, 0, 0, 0, "");
				}
			}

			function btnPrint() {
				q_box('z_vccp_sh.aspx' + "?;;;noa=" + trim($('#txtNoa').val()) + ";" + r_accy, '', "95%", "95%", q_getMsg("popPrint"));
			}

			function wrServer(key_value) {
				var i;
				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
			}

			function bbsSave(as) {
				if (!as['productno'] && !as['product'] ) {
					as[bbsKey[1]] = '';
					return;
				}

				q_nowf();
				as['typea'] = abbm2['typea'];
				as['mon'] = abbm2['mon'];
				as['noa'] = abbm2['noa'];
				as['datea'] = abbm2['datea'];
				as['custno'] = abbm2['custno'];
				if (abbm2['storeno'])
					as['storeno'] = abbm2['storeno'];

				t_err = '';
				if (as['price'] != null && (dec(as['price']) > 99999999 || dec(as['price']) < -99999999))
					t_err = q_getMsg('msgPriceErr') + as['price'] + '\n';
				if (as['total'] != null && (dec(as['total']) > 999999999 || dec(as['total']) < -99999999))
					t_err = q_getMsg('msgMoneyErr') + as['total'] + '\n';

				if (t_err) {
					alert(t_err);
					return false;
				}
				return true;
			}

			function q_stPost() {
				if (q_cur == 1 || q_cur == 2) {
					var s2 = xmlString.split(';');
					abbm[q_recno]['accno'] = s2[0];
				}
			}

			function refresh(recno) {
				_refresh(recno);
				HiddenTreat();
				stype_chang();
				$('#div_stk').hide();
				$('#div_store2').hide();
				refreshBbm();
			}
			
			function AutoNoq(){
				var maxnoq='001';
				for (var j = 0; j < q_bbsCount; j++) {
					if((!emp($('#txtProductno_'+j).val())) || (!emp($('#txtProduct_'+j).val()))){
						$('#txtNoq_'+j).val(maxnoq);
						maxnoq=('000'+(dec(maxnoq)+1)).substr(-3);
					}
					if(emp($('#txtProductno_'+j).val()) && emp($('#txtProduct_'+j).val())){
						$('#txtNoq_'+j).val('');
					}
				}
			}

			function HiddenTreat(){
				for (var j = 0; j < q_bbsCount; j++) {
					if(!emp($('#txtOrdeno_'+j).val())){
						$('#txtProductno_'+j).attr('disabled', 'disabled');
						$('#btnProductno_'+j).attr('disabled', 'disabled');
					}else{
						$('#txtProductno_'+j).removeAttr('disabled');
						$('#btnProductno_'+j).removeAttr('disabled');
					}
				}
			}
			
			function stype_chang(){
				if($('#cmbStype').val()=='3'){
					$('.invo').show();
					$('.vcca').hide();
				}else{
					$('.invo').hide();
					$('.vcca').show();
				}
			}

			function readonly(t_para, empty) {
				_readonly(t_para, empty);
				if (t_para) {
					$('#combAddr').attr('disabled', 'disabled');
				} else {
					$('#combAddr').removeAttr('disabled');
				}
				HiddenTreat();
				//限制帳款月份的輸入 只有在備註的第一個字為*才能手動輸入
				if ($('#txtMemo').val().substr(0,1)=='*')
					$('#txtMon').removeAttr('readonly');
				else
					$('#txtMon').attr('readonly', 'readonly');
				refreshBbm();
			}

			function btnMinus(id) {
				_btnMinus(id);
				var n=id.split('_')[id.split('_').length-1];
				sum();
				HiddenTreat();
				AutoNoq();
			}

			function btnPlus(org_htm, dest_tag, afield) {
				_btnPlus(org_htm, dest_tag, afield);
			}

			function q_appendData(t_Table) {
				dataErr = !_q_appendData(t_Table);
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
				//104/05/13測試中暫時不判斷是否收款
				/*Lock(1, {
					opacity : 0
				});
				var t_where = " where=^^ vccno='" + $('#txtNoa').val() + "'^^";
				q_gt('umms', t_where, 0, 0, 0, 'btnDele', r_accy);*/
				
				_btnDele();
			}

			function btnCancel() {
				_btnCancel();
			}

			function q_popPost(s1) {
				switch (s1) {
					case 'txtCustno':
						if (!emp($('#txtCustno').val())) {
							var t_where = "where=^^ noa='" + $('#txtCustno').val() + "'  ^^";
							q_gt('custaddr', t_where, 0, 0, 0, "");
						}
						break;
					case 'txtProductno_':
						AutoNoq();
						break;
				}
			}

			function FormatNumber(n) {
				var xx = "";
				if (n < 0) {
					n = Math.abs(n);
					xx = "-";
				}
				n += "";
				var arr = n.split(".");
				var re = /(\d{1,3})(?=(\d{3})+$)/g;
				return xx + arr[0].replace(re, "$1,") + (arr.length == 2 ? "." + arr[1] : "");
			}
			
			function HiddenTreat(){
				var hasStyle = q_getPara('sys.isstyle');
				var isStyle = (hasStyle.toString()=='1'?$('.isStyle').show():$('.isStyle').hide());
				var hasSpec = q_getPara('sys.isspec');
				var isSpec = (hasSpec.toString()=='1'?$('.isSpec').show():$('.isSpec').hide());
			}
		</script>
		<style type="text/css">
			#dmain {
				overflow: hidden;
			}
			.dview {
				float: left;
				width: 27%;
				border-width: 0px;
			}
			.tview {
				width: 100%;
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
				width: 73%;
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
				width: 98%;
				float: left;
			}
			.txt.c2 {
				width: 30%;
				float: left;
			}
			.txt.c3 {
				width: 68%;
				float: left;
			}
			.txt.c4 {
				width: 49%;
				float: left;
			}
			.txt.c6 {
				width: 25%;
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
				width: 100%;
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
		</style>
	</head>
	<body>
		<div id="div_stk" style="position:absolute; top:300px; left:400px; display:none; width:400px; background-color: #CDFFCE; border: 5px solid gray;">
			<table id="table_stk" style="width:100%;" border="1" cellpadding='2'  cellspacing='0'>
				<tr>
					<td style="background-color: #f8d463;" align="center">產品編號</td>
					<td style="background-color: #f8d463;" colspan="2" id='stk_productno'> </td>
				</tr>
				<tr>
					<td style="background-color: #f8d463;" align="center">產品名稱</td>
					<td style="background-color: #f8d463;" colspan="2" id='stk_product'> </td>
				</tr>
				<tr id='stk_top'>
					<td align="center" style="width: 30%;">倉庫編號</td>
					<td align="center" style="width: 45%;">倉庫名稱</td>
					<td align="center" style="width: 25%;">倉庫數量</td>
				</tr>
				<tr id='stk_close'>
					<td align="center" colspan='3'>
						<input id="btnClose_div_stk" type="button" value="關閉視窗">
					</td>
				</tr>
			</table>
		</div>
		<div id="div_store2" style="position:absolute; top:300px; left:400px; display:none; width:785px; background-color: #CDFFCE; border: 5px solid gray;">
			<table id="table_store2" style="width:100%;" border="1" cellpadding='2'  cellspacing='0'>
				<tr id='store2_top'>
					<td style="background-color: #f8d463;width: 21px;" align="center"> </td>
					<td style="background-color: #f8d463;width: 130px;" align="center">產品編號</td>
					<td style="background-color: #f8d463;width: 300px;" align="center">產品名稱</td>
					<td style="background-color: #f8d463;width: 300px;" align="center">單位</td>
					<td style="background-color: #f8d463;width: 200px;" align="center">批號</td>
					<!--<td style="background-color: #f8d463;width: 200px;" align="center">規格</td>-->
					<td style="background-color: #f8d463;width: 100px;" align="center">寄庫倉庫</td>
					<td style="background-color: #f8d463;width: 100px;" align="center">寄庫數量</td>
				</tr>
				<tr id='store2_close'>
					<td align="center" colspan='7'>
						<input id="btnImport_div_store2" type="button" value="寄庫匯入">
						<input id="btnClose_div_store2" type="button" value="關閉視窗">
					</td>
				</tr>
			</table>
		</div>
		<div id="dmain" style="width: 1260px;">
			<!--#include file="../inc/toolbar.inc"-->
			<div class="dview" id="dview" >
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:5%"><a id='vewChk'> </a></td>
						<td align="center" style="width:5%"><a id='vewType'> </a></td>
						<td align="center" style="width:20%"><a id='vewDatea'> </a></td>
						<td align="center" style="width:30%"><a id='vewNoa'> </a></td>
						<td align="center" style="width:40%"><a id='vewComp'> </a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" style=''/></td>
						<td align="center" id='typea=vcc.typea'>~typea=vcc.typea</td>
						<td align="center" id='datea'>~datea</td>
						<td align="center" id='noa'>~noa</td>
						<td align="center" id='nick' style="text-align: left;">~nick</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm"  id="tbbm" style="width: 910px;">
					<tr>
						<td class="td1" style="width: 90px;"><span> </span><a id='lblType' class="lbl"> </a></td>
						<td class="td2" style="width: 116px;"><select id="cmbTypea"> </select></td>
						<td class="td3" style="width: 108px;">
							<a id='lblStype' class="lbl" style="float: left;"> </a>
							<span style="float: left;"> </span>
							<select id="cmbStype"> </select>
						</td>
						<td class="td4" style="width: 90px;"><span> </span><a id='lblDatea' class="lbl"> </a></td>
						<td class="td5" style="width: 100px;"><input id="txtDatea" type="text"  class="txt c1"/></td>
						<td class="td6" style="width: 116px;"> </td>
						<td class="td7" style="width: 100px;"><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td class="td8" style="width: 144px;"><input id="txtNoa" type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id="lblAcomp" class="lbl btn"> </a></td>
						<td class="td2"><input id="txtCno" type="text" class="txt c1"/></td>
						<td class="td2"><input id="txtAcomp" type="text" class="txt c1"/></td>
						<td class="td7"><span> </span><a id='lblMon' class="lbl"> </a></td>
						<td class="td8"><input id="txtMon" type="text" class="txt c1"/></td>
						<td class="td8"> </td>
						<td class="td7">
							<span> </span>
							<a id='lblInvono' class="lbl btn vcca"> </a>
							<a id='lblInvo' class="lbl btn invo"> </a>
						</td>
						<td class="td8">
							<input id="txtInvono" type="text" class="txt c1 vcca"/>
							<input id="txtInvo" type="text" class="txt c1 invo"/>
						</td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id="lblCust" class="lbl btn"> </a></td>
						<td class="td2"><input id="txtCustno" type="text" class="txt c1"/></td>
						<td class="td2">
							<input id="txtComp" type="text" class="txt c1"/>
							<input id="txtNick" type="hidden" class="txt c1"/>
						</td>
						<td class="td4"><span> </span><a id='lblPay' class="lbl"> </a></td>
						<td class="td5"><input id="txtPaytype" type="text" class="txt c1"/></td>
						<td class="td6"><select id="combPay" style="width: 100%;" onchange='combPay_chg()'> </select></td>
						<td class="td6" colspan="2">
							<input id="btnOrdes" type="button"/>
							<input id="btnStore2" type="button" value="寄庫顯示"/>
							<input id="btnStore2report" type="button" value="寄庫報表"/>
						</td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id="lblTel" class="lbl"> </a></td>
						<td class="td2" colspan='2'><input id="txtTel" type="text" class="txt c1"/></td>
						<td class="td1"><span> </span><a id="lblFax" class="lbl"> </a></td>
						<td class="td2" colspan='2'><input id="txtFax" type="text" class="txt c1"/></td>
						<td class="td4"><span> </span><a id='lblTrantype' class="lbl"> </a></td>
						<td class="td5"><select id="cmbTrantype" style="width: 100%;"> </select></td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id="lblAddr" class="lbl"> </a></td>
						<td class="td2"><input id="txtPost" type="text" class="txt c1"/></td>
						<td class="td3" colspan='4'><input id="txtAddr" type="text" class="txt c1"/></td>
						<td class="td7"><span> </span><a id='lblOrdeno' class="lbl btn"> </a></td>
						<td class="td8"><input id="txtOrdeno" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblAddr2' class="lbl"> </a></td>
						<td class="td2"><input id="txtPost2"  type="text" class="txt c1"/></td>
						<td class="td3" colspan='4'>
							<input id="txtAddr2"  type="text" class="txt c1" style="width: 412px;"/>
							<select id="combAddr" style="width: 20px" onchange='combAddr_chg()'> </select>
						</td>
						<td class="td1"><span> </span><a id='lblCarno' class="lbl"> </a></td>
						<td class="td2"><input id="txtCarno"  type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id="lblMoney" class="lbl"> </a></td>
						<td class="td2" colspan='2'><input id="txtMoney" type="text" class="txt num c1"/></td>
						<td class="td4"><span> </span><a id='lblTax' class="lbl"> </a></td>
						<td class="td5" colspan='2'>
							<input id="txtTax" type="text" class="txt num c1 istax"  style="width: 49%;"/>
							<!--<select id="cmbTaxtype" style="width: 49%;" onchange="sum();"> </select>-->
							<input id="chkAtax" type="checkbox" />
						</td>
						<td class="td7"><span> </span><a id='lblTotal' class="lbl istax"> </a></td>
						<td class="td8"><input id="txtTotal" type="text" class="txt num c1 istax"/></td>
					</tr>
					<tr class="tr9">
						<td class="td1"><span> </span><a id='lblAcc1' class="lbl btn"> </a></td>
						<td class="td2"><input id="txtAcc1" type="text" class="txt c1" /></td>
						<td class="td3"><input id="txtAcc2" type="text" class="txt c1" /></td>
						<td class="td4"><span> </span><a id='lblCash' class="lbl"> </a></td>
						<td class="td5"  colspan="2"><input id="txtMount" type="text" class="txt num c1" /></td>
						<td class="td7"><span> </span><a id='lblDiscount' class="lbl"> </a></td>
						<td class="td8"><input id="txtDiscount" type="text" class="txt num c1" /></td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblSales' class="lbl btn"> </a></td>
						<td class="td2"><input id="txtSalesno" type="text" class="txt c1"/></td>
						<td class="td3"><input id="txtSales" type="text" class="txt c1"/></td>
						<td class="td4"><span> </span><a id="lblWorker" class="lbl"> </a></td>
						<td class="td5"><input id="txtWorker" type="text" class="txt c1"/></td>
						<td class="td6"><input id="txtWorker2" type="text" class="txt c1"/></td>
						<td class="td7"><span> </span><a id='lblAccc' class="lbl btn"> </a></td>
						<td class="td8"><input id="txtAccno" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id="lblMemo" class="lbl"> </a></td>
						<td class="td2" colspan='7'><textarea id="txtMemo" cols="10" rows="5" style="width: 99%;height: 50px;"> </textarea></td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs' style="width: 2260px;">
			<table id="tbbs" class='tbbs'>
				<tr style='color:White; background:#003366;' >
					<td align="center" style="width:40px;"><input class="btn"  id="btnPlus" type="button" value='＋' style="font-weight: bold;width:" /></td>
					<td align="center" style="width:40px;"><a>項次</a></td>
					<td align="center" style="width:110px"><a id='lblProductno_s'> </a></td>
					<td align="center" style="width:250px;"><a id='lblProduct_s'> </a><a class="isSpec">/</a><a id='lblSpec_s' class="isSpec"> </a></td>
					<td align="center" style="width:95px;" class="isStyle"><a id='lblStyle_s'> </a></td>
					<td align="center" style="width:40px;"><a id='lblUnit_s'> </a></td>
					<td align="center" style="width:80px;">出貨數量</td>
					<td align="center" style="width:80px;">計價數量</td>
					<td align="center" style="width:80px;"><a id='lblPrice_s'> </a></td>
					<td align="center" style="width:80px;"><a id='lblTotal_s'> </a></td>
					<td align="center" style="width:120px;">出貨倉庫</td>
					<td align="center" style="width:80px;"><a id='lblTranmoney2_s'> </a></td>
					<td align="center" style="width:80px;"><a id='lblTranmoney3_s'> </a></td>
					<td align="center" style="width:180px"><a id='lblUno_s'> </a></td>
					<td align="center" style="width:150px;"><a id='lblMemo_s'> </a></td>
					<td align="center" style="width:150px;">訂單號碼</td>
					<td align="center" style="width:40px;"><a id='lblRecord_s'> </a></td>
					<td align="center" style="width:40px;"><a id='lblStk_s'> </a></td>
					<td class="store2" align="center" style="width:120px;"><a id='lblStore2_s'> </a></td>
				</tr>
				<tr id="bbsseq.*" style='background:#cad3ff;'>
					<td align="center"><input class="btn"  id="btnMinus.*" type="button" value='－' style=" font-weight: bold;" /></td>
					<td align="center"><input id="txtNoq.*" type="text" class="txt c1"/></td>
					<td align="center">
						<input class="txt c1"  id="txtProductno.*" type="text" style="width: 75%;" />
						<input class="btn"  id="btnProductno.*" type="button" value='.' style=" font-weight: bold;" />
					</td>
					<td>
						<input id="txtProduct.*" type="text" class="txt c1" />
						<input id="txtSpec.*" type="text" class="txt c1 isSpec" />
					</td>
					<td class="isStyle"><input id="txtStyle.*" type="text" class="txt c1 isStyle" /></td>
					<td><input id="txtUnit.*" type="text" class="txt c1"/></td>
					<td><input id="txtMount.*" type="text" class="txt num c1"/></td>
					<td><input id="txtWidth.*" type="text" class="txt num c1"/></td>
					<td><input id="txtPrice.*" type="text" class="txt num c1"/>
						<input id="txtSprice.*" type="hidden" class="txt num c1"/>
					</td>
					<td><input id="txtTotal.*" type="text" class="txt num c1"/></td>
					<td>
						<input id="txtStoreno.*" type="text" class="txt c1" style="width: 30%"/>
						<input class="btn"  id="btnStoreno.*" type="button" value='.' style=" font-weight: bold;" />
						<input id="txtStore.*" type="text" class="txt c1" style="width: 50%"/>
					</td>
					<td><input id="txtTranmoney2.*" type="text" class="txt num c1"/></td>
					<td><input id="txtTranmoney3.*" type="text" class="txt num c1"/></td>
					<td><input id="txtUno.*" type="text" class="txt c1" /></td>
					<td><input id="txtMemo.*" type="text" class="txt c1"/></td>
					<td>
						<input id="txtOrdeno.*" type="text"  class="txt" style="width:65%;"/>
						<input id="txtNo2.*" type="text" class="txt" style="width:23%;"/>
					</td>
					<td align="center"><input class="btn"  id="btnRecord.*" type="button" value='.' style=" font-weight: bold;" /></td>
					<td align="center"><input class="btn"  id="btnStk.*" type="button" value='.' style="width:1%;"/></td>
					<td class="store2">
						<input id="txtStoreno2.*" type="text" class="txt c1 store2" style="width: 30%"/>
						<input class="btn"  id="btnStoreno2.*" type="button" value='.' style=" font-weight: bold;" />
						<input id="txtStore2.*" type="text" class="txt c1 store2" style="width: 50%"/>
					</td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>