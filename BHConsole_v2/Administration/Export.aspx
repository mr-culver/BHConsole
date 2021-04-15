<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Export.aspx.cs" Inherits="BHConsole_v2.Administration.Export" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
        <div class="row">
            <div class="col">
                <h2>Export</h2>

                <asp:Button ID="Button1" runat="server" Text="Button" OnClick="Button1_Click" />

            </div>
        </div>
    </div>
</asp:Content>
