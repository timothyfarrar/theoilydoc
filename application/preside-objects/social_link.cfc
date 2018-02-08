/**
 * @dataManagerGroup sitewide
 */
component {
	property name="type" control="select" labels="Facebook,Twitter,Google plus" values="facebook,twitter,google-plus";
	property name="link" relatedto="link" relationship="many-to-one";
}