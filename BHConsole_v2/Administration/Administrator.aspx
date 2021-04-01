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
                <asp:Label ID="lbl_time" runat="server" Text="" Visible="False"></asp:Label>
                <asp:Label ID="lbl_error" runat="server" Text="" CssClass="text-danger"></asp:Label>
                <%--Overview--%>
                <ul class="nav nav-tabs">
                    <li class="nav-item">
                        <a class="nav-link text-info active" data-toggle="tab" href="#volunteers">Volunteers</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link text-info" data-toggle="tab" href="#shoppers">Shoppers</a>
                    </li>
                </ul>
                <div id="myTabContent" class="tab-content">
                    <%--Volunteer Overview--%>
                    <div class="tab-pane fade active show" id="volunteers">
                        <br />
                        <h4>Manage Volunteers</h4>
                        <hr />
                        <div class="alert alert-dismissible alert-info">
                            <strong>Hello!</strong> This is an example placeholder, maybe information could be displayed based on certain criteria, or links displayed like <a href="#" class="alert-link">this one here</a>.
                        </div>
                        <hr />
                        <%--<asp:SqlDataSource ID="" runat="server" ConnectionString="<%$ ConnectionStrings:BHDBConnectionString %>" SelectCommand="SELECT [Id], [Name] FROM [VolunteerTimepunch] WHERE ([TimeOut] IS NULL) ORDER BY [TimeIn]">--%>
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
                            <%--</asp:SqlDataSource>--%>
                            <div class="tab-pane fade show active" id="overview">
                                <br />
                                <div class="row">
                                    <div class="col col-lg-5 col-md-12 col-sm-12">
                                        <asp:Label ID="lbl_volunteerMonthYear" runat="server" Text="Month/Year" CssClass="text-body" ></asp:Label>
                                        <div class="input-group">
                                            <asp:TextBox ID="txt_volunteerMonthYear" runat="server" CssClass="form-control" TextMode="Month" OnTextChanged="txt_volunteerMonthYear_TextChanged" AutoPostBack="true"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="col col-lg-7 col-md-12 col-sm-12">
                                        <br />
                                        <asp:Label ID="lbl_datetimeVolunteer" runat="server" Text="" CssClass="text-primary" Font-Bold="True" Font-Size="Larger"></asp:Label>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col col-lg-5 col-md-12 col-sm-12">
                                        <br />
                                        <asp:GridView ID="VolunteerOverview" runat="server" CssClass="table table-hover" AutoGenerateColumns="False" DataSourceID="VolunteerOverviewDataSource" EmptyDataText="No items to display" DataKeyNames="Id" HeaderStyle-CssClass="table-info" AllowPaging="True" GridLines="None" RowStyle-CssClass="table-light" ShowHeaderWhenEmpty="True">
                                            <Columns>
                                                <asp:BoundField DataField="TimeIn" HeaderText="Date" SortExpression="TimeIn" DataFormatString="{0:m}"  />
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
                                    <div class="col col-lg-7 col-md-12 col-sm-12">
                                        <br />
                                        <div class="card border-info mb-2">
                                            <div class="card-header">Detail View</div>
                                            <div class="card-body">
                                                <asp:FormView ID="VolunteerOverviewFormView" runat="server" DataKeyNames="Id" DataSourceID="VolunteerOverviewDetailDataSource" EmptyDataText="Nothing has been selected">
                                                    <EditItemTemplate>
                                                        Id:
                                                        <asp:Label ID="IdLabel1" runat="server" Text='<%# Eval("Id") %>' />
                                                        <br />
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
                                                        Hours:
                                                        <asp:TextBox ID="HoursTextBox" runat="server" Text='<%# Bind("Hours") %>' />
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
                                                        Hours:
                                                        <asp:TextBox ID="HoursTextBox" runat="server" Text='<%# Bind("Hours") %>' />
                                                        <br />
                                                        <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="Insert" />
                                                        &nbsp;<asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
                                                    </InsertItemTemplate>
                                                    <ItemTemplate>
                                                        Id:
                                                        <asp:Label ID="IdLabel" runat="server" Text='<%# Eval("Id") %>' />
                                                        <br />
                                                        Name:
                                                        <asp:Label ID="NameLabel" runat="server" Text='<%# Bind("Name") %>' />
                                                        <br />
                                                        Email:
                                                        <asp:Label ID="EmailLabel" runat="server" Text='<%# Bind("Email") %>' />
                                                        <br />
                                                        Phone:
                                                        <asp:Label ID="PhoneLabel" runat="server" Text='<%# Bind("Phone") %>' />
                                                        <br />
                                                        TimeIn:
                                                        <asp:Label ID="TimeInLabel" runat="server" Text='<%# Bind("TimeIn") %>' />
                                                        <br />
                                                        TimeOut:
                                                        <asp:Label ID="TimeOutLabel" runat="server" Text='<%# Bind("TimeOut") %>' />
                                                        <br />
                                                        Hours:
                                                        <asp:Label ID="HoursLabel" runat="server" Text='<%# Bind("Hours") %>' />
                                                        <br />
                                                        <asp:LinkButton ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit" />
                                                        &nbsp;<asp:LinkButton ID="DeleteButton" runat="server" CausesValidation="False" CommandName="Delete" Text="Delete" />
                                                        &nbsp;<asp:LinkButton ID="NewButton" runat="server" CausesValidation="False" CommandName="New" Text="New" />

                                                    </ItemTemplate>
                                                </asp:FormView>
                                                <asp:SqlDataSource ID="VolunteerOverviewDetailDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:BHDBConnectionString %>" DeleteCommand="DELETE FROM [VolunteerTimepunch] WHERE [Id] = @Id" InsertCommand="INSERT INTO [VolunteerTimepunch] ([Name], [Email], [Phone], [TimeIn], [TimeOut]) VALUES (@Name, @Email, @Phone, @TimeIn, @TimeOut)" SelectCommand="SelectVolunteerDetails" UpdateCommand="UPDATE [VolunteerTimepunch] SET [Name] = @Name, [Email] = @Email, [Phone] = @Phone, [TimeIn] = @TimeIn, [TimeOut] = @TimeOut WHERE [Id] = @Id" SelectCommandType="StoredProcedure">
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
                                <div class="row">
                                    <div class="col">
                                        
                                    </div>
                                </div>
                            </div>

                            <div class="tab-pane fade" id="clockedin">
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

                            <div class="tab-pane fade" id="export">
                                
                            </div>
                        </div>
                    </div>
                    <%--Shopper tab--%>
                    <div class="tab-pane fade" id="shoppers">
                        <%--Shopper tab--%>
                                            <br />
                                            <h4>Shopper Overview</h4>
                                            <hr />
                                            <ul class="nav nav-tabs">
                                                <li class="nav-item">
                                                    <a class="nav-link text-info active" data-toggle="tab" href="#shopperVisits">Visits</a>
                                                </li>
                                                <li class="nav-item">
                                                    <a class="nav-link text-info" data-toggle="tab" href="#shopperOverview">Overview</a>
                                                </li>
                                                <li class="nav-item">
                                                    <a class="nav-link text-info disabled" href="#exportShopper">Export Data</a>
                                                </li>
                                            </ul>
                                            <div class="tab-content" id="shopperTabContent">
                                                <div class="tab-pane fade show active" id="shopperVisits">
                                                    <br />
                                                    <div class="row">
                                                        <div class="col col-lg-6 col-md-12 col-sm-12">
                                                            <asp:Label ID="Label1" runat="server" Text="Month/Year" CssClass="text-body" ></asp:Label>
                                                            <div class="input-group">
                                                                <asp:TextBox ID="txt_shopperMonthYear" runat="server" CssClass="form-control" TextMode="Date" OnTextChanged="txt_shopperMonthYear_TextChanged" AutoPostBack="true"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                        <div class="col col-lg-6 col-md-12 col-sm-12">
                                                            <br />
                                                            <asp:Label ID="lbl_datetimeShopper" runat="server" Text="" CssClass="text-primary" Font-Bold="True" Font-Size="Larger"></asp:Label>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col col-lg-6 col-md-12 col-sm-12">
                                                            <br />
                                                            <asp:GridView ID="VisitGridView" runat="server" AllowPaging="True" AutoGenerateColumns="False" CssClass="table table-hover" DataKeyNames="Id,ShopperId" DataSourceID="VisitDataSource" GridLines="None">
                                                                <Columns>
                                                                    <asp:BoundField DataField="Timestamp" DataFormatString="{0:m}" HeaderText="Date" SortExpression="Timestamp" />
                                                                    <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                                                                    <asp:CheckBoxField DataField="FirstVisit" HeaderText="First Visit" SortExpression="FirstVisit" />
                                                                    <asp:CommandField ShowSelectButton="True" />
                                                                </Columns>
                                                                <HeaderStyle CssClass="table-info" />
                                                                <RowStyle CssClass="table-light" />
                                                                <SelectedRowStyle CssClass="table-success" />
                                                            </asp:GridView>
                                                            <asp:SqlDataSource ID="VisitDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:BHDBConnectionString %>" SelectCommand="SelectShopperVisits" SelectCommandType="StoredProcedure">
                                                                <SelectParameters>
                                                                    <asp:SessionParameter Name="Day" SessionField="Day" Type="Int32" />
                                                                    <asp:SessionParameter Name="Month" SessionField="Month" Type="Int32" />
                                                                    <asp:SessionParameter Name="Year" SessionField="Year" Type="Int32" />
                                                                </SelectParameters>
                                                            </asp:SqlDataSource>
                                                        </div>
                                                        <div class="col col-lg-6 col-md-12 col-sm-12">
                                                            <br />
                                                            <div class="card border-info mb-2">
                                                                <div class="card-header">Detail View</div>
                                                                <div class="card-body">
                                                                    <asp:FormView ID="VisitDetailsFormView" runat="server" DataKeyNames="Id,VisitId" DataSourceID="VisitDetailsDataSource" EmptyDataText="Select an item to display it here." CssClass="container-fluid">
                                                                        <EditItemTemplate>
                                                                            <div class="form-group">
                                                                                <label for="txt_name"><strong>Name</strong></label><asp:Label ID="Label1" runat="server" Text=" * " CssClass="text-danger"></asp:Label>
                                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Required Field" ControlToValidate="txt_name" CssClass="text-danger"></asp:RequiredFieldValidator>
                                                                                <asp:TextBox ID="txt_name" class="form-control" runat="server" Text='<%# Bind("Name") %>' ></asp:TextBox>
                                                                            </div>
                                                                            <div class="form-group">
                                                                                <label for="txt_email"><strong>Email</strong></label><asp:Label ID="Label2" runat="server" Text=" * " CssClass="text-danger"></asp:Label>
                                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Required Field" ControlToValidate="txt_email" CssClass="text-danger"></asp:RequiredFieldValidator>
                                                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="RegularExpressionValidator" ControlToValidate="txt_email" Text=" Invalid Email Format" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" CssClass="text-danger"></asp:RegularExpressionValidator>                              
                                                                                <asp:TextBox ID="txt_email" runat="server" CssClass="form-control" Text='<%# Bind("Email") %>' ></asp:TextBox>
                                                                            </div>
                                                                            <div class="form-group">
                                                                                <label for="txt_phone"><strong>Phone Number</strong></label>
                                                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ErrorMessage="RegularExpressionValidator" ControlToValidate="txt_phone" CssClass="text-danger" ValidationExpression="^\(\d{3}\)\s\d{3}-\d{4}" Text=" Invalid Phone Number"></asp:RegularExpressionValidator>
                                                                                <asp:TextBox ID="txt_phone" ClientIDMode="Static" CssClass="form-control" runat="server" Text='<%# Bind("Phone") %>' ></asp:TextBox>
                                                                                <script type="text/javascript">
                                                                                    jQuery(function ($) {
                                                                                        $("#txt_phone").mask("(999) 999-9999", { placeholder: "(###) ###-####" });
                                                                                    });
                                                                                </script>
                                                                            </div>
                                                                            <div class="form-group">
                                                                                <label for="txt_address"><strong>Address</strong></label>
                                                                                <asp:TextBox ID="txt_address" class="form-control" runat="server" Text='<%# Bind("Address") %>'></asp:TextBox>
                                                                            </div>
                                                                            <hr />
                                                                            <div class="form-group">
                                                                                <label><strong>First Time Visiting</strong></label><asp:Label ID="Label3" runat="server" Text=" * " CssClass="text-danger"></asp:Label>
                                                                                <br />
                                                                                <asp:CheckBox ID="FirstVisitCheckBox" runat="server" Checked='<%# Bind("FirstVisit") %>'  />
                                                                            </div>
                                                                            <div class="form-group">
                                                                                <label for="txt_numberOfChildren"><strong>Number of Cildren</strong></label><asp:Label ID="Label4" runat="server" Text=" * " CssClass="text-danger"></asp:Label>
                                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="Required Field" ControlToValidate="txt_numberOfChildren" CssClass="text-danger"></asp:RequiredFieldValidator>
                                                                                <asp:TextBox ID="txt_numberOfChildren" class="form-control" runat="server" TextMode="Number" Text='<%# Bind("NumberOfChildren") %>' ></asp:TextBox>
                                                                            </div>
                                                                            <div class="form-group">
                                                                                <label for="txt_caseWorker"><strong>Case Worker</strong><asp:Label ID="Label5" runat="server" Text=" * " CssClass="text-danger"></asp:Label>
                                                                                </label><asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ErrorMessage="Required Field" ControlToValidate="txt_caseWorker" CssClass="text-danger"></asp:RequiredFieldValidator>
                                                                                <asp:TextBox ID="txt_caseWorker" class="form-control" runat="server" Text='<%# Bind("CaseWorkerName") %>' ></asp:TextBox>
                                                                            </div>
                                                                            <div class="form-group">
                                                                                <label><strong>Relationship to Children</strong></label>
                                                                                <asp:DropDownList ID="dd_relation" runat="server" CssClass="form-control" SelectedValue='<%# Bind("RelationToChildren") %>'>
                                                                                    <asp:ListItem>Licensed Foster Parent</asp:ListItem>
                                                                                    <asp:ListItem>Relative or Kinship Placement</asp:ListItem>
                                                                                    <asp:ListItem>Caseworker</asp:ListItem>
                                                                                    <asp:ListItem>Ireland/Maglinger/Raintree</asp:ListItem>
                                                                                    <asp:ListItem>CASA</asp:ListItem>
                                                                                    <asp:ListItem>Other</asp:ListItem>
                                                                                </asp:DropDownList>
                                                                                <br />
                                                                                <label>Other Description</label>
                                                                                <asp:TextBox ID="txt_other" CssClass="form-control" runat="server" Text='<%# Bind("RelationOtherDescription") %>' TextMode="MultiLine" Rows="3"></asp:TextBox>
                                                                            </div>
                                                                            <div class="form-group">
                                                                                <label><strong>Timestamp</strong></label>
                                                                                <asp:TextBox ID="TextBox1" runat="server" CssClass="form-control" Text='<%# Bind("Timestamp") %>' TextMode="SingleLine"></asp:TextBox>
                                                                            </div>
                                                                            <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" Text="Update" />
                                                                            &nbsp;<asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
                                                                        </EditItemTemplate>
                                                                        <InsertItemTemplate>
                                                                            <div class="form-group">
                                                                                <label for="txt_name"><strong>Name</strong></label><asp:Label ID="Label1" runat="server" Text=" * " CssClass="text-danger"></asp:Label>
                                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Required Field" ControlToValidate="txt_name" CssClass="text-danger"></asp:RequiredFieldValidator>
                                                                                <asp:TextBox ID="txt_name" class="form-control" runat="server" Text='<%# Bind("Name") %>' ></asp:TextBox>
                                                                            </div>
                                                                            <div class="form-group">
                                                                                <label for="txt_email"><strong>Email</strong></label><asp:Label ID="Label2" runat="server" Text=" * " CssClass="text-danger"></asp:Label>
                                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Required Field" ControlToValidate="txt_email" CssClass="text-danger"></asp:RequiredFieldValidator>
                                                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="RegularExpressionValidator" ControlToValidate="txt_email" Text=" Invalid Email Format" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" CssClass="text-danger"></asp:RegularExpressionValidator>                              
                                                                                <asp:TextBox ID="txt_email" runat="server" CssClass="form-control" Text='<%# Bind("Email") %>' ></asp:TextBox>
                                                                            </div>
                                                                            <div class="form-group">
                                                                                <label for="txt_phone"><strong>Phone Number</strong></label>
                                                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ErrorMessage="RegularExpressionValidator" ControlToValidate="txt_phone" CssClass="text-danger" ValidationExpression="^\(\d{3}\)\s\d{3}-\d{4}" Text=" Invalid Phone Number"></asp:RegularExpressionValidator>
                                                                                <asp:TextBox ID="txt_phone" ClientIDMode="Static" CssClass="form-control" runat="server" Text='<%# Bind("Phone") %>' ></asp:TextBox>
                                                                                <script type="text/javascript">
                                                                                    jQuery(function ($) {
                                                                                        $("#txt_phone").mask("(999) 999-9999", { placeholder: "(###) ###-####" });
                                                                                    });
                                                                                </script>
                                                                            </div>
                                                                            <div class="form-group">
                                                                                <label for="txt_address"><strong>Address</strong></label>
                                                                                <asp:TextBox ID="txt_address" class="form-control" runat="server" Text='<%# Bind("Address") %>'></asp:TextBox>
                                                                            </div>
                                                                            <hr />
                                                                            <div class="form-group">
                                                                                <label><strong>First Time Visiting</strong></label><asp:Label ID="Label3" runat="server" Text=" * " CssClass="text-danger"></asp:Label>
                                                                                <br />
                                                                                <asp:CheckBox ID="FirstVisitCheckBox" runat="server" Checked='<%# Bind("FirstVisit") %>'  />
                                                                            </div>
                                                                            <div class="form-group">
                                                                                <label for="txt_numberOfChildren"><strong>Number of Cildren</strong></label><asp:Label ID="Label4" runat="server" Text=" * " CssClass="text-danger"></asp:Label>
                                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="Required Field" ControlToValidate="txt_numberOfChildren" CssClass="text-danger"></asp:RequiredFieldValidator>
                                                                                <asp:TextBox ID="txt_numberOfChildren" class="form-control" runat="server" TextMode="Number" Text='<%# Bind("NumberOfChildren") %>' ></asp:TextBox>
                                                                            </div>
                                                                            <div class="form-group">
                                                                                <label for="txt_caseWorker"><strong>Case Worker</strong><asp:Label ID="Label5" runat="server" Text=" * " CssClass="text-danger"></asp:Label>
                                                                                </label><asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ErrorMessage="Required Field" ControlToValidate="txt_caseWorker" CssClass="text-danger"></asp:RequiredFieldValidator>
                                                                                <asp:TextBox ID="txt_caseWorker" class="form-control" runat="server" Text='<%# Bind("CaseWorkerName") %>' ></asp:TextBox>
                                                                            </div>
                                                                            <div class="form-group">
                                                                                <label><strong>Relationship to Children</strong></label>
                                                                                <asp:DropDownList ID="dd_relation" runat="server" CssClass="form-control" SelectedValue='<%# Bind("RelationToChildren") %>'>
                                                                                    <asp:ListItem>Licensed Foster Parent</asp:ListItem>
                                                                                    <asp:ListItem>Relative or Kinship Placement</asp:ListItem>
                                                                                    <asp:ListItem>Caseworker</asp:ListItem>
                                                                                    <asp:ListItem>Ireland/Maglinger/Raintree</asp:ListItem>
                                                                                    <asp:ListItem>CASA</asp:ListItem>
                                                                                    <asp:ListItem>Other</asp:ListItem>
                                                                                </asp:DropDownList>
                                                                                <br />
                                                                                <label>Other Description</label>
                                                                                <asp:TextBox ID="txt_other" CssClass="form-control" runat="server" Text='<%# Bind("RelationOtherDescription") %>' TextMode="MultiLine" Rows="3"></asp:TextBox>
                                                                            </div>
                                                                            <div class="form-group">
                                                                                <label><strong>Timestamp</strong></label>
                                                                                <asp:TextBox ID="TextBox1" runat="server" CssClass="form-control" Text='<%# Bind("Timestamp") %>' TextMode="DateTimeLocal"></asp:TextBox>
                                                                            </div>
                                                                            <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="Insert" />
                                                                            &nbsp;<asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
                                                                        </InsertItemTemplate>
                                                                        <ItemTemplate>
                                                                                <label for="txt_name"><strong>Name</strong></label><asp:TextBox ID="txt_name" class="form-control" runat="server" Text='<%# Bind("Name") %>' ReadOnly="true"></asp:TextBox>
                                                                            <div class="form-group">
                                                                                <label for="txt_email"><strong>Email</strong></label><asp:TextBox ID="txt_email" runat="server" CssClass="form-control" Text='<%# Bind("Email") %>' ReadOnly="true"></asp:TextBox>
                                                                            </div>
                                                                            <div class="form-group">
                                                                                <label for="txt_phone"><strong>Phone Number</strong></label>
                                                                                <asp:TextBox ID="txt_phone" ClientIDMode="Static" CssClass="form-control" runat="server" Text='<%# Bind("Phone") %>' ReadOnly="true"></asp:TextBox>
                                                                                <script type="text/javascript">
                                                                                    jQuery(function ($) {
                                                                                        $("#txt_phone").mask("(999) 999-9999", { placeholder: "(###) ###-####" });
                                                                                    });
                                                                                </script>
                                                                            </div>
                                                                            <div class="form-group">
                                                                                <label for="txt_address"><strong>Address</strong></label>
                                                                                <asp:TextBox ID="txt_address" class="form-control" runat="server" Text='<%# Bind("Address") %>' ReadOnly="true"></asp:TextBox>
                                                                            </div>
                                                                            <hr />
                                                                            <div class="form-group">
                                                                                <label><strong>First Time Visiting</strong></label>
                                                                                <br />
                                                                                <asp:CheckBox ID="FirstVisitCheckBox" runat="server" Checked='<%# Bind("FirstVisit") %>' Enabled="false" />
                                                                            </div>
                                                                            <div class="form-group">
                                                                                <label for="txt_numberOfChildren"><strong>Number of Cildren</strong></label><asp:TextBox ID="txt_numberOfChildren" class="form-control" runat="server" TextMode="Number" Text='<%# Bind("NumberOfChildren") %>' ReadOnly="true"></asp:TextBox>
                                                                            </div>
                                                                            <div class="form-group">
                                                                                <label for="txt_caseWorker"><strong>Case Worker</strong></label><asp:TextBox ID="txt_caseWorker" class="form-control" runat="server" Text='<%# Bind("CaseWorkerName") %>' ReadOnly="true"></asp:TextBox>
                                                                            </div>
                                                                            <div class="form-group">
                                                                                <label><strong>Relationship to Children</strong></label>
                                                                                <asp:TextBox ID="txt_relation" runat="server" class="form-control" Text='<%# Bind("RelationToChildren") %>' ReadOnly="true"></asp:TextBox>
                                                                                <br />
                                                                                <label>Other Description</label>
                                                                                <asp:TextBox ID="txt_other" CssClass="form-control" runat="server" Text='<%# Bind("RelationOtherDescription") %>' ReadOnly="true" TextMode="MultiLine" Rows="3"></asp:TextBox>
                                                                            </div>
                                                                            <div class="form-group">
                                                                                <label><strong>Timestamp</strong></label>
                                                                                <asp:TextBox ID="TextBox1" runat="server" CssClass="form-control" Text='<%# Bind("Timestamp", "{0:f}") %>' ReadOnly="True"></asp:TextBox>
                                                                            </div>
                                                                            <asp:LinkButton ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit" />
                                                                            &nbsp;<asp:LinkButton ID="DeleteButton" runat="server" CausesValidation="False" CommandName="Delete" Text="Delete" />
                                                                            &nbsp;<asp:LinkButton ID="NewButton" runat="server" CausesValidation="False" CommandName="New" Text="New" />
                                                                        </ItemTemplate>
                                                                    </asp:FormView>
                                                                    <asp:SqlDataSource ID="VisitDetailsDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:BHDBConnectionString %>" DeleteCommand="DELETE FROM Visit WHERE (Id = @Id)" InsertCommand="ShopperCheckin" InsertCommandType="StoredProcedure" SelectCommand="SelectShopperVisitDetails" SelectCommandType="StoredProcedure" UpdateCommand="UpdateShopperVisit" UpdateCommandType="StoredProcedure">
                                                                        <DeleteParameters>
                                                                            <asp:Parameter Name="Id" />
                                                                        </DeleteParameters>
                                                                        <InsertParameters>
                                                                            <asp:Parameter Name="Name" Type="String" />
                                                                            <asp:Parameter Name="Email" Type="String" />
                                                                            <asp:Parameter Name="Phone" Type="String" />
                                                                            <asp:Parameter Name="Address" Type="String" />
                                                                            <asp:Parameter Name="FirstVisit" Type="Boolean" />
                                                                            <asp:Parameter Name="NumberOfChildren" Type="Byte" />
                                                                            <asp:Parameter Name="CaseWorkerName" Type="String" />
                                                                            <asp:Parameter Name="RelationToChildren" Type="String" />
                                                                            <asp:Parameter Name="RelationOtherDescription" Type="String" />
                                                                            <asp:Parameter Name="Timestamp" Type="DateTime" />
                                                                        </InsertParameters>
                                                                        <SelectParameters>
                                                                            <asp:ControlParameter ControlID="VisitGridView" Name="Id" PropertyName="SelectedValue" Type="Int32" />
                                                                        </SelectParameters>
                                                                        <UpdateParameters>
                                                                            <asp:Parameter Name="Id" />
                                                                            <asp:Parameter Name="Name" />
                                                                            <asp:Parameter Name="Email" />
                                                                            <asp:Parameter Name="Phone" />
                                                                            <asp:Parameter Name="Address" />
                                                                            <asp:Parameter Name="VisitId" Type="Int32" />
                                                                            <asp:Parameter Name="FirstVisit" />
                                                                            <asp:Parameter Name="NumberOfChildren" />
                                                                            <asp:Parameter Name="CaseWorkerName" />
                                                                            <asp:Parameter Name="RelationToChildren" />
                                                                            <asp:Parameter Name="RelationOtherDescription" />
                                                                            <asp:Parameter Name="Timestamp" />
                                                                        </UpdateParameters>
                                                                    </asp:SqlDataSource>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="tab-pane fade" id="shopperOverview">
                                                    <div class="row">
                                                        <div class="col">
                                                            <br />
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col">
                                                            <div class="bs-component">
                                                                <div class="form-group">

                                                                </div>
                                                                <div class="form-group">

                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="tab-pane fade" id="exportShopper">
                                
                                                </div>
                                            </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
