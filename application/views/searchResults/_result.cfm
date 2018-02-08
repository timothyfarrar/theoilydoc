<cfscript>
    title           = args.title ?: "";
    teaser          = args.teaser ?: "";
    postAuthor      = args.postAuthor ?: "";
    main_image      = args.main_image ?: "";
    datecreated     = args.datecreated ?: "";
    publishDate     = args.publish_date ?: "";
    pageType        = args.type ?: "";
    displayDate     = pageType eq "blog_post" && !IsEmpty( publishDate ) ? publishDate : datecreated;
    link            = event.buildLink( page=args.id ?: "" );
</cfscript>
<cfoutput>
    <div class="articles-item">
        <div class="articles-item-image">
            <a href="#link#">
                #renderAsset( assetId=main_image, args={ derivative="blogMainImageTeaserSmall" } )#
            </a>
        </div>
        <div class="articles-item-details">
            <h3><a href="#link#">#title#</a></h3>
            <cfif Len( displayDate ) or Len( postAuthor )>
                <ul class="list-details">
                    <cfif Len( displayDate )>
                        <!--- TODO: i18n date format --->
                        <li>#DateFormat( displayDate, 'dd mmm yyyy' )#</li>
                    </cfif>
                    <cfif Len( postAuthor )>
                        <li>#postAuthor#</li>
                    </cfif>
                </ul>
            </cfif>
            <cfif Len( teaser )>
                <p>#teaser#</p>
            </cfif>
        </div>
    </div>
</cfoutput>