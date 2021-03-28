using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BHConsole_v2
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btn_Login_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["BHDBConnectionString"].ConnectionString);
                try
                {
                    if(conn.State == System.Data.ConnectionState.Closed)
                    {
                        conn.Open();
                    }
                    SqlCommand cmd = new SqlCommand("SELECT * FROM [User] WHERE (([User].UserId = @UserId) AND ([User].Password = @Password))", conn);
                    cmd.Parameters.AddWithValue("@UserId", txt_Id.Text.Trim());
                    cmd.Parameters.AddWithValue("@Password", txt_Password.Text.Trim());
                    SqlDataReader dr = cmd.ExecuteReader();
                    if (dr.HasRows)
                    {
                        lbl_result.CssClass = "text-success";
                        while (dr.Read())
                        {
                            Session["UserId"] = dr.GetValue(1).ToString();
                            Session["Permission"] = dr.GetValue(3).ToString();
                            //lbl_result.Text = dr.GetValue(1).ToString();
                            //lbl_result.Text = dr.GetValue(3).ToString();
                        }
                        //Response.Redirect("Default.aspx");
                    }
                    else
                    {
                        lbl_result.CssClass = "text-danger";
                        lbl_result.Text = "Login failed";
                    }
                }
                catch(Exception exc)
                {
                    lbl_result.Text = "Error: " + exc.Message;
                }
                finally
                {
                    conn.Close();
                }
            }
        }
    }
}