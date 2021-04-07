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
            //lbl_time.Text = System.DateTime.Now.ToString();
            //lbl_error.Text = "";
            //ClockedInDataSource.DataBind();
            //ClockedInGridview.DataBind();
            //VisitDataSource.DataBind();
            //VisitDataSource.DataBind();
            //VisitDetailsDataSource.DataBind();
            //VisitDetailsDataSource.DataBind();
            //// if session objects are null, set to default (this month/year)
            //if (Session["Year"] == null || Session["Year"].Equals(""))
            //{
            //    lbl_error.Text = "";
            //    Session["Year"] = System.DateTime.Now.Year.ToString();
            //    Session["Month"] = System.DateTime.Now.Month.ToString();
            //    Session["Day"] = System.DateTime.Now.Day.ToString();
            //}
            //SetTimeLabels();
            
            //var parameter = VolunteerOverviewDetailDataSource.SelectParameters;
            //parameter["@Time"].DefaultValue = System.DateTime.Now.ToString();
            //ClockedInDataSource.Select(new DataSourceSelectArguments());
            //ClockedInGridview.DataBind();
        }

        protected void Button1_Click(object sender, EventArgs e)
        {

        }
    }
}