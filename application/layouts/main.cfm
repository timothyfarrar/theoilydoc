<cfscript>
body     = renderView();
metaTags = renderView( "/general/_pageMetaForHtmlHead"    );
header   = renderView( "/general/_header"                 );
footer   = renderView( "/general/_footer"                 );
adminBar = renderView( "/general/_adminToolbar"           );
</cfscript>

<!doctype html>
<html lang="en">
<head>
<meta content="width=device-width, initial-scale=1.0" name="viewport">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>COLORIS - Premium Responsive Portfolio Template</title>
<!--  FAVICON  -->
<link rel="shortcut icon" href="/assets/images/favicon.ico" />
<!--  //FAVICON  -->

<!--  JQUERY CSS  -->
<link rel="stylesheet" type="text/css" href="/assets/style/jquery/magnific-popup.css" />
<!--  //JQUERY STYLE  -->

<!--  ANIMATE CSS  -->
<link rel="stylesheet" type="text/css" href="/assets/style/animate/animate.css" />
<!--  //ANIMATE CSS  -->

<!--  FONTS  -->
<link href='http://fonts.googleapis.com/css?family=Lato:400,300,900,700' rel='stylesheet' type='text/css'>
<link rel="stylesheet" type="text/css" href="/assets/style/font-awesome.min.css" />
<!--  //FONTS  -->

<!-- SLIDER REVOLUTION CSS SETTINGS -->
<link rel="stylesheet" type="text/css" href="/assets/style/rs-plugin/settings.css" media="screen" />
<!-- //SLIDER REVOLUTION CSS SETTINGS -->

<!--  CSS  -->
<link rel="stylesheet" type="text/css" href="/assets/style/bootstrap.min.css" />
<link rel="stylesheet" type="text/css" href="/assets/style/style.css" />
<!--  //CSS  -->

</head>
    
<body class="home-page">
    <!--  PRELOADER  -->
    <div id="preloader">
        <img alt="" src="/assets/images/preloader/preloader.gif">
        Loader
    </div>   
    <!--  //PRELOADER  -->

    <div class="page-wrapper">

        <!--  HEADER  -->
        <cfoutput>#header#</cfoutput>
        <!--  //HEADER  -->

        <section class="single-work">
            <cfoutput>#body#</cfoutput>
        </section>
        
        <!--  WORKS  -->
        <section class="works">
            <div class="container">
                <div class="title">
                    <div class="name">other works</div>
                    <div class="dots">
                        <em></em>
                        <em></em>
                        <em></em>
                        <em></em>
                    </div>
                </div>
                <div id="worksContent" class="works-content row">
                    <div class="work-block slide photography" data-category="photography">
                        <div class="image-wrapper">
                            <a class="zoom" href="/assets/images/works/1.jpg">
                                <img src="/assets/images/works/1.jpg" alt="">
                            </a>
                            <div class="button-wrapper">
                                <a class="fa fa-share" href="single-work.html"></a>
                            </div>
                        </div>
                        <a href="single-work.html" class="name">
                            Creative Glamour Girl
                            <em class="fa fa-heart"></em>
                        </a>
                        <div class="category">Photography</div>
                    </div>
                    <div class="work-block slide illustration" data-category="illustration">
                        <div class="image-wrapper">
                            <a class="zoom" href="/assets/images/works/2.jpg">
                                <img src="/assets/images/works/2.jpg" alt="">
                            </a>
                            <div class="button-wrapper">
                                <a class="fa fa-share" href="single-work.html"></a>
                            </div>
                        </div>
                        <a href="single-work.html" class="name">
                            Pictoplasma Character 
                            <em class="fa fa-heart"></em>
                        </a>
                        <div class="category">Illustration</div>
                    </div>
                    <div class="work-block slide branding" data-category="branding">
                        <div class="image-wrapper">
                            <a class="zoom" href="/assets/images/works/3.jpg">
                                <img src="/assets/images/works/3.jpg" alt="">
                            </a>
                            <div class="button-wrapper">
                                <a class="fa fa-share" href="single-work.html"></a>
                            </div>
                        </div>
                        <a href="single-work.html" class="name">
                            Galo Kitchen
                            <em class="fa fa-heart"></em>
                        </a>
                        <div class="category">Branding</div>
                    </div>
                    <div class="work-block slide illustration" data-category="illustration">
                        <div class="image-wrapper">
                            <a class="zoom" href="/assets/images/works/4.jpg">
                                <img src="/assets/images/works/4.jpg" alt="">
                            </a>
                            <div class="button-wrapper">
                                <a class="fa fa-share" href="single-work.html"></a>
                            </div>
                        </div>
                        <a href="single-work.html" class="name">
                            Playing cards
                            <em class="fa fa-heart"></em>
                        </a>
                        <div class="category">Illustration</div>
                    </div>                    
                </div>
            </div>
        </section>
        <!--  //WORKS  -->

        <section data-scroll-index="7" class="contact">
            <div class="container">
                <div class="title white">
                    <div class="name">Contact us</div>
                    <div class="dots">
                        <em></em>
                        <em></em>
                        <em></em>
                        <em></em>
                    </div>
                    <p class="text">Dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur.</p>
                </div>
                <div class="row contact-block">
                    <div class="col-lg-6 col-md-6 col-sm-12">
                        <div class="phone">1 234 56 78</div>
                        <div class="address">Street Name 1234, New York 1234</div>
                        <a class="mail" href="">welcome@coloris.com</a>
                        <a id="viewMap" href="" class="button big">view map</a>
                    </div>
                    <form class="col-lg-6 col-md-6 col-sm-12" id="ajax-contact-form" action="javascript:void(0);">
                        <div class="clearfix">
                            <div class="col-lg-6 col-md-6 col-sm-12">
                                <input placeholder="Name" name="name" type="text">
                                <input placeholder="E-mail" name="email" type="text">
                                <input placeholder="Phone" name="phone" type="text">
                            </div>
                            <div class="col-lg-6 col-md-6 col-sm-12">
                                <textarea placeholder="Message" name="message"></textarea>
                            </div>
                        </div>
                        <a href="" class="button big">Send message</a>
                    </form>
                </div>
                <a id="hideMap" href="" class="button big">Back</a>
            </div>
            <div id="map"></div>
        </section>
        <!--  //CONTACT  -->

        <!--  SOC BLOCK  -->
        <section class="soc-block">
            <div class="container">
                <div data-scroll-nav="1" class="scroll-top fa fa-angle-up"></div>
                <div class="title">
                    <div class="name">DON'T MISS A THING</div>
                    <div class="dots">
                        <em></em>
                        <em></em>
                        <em></em>
                        <em></em>
                    </div>
                    <p class="text">Join our social networks</p>
                </div>
                <div class="row">
                    <div class="col-lg-2 col-md-2 col-sm-2">
                        <a href="" class="fa fa-twitter"></a>
                    </div>
                    <div class="col-lg-2 col-md-2 col-sm-2">
                        <a href="" class="fa fa-facebook"></a>
                    </div>
                    <div class="col-lg-2 col-md-2 col-sm-2">
                        <a href="" class="fa fa-linkedin"></a>
                    </div>
                    <div class="col-lg-2 col-md-2 col-sm-2">
                        <a href="" class="fa fa-pinterest"></a>
                    </div>
                    <div class="col-lg-2 col-md-2 col-sm-2">
                        <a href="" class="fa fa-dribbble"></a>
                    </div>
                    <div class="col-lg-2 col-md-2 col-sm-2">
                        <a href="" class="fa fa-flickr"></a>
                    </div>
                </div>
                <p>© Copyright 2014 by Evatheme. All Rights Reserved.</p>
            </div>
        </section>
        <!--  //SOC BLOCK  -->

    </div>    

<!--  JQUERY SCRIPT  --> 
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAaXCxqnCwD2cQ4RE_WuFfW0ECKkYBelhU&amp;sensor=true"></script>
<script type="text/javascript" src="/assets/js/jquery/jquery-1.11.0.min.js"></script>
<script type="text/javascript" src="/assets/js/jquery/jquery.parallax-1.1.3.js"></script>
<script type="text/javascript" src="/assets/js/jquery/jquery.countTo.js"></script>
<script type="text/javascript" src="/assets/js/jquery/jquery.transit.min.js"></script>
<script type="text/javascript" src="/assets/js/jquery/jquery.isotope.min.js"></script>
<script type="text/javascript" src="/assets/js/jquery/jquery.flexslider-min.js"></script>
<script type="text/javascript" src="/assets/js/jquery/scrollIt.min.js"></script>
<script type="text/javascript" src="/assets/js/jquery/jquery.magnific-popup.min.js"></script>
<script type="text/javascript" src="/assets/js/jquery/jquery.carouFredSel-6.2.1-packed.js"></script>
<script type="text/javascript" src="/assets/js/jquery/jquery.mousewheel.min.js"></script>
<script type="text/javascript" src="/assets/js/jquery/jquery.touchSwipe.min.js"></script>
<!--  //JQUERY SCRIPT  --> 

<!-- SLIDER REVOLUTION SCRIPTS  -->
<script type="text/javascript" src="/assets/js/rs-plugin/jquery.themepunch.tools.min.js"></script>
<script type="text/javascript" src="/assets/js/rs-plugin/jquery.themepunch.revolution.min.js"></script>
<!-- //SLIDER REVOLUTION SCRIPTS  -->

<!--  BOOTSTRAP SCRIPT  --> 
<script type="text/javascript" src="/assets/js/bootstrap/bootstrap.min.js"></script>
<!--  //BOOTSTRAP SCRIPT  --> 

<!--  SITE SCRIPT  --> 
<script type="text/javascript" src="/assets/js/custom.script.js"></script>
<!--  //SITE SCRIPT  --> 
</body>
</html>
