using System;
using System.Collections.Generic;
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
                if(Session["UserId"] == null)
                {
                    LinkButtonAdmin.Visible = false;
                    LinkButtonLogout.Visible = false;
                    LinkButtonLogin.Visible = true;
                }
                else if (Session["UserId"].Equals("admin"))
                {
                    LinkButtonAdmin.Visible = true;
                    LinkButtonLogout.Visible = true;
                    LinkButtonLogin.Visible = false;
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
            Response.Redirect("Default.aspx");
        }
    }
}