(function($) {
    "use strict";
    var revapi;
    var shift = $(window).width() > 640 ? 350 : 150;

    /*----------  MOBILE DETECT  ----------*/
    var isMobile = {
	    Android: function() {
	        return navigator.userAgent.match(/Android/i);
	    },
	    BlackBerry: function() {
	        return navigator.userAgent.match(/BlackBerry/i);
	    },
	    iOS: function() {
	        return navigator.userAgent.match(/iPhone|iPad|iPod/i);
	    },
	    Opera: function() {
	        return navigator.userAgent.match(/Opera Mini/i);
	    },
	    Windows: function() {
	        return navigator.userAgent.match(/IEMobile/i);
	    },
	    any: function() {
	        return (isMobile.Android() || isMobile.BlackBerry() || isMobile.iOS() || isMobile.Opera() || isMobile.Windows());
	    }
	};
	/*----------  //MOBILE DETECT  ----------*/

	/*----------  PRELOADER  ----------*/
	setTimeout(function(){
		$('#preloader').animate({'opacity' : '0'},300,function(){
			$('#preloader').hide();
			if(0 < $(window).scrollTop()){				
				setTimeout(function(){
					scrolling();
				}, 500)
			}	
		});

		$('.page-wrapper').animate({'opacity' : '1'},500);
	},3000)
	/*----------  //PRELOADER  ----------*/
	
	/*----------  FUNCTION FOR SWITCH THEME COLOR  ----------*/
	if($('.picker-btn').length){
		$('.picker-btn').on('click', function(){
			if(parseInt($('.color-picker').css('right')) == 0){
				$('.color-picker').stop().animate({'right': -160}, 500);
			}else{
				$('.color-picker').stop().animate({'right': 0}, 500);
			}
		});
		$('.color-picker .pwrapper div.color').on('click', function(){
			$('body').removeClass('lightgreen blue green lightred red yellow turquoise pink purple');
			$('body').addClass($(this).attr('data-color'));
		});
	}
	/*----------  //FUNCTION FOR SWITCH THEME COLOR  ----------*/

	/*----------  NAVIGATION ON PAGE  ----------*/
	$.scrollIt();
	/*----------  //NAVIGATION ON PAGE  ----------*/

	$('.images-bg').each(function(){
		$(this).css({
			'background-image': 'url(' +$('>img', this).hide().attr('src') +')'
		});
	});

	function parallaxInit() {
		if (!isMobile.any())
		{
			$('.parallax').parallax("50%", 0.2);
		}
	}	
	parallaxInit();	

	/*----------  WORKS SLIDER  ----------*/
	setTimeout(function(){
		var $container = $('#worksContent');

	    $container.isotope({
	      itemSelector : '.slide',
	      getSortData : {
	        category : function( $elem ) {
	          return $elem.attr('data-category');
	        }
	      }
	    });

	    var $optionSets = $('.works-category'),
	      $optionLinks = $optionSets.find('a');

		$optionLinks.click(function(){
			var $this = $(this);
			// don't proceed if already selected
			if ( $this.hasClass('active') ) {
				return false;
			}
			var $optionSet = $this.parents('.works-category');
			$optionSet.find('.active').removeClass('active');
			$this.addClass('active');

			// make option object dynamically, i.e. { filter: '.my-filter-class' }
			var options = {},
			key = $optionSet.attr('data-option-key'),
			value = $this.attr('data-option-value');
			// parse 'false' as false boolean
			value = value === 'false' ? false : value;
			options[ key ] = value;
			$container.isotope( options );

			return false;
		});
	}, 1000);
	/*----------  //WORKS SLIDER  ----------*/

	setTimeout(function(){
		/*----------  CLIENTS SLIDER  ----------*/
		$('.clients-feedback .flexslider').flexslider({slideshowSpeed: 6000});
		/*----------  //CLIENTS SLIDER  ----------*/

		/*----------  TWITTER SLIDER  ----------*/
		$('.twitter .flexslider').flexslider();
		/*----------  //TWITTER SLIDER  ----------*/

		/*----------  TEAM SLIDER  ----------*/
		$('.team .flexslider').flexslider();
		/*----------  //TEAM SLIDER  ----------*/

		/*----------  SINGLE WORK SLIDER  ----------*/
		$('.single-work .flexslider').flexslider();
		/*----------  //SINGLE WORK SLIDER  ----------*/

		/*----------  BLOG SLIDER  ----------*/
		$('.blog-content .flexslider').flexslider();
		/*----------  //BLOG SLIDER  ----------*/
	}, 2000);
	
	if($('.work-block .zoom').length){
		$('.work-block .zoom').magnificPopup({
			type: 'image',
			gallery: {
				enabled: true
			},
			zoom: {
				enabled: true,
				duration: 300
			}
		});
	}	

	$('#viewMap').on('click', function(){
		$('.contact .title, .contact .contact-block').addClass('bounceOutLeft animated');
		$('.contact .title, .contact .contact-block').one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function(){
			$('.contact .title, .contact .contact-block').removeClass('bounceOutLeft animated').css('opacity',0);

			$('#map').css('z-index', 1);
			$('#map .gm-style').css('opacity', 1);

			$('#hideMap').addClass('bounceInRight animated').css('opacity',1);
			$('#hideMap').one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function(){
				$('#hideMap').removeClass('bounceInRight animated');
			});	

		});	


		return false;
	});

	$('#hideMap').on('click', function(){
		$('#hideMap').addClass('bounceOutRight animated');
		$('#hideMap').one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function(){
			$('#hideMap').removeClass('bounceOutRight animated').css('opacity',0);

			$('.contact .title, .contact .contact-block').addClass('bounceInLeft animated').css('opacity',1);
			$('.contact .title, .contact .contact-block').one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function(){
				$('.contact .title, .contact .contact-block').removeClass('bounceInLeft animated');			

			});	
		});	

		$('#map').css('z-index', -1);
		$('#map .gm-style').css('opacity', 0.2);
		
		return false;
	});

	/*----------  VIDEO  ----------*/
	var min_w = 300; // minimum video width allowed
    var vid_w_orig;  // original video dimensions
    var vid_h_orig;

	setTimeout(function(){	        
        vid_w_orig = parseInt($('#video-container video').attr('width'));
        vid_h_orig = parseInt($('#video-container video').attr('height'));
        
        $(window).resize(function () { resizeToCover(); });
        $(window).trigger('resize');
    }, 2000);

    function resizeToCover() {

	    // set the video viewport to the window size
	    $('#video-container').width($(window).width());
	    $('#video-container').height($(window).height());

	    // use largest scale factor of horizontal/vertical
	    var scale_h = $(window).width() / vid_w_orig;
	    var scale_v = $(window).height() / vid_h_orig;
	    var scale = scale_h > scale_v ? scale_h : scale_v;

	    // don't allow scaled width < minimum video width
	    if (scale * vid_w_orig < min_w) {scale = min_w / vid_w_orig;};

	    // now scale the video
	    $('#video-container video').width(scale * vid_w_orig);
	    $('#video-container video').height(scale * vid_h_orig);
	    // and center it by scrolling the video viewport
	    $('#video-container').scrollLeft(($('#video-container video').width() - $(window).width()) / 2);
	    $('#video-container').scrollTop(($('#video-container video').height() - $(window).height()) / 2);

    }

    /*----------  //VIDEO  ----------*/

	function scrolling(){
		var scroll = $(window).scrollTop() + $(window).height();

		/*----------  HEADER  ----------*/
		if($(window).scrollTop() > 40){
			$('#haeder').addClass('fixed');
		}else{
			$('#haeder').removeClass('fixed');
		}
		/*----------  //HEADER  ----------*/

		/*----------  ANIMATION FOR ABOUT  ----------*/
		if($('#about').length && parseInt($('#about').offset().top)+shift < scroll){			
			if($('#about').hasClass('animate')){
				$('#about').removeClass('animate');
				var time = -200;
				$('#about .about-block').each(function(){
					time += 200;
					var thiz = this;
					setTimeout(function(){
						$(thiz).addClass('fadeInUp animated').css('opacity',1);
						$(thiz).one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function(){
							$(thiz).removeClass('fadeInUp animated');
						});						
					}, time)
				})
			}
		}
		/*----------  //ANIMATION FOR ABOUT  ----------*/

		/*----------  ANIMATION FOR SERVICE  ----------*/
		if($('#service').length && parseInt($('#service').offset().top)+shift < scroll){			
			if($('#service').hasClass('animate')){
				$('#service').removeClass('animate');
				var time = -200;
				$('#service .services-block').each(function(){
					time += 200;
					var thiz = this;
					setTimeout(function(){
						$(thiz).addClass('fadeInLeft animated').css('opacity',1);
						$(thiz).one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function(){
							$(thiz).removeClass('fadeInLeft animated');
						});						
					}, time)
				})
			}
		}
		/*----------  //ANIMATION FOR SERVICE  ----------*/

		/*----------  ANIMATION FOR FACTS  ----------*/
		if($('#facts').length && parseInt($('#facts').offset().top)+shift < scroll){
			if($('#facts').hasClass('animate')){
				$('#facts').removeClass('animate');

				$('#facts .fact-block').addClass('fadeInUp animated').css('opacity',1);
				$('#facts .fact-block').one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function(){
					$('#facts .fact-block').removeClass('fadeInUp animated');
				});	

				$('#facts .amount').each(function(){
					$(this).countTo({
	        	        from: 0,
	        	        to: $(this).attr('data-amount'),
	        	        speed: 3000
	                });
				})
				
			}
		}
		/*----------  //ANIMATION FOR FACTS  ----------*/

		/*----------  ANIMATION FOR TEAM  ----------*/
		if($('#team').length && parseInt($('#team').offset().top)+shift < scroll){			
			if($('#team').hasClass('animate')){
				$('#team').removeClass('animate');
				$('#team .team-block').addClass('bounceInLeft animated').css('opacity',1);
				$('#team .team-block').one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function(){
					$('#team .team-block').removeClass('bounceInLeft animated');
				});	
			}
		}
		/*----------  //ANIMATION FOR TEAM  ----------*/
	}




	/*----------  FUNCTION FOR WINDOW SCROLL  ----------*/
	$(window).on('scroll', function(){
		scrolling();
	});
	/*----------  //FUNCTION FOR WINDOW SCROLL  ----------*/

	/*----------  MAP  ----------*/
    if($('#map').length){ 		
		var element = document.getElementById("map");
		var myLatLng = new google.maps.LatLng(48.1391265, 11.580186300000037);
 
        /*
        Build list of map types.
        You can also use var mapTypeIds = ["roadmap", "satellite", "hybrid", "terrain", "OSM"]
        but static lists sucks when google updates the default list of map types.
        */
        var mapTypeIds = [];
        for(var type in google.maps.MapTypeId) {
            mapTypeIds.push(google.maps.MapTypeId[type]);
        }
        mapTypeIds.push("OSM");

        var map = new google.maps.Map(element, {
            center: myLatLng,
            zoom: 15,
            mapTypeControl: false,
            streetViewControl: false,
            mapTypeId: "satellite",
            mapTypeControlOptions: {
                mapTypeIds: mapTypeIds
            }
        });

        map.mapTypes.set("OSM", new google.maps.ImageMapType({
            getTileUrl: function(coord, zoom) {
                return "http://tile.openstreetmap.org/" + zoom + "/" + coord.x + "/" + coord.y + ".png";
            },
            tileSize: new google.maps.Size(256, 256),
            name: "OpenStreetMap",
            maxZoom: 18
        }));

        var marker = new google.maps.Marker({
			position: myLatLng,
			map: map,
			icon: '/assets/images/map/location-icon.png',
			title: '',
		});

        $('#showMap').on('click', function(){
        	if($('#map').hasClass('active')){
        		$('#map, #showMap').removeClass('active');
        	}else{
            	$('#map, #showMap').addClass('active');
            	setTimeout(function(){
            		$('html,body')
						.stop()
						.scrollTo($('#map').offset().top, 300);  
				}, 300)      		
        	}
        	return false;
        });

    }    
    /*----------  //MAP  ----------*/

    /*----------  LOGO SLIDER  ----------*/
    setTimeout(function(){
		$('#logoSlider').carouFredSel({
			mousewheel: true,
			swipe: {
				onMouse: true,
				onTouch: true
			},
			items: 4,
			responsive: true,
			scroll: 1
		});
    }, 2000);    
	/*----------  //LOGO SLIDER  ----------*/

	if($(window).width() <= 480){
		$('.home-button-1').attr('data-voffset', 150);
	}

    revapi = jQuery('.tp-banner').revolution(
	{
		delay:9000,
		startwidth:1170,
		startheight:610,
		hideThumbs:10,
		fullWidth:"off",
		fullScreen:"on",
		fullScreenOffsetContainer: "",
		navigationStyle:"preview4" 

	});

	/*----------  SUBMIT FUNCTION  ----------*/
    $('.contact form .button').on('click', function(){
		var thiz = this;
		var flag = true;

		if(/\D/.test($('.contact input[name="phone"]').val()) || !$('.contact input[name="phone"]').val().length){
            $('.contact input[name="phone"]').val('').attr('placeholder','please enter phone number').addClass('error');
            flag = false;
        }
        if(!/^[-\w.]+@([A-z0-9][-A-z0-9]+\.)+[A-z]{2,4}$/.test($('.contact input[name="email"]').val())){
            $('.contact input[name="email"]').val('').attr('placeholder','please enter correct e-mail').addClass('error');;
            flag = false;
        }


        if(flag){
            $(thiz).parents('form').submit(); 
            $(thiz).addClass('success').html('success'); 
            $('.contact input').removeClass('error');      	
        }else{
        	$(thiz).addClass('error').html('error'); 
        }

        setTimeout(function(){
        	$(thiz).removeClass('error success').html('send message'); 
        }, 3000)
        
        return false;
    });

	$("#ajax-contact-form").submit(function() {
		var str = $(this).serialize();		
		var href = location.href.replace(/index\.html/g,'');
		$.ajax({
			type: "POST",
			url: href + "contact_form/contact_process.php",
			data: str,
			success: function(msg) {
				// Message Sent - Show the 'Thank You' message and hide the form
				if(msg == 'OK') {
					$(this).addClass('success').find('span:eq(1)').html('success'); 
				} else {
					$(this).addClass('error').find('span:eq(1)').html('error'); 
				}
			}
		});
		return false;
	});
	/*----------  //SUBMIT FUNCTION  ----------*/

})(jQuery); 