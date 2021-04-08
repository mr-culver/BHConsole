<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="VolunteerOverview.aspx.cs" Inherits="BHConsole_v2.Administration.VolunteerOverview" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="../Scripts/jquery-3.5.1.min.js"></script>
    <script src="../Scripts/bootstrap.min.js"></script>
    <script src="../Scripts/jquery.mask.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container" >
        <br />
        <h3>Volunteer Overview</h3>
        <hr />
        <div class="alert alert-dismissible alert-info">
            <%--<strong>Hello!</strong> This is an example placeholder, maybe information could be displayed based on certain criteria, or links displayed like <a href="#" class="alert-link">this one here</a>.--%>
            <div class="row">
                <div class="col col-lg-6 col-md-12">
                    <asp:Label ID="lbl_datetimeVolunteer" runat="server" Text="" Font-Size="XX-Large"></asp:Label>
                </div>
                <div class="col col-lg-6 col-md-12">
                    <%--<asp:Label ID="lbl_volunteerHours" runat="server" Text="" Font-Size="XX-Large"></asp:Label>--%>
                    <asp:FormView ID="FormView1" runat="server" DataSourceID="VolunteerHoursDataSource" CssClass="container-fluid">
                        <EditItemTemplate>
                            MonthHours:
                            <asp:TextBox ID="MonthHoursTextBox" runat="server" Text='<%# Bind("MonthHours") %>' />
                            <br />
                            <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" Text="Update" />
                            &nbsp;<asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            MonthHours:
                            <asp:TextBox ID="MonthHoursTextBox" runat="server" Text='<%# Bind("MonthHours") %>' />
                            <br />
                            <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="Insert" />
                            &nbsp;<asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
                        </InsertItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label1" runat="server" Text="Volunteer Hours: " Font-Size="XX-Large"></asp:Label>
                            <asp:Label ID="MonthHoursLabel" runat="server" Text='<%# Bind("MonthHours") %>' Font-Size="XX-Large" />
                            <br />

                        </ItemTemplate>
                    </asp:FormView>
                    <asp:SqlDataSource ID="VolunteerHoursDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:BHDBConnectionString %>" SelectCommand="SelectVolunteerHours" SelectCommandType="StoredProcedure">
                        <SelectParameters>
                            <asp:SessionParameter Name="Month" SessionField="Month" Type="Int32" />
                            <asp:SessionParameter Name="Year" SessionField="Year" Type="Int32" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </div>
            </div>
            
        </div>
        <hr />
        <div class="row">
            <div class="col col-lg-5 col-md-12 col-sm-12">
                <asp:Label ID="lbl_volunteerMonthYear" runat="server" Text="Change Date" CssClass="text-body" ></asp:Label>
                <div class="input-group">
                    <asp:TextBox ID="txt_volunteerMonthYear" runat="server" CssClass="form-control" TextMode="Month" OnTextChanged="txt_volunteerMonthYear_TextChanged" AutoPostBack="true"></asp:TextBox>
                </div>
            </div>
            <div class="col col-lg-7 col-md-12 col-sm-12">
                <br />
                <asp:Label ID="lbl_error" runat="server" Text="Label" CssClass="test-danger"></asp:Label>
            </div>
        </div>
        <div class="row">
            <div class="col col-lg-5 col-md-12 col-sm-12">
                <br />
                <asp:GridView ID="VolunteerOverviewGridView" runat="server" CssClass="table table-hover" AutoGenerateColumns="False" DataSourceID="VolunteerOverviewDataSource" EmptyDataText="No items to display" DataKeyNames="Id" HeaderStyle-CssClass="table-info" AllowPaging="True" GridLines="None" RowStyle-CssClass="table-light" ShowHeaderWhenEmpty="True">
                    <Columns>
                        <asp:BoundField DataField="TimeIn" HeaderText="Date" SortExpression="TimeIn" DataFormatString="{0:m}"  />
                        <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                        <asp:BoundField DataField="Hours" HeaderText="Hours" ReadOnly="True" SortExpression="Hours" />
                        <asp:CommandField ShowSelectButton="True" />
                    </Columns>
                    <HeaderStyle CssClass="table-info"></HeaderStyle>
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
            <div class="col col-lg-7 col-md-12 col-sm-12">
                <br />
                <div class="card border-info mb-2">
                    <div class="card-header">Detail View</div>
                    <div class="card-body">
                        <asp:FormView ID="VolunteerOverviewFormView" runat="server" DataKeyNames="Id" DataSourceID="VolunteerOverviewDetailDataSource" EmptyDataText="Nothing has been selected">
                            <EditItemTemplate>
                                Name:
                                <asp:TextBox ID="NameTextBox" runat="server" Text='<%# Bind("Name") %>'  CssClass="form-control"/>
                                <br />
                                Email:
                                <asp:TextBox ID="EmailTextBox" runat="server" Text='<%# Bind("Email") %>'  CssClass="form-control"/>
                                <br />
                                Phone:
                                <asp:TextBox ID="PhoneTextBox" runat="server" Text='<%# Bind("Phone") %>'  CssClass="form-control"/>
                                <hr />
                                TimeIn:
                                <asp:TextBox ID="TimeInTextBox" runat="server" Text='<%# Bind("TimeIn") %>'  CssClass="form-control"/>
                                <br />
                                TimeOut:
                                <asp:TextBox ID="TimeOutTextBox" runat="server" Text='<%# Bind("TimeOut") %>'  CssClass="form-control"/>
                                <br />
                                Hours:
                                <asp:TextBox ID="HoursTextBox" runat="server" Text='<%# Bind("Hours") %>'  CssClass="form-control" TextMode="Number"/>
                                <br />
                                <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" Text="Update" />
                                &nbsp;<asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
                            </EditItemTemplate>
                            <InsertItemTemplate>
                                Name:
                                <asp:TextBox ID="NameTextBox" runat="server" Text='<%# Bind("Name") %>'  CssClass="form-control"/>
                                <br />
                                Email:
                                <asp:TextBox ID="EmailTextBox" runat="server" Text='<%# Bind("Email") %>'  CssClass="form-control"/>
                                <br />
                                Phone:
                                <asp:TextBox ID="PhoneTextBox" runat="server" Text='<%# Bind("Phone") %>'  CssClass="form-control"/>
                                <hr />
                                TimeIn:
                                <asp:TextBox ID="TimeInTextBox" runat="server" Text='<%# Bind("TimeIn") %>'  CssClass="form-control" TextMode="DateTimeLocal" />
                                <br />
                                TimeOut:
                                <asp:TextBox ID="TimeOutTextBox" runat="server" Text='<%# Bind("TimeOut") %>'  CssClass="form-control" TextMode="DateTimeLocal"/>
                                <br />
                                Hours:
                                <asp:TextBox ID="HoursTextBox" runat="server" Text='<%# Bind("Hours") %>'  CssClass="form-control" TextMode="Number"/>
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
                                <hr />
                                Time In:
                                <asp:Label ID="TimeInLabel" runat="server" Text='<%# Bind("TimeIn", "{0:f}") %>' />
                                <br />
                                Time Out:
                                <asp:Label ID="TimeOutLabel" runat="server" Text='<%# Bind("TimeOut", "{0:f}") %>' />
                                <br />
                                Hours:
                                <asp:Label ID="HoursLabel" runat="server" Text='<%# Bind("Hours") %>' />
                                <br />
                                <asp:LinkButton ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit" />
                                &nbsp;<asp:LinkButton ID="DeleteButton" runat="server" CausesValidation="False" CommandName="Delete" Text="Delete" />
                                &nbsp;<asp:LinkButton ID="NewButton" runat="server" CausesValidation="False" CommandName="New" Text="New" />

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
        <div class="row">
            <div class="col">
                                        
            </div>
        </div>
    </div>
</asp:Content>
