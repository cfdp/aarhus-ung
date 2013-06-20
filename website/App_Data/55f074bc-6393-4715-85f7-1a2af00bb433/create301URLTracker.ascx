<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="create301URLTracker.ascx.cs" Inherits="InfoCaster.Umbraco._301UrlTracker.Create301URLTrackerControl" %>
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
<input type="hidden" name="nodeType" value="-1"/>

<asp:Label runat="server" ID="lblMessage" Text="Please select a valid node" Visible="false" style="color: Red; font-size: 90%; font-weight: bold; display: block;" />
<b>Select a node:</b>
<br /><br /><asp:PlaceHolder runat="server" ID="phContentPicker" />

<!-- added to support missing postback on enter in IE -->
<asp:TextBox runat="server" style="visibility: hidden; display: none;" ID="Textbox1"/>

<div style="margin-top: 15px;">
	<asp:Button ID="btnSelect" runat="server" OnClick="btnSelect_Click" style="margin-top: 14px" Width="90" />
	<em> or </em>
	<asp:LinkButton runat="server" ID="lbCancel" OnClick="btnCancel_Click" style="color: Blue; margin-left: 6px;"><%= umbraco.ui.Text("cancel") %></asp:LinkButton>
</div>