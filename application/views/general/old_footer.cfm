<cfscript>
    site                    = event.getSite();
    contactSectionTitle     = site.contact_section_title     ?: "Contact us"; // TODO: i18n
    contactAddress          = site.contact_address           ?: "";
    socialLinkSectionTitle  = site.social_link_section_title ?: "Follow us"; // TODO: i18n
    socialLinks             = site.social_links              ?: "";
    copyright               = site.copyright                 ?: "";
    leftContent             = site.left_content              ?: "";
</cfscript>
<cfoutput>
    <footer id="subhead" class="site-footer">
        <div class="site-footer-widgets">
            <div class="container">
                <div class="row">
                    <div class="col-xs-12 col-md-5">
                        <cfif leftContent.len()>
                            #renderContent( renderer="richeditor", data=leftContent )#
                        </cfif>
                    </div>

                    <div class="col-xs-12 col-lg-3 col-lg-offset-4 col-md-4 col-md-offset-3">

                        <div class="widget widget-text">
                            <cfif !IsEmpty( contactAddress )>
                                <h3 class="widget-title">#contactSectionTitle#</h3>

                                <div class="widget-content">
                                    #contactAddress#                                    
                                </div>
                            </cfif>
                        </div>

                        <div class="widget widget-social">
                            <cfif !IsEmpty( socialLinks )>
                                <h3 class="widget-title">#socialLinkSectionTitle#</h3>

                                <div class="widget-content">
                                    <ul>
                                        <cfloop list="#socialLinks#" index="socialLink">
                                            #renderView( presideobject="social_link", view="/general/_social_link", filter={ id=socialLink } )#
                                        </cfloop>
                                    </ul>
                                </div>
                            </cfif>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="site-footer-bot">
            <div class="container">
                <div class="row">
                    <div class="col-xs-12 col-md-5">
                        <div class="site-footer-copyright">
                            <p>#copyright#</p>
                        </div>
                    </div>
                    <div class="col-xs-12 col-lg-3 col-lg-offset-4 col-md-4 col-md-offset-3">
                        <div class="site-footer-preside">
                            <p>Powered by <a href="https://www.presidecms.com/" target="_blank">Preside CMS <img src="/assets/img/icon-preside.png" alt=""></a></p>
                        </div>
                    </div>
                </div>
                <a href="##" class="icon icon-chevron-up back-to-top js-scroll-top"></a>
            </div>
        </div>
    </footer>
</cfoutput>