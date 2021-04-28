using BHConsole.Models;
using Jitbit.Utils;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.IO;
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
            if (Session["Permission"] == null)
            {
                Response.Redirect("~/Default.aspx");
            }
            else if (Session["Permission"].Equals("9"))
            {
                SetLabels();
                lbl_error.Text = "";
                VisitGridView.DataBind();
                MonthVisitGridView.DataBind();
            }
            else
            {
                Response.Redirect("~/Default.aspx");
            }
        }
        protected void txt_shopperMonthYear_TextChanged(object sender, EventArgs e)
        {
            //var parameter = VisitDataSource.SelectParameters;
            //parameter["Day"].DefaultValue = System.DateTime.Parse(txt_shopperMonthYear.Text).Day.ToString();
            //parameter["Month"].DefaultValue = System.DateTime.Parse(txt_shopperMonthYear.Text).Month.ToString();
            //parameter["Year"].DefaultValue = System.DateTime.Parse(txt_shopperMonthYear.Text).Year.ToString();
            try
            {
                DataSourceSelectArguments arg = new DataSourceSelectArguments();
                VisitDataSource.Select(arg);
                VisitDataSource.DataBind();
                Session["Year"] = System.DateTime.Parse(txt_shopperMonthYear.Text).Year.ToString();
                Session["Month"] = System.DateTime.Parse(txt_shopperMonthYear.Text).Month.ToString();
                Session["Day"] = System.DateTime.Parse(txt_shopperMonthYear.Text).Day.ToString();
                SetLabels();
            }
            catch (Exception exc)
            {
                lbl_error.Text = exc.Message;
            }
        }
        private void SetLabels()
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
            lbl_childrenServedDay.Text = ShopperVisit.GetChildrenServedDay((string)Session["Day"], (string)Session["Month"], (string)Session["Year"]);
            lbl_childrenServedMonth.Text = ShopperVisit.GetChildrenServedMonth((string)Session["Month"], (string)Session["Year"]);
        }

        protected void btn_exportMonth_Click(object sender, EventArgs e)
        {
            DownloadShopperVisitsMonth(new DateTime(Convert.ToInt32((string)Session["Year"]), Convert.ToInt32((string)Session["Month"]), Convert.ToInt32((string)Session["Day"])));
        }

        protected void btn_exportDay_Click(object sender, EventArgs e)
        {
            DownloadShopperVisitsDay(new DateTime(Convert.ToInt32((string)Session["Year"]), Convert.ToInt32((string)Session["Month"]), Convert.ToInt32((string)Session["Day"])));
        }

        private void DownloadShopperVisitsMonth(DateTime date)
        {
            string sql = "EXEC SelectShopperVisitsMonth @Month, @Year";
            var myExport = new CsvExport();
            using (SqlConnection conn = Connection.GetConnection())
            {
                using (SqlCommand cmd = new SqlCommand(sql, conn))
                {
                    cmd.Parameters.AddWithValue("@Month", date.Month);
                    cmd.Parameters.AddWithValue("@Year", date.Year);
                    try
                    {
                        conn.Open();
                        using (SqlDataReader dr = cmd.ExecuteReader())
                        {
                            if (dr.HasRows)
                            {
                                while (dr.Read())
                                {
                                    myExport.AddRow();
                                    myExport["Date"] = dr.GetValue(0).ToString();
                                    myExport["Name"] = dr.GetValue(1).ToString();
                                    myExport["Email"] = dr.GetValue(2).ToString();
                                    myExport["Phone"] = dr.GetValue(3).ToString();
                                    myExport["Address"] = dr.GetValue(4).ToString();
                                    myExport["First"] = dr.GetValue(5).ToString();
                                    myExport["Children"] = dr.GetValue(6).ToString();
                                    myExport["Case Worker"] = dr.GetValue(7).ToString();
                                    myExport["Relation"] = dr.GetValue(8).ToString();
                                    myExport["Description"] = dr.GetValue(9).ToString();
                                }
                                myExport.ExportToFile(Server.MapPath("~/Data/ShopperVisits.csv"));
                                FileInfo file = new FileInfo(Server.MapPath("~/Data/ShopperVisits.csv"));
                                string a = file.Directory.ToString();
                                string b = file.FullName;
                                if (file.Exists)
                                {
                                    Response.Clear();
                                    Response.ContentType = "application/octet-stream";
                                    Response.AppendHeader("Content-Disposition", "filename=" + "ShopperVisits" + "-" + Session["Year"].ToString() + "-" + Session["Month"].ToString() + ".csv");
                                    Response.TransmitFile(Server.MapPath("~/Data/ShopperVisits.csv"));
                                    Response.End();
                                    file.Delete();
                                }
                            }
                        }
                    }
                    catch (Exception exc)
                    {
                        throw exc;
                    }
                }
            }
        }

        private void DownloadShopperVisitsDay(DateTime date)
        {
            string sql = "EXEC SelectShopperVisitsDay @Day, @Month, @Year";
            var myExport = new CsvExport();
            using (SqlConnection conn = Connection.GetConnection())
            {
                using (SqlCommand cmd = new SqlCommand(sql, conn))
                {
                    cmd.Parameters.AddWithValue("@Day", date.Day);
                    cmd.Parameters.AddWithValue("@Month", date.Month);
                    cmd.Parameters.AddWithValue("@Year", date.Year);
                    try
                    {
                        conn.Open();
                        using (SqlDataReader dr = cmd.ExecuteReader())
                        {
                            if (dr.HasRows)
                            {
                                while (dr.Read())
                                {
                                    myExport.AddRow();
                                    myExport["Date"] = dr.GetValue(0).ToString();
                                    myExport["Name"] = dr.GetValue(1).ToString();
                                    myExport["Email"] = dr.GetValue(2).ToString();
                                    myExport["Phone"] = dr.GetValue(3).ToString();
                                    myExport["Address"] = dr.GetValue(4).ToString();
                                    myExport["First"] = dr.GetValue(5).ToString();
                                    myExport["Children"] = dr.GetValue(6).ToString();
                                    myExport["Case Worker"] = dr.GetValue(7).ToString();
                                    myExport["Relation"] = dr.GetValue(8).ToString();
                                    myExport["Description"] = dr.GetValue(9).ToString();
                                }
                                myExport.ExportToFile(Server.MapPath("~/Data/ShopperVisits.csv"));
                                FileInfo file = new FileInfo(Server.MapPath("~/Data/ShopperVisits.csv"));
                                string a = file.Directory.ToString();
                                string b = file.FullName;
                                if (file.Exists)
                                {
                                    Response.Clear();
                                    Response.ContentType = "application/octet-stream";
                                    Response.AppendHeader("Content-Disposition", "filename=" + "ShopperVisits" + "-" + Session["Year"].ToString() + "-" + Session["Month"].ToString() + "-" + Session["Day"].ToString() + ".csv");
                                    Response.TransmitFile(Server.MapPath("~/Data/ShopperVisits.csv"));
                                    Response.End();
                                    file.Delete();
                                }

                            }
                        }
                    }
                    catch (Exception exc)
                    {
                        throw exc;
                    }
                }
            }
        }

        protected void VisitDetailsFormView_ItemInserted(object sender, FormViewInsertedEventArgs e)
        {
            VisitGridView.DataBind();
            //ChildrenServedFormView.DataBind();
        }

        protected void VisitDetailsFormView_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
        {
            VisitGridView.DataBind();
            //ChildrenServedFormView.DataBind();
        }

        protected void VisitDetailsFormView_ItemDeleted(object sender, FormViewDeletedEventArgs e)
        {
            VisitGridView.DataBind();
            //ChildrenServedFormView.DataBind();
        }
    }
}