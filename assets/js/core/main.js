var PIXL8 = function() {

	var menuHandler = function () {

		$( ".js-menu-trigger" ).click( function( e ) {
			e.preventDefault();
			$( ".site-head-search" ).stop().slideUp();
			$( ".site-head-nav" ).stop().slideToggle();
			$( ".hamburger" ).toggleClass( "is-active" );
		} );

		$( ".js-search-trigger" ).click( function( e ) {
			e.preventDefault();
			$( ".site-head-nav" ).stop().slideUp();
			$( ".hamburger" ).removeClass( "is-active" );
			$( ".site-head-search" ).stop().slideToggle();
		} );

	}

	var formHandler = function () {

		// Collapsible alert
		$( ".js-close-alert" ).click(function(e) {
			e.preventDefault();
			$( this ).closest( ".alert" ).slideUp();
		});

		// File upload
		$( "input[type='file']" ).on("change", function(e) {
			var $me = $( this ),
				fileName = $me.val().split('\\').pop();
			if ( $me.siblings( ".file-name" ).is( "input" ) ) {
				$me.siblings( ".file-name" ).val( fileName );
			} else {
				$me.siblings( ".file-name" ).text( fileName );
			}
		});

	}

	var contentHandler = function () {

		$( ".js-scroll-top" ).click( function( e ) {
			e.preventDefault();

			$( "html, body" ).animate( {
				scrollTop: 0
			}, "slow" );

		} );

		$( ".widget.mod-mobile-collapse .widget-title" ).click( function() {

			if ( PIXL8.fn.viewport().width <= PIXL8.mediaWidth.XS ) {
				$( this ).toggleClass( "is-active" );
				$( this ).next( ".widget-content" ).stop().fadeToggle();
			}

		} );

	}

	// Collapsible, add class .accordion to .collapsible to make it accordion.
	var collapsibleHandler = function( $container ) {

		$( ".collapsible", $container ).each(function() {
			var $me = $( this ),
				isAccordion = $me.hasClass( "accordion" );
			$me.find( "> .collapsible-item > .collapsible-item-header > a" ).click( function( e ) {
				e.preventDefault();
				var collapsible_item = $( this ).closest( ".collapsible-item" );
				if ( isAccordion ) {
					collapsible_item.addClass( "is-open" ).find( "> .collapsible-item-content:first" ).slideDown();
					collapsible_item.siblings().removeClass( "is-open" ).find( "> .collapsible-item-content" ).stop().slideUp();
				} else {
					collapsible_item.toggleClass( "is-open" ).find( "> .collapsible-item-content" ).stop().slideToggle();
				}
			});
			if ( isAccordion ) {
				$me.find( "> .collapsible-item.is-open > .collapsible-item-header > a" ).trigger( "click" );
			} else {
				$me.find( "> .collapsible-item.is-open > .collapsible-item-content" ).slideDown();
			}
		});

	}

	// Toggle tabs
	var toggleTabsHandler = function( $container ) {

		var animateTab = function( currentObject ){
			$( currentObject.attr( "href" ) ).fadeIn().addClass( "is-active" ).siblings().hide().removeClass( "is-active" );
			currentObject.parent().addClass( "is-active" ).siblings().removeClass( "is-active" );
			$( currentObject.attr( "href" ) ).find( "> .toggle-tabs-panel-item-header" ).addClass( "is-active" )
				.next( ".toggle-tabs-panel-item-content" ).css( "display", "block" )
				.parent().siblings().find( "> .toggle-tabs-panel-item-header" ).removeClass( "is-active" )
				.next( ".toggle-tabs-panel-item-content" ).hide();
			if ( currentObject.closest( ".toggle-tabs" ).hasClass( "mod-mobile-accordion" ) ) {
				currentObject.closest( ".toggle-tabs" ).find( "> .toggle-tabs-panel > .toggle-tabs-panel-item.is-active > .toggle-tabs-panel-item-header" ).addClass( "is-active" );
			}
		}

		$( ".toggle-tabs-nav a", $container ).click(function(e) {
			var $me = $( this );
			if ( ! $me.closest( ".toggle-tabs" ).hasClass( "mod-tab-links" ) ) {
				e.preventDefault();
				animateTab( $me );
			}
			if ( $me.parent().hasClass( "is-active" ) ) {
				e.preventDefault();
			}
		});

		$( ".toggle-tabs", $container ).each(function() {
			var $me = $( this );
			if ( $me.hasClass( "mod-tab-links" ) ) {
				var isBeforeCurrent = true,
					mobileHeaderBefore = "",
					mobileHeaderAfter = "";
				$me.find( "> .toggle-tabs-panel > .toggle-tabs-panel-item" ).show().addClass( "is-active" ).find( "> .toggle-tabs-panel-item-header" ).addClass( "is-active" );
				$me.find( "> .toggle-tabs-nav li a" ).each( function( i ) {
					if ( $(this).parent().hasClass( "is-active" ) ) {
						isBeforeCurrent = false;
					} else {
						if( isBeforeCurrent ) {
							mobileHeaderBefore += '<div class="toggle-tabs-panel-item"><a href="' + $(this).attr( "href" ) + '" class="toggle-tabs-panel-item-header">' + $(this).text() + '</a></div>';
						} else {
							mobileHeaderAfter += '<div class="toggle-tabs-panel-item"><a href="' + $(this).attr( "href" ) + '" class="toggle-tabs-panel-item-header">' + $(this).text() + '</a></div>';
						}
					}
				});
				$me.find( "> .toggle-tabs-panel" ).prepend( mobileHeaderBefore ).append( mobileHeaderAfter );
			} else {
				animateTab( $me.find( "> .toggle-tabs-nav li.is-active a" ) );
				$me.find( "> .toggle-tabs-panel > .toggle-tabs-panel-item > .toggle-tabs-panel-item-header" ).click( function( e ) {
					e.preventDefault();
					$( this ).addClass( "is-active" ).next( ".toggle-tabs-panel-item-content" ).slideDown()
						.parent().siblings().find( "> .toggle-tabs-panel-item-header.is-active" )
						.removeClass( "is-active" ).next( ".toggle-tabs-panel-item-content" ).slideUp();
				});
			}
		});

		PIXL8.fn.addDebounceResize( function() {
			if ( PIXL8.fn.viewport().width <= PIXL8.mediaWidth.XS ) {
				$( ".mod-mobile-accordion .toggle-tabs-panel .toggle-tabs-panel-item" ).show();
			} else {
				$( ".mod-mobile-accordion .toggle-tabs-panel .toggle-tabs-panel-item" ).not( ".is-active" ).hide();
			}
		});

	}

	// Subnavigation Widget
	var subnavigationWidgetHandler = function() {

		$( ".widget-sub-navigation .has-submenu > a" ).click(function(e) {
			if (! $( this ).parent().hasClass( "is-active" ) ) {
				e.preventDefault();
				$( this ).next(".submenu").slideToggle().parent().toggleClass( "is-active" );
			}
		});
		$( ".widget-sub-navigation .has-submenu.is-active > a" ).next( ".submenu" ).slideDown();

	}

	var ie8Handler = function () {

		$( "input[type='radio'], input[type='checkbox']" ).each(function() {
			if ( $(this).is( ":checked" ) ) {
				$( this ).next( "label" ).toggleClass( "checked" );
			}
		});

		$( "body" ).on( "change", "input[type='checkbox']", function() {
			$(this).next("label").toggleClass("checked");
		});

		$( "body" ).on( "change", "input[type='radio']", function() {
			if ( $( this ).is( ":checked" ) ) {
				$( "input[name='" + $(this).attr( "name" ) + "']" ).next( "label" ).removeClass( "checked" );
				$( this ).next( "label" ).addClass( "checked" );
			}
		});

	}

	return {

		  isIE8: $( "html" ).hasClass( "lt-ie9" )

		, isIE7: $( "html" ).hasClass( "lt-ie8" )

		/* Media queries breakpoints */
		, mediaWidth: {
			  SM: 991
			, XS: 767
		} /* End media queries breakpoints */

		/*
			Public functions, can be accessed from js/specific/ scripts
			PIXL8.fn.addCustomFunction = function() {};
		*/
		, fn: {
			viewport : function() {
				var e = window, a = 'inner';
				if ( ! ( 'innerWidth' in window ) ) {
					a = 'client';
					e = document.documentElement || document.body;
				}
				return { width : e[ a+'Width' ] , height : e[ a+'Height' ] }
			}
			, addDebounceResize: function( funct ) {
				var _afterResized = PIXL8.afterResized;
				PIXL8.afterResized = function() {
					_afterResized();
					funct();
				}
			}
			, attachCollapsible : function( $container ) {
				collapsibleHandler( $container );
			}
			, attachToggleTabs : function( $container ) {
				toggleTabsHandler( $container );
			}
		} /* End general public functions */

		, afterResized: function() {}

		/* Initiate handlers */
		, init: function() {

			var afterResize  = 0;

			menuHandler();
			formHandler();
			contentHandler();
			subnavigationWidgetHandler();
			collapsibleHandler( $("body") );
			toggleTabsHandler( $("body") );

			if ( this.isIE8 ) {
				ie8Handler();
			}

			$(window).on( "resize", function() {
				clearTimeout( afterResize );
				afterResize = setTimeout( PIXL8.afterResized, 250 );
			});

			// Trigger resize onload to make the other plugin works properly eg. masonry
			$(window).on( "load", function() {
				$(window).trigger( "resize" );
			});

			return this;

		} /* End initiate handlers */

	};

}();

( function( $ ) {

	$( document ).ready( function() {

		PIXL8.init();

	} );

} )( jQuery );