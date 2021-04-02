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
            lbl_error.Text = "";
            ClockedInDataSource.DataBind();
            ClockedInGridview.DataBind();
            VisitDataSource.DataBind();
            VisitDataSource.DataBind();
            VisitDetailsDataSource.DataBind();
            VisitDetailsDataSource.DataBind();
            // if session objects are null, set to default (this month/year)
            if (Session["Year"] == null || Session["Year"].Equals(""))
            {
                lbl_error.Text = "";
                Session["Year"] = System.DateTime.Now.Year.ToString();
                Session["Month"] = System.DateTime.Now.Month.ToString();
                Session["Day"] = System.DateTime.Now.Day.ToString();
            }
            SetTimeLabels();
            
            //var parameter = VolunteerOverviewDetailDataSource.SelectParameters;
            //parameter["@Time"].DefaultValue = System.DateTime.Now.ToString();
            //ClockedInDataSource.Select(new DataSourceSelectArguments());
            //ClockedInGridview.DataBind();
        }

        private void SetTimeLabels()
        {
            string monthYear;
            string monthDayYear;
            switch (Convert.ToInt32(Session["Month"].ToString()))
            {
                case 1:
                    monthYear = "January ";
                    break;
                case 2:
                    monthYear = "February ";
                    break;
                case 3:
                    monthYear = "March ";
                    break;
                case 4:
                    monthYear = "April ";
                    break;
                case 5:
                    monthYear = "May ";
                    break;
                case 6:
                    monthYear = "June ";
                    break;
                case 7:
                    monthYear = "July ";
                    break;
                case 8:
                    monthYear = "August ";
                    break;
                case 9:
                    monthYear = "September";
                    break;
                case 10:
                    monthYear = "October ";
                    break;
                case 11:
                    monthYear = "November ";
                    break;
                case 12:
                    monthYear = "December ";
                    break;
                default:
                    monthYear = "January ";
                    break;
            }
            monthDayYear = monthYear;
            monthDayYear += Session["Day"].ToString() + ", " + Session["Year"].ToString();
            lbl_datetimeShopper.Text = monthDayYear;
            monthYear += Session["Year"].ToString();
            lbl_datetimeVolunteer.Text = monthYear;
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
            }
            catch (Exception exc)
            {
                lbl_error.Text = exc.Message;
            }
            Page.SetFocus(VolunteerOverview);
        }
        protected void btn_clockout_Click(object sender, EventArgs e)
        {
            if (dd_clockedin.SelectedItem != null)
            {
                VolunteerTimepunch.ClockOut(Convert.ToInt32(dd_clockedin.SelectedValue));
                ClockedInDataSource.Select(new DataSourceSelectArguments());
                ClockedInGridview.DataBind();
                ClockedInDataSource.DataBind();
                Page.SetFocus(btn_clockout);
                //Session["VolunteerToThank"] = dd_clockedin.SelectedItem.ToString();
                /*Session["VolunteerToThank"] = dd_clockedin.SelectedValue.ToString();*/ // TODO: Add thank you page
                /*Response.Redirect("~/Default.aspx");*/ // Will redirect to thank you page
            }
        }
        protected void txt_shopperMonthYear_TextChanged(object sender, EventArgs e)
        {
            var parameter = VisitDataSource.SelectParameters;
            parameter["Day"].DefaultValue = System.DateTime.Parse(txt_shopperMonthYear.Text).Day.ToString();
            parameter["Month"].DefaultValue = System.DateTime.Parse(txt_shopperMonthYear.Text).Month.ToString();
            parameter["Year"].DefaultValue = System.DateTime.Parse(txt_shopperMonthYear.Text).Year.ToString();
            try
            {
                DataSourceSelectArguments arg = new DataSourceSelectArguments();
                VisitDataSource.Select(arg);
                VisitDataSource.DataBind();
                Session["Year"] = System.DateTime.Parse(txt_shopperMonthYear.Text).Year.ToString();
                Session["Month"] = System.DateTime.Parse(txt_shopperMonthYear.Text).Month.ToString();
                Session["Day"] = System.DateTime.Parse(txt_shopperMonthYear.Text).Day.ToString();
                SetTimeLabels();
            }
            catch (Exception exc)
            {
                lbl_error.Text = exc.Message;
            }
        }
    }
}