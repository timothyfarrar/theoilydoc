
( function( $ ){
	var $form = $( "#search-filter" );

	if ( $form.length ) {
		$form.on( "change", "input[type='checkbox']", function( e ){
			$form.get(0).submit();
		} );
	}
} )( jQuery );
