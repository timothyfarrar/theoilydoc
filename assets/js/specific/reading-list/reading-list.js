PIXL8.readingListHandler = function() {

	var isFetchingArticle = false

	/*
		https://github.com/gnarf/jquery-ajaxQueue
	 	jQuery on an empty object, we are going to use this as our Queue
	*/
	var ajaxQueue = $({});

	$.ajaxQueue = function( ajaxOpts ) {
		var jqXHR,
			dfd = $.Deferred(),
			promise = dfd.promise();

		// run the actual query
		function doRequest( next ) {
			jqXHR = $.ajax( ajaxOpts );
			jqXHR.done( dfd.resolve )
				.fail( dfd.reject )
				.then( next, next );
		}

		// queue our ajax request
		ajaxQueue.queue( doRequest );

		// add the abort method
		promise.abort = function( statusText ) {

			// proxy abort to the jqXHR if it is active
			if ( jqXHR ) {
				return jqXHR.abort( statusText );
			}

			// if there wasn't already a jqXHR we need to remove from queue
			var queue = ajaxQueue.queue(),
				index = $.inArray( doRequest, queue );

			if ( index > -1 ) {
				queue.splice( index, 1 );
			}

			// and then reject the deferred
			dfd.rejectWith( ajaxOpts.context || ajaxOpts, [ promise, statusText, "" ] );
			return promise;
		};

		return promise;
	};

	/*
		http://upshots.org/javascript/jquery-test-if-element-is-in-viewport-visible-on-screen
		Customize isOnScreen (Detects if element is within the half to the 2/3 height of the screen)
	*/
	$.fn.isOnScreen = function( isCenter ){

		if ( isCenter === undefined ) {
			isCenter = false;
		}

		var win = $(window);

		var viewport = {
			top : win.scrollTop(),
			left : win.scrollLeft()
		};
		viewport.right = viewport.left + win.width();
		viewport.bottom = viewport.top + win.height();
		if ( isCenter ) {
			viewport.bottom -= ( win.height() / 3 );
		}

		var bounds = this.offset();
		bounds.right = bounds.left + this.outerWidth();
		bounds.bottom = bounds.top + this.outerHeight();

		return (!(viewport.right < bounds.left || viewport.left > bounds.right || viewport.bottom < bounds.top || viewport.top + (win.height() / 2)  > bounds.bottom));

	};

	function fetchNextArticle( $nextArticle, isQueue, callback ) {

		if ( isQueue === undefined ) {
			isQueue = false;
		}

		if ( callback === undefined ) {
			callback = function() {};
		}

		if( !isFetchingArticle || isQueue ) {

			isFetchingArticle = true;

			$.ajaxQueue( $nextArticle.find( ".js-load-article" ).attr( "href" ), {
				  method : "post"
			} )
			.done( function( response ) {
				$(".article-container").last().after(response);
				if ( window.addthis !== undefined ) {
					window.addthis.layers.refresh()
				}
				callback();
				$nextArticle.data( "has-loaded", true );
				isFetchingArticle = false;
			} );

		}

	}

	$( ".js-load-article" ).click( function( e ) {
		e.preventDefault();
		var $thisArticle = $( this ).closest( "li" );

		function scrollToArticle() {
			$( "html, body" ).animate( {
				scrollTop : $( "#" + $thisArticle.data( "article" ) ).offset().top - 50
			}, "slow" );
		}

		if ( $( "#" + $thisArticle.data( "article" ) ).length ) {
			scrollToArticle()
		} else {
			var articles = $thisArticle.prevAll().andSelf();

			articles.each( function( i ) {
				if ( ! $( "#" + $( this ).data( "article" ) ).length ) {
					if ( articles.length - 1 == i ) {
						fetchNextArticle( $( this ), true, scrollToArticle );
					} else {
						fetchNextArticle( $( this ), true );
					}
				}
			} );
		}

	} );

	$( window ).scroll( function() {

		if ( PIXL8.fn.viewport().width > PIXL8.mediaWidth.SM ) {

			var scrollTop             = $( this ).scrollTop(),
				$sidebarStickyContent = $( ".sidebar-content-sticky" ),
				$mainContent          = $( ".sidebar.mod-sticky" ).prev(),
				sidebarTop            = $( ".sidebar.mod-sticky" ).offset().top + 50;

			if ( scrollTop >= sidebarTop ) {
				$sidebarStickyContent.addClass( "do-stick" );
			} else {
				$sidebarStickyContent.removeClass( "do-stick" );
			}

			// Check if sidebar is exceeding the scroll on main content
			var sidebarNewTop = ( $mainContent.outerHeight() + $mainContent.offset().top ) - ( scrollTop + $sidebarStickyContent.outerHeight() );
			if ( $mainContent.outerHeight() + $mainContent.offset().top < scrollTop + $sidebarStickyContent.outerHeight() + 50 ) {
				$sidebarStickyContent.css( "top", sidebarNewTop );
			} else {
				$sidebarStickyContent.css( "top", "" );
			}

		}

		$( ".article-container" ).each( function( i ) {
			var $me          = $( this ),
				$listArticle = $( ".widget.mod-reading-list li[data-article='"+$me.attr("id")+"']" );

			if ( $me.isOnScreen( true ) ) {

				var percentRead = ( $(window).scrollTop() - $me.offset().top + ( $(window).height() / 2 ) ) / $me.outerHeight() * 100;

				if ( percentRead < 100 ) {
					$listArticle.prevAll().addClass( "has-read" );
					$listArticle.nextAll().removeClass( "has-read is-reading" );
					$listArticle.removeClass( "has-read" ).addClass( "is-reading" );
					$listArticle.find( ".reading-progress-bar" ).width( percentRead + '%' );

					// Load DisQus plugin on the currently reading article
					/* $me.siblings().find( ".disqus-thread-wrapper" ).empty();
					if ( $me.find( "#disqus_thread" ).length  == 0 ) {
						$me.find( ".disqus-thread-wrapper" ).append( '<div id="disqus_thread"></div>' );
						DISQUS.reset({
							  reload : true
							, config : function () {
								this.page.identifier = "newidentifier";
								this.page.url        = "http://example.com/#!newthread";
							}
						});
					} */

					if ( percentRead > 65 ) {
						if ( $listArticle.next().length ) {
							if ( ! $listArticle.next().data( "has-loaded" ) ) {
								fetchNextArticle( $listArticle.next() );
							}
						}
					}
				}

			} else {

				if ( $( ".article-container" ).length - 1 == i ) {
					if ( $listArticle.prevAll( ".has-read" ).length == $listArticle.prevAll().length ) {
						$listArticle.addClass( "has-read" );
					}
				}

				if ( i == 0 && ! ( $listArticle.siblings(".is-reading").length || $listArticle.siblings(".has-read").length ) ) {
					$( ".widget.mod-reading-list li" ).removeClass( "has-read is-reading" );
				}

			}

		} );

	} ).on( "load", function() {
		$( window ).trigger( "scroll" );
	});

};

( function( $ ) {

	$( document ).ready( function() {

		PIXL8.readingListHandler();

	} );

} )( jQuery );