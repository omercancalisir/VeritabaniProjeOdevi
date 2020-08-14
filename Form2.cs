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
    public partial class Form2 : Form
    {
        public Form2()
        {
            InitializeComponent();
        }
        public string kullanıcıNo;
        public string ekBakiye;
        public string db_bakiye;
        public string db_son_string;
        public string kitapNo;
        public string db_fiyat;
        public string db_son_son;
        public int kitapSayisi = 0;
       


        void esle()
        {
            NpgsqlConnection con = new NpgsqlConnection("Server = localhost; Port=5432; Database=deneme; User Id = postgres; Password=database");
            DataSet dataSet = new DataSet();


            con.Open();
            string sql = "SELECT \"bakiye\"  FROM \"Uye\" WHERE \"kullaniciNo\"='" + kullanıcıNo + "'";

            NpgsqlDataAdapter add = new NpgsqlDataAdapter(sql, con);
            add.Fill(dataSet);

            dataGridView1.DataSource = dataSet.Tables[0];


            con.Close();
        }
        void sepet()
        {
            NpgsqlConnection con = new NpgsqlConnection("Server = localhost; Port=5432; Database=deneme; User Id = postgres; Password=database");
            DataSet dataSet = new DataSet();


            con.Open();
            string sql = "SELECT \"ad\",\"fiyat\",\"sayfaSayisi\"  FROM \"Kitap\" WHERE \"kitapNo\"='" + kitapNo + "'";

            NpgsqlDataAdapter add = new NpgsqlDataAdapter(sql, con);
            add.Fill(dataSet);
           
            dataGridView3.DataSource = dataSet.Tables[0];

            
            

            kitapSayisi++;
            con.Close();
        }
        void kitap()
        {
            NpgsqlConnection con = new NpgsqlConnection("Server = localhost; Port=5432; Database=deneme; User Id = postgres; Password=database");
            DataSet dataSet = new DataSet();


            con.Open();
            string sql = "SELECT * FROM \"Kitap\"";

            NpgsqlDataAdapter add = new NpgsqlDataAdapter(sql, con);
            add.Fill(dataSet);

            dataGridView2.DataSource = dataSet.Tables[0];


            con.Close();
        }
        void bakiye()
        {
            try
            {
                NpgsqlConnection con = new NpgsqlConnection("Server = localhost; Port=5432; Database=deneme; User Id = postgres; Password=database");
                DataSet dataSet = new DataSet();


                con.Open();
                string sql = "UPDATE \"Uye\" SET \"bakiye\" = '" + db_son_string + "' WHERE \"kullaniciNo\"='" + kullanıcıNo + "'";

                NpgsqlDataAdapter add = new NpgsqlDataAdapter(sql, con);
                add.Fill(dataSet);

                dataGridView1.DataSource = dataSet.Tables[0];

                con.Close();
            }
            catch (Exception)
            {
                MessageBox.Show("eklendi");
            }
            
        }

        private void label1_Click(object sender, EventArgs e)
        {

        }

        private void Form2_Load(object sender, EventArgs e)
        {
            esle();
            dataGridView1.Visible = false;
            int secim = dataGridView1.SelectedCells[0].RowIndex;
            db_bakiye = dataGridView1.Rows[secim].Cells[0].Value.ToString();
            txt_bakiye.Text = db_bakiye;
            kitap();
        }

        private void btn_ekle_Click(object sender, EventArgs e)
        {
            esle();
            dataGridView1.Visible = false;
            int secim = dataGridView1.SelectedCells[0].RowIndex;
            db_bakiye = dataGridView1.Rows[secim].Cells[0].Value.ToString();
            txt_bakiye.Text = db_bakiye;
            kitap();
            ekBakiye = txt_ekle.Text;
            int db_son;
            db_son=Convert.ToInt32(ekBakiye) + Convert.ToInt32(db_bakiye);
            db_son_string = Convert.ToString(db_son);
            bakiye();
            esle();
            secim = dataGridView1.SelectedCells[0].RowIndex;
            db_son_son = dataGridView1.Rows[secim].Cells[0].Value.ToString();
            txt_bakiye.Text = db_son_son;
            
            
            
        }

        private void label1_Click_1(object sender, EventArgs e)
        {

        }

        private void button1_Click(object sender, EventArgs e)
        {
            kitapNo = txt_kitap.Text;
            sepet();
            
        }

        private void button2_Click(object sender, EventArgs e)
        {
            int secim = dataGridView3.SelectedCells[0].RowIndex;
            db_fiyat = dataGridView3.Rows[secim].Cells[1].Value.ToString();
            int sonuc = Convert.ToInt32(txt_bakiye.Text) - Convert.ToInt32(db_fiyat);
            txt_bakiye.Text = Convert.ToString(sonuc);
            MessageBox.Show("satın alındı");
            MessageBox.Show("Bakiye Güncellendi.");
        }

        private void label4_Click(object sender, EventArgs e)
        {

        }

        private void silme_Click(object sender, EventArgs e)
        {
            dataGridView3.DataSource = 0;
            MessageBox.Show("sepetten silindi");
        }
    }
}
