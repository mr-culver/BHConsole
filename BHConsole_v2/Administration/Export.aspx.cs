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
    public partial class Export : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            //DownloadVolunteerTimepunches(System.DateTime.Now);
            DownloadShopperVisits(System.DateTime.Now);
        }

        private void DownloadVolunteerTimepunches(DateTime date)
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
                                myExport.ExportToFile(Server.MapPath("~/Data/test.csv"));
                                FileInfo file = new FileInfo("~/Data/test.csv");
                                if (file.Exists)
                                {
                                    Response.Clear();
                                    Response.ContentType = "application/octet-stream";
                                    Response.AppendHeader("Content-Disposition", "filename=test.csv");
                                    Response.TransmitFile(Server.MapPath("~/Data/test.csv"));
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
        private void DownloadShopperVisits(DateTime date)
        {
            string sql = "EXEC SelectShopperVisitsMonth @Month, @Year";
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
                                    Response.AppendHeader("Content-Disposition", "filename=helloworld.csv"); 
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
    }
}