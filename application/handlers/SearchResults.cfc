component {

	property name="searchEngine" inject="SearchEngine";

	public string function index( event, rc, prc, args={} ) {

		var pageId 		= event.getCurrentPageId();

		args.searchResult = searchEngine.search(
			  q     = rc.q ?: ""
			, page  = 1
			, types = ListToArray( rc.types ?: "" )
		);

		event.include( "/js/specific/search/" );

		return renderView (
			  view 			= "/searchResults/index"
			, presideObject = "search_results"
			, id 			= pageId
			, args 			= args 
		);
	}

	public void function loadMore( event, rc, prc ) {
		args.searchResult = searchEngine.search(
			  q     = rc.q ?: ""
			, types = ListToArray( rc.types ?: "" )
			, page  = Val( rc.page ?: 1 )
		);
		var results = "";

		args.searchResult.getResults().each( function( result ) {
		 	results &= renderView( view="/searchResults/_result", args=result );
		});

		event.renderData( data=results, type="HTML" );
	}
}