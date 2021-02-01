using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Database_CarDealership_SalesPerson
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            //Filter Panel 
            filterPanel.Visible = false;
        }

        private void closeBox_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void filterButton_Click(object sender, EventArgs e)
        {
            filterPanel.Visible = true;
        }

        private void filterClose_Click(object sender, EventArgs e)
        {
            filterPanel.Visible = false;
        }

        private void carSubmitButton_Click(object sender, EventArgs e)
        {
            carSubmitButton.Text = "Hola!";
        }

        private void carCancelButton_Click(object sender, EventArgs e)
        {
            carCancelButton.Text = "Hello!";
        }
    }
}
