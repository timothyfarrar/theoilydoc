<cfscript>
    body     = renderView();
    metaTags = renderView( "/general/_pageMetaForHtmlHead"    );
    header   = renderView( "/general/_header"                 );
    footer   = renderView( "/general/_footer"                 );
    adminBar = renderView( "/general/_adminToolbar"           );

    event.include( assetId="jq-core-jquery"                   )
         .include( assetId="jq-core-placeholders"             )
         .include( assetId="/js/core/"                        )
         .include( assetId="css-core-google-font"             )
         .include( assetId="css-core-bootstrap"               )
         .include( assetId="css-core-icomoon"                 )
         .include( assetId="/css/core/"                       )
         .include( assetId="css-ie8"                          )
         .include( assetId="js-modernizr"                     )
         .include( assetId="js-respond"         , group="top" );
</cfscript>

<cfoutput><!DOCTYPE html>
<!--[if lt IE 7]>      <html class="no-js lt-ie10 lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie10 lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie10 lt-ie9"> <![endif]-->
<!--[if IE 9]>         <html class="no-js lt-ie10 gt-ie8"> <![endif]-->
<!--[if gt IE 9]><!--> <html class="no-js gt-ie8"> <!--<![endif]-->
    <head>
        <meta charset="utf-8">
        <!--[if IE]> <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"> <![endif]-->
        
        #metaTags#

        <meta name="viewport" content="width=device-width, initial-scale=1">

        <link rel="shortcut icon" href="/assets/img/favicon/favicon.ico" type="image/x-icon">

        #event.renderIncludes( "css" )#
        #event.renderIncludes( "js", "top" )#
    </head>
    <body class="#( prc.body_class ?: '' )#">
        <!--[if lt IE 7]>
            <p class="chromeframe">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> or <a href="http://www.google.com/chromeframe/?redirect=true">activate Google Chrome Frame</a> to improve your experience.</p>
        <![endif]-->

        #header#

        <div class="main-wrapper">
            #body#
        </div>

        #footer#
        #adminBar#

        #event.renderIncludes( "js" )#

        #renderViewlet( event="googleanalytics.tracking" )#
        #renderViewlet( event="addthis.social"           )#
        #renderViewlet( event="disqus.comments"          )#
    </body>
</html></cfoutput>