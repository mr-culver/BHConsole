using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace BHConsole.Models
{
    public class VolunteerTimePunch
    {
        private Volunteer volunteer;
        private TimePunch timePunch;

        public VolunteerTimePunch(string name, string phone, string email)
        {
            this.volunteer = new Volunteer();
            this.volunteer.Name = name;
            this.volunteer.Phone = phone;
            this.volunteer.Email = email;
            this.timePunch = new TimePunch();
            this.timePunch.ClockInTime = System.DateTime.Now;
        }

        public static void ClockIn(VolunteerTimePunch vtp, SqlConnection conn)
        {
            string volunteerSQL = "EXEC VolunteerClockin @Name, @Phone, @Email, @TimeIn";
            //TODO: Data validation
            using (SqlCommand cmd = new SqlCommand(volunteerSQL, conn))
            {
                cmd.Parameters.AddWithValue("@Name", vtp.volunteer.Name);
                cmd.Parameters.AddWithValue("@Phone", vtp.volunteer.Phone);
                cmd.Parameters.AddWithValue("@Email", vtp.volunteer.Email);
                cmd.Parameters.AddWithValue("@TimeIn", vtp.timePunch.ClockInTime);

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

        public static void ClockOut(Int32 id, SqlConnection conn)
        {
            //Update the correct time_punch using the id
            string updateSQL = "UPDATE time_punch SET time_out = @TimeOut WHERE id = @Id";
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
}