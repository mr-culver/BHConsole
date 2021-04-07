using System;
using BHConsole.Models;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BHConsole_v2.Administration
{
    public partial class VolunteerOverview : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            lbl_error.Text = "";
            SetTimeLabels();
            //lbl_volunteerHours.Text = VolunteerTimepunch.TotalVolunteerHours(Convert.ToInt32(Session["Month"]), Convert.ToInt32(Session["Year"])).ToString();
            VolunteerOverviewGridView.DataBind();
            FormView1.DataBind();
        }
        protected void txt_volunteerMonthYear_TextChanged(object sender, EventArgs e)
        {
            var parameter = VolunteerOverviewDataSource.SelectParameters;
            parameter["Month"].DefaultValue = System.DateTime.Parse(txt_volunteerMonthYear.Text).Month.ToString();
            parameter["Year"].DefaultValue = System.DateTime.Parse(txt_volunteerMonthYear.Text).Year.ToString();
            try
            {
                DataSourceSelectArguments arg = new DataSourceSelectArguments();
                VolunteerOverviewDataSource.Select(arg);
                VolunteerOverviewDataSource.DataBind();
                Session["Year"] = System.DateTime.Parse(txt_volunteerMonthYear.Text).Year.ToString();
                Session["Month"] = System.DateTime.Parse(txt_volunteerMonthYear.Text).Month.ToString();
                SetTimeLabels();
                //lbl_volunteerHours.Text = VolunteerTimepunch.TotalVolunteerHours((int)Session["Month"], (int)Session["Year"]).ToString();
            }
            catch (Exception exc)
            {
                lbl_error.Text = exc.Message;
            }
        }
        private void SetTimeLabels()
        {
            if (Session["Year"] == null || Session["Year"].Equals(""))
            {
                lbl_error.Text = "";
                Session["Year"] = System.DateTime.Now.Year.ToString();
                Session["Month"] = System.DateTime.Now.Month.ToString();
                Session["Day"] = System.DateTime.Now.Day.ToString();
            }
            DateTime dateTime = new DateTime(Convert.ToInt32((string)Session["Year"]), Convert.ToInt32((string)Session["Month"]), Convert.ToInt32((string)Session["Day"]));
            lbl_datetimeVolunteer.Text = dateTime.ToString("y");
        }

        protected void VolunteerOverviewDetailDataSource_Inserted(object sender, SqlDataSourceStatusEventArgs e)
        {
            VolunteerOverviewGridView.DataBind();
        }

        protected void VolunteerOverviewDetailDataSource_Updated(object sender, SqlDataSourceStatusEventArgs e)
        {
            VolunteerOverviewGridView.DataBind();
        }
    }
}