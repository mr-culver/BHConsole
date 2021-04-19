<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="VolunteerOverview.aspx.cs" Inherits="BHConsole_v2.Administration.VolunteerOverview" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="../Scripts/jquery-3.5.1.min.js"></script>
    <script src="../Scripts/bootstrap.min.js"></script>
    <script src="../Scripts/jquery.mask.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container" >
        <br />
        <h2 class="display-4">Volunteer Overview</h2>
        <hr />
        <div class="row">
            <div class="col col-lg-5 col-md-12">
                <asp:Label ID="lbl_datetimeVolunteer" runat="server" Text="" Font-Size="XX-Large" CssClass="text-info"></asp:Label>
            </div>
            <div class="col col-lg-7 col-md-12">
                <asp:Label ID="Label6" runat="server" Text="Volunteer Hours (day): " CssClass="h4"></asp:Label><asp:Label ID="lbl_volunteerHoursDay" runat="server" Text="" CssClass="h4 text-info"></asp:Label>
                <br />
                <asp:Label ID="Label8" runat="server" Text="Volunteer Hours (month): " CssClass="h4"></asp:Label><asp:Label ID="lbl_volunteerHoursMonth" runat="server" Text="" CssClass="h4 text-info"></asp:Label>
            </div>
        </div>
        <hr />
        <div class="row">
            <div class="col col-lg-5 col-md-12 col-sm-12">
                <asp:Label ID="lbl_volunteerMonthYear" runat="server" Text="Change Date" CssClass="text-body" ></asp:Label>
                <div class="input-group">
                    <asp:TextBox ID="txt_volunteerMonthYear" runat="server" CssClass="form-control" TextMode="Date" OnTextChanged="txt_volunteerMonthYear_TextChanged" AutoPostBack="true"></asp:TextBox>
                </div>
            </div>
            <div class="col col-lg-7 col-md-12 col-sm-12">
                <br />
                <div class="row">
                    <div class="col">
                        <asp:Button ID="btn_exportMonth" runat="server" Text="Export Month" CssClass="btn btn-info btn-block" OnClick="btn_exportMonth_Click" />
                    </div>
                    <div class="col">
                        <asp:Button ID="btn_exportDay" runat="server" Text="Export Day" CssClass="btn btn-info btn-block" OnClick="btn_exportDay_Click"/>
                    </div>
                </div>
                <asp:Label ID="lbl_error" runat="server" Text="Label" CssClass="test-danger"></asp:Label>
            </div>
        </div>
        <br />
        <ul class="nav nav-tabs">
            <li class="nav-item">
                <a class="nav-link active" data-toggle="tab" href="#day">Day</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" data-toggle="tab" href="#month">Month</a>
            </li>
        </ul>
        <div id="myTabContent" class="tab-content">
            <div class="tab-pane fade show active" id="day">
                <%--Day Row--%>
                <div class="row">
                    <div class="col col-lg-5 col-md-12 col-sm-12">
                        <br />
                        <asp:GridView ID="VolunteerOverviewGridView" runat="server" CssClass="table table-hover" AutoGenerateColumns="False" DataSourceID="VolunteerOverviewDataSource" EmptyDataText="No items to display" DataKeyNames="Id" HeaderStyle-CssClass="table-info" AllowPaging="True" GridLines="None" RowStyle-CssClass="table-light" ShowHeaderWhenEmpty="True" PageSize="20">
                            <Columns>
                                <asp:BoundField DataField="TimeIn" HeaderText="Time" SortExpression="TimeIn" DataFormatString="{0:t}"  />
                                <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                                <asp:BoundField DataField="Hours" HeaderText="Hours" ReadOnly="True" SortExpression="Hours" />
                                <asp:CommandField ShowSelectButton="True" ButtonType="Button" >
                                <ControlStyle CssClass="btn btn-outline-success btn-sm btn-block" />
                                </asp:CommandField>
                            </Columns>
                            <HeaderStyle CssClass="table-info"></HeaderStyle>
                            <RowStyle CssClass="table-light"></RowStyle>
                            <SelectedRowStyle CssClass="table-success"></SelectedRowStyle>
                        </asp:GridView>
                        <asp:SqlDataSource ID="VolunteerOverviewDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:BHDBConnectionString %>" SelectCommand="SelectVolunteers" SelectCommandType="StoredProcedure" UpdateCommand="UPDATE VolunteerTimepunch SET Name = @Name, TimeIn =@TimeIn WHERE (Id = @Id)">
                            <SelectParameters>
                                <asp:SessionParameter Name="Day" SessionField="Day" Type="Int32" />
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
                    <div class="col col-lg-7 col-md-12 col-sm-12">
                        <br />
                        <div class="card border-info mb-2">
                            <div class="card-header">Detail View</div>
                            <div class="card-body">
                                <asp:FormView ID="VolunteerOverviewFormView" runat="server" DataKeyNames="Id" DataSourceID="VolunteerOverviewDetailDataSource" EmptyDataText="Nothing has been selected" CssClass="container-fluid" OnItemDeleted="VolunteerOverviewFormView_ItemDeleted" OnItemInserted="VolunteerOverviewFormView_ItemInserted" OnItemUpdated="VolunteerOverviewFormView_ItemUpdated">
                                    <EditItemTemplate>
                                        <strong>Name</strong>
                                        <asp:TextBox ID="NameTextBox" runat="server" Text='<%# Bind("Name") %>'  CssClass="form-control"/>
                                        <br />
                                        <strong>Email</strong>
                                        <asp:TextBox ID="EmailTextBox" runat="server" Text='<%# Bind("Email") %>'  CssClass="form-control"/>
                                        <br />
                                        <strong>Phone</strong>
                                        <asp:TextBox ID="PhoneTextBox" runat="server" Text='<%# Bind("Phone") %>'  CssClass="form-control"/>
                                        <hr />
                                        <strong>Time In</strong>
                                        <asp:TextBox ID="TimeInTextBox" runat="server" Text='<%# Bind("TimeIn") %>'  CssClass="form-control"/>
                                        <br />
                                        <strong>Time Out</strong>
                                        <asp:TextBox ID="TimeOutTextBox" runat="server" Text='<%# Bind("TimeOut") %>'  CssClass="form-control"/>
                                        <br />
                                        <div class="row">
                                            <div class="col">
                                                <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" Text="Update" CssClass="btn btn-success btn-sm btn-block" />
                                            </div>
                                            <div class="col">
                                                <asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" CssClass="btn btn-danger btn-sm btn-block" />
                                            </div>
                                        </div>
                                    </EditItemTemplate>
                                    <InsertItemTemplate>
                                        <strong>Name</strong>
                                        <asp:TextBox ID="NameTextBox" runat="server" Text='<%# Bind("Name") %>'  CssClass="form-control"/>
                                        <br />
                                        <strong>Email</strong>
                                        <asp:TextBox ID="EmailTextBox" runat="server" Text='<%# Bind("Email") %>'  CssClass="form-control"/>
                                        <br />
                                        <strong>Phone</strong>
                                        <asp:TextBox ID="PhoneTextBox" runat="server" Text='<%# Bind("Phone") %>'  CssClass="form-control"/>
                                        <hr />
                                        <strong>Time In</strong>
                                        <asp:TextBox ID="TimeInTextBox" runat="server" Text='<%# Bind("TimeIn") %>'  CssClass="form-control" TextMode="DateTimeLocal" />
                                        <br />
                                        <strong>Time Out</strong>
                                        <asp:TextBox ID="TimeOutTextBox" runat="server" Text='<%# Bind("TimeOut") %>'  CssClass="form-control" TextMode="DateTimeLocal"/>
                                        <br />
                                        <div class="row">
                                            <div class="col">
                                                <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="Insert" CssClass="btn btn-success btn-sm btn-block" />
                                            </div>
                                            <div class="col">
                                                <asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" CssClass="btn btn-danger btn-sm btn-block" />
                                            </div>
                                        </div>
                                    </InsertItemTemplate>
                                    <ItemTemplate>
                                        <strong>Name:</strong>
                                        <asp:Label ID="NameLabel" runat="server" Text='<%# Bind("Name") %>' />
                                        <br />
                                        <strong>Email:</strong>
                                        <asp:Label ID="EmailLabel" runat="server" Text='<%# Bind("Email") %>' />
                                        <br />
                                        <strong>Phone:</strong>
                                        <asp:Label ID="PhoneLabel" runat="server" Text='<%# Bind("Phone") %>' />
                                        <hr />
                                        <strong>Time In:</strong>
                                        <asp:Label ID="TimeInLabel" runat="server" Text='<%# Bind("TimeIn", "{0:f}") %>' />
                                        <br />
                                        <strong>Time Out:</strong>
                                        <asp:Label ID="TimeOutLabel" runat="server" Text='<%# Bind("TimeOut", "{0:f}") %>' />
                                        <br />
                                        <strong>Hours:</strong>
                                        <asp:Label ID="HoursLabel" runat="server" Text='<%# Bind("Hours") %>' />
                                        <br />
                                        <br />
                                        <div class="row">
                                            <div class="col">
                                                <asp:LinkButton ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit" CssClass="btn btn-info btn-sm btn-block" />
                                            </div>
                                            <div class="col">
                                                <asp:LinkButton ID="NewButton" runat="server" CausesValidation="False" CommandName="New" Text="New" CssClass="btn btn-success btn-sm btn-block" />
                                            </div>
                                            <div class="col">
                                                <asp:LinkButton ID="DeleteButton" runat="server" CausesValidation="False" CommandName="Delete" Text="Delete" CssClass="btn btn-danger btn-sm btn-block" />
                                            </div>
                                        </div>
                                    </ItemTemplate>
                                </asp:FormView>
                                <asp:SqlDataSource ID="VolunteerOverviewDetailDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:BHDBConnectionString %>" DeleteCommand="DELETE FROM [VolunteerTimepunch] WHERE [Id] = @Id" InsertCommand="INSERT INTO [VolunteerTimepunch] ([Name], [Email], [Phone], [TimeIn], [TimeOut]) VALUES (@Name, @Email, @Phone, @TimeIn, @TimeOut)" SelectCommand="SelectVolunteerDetails" UpdateCommand="UPDATE [VolunteerTimepunch] SET [Name] = @Name, [Email] = @Email, [Phone] = @Phone, [TimeIn] = @TimeIn, [TimeOut] = @TimeOut WHERE [Id] = @Id" SelectCommandType="StoredProcedure" OnInserted="VolunteerOverviewDetailDataSource_Inserted" OnUpdated="VolunteerOverviewDetailDataSource_Updated">
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
                                        <asp:ControlParameter ControlID="VolunteerOverviewGridView" Name="Id" PropertyName="SelectedValue" Type="Int32" />
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
            <div class="tab-pane fade" id="month">
                <%--Month Row--%>
                <div class="row">
                    <div class="col">
                        <br />
                        <asp:GridView ID="VolunteerMonthGridView" runat="server" AutoGenerateColumns="False" DataSourceID="VolunteerMonthDataSource" CssClass="table table-hover" GridLines="None">
                            <Columns>
                                <asp:BoundField DataField="TimeIn" HeaderText="Date" SortExpression="TimeIn" DataFormatString="{0:m}" />
                                <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                                <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" />
                                <asp:BoundField DataField="Phone" HeaderText="Phone" SortExpression="Phone" />
                                <asp:BoundField DataField="TimeIn" DataFormatString="{0:t}" HeaderText="In" SortExpression="TimeIn" />
                                <asp:BoundField DataField="TimeOut" HeaderText="Out" SortExpression="TimeOut" DataFormatString="{0:t}" />
                                <asp:BoundField DataField="Hours" HeaderText="Hours" ReadOnly="True" SortExpression="Hours" />
                            </Columns>
                            <HeaderStyle CssClass="table-info" />
                            <RowStyle CssClass="table-light" />
                        </asp:GridView>
                        <asp:SqlDataSource ID="VolunteerMonthDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:BHDBConnectionString %>" SelectCommand="SelectVolunteerShifts" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:SessionParameter Name="Month" SessionField="Month" Type="String" />
                                <asp:SessionParameter Name="Year" SessionField="Year" Type="String" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col">
                                        
            </div>
        </div>
    </div>
</asp:Content>
