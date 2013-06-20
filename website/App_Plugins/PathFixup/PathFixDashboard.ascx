<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="PathFixDashboard.ascx.cs" Inherits="UmbracoPathFix.PathFixDashboard" %>
<%@ Import Namespace="UmbracoPathFix" %>
<%@ Register Namespace="ClientDependency.Core.Controls" Assembly="ClientDependency.Core" TagPrefix="cdf" %>

<cdf:CssInclude ID="CssInclude1" runat="server" FilePath="~/App_Plugins/PathFixup/FixPaths.css" />
<cdf:JsInclude ID="JsInclude1" runat="server" FilePath="~/App_Plugins/PathFixup/FixPaths.js" />
<cdf:JsInclude ID="JsInclude2" runat="server" FilePath="UI/knockout.js" Priority="3" PathNameAlias="UmbracoClient" />

<script type="text/javascript">
    $(document).ready(function () {
        var fixer = new Umbraco.Dashboards.FixPaths({
            restServiceLocation: "<%=Url.GetFixPathsServicePath() %>"
        });
        fixer.init();
    });
</script>

<div id="pathFixDashboard" class="dashboardWrapper">

    <h2>Content & Media 'Path' fix</h2>
    <img src="<%=ResolveClientUrl("~/App_Plugins/PathFixup/tools.png") %>" alt="Path fix" class="dashboardIcon" />
    <p>
        This operation will fix up the database inconsistencies based on an issue that was introduced in version 4.10 (<a target="_blank" href="http://issues.umbraco.org/issue/U4-1491">http://issues.umbraco.org/issue/U4-1491</a>). 
    The change that was made that caused this issue was meant to improve performance but unfortunately it caused
    an bug with moving and deleting (recycling) nodes.
    </p>
    <p>
        Before executing running this operation, <strong>ensure that you backup your database</strong>. Once this operation is complete it will save a report
    at the location ~/App_Data/TEMP/FixPaths/report.txt
    </p>

    <% if (ContentPathFix.HasBeenFixed())
       { %>
    
    <div class="success" id="pathFixStatus" >
        <span>Already fixed</span>
    </div>
    
    <p>
        This fix has already been applied. The report is saved in a file at this location: ~/App_Data/TEMP/FixPaths/report.txt. 
        If you wish to re-execute this fix please delete this report file and refresh this page.
    </p>

    <% }
       else
       { %>

    <button data-bind="click: start, visible: status() == 0">Fix paths</button>

    <div id="pathFixStatus" data-bind="attr: { 'class': messageStyle }, visible: status() != 0 ">
        <span data-bind="text: message"></span>
    </div>

    <% } %>
</div>
