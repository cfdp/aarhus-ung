APP.loadExternalUrl = function(url) {
	if (url && url != "") {
		if (navigator && navigator.app && navigator.app.loadUrl) {
			navigator.app.loadUrl(url, { openExternal: true });
		}
		else {
			window.open(url);
		}
	}
	return false;
};



//NB: mailto: links require an active mail account to be setup.

$("a")
	//Listen for clicks on external links:
	.live("click", function(e) {
		//Check if href starts with a protocol:
		var rx = /^(?!mailto:|tel:)[^:#]+:.*$/;
		var href = $(this).attr("href");
		
		if (rx.test(href)) {
			e.preventDefault();
			e.stopPropagation();
			return APP.loadExternalUrl(href);
		}
	});