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
            var q_name = "tranvcce";
            var q_readonly = ['txtNoa', 'txtWeight','txtTotal', 'txtWorker', 'txtWorker2'];
            var q_readonlys = ['txtCust'];
            var bbmNum = [];
            var bbsNum = [['txtMount', 10, 2, 1],['txtWeight', 10, 2, 1],['txtVolume', 10, 1, 1],['txtTotal', 10, 2, 1],['txtTotal2', 10, 0, 1]];
            var bbmMask = [];
            var bbsMask = [['txtTime1','999/99/99']];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            q_alias = '';
            q_desc = 1;
            aPop = new Array(['txtCno', 'lblCno', 'acomp', 'noa,acomp', 'txtCno,txtAcomp', 'acomp_b.aspx']
            , ['txtCustno_', 'btnCust_', 'cust', 'noa,paytype,nick', 'txtCustno_,cmbTypea_,txtCust_', 'cust_b.aspx']
            , ['txtProductno_', 'btnProduct_', 'ucc', 'noa,product', 'txtProductno_,txtProduct_', 'ucc_b.aspx']
            , ['txtCarno_', 'btnCarno_', 'car2', 'driverno,a.noa,driver', 'txtDriverno_,txtCarno_,txtDriver_', 'car2_b.aspx']
            , ['txtAddrno_', 'btnStraddr_', 'addr', 'noa,addr', '0txtAddrno_,txtAddr_', 'addr_b.aspx']
            , ['txtAddrno2_', 'btnEndaddr_',  'addr', 'noa,addr', '0txtAddrno2_,txtAddr2_', 'addr_b.aspx']
            , ['txtAddrno3_', 'btnAddr3_', 'cust', 'noa,nick', 'txtAddrno3_,txtAddr3_', 'cust_b.aspx']
            , ['txtDriverno_', 'btnDriver_', 'driver', 'noa,namea', 'txtDriverno_,txtDriver_', 'driver_b.aspx']);

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
            }

            function sum() {
            }

            function mainPost() {
                bbmMask = [['txtDatea', r_picd]];
                q_getFormat();
                q_mask(bbmMask);
                $('#txtDatea').datepicker();
                q_cmbParse("cmbTypea",'月結@月結,付清@付清','s');
                q_cmbParse("cmbUnit2",'@,cm^3@cm^3,m^3@m^3,材@材,CBM@CBM,M@M','s');
                if (q_cur=='0'){
                    $('#textNoa').css('color', 'black').css('background', 'white').removeAttr('readonly');
                    $('#textNoq').css('color', 'black').css('background', 'white').removeAttr('readonly');
                }
                
                $('#btnshseek').click(function() {
                      for(var i=0;i<q_bbsCount;i++){
                           if ($('#txtNo2_' +i).val()==$('#textNoq').val()) {
                            $('#trSel_' + i).addClass('chksel');
                                    //變色
                          }else{
                            $('#trSel_' +i).removeClass('chksel');
                                    //取消變色
                          }
                      }      
                });
                
                $('#btnImport').click(function() {
                      var t_noa = $('#textNoa').val();
                      var t_noq = $('#textNoq').val();
                      if(t_noa.length==0 || t_noq.length==0){
                               alert('讀單編號或是項次空白!!');
                      }else{
                           q_func('qtxt.query.tranvccesh_chk1', 'tranvcce.txt,tranvccesh_chk1,' + encodeURI(t_noa) + ';' + encodeURI(t_noq));
                           if(t_noa.length!=0 || t_noq.length!=0 && $('#txtNoa').val()==$('#textNoa').val()){
                               for(var i=0;i<q_bbsCount;i++){
                                   if ($('#txtNo2_' +i).val()==$('#textNoq').val()) {
                                        $('#chkChk1_'+i).prop('checked',true);
                                   }
                               }
                           }
                           
                      }
                });
                
                $('#btnShowin').click(function() {
                     if ($('#btnShowin').val().indexOf("隱藏") > -1) {
                        $(".hid_Mount").hide();
                        $(".hid_Unit").hide();
                        $(".hid_Volume").hide();
                        $(".hid_Unit2").hide();
                        $(".hid_Weight").hide();
                        for (var j = 0; j < q_bbsCount; j++) {
                            $('#hid_Mount_' + j).hide();
                            $("#hid_Unit_" + j).hide();
                            $("#hid_Volume_" + j).hide();
                            $("#hid_Unit2_" + j).hide();
                            $("#hid_Weight_" + j).hide();

                        }
                        $('#tbbs').css("width",(dec($('#tbbs')[0].offsetWidth)-355)+"px");
                        scroll("tbbs", "box", 1);
                        $("#btnShowin").val("物流顯示");
                    } else {
                        $(".hid_Mount").show();
                        $(".hid_Unit").show();
                        $(".hid_Volume").show();
                        $(".hid_Unit2").show();
                        $(".hid_Weight").show();
                        for (var j = 0; j < q_bbsCount; j++) {
                            $("#hid_Mount_" + j).show();
                            $("#hid_Unit_" + j).show();
                            $("#hid_Volume_" + j).show();
                            $("#hid_Unit2_" + j).show();
                            $("#hid_Weight_" + j).show();
                        }
                        $('#tbbs').css("width",(dec($('#tbbs')[0].offsetWidth)+355)+"px");
                        scroll("tbbs", "box", 1);
                        $("#btnShowin").val("物流隱藏");
                    }
                });
                
                $('#btnShowout').click(function() {
                    if ($('#btnShowout').val().indexOf("隱藏") > -1) {
                        $(".hid_Product").hide();
                        $(".hid_Tranno").hide();
                        for (var j = 0; j < q_bbsCount; j++) {
                            $('#hid_Product_' + j).hide();
                            $("#hid_Tranno_" + j).hide();
                        }
                        $('#tbbs').css("width",(dec($('#tbbs')[0].offsetWidth)-240)+"px");
                        scroll("tbbs", "box", 1);
                        $("#btnShowout").val("貨櫃顯示");
                    } else {
                        $(".hid_Product").show();
                        $(".hid_Tranno").show();
                        for (var j = 0; j < q_bbsCount; j++) {
                            $("#hid_Product_" + j).show();
                            $("#hid_Tranno_" + j).show();
                        }
                        $('#tbbs').css("width",(dec($('#tbbs')[0].offsetWidth)+240)+"px");
                        scroll("tbbs", "box", 1);
                        $("#btnShowout").val("貨櫃隱藏");
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
            
            function q_boxClose(s2) {
                var ret;
                switch (b_pop) {
                case q_name + '_s':
                    q_boxClose2(s2);
                    break;
                }
                b_pop = '';
            }

            function q_gtPost(t_name) {
                switch (t_name) {
                    case 'cust':
                        var as = _q_appendData("cust", "", true);
                        for(var i=0;i<q_bbsCount;i++){
                                   if ($('#txtCustno_' +i).val()==as[0].noa) {
                                        $('#cmbTypea'+i).val(as[0].paytype);
                                   }
                        }
                        break;
                case q_name:
                    if (q_cur == 4)
                        q_Seek_gtPost();
                    break;
                }
            }

            function q_popPost(s1) {
                switch (s1) {
                    case 'txtCustno_':
                        var t_where = "where=^^ noa='"+$('#txtCustno_'+b_seq).val()+"' ^^";
                        q_gt('cust', t_where, 0, 0, 0, "");
                        break;
                }
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
                //自動更換noq
                for(var i=0;i<q_bbsCount;i++){
                    $('#txtNoq_'+i).val('');
                    $('#txtNoq_'+i).val($('#txtNo2_'+i).val());
                }
                for(var i=0;i<q_bbsCount;i++){
                    var t_noq=$('#txtNoq_'+i).val();
                    var t_nos=1;
                    if(t_noq.indexOf('-')==-1){
                        for(var j=i+1;j<q_bbsCount;j++){
                            if(t_noq==$('#txtNoq_'+j).val()){
                                $('#txtNoq_'+j).val(t_noq+'-'+t_nos);
                                t_nos=t_nos+1
                            }
                        }
                        t_nos=0
                    }
                }
                
                if(q_cur ==1){
                    $('#txtWorker').val(r_name);
                }else if(q_cur ==2){
                    $('#txtWorker2').val(r_name);
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

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)
                    return;
                q_box('tranvcce_sh_s.aspx', q_name + '_s', "500px", "600px", '查詢視窗');
            }

            function bbsAssign() {
                for (var i = 0; i < q_bbsCount; i++) {
					$('#lblNo_' + i).text(i + 1);
                    if($('#btnMinus_' + i).hasClass('isAssign'))
                    	continue;
                  $('#txtNo2_' + i).focusout(function (){
                        var s1 = $(this).val();
                            if (s1.length == 1 && s1 == "=") {
                                t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
                                q_bodyId($(this).attr('id'));
                                b_seq = t_IdSeq;
                                if (b_seq > 0) {
                                    var i = b_seq - 1;
                                    var s1 = $('#txtTime1_' + i).val();
                                    $('#txtTime1_' + b_seq).val(s1);
                                    var s2 = $('#txtCustno_' + i).val();
                                    $('#txtCustno_' + b_seq).val(s2); 
                                    var s3 = $('#txtCust_' + i).val();
                                    $('#txtCust_' + b_seq).val(s3);
                                    var s4 = $('#txtMount_' + i).val();
                                    $('#txtMount_' + b_seq).val(s4);
                                    var s5 = $('#txtUnit_' + i).val();
                                    $('#txtUnit_' + b_seq).val(s5); 
                                    var s6 = $('#txtAddrno_' + i).val();
                                    $('#txtAddrno_' + b_seq).val(s6);
                                    var s7 = $('#txtAddr_' + i).val();
                                    $('#txtAddr_' + b_seq).val(s7);
                                    var s8 = $('#txtAddrno2_' + i).val();
                                    $('#txtAddrno2_' + b_seq).val(s8); 
                                    var s9 = $('#txtAddr2_' + i).val();
                                    $('#txtAddr2_' + b_seq).val(s9);
                                    var s10 = $('#txtVolume_' + i).val();
                                    $('#txtVolume_' + b_seq).val(s10);
                                    var s11 = $('#txtTranno_' + i).val();
                                    $('#txtTranno_' + b_seq).val(s11); 
                                    var s12 = $('#txtProductno2_' + i).val();
                                    $('#txtProductno2_' + b_seq).val(s12);
                                    var s13 = $('#txtProductno_' + i).val();
                                    $('#txtProductno_' + b_seq).val(s13); 
                                    var s14 = $('#txtProduct_' + i).val();
                                    $('#txtProduct_' + b_seq).val(s14);
                                    var s15 = $('#txtAddrno3_' + i).val();
                                    $('#txtAddrno3_' + b_seq).val(s15); 
                                    var s16 = $('#txtAddr3_' + i).val();
                                    $('#txtAddr3_' + b_seq).val(s16);
                                    var s17 = $('#txtNo2_' + i).val();
                                    $('#txtNo2_' + b_seq).val(s17); 
                                    var s18 = $('#cmbTypea_' + i).val();
                                    $('#cmbTypea_' + b_seq).val(s18);
                                    var s19 = $('#txtWeight_' + i).val();
                                    $('#txtWeight_' + b_seq).val(s19); 
                                    var s20 = $('#cmbUnit2_' + i).val();
                                    $('#cmbUnit2_' + b_seq).val(s20);
                                    var s21 = $('#txtMemo_' + i).val();
                                    $('#txtMemo_' + b_seq).val(s21);                                     
                                }
                            }else  if(s1.length == 1 && s1 == "@") {
                                t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
                                q_bodyId($(this).attr('id'));
                                b_seq = t_IdSeq;
                                if (b_seq > 0) {
                                    var y=-1;
                                    for (var x = -1;x <b_seq;x++) {
                                        if ($('#Copy_'+x).is(':checked')==true) {
                                                y=y+1;
                                                var seq=b_seq+y;
                                                var s1 = $('#txtTime1_' + x).val();
                                                $('#txtTime1_' + seq).val(s1);
                                                var s2 = $('#txtCustno_' + x).val();
                                                $('#txtCustno_' + seq).val(s2); 
                                                var s3 = $('#txtCust_' + x).val();
                                                $('#txtCust_' + seq).val(s3);
                                                var s4 = $('#txtMount_' + x).val();
                                                $('#txtMount_' + seq).val(s4);
                                                var s5 = $('#txtUnit_' + x).val();
                                                $('#txtUnit_' + seq).val(s5); 
                                                var s6 = $('#txtAddrno_' + x).val();
                                                $('#txtAddrno_' + seq).val(s6);
                                                var s7 = $('#txtAddr_' + x).val();
                                                $('#txtAddr_' + seq).val(s7);
                                                var s8 = $('#txtAddrno2_' + x).val();
                                                $('#txtAddrno2_' + seq).val(s8); 
                                                var s9 = $('#txtAddr2_' + x).val();
                                                $('#txtAddr2_' + seq).val(s9);
                                                var s10 = $('#txtVolume_' + x).val();
                                                $('#txtVolume_' + seq).val(s10);
                                                var s11 = $('#txtTranno_' + x).val();
                                                $('#txtTranno_' + seq).val(s11); 
                                                var s12 = $('#txtProductno2_' + x).val();
                                                $('#txtProductno2_' + seq).val(s12);
                                                var s13 = $('#txtProductno_' + x).val();
                                                $('#txtProductno_' + seq).val(s13); 
                                                var s14 = $('#txtProduct_' + x).val();
                                                $('#txtProduct_' + seq).val(s14);
                                                var s15 = $('#txtAddrno3_' + x).val();
                                                $('#txtAddrno3_' + seq).val(s15); 
                                                var s16 = $('#txtAddr3_' + x).val();
                                                $('#txtAddr3_' + seq).val(s16);
                                                var s17 = $('#txtNo2_' + x).val();
                                                $('#txtNo2_' + seq).val(s17); 
                                                var s18 = $('#cmbTypea_' + x).val();
                                                $('#cmbTypea_' + seq).val(s18);
                                                var s19 = $('#txtWeight_' + x).val();
                                                $('#txtWeight_' + seq).val(s19); 
                                                var s20 = $('#cmbUnit2_' + x).val();
                                                $('#cmbUnit2_' + seq).val(s20);
                                                var s21 = $('#txtMemo_' + x).val();
                                                $('#txtMemo_' + seq).val(s21);
                                        }else{
                                                y=y
                                        }
                                    }                                    
                                }
                            }
                  });
                  $('#txtCustno_' + i).bind('contextmenu', function(e) {
                        /*滑鼠右鍵*/
                        e.preventDefault();
                        var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
                        $('#btnCust_'+n).click();
                  });
                  $('#txtProductno_' + i).bind('contextmenu', function(e) {
                        /*滑鼠右鍵*/
                        e.preventDefault();
                        var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
                        $('#btnProduct_'+n).click();
                  });
                  $('#txtAddrno_' + i).bind('contextmenu', function(e) {
                        /*滑鼠右鍵*/
                        e.preventDefault();
                        var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
                        $('#btnStraddr_'+n).click();
                  });
                  $('#txtAddrno2_' + i).bind('contextmenu', function(e) {
                        /*滑鼠右鍵*/
                        e.preventDefault();
                        var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
                        $('#btnEndaddr_'+n).click();
                  });
                  $('#txtAddrno3_' + i).bind('contextmenu', function(e) {
                        /*滑鼠右鍵*/
                        e.preventDefault();
                        var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
                        $('#btnAddr3_'+n).click();
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
                  $('#txtNo2_' + i).focus(function () {
                            if (!$(this).val())
                                q_msg($(this), '=號複製上一筆資料,@複製多筆勾選資料');
                  });
                  
                  $('#cmbTypea_' + i).change(function() {  
                        for(var i=0;i<q_bbsCount;i++){
                            if($('#cmbTypea_'+i).val()=="付清"){
                                $('#cmbTypea_'+i).css('color','red');
                            };
                        }
                  });
                  $('#btnC1').click(function() {  
                        for(var i=0;i<q_bbsCount;i++){
                            $('#chkChk1_'+i).prop('checked',true);
                        }
                  });
                  /*$('#btnC2').click(function() {  
                        for(var i=0;i<q_bbsCount;i++){
                            $('#chkChk2_'+i).prop('checked',true);
                        }
                  });*/
                }
                _bbsAssign();
                
                 if ($('#btnShowin').val().indexOf("顯示") > -1) {
                        $(".hid_Mount").hide();
                        $(".hid_Unit").hide();
                        $(".hid_Volume").hide();
                        $(".hid_Unit2").hide();
                        $(".hid_Weight").hide();
                        for (var j = 0; j < q_bbsCount; j++) {
                            $('#hid_Mount_' + j).hide();
                            $("#hid_Unit_" + j).hide();
                            $("#hid_Volume_" + j).hide();
                            $("#hid_Unit2_" + j).hide();
                            $("#hid_Weight_" + j).hide();

                        }
                }
                
                if ($('#btnShowout').val().indexOf("顯示") > -1) {
                        $(".hid_Product").hide();
                        $(".hid_Tranno").hide();
                        for (var j = 0; j < q_bbsCount; j++) {
                            $('#hid_Product_' + j).hide();
                            $("#hid_Tranno_" + j).hide();
                        }
                }
                    
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
                for(var i=0;i<q_bbsCount;i++){
                    if($('#cmbTypea_'+i).val()=="付清"){
                          $('#cmbTypea_'+i).css('color','red');
                    };
                }
            }

            function btnPrint() {
            	q_box('z_tran_sh.aspx' + "?;;;noa=" + trim($('#txtNoa').val()) + ";" + r_accy, '', "95%", "95%", q_getMsg("popPrint"));
            }

            function wrServer(key_value) {
                var i;
                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);

                var date = new Date(dec(r_accy)+1911+'-'+$('#txtDatea').val().substr(4,2)+'-'+$('#txtDatea').val().substr(7,2)+' 00:00:00');
                    //隔年度第一天
                var until = new Date(dec(r_accy)+1911+1+'-01-01 00:00:00');
                    //算出剩下天數
                var days = round((until - date)/1000/3600/24,0);
                var maxno=('000'+(999-dec($('#txtNoa').val().substr(10,3)))).slice(-3);
                for(var i=0;i<q_bbsCount;i++){ 
                    $('#txtOrdeno_'+i).val(days+'-'+maxno+'-'+key_value+$('#txtNoq_'+i).val());
                }
                
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
            }

            function bbsSave(as) {
                if (!as['no2'] && !as['time1'] && !as['custno'] && !as['cust'] && !as['productno'] && !as['product'] && !as['mount'] ) {
                    as[bbsKey[1]] = '';
                    return;
                }
                q_nowf();
                as['time1'] = abbm2['datea'];
                as['cno'] = abbm2['cno'];
                as['acomp'] = abbm2['acomp'];
                return true;n
            }

            function refresh(recno) {
                _refresh(recno);
                
            }

            function readonly(t_para, empty) {
                _readonly(t_para, empty);
                if (q_cur=='0'){
                    $('#textNoa').css('color', 'black').css('background', 'white').removeAttr('readonly');
                    $('#textNoq').css('color', 'black').css('background', 'white').removeAttr('readonly');
                }
                for(var i=0;i<q_bbsCount;i++){
                    if($('#cmbTypea_'+i).val()=="付清"){
                          $('#cmbTypea_'+i).css('color','red');
                    };
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
                q_box('tranvcce_s.aspx', q_name + '_s', "500px", "600px", q_getMsg("popSeek"));
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
                width: 630px;
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
                width: 1900px;
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
            .tbbs tr.chksel {
                background: #FA0300;
            }
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		<!--#include file="../inc/toolbar.inc"-->
		<div id="dmain" >
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:5%"><a id="vewChk"> </a></td>
						<td align="center" style="display:none;"><a> </a></td>
						<td align="center" style="width:20%"><a>日期</a></td>
						<td align="center" style="width:20%"><a>電腦編號</a></td>
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
						<td class="tdZ"></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblNoa" class="lbl" > </a></td>
						<td>
						<input id="txtNoa" type="text" class="txt c1"/>
						</td>
						<td><span> </span><a id="lblDatea_sh" class="lbl" >出車日期</a></td>
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
						<td><span> </span><a id="lblMemo" class="lbl" > </a></td>
						<td colspan="3"><textarea id="txtMemo" style="height:40px;" class="txt c1"> </textarea></td>
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
					</tr>
					<tr>
					    <td> </td>
                        <td><input id="btnShowin" type="button" value="物流隱藏" style="width:98%;"/></td>
                        <td><input id="btnShowout" type="button" value="貨櫃隱藏" style="width:98%;"/></td>
                    </tr>
				</table>
			</div>
		</div>
		<!--2017/10/31 于小姐討論後 數量跟材積都是數字 貨櫃的櫃型打在品名 多櫃號、S/O、貨主-->
		<div class='dbbs' >
			<table id="tbbs" class='tbbs' style="background:#cad3ff;">
				<tr style='color:white; background:#003366;' >
					<td align="center" style="width:25px"><input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  /></td>
					<td align="center" style="width:20px;"> </td>
					<td align="center" style="width:10px"><a>複製</a></td>
					<td align="center" style="width:30px"><a>讀單</a>
					    <input type="button" id="btnC1" value="≡">
                    </td>
					<td align="center" style="width:50px"><a>項次</a></td>
					<td align="center" style="width:70px"><a>付款</a></td>
					<td align="center" style="width:90px;display:none;"><a>出車日期</a></td>
					<td align="center" style="width:90px"><a>客戶</a></td>
					<td class="hid_Product" align="center" style="width:100px"><a>品項</a></td>
					<td class="hid_Mount" align="center" style="width:75px"><a>數量</a></td>
					<td class="hid_Unit" align="center" style="width:50px"><a>單位</a></td>
					<td class="hid_Volume" align="center" style="width:75px"><a>材積</a></td>
					<td class="hid_Unit2" align="center" style="width:80px"><a>材積單位</a></td>
					<td class="hid_Weight" align="center" style="width:75px"><a>重量(KG)</a></td>
					<td align="center" style="width:100px"><a>起點</a></td>
					<td align="center" style="width:100px"><a>迄點</a></td>
					<td class="hid_Tranno" align="center" style="width:140px"><a>櫃號</a></td>
					<td align="center" style="width:140px;display:none;"><a>S/O</a></td>
					<td align="center" style="width:100px;display:none;"><a>貨主</a></td>
					<td align="center" style="width:80px"><a>金額</a></td>
					<td align="center" style="width:100px"><a>車牌</a></td>
					<td align="center" style="width:80px"><a>司機</a></td>
					<td align="center" style="width:80px"><a>司機運費</a></td>
					    
					<!--<td align="center" style="width:50px"><a>確認</a>
					    <input type="button" id="btnC2" value="≡">
					</td>-->
					<td align="center" style="width:250px"><a>備註</a></td>
				</tr>
				<tr id="trSel.*">
					<td align="center">
						<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
						<input type="text" id="txtNoq.*" style="display:none;"/>
					</td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td align="center"><input id="Copy.*" type="checkbox" style="zoom:1.5"/></td>
					<td align="center"><input id="chkChk1.*" type="checkbox" style="zoom:1.5"/></td>
					<td><input type="text" id="txtNo2.*" style="width:95%;"/></td>
					<td><select id="cmbTypea.*" class="txt" style="width:95%;"> </select></td>
					<td style="display:none;"><input type="text" id="txtTime1.*" style="width:95%;"/></td>
					<td>
						<input type="text" id="txtCustno.*" style="float:left;width:95%;" />
						<input type="text" id="txtCust.*" style="float:left;width:95%;">
						<input type="button" id="btnCust.*" style="display:none;">
						<input type="text" id="txtOrdeno.*" style="display:none;"/>
					</td>
					<td id='hid_Product.*'>
                        <input type="text" id="txtProductno.*" style="float:left;width:95%;" />
                        <input type="text" id="txtProduct.*" style="float:left;width:95%;">
                        <input type="button" id="btnProduct.*" style="display:none;">
                    </td>
					<td id='hid_Mount.*'><input type="text" id="txtMount.*" class="num" style="width:95%;"/></td>
					<td id='hid_Unit.*'><input type="text" id="txtUnit.*" style="width:95%;"/></td>
					<td id='hid_Volume.*'><input type="text" id="txtVolume.*" class="num" style="width:95%;"/></td>
					<td id='hid_Unit2.*'><select id="cmbUnit2.*" class="txt" style="width:95%;"> </select></td>
					<td id='hid_Weight.*'><input type="text" id="txtWeight.*" class="num" style="width:95%;"/></td>
					<td>
                        <input type="text" id="txtAddrno.*" style="float:left;width:95%;"/>
                        <input type="text" id="txtAddr.*" style="float:left;width:95%;"/>
                        <input type="button" id="btnStraddr.*" style="display:none;"/>
                    </td>
                    <td>
                        <input type="text" id="txtAddrno2.*" style="float:left;width:95%;"/>
                        <input type="text" id="txtAddr2.*" style="float:left;width:95%;"/>
                        <input type="button" id="btnEndaddr.*" style="display:none;"/>
                    </td>
                    <td id='hid_Tranno.*'><input type="text" id="txtTranno.*" style="float:left;width:95%;"/></td>
                    <td style="display: none"><input type="text" id="txtProductno2.*" style="float:left;width:95%;"/></td>
                    <td style="display: none">
                        <input type="text" id="txtAddrno3.*" style="float:left;width:95%;"/>
                        <input type="text" id="txtAddr3.*" style="float:left;width:95%;"/>
                        <input type="button" id="btnAddr3.*" style="display:none;"/>
                    </td>
					<td><input type="text" id="txtTotal.*" class="num" style="width:95%;"/></td>
					<td>
						<input type="text" id="txtCarno.*" style="width:95%;"/>
						<input type="button" id="btnCarno.*" style="display:none;"/>
					</td>
					<td>
					    <input type="text" id="txtDriverno.*" style="float:left;width:95%;"/>
                        <input type="text" id="txtDriver.*" style="float:left;width:95%;"/>
                        <input type="button" id="btnDriver.*" style="display:none;"/>
                    </td>
                    <td><input type="text" id="txtTotal2.*" class="num" style="width:95%;"/></td>
					<!--<td align="center"><input id="chkChk2.*" type="checkbox"/></td>-->
					<td><input type="text" id="txtMemo.*" style="float:left;width:98%;"/></textarea></td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden"/>
	</body>
</html>