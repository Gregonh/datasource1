using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace datasource1
{
    public partial class AutoresTitulos : System.Web.UI.Page
    {
        /*
         * la listbox va a necesitar un control del postback
         * de modo que si no hay postback crea los elementos,
         * si hay postback por darle al boton ya los tendria
         * y por tanto haria la funcion de abajo selectindexCVhanged
         * 
         * el radiobotton no necesita de este mecanismo
         * 
         * 
         * */
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                ListBox1.DataSource = this.SqlDataSource1;
                ListBox1.DataTextField = "AuthorLastName";
                ListBox1.DataValueField = "Title";
                ListBox1.DataBind();
            }
        }


        protected void ListBox1_SelectedIndexChanged(object sender, EventArgs e)
        {
            Label1.Text = ListBox1.SelectedItem.Value;
            //Label1.Text = this.ListBox1.SelectedValue;


        }

        protected void RadioButtonList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            Label1.Text = RadioButtonList1.SelectedItem.Value;
        }
    }
}