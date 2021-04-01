<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="BHConsole_v2.Login" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="Scripts/jquery-3.5.1.min.js"></script>
    <script src="Scripts/bootstrap.min.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
        <div class="row">
            <div class="col-2">

            </div>
            <div class="col-8">
                <div class="jumbotron">
                    <div class="card border-primary">
                        <div class="card-header">Login</div>
                        <div class="card-body">
                            <%--Form--%>
                            <asp:Label ID="lbl_result" runat="server" Text=""></asp:Label>
                            <br />
                            <%--<asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="text-danger" />--%>
                            <asp:Label ID="lbl_user" runat="server" Text="User Id" AssociatedControlID="txt_Id"></asp:Label>
                            <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="ID is required" CssClass="text-danger" Text=" *" ControlToValidate="txt_Id"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="ID must be 5 digits" ValidationExpression="\d{5}" ControlToValidate="txt_Id" CssClass="text-danger" Text="* Your ID is a 5 digit code"></asp:RegularExpressionValidator>--%>
                            <asp:TextBox ID="txt_Id" runat="server" CssClass="form-control" Text="admin"></asp:TextBox>
                            <hr />
                            <asp:Label ID="lbl_password" runat="server" Text="Password" AssociatedControlID="txt_Password"></asp:Label>
                            <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Password is required" CssClass="text-danger" Text=" *" ControlToValidate="txt_Name"></asp:RequiredFieldValidator>--%>
                            <asp:TextBox ID="txt_Password" runat="server" CssClass="form-control" MaxLength="50" TextMode="Password" ></asp:TextBox>
                            <%--/Form--%>
                            <hr />
                            <div class="row">
                                <div class="col">
                                    <asp:Button ID="btn_Login" runat="server" Text="Login" CssClass="btn btn-primary btn-lg btn-block" OnClick="btn_Login_Click"/>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-2">

            </div>
            
        </div>
        
    </div>
</asp:Content>
