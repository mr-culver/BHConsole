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
            Session["Year"] = System.DateTime.Now.Year.ToString();
            Session["Month"] = System.DateTime.Now.Month.ToString();
            Session["Day"] = System.DateTime.Now.Day.ToString();
            ClockedInGridview.DataBind();
            dd_clockedin.DataBind();
            lbl_shoppers.Text = GetNumberOfVisitsToday();
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
            }
        }

        private string GetNumberOfVisitsToday()
        {
            string sql = "SELECT COUNT([Id]) AS Vists FROM [Visit] WHERE MONTH([Visit].[Timestamp]) = @Month AND DAY([Visit].[Timestamp]) = @Day AND YEAR([Visit].[Timestamp]) = @Year";
            using (SqlConnection conn = Connection.GetConnection())
            {
                using (SqlCommand cmd = new SqlCommand(sql, conn))
                {
                    cmd.Parameters.AddWithValue("@Month", DateTime.Now.Month);
                    cmd.Parameters.AddWithValue("@Year", DateTime.Now.Year);
                    cmd.Parameters.AddWithValue("@Day", DateTime.Now.Day);
                    try
                    {
                        conn.Open();
                        return cmd.ExecuteScalar().ToString();
                    }
                    catch (Exception exc)
                    {
                        throw exc;
                    }
                }
            }
        }
    }
}