using BHConsole.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BHConsole
{
    public partial class VolunteerClockin : System.Web.UI.Page
    {
        //SqlConnection conn;

        protected void Page_Load(object sender, EventArgs e)
        {
            //conn = new SqlConnection(ConfigurationManager.ConnectionStrings["BHDBConnectionString"].ConnectionString);
            //conn = Connection.GetConnection().conn;
        }

        protected void btn_clockin_Click(object sender, EventArgs e)
        {
            VolunteerTimePunch vtp = new VolunteerTimePunch(txt_name.Text.Trim(), txt_phone.Text, txt_email.Text);

            VolunteerTimePunch.ClockIn(vtp, Connection.GetConnection().conn);

            //TODO: Redirect to clockin confirmation page or something
            Response.Redirect("~/Default.aspx");
        }
    }
}