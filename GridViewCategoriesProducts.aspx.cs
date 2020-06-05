using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace datasource1
{
    public partial class GridViewCategoriesProducts : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {
            Label1.Text = "The primary key value of the selected row is " + GridView1.SelectedValue.ToString() + ".";
        }
    }
}