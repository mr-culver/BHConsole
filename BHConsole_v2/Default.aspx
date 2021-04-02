<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="BHConsole_v2.Default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="Scripts/jquery-3.5.1.min.js"></script>
    <script src="Scripts/bootstrap.min.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
            <div class="jumbotron">
                <h1 class="display-4">Welcome to Borrowed Hearts!</h1>
                <hr />
                <div class="row">
                    <div class="col-lg-6">
                        <%--<h3 class="display-4">Here to shop?</h3>--%>
                        <asp:Button ID="btn_shop" CssClass="btn btn-info btn-lg btn-block" runat="server" Text="Shopper Form" PostBackUrl="~/Shopper/ShopperCheckin.aspx" Height="100px" Font-Bold="True" Font-Size="XX-Large" />
                    </div>
                    <div class="col-lg-6">
                        <%--<h3 class="display-4">Here to volunteer?</h3>--%>
                        <asp:Button ID="btn_volunteer" CssClass="btn btn-info btn-lg btn-block" runat="server" Text="Volunteer Clock In" PostBackUrl="~/Volunteer/VolunteerClockin.aspx"  Height="100px" Font-Bold="True" Font-Size="XX-Large" />
                    </div>
                </div>
            </div>
            <br />
            <div class="row">
                <div class="col-lg-4">
                    <div class="card border-primary mb-3">
                        <div class="card-header">Mission Statement</div>
                        <div class="card-body">
                            <p class="card-text">
                                Our mission is to lead the efforts in which every foster family attains the rights to clothing, hygiene, development, and a loving support system.
                            </p>
                            <asp:Image ID="Image2" runat="server" ImageUrl="~/Images/e_for_everyone.png" CssClass="d-block user-select-none" Width="100%"/>
                        </div>
                        <%--<div class="card-body">
                            <h5 class="card-title">Thanks to our partners!</h5>
                            <ul class="list-group list-group-flush">
                                <li class="list-group-item">The Isaiah 1:17 Project</li>
                                <li class="list-group-item">Hangers</li>
                                <li class="list-group-item">St. Vincent Early Learning</li>
                                <li class="list-group-item">YMCA Boxing</li>
                                <li class="list-group-item">Hillcrest, Ozanam Shelter</li>
                                <li class="list-group-item">The Dream Center</li>
                                <li class="list-group-item">United Methodist Youth Home</li>
                                <li class="list-group-item">Teacher Locker & Granted</li>
                            </ul>
                        </div>--%>
                    </div>
                    <div class="card border-primary mb-3" draggable="false">
                        <div class="card-header">Donate with Venmo</div>
                        <div class="card-body">
                            <%--<h6 class="card-subtitle text-muted">2020 Virtual Pancake Breakfast</h6>--%>
                            <br />
                            <asp:Image ID="Image3" runat="server" ImageUrl="~/Images/bhdonateqr.jpeg" CssClass="d-block user-select-none" Width="100%" preserveAspectRatio="xMidYMid slice"/>
                        </div>
                        <div class="card-body">
                            <asp:LinkButton ID="LinkButton2" class="btn btn-info btn-block" runat="server" href="https://www.borrowedheartsfoundation.org/donate.html">More ways to donate</asp:LinkButton>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="card border-secondary mb-3" draggable="false">
                            <div class="card-header">Fundraising Events</div>
                        <div class="card-body">
                            <p class="card-text">
                                Placeholder for new event coming for 2021
                            </p>
                            <h5 class="card-title">Last year's event...</h5>
                            <%--<h6 class="card-subtitle text-muted">2020 Virtual Pancake Breakfast</h6>--%>
                            <asp:Image ID="Image1" runat="server" ImageUrl="~/Images/pancake_breakfast.png" CssClass="d-block user-select-none" Width="100%" preserveAspectRatio="xMidYMid slice"/>
                        </div>
                        <div class="card-body">
                            <asp:LinkButton ID="LinkButton1" class="btn btn-info btn-block" runat="server" href="https://www.borrowedheartsfoundation.org/fundraising-events.html">More Info</asp:LinkButton>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="card border-info mb-3" >
                        <div class="card-header">Birthday Resources!</div>
                        <div class="card-body">
                            <%--<h5 class="card-title align-content-center">Sponsors</h5>--%>
                            <asp:Image ID="img_card3_2" runat="server" CssClass="d-block user-select-none" Width="100%" preserveAspectRatio="xMidYMid slice" ImageUrl="~/Images/Gayla-Cake-Logo.png" />
                            <asp:Image ID="img_card3_1" runat="server" CssClass="d-block user-select-none" Width="100%" preserveAspectRatio="xMidYMid slice" ImageUrl="~/Images/balloonsjyslogo.jpg" />
                            <ul class="list-group list-group-flush">
                                <li class="list-group-item">Free cakes provided by GaylaCakes</li>
                                <li class="list-group-item">Balloon arrangements from Balloons by JYS</li>
                                <li class="list-group-item">Please fill out the request form one month prior to the child's birthday!</li>
                            </ul>
                            <asp:LinkButton ID="LinkButton4" class="btn btn-info btn-block" runat="server" href="https://docs.google.com/forms/d/e/1FAIpQLSc6aN11MJmWPk1GPf-vNMQz0I3t3JHwyiICUnX_lfdEUjrSFg/viewform">Birthday Request Form</asp:LinkButton>
                            <asp:LinkButton ID="LinkButton5" class="btn btn-info btn-block" runat="server" href="https://www.borrowedheartsfoundation.org/resources.html">Other Resources</asp:LinkButton>
                        </div>
                        <%--<div class="card-body">
                            <asp:LinkButton ID="LinkButton2" class="btn btn-info btn-block" runat="server" href="https://docs.google.com/forms/d/e/1FAIpQLSc6aN11MJmWPk1GPf-vNMQz0I3t3JHwyiICUnX_lfdEUjrSFg/viewform">Birthday Request Form</asp:LinkButton>
                            <asp:LinkButton ID="LinkButton3" class="btn btn-info btn-block" runat="server" href="https://www.borrowedheartsfoundation.org/resources.html">Other Resources</asp:LinkButton>
                        </div>--%>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-4">
                    
                </div>
                <div class="col-4">

                </div>
                <div class="col-4">

                </div>
            </div>
        
    </div>
</asp:Content>
