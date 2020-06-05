using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace datasource1
{
    public partial class GridViewPractica1_2 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void GridView2_SelectedIndexChanging(object sender, GridViewSelectEventArgs e)
        {

            GridViewRow row = GridView2.Rows[e.NewSelectedIndex];

            // You can cancel the select operation by using the Cancel
            // property. For this example, if the user selects a customer with 
            // the ID "HANAR", the select operation is canceled and an error message
            // is displayed.
            if (row.Cells[2].Text == "HANAR")
            {
                e.Cancel = true;
                Label1.Text = "You cannot select " + row.Cells[2].Text + ".";
            }

        }

        protected void GridView2_SelectedIndexChanged(object sender, EventArgs e)
        {
            // Get the currently selected row using the SelectedRow property.
            GridViewRow row = GridView2.SelectedRow;

            // Display the third name from the selected row.
            // In this example, the third column (index 2) contains
            // the customer ID
            Label1.Text = "You selected " + row.Cells[2].Text + ".";
        }

        protected void GridView2_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                // Get the price for this row.
                DateTime fecha = (DateTime)DataBinder.Eval(e.Row.DataItem, "OrderDate");
                if (fecha > DateTime.Now.AddYears(-23))
                {
                    e.Row.BackColor = System.Drawing.Color.ForestGreen;
                    e.Row.ForeColor = System.Drawing.Color.White;
                    e.Row.Font.Bold = true;

                    // mostramos el cliente en Italica para aquellos con DateTime 
                    e.Row.Cells[2].Text = "<i>" + e.Row.Cells[2].Text + "</i>";

                }
            }
        }

        protected void GridView3_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Select")
            {

                // Convert the row index stored in the CommandArgument
                // property to an Integer.
                int index = Convert.ToInt32(e.CommandArgument);

                // Get the last name of the customer from the appropriate
                // cell in the GridView control.
                GridViewRow selectedRow = GridView3.Rows[index];
                TableCell customer = selectedRow.Cells[1];
                string cliente = customer.Text;

                // Display the selected author.
                Label2.Text = "You selected " + cliente + ".";

            }
        }
    }
}