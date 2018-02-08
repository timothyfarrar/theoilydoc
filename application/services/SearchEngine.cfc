/**
 * @singleton true
 */
component {

// CONSTRUCTOR
	/**
	 * @elasticSearchEngine.inject     elasticSearchEngine
	 * @elasticSearchApiWrapper.inject elasticSearchApiWrapper
	 * @searchResultsPageDao.inject    presidecms:object:search_results
	 */
	public any function init(
		  required any elasticSearchEngine
		, required any elasticSearchApiWrapper
		, required any searchResultsPageDao
	) {
		_setElasticSearchEngine( arguments.elasticSearchEngine );
		_setElasticSearchApiWrapper( arguments.elasticSearchApiWrapper );
		_setSearchResultsPageDao( arguments.searchResultsPageDao );

		return this;
	}

	public any function search( required string q, array types=[], numeric page=1 ) {
		var args     = Duplicate( arguments );
		var settings = getSettings();

		args.fieldList       = "id,slug,title,teaser,publish_date,datecreated,href,main_image";
		args.sortOrder       = "_score desc";
		args.highlightFields = "title";
		args.defaultOperator = "AND";
		args.pageSize        = Val( settings.results_per_page ?: 5 );

		if ( !Len( Trim( args.q ) ) ) {
			args.q = "*";
		}

		args.fullDsl        = _getElasticSearchApiWrapper().generateSearchDsl( argumentCollection=args );
		args.fullDsl.filter = _getFilterDsl( arguments.types );
		_addAggregationsDsl( args.fullDsl );

		return _getElasticSearchEngine().search( argumentCollection=args );
	}

	public struct function getSettings() {
		var pageRecord = _getSearchResultsPageDao().selectData( maxRows=1 ); // it's a system page, there should only ever be one record here

		for( var p in pageRecord ) {
			return p;
		}

		return {};
	}

	private void function _addAggregationsDsl( required struct dsl ) {
		arguments.dsl.aggs 	= {
			pages     	= { filter = { "or" = [
				  { type = { value="standard_page" } }
				, { type = { value="blog_post" } }
			  ] } }
		};
	}

	private struct function _getFilterDsl( required array types ) {
		var filter = { "or" = [] };

		if ( !arguments.types.len() || arguments.types.findNoCase( "pages" ) ) {
			filter.or.append( { type={ value="standard_page" } } );
			filter.or.append( { type={ value="blog_post" } } );
		}

		return filter;
	}


// GETTERS AND SETTERS
	private any function _getElasticSearchEngine() {
		return _elasticSearchEngine;
	}
	private void function _setElasticSearchEngine( required any elasticSearchEngine ) {
		_elasticSearchEngine = arguments.elasticSearchEngine;
	}

	private any function _getSearchResultsPageDao() {
		return _searchResultsPageDao;
	}
	private void function _setSearchResultsPageDao( required any searchResultsPageDao ) {
		_searchResultsPageDao = arguments.searchResultsPageDao;
	}

	private any function _getElasticSearchApiWrapper() {
		return _elasticSearchApiWrapper;
	}
	private void function _setElasticSearchApiWrapper( required any elasticSearchApiWrapper ) {
		_elasticSearchApiWrapper = arguments.elasticSearchApiWrapper;
	}
}