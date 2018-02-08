component {
    property name="contact_section_title"       type="string"   dbtype="varchar" default="Contact us";
    property name="contact_address"             type="string"   dbtype="text";
    property name="social_link_section_title"   type="string"   dbtype="varchar" default="Follow us";
    property name="social_links"                type="string"   dbtype="text";
    property name="copyright"                   type="string"   dbtype="text";
    property name="left_content"                type="string"   dbtype="text";
    property name="logo"                        relationship="many-to-one" relatedto="asset" allowedTypes="images";
}