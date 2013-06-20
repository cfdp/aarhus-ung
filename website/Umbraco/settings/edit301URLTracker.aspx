<%@ Page MasterPageFile="../masterpages/umbracoPage.Master" Language="C#" AutoEventWireup="True" CodeBehind="edit301URLTracker.aspx.cs" Inherits="InfoCaster.Umbraco._301UrlTracker.edit301URLTracker" %>
<%@ Register Namespace="umbraco.uicontrols" Assembly="controls" TagPrefix="umb" %>
<%@ Register Src="~/usercontrols/edit301URLTrackerNode.ascx" TagName="Edit301URLTrackerNode" TagPrefix="ic" %>
<%--
// Copyright (c) 2012 - InfoCaster - Stefan Kip
// 
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
// 
// Author:	Stefan Kip - InfoCaster
// Website: http://www.infocaster.net
// Email:	stefan@infocaster.net
--%>
<asp:Content ContentPlaceHolderID="body" runat="server">
	<!-- Created by InfoCaster | Original idea by Soeteman Software -->
	<umb:UmbracoPanel ID="panel" runat="server" Width="100%" Height="100%" style="text-align: center">
		<asp:MultiView runat="server" ID="mv301URLTracker" ActiveViewIndex="0">
			<asp:View runat="server" ID="vw301URLTrackerItem">
				<ic:Edit301URLTrackerNode runat="server" ID="URLTrackerControl" />
			</asp:View>
			<asp:View runat="server" ID="vw301URLTrackerRoot">
				<umb:Pane runat="server" ID="pane1">
					<umb:PropertyPanel runat="server" ID="propertyPanel1">
						<a href="edit301URLTracker.aspx?id=-1&amp;notFound=1">&laquo; View all not found requests</a>
						<asp:Label runat="server" ID="lblButtonSeperator1" Text="&nbsp;|&nbsp;" />
						<asp:LinkButton runat="server" ID="lbDefaultExplanation" OnClick="lbDefaultExplanation_Click">In the future, open this readme by default</asp:LinkButton>
						<asp:Label runat="server" ID="lblDefaultExplanationSet" Visible="false" style="color: Green;" Text="In the future, this readme will be shown by default when clicking the '301 URL Tracker' node" />
						<asp:Literal runat="server" ID="ltlExplanation" />
					</umb:PropertyPanel>
				</umb:Pane>
			</asp:View>
			<asp:View runat="server" ID="vw301URLTrackerNotFounds">
				<umb:Pane runat="server" ID="pane2">
					<umb:PropertyPanel runat="server" ID="propertyPanel2">
						<a href="edit301URLTracker.aspx?id=-1&amp;explanation=1">&laquo; Read the 301 URL Tracker readme</a>
						<asp:Label runat="server" ID="lblButtonSeperator2" Text="&nbsp;|&nbsp;" />
						<asp:LinkButton runat="server" ID="lbDefaultNotFounds" OnClick="lbDefaultNotFounds_Click">In the future, open this overview by default</asp:LinkButton>
						<asp:Label runat="server" ID="lblDefaultNotFoundsSet" Visible="false" style="color: Green;" Text="In the future, this overview will be shown by default when clicking the '301 URL Tracker' node" />
						<asp:Label runat="server" ID="lblNoNotFounds" Text="There haven't been any requests resulting in a 404 Not Found yet! :-)" style="display: block; margin: 10px 0;" />
						<asp:UpdatePanel runat="server" ID="upNotFounds" UpdateMode="Conditional" ChildrenAsTriggers="true">
							<ContentTemplate>
								<asp:GridView runat="server" ID="gvNotFounds" OnPageIndexChanging="gvNotFounds_PageIndexChanging" OnRowDataBound="gvNotFounds_RowDataBound"
									AllowPaging="True" PageSize="20" style="margin-top: 10px;"
									CellPadding="4" ForeColor="#333333" GridLines="None" >
									<PagerSettings FirstPageText="first" LastPageText="last" Visible="true" Mode="NumericFirstLast" />
									<RowStyle BackColor="#EFF3FB" HorizontalAlign="Left" />
									<FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
									<PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
									<SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
									<HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
									<EditRowStyle BackColor="#2461BF" />
									<AlternatingRowStyle BackColor="White" />
								</asp:GridView>
							</ContentTemplate>
						</asp:UpdatePanel>
					</umb:PropertyPanel>
				</umb:Pane>
			</asp:View>
		</asp:MultiView>
	</umb:UmbracoPanel>
</asp:Content>