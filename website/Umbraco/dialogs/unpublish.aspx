<%@ Page Language="C#" MasterPageFile="../masterpages/umbracoDialog.Master" AutoEventWireup="true" CodeBehind="unpublish.aspx.cs" Inherits="ContextQuickLink.umbraco.dialogs.UnpublishDocument" %>
<%@ Register TagPrefix="cc1" Namespace="umbraco.uicontrols" Assembly="controls" %>
<%@ Register TagPrefix="umb" Namespace="ClientDependency.Core.Controls" Assembly="ClientDependency.Core" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">

<umb:JsInclude ID="JsInclude1" runat="server" FilePath="js/umbracoCheckKeys.js" PathNameAlias="UmbracoRoot"/>
    
<asp:Panel ID="TheForm" Visible="True" runat="server">
      
<div id="body_theEnd">
	
    <div id="body_feedbackMsg" style="" class="success">        
        <p><asp:Literal ID="litStatus" runat="server" /></p>
        <p><a href="#" onclick="UmbClientMgr.closeModalWindow();">Close this window</a></p>
    </div>

</div>
      
</asp:Panel>
<script type="text/javascript">
    //<![CDATA[
    UmbClientMgr.mainTree().reloadActionNode(false, true, null); UmbClientMgr.setUmbracoPath("/umbraco");
    //]]>
</script>
   
</asp:Content>