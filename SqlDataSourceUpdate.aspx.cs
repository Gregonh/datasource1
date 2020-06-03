using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace datasource1
{
    public partial class SqlDataSourceUpdate : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void DetailsRegion_Inserting(object sender, SqlDataSourceCommandEventArgs e)
        {
            e.Command.Parameters["@RegionID"].Value = 5;
            e.Command.Parameters["@RegionDescription"].Value = "Europe";
        }
    }
}