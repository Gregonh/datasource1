<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EmployeeOrder.aspx.cs" Inherits="datasource1.EmployeeOrder" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:SqlDataSource ID="SqlEmployee" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString2 %>" SelectCommand="SELECT [EmployeeID], [LastName], [FirstName], [Title], [PostalCode], [Country] FROM [Employees]" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
        </div>
    </form>
</body>
</html>
