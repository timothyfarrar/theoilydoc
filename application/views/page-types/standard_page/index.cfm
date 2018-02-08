<cf_presideparam name="args.title"        type="string" field="page.title"        editable="true" />
<cf_presideparam name="args.main_content" type="string" field="page.main_content" editable="true" />

<cfoutput>
	<div class="contents" >
		<div class="main-content">
			<div class="container">
				<div class="row">
					<div class="col-md-12">
						<h2>#args.title#</h2>
						#args.main_content#
					</div>
				</div>
			</div>
		</div>
	</div>
</cfoutput>