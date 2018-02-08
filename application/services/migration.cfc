<cfcomponent>
<!---

Preside Structure:

Categories are going to be created as blog rolls

	subcategories - just tags
		add tags to pobj_blog_tag

	Bind to blog post via pobj_blog_blog_tag

Menu items are blog rolls or pages

--->

	<cffunction name="startMigrate">

		<cfquery name="siteID" datasource="preside">
		SELECT H.ID, site,created_by, (SELECT MAX(p._hierarchy_id) FROM psys_page p )as hierarchy_ID FROM psys_page H WHERE H.page_type = 'homepage'
		</cfquery>
		<cfset sitePageID = siteID.id>
		<cfset site = siteID.site>
		<cfset adminUserID = siteID.created_By>
		<cfset hierarchy_ID = siteID.hierarchy_ID>
		<cfquery datasource="preside" name="categories">
		SELECT *
		FROM `wp_theoilydoc`.`wp_terms` t
		LEFT JOIN `wp_theoilydoc`.`wp_term_taxonomy` tt on tt.term_id = t.term_id
		WHERE tt.taxonomy = 'category'
		and tt.parent = 0
		</cfquery>
		<cfquery datasource="preside" name="presideCategories">
		SELECT slug
		FROM psys_page
		WHERE page_type = 'blog'
		</cfquery>
		<cfset presideCategories = valueList(presideCategories.slug)>
		<cfloop query="categories">
			<cfif !listFind(presideCategories, slug)>
				<cfset hierarchy_id +=1>
				<cfquery datasource="preside">
				INSERT INTO psys_page (
					id,
					title,
					page_type,
					slug,
					parent_page,
					datecreated,
					datemodified,
					active,
					internal_search_access,
					search_engine_access,
					access_restriction,
					iframe_restriction,
					exclude_from_navigation,
					sort_order,
					created_by,
					updated_by,
					_hierarchy_id,
					_hierarchy_sort_order,
					_hierarchy_lineage,
					_hierarchy_child_selector,
					_hierarchy_depth,
					_hierarchy_slug,
					site,
					exclude_from_sitemap,
					trashed,
					full_login_required,
					grantaccess_to_all_logged_in_users,
					exclude_from_navigation_when_restricted,
					exclude_from_sub_navigation,
					exclude_children_from_navigation,
					unique_page_views,
					page_views,
					_version_has_drafts,
					_version_is_draft
				)
				VALUES(
					uuid_short(),
					'#name#',
					'blog', 
					'#slug#',
					'#sitePageID#',
					current_date(),
					current_date(),
					1,
					'inherit',
					'inherit',
					'inherit',
					'inherit',
					1,
					0,
					'#adminUserID#',
					'#adminUserID#',
					'#hierarchy_ID#',
					'/000001/#right('00000#hierarchy_id#', 6)#',
					'/1/',
					'/1/#hierarchy_id#/',
					1,
					'/#slug#/',
					'#site#',
					0,
					0,
					0,
					0,
					0,
					0,
					0,
					0,
					0,
					0,
					0
				)
				</cfquery>
			</cfif>
		</cfloop>
		<cfquery name="categoryBlog" datasource="preside">
		INSERT INTO pobj_blog (id, page, sidebar_content, datecreated, datemodified, initial_max_rows,_version_is_draft,_version_has_drafts)
		SELECT uuid_short(), p.id, p.slug, current_date(), current_date(), 5, 0, 0
		FROM psys_page p
		WHERE p.id NOT IN (SELECT b.page FROM pobj_blog b);
		
		</cfquery>
		<cfquery name="standardPage" datasource="preside">
		INSERT INTO psys_standard_page (id, page, dateCreated, dateModified, _version_is_draft, _version_has_drafts)
		SELECT uuid_short(), p.id, current_date(), current_date(), 0, 0
		FROM psys_page p
		WHERE p.id NOT IN (SELECT b.page FROM psys_standard_page b)
		</cfquery>
		<cfquery datasource="preside" name="subcategories">
		SELECT *, (SELECT slug FROM `wp_theoilydoc`.`wp_terms` p
		LEFT JOIN `wp_theoilydoc`.`wp_term_taxonomy` pt on pt.term_id = p.term_id WHERE p.term_ID = tt.parent) AS parentSlug
		FROM `wp_theoilydoc`.`wp_terms` t
		LEFT JOIN `wp_theoilydoc`.`wp_term_taxonomy` tt on tt.term_id = t.term_id
		WHERE tt.taxonomy = 'category'
		and parent != 0
		</cfquery>
		<cfquery name="importedTags" datasource="preside">
		SELECT label FROM pobj_blog_tag
		</cfquery>
		<cfset importedTags = valueList(importedTags.label)>
		<cfloop query="subcategories">
			<cfif !listFind(importedTags, slug)>
				<cfquery datasource="preside">
				INSERT INTO pobj_blog_tag (id, label, featured, datecreated, datemodified, _version_is_draft, _version_has_drafts)
				VALUES (uuid_short(), '#slug#', 0, current_date(), current_date(), 0, 0)
				</cfquery>
			</cfif>
		</cfloop>
		<cfquery name="users" datasource="preside">
		
		INSERT INTO psys_website_user (id, login_id, email_address, display_name, active, dateCreated, dateModified)
		SELECT uuid_short(), wp.user_login, wp.user_email, wp.user_nicename, 1, current_date(), current_date() FROM `wp_theoilydoc`.`wp_users` as wp
		WHERE user_login NOT IN (SELECT login_id FROM psys_website_user WHERE login_id = user_login);
		</cfquery>
		<cfquery name="userBenefits" datasource="preside">

		INSERT INTO psys_website_benefit__join__website_user (website_benefit, website_user)
		SELECT (SELECT b.id  FROM psys_website_benefit b WHERE label = 'Team Members'),
			u.id FROM psys_website_user u
		WHERE u.id NOT IN (SELECT bu.website_user FROM psys_website_benefit__join__website_user bu)
		</cfquery>
		<cfquery name="posts" datasource="preside">
		INSERT INTO psys_page (
			id,
			title,
			page_type,
			slug,
			parent_page,
			datecreated,
			datemodified,
			active,
			internal_search_access,
			search_engine_access,
			access_restriction,
			iframe_restriction,
			exclude_from_navigation,
			sort_order,
			created_by,
			updated_by,
			exclude_from_sitemap,
			_version_has_drafts,
			_version_is_draft,
			page_views,
			unique_page_views,
			site,
			trashed,
			full_login_required,
			grantaccess_to_all_logged_in_users,
			exclude_from_navigation_when_restricted,
			exclude_from_sub_navigation,
			exclude_children_from_navigation,
			_hierarchy_sort_order,
			_hierarchy_lineage,
			_hierarchy_child_selector,
			_hierarchy_depth,
			_hierarchy_slug,
			_hierarchy_id
		)
		SELECT ID,
	    post_title,
	    'blog_post',
	    ID,
	    (
			SELECT max(id) FROM theoilydoc.psys_page where page_type = 'blog' AND title IN (
	    		SELECT tn.name
				FROM  wp_theoilydoc.wp_term_relationships tr
				left join wp_theoilydoc.wp_terms tn on tn.term_id = tr.term_taxonomy_id
				where object_id = p.id 
				AND term_taxonomy_ID IN (
					SELECT t.term_id
					FROM `wp_theoilydoc`.`wp_terms` t
					LEFT JOIN `wp_theoilydoc`.`wp_term_taxonomy` tt on tt.term_id = t.term_id
					WHERE tt.taxonomy = 'category'
				        and name != 'Uncategorized'
						and tt.parent = 0
				)
			)
	    ) as categoryID,
	    post_date,
	    post_modified,
	    1,
		'inherit',
		'inherit',
		'inherit',
		'inherit',
		1,
		0,
		'#adminUserID#' as created_by,
		'#adminUserID#' as updated_by,
		1,
		0,
		0,
		0,
		0,
		'#site#' as siteID,
		0,
		0,
		1,
		0,
		0,
		0,
		'/000000/000000',
		'/0/',
		'/0/',
		2,
		'come/back/to/this',
		RAND()*384739
	    FROM `wp_theoilydoc`.`wp_posts` p
	    WHERE post_status = 'publish'
		and post_title != ''
		AND (


	    	SELECT max(id) FROM theoilydoc.psys_page where page_type = 'blog' AND title IN (
	    		SELECT tn.name
				FROM  wp_theoilydoc.wp_term_relationships tr
				left join wp_theoilydoc.wp_terms tn on tn.term_id = tr.term_taxonomy_id
				where object_id = p.id 
				AND term_taxonomy_ID IN (
					SELECT t.term_id
					FROM `wp_theoilydoc`.`wp_terms` t
					LEFT JOIN `wp_theoilydoc`.`wp_term_taxonomy` tt on tt.term_id = t.term_id
					WHERE tt.taxonomy = 'category'
				        and name != 'Uncategorized'
						and tt.parent = 0
				)
			)
	    ) != ''
	    and post_type = 'post'
		AND CONVERT(id, CHAR(50)) NOT IN (SELECT ID FROM psys_page)
	    order by post_title;
	    </cfquery>

	    <cfquery datasource="preside" name="content">
	    SELECT (SELECT post_content FROM `wp_theoilydoc`.`wp_posts` wp WHERE p.id = wp.id) as main_content, id
	    FROM  psys_page p
	    WHERE main_content is null
	    </cfquery>
	    <cfset i = 1>
	   	<cftry>
	    <cfloop query="content">
	    	<cfdump var="#i#">
	    	<br />
	    	<cfset i += 1>
	    	<cfquery datasource="preside">
	    	UPDATE psys_page
	    	SET main_content = <cfqueryparam value="#main_content#" cfsqltype="cf_sql_varchar">
	    	WHERE id = <cfqueryparam value="#id#">
	    	</cfquery>
	    </cfloop>
	    <cfcatch>
	    	<cfdump var="#content#">
	    	<cfdump var="#cfcatch#">
	    </cfcatch>
	    </cftry>
	    <cfquery name="test" datasource="preside">

	    INSERT INTO `theoilydoc`.`pobj_blog_post`
		( ID,
		postAuthor,
		publish_date,
		allow_comments,
		top_post,
		page,
		datecreated,
		datemodified,
		_version_is_draft,
		_version_has_drafts
		)
		SELECT
			uuid_short(),
			(SELECT id FROM pobj_blog_author),
			dateCreated,
			0,
			0,
			id,
			datecreated,
			datemodified,
			0,
			0
		FROM psys_page p 
		WHERE p.id NOT IN (SELECT page FROM pobj_blog_post)
		</cfquery>
		
		<cfquery name="postTags" datasource="preside">
		SELECT p.id, post_title,t.name, t.term_id
		FROM `wp_theoilydoc`.`wp_terms` t
		LEFT JOIN `wp_theoilydoc`.`wp_term_taxonomy` tt on tt.term_id = t.term_id
		LEFT JOIN `wp_theoilydoc`.`wp_term_relationships` tr on t.term_id = tr.term_taxonomy_id
		LEFT JOIN `wp_theoilydoc`.`wp_posts` p on p.id = tr.object_id
		WHERE p.post_status = 'publish'
		AND tt.taxonomy = 'category'
		</cfquery>
		<!--- <cfdump var="#users#"> --->
		<!--- <cfdump var="#categories#"> --->
		<!--- <cfdump var="#subCategories#"> --->
		
		<cfdump var="#postTags#">
		<cfabort>
	</cffunction>
</cfcomponent>