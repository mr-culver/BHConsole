using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BHConsole_v2
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Permission"] == null || Session["Permission"].Equals("0"))
            {
            }
            else if (Session["Permission"].Equals("9"))
            {
                Response.Redirect("~/Administration/Administrator.aspx");
            }
        }
    }
}