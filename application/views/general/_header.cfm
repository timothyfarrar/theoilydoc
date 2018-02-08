<cfscript>
    mainNav 	= renderViewlet( event="core.navigation.mainNavigation", args={ depth=2 });
    site    	= event.getSite();
    logo 		= site.logo ?: "";
    logoSource  = len(logo) ? event.buildLink( assetId=logo , derivative= "headerLogo"  ) : "";
</cfscript>
<!--  HEADER  -->
<header id="haeder" class="header">
    <div class="header-search">
        <div class="container">
            <!-- Single button -->
            <div class="btn-group">
                <button type="button" class="btn dropdown-toggle" data-toggle="dropdown">
                    <img src="/assets/images/flag/United-Kingdom.png" alt=""> English <span class="fa fa-bars"></span>
                </button>
                <ul class="dropdown-menu" role="menu">
                    <li><a href="#"><img src="/assets/images/flag/Germany.png" alt=""> Germany</a></li>
                    <li><a href="#"><img src="/assets/images/flag/France.png" alt=""> French</a></li>
                    <li><a href="#"><img src="/assets/images/flag/Spain.png" alt=""> Spanish</a></li>
                </ul>
            </div>
            <div class="pull-right">
                <div class="input-group">
                    <input id="formControl" placeholder="Search" type="text" class="form-control">
                    <span class="input-group-btn">
                        <button class="btn btn-default fa fa-search" type="button"></button>
                    </span>
                </div><!-- /input-group -->
            </div>
            <div class="pull-right soc-icons">
                <a href="" class="fa fa-twitter"></a>
                <a href="" class="fa fa-facebook"></a>
                <a href="" class="fa fa-linkedin"></a>
                <a href="" class="fa fa-dribbble"></a>
            </div>
        </div>
    </div>            
    <div class="container">     
        <!--  MENU  -->
        <nav class="navbar navbar-default" role="navigation">
            <div class="container-fluid">
                <!-- Brand and toggle get grouped for better mobile display -->
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <!--  LOGO  -->
                    <cfoutput><img src="#logoSource#" alt=""></cfoutput>
                    <!--  //LOGO  -->
                </div>

                <!-- Collect the nav links, forms, and other content for toggling -->
                <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                    <ul class="nav navbar-nav">                                
                        <cfoutput>#mainNav#</cfoutput>
                    </ul>
                </div><!-- /.navbar-collapse -->
            </div><!-- /.container-fluid -->
        </nav>                
        <!--  //MENU  -->
    </div>            
</header>
<!--  //HEADER  -->