<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
        <link href="../qbox.css" rel="stylesheet" type="text/css" />
        <link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"> </script>
		<script src="css/jquery/ui/jquery.ui.widget.js"> </script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"> </script>
		<script type="text/javascript">
			var q_name = "tranvcces";
			
			aPop = new Array(['txtCustno', '', 'cust', 'noa,comp,nick', 'txtCustno', 'cust_b.aspx']
			    ,['txtCno', '', 'acomp', 'noa,acomp', 'txtCno', 'acomp_b.aspx']
				,['txtProductno', '', 'ucc', 'noa,product', 'txtProductno', 'ucc_b.aspx']
				,['txtAddrno', '', 'addr', 'noa,addr', 'txtAddrno', 'addr_b.aspx']
				,['txtAddrno2', '', 'Addr', 'noa,product', 'txtAddrno2', 'addr_b.aspx']
				,['txtCarno', '', 'car2', 'a.noa,driverno,driver', 'txtCarno', 'car2_b.aspx']
				,['txtDriverno', '', 'driver', 'noa,namea', 'txtDriverno', 'driver_b.aspx']);
				
			$(document).ready(function() {
				main();
			});
			/// end ready
			function main() {
				mainSeek();
				q_gf('', q_name);
			}
			function q_gfPost() {
				q_getFormat();
				q_langShow();
				bbmMask = [['txtBdate', r_picd], ['txtEdate', r_picd]];
				q_mask(bbmMask);
				$('#txtBdate').datepicker();
				$('#txtEdate').datepicker(); 
				$('#txtNoa').focus();
				$('#txtNoa').val('BP');
				if($('#txtEdate').val()==''){
                    $('#txtEdate').val($('#txtBdate').val());
                }
                $('#txtBdate').change(function() {
                        if($('#txtEdate').val().length==0){
                            $('#txtEdate').val($('#txtBdate').val());
                        }  
                });
                $('#txtNoa').change(function() {
                        if($('#txtNoa').val().length!=0){
                            $('#txtNoa').val($('#txtNoa').val());
                        }  
                });
			}
			function q_seekStr() {
				t_bdate = $.trim($('#txtBdate').val());
				t_edate = $.trim($('#txtEdate').val());
				t_noa = $.trim($('#txtNoa').val());
				t_no2= $.trim($('#txtNo2').val());
				t_custno = $.trim($('#txtCustno').val());
				t_cust = $.trim($('#txtCust').val());
				t_productno = $.trim($('#txtProductno').val());
                t_product = $.trim($('#txtProduct').val());
                t_addrno = $.trim($('#txtAddrno').val());
                t_addr = $.trim($('#txtAddr').val());
                t_addrno2 = $.trim($('#txtAddrno2').val());
                t_addr2= $.trim($('#txtAddr2').val());
                t_tranno= $.trim($('#txtTranno').val());
                t_carno= $.trim($('#txtCarno').val());
                t_driverno= $.trim($('#txtDriverno').val());
                t_driver= $.trim($('#txtDriver').val());
                t_total= $.trim($('#txtTotal').val());
				
				var t_where = " 1=1 "
					+q_sqlPara2("time1", t_bdate, t_edate)
					+q_sqlPara2("noa", t_noa)
					+q_sqlPara2("no2", t_no2)
					+q_sqlPara2("custno", t_custno)
					+q_sqlPara2("productno", t_productno)
					+q_sqlPara2("addrno", t_addrno)
					+q_sqlPara2("addrno2", t_addrno2)
					+q_sqlPara2("tranno", t_tranno)
					+q_sqlPara2("carno", t_carno)
					+q_sqlPara2("driverno", t_driverno)
					+q_sqlPara2("total", t_total)
					;
					
				if (t_cust.length>0)
                    t_where += " and charindex('" + t_cust + "',cust)>0";
                if (t_product.length>0)
                    t_where += " and charindex('" + t_product + "',product)>0";
                if (t_addr.length>0)
                    t_where += " and charindex('" + t_addr + "',addr)>0";
                if (t_addr2.length>0)
                    t_where += " and charindex('" + t_addr2 + "',addr2)>0";
                if (t_driver.length>0)
                    t_where += " and charindex('" + t_driver + "',driver)>0";
                        
				t_where = ' where=^^' + t_where + '^^ ';
				return t_where;
			}
		</script>
		<style type="text/css">
			.seek_tr {
				color: white;
				text-align: center;
				font-weight: bold;
				background-color: #76a2fe
			}
		</style>
	</head>
	<body>
		<div style='width:400px; text-align:center;padding:15px;' >
			<table id="seek"  border="1"   cellpadding='3' cellspacing='2' style='width:100%;' >
				<tr class='seek_tr'>
					<td style="width:35%;" ><a id='lblDatea'>日期</a></td>
					<td style="width:65%;  ">
					<input class="txt" id="txtBdate" type="text" style="width:90px; font-size:medium;" />
					<span style="display:inline-block; vertical-align:middle">&sim;</span>
					<input class="txt" id="txtEdate" type="text" style="width:93px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblNoa'>電腦編號</a></td>
					<td><input class="txt" id="txtNoa" type="text" style="width:220px;float:left; font-size:medium;" /></td>
				</tr>
				<tr class='seek_tr'>
                    <td class='seek'  style="width:20%;"><a id='lblNo2'>項次</a></td>
                    <td><input class="txt" id="txtNo2" type="text" style="width:220px;float:left; font-size:medium;" /></td>
                </tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblCustno'>客戶編號</a></td>
					<td><input class="txt" id="txtCustno" type="text" style="width:220px;float:left; font-size:medium;" /></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblCust'>客戶名稱</a></td>
					<td><input class="txt" id="txtCust" type="text" style="width:220px;float:left; font-size:medium;" /></td>
				</tr>
				<tr class='seek_tr'>
                    <td class='seek'  style="width:20%;"><a id='lblProductno'>品項編號</a></td>
                    <td><input class="txt" id="txtProductno" type="text" style="width:220px;float:left; font-size:medium;" /></td>
                </tr>
                <tr class='seek_tr'>
                    <td class='seek'  style="width:20%;"><a id='lblProduct'>品項</a></td>
                    <td><input class="txt" id="txtProduct" type="text" style="width:220px;float:left; font-size:medium;" /></td>
                </tr>
                <tr class='seek_tr'>
                    <td class='seek'  style="width:20%;"><a id='lblAddrno'>起點</a></td>
                    <td><input class="txt" id="txtAddrno" type="text" style="width:80px;float:left; font-size:medium;" />
                        <input class="txt" id="txtAddr" type="text" style="width:140px;float:left; font-size:medium;" /></td>
                </tr>
                <tr class='seek_tr'>
                    <td class='seek'  style="width:20%;"><a id='lblAddrno2'>迄點</a></td>
                    <td><input class="txt" id="txtAddrno2" type="text" style="width:80px;float:left; font-size:medium;" />            
                        <input class="txt" id="txtAddr2" type="text" style="width:140px;float:left; font-size:medium;" /></td>
                </tr>
                <tr class='seek_tr'>
                    <td class='seek'  style="width:20%;"><a id='lblTranno'>櫃號</a></td>
                    <td><input class="txt" id="txtTranno" type="text" style="width:220px;float:left; font-size:medium;" /></td>
                </tr>
                <tr class='seek_tr'>
                    <td class='seek'  style="width:20%;"><a id='lblTotal'>金額</a></td>
                    <td><input class="txt" id="txtTotal" type="text" style="width:220px;float:left; font-size:medium;" /></td>
                </tr>
                <tr class='seek_tr'>
                    <td class='seek'  style="width:20%;"><a id='lblCarno'>車牌</a></td>
                    <td><input class="txt" id="txtCarno" type="text" style="width:220px;float:left; font-size:medium;" /></td>
                </tr>
                <tr class='seek_tr'>
                    <td class='seek'  style="width:20%;"><a id='lblDriverno'>司機</a></td>
                    <td><input class="txt" id="txtDriverno" type="text" style="width:110px;float:left; font-size:medium;" />
                        <input class="txt" id="txtDriver" type="text" style="width:110px;float:left; font-size:medium;" /></td>
                </tr>
			</table>
			<!--#include file="../inc/seek_ctrl.inc"-->
			<datalist id="listTypea"> </datalist>
		</div>
	</body>
</html>