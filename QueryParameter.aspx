<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="QueryParameter.aspx.cs" Inherits="datasource1.QueryParameter" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <!--
                vista utilizada en sqldatasourcejemplo para hacer la redirect
                en selectParameter; el querystringparameter tiene un querystringfield que se refiere al campo selected en la otra vista, es el campo mandado para ver
                
                
                -->
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString='<%$ ConnectionStrings:ConnectionString %>' SelectCommand="SELECT * FROM [Products] WHERE ([ProductID] = @ProductID1)">

                <SelectParameters>
                    <asp:QueryStringParameter Name="ProductID1" QueryStringField="prodID" />
                </SelectParameters>
            </asp:SqlDataSource>
         <asp:DetailsView ID="detailsProduct" runat="server" DataSourceID="SqlDataSource1" />
        </div>
    </form>
</body>
</html>
