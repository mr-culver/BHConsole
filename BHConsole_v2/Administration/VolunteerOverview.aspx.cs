using System;
using BHConsole.Models;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Jitbit.Utils;
using System.Data.SqlClient;
using System.IO;

namespace BHConsole_v2.Administration
{
    public partial class VolunteerOverview : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Permission"] == null)
            {
                Response.Redirect("~/Default.aspx");
            }
            else if (Session["Permission"].Equals("9"))
            {
                lbl_error.Text = "";
                SetLabels();
                VolunteerOverviewGridView.DataBind();
            }
            else
            {
                Response.Redirect("~/Default.aspx");
            }
        }
        protected void txt_volunteerMonthYear_TextChanged(object sender, EventArgs e)
        {
            //var parameter = VolunteerOverviewDataSource.SelectParameters;
            //parameter["Day"].DefaultValue = System.DateTime.Parse(txt_volunteerMonthYear.Text).Day.ToString();
            //parameter["Month"].DefaultValue = System.DateTime.Parse(txt_volunteerMonthYear.Text).Month.ToString();
            //parameter["Year"].DefaultValue = System.DateTime.Parse(txt_volunteerMonthYear.Text).Year.ToString();
            try
            {
                DataSourceSelectArguments arg = new DataSourceSelectArguments();
                VolunteerOverviewDataSource.Select(arg);
                VolunteerOverviewDataSource.DataBind();
                Session["Day"] = System.DateTime.Parse(txt_volunteerMonthYear.Text).Day.ToString();
                Session["Year"] = System.DateTime.Parse(txt_volunteerMonthYear.Text).Year.ToString();
                Session["Month"] = System.DateTime.Parse(txt_volunteerMonthYear.Text).Month.ToString();
                SetLabels();
                //lbl_volunteerHours.Text = VolunteerTimepunch.TotalVolunteerHours((int)Session["Month"], (int)Session["Year"]).ToString();
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
            lbl_datetimeVolunteer.Text = dateTime.ToString("D");
            lbl_volunteerHoursDay.Text = VolunteerTimepunch.GetVolunteerHoursDay(Session["Day"].ToString(), Session["Month"].ToString(), Session["Year"].ToString());
            lbl_volunteerHoursMonth.Text = VolunteerTimepunch.GetVolunteerHoursMonth(Session["Month"].ToString(), Session["Year"].ToString());
        }

        protected void VolunteerOverviewDetailDataSource_Inserted(object sender, SqlDataSourceStatusEventArgs e)
        {
            VolunteerOverviewGridView.DataBind();
        }

        protected void VolunteerOverviewDetailDataSource_Updated(object sender, SqlDataSourceStatusEventArgs e)
        {
            VolunteerOverviewGridView.DataBind();
        }

        protected void btn_exportMonth_Click(object sender, EventArgs e)
        {
            DownloadVolunteerTimepunchesMonth(new DateTime(Convert.ToInt32((string)Session["Year"]), Convert.ToInt32((string)Session["Month"]), Convert.ToInt32((string)Session["Day"])));
        }

        protected void btn_exportDay_Click(object sender, EventArgs e)
        {
            DownloadVolunteerTimepunchesDay(new DateTime(Convert.ToInt32((string)Session["Year"]), Convert.ToInt32((string)Session["Month"]), Convert.ToInt32((string)Session["Day"])));
        }

        private void DownloadVolunteerTimepunchesMonth(DateTime date)
        {
            string sql = "EXEC SelectVolunteerShifts @Month, @Year";
            var myExport = new CsvExport();
            using (SqlConnection conn = Connection.GetConnection())
            {
                using (SqlCommand cmd = new SqlCommand(sql, conn))
                {
                    //cmd.Parameters.AddWithValue("@Month", System.DateTime.Now.Month);
                    //cmd.Parameters.AddWithValue("@Year", System.DateTime.Now.Year);
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
                                    myExport["Time In"] = dr.GetValue(0).ToString();
                                    myExport["Name"] = dr.GetValue(1).ToString();
                                    myExport["Email"] = dr.GetValue(2).ToString();
                                    myExport["Phone"] = dr.GetValue(3).ToString();
                                    myExport["Hours"] = dr.GetValue(4).ToString();
                                }
                                myExport.ExportToFile(Server.MapPath("~/Data/VolunteerTimepunches.csv"));
                                FileInfo file = new FileInfo(Server.MapPath("~/Data/VolunteerTimepunches.csv"));
                                if (file.Exists)
                                {
                                    Response.Clear();
                                    Response.ContentType = "application/octet-stream";
                                    Response.AppendHeader("Content-Disposition", "filename=VolunteerTimepunches" + "-" + Session["Year"].ToString() + "-" + Session["Month"].ToString() + ".csv");
                                    Response.TransmitFile(Server.MapPath("~/Data/VolunteerTimepunches.csv"));
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

        private void DownloadVolunteerTimepunchesDay(DateTime date)
        {
            string sql = "EXEC SelectVolunteerShiftsDay @Day, @Month, @Year";
            var myExport = new CsvExport();
            using (SqlConnection conn = Connection.GetConnection())
            {
                using (SqlCommand cmd = new SqlCommand(sql, conn))
                {
                    //cmd.Parameters.AddWithValue("@Month", System.DateTime.Now.Month);
                    //cmd.Parameters.AddWithValue("@Year", System.DateTime.Now.Year);
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
                                    myExport["Time In"] = dr.GetValue(0).ToString();
                                    myExport["Name"] = dr.GetValue(1).ToString();
                                    myExport["Email"] = dr.GetValue(2).ToString();
                                    myExport["Phone"] = dr.GetValue(3).ToString();
                                    myExport["Hours"] = dr.GetValue(4).ToString();
                                }
                                myExport.ExportToFile(Server.MapPath("~/Data/VolunteerTimepunches.csv"));
                                FileInfo file = new FileInfo(Server.MapPath("~/Data/VolunteerTimepunches.csv"));
                                if (file.Exists)
                                {
                                    Response.Clear();
                                    Response.ContentType = "application/octet-stream";
                                    Response.AppendHeader("Content-Disposition", "filename=VolunteerTimepunches" + "-" + Session["Year"].ToString() + "-" + Session["Month"].ToString() + "-" + Session["Day"].ToString() + ".csv");
                                    Response.TransmitFile(Server.MapPath("~/Data/VolunteerTimepunches.csv"));
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

        protected void VolunteerOverviewFormView_ItemDeleted(object sender, FormViewDeletedEventArgs e)
        {
            VolunteerOverviewGridView.DataBind();
        }

        protected void VolunteerOverviewFormView_ItemInserted(object sender, FormViewInsertedEventArgs e)
        {
            VolunteerOverviewGridView.DataBind();
        }

        protected void VolunteerOverviewFormView_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
        {
            VolunteerOverviewGridView.DataBind();
        }
    }
}