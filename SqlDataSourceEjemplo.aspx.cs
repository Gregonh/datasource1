using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace datasource1
{
    public partial class SqlDataSourceEjemplo : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        // toma del dropdownlist1 el valor seleccionado y lo manda como variable prodId al a la vista  queryparameter 
        protected void Button1_Click(object sender, EventArgs e)
        {
            if (DropDownList1.SelectedIndex != -1)
            {
                Response.Redirect(
                "QueryParameter.aspx?prodID=" + DropDownList1.SelectedValue);
            }
        }

        protected void sourceCustomersID_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {
            e.Command.Parameters["@OrderDate"].Value = DateTime.Today.AddYears(-23);

            //Codigo para depurar el valor de los parametros.

            lblParameters.Text = "Parametros de SqlDataSource sourceCustomersID: <br/>";
            // recorre los parametros y muestra su nombre y valor
            foreach (SqlParameter Par in e.Command.Parameters)
            {
                lblParameters.Text += "Par: " + Par.ParameterName + ": " + Par.Value.ToString() + "<br/>";
            }

        }

        protected void sourceCustomersID_Selected(object sender, SqlDataSourceStatusEventArgs e)
        {

            if (e.Exception != null)
            {
                lblError.Text = "An exception occurred performing the query.";
                // Consider the error handled.
                e.ExceptionHandled = true;
            }


            lblError.Text = "Filas seleccionadas: " + e.AffectedRows;


        }
    }
}