<cfparam name="args.link" default="" />
<cfparam name="args.type" default="" />
<cfoutput>
	<cfif !IsEmpty( args.link )>
		<li>#renderLink( id=args.link, body="<i class='font-icon font-icon-#args.type#'></i>" )#</li>
	</cfif>
</cfoutput>