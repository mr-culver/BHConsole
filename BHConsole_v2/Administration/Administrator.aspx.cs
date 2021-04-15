using BHConsole.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BHConsole_v2.Administration
{
    public partial class Administrator : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            lbl_time.Text = System.DateTime.Now.ToString();
            if (Session["Year"] == null || Session["Year"].Equals(""))
            {
                Session["Year"] = System.DateTime.Now.Year.ToString();
                Session["Month"] = System.DateTime.Now.Month.ToString();
                Session["Day"] = System.DateTime.Now.Day.ToString();
            }
            ClockedInGridview.DataBind();
        }

        protected void btn_clockout_Click(object sender, EventArgs e)
        {
            if (dd_clockedin.SelectedItem != null)
            {
                VolunteerTimepunch.ClockOut(Convert.ToInt32(dd_clockedin.SelectedValue));
                ClockedInDataSource.Select(new DataSourceSelectArguments());
                ClockedInGridview.DataBind();
                ClockedInDataSource.DataBind();
                dd_clockedin.SelectedValue = null;
                //Session["VolunteerToThank"] = dd_clockedin.SelectedItem.ToString();
                /*Session["VolunteerToThank"] = dd_clockedin.SelectedValue.ToString();*/ // TODO: Add thank you page
                /*Response.Redirect("~/Default.aspx");*/ // Will redirect to thank you page
            }
        }
    }
}