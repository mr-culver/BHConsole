using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BHConsole_v2.Administration
{
    public partial class ShopperOverview : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            SetTimeLabels();
            lbl_error.Text = "";
            VisitGridView.DataBind();
            ChildrenServedFormView.DataBind();
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
            lbl_datetimeShopper.Text = dateTime.ToString("D");
            //monthYear += Session["Year"].ToString();
            //lbl_datetimeVolunteer.Text = monthYear;
        }
    }
}