using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace BHConsole.Models
{
    public class VolunteerTimepunch
    {
        private Volunteer volunteer;
        private Timepunch timepunch;

        public VolunteerTimepunch(string name, string phone, string email)
        {
            this.volunteer = new Volunteer();
            this.volunteer.Name = name;
            this.volunteer.Phone = phone;
            this.volunteer.Email = email;
            this.timepunch = new Timepunch();
            this.timepunch.ClockInTime = System.DateTime.Now;
        }

        public VolunteerTimepunch()
        {

        }

        public static void ClockIn(VolunteerTimepunch vtp)
        {
            string volunteerSQL = "INSERT INTO VolunteerTimepunch ([Name],[Email],[Phone],[TimeIn]) VALUES (@Name, @Email, @Phone, @TimeIn)";
            //string volunteerSQL = "EXEC VolunteerClockin @Name, @Phone, @Email, @TimeIn";
            using (SqlConnection conn = Connection.GetConnection())
            {
                using (SqlCommand cmd = new SqlCommand(volunteerSQL, conn))
                {
                    cmd.Parameters.AddWithValue("@Name", vtp.volunteer.Name);
                    cmd.Parameters.AddWithValue("@Phone", vtp.volunteer.Phone);
                    cmd.Parameters.AddWithValue("@Email", vtp.volunteer.Email);
                    cmd.Parameters.AddWithValue("@TimeIn", vtp.timepunch.ClockInTime);

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
        }

        public static void ClockOut(Int32 id)
        {
            //Update the correct time_punch using the id
            string updateSQL = "UPDATE VolunteerTimepunch SET TimeOut = @TimeOut WHERE Id = @Id";
            using (SqlConnection conn = Connection.GetConnection())
            {
                using (SqlCommand cmd = new SqlCommand(updateSQL, conn))
                {
                    cmd.Parameters.AddWithValue("@Id", id);
                    cmd.Parameters.AddWithValue("@TimeOut", DateTime.Now);
                    try
                    {
                        conn.Open();
                        cmd.ExecuteNonQuery();
                    }
                    finally
                    {
                        conn.Close();
                    }
                }
            }
        }

        public static string GetVolunteersMonth(string month, string year)
        {
            string sql = "SELECT COUNT(Id) FROM [VolunteerTimepunch] WHERE MONTH([TimeIn]) = @Month AND YEAR([TimeIn]) = @Year";
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
                    finally
                    {
                        conn.Close();
                    }
                }
            }
        }

        public static string GetVolunteerHoursMonth(string month, string year)
        {
            string sql = "EXEC SelectVolunteerHoursMonth @Month, @Year";
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
                    finally
                    {
                        conn.Close();
                    }
                }
            }
        }

        public static string GetVolunteerHoursDay(string day, string month, string year)
        {
            string sql = "EXEC SelectVolunteerHoursDay @Day, @Month, @Year";
            using (SqlConnection conn = Connection.GetConnection())
            {
                using (SqlCommand cmd = new SqlCommand(sql, conn))
                {
                    cmd.Parameters.AddWithValue("Day", day);
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
                    finally
                    {
                        conn.Close();
                    }
                }
            }
        }
    }
}