// main.JS
//--------------------------------------------------------------------------------------------------------------------------------
//This is JS file that contains principal fuctions of theme */
// -------------------------------------------------------------------------------------------------------------------------------
// Template Name: Travelia - Travel Theme And Hotel Online Booking.
// Author: Iwthemes.
// Name File: main.js
// Version 1.0 - Created on 26 May 2015
// Website: http://www.iwthemes.com 
// Email: support@iwthemes.com
// Copyright: (C) 2015

$(document).ready(function($) {

	'use strict';
  $(".where_select").each(function(i){
    whereSelectFun(i,1,"");
  });

  $(".where").each(function(i){
    $.post("where_re.asp",{sno:i},function(data){
      $(".where").eq(i).append(data);
      $(".choose_clear").eq(i).bind("click",function(){
        $(".where").eq(i).find("input[type='checkbox']").prop("checked",false);
        $(".input-large").eq(i).val("");
      });
      $(".choose_ok").eq(i).bind("click",function(){
        var larges = "";
        var areas = "";
        $(".where").eq(i).find("input[type='checkbox']:checked").each(function(){
          var labelText = $(this).next("label").text();
          var labelVal = $(this).val();
          if (labelText.indexOf("全區") == -1){
            if (larges != ""){larges+=" | ";}
            larges += labelText;
            areas += "$|$" + labelVal;
          }
        });
        $(".input-large").eq(i).val(larges);
      });
      $(".where").eq(i).find(".selectAll").bind("click",function(){
        var TF = $(this).prop("checked");
        $(this).parent(".tab-pane").find("input[type='checkbox']").prop("checked",TF);
      });
    });
  });
  
  $('#dl-menu').dlmenu();
  $(".where , .close_btn").hide();
  $("#choose_prod").click(function(event) {
    $(".where , .close_btn").show();
  });
  $("#choose_group").click(function(event) {
    $(".where , .close_btn").show();
  });
  $(".close_btn").click(function(event) {
    $(".where , .close_btn").hide();
  });
  $("#choose_sin").click(function(event) {
    $(".where_sin , .close_btn").show();
  });
  $(".close_btn").click(function(event) {
    $(".where_sin , .close_btn").hide();
  });
  
  $("#dl-menu a, .img_block a").click(function(event){
    event.preventDefault();
    var aHref = $(this).attr("href");
    if (aHref != "#"){
      var aHref = aHref.toLowerCase().replace("product_list_new.asp?area=","");
      var apHtml = "<form id='apForm' action='product_list_new.asp' method='get'>";
      apHtml += "<input type='hidden' name='sarea' value='"+aHref+"'>";
      apHtml += "</form>";
      if ($(".area_div").find("form").length == 0){
        $(".area_div").append(apHtml);
      }else{
        $("#apForm").find("input").val(aHref);  
      }
      if ($(this).nextAll("ul").length == 0){
        $("#apForm").submit();
      }
    }
  });
  
  //頁底員工登入
  $("#workerLink").dblclick(function(){
    document.location.href = "staff_login.asp";
  }); 
  //=================================== Loader =====================================//
  // jQuery(window).load(function() {
  //   jQuery(".status").fadeOut();
  //     jQuery(".preloader").delay(1000).fadeOut("slow");
  // })

	
});	

whereSelectFun = function(i,level,area){
  var ws = $(".where_select").eq(i);
  $.post("where_re_select.asp",{sno:i,level:level,sarea:area},function(data){
    if (data != ""){
      if (ws.find("select").length == 0){
        ws.append(data);
      }else{      
        ws.find("select").eq(level-2).nextAll("select").remove();
        ws.find("select").last().after(data);
      }
      ws.find("select").change(function(){
        var level = parseInt($(this).attr("class").replace("level",""))+1;
        var area = $(this).val();
        whereSelectFun(i,level,area);
      });
    }else{
      ws.find("select").eq(level-2).nextAll("select").remove();
    }
  });
}

