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

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btn_clockin_Click(object sender, EventArgs e)
        {
            
            VolunteerTimepunch vtp = new VolunteerTimepunch(txt_name.Text.Trim(), txt_phone.Text, txt_email.Text);

            VolunteerTimepunch.ClockIn(vtp);

            //TODO: Redirect to clockin confirmation page or something
            Response.Redirect("~/Default.aspx");
        }
    }
}