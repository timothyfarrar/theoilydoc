component {

	public void function configure( bundle ) {
		// See sticker docs here: http://sticker.readthedocs.org/en/latest/
		bundle.addAsset( id="jq-core-jquery"        , path="/js/lib/jquery-1.10.1.min.js"                           );
		bundle.addAsset( id="jq-core-placeholders"  , path="/js/lib/placeholders.jquery.min.js"                     );
		bundle.addAsset( id="jq-tooltipster"        , path="/js/lib/jquery.tooltipster.min.js"                      );
		bundle.addAsset( id="jq-magnific-popup"     , path="/js/lib/jquery.magnific-popup.min.js"                   );
		bundle.addAsset( id="jq-bxslider"           , path="/js/lib/jquery.bxslider.min.js"                         );
		bundle.addAsset( id="jq-parallax"           , path="/js/lib/parallax.min.js"                                );
		bundle.addAsset( id="js-modernizr"          , path="/js/lib/modernizr-2.6.2.min.js"                         );
		bundle.addAsset( id="js-respond"            , path="/js/lib/respond.js"                                     );

		bundle.addAsset( id="css-core-google-font"  , url="//fonts.googleapis.com/css?family=Roboto:700%2C300%2C300italic%7CNoto+Serif:400%2C700",  type="css"  );
		bundle.addAsset( id="css-core-bootstrap"    , path="/css/lib/bootstrap.min.css"                             );
		bundle.addAsset( id="css-core-icomoon"      , path="/css/lib/icomoon.css"                                   );
		bundle.addAsset( id="css-tooltipster"       , path="/css/lib/tooltipster.css"                               );
		bundle.addAsset( id="css-magnific-popup"    , path="/css/lib/magnific-popup.css"                            );
		bundle.addAsset( id="css-bxslider"          , path="/css/lib/jquery.bxslider.css"                           );
		bundle.addAsset( id="css-ie8"               , path="/css/lib/ie8.css"                                       );

		bundle.addAssets(
			  directory   = "/js/"
			, match       = function( path ){ return ReFindNoCase( "_[0-9a-f]{8}\..*?\.min.js$", arguments.path ); }
			, idGenerator = function( path ) {
				return ListDeleteAt( path, ListLen( path, "/" ), "/" ) & "/";
			}
		);

		bundle.addAssets(
			  directory   = "/css/"
			, match       = function( path ){ return ReFindNoCase( "_[0-9a-f]{8}\..*?\.min.css$", arguments.path ); }
			, idGenerator = function( path ) {
				return ListDeleteAt( path, ListLen( path, "/" ), "/" ) & "/";
			}
		);

		bundle.asset( "jq-core-jquery" ).dependents( "jq-*" );
		bundle.asset( "jq-core-placeholders" ).setIE( "lte IE 9" );
		bundle.asset( "js-respond" ).setIE( "lte IE 8" );
		bundle.asset( "/js/core/" ).after( "jq-*", "js-*" );

		bundle.asset( "css-core-google-font" ).dependents( "css-*" );
		bundle.asset( "css-core-bootstrap" ).before( "css-*" );
		bundle.asset( "/css/core/" ).after( "css-*" ).dependents( "/css/specific/*" );
		bundle.asset( "css-ie8" ).after( "/css/core/" ).setIE( "lte IE 8" );

		// maginific-popup bundle -- just include "/js/specific/maginific-popup/" on specific pages
		bundle.asset( "jq-magnific-popup" ).dependsOn( "css-magnific-popup" );
		bundle.asset( "/js/specific/magnific-popup/" ).dependsOn( "jq-magnific-popup" );

		// tooltipster bundle -- just include "/js/specific/tooltipster/" on specific pages
		bundle.asset( "jq-tooltipster" ).dependsOn( "css-tooltipster" );
		bundle.asset( "/js/specific/tooltipster/" ).dependsOn( "jq-tooltipster" );

		// bxslider bundle -- just include "/js/specific/bxslider/"" on specific pages
		bundle.asset( "jq-bxslider" ).dependsOn( "css-bxslider" );
		bundle.asset( "/js/specific/bxslider/" ).dependsOn( "jq-bxslider" );

	}
}