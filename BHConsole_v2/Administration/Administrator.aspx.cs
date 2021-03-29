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
            // if session objects are null, set to default (this month/year)
            if (Session["Year"] == null || Session["Year"].Equals(""))
            {
                //lbl_error.Text = "";
                //parameter["Month"].DefaultValue = System.DateTime.Parse(txt_volunteerMonthYear.Text).Month.ToString();
                //parameter["Year"].DefaultValue = System.DateTime.Parse(txt_volunteerMonthYear.Text).Year.ToString();
                //var parameter = VolunteerOverviewDataSource.SelectParameters;
                //parameter["Month"].DefaultValue = System.DateTime.Now.Month.ToString();
                //parameter["Year"].DefaultValue = System.DateTime.Now.Year.ToString();
                //try
                //{
                //    DataSourceSelectArguments arg = new DataSourceSelectArguments();
                //    VolunteerOverviewDataSource.Select(arg);
                //    VolunteerOverviewDataSource.DataBind();
                //}
                //catch (Exception exc)
                //{
                //    lbl_error.Text = exc.Message;
                //}

                lbl_error.Text = "";
                Session["Year"] = System.DateTime.Now.Year.ToString();
                Session["Month"] = System.DateTime.Now.Month.ToString();
                VolunteerOverviewDataSource.DataBind();
            }
        }

        //protected void btn_volunteerOverviewBind_Click(object sender, EventArgs e)
        //{
        //    var parameter = VolunteerOverviewDataSource.SelectParameters;
        //    parameter["Month"].DefaultValue = System.DateTime.Parse(txt_volunteerMonthYear.Text).Month.ToString();
        //    parameter["Year"].DefaultValue = System.DateTime.Parse(txt_volunteerMonthYear.Text).Year.ToString();
        //    try
        //    {
        //        DataSourceSelectArguments arg = new DataSourceSelectArguments();

        //        VolunteerOverviewDataSource.Select(arg);
        //        VolunteerOverviewDataSource.DataBind();
        //    }
        //    catch (Exception exc)
        //    {
        //        lbl_error.Text = exc.Message;
        //    }
        //}

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
                // ADD TO SESSION OBJECTS!
                Session["Year"] = System.DateTime.Parse(txt_volunteerMonthYear.Text).Year.ToString();
                Session["Month"] = System.DateTime.Parse(txt_volunteerMonthYear.Text).Month.ToString();
            }
            catch (Exception exc)
            {
                lbl_error.Text = exc.Message;
            }
        }
    }
}