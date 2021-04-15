using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BHConsole_v2
{
    public partial class Site : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if(Session["Permission"] == null || Session["Permission"].Equals("0"))
                {
                    LinkButtonAdmin.Visible = false;
                    LinkButtonLogout.Visible = false;
                    LinkButtonLogin.Visible = true;
                    LinkButtonVisitsAdmin.Visible = false;
                    LinkButtonVolunteersAdmin.Visible = false;
                    LinkButtonDashboard.Visible = true;
                }
                else if (Session["Permission"].Equals("9"))
                {
                    LinkButtonVisitsAdmin.Visible = true;
                    LinkButtonShoppers.Visible = false;
                    LinkButtonVolunteers.Visible = false;
                    LinkButtonAdmin.Visible = true;
                    LinkButtonLogout.Visible = true;
                    LinkButtonLogin.Visible = false;
                    LinkButtonVolunteersAdmin.Visible = true;
                    LinkButtonDashboard.Visible = false;
                }
            }
            catch(Exception exc)
            {
                throw exc;
            }
        }

        protected void LinkButtonLogout_Click(object sender, EventArgs e)
        {
            Session["UserId"] = null;
            Session["Permission"] = null;
            Response.Redirect("~/Default.aspx");
        }
    }
}