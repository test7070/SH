﻿<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta http-equiv="Content-Language" content="en-us" />
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src="../script/qj2.js" type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src="../script/qj_mess.js" type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
            var q_name = 'view_tranvcces', t_bbsTag = 'tbbs', t_content = " ", afilter = [], bbsKey = ['noa'], as;
            var t_sqlname = '';
            t_postname = q_name;
            var isBott = false;
            var txtfield = [], afield, t_data, t_htm;
            var i, s1;
            brwCount = -1;
            brwCount2 = 0;
            $(document).ready(function() {
                if (!q_paraChk())
                    return;

                main();
                $('#btnTop').hide();
                $('#btnPrev').hide();
                $('#btnNext').hide();
                $('#btnBott').hide();
            });

            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                mainBrow(6, t_content, t_sqlname, t_postname, r_accy);
            }

			function mainPost(){
			}

            function bbsAssign() {
                _bbsAssign();
            }

            function q_gtPost() {
            }

            function refresh() {
                _refresh();
                $('#checkAllCheckbox').click(function() {
                    $('input[type=checkbox][id^=chkSel]').each(function() {
                        var t_id = $(this).attr('id').split('_')[1];
                        if (!emp($('#txtNoa_' + t_id).val()))
                            $(this).attr('checked', $('#checkAllCheckbox').is(':checked'));
                    });
                });
                
                for(var i=0;i<q_bbsCount;i++){
					$('#lblNo_'+i).text((i+1));
				}
            }

		</script>
		<style type="text/css">
            .seek_tr {
                color: white;
                text-align: center;
                font-weight: bold;
                BACKGROUND-COLOR: #76a2fe
            }
            input[type="text"], input[type="button"] {
                font-size: medium;
            }
            select {
                font-size: medium;
            }
		</style>
	</head>
	<body>
		<div  id="dbbs"  >
			<table id="tbbs" class='tbbs'  border="2"  cellpadding='2' cellspacing='1' style='width:100%'  >
				<tr style='color:White; background:#003366;' >
					<td align="center" style="width:25px" ><input type="checkbox" id="checkAllCheckbox"/></td>
					<td align="center" style="width:25px;"> </td>
					<th align="center"><a id=''>派車單號/項次</a></th>
					<th align="center"><a id=''>客戶</a></th>
					<th align="center"><a id=''>出車日期</a></th>
					<th align="center"><a id=''>品名</a></th>
					<th align="center"><a id=''>數量</a></th>
					<th align="center"><a id=''>材積</a></th>
					<th align="center"><a id=''>重量</a></th>
					<th align="center"><a id=''>起點 / 迄點</a></th>
					<th align="center"><a id=''>櫃號 / S/O</a></th>
					<th align="center"><a id=''>金額</a></th>
					<th align="center"><a id=''>出車車號</a></th>
					<th align="center"><a id=''>司機</a></th>
					<th align="center"><a id=''>讀單</a></th>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td style="width:25px;"><input id="chkSel.*" type="checkbox"/></td>
					<td style="width:25px;"><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td style="width:140px;" align="center">
						<input id="txtNoa.*" type="text" style="float:left;width:95%;" readonly="readonly"/>
						<input id="txtNoq.*" type="text" style="float:left;width:40%;"  readonly="readonly" />
						<input id="txtNo2.*" type="text" style="float:left;width:45%;"  readonly="readonly" />
					</td>
					<td style="width:80px;" align="center">
						<input id="txtCustno.*" type="text" style="display:none;"/>
						<input id="txtCust.*" type="text" style="float:left;width:95%;" readonly="readonly"/>
						<input id="txtTypea.*" type="text" style="float:left;width:95%;" readonly="readonly"/>
					</td>
					<td style="width:80px;">
                        <input id="txtTime1.*" type="text" style="float:left;width:95%;" readonly="readonly" />
                    </td>
                    <td style="width:90px;">
                        <input id="txtProduct.*" type="text" style="float:left;width:95%;" readonly="readonly" />
                    </td>
					<td style="width:70px;">
                        <input id="txtMount.*" type="text" style="float:left;width:95%;" readonly="readonly"/>
                    </td>
					<td style="width:70px;">
					    <input id="txtVolume.*" type="text" style="float:left;width:95%;" readonly="readonly"/>
					</td>
					<td style="width:70px;">
                        <input id="txtWeight.*" type="text" style="float:left;width:95%;" readonly="readonly"/>
                    </td>
					<td style="width:90px;">
						<input id="txtAddrno.*" type="text" style="display:none;"/>
						<input id="txtAddr.*" type="text" style="float:left;width:95%;" readonly="readonly" />
                        <input id="txtAddrno2.*" type="text" style="display:none;"/>
                        <input id="txtAddr2.*" type="text" style="float:left;width:95%;" readonly="readonly" />
                    </td>
                    <td style="width:100px;">
                        <input id="txtTranno.*" type="text" style="float:left;width:95%;" readonly="readonly" />
                        <input id="txtProductno2.*" type="text" style="float:left;width:95%;" readonly="readonly" />
                    </td>
                    <td style="width:70px;">
                        <input id="txtTotal.*" type="text" style="float:left;width:95%;" readonly="readonly"/>
                    </td>
					<td style="width:70px;">
                        <input id="txtCarno.*" type="text" style="float:left;width:95%;" readonly="readonly"/>
                    </td>
                    <td style="width:80px;">
                        <input id="txtdriverno.*" type="text" style="float:left;width:95%;" readonly="readonly"/>
                        <input id="txtdriver.*" type="text" style="float:left;width:95%;" readonly="readonly"/>
                    </td>
                    <td style="display:none;">
                        <input id="txtUnit.*" style="display:none;" />
                    </td>
                    <td style="width:20px;">
                       <input id="chkChk1.*" type="checkbox"/>
                    </td>
				</tr>
			</table>
		</div>
		<div>
			<!--#include file="../inc/pop_ctrl.inc"-->
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>


