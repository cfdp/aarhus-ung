<%@ Control Language="C#" AutoEventWireup="True" CodeBehind="edit301URLTrackerNode.ascx.cs" Inherits="InfoCaster.Umbraco._301UrlTracker.usercontrols.edit301URLTrackerNode" %>
<%@ Register Namespace="umbraco.uicontrols" Assembly="controls" TagPrefix="umb" %>
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
<style type="text/css">
	span.url { }
	span.message { font-size: 90%; margin-left: 15px; }
	.deleteButton { margin-left: 15px; vertical-align: middle; }
	.propertypane div.propertyItem .propertyItemContent { width: 80%; }
	.form-text { width: 100px; float: left; margin-top: 4px; }
	.form-field { width: 200px; float: left; }
	.form-button { margin-left: 15px; float: left; height: 22px; }
	.form-example { font-size: 90%; float: left; margin-left: 15px; margin-top: 5px; }
	.form-row { margin-bottom: 5px; }
	.form-checkbox { float: left; }
	.form-checkbox input { margin: 0 5px 0 0; }
	.clearer { clear: both; }
</style>

<asp:UpdatePanel runat="server" ID="upUrls" UpdateMode="Conditional" ChildrenAsTriggers="false">
	<ContentTemplate>
		<umb:Pane runat="server" ID="pane">
			<umb:PropertyPanel runat="server" ID="propertyPanel" Text="Automatic mappings">
				<asp:Repeater runat="server" ID="rptUrls" OnItemCommand="rptUrls_ItemCommand" OnItemDataBound="rptUrls_ItemDataBound">
					<ItemTemplate>
						<span class="url" title="<%# Eval("Inserted") %>">
							<a target="_blank" href="<%# Eval("OldUrl") %>"><%# Eval("OldUrl") %></a>
						</span>
						<asp:ImageButton runat="server" ID="ibtnDelete" ImageUrl="~/umbraco/images/delete.small.png" CssClass="deleteButton" AlternateText="Delete" CommandName="delete" />
						<span class="message"><%# !string.IsNullOrEmpty(Eval("Message").ToString()) ? string.Format("({0})", Eval("Message").ToString()) : string.Empty %></span>
						<div style="clear: both;"></div>
					</ItemTemplate>
				</asp:Repeater>
			</umb:PropertyPanel>
		</umb:Pane>
	</ContentTemplate>
</asp:UpdatePanel>

<asp:UpdatePanel runat="server" ID="upCustomUrls" UpdateMode="Conditional" ChildrenAsTriggers="false">
	<ContentTemplate>
		<umb:Pane runat="server" ID="customPane">
			<umb:PropertyPanel runat="server" ID="customPropertyPanel" Text="Custom mappings">
				<asp:Repeater runat="server" ID="rptCustomUrls" OnItemCommand="rptUrls_ItemCommand" OnItemDataBound="rptUrls_ItemDataBound">
					<ItemTemplate>
						<span class="url" title="<%# Eval("Inserted") %>">
							<asp:HyperLink runat="server" ID="lnkOldUrl" target="_blank" />
							<asp:Label runat="server" ID="lblRegex" />
						</span>
						<asp:ImageButton runat="server" ID="ibtnDelete" ImageUrl="~/umbraco/images/delete.small.png" CssClass="deleteButton" AlternateText="Delete" CommandName="delete" />
						<span class="message"><%# Eval("Message") != null && !string.IsNullOrEmpty(Eval("Message").ToString()) ? string.Format("({0})", Eval("Message").ToString()) : string.Empty %></span>
						<div style="clear: both;"></div>
					</ItemTemplate>
				</asp:Repeater>
			</umb:PropertyPanel>
		</umb:Pane>
	</ContentTemplate>
</asp:UpdatePanel>

<asp:UpdatePanel runat="server" ID="upAddMapping" UpdateMode="Conditional" ChildrenAsTriggers="false">
	<ContentTemplate>
		<umb:Pane runat="server" ID="addMappingPane">
			<umb:PropertyPanel runat="server" ID="addMappingPanel" Text="Add custom mapping">
				<asp:Panel ID="Panel1" runat="server">
					<asp:Label runat="server" ID="lblMessage" style="display: block;" Visible="false" />
					<div class="form-row">
						<asp:CheckBox runat="server" ID="cbRegex" AutoPostBack="true" OnCheckedChanged="cbRegex_CheckedChanged" Text="Use RegEx" CssClass="form-checkbox" />
						<asp:Label runat="server" ID="lblRegexr" CssClass="form-example" style="margin-top: 3px; margin-left: 25px;">
							(tip: use <a href="http://www.regexr.com" target="_blank">www.RegExr.com</a> to create a RegEx!)
						</asp:Label>
						<div class="clearer"></div>
					</div>
					<div class="form-row">
						<span class="form-text"><%= useRegex ? "RegEx" : "Url" %> *:</span><asp:TextBox runat="server" ID="tbAddMapping" CssClass="form-field" />
						<asp:Label runat="server" ID="lblExample" CssClass="form-example" />
						<div class="clearer"></div>
					</div>
					<div class="form-row">
						<span class="form-text">Note:</span><asp:TextBox runat="server" ID="tbAddMappingReason" CssClass="form-field" />
						<asp:Button runat="server" ID="btnAddMapping" OnClick="btnAddMapping_Click" Text="Add mapping" CssClass="form-button" />
						<div class="clearer"></div>
					</div>
				</asp:Panel>
			</umb:PropertyPanel>
		</umb:Pane>
	</ContentTemplate>
</asp:UpdatePanel>