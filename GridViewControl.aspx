﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GridViewControl.aspx.cs" Inherits="datasource1.GridViewControl" %>

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
                se crea el sqldatasource para hacer un select;
                el id se usa despues en el gridview para vincularlo (con el datasourceid)
                el datakeyname en gridview es la clave primaria
                
                -->
             <asp:SqlDataSource ID = "sourceProducts" runat = "server"
        ConnectionString = "<%$ ConnectionStrings:ConnectionString %>"
        SelectCommand = "SELECT [ProductID], [ProductName], [UnitPrice], [QuantityPerUnit], [UnitsOnOrder] FROM [Products]" />
            <br />
            <br />
            <asp:SqlDataSource ID="sourceOrders" runat="server" ConnectionString="
                <%$ ConnectionStrings:ConnectionString %>" 
                SelectCommand="SELECT [OrderID], [CustomerID], [OrderDate], [ShipAddress], [ShippedDate] 
                FROM [Orders]"></asp:SqlDataSource>
            <br />
            <br />
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="ProductID" DataSourceID="sourceProducts">
                <Columns>
                    <asp:BoundField DataField="ProductID" HeaderText="ProductID" InsertVisible="False" ReadOnly="True" SortExpression="ProductID" />
                    <asp:BoundField DataField="ProductName" HeaderText="ProductName" SortExpression="ProductName" />
                    <asp:BoundField DataField="UnitPrice" DataFormatString="{0:C}" HeaderText="UnitPrice" SortExpression="UnitPrice" >
                    <FooterStyle BackColor="Red" BorderColor="#00CC66" BorderWidth="30px" />
                    </asp:BoundField>
                    <asp:BoundField DataField="QuantityPerUnit" HeaderText="QuantityPerUnit" SortExpression="QuantityPerUnit" />
                    <asp:BoundField DataField="UnitsOnOrder" HeaderText="UnitsOnOrder" SortExpression="UnitsOnOrder" >
                    <HeaderStyle BorderColor="Red" />
                    <ItemStyle BorderColor="Blue" BorderWidth="5px" />
                    </asp:BoundField>
                </Columns>
                <HeaderStyle BackColor="#CCFFCC" BorderColor="#990000" />
            </asp:GridView>
            <br />
            <br />
            <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" DataKeyNames="OrderID" DataSourceID="sourceOrders">
                <Columns>
                    <asp:BoundField DataField="OrderID" HeaderText="Identificador" InsertVisible="False" ReadOnly="True" SortExpression="OrderID" />
                    <asp:BoundField DataField="CustomerID" HeaderText="Identificador Cliente" SortExpression="CustomerID" />
                    <asp:BoundField DataField="OrderDate" DataFormatString="{0:F}" HeaderText="OrderDate" SortExpression="OrderDate" />
                    <asp:BoundField DataField="ShipAddress" HeaderText="ShipAddress" SortExpression="ShipAddress" />
                    <asp:BoundField DataField="ShippedDate" HeaderText="ShippedDate" SortExpression="ShippedDate" />
                </Columns>
                <HeaderStyle BackColor="#9999FF" Font-Bold="True" BorderStyle="Dashed" />
                <RowStyle BackColor="#CCFF99" BorderColor="Red" />
            </asp:GridView>
            <br />
            <br />
        </div>
    </form>
</body>
</html>