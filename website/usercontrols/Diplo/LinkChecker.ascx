<%@ Control Language="C#" AutoEventWireup="true" Inherits="Diplo.LinkChecker.Web.usercontrols.Diplo.LinkCheckerControl" %>

<%@ Register Namespace="umbraco.uicontrols" Assembly="controls" TagPrefix="umb" %>

<style type="text/css">
	#linkchecker body
	{
		background-color: White;
		color: #000;
		font-family: Arial, Verdana, Sans-Serif;
		font-size: 76%;
	}
	#linkchecker h1
	{
		margin: 0 0 4px 0;
		padding: 0;
		font-size:18px;
	}
	#linkchecker a
	{
		color: #00C;
	}
	#linkchecker fieldset
	{
		padding: 5px;
		border: 1px solid #ccc;
		margin-bottom: 4px;
	}
	#linkchecker legend
	{
		font-weight: bold;
	}
	#linkchecker caption
	{
		font-weight: bold;
		color: #666;
		text-align:left;
	}
	#linkchecker .button
	{
		font-size:16px;
		margin-right:1em;
		color:#333;
	}
	#linkchecker .button:hover
	{
		color:#393;
	}
		
	#linkchecker .pageTable
	{
		width: 100%;
		border: 1px solid #666;
		padding: 2px;
		margin: 0;
		border-collapse: collapse;
		margin-top:8px;
	}
	#linkchecker .pageTable td, #linkchecker .pageTable th
	{
		padding: 4px;
		margin: 0;
		border: 1px solid #ddd;
		text-align: left;
	}
	#linkchecker .pageTable th
	{
		background-color: #334;
		color: #fff;
		font-weight: bold;
	}
	#linkchecker .pageTable .pageHead
	{
		background-color: #ffe;
		color: #003;
		padding: 4px;
		font-size: larger;
	}
	#linkchecker .pageTable .pageGrid
	{
		background-color: #ffe;
		padding: 5px;
	}
	#linkchecker .pageTable .linkGridView
	{
		width: 100%;
		border: 1px solid #aa9;
	}
	#linkchecker .linkGridView th
	{
		background-color: #666;
		color: #fff;
		font-weight: bold;
	}
	#linkchecker .linkGridView .linkRow
	{
		background-color: White;
		color: #003;
	}
	#linkchecker .linkGridView .linkRowAlternate
	{
		background-color: #eee;
		color: #000;
	}
	#linkchecker .editUmbraco
	{
		background-image: url(/umbraco/images/editor/html.gif);
		background-repeat: no-repeat;
		background-position: left center;
		padding-left: 20px;
	}
	#linkchecker .viewLink
	{
		background-image: url(/umbraco/images/umbraco/docPic.gif);
		background-repeat: no-repeat;
		background-position: left center;
		padding-left: 18px;
	}
	#linkchecker .helpLink
	{
		background-image: url(/umbraco/images/help.png);
		background-repeat: no-repeat;
		background-position: left center;
		padding-left: 18px;
	}
	#linkchecker .progress
	{
		background-color: #fff;
		padding: 10px;
		margin: 5px 0;
		border: 1px solid #CCF;
	}
	#linkchecker .error
	{
		display: block;
		background-color: #ffe;
		border: 1px solid red;
		padding: 10px;
		margin: 5px 0;
	}
	
	#linkchecker div.divider
	{
		margin:4px 0;
	}
</style>

<div id="linkchecker">

    <asp:UpdatePanel ID="UP1" runat="server">
        <Triggers>
			<asp:PostBackTrigger ControlID="ButtonExportReport" />
		</Triggers>
		<ContentTemplate>
            
			<umb:Pane ID="Pane1" runat="server">
                <h1>Link Checker</h1>
				<asp:Label ID="LblMessage" runat="server" EnableViewState="false" Visible="false" />
                <asp:Label ID="LblError" runat="server" EnableViewState="false" Visible="false" style="color:Red" />
				<asp:Panel ID="PanelParams" runat="server" DefaultButton="ButtonStartCheck">
					<asp:Label ID="LblStatus" runat="server" Text="Inlcude in report links that are:"
						AssociatedControlID="CbStatus" />
					<div class="divider">
					    <asp:CheckBoxList ID="CbStatus" runat="server" RepeatDirection="Horizontal" RepeatLayout="Flow">
						    <asp:ListItem Value="1" Text="OK" title="Report links that were found to be OK" />
						    <asp:ListItem Value="2" Text="Warning" Selected="True" title="Report links that are found but have a warning" />
						    <asp:ListItem Value="3" Text="Error" Selected="True" title="Report links that are not found or broken" />
					    </asp:CheckBoxList>
					</div>
                    <div class="divider">
					<asp:CheckBox ID="CbShowAll" runat="server" Text="Show all pages checked (even if they have no links)"
						ToolTip="Tick to show all pages that are checked (including those with no links)"
						Checked="true" />
                    </div>
                    <asp:Panel ID="PanelStartFrom" runat="server" CssClass="divider">
                        <asp:Label ID="LblStartFrom" runat="server" AssociatedControlID="ContentPickerHolder" title="Select the page to start checking from">Start From: </asp:Label>
                        <asp:PlaceHolder ID="ContentPickerHolder" runat="server" />
                    </asp:Panel>
					<div style="padding:4px 0">
						<asp:Button ID="ButtonStartCheck" runat="server" Text="Start Link Check" CssClass="button" 
							ToolTip="Click to check links" OnClick="ButtonStartCheck_Click" CausesValidation="false" />

						<asp:Button ID="ButtonExportReport" runat="server" Text="Download Report" ToolTip="Download the current report progress as a Word Document"
							OnClick="ButtonExportReport_Click" CssClass="button" Visible="false" />
                        
                        <a href="" title="Stop link checker and reset to defaults" onclick="return confirm('Are you sure you want to finish checking and reset?')" style="float:right">Reset</a>

					</div>
				</asp:Panel>
			</umb:Pane>

			<umb:Pane ID="LabelPane" runat="server">
				<asp:Label ID="LabelMessage" runat="server" Font-Bold="true" EnableViewState="false">
				</asp:Label>
			</umb:Pane>

			<asp:UpdateProgress ID="Progress" runat="server" DisplayAfter="10" EnableViewState="false">
				<ProgressTemplate>
					<div class="progress">
						<h2><img src="/umbraco/images/throbber.gif" width="16" height="16" alt="wait" /> Link Check in Progress...</h2>
						<umb:ProgressBar ID="ProgressBar1" runat="server" />
					</div>
				</ProgressTemplate>
			</asp:UpdateProgress>

			<asp:PlaceHolder ID="PlaceHolderReport" runat="server" Visible="false" EnableViewState="false">

				<table width="100%" class="pageTable">
					<asp:Repeater ID="RepeaterPages" runat="server" EnableViewState="false" OnItemDataBound="RepeaterPages_ItemDataBound">
						<ItemTemplate>
							<tr>
								<th title="A link to the page that was checked">Checked Page</th>
								<th title="A link to edit the page that was checked">Edit Link</th>
								<th title="Who created the page and when">Created</th>
								<th title="Who last edited the page and when">Last Edited</th>
								<th title="The top-level parent section the checked page resides in">Parent Section</th>
								<th title="Total number of links in this page">Links</th>
								<th title="Http Status">Status</th>
							</tr>
							<tr class="pageHead">
								<td>
									<asp:HyperLink ID="HyperLink1" runat="server" Text='<%# Eval("NodeName") %>' NavigateUrl='<%# Eval("CheckedUrl") %>'
										ToolTip='<%# Eval("CheckedUrl") %>' Target="_blank"
										CssClass="viewLink" />
								</td>
								<td>
									<asp:HyperLink ID="HyperLink2" runat="server" Text="Edit" NavigateUrl='<%# Eval("NodeId", "/umbraco/actions/editContent.aspx?id={0}") %>'
										ToolTip="Edit this page in Umbraco" Target="_blank" CssClass="editUmbraco" />
								</td>
								<td>
									<%# Eval("NodeCreateDate", "{0:d}") %>
									by <a href="mailto:<%# Eval("CreatorUserEmail") %>">
										<%# Eval("NodeCreatorName")%></a> </td>
								<td>
									<%# Eval("NodeUpdateDate", "{0:d}") %>
									by
									<%# Eval("NodeWriterName")%>
								</td>
								<td>
									<asp:HyperLink ID="HyperLinkTopNode" runat="server" Text='<%# Eval("TopLevelNodeName") %>'
										NavigateUrl='<%# Eval("TopLevelNodeUrl") %>' ToolTip="This is the top-level section the checked page was in"
										Target="_blank" />
								</td>
								<td>
									<span title="The number of links found on the page"><%# Eval("HtmlLinksCheckedCount")%></span>
								</td>
								<td style='<%# Eval("CssStyle") %>'>
									<%# Eval("StatusCodeNumberString") %>
									<%# Eval("StatusDescription") %>
								</td>
							</tr>
							<tr>
								<td colspan="7" align="center" class="pageGrid">
									<%-- GridView Of Checked Links --%>

									<asp:GridView ID="GvLinks" runat="server" AutoGenerateColumns="false" CssClass="linkGridView"
										GridLines="Both">
										<RowStyle CssClass="linkRow" />
										<AlternatingRowStyle CssClass="linkRowAlternate" />
										<Columns>
											<asp:TemplateField HeaderText="Status">
												<ItemTemplate>
													<div style="<%# Eval("CssStyle") %>">
														<%# Eval("Status") %></div>
												</ItemTemplate>
											</asp:TemplateField>
											<asp:TemplateField HeaderText="Message" ItemStyle-Wrap="true">
												<ItemTemplate>
													<%# Eval("StatusCodeNumberString") %>
													<%# Eval("StatusDescription") %>
												</ItemTemplate>
											</asp:TemplateField>
											<asp:TemplateField HeaderText="Checked Link">
												<ItemTemplate>
													<a href="<%# Eval("CheckedUrl") %>" title="<%# Eval("CheckedUrl") %>" target="_blank">
														<%# HttpUtility.UrlDecode(Eval("UrlForDisplay").ToString()) %></a>
												</ItemTemplate>
											</asp:TemplateField>
											<asp:BoundField HeaderText="Link Text" DataField="Text" />
											<asp:TemplateField HeaderText="Type">
												<ItemTemplate>
													<span title="<%# Eval("UrlAttribute") %>"><%# Eval("TagType") %></span>
												</ItemTemplate>
											</asp:TemplateField>
											<asp:BoundField HeaderText="Internal?" DataField="IsInternal" />
											<asp:TemplateField>
												<ItemTemplate>
													<asp:HyperLink ID="HyperLink3" runat="server" CssClass="helpLink" Text="Help" NavigateUrl='<%# Eval("HelpPageUrl") %>'
														Target="_blank" Visible='<%# Eval("HelpPageUrl").ToString().Length > 0 %>' Style="cursor: help" />
												</ItemTemplate>
											</asp:TemplateField>
										</Columns>
									</asp:GridView>

								</td>
							</tr>
						</ItemTemplate>
					</asp:Repeater>
				</table>

			</asp:PlaceHolder>

		</ContentTemplate>
	</asp:UpdatePanel>
</div>