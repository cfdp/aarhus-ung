
/*
 DEV-DEBUG INFO: mailto: and tel: links not supported by iPhone Simulator since it does not have phone or email apps!
 */
/*
 Listen for clicks on external links, inspired by:
 http://www.rigelgroupllc.com/blog/2012/05/22/opening-links-in-phonegap-apps-in-mobile-safari/
 */
$("a").live("click", function(e) {
    var href = $(this).attr("href");
    var rx = /^(?!mailto:|tel:)[^:#]+:.*$/;
    
    //Check if href starts with protocol (excluding mailto and tel):
    //Only modify href attribute once:
    if (rx.test(href) && href.indexOf("#aarhusung=external") == -1) {
        
        $(this)
            .attr("target", "_blank")
            .attr("href", href + "#aarhusung=external");
        
    }
});