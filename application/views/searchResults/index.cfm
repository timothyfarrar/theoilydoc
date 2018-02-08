<cfparam name="args.label_you_searched_for" field="search_results.label_you_searched_for" />
<cfparam name="args.search_name" field="search_results.search_name" />
<cfparam name="args.label_result_count" field="search_results.label_result_count" />
<cfparam name="args.label_load_more" field="search_results.label_load_more" />
<cfscript>
    event.include( "/css/specific/blog-search/" );
    q = rc.q ?: "";

    results = [];
    args.searchResult.getResults().each( function( r ){ results.append( r ); } );

    youSearchname   = Replace( args.search_name, "${q}", q );
    youSearchname   = Len( Trim( youSearchname ) ) ? youSearchname : "#HtmlEditFormat( q )#";
    youSearchedFor  = Len( Trim( args.label_you_searched_for ) ) ? args.label_you_searched_for : "You searched for"; // TODO: i18n
    resultCount     = NumberFormat( args.searchResult.getTotalResults() );
    loadMore        = Len( Trim( args.label_load_more ) ) ? args.label_load_more : "Show more..."; // TODO: i18n
</cfscript>
<cfoutput>
    <div class="contents" >
        <div class="main-content">
            <div class="container">
                <div class="row">
                    <div class="col-xs-12 col-md-8 col-md-offset-2">

                        <!--- TODO: i18n --->
                        <h1>Search Results: #youSearchedFor# (#youSearchname#)</h1>

                        <div class="results-summary">
                            <!--- TODO: i18n --->
                            <div class="results-summary-count">#resultCount# <cfif resultCount eq 1>Result<cfelse>Results</cfif></div>
                            <!--- TODO: implement sorting of search results --->
                            <div class="results-summary-sort">
                                <!--- TODO: i18n --->
                                View by:
                                <select name="sel-sort" id="sel-sort">
                                    <!--- TODO: i18n --->
                                    <option value="relevance">Relevance</option>
                                    <option value="newest">Newest</option>
                                    <option value="oldest">Oldest</option>
                                </select>
                            </div>
                        </div>

                        <div class="articles mod-listing">
                            <cfloop array="#results#" index="i" item="result">
                                #renderView( view="/searchResults/_result", args=result )#
                            </cfloop>
                        </div>

                        <!--- TODO: implement load more for search results --->
                        <p class="load-more u-aligned-center">
                            <!--- TODO: i18n --->
                            <a href="#event.buildLink( linkTo="searchResults.loadMore", queryString="q=#q#&page=" )#" class="button" id="load-more" data-load-more-target="search-results-listing"><span class="icon icon-load"></span> #loadMore#</a>
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</cfoutput>