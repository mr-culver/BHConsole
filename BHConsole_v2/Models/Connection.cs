using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace BHConsole.Models
{
    public class Connection
    {
        public SqlConnection conn { get; }

        public Connection()
        {
            conn = new SqlConnection(ConfigurationManager.ConnectionStrings["BHDBConnectionString"].ConnectionString);
        }

        public static SqlConnection GetConnection()
        {
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["BHDBConnectionString"].ConnectionString);
            return conn;
        }
    }
}