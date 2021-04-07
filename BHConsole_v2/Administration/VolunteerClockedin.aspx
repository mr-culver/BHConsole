<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="VolunteerClockedin.aspx.cs" Inherits="BHConsole_v2.Administration.VolunteerClockedin" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="../Scripts/jquery-3.5.1.min.js"></script>
    <script src="../Scripts/bootstrap.min.js"></script>
    <script src="../Scripts/jquery.mask.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
        <br />
        <h3>Clocked In Volunteers</h3>
        <asp:Label ID="lbl_time" runat="server" Text="" Visible="False"></asp:Label>
        <hr />
        <div class="alert alert-dismissible alert-info">
            <strong>Hello!</strong> This is an example placeholder, maybe information could be displayed based on certain criteria, or links displayed like <a href="#" class="alert-link">this one here</a>.
        </div>
        <hr />
        <div class="row">
            <div class="col">
                <br />
                <asp:GridView ID="ClockedInGridview" runat="server" AutoGenerateColumns="False" CssClass="table table-hover" DataKeyNames="Id" DataSourceID="ClockedInDataSource" GridLines="None" EmptyDataText="No records to display">
                    <Columns>
                        <asp:BoundField DataField="TimeIn" HeaderText="Time In" SortExpression="TimeIn" DataFormatString="{0:g}" />
                        <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                        <asp:BoundField DataField="Shift Length" HeaderText="Shift Length" ReadOnly="True" SortExpression="Shift Length" />
                        <asp:CommandField ShowDeleteButton="True" />
                    </Columns>
                    <HeaderStyle CssClass="table-info" />
                    <RowStyle CssClass="table-light" />
                </asp:GridView>
                <asp:SqlDataSource ID="ClockedInDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:BHDBConnectionString %>" DeleteCommand="DELETE FROM [VolunteerTimepunch] WHERE [Id] = @Id" InsertCommand="INSERT INTO [VolunteerTimepunch] ([Name], [Email], [Phone], [TimeIn]) VALUES (@Name, @Email, @Phone, @TimeIn)" SelectCommand="SelectClockedInVolunteers" SelectCommandType="StoredProcedure" UpdateCommand="UPDATE [VolunteerTimepunch] SET [Name] = @Name, [Email] = @Email, [Phone] = @Phone, [TimeIn] = @TimeIn WHERE [Id] = @Id">
                    <DeleteParameters>
                        <asp:Parameter Name="Id" Type="Int32" />
                    </DeleteParameters>
                    <InsertParameters>
                        <asp:Parameter Name="Name" Type="String" />
                        <asp:Parameter Name="Email" Type="String" />
                        <asp:Parameter Name="Phone" Type="String" />
                        <asp:Parameter Name="TimeIn" Type="DateTime" />
                    </InsertParameters>
                    <SelectParameters>
                        <asp:ControlParameter ControlID="lbl_time" Name="Time" PropertyName="Text" Type="DateTime" />
                    </SelectParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="Name" Type="String" />
                        <asp:Parameter Name="Email" Type="String" />
                        <asp:Parameter Name="Phone" Type="String" />
                        <asp:Parameter Name="TimeIn" Type="DateTime" />
                        <asp:Parameter Name="Id" Type="Int32" />
                    </UpdateParameters>
                </asp:SqlDataSource>
            </div>
        </div>
        <div class="row">
            <div class="col">
                <div class="bs-component">
                    <div class="form-group">
                        <asp:DropDownList ID="dd_clockedin" CssClass="form-control" runat="server" DataSourceID="ClockedInDataSource" DataTextField="Name" DataValueField="Id"></asp:DropDownList>
                        <%--<asp:SqlDataSource ID="" runat="server" ConnectionString="<%$ ConnectionStrings:BHDBConnectionString %>" SelectCommand="SELECT [Id], [Name] FROM [VolunteerTimepunch] WHERE ([TimeOut] IS NULL) ORDER BY [TimeIn]">--%>    
                        <%--</asp:SqlDataSource>--%>
                    </div>
                    <div class="form-group">
                        <asp:Button ID="btn_clockout" class="btn btn-primary btn-lg btn-block" runat="server" Text="Clock Out" OnClick="btn_clockout_Click" OnClientClick="return confirm('Are you sure you want to clock out?')" />
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
