<%@ Page Title="Admin" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Administrator.aspx.cs" Inherits="BHConsole_v2.Administration.Administrator" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <script src="../Scripts/jquery-3.5.1.js"></script>
    <script src="../Scripts/jquery.validate.js"></script>
    <script src="../Scripts/jquery.mask.js"></script>
    <script src="../Scripts/bootstrap.js"></script>
    <script src="../Scripts/popper.js"></script>
    <link href="../Content/minty.css" rel="stylesheet" />
    <div class="container">
        <div class="row-cols-1">
            <div class="row">
                <div class="col">
                    <ul class="nav nav-tabs">
                        <li class="nav-item">
                            <a class="nav-link active" data-toggle="tab" href="#volunteers">Volunteers</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" data-toggle="tab" href="#shoppers">Shoppers</a>
                        </li>
                    </ul>
                    <div id="myTabContent" class="tab-content">
                        <div class="tab-pane fade active show" id="volunteers">
                            <div class="container">
                                <hr />
                                <h1>Volunteer Overview</h1>
                                <hr />
                                <div class="row">
                                    <div class="col">
                                        <h3>All Volunteers</h3>
                                        <div class="container">
                                            <div class="row">
                                                <div class="col">
                                                    <asp:Label ID="lbl_volunteerMonthYear" runat="server" Text="Month/Year" CssClass="text-body" AssociatedControlID="txt_volunteerMonthYear"></asp:Label>
                                                    <asp:TextBox ID="txt_volunteerMonthYear" runat="server" CssClass="form-control" TextMode="Month" AutoPostBack="true"></asp:TextBox>
                                                    <br />
                                                    <asp:GridView ID="VolunteerOverview" runat="server" CssClass="table table-bordered table-hover" AutoGenerateColumns="False" DataSourceID="VolunteerOverviewDataSource" EmptyDataText="No items to display" DataKeyNames="Id">
                                                        <Columns>
                                                            <asp:CommandField ShowSelectButton="True" />
                                                            <asp:BoundField DataField="TimeIn" HeaderText="TimeIn" SortExpression="TimeIn" />
                                                            <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                                                            <asp:BoundField DataField="Id" HeaderText="Id" InsertVisible="False" ReadOnly="True" SortExpression="Id" />
                                                        </Columns>
                                                        <HeaderStyle CssClass="table-primary" />
                                                    </asp:GridView>
                                                    <asp:SqlDataSource ID="VolunteerOverviewDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:BHDBConnectionString %>" SelectCommand="SELECT [TimeIn], [Name], [Id] FROM [VolunteerTimepunch] WHERE ([TimeIn] = @TimeIn)">
                                                        <SelectParameters>
                                                            <asp:ControlParameter ControlID="txt_volunteerMonthYear" DefaultValue="" Name="TimeIn" PropertyName="Text" Type="DateTime" />
                                                        </SelectParameters>
                                                    </asp:SqlDataSource>
                                                </div>
                                                <div class="col">
                                                    <asp:FormView ID="FormView1" runat="server"></asp:FormView>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col">
                                        <h3>Clocked In Volunteers</h3>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col">
                                        <h3>Volunteer Time Punches</h3>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col">
                                    </div>
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
    </div>
</asp:Content>
