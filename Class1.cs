using Npgsql;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace WindowsFormsApp1
{
    class Class1
    {

        NpgsqlConnection con = new NpgsqlConnection("Server = localhost; Port=5432; Database=deneme; User Id = postgres; Password=database");
        DataSet dataSet = new DataSet();

        void baglan()
        {
            con.Open();
        }

        void kapat()
        {
            con.Close();
        }

    }
}
