<%@ Page Title="Admin" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Administrator.aspx.cs" Inherits="BHConsole_v2.Administration.Administrator" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="../Scripts/jquery-3.5.1.js"></script>
    <script src="../Scripts/bootstrap.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
        <br />
        <h3>Admin Dashboard</h3>
        <asp:Label ID="lbl_time" runat="server" Text="" Visible="False"></asp:Label>
        <hr />
        <div class="row">
            <div class="col">
                <div class="card border-primary mb-3">
                    <div class="card-header">Clocked In</div>
                    <div class="card-body">
                        <asp:GridView ID="ClockedInGridview" runat="server" AutoGenerateColumns="False" CssClass="table table-hover" DataKeyNames="Id" DataSourceID="ClockedInDataSource" GridLines="None" EmptyDataText="No records to display" ShowHeaderWhenEmpty="True">
                            <Columns>
                                <asp:BoundField DataField="TimeIn" HeaderText="Time In" SortExpression="TimeIn" DataFormatString="{0:g}" />
                                <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                                <asp:BoundField DataField="Shift Length" HeaderText="Shift" ReadOnly="True" SortExpression="Shift Length" />
                                <asp:CommandField ShowDeleteButton="True" />
                            </Columns>
                            <HeaderStyle CssClass="table-primary" />
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
                        <br />
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
            <div class="col">
                <div class="card border-success mb-3">
                    <div class="card-header">Shoppers</div>
                    <div class="card-body">
                        <asp:ListView ID="ListView1" runat="server" DataSourceID="ShopperVisitDataSource">
                            <AlternatingItemTemplate>
                                <span style="">Date:
                                <asp:Label ID="DateLabel" runat="server" Text='<%# Eval("Date") %>' />
                                <br />
                                Name:
                                <asp:Label ID="NameLabel" runat="server" Text='<%# Eval("Name") %>' />
                                <br />
                                Email:
                                <asp:Label ID="EmailLabel" runat="server" Text='<%# Eval("Email") %>' />
                                <br />
                                Phone:
                                <asp:Label ID="PhoneLabel" runat="server" Text='<%# Eval("Phone") %>' />
                                <br />
                                Address:
                                <asp:Label ID="AddressLabel" runat="server" Text='<%# Eval("Address") %>' />
                                <br />
                                <asp:CheckBox ID="First_VisitCheckBox" runat="server" Checked='<%# Eval("[First Visit]") %>' Enabled="false" Text="First Visit" />
                                <br />
                                Children:
                                <asp:Label ID="ChildrenLabel" runat="server" Text='<%# Eval("Children") %>' />
                                <br />
                                Case Worker:
                                <asp:Label ID="Case_WorkerLabel" runat="server" Text='<%# Eval("[Case Worker]") %>' />
                                <br />
                                Relation:
                                <asp:Label ID="RelationLabel" runat="server" Text='<%# Eval("Relation") %>' />
                                <br />
                                Description:
                                <asp:Label ID="DescriptionLabel" runat="server" Text='<%# Eval("Description") %>' />
                                <br />
<br /></span>
                            </AlternatingItemTemplate>
                            <EditItemTemplate>
                                <span style="">Date:
                                <asp:TextBox ID="DateTextBox" runat="server" Text='<%# Bind("Date") %>' />
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
                                Address:
                                <asp:TextBox ID="AddressTextBox" runat="server" Text='<%# Bind("Address") %>' />
                                <br />
                                <asp:CheckBox ID="First_VisitCheckBox" runat="server" Checked='<%# Bind("[First Visit]") %>' Text="First Visit" />
                                <br />
                                Children:
                                <asp:TextBox ID="ChildrenTextBox" runat="server" Text='<%# Bind("Children") %>' />
                                <br />
                                Case Worker:
                                <asp:TextBox ID="Case_WorkerTextBox" runat="server" Text='<%# Bind("[Case Worker]") %>' />
                                <br />
                                Relation:
                                <asp:TextBox ID="RelationTextBox" runat="server" Text='<%# Bind("Relation") %>' />
                                <br />
                                Description:
                                <asp:TextBox ID="DescriptionTextBox" runat="server" Text='<%# Bind("Description") %>' />
                                <br />
                                <asp:Button ID="UpdateButton" runat="server" CommandName="Update" Text="Update" />
                                <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancel" />
                                <br /><br /></span>
                            </EditItemTemplate>
                            <EmptyDataTemplate>
                                <span>No data was returned.</span>
                            </EmptyDataTemplate>
                            <InsertItemTemplate>
                                <span style="">Date:
                                <asp:TextBox ID="DateTextBox" runat="server" Text='<%# Bind("Date") %>' />
                                <br />Name:
                                <asp:TextBox ID="NameTextBox" runat="server" Text='<%# Bind("Name") %>' />
                                <br />Email:
                                <asp:TextBox ID="EmailTextBox" runat="server" Text='<%# Bind("Email") %>' />
                                <br />Phone:
                                <asp:TextBox ID="PhoneTextBox" runat="server" Text='<%# Bind("Phone") %>' />
                                <br />Address:
                                <asp:TextBox ID="AddressTextBox" runat="server" Text='<%# Bind("Address") %>' />
                                <br />
                                <asp:CheckBox ID="First_VisitCheckBox" runat="server" Checked='<%# Bind("[First Visit]") %>' Text="First Visit" />
                                <br />Children:
                                <asp:TextBox ID="ChildrenTextBox" runat="server" Text='<%# Bind("Children") %>' />
                                <br />Case Worker:
                                <asp:TextBox ID="Case_WorkerTextBox" runat="server" Text='<%# Bind("[Case Worker]") %>' />
                                <br />Relation:
                                <asp:TextBox ID="RelationTextBox" runat="server" Text='<%# Bind("Relation") %>' />
                                <br />Description:
                                <asp:TextBox ID="DescriptionTextBox" runat="server" Text='<%# Bind("Description") %>' />
                                <br />
                                <asp:Button ID="InsertButton" runat="server" CommandName="Insert" Text="Insert" />
                                <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Clear" />
                                <br /><br /></span>
                            </InsertItemTemplate>
                            <ItemTemplate>
                                <span style="">Date:
                                <asp:Label ID="DateLabel" runat="server" Text='<%# Eval("Date") %>' />
                                <br />
                                Name:
                                <asp:Label ID="NameLabel" runat="server" Text='<%# Eval("Name") %>' />
                                <br />
                                Email:
                                <asp:Label ID="EmailLabel" runat="server" Text='<%# Eval("Email") %>' />
                                <br />
                                Phone:
                                <asp:Label ID="PhoneLabel" runat="server" Text='<%# Eval("Phone") %>' />
                                <br />
                                Address:
                                <asp:Label ID="AddressLabel" runat="server" Text='<%# Eval("Address") %>' />
                                <br />
                                <asp:CheckBox ID="First_VisitCheckBox" runat="server" Checked='<%# Eval("[First Visit]") %>' Enabled="false" Text="First Visit" />
                                <br />
                                Children:
                                <asp:Label ID="ChildrenLabel" runat="server" Text='<%# Eval("Children") %>' />
                                <br />
                                Case Worker:
                                <asp:Label ID="Case_WorkerLabel" runat="server" Text='<%# Eval("[Case Worker]") %>' />
                                <br />
                                Relation:
                                <asp:Label ID="RelationLabel" runat="server" Text='<%# Eval("Relation") %>' />
                                <br />
                                Description:
                                <asp:Label ID="DescriptionLabel" runat="server" Text='<%# Eval("Description") %>' />
                                <br />
<br /></span>
                            </ItemTemplate>
                            <LayoutTemplate>
                                <div id="itemPlaceholderContainer" runat="server" style="">
                                    <span runat="server" id="itemPlaceholder" />
                                </div>
                                <div style="">
                                    <asp:DataPager ID="DataPager1" runat="server">
                                        <Fields>
                                            <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False" />
                                            <asp:NumericPagerField />
                                            <asp:NextPreviousPagerField ButtonType="Button" ShowLastPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False" />
                                        </Fields>
                                    </asp:DataPager>
                                </div>
                            </LayoutTemplate>
                            <SelectedItemTemplate>
                                <span style="">Date:
                                <asp:Label ID="DateLabel" runat="server" Text='<%# Eval("Date") %>' />
                                <br />
                                Name:
                                <asp:Label ID="NameLabel" runat="server" Text='<%# Eval("Name") %>' />
                                <br />
                                Email:
                                <asp:Label ID="EmailLabel" runat="server" Text='<%# Eval("Email") %>' />
                                <br />
                                Phone:
                                <asp:Label ID="PhoneLabel" runat="server" Text='<%# Eval("Phone") %>' />
                                <br />
                                Address:
                                <asp:Label ID="AddressLabel" runat="server" Text='<%# Eval("Address") %>' />
                                <br />
                                <asp:CheckBox ID="First_VisitCheckBox" runat="server" Checked='<%# Eval("[First Visit]") %>' Enabled="false" Text="First Visit" />
                                <br />
                                Children:
                                <asp:Label ID="ChildrenLabel" runat="server" Text='<%# Eval("Children") %>' />
                                <br />
                                Case Worker:
                                <asp:Label ID="Case_WorkerLabel" runat="server" Text='<%# Eval("[Case Worker]") %>' />
                                <br />
                                Relation:
                                <asp:Label ID="RelationLabel" runat="server" Text='<%# Eval("Relation") %>' />
                                <br />
                                Description:
                                <asp:Label ID="DescriptionLabel" runat="server" Text='<%# Eval("Description") %>' />
                                <br />
<br /></span>
                            </SelectedItemTemplate>
                        </asp:ListView>
                        <asp:SqlDataSource ID="ShopperVisitDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:BHDBConnectionString %>" SelectCommand="SelectShopperVisitsDay" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:SessionParameter Name="Day" SessionField="Day" Type="Int32" />
                                <asp:SessionParameter Name="Month" SessionField="Month" Type="Int32" />
                                <asp:SessionParameter Name="Year" SessionField="Year" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col">
                <%--Tabs--%>
                <ul class="nav nav-tabs">
                    <li class="nav-item">
                        <a class="nav-link active" data-toggle="tab" href="#home">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" data-toggle="tab" href="#profile">Profile</a>
                    </li>
                </ul>
                <div id="myTabContent" class="tab-content">
                    <div class="tab-pane fade show active" id="home">
                        <p>Raw denim you probably haven't heard of them jean shorts Austin. Nesciunt tofu stumptown aliqua, retro synth master cleanse. Mustache cliche tempor, williamsburg carles vegan helvetica. Reprehenderit butcher retro keffiyeh dreamcatcher synth. Cosby sweater eu banh mi, qui irure terry richardson ex squid. Aliquip placeat salvia cillum iphone. Seitan aliquip quis cardigan american apparel, butcher voluptate nisi qui.</p>
                    </div>
                    <div class="tab-pane fade" id="profile">
                        <p>Food truck fixie locavore, accusamus mcsweeney's marfa nulla single-origin coffee squid. Exercitation +1 labore velit, blog sartorial PBR leggings next level wes anderson artisan four loko farm-to-table craft beer twee. Qui photo booth letterpress, commodo enim craft beer mlkshk aliquip jean shorts ullamco ad vinyl cillum PBR. Homo nostrud organic, assumenda labore aesthetic magna delectus mollit.</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
