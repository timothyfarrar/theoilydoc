<cfscript>
	menuItems = args.menuItems ?: [];
	navItemIndex = 0;
</cfscript>
<cfoutput>
	<cfloop array="#menuItems#" index="menuItem">
		<cfif navItemIndex GTE 6><cfbreak></cfif>
		<cfset navItemIndex += 1>
		<cfset menuItemClass = "site-head-nav-dropdown" />
		<cfif menuItem.active>
			<cfset menuItemClass &= " is-active" />
		</cfif>
		<li>
            <a href="#event.buildLink( page=menuItem.id )#">#menuItem.title#</a>
        </li>
	</cfloop>
</cfoutput>