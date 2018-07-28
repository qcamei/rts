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

	//=================================== Twitter Feed  ===============================//
  $("#twitter").tweet({
      modpath: 'js/twitter/index.php',
      username: "envato", // Change for Your Username
      count: 5,
      loading_text: "Loading tweets..."
  });

  //=================================== Flikr Feed  ========================================//
  $('#flickr').jflickrfeed({
    limit: 8, //Number of images to be displayed
    qstrings: {
      id: '36587311@N08'//Change this to any Flickr Set ID as you prefer in http://idgettr.com/
    },
    itemTemplate: '<li><a href="{{image_b}}" class="fancybox"><img src="{{image_s}}" alt="{{title}}" /></a></li>'
  });

  //=================================== Sticky nav ===================================//

  $("#header").sticky({topSpacing:0});

  //=================================== datepicker ===================================//
  $(".date-input" ).datepicker({
    minDate: 'today+1',
    onSelect:function(data){
      var baDate = $(".date1").datepicker('getDate');
      $(".date2").datepicker('option','minDate',baDate);
    }
  });

  $(".birth-input").datepicker({
    changeYear:true,
    changeMonth:true
  });


  //=================================== Loader =====================================//
  jQuery(window).load(function() {
    jQuery(".status").fadeOut();
    jQuery(".preloader").delay(1000).fadeOut("slow");
  })

	//=================================== Carousel Services  ==============================//	 
	$("#single-carousel, #single-carousel-sidebar").owlCarousel({
		  items : 1,
		  autoPlay: 4000,  
    	navigation : true,
    	autoHeight : true,
    	slideSpeed : 400,
    	singleItem: true,
    	pagination : false
	});

  //=================================== Carousel features  ==================================//
  $("#slide-features").owlCarousel({
      autoPlay: false,
      items : 1,
      navigation : true,
      autoHeight : true,
      slideSpeed : 400,
      singleItem: true,
      pagination : true
  });

  //=================================== Carousel Boxes  ==================================//
   $("#boxes-carousel").owlCarousel({
       autoPlay: 3200,      
       items : 4,
       navigation: true,
       itemsDesktopSmall : [1024,3],
       itemsTablet : [768,2],
       itemsMobile : [500,1],
       pagination: false
   });

  //=================================== Carousel teams  ==================================//
   $("#team-carousel").owlCarousel({
       autoPlay: 3200,      
       items : 3,
       navigation: true,
       itemsDesktopSmall : [1024,3],
       itemsTablet : [768,2],
       itemsMobile : [500,1],
       pagination: false
   });

   $("#team-carousel-02, #carousel-boxes-2").owlCarousel({
       autoPlay: 3200,      
       items : 2,
       navigation: false,
       itemsDesktopSmall : [1024,3],
       itemsTablet : [768,2],
       itemsMobile : [500,1],
       pagination: false
   });

   //=================================== Carousel Sponsor  ==================================//
   $("#sponsors").owlCarousel({
       autoPlay: 3200,      
       items : 5,
       navigation: false,
       itemsDesktop : [1199,4],
       itemsDesktopSmall : [1024,4],
       itemsTablet : [768,3],
       itemsMobile : [500,2],
       pagination: true
   });

   //=================================== Carousel testimonials  ===============================//  
  $("#testimonials").owlCarousel({
      items : 1,
      autoPlay: 3200,  
      navigation : false,
      autoHeight : true,
      slideSpeed : 400,
      singleItem: true,
      pagination : true
  });

	//=================================== Carousel Twitter  ===============================//	 
	$(".tweet_list").owlCarousel({
		  items : 1,
		  autoPlay: 3200,  
    	navigation : false,
    	autoHeight : true,
    	slideSpeed : 400,
    	singleItem: true,
    	pagination : true
	});

	//=================================== Subtmit Form  ===================================//
	$('#login').submit(function(event) { 
    $('.result').hide();  
    var lgButton = $(this).find("button[type='submit']");
    lgButton.attr("disabled",true);
    event.preventDefault();  
    var url = $(this).attr('action');  
    var datos = $(this).serialize();  
    $.post(url, datos, function(resultado) {  
      if (resultado.indexOf(".asp") == -1){
        lgButton.attr("disabled",false);
        $('.result').html(resultado).fadeIn();         
      }else{
        document.location.href = resultado;
      }
		});  
 	});

  $('#form-contact').submit(function(event) {  
       event.preventDefault();  
       var url = $(this).attr('action');  
       var datos = $(this).serialize();  
        $.get(url, datos, function(resultado) {  
        $('#result').html(resultado);  
    });  
  });

  //=================================== Form Newslleter  =================================//
  $('#newsletterForm').submit(function(event) {  
       event.preventDefault();  
       var url = $(this).attr('action');  
       var datos = $(this).serialize();  
        $.get(url, datos, function(resultado) {  
        $('#result-newsletter').html(resultado);  
    });  
  });  

  //=================================== Ligbox  ===========================================//	
  $(".fancybox").fancybox({
      openEffect  : 'elastic',
      closeEffect : 'elastic',

      helpers : {
        title : {
          type : 'inside'
        }
      }
  });

	//=============================  tooltip demo ===========================================//
  $('.tooltip-hover').tooltip({
      selector: "[data-toggle=tooltip]",
      container: "body"
   });

  // slider-range
  $("#slider-range").slider({});

	//=================================== Totop  ============================================//
  $().UItoTop({
		scrollSpeed:500,
		easingType:'linear'
	});	


    $(document).ready(function() {
    function slideLine(box, stf, delay, speed, h) {
      //取得id
      var slideBox = document.getElementById(box);
      //預設值 delay:幾毫秒滾動一次(1000毫秒=1秒)
      //       speed:數字越小越快，h:高度
      var delay = delay || 1000,
        speed = speed || 20,
        h = h || 80;
      var tid = null,
        pause = false;
      //setInterval跟setTimeout的用法可以咕狗研究一下~
      var s = function() {
          tid = setInterval(slide, speed);
        }
        //主要動作的地方
      var slide = function() {
          //當滑鼠移到上面的時候就會暫停
          if (pause) return;
          //滾動條往下滾動 數字越大會越快但是看起來越不連貫，所以這邊用1
          slideBox.scrollTop += 1;
          //滾動到一個高度(h)的時候就停止
          if (slideBox.scrollTop % h == 0) {
            //跟setInterval搭配使用的
            clearInterval(tid);
            //將剛剛滾動上去的前一項加回到整列的最後一項
            slideBox.appendChild(slideBox.getElementsByTagName(stf)[0]);
            //再重設滾動條到最上面
            slideBox.scrollTop = 0;
            //延遲多久再執行一次
            setTimeout(s, delay);
          }
        }
        //滑鼠移上去會暫停 移走會繼續動
      slideBox.onmouseover = function() {
        pause = true;
      }
      slideBox.onmouseout = function() {
          pause = false;
        }
        //起始的地方，沒有這個就不會動囉
      setTimeout(s, delay);
    }
    //網頁load完會執行一次
    //五個屬性各別是：外面div的id名稱、包在裡面的標籤類型
    //延遲毫秒數、速度、高度
    slideLine('logo_bar', 'div', 2000, 25, 80);
  });

  //=================================== Portfolio Filters  ==============================//
  $(window).load(function(){
      var $container = $('.portfolioContainer');
      $container.isotope({
      filter: '*',
          animationOptions: {
          duration: 750,
          easing: 'linear',
          queue: false
  	}
  });
  $('.portfolioFilter a').click(function(){
      $('.portfolioFilter .current').removeClass('current');
      $(this).addClass('current');
       var selector = $(this).attr('data-filter');
       $container.isotope({
        filter: selector,
              animationOptions: {
              duration: 750,
              easing: 'linear',
              queue: false
            }
        });
       return false;
      }); 
   });
});	

