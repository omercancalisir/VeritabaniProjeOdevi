using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using Npgsql;

namespace WindowsFormsApp1
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }
        public string ad;
        public string sifre;
        void esle()
        {
            NpgsqlConnection con = new NpgsqlConnection("Server = localhost; Port=5432; Database=deneme; User Id = postgres; Password=database");
            DataSet dataSet = new DataSet();


            con.Open();
            string sql = "SELECT \"email\" ,\"sifre\",\"kullaniciNo\" FROM \"Kullanici\" WHERE \"email\"='"+ad + "' AND \"sifre\"='" + sifre + "' ";

            NpgsqlDataAdapter add = new NpgsqlDataAdapter(sql, con);
            add.Fill(dataSet);

            dataGridView1.DataSource = dataSet.Tables[0];


            con.Close();
        }

        private void richTextBox1_TextChanged(object sender, EventArgs e)
        {

        }

        private void btnGiris_Click(object sender, EventArgs e)
        {
            ad = richTextBox2.Text;
            sifre = richTextBox5.Text;
            richTextBox1.Visible = false;
            richTextBox2.Visible = false;
            richTextBox3.Visible = false;
            richTextBox4.Visible = false;
            richTextBox5.Visible = false;
            btnGiris.Visible = false;
            dataGridView1.Visible = true;
            
            esle();
            int secim = dataGridView1.SelectedCells[0].RowIndex;
            string db_ad = dataGridView1.Rows[secim].Cells[0].Value.ToString();
            string db_sifre = dataGridView1.Rows[secim].Cells[1].Value.ToString();
            string db_kullanici = dataGridView1.Rows[secim].Cells[2].Value.ToString();

            if (db_ad!=ad && db_sifre!=sifre)
            {
                Form2 form = new Form2();
                form.kullanıcıNo = db_kullanici;
                form.ShowDialog();
            }

        }

        private void Form1_Load(object sender, EventArgs e)
        {

            dataGridView1.Visible = false; 
            
        }

        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            
        }
    }
}
