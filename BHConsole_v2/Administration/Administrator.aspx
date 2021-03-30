<%@ Page Title="Admin" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Administrator.aspx.cs" Inherits="BHConsole_v2.Administration.Administrator" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="../Scripts/jquery-3.5.1.js"></script>
    <script src="../Scripts/bootstrap.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
        <div class="row">
            <div class="col">
                <h2>Admin Dashboard</h2>
                <asp:Label ID="lbl_error" runat="server" Text="" CssClass="text-danger"></asp:Label>
                <ul class="nav nav-tabs">
                    <li class="nav-item">
                        <a class="nav-link text-info active" data-toggle="tab" href="#volunteers">Volunteers</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link text-info" data-toggle="tab" href="#shoppers">Shoppers</a>
                    </li>
                </ul>
                <div id="myTabContent" class="tab-content">
                    <div class="tab-pane fade active show" id="volunteers">
                        <br />
                        <h4>Manage Volunteers</h4>
                        <hr />
                        <div class="alert alert-dismissible alert-info">
                            <strong>Hello!</strong> This is an example placeholder, maybe information could be displayed based on certain criteria, or links displayed like <a href="#" class="alert-link">this one here</a>.
                        </div>
                        <hr />
                        <ul class="nav nav-tabs">
                            <li class="nav-item">
                                <a class="nav-link text-info active" data-toggle="tab" href="#overview">Overview</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link text-info" data-toggle="tab" href="#clockedin">Clocked In Volunteers</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link text-info disabled" href="#export">Export Data</a>
                            </li>
                        </ul>
                        <div class="tab-content" id="volunteerTabContent">
                            <div class="tab-pane fade show active" id="overview">
                                <br />
                                <div class="row">
                                    <div class="col col-md-5 col-sm-12">
                                        <asp:Label ID="lbl_volunteerMonthYear" runat="server" Text="Month/Year" CssClass="text-body" ></asp:Label>
                                        <div class="input-group">
                                            <asp:TextBox ID="txt_volunteerMonthYear" runat="server" CssClass="form-control" TextMode="Month" OnTextChanged="txt_volunteerMonthYear_TextChanged" AutoPostBack="true"></asp:TextBox>
                                        </div>
                                    </div>
                                    <%--<div class="col col-md-7 col-sm-12">
                                        <br />
                                        <br />
                                    </div>--%>
                                </div>
                                <div class="row">
                                    <div class="col col-md-5 col-sm-12">
                                        <br />
                                        <asp:GridView ID="VolunteerOverview" runat="server" CssClass="table table-hover" AutoGenerateColumns="False" DataSourceID="VolunteerOverviewDataSource" EmptyDataText="No items to display" DataKeyNames="Id" HeaderStyle-CssClass="table-info" AllowPaging="True" GridLines="None" RowStyle-CssClass="table-light" ShowHeaderWhenEmpty="True">
                                            <Columns>
                                                <asp:BoundField DataField="TimeIn" HeaderText="TimeIn" SortExpression="TimeIn" DataFormatString="{0:d}"  />
                                                <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                                                <asp:BoundField DataField="Hours" HeaderText="Hours" ReadOnly="True" SortExpression="Hours" />
                                                <asp:CommandField ShowSelectButton="True" />
                                            </Columns>
                                            <HeaderStyle CssClass="table-info"></HeaderStyle>
                                            <PagerStyle CssClass="text-info"></PagerStyle>
                                            <RowStyle CssClass="table-light"></RowStyle>
                                            <SelectedRowStyle CssClass="table-success"></SelectedRowStyle>
                                        </asp:GridView>
                                        <asp:SqlDataSource ID="VolunteerOverviewDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:BHDBConnectionString %>" SelectCommand="SelectVolunteers" SelectCommandType="StoredProcedure" UpdateCommand="UPDATE VolunteerTimepunch SET Name = @Name, TimeIn =@TimeIn WHERE (Id = @Id)">
                                            <SelectParameters>
                                                <asp:SessionParameter DefaultValue="" Name="Month" SessionField="Month" Type="String" />
                                                <asp:SessionParameter DefaultValue="" Name="Year" SessionField="Year" Type="String" />
                                            </SelectParameters>
                                            <UpdateParameters>
                                                <asp:Parameter Name="Name" />
                                                <asp:Parameter Name="TimeIn" />
                                                <asp:Parameter Name="Id" />
                                            </UpdateParameters>
                                        </asp:SqlDataSource>
                                    </div>
                                    <div class="col col-md-7 col-sm-12">
                                        <br />
                                        <div class="card border-info mb-2">
                                            <div class="card-header">Detail View</div>
                                            <div class="card-body">
                                                <asp:FormView ID="VolunteerOverviewFormView" runat="server" DataKeyNames="Id" DataSourceID="VolunteerOverviewDetailDataSource" EmptyDataText="Nothing has been selected">
                                                    <EditItemTemplate>
                                                        Name:
                                                        <asp:TextBox ID="NameTextBox" runat="server" Text='<%# Bind("Name") %>' />
                                                        <br />
                                                        Email:
                                                        <asp:TextBox ID="EmailTextBox" runat="server" Text='<%# Bind("Email") %>' />
                                                        <br />
                                                        Phone:
                                                        <asp:TextBox ID="PhoneTextBox" runat="server" Text='<%# Bind("Phone") %>' />
                                                        <br />
                                                        TimeIn:
                                                        <asp:TextBox ID="TimeInTextBox" runat="server" Text='<%# Bind("TimeIn") %>' />
                                                        <br />
                                                        TimeOut:
                                                        <asp:TextBox ID="TimeOutTextBox" runat="server" Text='<%# Bind("TimeOut") %>' />
                                                        <br />
                                                        <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" Text="Update" />
                                                        &nbsp;<asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
                                                    </EditItemTemplate>
                                                    <InsertItemTemplate>
                                                        Name:
                                                        <asp:TextBox ID="NameTextBox" runat="server" Text='<%# Bind("Name") %>' />
                                                        <br />
                                                        Email:
                                                        <asp:TextBox ID="EmailTextBox" runat="server" Text='<%# Bind("Email") %>' />
                                                        <br />
                                                        Phone:
                                                        <asp:TextBox ID="PhoneTextBox" runat="server" Text='<%# Bind("Phone") %>' />
                                                        <br />
                                                        TimeIn:
                                                        <asp:TextBox ID="TimeInTextBox" runat="server" Text='<%# Bind("TimeIn") %>' />
                                                        <br />
                                                        TimeOut:
                                                        <asp:TextBox ID="TimeOutTextBox" runat="server" Text='<%# Bind("TimeOut") %>' />
                                                        <br />
                                                        <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="Insert" />
                                                        &nbsp;<asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
                                                    </InsertItemTemplate>
                                                    <ItemTemplate>
                                                        Name:
                                                        <asp:Label ID="NameLabel" runat="server" Text='<%# Bind("Name") %>' />
                                                        <br />
                                                        Email:
                                                        <asp:Label ID="EmailLabel" runat="server" Text='<%# Bind("Email") %>' />
                                                        <br />
                                                        Phone:
                                                        <asp:Label ID="PhoneLabel" runat="server" Text='<%# Bind("Phone") %>' />
                                                        <br />
                                                        Time In:
                                                        <asp:Label ID="TimeInLabel" runat="server" Text='<%# Bind("TimeIn", "{0:g}") %>' />
                                                        <br />
                                                        Time Out:
                                                        <asp:Label ID="TimeOutLabel" runat="server" Text='<%# Bind("TimeOut", "{0:g}") %>' />
                                                        <br />
                                                        <asp:LinkButton ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit" CssClass="text-info" Text="Edit" />
                                                        &nbsp;<asp:LinkButton ID="DeleteButton" runat="server" CausesValidation="False" CommandName="Delete" CssClass="text-info" Text="Delete" />
                                                        &nbsp;<asp:LinkButton ID="NewButton" runat="server" CausesValidation="False" CommandName="New" CssClass="text-info" Text="New" />

                                                    </ItemTemplate>
                                                </asp:FormView>
                                                <asp:SqlDataSource ID="VolunteerOverviewDetailDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:BHDBConnectionString %>" DeleteCommand="DELETE FROM [VolunteerTimepunch] WHERE [Id] = @Id" InsertCommand="INSERT INTO [VolunteerTimepunch] ([Name], [Email], [Phone], [TimeIn], [TimeOut]) VALUES (@Name, @Email, @Phone, @TimeIn, @TimeOut)" SelectCommand="SELECT * FROM [VolunteerTimepunch] WHERE ([Id] = @Id)" UpdateCommand="UPDATE [VolunteerTimepunch] SET [Name] = @Name, [Email] = @Email, [Phone] = @Phone, [TimeIn] = @TimeIn, [TimeOut] = @TimeOut WHERE [Id] = @Id">
                                                    <DeleteParameters>
                                                        <asp:Parameter Name="Id" Type="Int32" />
                                                    </DeleteParameters>
                                                    <InsertParameters>
                                                        <asp:Parameter Name="Name" Type="String" />
                                                        <asp:Parameter Name="Email" Type="String" />
                                                        <asp:Parameter Name="Phone" Type="String" />
                                                        <asp:Parameter Name="TimeIn" Type="DateTime" />
                                                        <asp:Parameter Name="TimeOut" Type="DateTime" />
                                                    </InsertParameters>
                                                    <SelectParameters>
                                                        <asp:ControlParameter ControlID="VolunteerOverview" Name="Id" PropertyName="SelectedValue" Type="Int32" />
                                                    </SelectParameters>
                                                    <UpdateParameters>
                                                        <asp:Parameter Name="Name" Type="String" />
                                                        <asp:Parameter Name="Email" Type="String" />
                                                        <asp:Parameter Name="Phone" Type="String" />
                                                        <asp:Parameter Name="TimeIn" Type="DateTime" />
                                                        <asp:Parameter Name="TimeOut" Type="DateTime" />
                                                        <asp:Parameter Name="Id" Type="Int32" />
                                                    </UpdateParameters>
                                                </asp:SqlDataSource>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="tab-pane fade" id="clockedin">
                                
                            </div>
                            <div class="tab-pane fade" id="export">
                                
                            </div>
                        </div>
                    </div>
                    <div class="tab-pane fade" id="shoppers">
                        <div class="container">
                            <hr />
                            <h1>Shopper Overview</h1>
                            <hr />
                            <h3>All Shoppers</h3>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
