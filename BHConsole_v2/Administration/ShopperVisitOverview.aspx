<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ShopperVisitOverview.aspx.cs" Inherits="BHConsole_v2.Administration.ShopperOverview" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="../Scripts/jquery-3.5.1.min.js"></script>
    <script src="../Scripts/bootstrap.min.js"></script>
    <script src="../Scripts/jquery.mask.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
        <br />
        <h3>Shopper Visit Overview</h3>
        <hr />
        <div class="alert alert-dismissible alert-info">
            <%--<strong>Hello!</strong> This is an example placeholder, maybe information could be displayed based on certain criteria, or links displayed like <a href="#" class="alert-link">this one here</a>.--%>
            
            <div class="row">
                <div class="col col-lg-6 col-md-12">
                    <asp:Label ID="lbl_datetimeShopper" runat="server" Text="" Font-Size="XX-Large"></asp:Label>
                </div>
                <div class="col col-lg-6 col-md-12">
                    <asp:FormView ID="ChildrenServedFormView" runat="server" CssClass="container-fluid" DataSourceID="ChildrenServedDataSource">
                        <EditItemTemplate>
                            ChildrenServed:
                            <asp:TextBox ID="ChildrenServedTextBox" runat="server" Text='<%# Bind("ChildrenServed") %>' />
                            <br />
                            <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" Text="Update" />
                            &nbsp;<asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            ChildrenServed:
                            <asp:TextBox ID="ChildrenServedTextBox" runat="server" Text='<%# Bind("ChildrenServed") %>' />
                            <br />
                            <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="Insert" />
                            &nbsp;<asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
                        </InsertItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label1" runat="server" Text="Children Served: " Font-Size="XX-Large"></asp:Label>
                            <asp:Label ID="ChildrenServedLabel" runat="server" Text='<%# Bind("ChildrenServed") %>' Font-Size="XX-Large"/>
                            <br />

                        </ItemTemplate>
                    </asp:FormView>
                    <asp:SqlDataSource ID="ChildrenServedDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:BHDBConnectionString %>" SelectCommand="SelectChildrenServedDay" SelectCommandType="StoredProcedure">
                        <SelectParameters>
                            <asp:SessionParameter Name="Day" SessionField="Day" Type="Int32" />
                            <asp:SessionParameter Name="Month" SessionField="Month" Type="Int32" />
                            <asp:SessionParameter Name="Year" SessionField="Year" Type="Int32" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </div>
            </div>
        </div>
        <hr />
        <div class="row">
            <div class="col col-lg-6 col-md-12 col-sm-12">
                <asp:Label ID="Label1" runat="server" Text="Month/Year" CssClass="text-body" ></asp:Label>
                <div class="input-group">
                    <asp:TextBox ID="txt_shopperMonthYear" runat="server" CssClass="form-control" TextMode="Date" OnTextChanged="txt_shopperMonthYear_TextChanged" AutoPostBack="true"></asp:TextBox>
                </div>
            </div>
            <div class="col col-lg-6 col-md-12 col-sm-12">
                <br />
                <div class="row">
                    <div class="col">
                        <asp:Button ID="btn_exportMonth" runat="server" Text="Export Month" CssClass="btn btn-primary btn-block " OnClick="btn_exportMonth_Click" />
                    </div>
                    <div class="col">
                        <asp:Button ID="btn_exportDay" runat="server" Text="Export Day" CssClass="btn btn-primary btn-block" OnClick="btn_exportDay_Click" />
                    </div>
                </div>
                
                <asp:Label ID="lbl_error" runat="server" Text="Label" CssClass="test-danger"></asp:Label>
            </div>
        </div>
        <div class="row">
            <div class="col col-lg-6 col-md-12 col-sm-12">
                <br />
                <asp:GridView ID="VisitGridView" runat="server" AllowPaging="True" AutoGenerateColumns="False" CssClass="table table-hover" DataKeyNames="Id,ShopperId" DataSourceID="VisitDataSource" GridLines="None" EmptyDataText="No visits" ShowHeaderWhenEmpty="true">
                    <Columns>
                        <asp:BoundField DataField="Timestamp" DataFormatString="{0:m}" HeaderText="Date" SortExpression="Timestamp" />
                        <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                        <asp:BoundField DataField="NumberOfChildren" HeaderText="Children" SortExpression="NumberOfChildren" />
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
                                <div class="form-group">
                                    <label for="txt_name"><strong>Name</strong></label><asp:TextBox ID="txt_name" class="form-control" runat="server" Text='<%# Bind("Name") %>' ReadOnly="true"></asp:TextBox>
                                </div>
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
</asp:Content>
