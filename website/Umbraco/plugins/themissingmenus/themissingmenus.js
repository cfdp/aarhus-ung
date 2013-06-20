
// Pass in the Url and open a new window
function RedirectUrl() {
    var nodeId = UmbClientMgr.mainTree().getActionNode().nodeId;

    $.get("/base/Quicklinks/GetNiceUrl/" + nodeId + ".aspx",
    function (data) {
        var redirectUrl = $('value', data).text();
        if (redirectUrl != '') {
            window.open(redirectUrl, nodeId + "PreviewWindow", "menubar=yes,resizable=yes,location=yes,status=yes,scrollbars=yes");            
        } else {
            alert('Error getting Url');
        }
    });
}