/**
 * The search_results SYSTEM page type is used for the site search page
 *
 * @displayName           Page type: Search Results
 * @isSystemPageType      true
 * @pagetypeViewlet       searchResults.index
 *
 */
component {
	property name="results_per_page"          type="numeric" dbtype="integer"               default=5;
	property name="label_you_searched_for"    type="string"  dbtype="varchar" maxlength=200 default="You searched for";
	property name="search_name"    			  type="string"  dbtype="varchar" maxlength=200 default="${q}";
	property name="label_result_count"        type="string"  dbtype="varchar" maxlength=200 default="${count} results";
	property name="label_load_more"           type="string"  dbtype="varchar" maxlength=200 default="Show more...";
}