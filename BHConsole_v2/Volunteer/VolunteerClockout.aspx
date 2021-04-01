<%@ Page Title="Volunteer Clock Out" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="VolunteerClockout.aspx.cs" Inherits="BHConsole.VolunteerClockout" %>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <script src="../Scripts/jquery-3.5.1.min.js"></script>
    <script src="../Scripts/bootstrap.min.js"></script>
    <div class="container">
        <h1 class="display-4">Volunteers</h1>
        <hr />
        <div class="row">
            <div class="col">
                <fieldset>
                    <legend>Clock Out</legend>
                    <div class="form-group">
                        <p>Thank you for your help!</p>
                        
                    </div>
                    <div class="bs-component">
                        <div class="form-group">
                            <asp:DropDownList ID="dd_clockedin" CssClass="form-control" runat="server" DataSourceID="BHDBsource" DataTextField="Name" DataValueField="Id" style="margin-bottom: 0"></asp:DropDownList>
                            <asp:SqlDataSource ID="BHDBsource" runat="server" ConnectionString="<%$ ConnectionStrings:BHDBConnectionString %>" SelectCommand="SELECT [Id], [Name] FROM [VolunteerTimepunch] WHERE ([TimeOut] IS NULL) ORDER BY [TimeIn]">    
                            </asp:SqlDataSource>
                        </div>
                        <div class="form-group">
                            <asp:Button ID="btn_clockout" class="btn btn-primary btn-lg btn-block" runat="server" Text="Clock Out" OnClick="btn_clockout_Click" OnClientClick="return confirm('Are you sure you want to clock out?')" />
                        </div>
                    </div>
                </fieldset>

            </div>
        </div>
    </div>
</asp:Content>
