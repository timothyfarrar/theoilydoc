<cfscript>
    mainNav 	= renderViewlet( event="core.navigation.mainNavigation", args={ depth=2 });
    site    	= event.getSite();
    logo 		= site.logo ?: "";
    logoSource  = len(logo) ? event.buildLink( assetId=logo , derivative= "headerLogo"  ) : "";
</cfscript>
<cfoutput>
	<header id="masthead" class="site-head">
		<div class="site-head-top">
			<div class="container">

				<cfif len( logoSource )>
					<div class="site-head-logo">
						<a href="#event.buildLink( page="homepage" )#">
							<img src="#logoSource#" alt="">
						</a>
					</div>
				</cfif>

				<nav class="mobile-nav">
					<a class="js-search-trigger"><i class="font-icon font-icon-seh1 for arch"></i></a>
					<a class="js-menu-trigger"><span class="hamburger"></span></a>
				</nav>
			</div>
		</div>

		<div class="site-head-bot">
			<div class="container">
				<nav class="site-head-nav">
					<ul>
						#mainNav#
					</ul>
				</nav>
				<!--- TODO: maybe disable the search form if the extension is not active --->
				<div class="site-head-search">
					##Logout##
					<form action="#event.buildLink( page='search_results' )#" method="get" class="widget-search-form">
						<input type="text" class="form-control search-field" placeholder="Search" name="q">
						<button type="submit" class="btn-search"><i class="font-icon font-icon-search"></i></button>
					</form>
				</div>
			</div>
		</div>
	</header>
</cfoutput>