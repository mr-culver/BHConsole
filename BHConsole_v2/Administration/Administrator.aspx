<%@ Page Title="Admin" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Administrator.aspx.cs" Inherits="BHConsole_v2.Administration.Administrator" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="../Scripts/jquery-3.5.1.js"></script>
    <script src="../Scripts/bootstrap.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
        <br />
        <h2 class="display-4">Administrator Dashboard</h2>
        <asp:Label ID="lbl_time" runat="server" Text="" Visible="False"></asp:Label>
        <hr />
        <div class="row">
            <div class="col">
                <h2>This Month</h2>
                <asp:Label ID="Label11" CssClass="h5" runat="server" Text="Shoppers: "></asp:Label>
                <asp:Label ID="lbl_shoppersMonth" CssClass="h5 text-info" runat="server" Text=""></asp:Label>
                <br />
                <asp:Label ID="Label12" CssClass="h5" runat="server" Text="Children served: "></asp:Label>
                <asp:Label ID="lbl_childrenMonth" CssClass="h5 text-info" runat="server" Text=""></asp:Label>
                <br />
                <asp:Label ID="Label13" CssClass="h5" runat="server" Text="Volunteers: "></asp:Label>
                <asp:Label ID="lbl_volunteersMonth" CssClass="h5 text-info" runat="server" Text=""></asp:Label>
                <br />
                <asp:Label ID="Label14" CssClass="h5" runat="server" Text="Hours: "></asp:Label>
                <asp:Label ID="lbl_volunteerHours" CssClass="h5 text-info" runat="server" Text=""></asp:Label>
            </div>
        </div>
        <hr />
        <div class="row">
            <div class="col col-lg-6 col-md-12">
                <div class="card border-primary mb-3">
                    <div class="card-header">Clocked In Volunteers</div>
                    <div class="card-body">
                        <asp:GridView ID="ClockedInGridview" runat="server" AutoGenerateColumns="False" CssClass="table table-hover" DataKeyNames="Id" DataSourceID="ClockedInDataSource" GridLines="None" EmptyDataText="No records to display" ShowHeaderWhenEmpty="True">
                            <Columns>
                                <asp:BoundField DataField="TimeIn" HeaderText="Time In" SortExpression="TimeIn" DataFormatString="{0:g}" />
                                <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
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
                        </div>
                        <div class="form-group">
                            <asp:Button ID="btn_clockout" class="btn btn-primary btn-lg btn-block" runat="server" Text="Clock Out" OnClick="btn_clockout_Click" OnClientClick="return confirm('Are you sure you want to clock out?')" />
                        </div>
                    </div>
                </div>
            </div>
            <div class="col col-lg-6 col-md-12">
                <div class="card border-success mb-3">
                    <div class="card-header">Shoppers Today: <asp:Label ID="lbl_shoppers" runat="server" Text=""></asp:Label></div>
                    <div class="card-body">
                        <asp:DataList ID="DataList1" runat="server" DataSourceID="ShopperVisitDataSource" CssClass="container-fluid">
                            <ItemTemplate>
                                <strong>Time: </strong>
                                <asp:Label ID="Label2" runat="server" Text='<%# Eval("Date", "{0:t}") %>'></asp:Label>
                                <br />
                                <strong>Name: </strong>
                                <asp:Label ID="Label3" runat="server" Text='<%# Eval("Name") %>'></asp:Label>
                                <br />
                                <strong>Email: </strong>
                                <asp:Label ID="Label1" runat="server" Text='<%# Eval("Email") %>'></asp:Label>
                                <br />
                                <strong>Phone: </strong>
                                <asp:Label ID="Label4" runat="server" Text='<%# Eval("Phone") %>'></asp:Label>
                                <br />
                                <strong>Address: </strong>
                                <asp:Label ID="Label5" runat="server" Text='<%# Eval("Address") %>'></asp:Label>
                                <br />
                                <strong>First Visit: </strong>
                                <asp:Label ID="Label6" runat="server" Text='<%# Eval("[First Visit]") %>'></asp:Label>
                                <br />
                                <strong>Children: </strong>
                                <asp:Label ID="Label7" runat="server" Text='<%# Eval("Children") %>'></asp:Label>
                                <br />
                                <strong>Case Worker: </strong>
                                <asp:Label ID="Label8" runat="server" Text='<%# Eval("[Case Worker]") %>'></asp:Label>
                                <br />
                                <strong>Relationship: </strong>
                                <asp:Label ID="Label9" runat="server" Text='<%# Eval("Relation") %>'></asp:Label>
                                <br />
                                <strong>Description: </strong>
                                <asp:Label ID="Label10" runat="server" Text='<%# Eval("Description") %>'></asp:Label>
                                <hr />
                            </ItemTemplate>
                        </asp:DataList>
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
                <%--<ul class="nav nav-tabs">
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
                </div>--%>
            </div>
        </div>
    </div>
</asp:Content>
