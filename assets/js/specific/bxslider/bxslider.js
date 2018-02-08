PIXL8.bxSliderHandler = function() {

	if ( $( ".page-banner-slider .page-banner-item" ).length > 1 ) {

		$( ".page-banner-slider" ).bxSlider( {
			  slideSelector  : "div.page-banner-item"
			, auto           : true
			, controls       : true
			, pager          : true
			, adaptiveHeight : true
			, nextSelector   : ".control-nav-next"
			, prevSelector   : ".control-nav-prev"
			, onSlideAfter   : function (currentSlideNumber, totalSlideQty, currentSlideHtmlObject) {
				$( ".is-active-slide" ).removeClass( "is-active-slide" );
				$( ".page-banner-slider .page-banner-item" ).eq(currentSlideHtmlObject + 1).addClass( "is-active-slide" )

				if ( PIXL8.fn.viewport().width <= PIXL8.mediaWidth.SM ) {
					$( ".page-banner .bx-pager" ).css( "top", $( ".page-banner-item.is-active-slide img" ).height() - 27 );
				}

			}
			, onSliderLoad   : function () {
				$( ".page-banner-slider .page-banner-item" ).eq(1).addClass( "is-active-slide" )
			}
		} );


		PIXL8.fn.addDebounceResize( function() {

			if ( PIXL8.fn.viewport().width <= PIXL8.mediaWidth.SM ) {
				$( ".page-banner .bx-pager" ).css( "top", $( ".page-banner-item.is-active-slide img" ).height() - 27 );
			} else {
				$( ".page-banner .bx-pager" ).css( "top", "" );
			}

		});

	}

};

( function( $ ) {

	$( document ).ready( function() {

		PIXL8.bxSliderHandler();

	} );

} )( jQuery );