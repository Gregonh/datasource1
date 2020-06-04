using System;
using System.Collections.Generic;
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
        }

        protected void sourceCustomersID_Selected(object sender, SqlDataSourceStatusEventArgs e)
        {

            if (e.Exception != null)
            {
                lblError.Text = "An exception occurred performing the query.";
                // Consider the error handled.
                e.ExceptionHandled = true;
            }

        }
    }
}