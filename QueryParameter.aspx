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
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString='<%$ ConnectionStrings:ConnectionString %>' SelectCommand="SELECT [ProductName], [ProductID] FROM [Products]"></asp:SqlDataSource>
        </div>
    </form>
</body>
</html>
