<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!-- #include file="_ph.asp" -->
<!-- #include file="_page.asp" -->
<!-- #include file="_olu.asp" -->
<!-- #include file="_login.asp" -->
<!-- #include file="_toBigNum.asp" -->
<%
login() 'before login location


'接收參數
If Request.Cookies("id") <> "" Then f_id = Request.Cookies("id") Else f_id = NULL

'test'
f_id = "{F6EBB606-5E85-4120-B511-352BCF668C60}" 
'test'

f_numDetail = Request.Cookies("f_numDetail") 
f_hotel = Request.Cookies("f_hotel")
f_ticket = Request.Cookies("f_ticket")
'Response.Cookies("id") = ""
'Response.Cookies("f_hotel") = ""
'Response.Cookies("f_ticket") = ""


'Response.Write "p_No= " & p_No & "<br>"
'Response.Write Err.Description & " .......................00<br>"

'feedback
Set rs = GetSQLMdb("rtstours","SELECT * FROM feedback WHERE f_id = '"& f_id &"' AND (type_id = '2' OR type_id = '4') ")
If rs.EOF Then
  Response.Redirect "index_new.asp"
End If
p_no = rs("p_no")
f_name1 = rs("f_name1")
f_sex = rs("f_sex")
If f_sex = "m" Then
  f_sex = "男"
Else
  f_sex = "女"
End If
f_cellphone = rs("f_cellphone")
f_tel = rs("f_tel")
f_tel2 = rs("f_tel2")
f_email = rs("f_email")
f_notes = rs("f_notes")
rsclose rs

orderNo = Mid(rs("f_notes"),Instr(rs("f_notes"),"訂單編號")+5,10)

numDetail = Split(rs("f_numDetail"),",")  '人員明細
numDetailTot = 0
For i = 0 To Ubound(numDetail)
  numDetailTot = numDetailTot + Cint(numDetail(i))
Next

'product
Set rsp = GetSQLMdb("rtstours","SELECT * FROM product WHERE p_no = '"& p_no &"' ")
If Not rsp.Eof Then
  p_id = rsp("p_id")
  type_id = rsp("type_id")
  kind_id = rsp("kind_id")
  p_title = rsp("p_title")
  p_airline = rsp("p_airline")  
  p_time3 = rsp("p_time3")  
  p_time4 = rsp("p_time4")
  p_price1 = rsp("p_price1")
End If
rsclose rsp

'天數
Set rspc = GetSQLMdb("Tour","SELECT days FROM DIR WHERE GroNo = '"& p_No &"' ")
If Not rspc.Eof Then
  p_days = rspc("days")
Else
  Set rspc = GetSQLMdb("rtstours","SELECT * FROM productContent WHERE p_id = '"& p_id &"' ORDER BY pc_day ASC ")
  If Not rspc.Eof Then p_days = rspc.Recordcount
End If  
rsclose rspc

'OrderGroup - 航班明細查詢 (A班機說明)
Set rsog = GetSQLMdb("Tour","SELECT * FROM OrderGroup WHERE GroNo = '"& p_No &"' ORDER BY Date1 ASC ")


'Hotel - 住宿明細查詢 (B住宿說明)
'Set rshotel = GetSQLMdb("Tour","SELECT * FROM Hotel WHERE GroNo = '"& p_No &"' ORDER BY Date1 ASC ")
Set rshotel = GetSQLMdb("rtstours","SELECT * FROM productHotel WHERE h_id in ('"& Replace(f_hotel,";","','") &"') ORDER BY gp ASC ")


'Ticket - 加購票券查詢 (C票券說明)
f_ticketDim = Split(f_ticket,";")
f_ticketsql = ""
redim taDim(Ubound(f_ticketDim)+1)
redim tcDim(Ubound(f_ticketDim)+1)
For i = 0 To Ubound(f_ticketDim)
  f_ticketDim2 = Split(f_ticketDim(i),",")
  If f_ticketsql <> "" Then f_ticketsql = f_ticketsql & "','"  
  f_ticketsql = f_ticketsql & f_ticketDim2(0)
  taDim(i+1) = f_ticketDim2(1)
  If f_ticketDim2(2) <> "" Then tcDim(i+1) = f_ticketDim2(2) 
Next 

'Ticket - 加購票券查詢 (C票券說明)
Set rsticket = GetSQLMdb("rtstours","SELECT * FROM productTicket WHERE t_id in ('"& f_ticketsql &"') ORDER BY gp ASC ")


'Update keywords...
a_keyword = p_title & ", " & a_keyword


'Update Location & Action
LocationNow = "報名成功"
ActionNow = p_title
olu = oluObj(LocationNow, ActionNow)
%>
<!DOCTYPE html>
<html lang="zh-TW">
<head>
  <title>報名成功 | <%= a_web %></title>
  <meta name="description" content="<%= a_description %>">
  <!-- #include file="_keyword_new.asp" -->
</head>
<body>
  <!--#include file="header_new.asp"-->  
  <section class="content-central no_padtop prod_confirm form_style">
    <div class="content_info">
      <div class="paTB30">
        <div class="container">
          <div class="row">
            <div class="col-md-12">
              <div class="alert alert-warning paL20_xs" role="alert">
                <i class="fa fa-check-circle"></i> 報名成功！可至<a href="order_history_new.asp" class="alert-link">歷史訂單</a>查看您的報名紀錄。
              </div>
            </div>
            <div class="col-md-12 form-theme">
              <h3>訂購資料：</h3>
              <div class="text_c">
                <%= f_notes %>
              </div>
              <div class="clearfix"></div>
            </div>
            <div class="col-md-12 text_c">
              <a href="index_new.asp"><button class="btn btn-clear">回到首頁</button></a>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
  
  <!--#include file="foot_new.asp"-->
  <!--#include file="footJs_new.asp"-->
</body>
</html>
<!--#include file="_backpost.asp"-->


<% 
response.end()
login() 'before login location


'接收參數
If Request.Cookies("id") <> "" Then f_id = Request.Cookies("id") Else f_id = NULL

f_numDetail = Request.Cookies("f_numDetail") 
f_hotel = Request.Cookies("f_hotel")
f_ticket = Request.Cookies("f_ticket")
'Response.Cookies("id") = ""
'Response.Cookies("f_hotel") = ""
'Response.Cookies("f_ticket") = ""


'Response.Write "p_No= " & p_No & "<br>"
'Response.Write Err.Description & " .......................00<br>"

'feedback
Set rs = GetSQLMdb("rtstours","SELECT * FROM feedback WHERE f_id = '"& f_id &"' AND (type_id = '2' OR type_id = '4') ")
If rs.EOF Then
	Response.Redirect "index.asp"
End If

orderNo = Mid(rs("f_notes"),Instr(rs("f_notes"),"訂單編號")+5,10)

numDetail = Split(rs("f_numDetail"),",")	'人員明細
numDetailTot = 0
For i = 0 To Ubound(numDetail)
  numDetailTot = numDetailTot + Cint(numDetail(i))
Next

'product
Set rsp = GetSQLMdb("rtstours","SELECT * FROM product WHERE p_no = '"& rs("p_No") &"' ")
If Not rsp.Eof Then
  p_No = rsp("p_No")
	p_id = rsp("p_id")
	type_id = rsp("type_id")
	kind_id = rsp("kind_id")
	p_title = rsp("p_title")
	p_airline = rsp("p_airline")	
	p_time3 = rsp("p_time3")	
	p_time4 = rsp("p_time4")
	p_price1 = rsp("p_price1")
End If
rsclose rsp

'天數
Set rspc = GetSQLMdb("Tour","SELECT days FROM DIR WHERE GroNo = '"& p_No &"' ")
If Not rspc.Eof Then
  p_days = rspc("days")
Else
	Set rspc = GetSQLMdb("rtstours","SELECT * FROM productContent WHERE p_id = '"& p_id &"' ORDER BY pc_day ASC ")
	If Not rspc.Eof Then p_days = rspc.Recordcount
End If	
rsclose rspc

'OrderGroup - 航班明細查詢 (A班機說明)
Set rsog = GetSQLMdb("Tour","SELECT * FROM OrderGroup WHERE GroNo = '"& p_No &"' ORDER BY Date1 ASC ")


'Hotel - 住宿明細查詢 (B住宿說明)
'Set rshotel = GetSQLMdb("Tour","SELECT * FROM Hotel WHERE GroNo = '"& p_No &"' ORDER BY Date1 ASC ")
Set rshotel = GetSQLMdb("rtstours","SELECT * FROM productHotel WHERE h_id in ('"& Replace(f_hotel,";","','") &"') ORDER BY gp ASC ")


'Ticket - 加購票券查詢 (C票券說明)
f_ticketDim = Split(f_ticket,";")
f_ticketsql = ""
redim taDim(Ubound(f_ticketDim)+1)
redim tcDim(Ubound(f_ticketDim)+1)
For i = 0 To Ubound(f_ticketDim)
  f_ticketDim2 = Split(f_ticketDim(i),",")
	If f_ticketsql <> "" Then f_ticketsql = f_ticketsql & "','"  
	f_ticketsql = f_ticketsql & f_ticketDim2(0)
	taDim(i+1) = f_ticketDim2(1)
	If f_ticketDim2(2) <> "" Then tcDim(i+1) = f_ticketDim2(2) 
Next 

'Ticket - 加購票券查詢 (C票券說明)
Set rsticket = GetSQLMdb("rtstours","SELECT * FROM productTicket WHERE t_id in ('"& f_ticketsql &"') ORDER BY gp ASC ")


'Update keywords...
a_keyword = p_title & ", " & a_keyword


'Update Location & Action
LocationNow = "自由行報名成功"
ActionNow = p_title
olu = oluObj(LocationNow, ActionNow)
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv='X-UA-Compatible' content='IE=9; requiresActiveX=true' >
<title>自由行報名成功 | <%= a_web %></title>
<meta name="description" content="<%= rs("p_notes") %>">
<!-- #include file="_keyword.asp" -->
<link href="css/free.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="js/cal3.js"></script>
<script src="js/skdslider.js"></script>
<script type="text/javascript">
		jQuery(document).ready(function(){
    window.open('http://js.bondlink.com.tw/pdf_rtsOrders/pdf_orders.asp?fid=<%= f_id %>&orderNo=<%= orderNo %>','_hidden'); 																			
		jQuery('#demo').skdslider({'delay':5000, 'fadeSpeed': 2000,'showNextPrev':true,'showPlayButton':false,'autoStart':true});
		$("img").lazyload({
			placeholder : "fill.gif", //加载图片前的占位图片
			effect      : "fadeIn" //加载图片使用的效果(淡入)
		});
    selDepdate('','<%= p_No %>');			//三個日曆選擇
		
 });
 
 pdfDownloadFun = function(p_no){
	 $.ajax({
	   url:'pdfhits.asp',
		 data:{no:p_no
		 },
		 success:function(){
			// alert("success");
		 },
		 error:function(){
			// alert("error");			 
		 }
	 });	
   window.open('http://js.bondlink.com.tw/pdf/pdf.asp?no='+p_no,'_blank'); 	 
 }
</script>



<!-- 選單 -->
<script type='text/javascript' src='js/superfish.js?ver=1.4.8'></script>
  <script type="text/javascript">
  	// initialise plugins
		jQuery(function(){
			// main navigation init
			jQuery('ul.free_sf_menu').superfish({
				delay:       1000, 		// one second delay on mouseout 
				animation:   {opacity:'show',height:'show'}, // fade-in and slide-down animation 
				speed:       'normal',  // faster animation speed 
				autoArrows:  true,   // generation of arrow mark-up (for submenu) 
				dropShadows: false   // drop shadows (for submenu)
			});
			
			// prettyphoto init
			jQuery("a[rel^='prettyPhoto']").prettyPhoto({
				animation_speed:'normal',
				slideshow:5000,
				autoplay_slideshow: false
			});
			
			// easyTooltip init
			jQuery("a.tooltip").easyTooltip();
			
			jQuery('#widget-footer .grid_3, #widget-footer .grid_4').equalHeightColumns();
			
			
			jQuery('.post_list.services li:nth-child(odd)').addClass("odd");
			jQuery('.post_list.services li:nth-child(2)').addClass("second-child");
			jQuery('.recent-posts.team li:nth-child(3n)').addClass("nomargin");
			
			
		});
		
		// Init for audiojs
		audiojs.events.ready(function() {
			var as = audiojs.createAll();
		});
  </script>
  

</head>
<iframe name="_hidden" height="0"></iframe>
<body id="<%= bodybg %>">
<!--#include file="header.asp"-->
<!--#include file="banner.asp"-->
<div id="mainframe">
 <div class="infoframe"><!--leftbox END-->
	<div class="rightinfo" style=" width:100%">
		<div class="share" style=" width:200px">
		  <button class="Forward" onclick="javascript:document.location.href='mail_friend.asp?no=<%= p_No %>';"></button>
      <button class="Download" onClick="javascript:pdfDownloadFun('<%= rs("p_No") %>');"></button>
      <button class="Print" onClick="javascript:window.open('downloadpdf.asp?no=<%= rs("p_No") %>','_blank');"></button>
		</div>
		<h2 class="infotit" style=" margin-top:0; margin-bottom:0">報名行程</h2>
	  <div class="prod_info" style=" width:45%; float:left">
	    <p><span>【團　名】</span><%= p_title %></p>
			<p><span>【價　格】</span><span class="price">$ <%= p_price1 %></span>起</p>
			<p><span>【天　數】</span><b><%= p_days %></b>天</p>
		</div>
		<div class="prod_info" style=" width:45%; float:left">
      <p><span>【團　號】</span><%= p_No %></p>
      <p><span>【出發日】</span><%= p_time4 %></p>
      <p><span>【返程日】</span><%= dateadd("d",p_days-1,p_time4) %></p>
    </div>
	</div><!--rightinfo END-->
</div><!--infoframe END-->

<div class="clear"></div>
<div class="infoframe"><!--tab_landmarks  END-->

	<div class="clear"></div>

	<div id="tab_note" class="tab_content">
		<div class="title_blue">報名資料</div>
			<div class="Rightbox">
				<h4 style="float:left">團名：<%= p_title %><br />
				團號：<%= p_No %><br /></h4>
				<table width="100%" border="0" cellspacing="0" cellpadding="0"  class="normal">
          <tr>
            <td colspan="4" class="lastbar" scope="row" style=" padding:10px; padding-left:100px; padding-right:100px;">
              <%= rs("f_notes") %><br /><br />
            </td>
          </tr>
          <tr>
            <td colspan="4" class="lastbar" scope="row" style=" padding:10px">
            <p class="bc635e">
              ★ 請注意！ 本公司 保有接受詢問訂單與否權利，經報名後，<br />
              該旅遊產品本公司之業務專員於報名48小時內與您聯絡並洽談相關事宜，但不保證一定有名額。<br />
              ★ 若因匯率或航空票價調漲等因素，本公司於收到訂金前，保有調整團費之權利！
            </p>    
            </td>
          </tr>
          <tr>
            <th scope="row" class="lastbar">&nbsp;</th>
            <td colspan="3" class="lastbar">&nbsp;</td>
          </tr>
        </table>
        <% rsclose rs %>
			<div style=" text-align:center">
			<button onclick="location.href='index.asp'">回到首頁</button>
      </div>
    </div>
</div><!--tab_note  END-->

<div class="clear"></div>

<!--tab_signup  END-->


</div> 
 
</div>
<!--mainframe  END-->
<!--#include file="footer.asp"-->
<!-- END-->
</body>
</html>

