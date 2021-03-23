using BHConsole.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BHConsole
{
    public partial class VolunteerClockout : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btn_clockout_Click(object sender, EventArgs e)
        {
            if (dd_clockedin.SelectedItem != null)
            {
                VolunteerTimePunch.ClockOut(Convert.ToInt32(dd_clockedin.SelectedValue), Connection.GetConnection().conn);
                Session["VolunteerToThank"] = dd_clockedin.SelectedValue.ToString(); // TODO: Add thank you page
                Response.Redirect("~/Volunteers.aspx"); // Will redirect to thank you page
            }
            

        }
    }
}