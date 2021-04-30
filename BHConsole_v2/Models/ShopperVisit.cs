using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace BHConsole.Models
{
    public class ShopperVisit
    {
        private Shopper shopper;
        private Visit visit;

        public ShopperVisit 
        (
            // Constructor arguments
            string name, 
            string email, 
            string phone, 
            string address, 
            int firstVisit, 
            int numberOfChildren, 
            string caseWorkerName, 
            string relationToChildren, 
            string relationOtherDescription
        )
        {
            // build object that will be inserted into the database
            this.shopper = new Shopper();
            this.shopper.Name = name;
            this.shopper.Email = email;
            this.shopper.Phone = phone;
            this.shopper.Address = address;
            this.visit = new Visit();
            this.visit.FirstVisit = firstVisit;
            this.visit.NumberOfChildren = numberOfChildren;
            this.visit.CaseWorkerName = caseWorkerName;
            this.visit.RelationToChildren = relationToChildren;
            this.visit.RelationOtherDescription = relationOtherDescription;
        }

        public static void CheckIn(ShopperVisit shopperVisit, SqlConnection conn)
        {
            string shopperSQL = "EXEC ShopperCheckin @Name, @Email, @Phone, @Address, @FirstVisit, @NumberOfChildren, @CaseWorkerName, @RelationToChildren, @RelationOtherDescription, @Timestamp";
            using (SqlCommand cmd = new SqlCommand(shopperSQL, conn))
            {
                cmd.Parameters.AddWithValue("@Name", shopperVisit.shopper.Name);
                cmd.Parameters.AddWithValue("@Email", shopperVisit.shopper.Email);
                cmd.Parameters.AddWithValue("@Phone", shopperVisit.shopper.Phone);
                cmd.Parameters.AddWithValue("@Address", shopperVisit.shopper.Address);
                cmd.Parameters.AddWithValue("@FirstVisit", shopperVisit.visit.FirstVisit);
                cmd.Parameters.AddWithValue("@NumberOfChildren", shopperVisit.visit.NumberOfChildren);
                cmd.Parameters.AddWithValue("@CaseWorkerName", shopperVisit.visit.CaseWorkerName);
                cmd.Parameters.AddWithValue("@RelationToChildren", shopperVisit.visit.RelationToChildren);
                cmd.Parameters.AddWithValue("@RelationOtherDescription", shopperVisit.visit.RelationOtherDescription);
                cmd.Parameters.AddWithValue("@Timestamp", System.DateTime.Now.ToString());

                try
                {
                    conn.Open();
                    cmd.ExecuteScalar();
                }
                finally
                {
                    conn.Close();
                }
            }
        }

        public static string GetChildrenServedDay(string day, string month, string year)
        {
            string sql = "EXEC [SelectChildrenServedDay] @Day, @Month, @Year";
            using (SqlConnection conn = Connection.GetConnection())
            {
                using (SqlCommand cmd = new SqlCommand(sql, conn))
                {
                    cmd.Parameters.AddWithValue("@Day", day);
                    cmd.Parameters.AddWithValue("@Month", month);
                    cmd.Parameters.AddWithValue("@Year", year);
                    try
                    {
                        conn.Open();
                        return cmd.ExecuteScalar().ToString();
                    }
                    catch (Exception exc)
                    {
                        return exc.Message;
                    }
                }
            }
        }

        public static string GetChildrenServedMonth(string month, string year)
        {
            string sql = "EXEC [SelectChildrenServedMonth] @Month, @Year";
            using (SqlConnection conn = Connection.GetConnection())
            {
                using (SqlCommand cmd = new SqlCommand(sql, conn))
                {
                    cmd.Parameters.AddWithValue("@Month", month);
                    cmd.Parameters.AddWithValue("@Year", year);
                    try
                    {
                        conn.Open();
                        return cmd.ExecuteScalar().ToString();
                    }
                    catch (Exception exc)
                    {
                        return exc.Message;
                    }
                }
            }
        }

        public static string GetShopperVistsMonth(string month, string year)
        {
            string sql = "SELECT COUNT(Id) FROM [Visit] WHERE MONTH([Timestamp]) = @Month AND YEAR([Timestamp]) = @Year";
            using (SqlConnection conn = Connection.GetConnection())
            {
                using (SqlCommand cmd = new SqlCommand(sql, conn))
                {
                    cmd.Parameters.AddWithValue("@Month", month);
                    cmd.Parameters.AddWithValue("@Year", year);
                    try
                    {
                        conn.Open();
                        return cmd.ExecuteScalar().ToString();
                    }
                    catch (Exception exc)
                    {
                        return exc.Message;
                    }
                }
            }
        }
    }
}