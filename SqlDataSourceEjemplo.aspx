<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SqlDataSourceEjemplo.aspx.cs" Inherits="datasource1.SqlDataSourceEjemplo" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="SqlDataSource1" DataTextField="ProductName" DataValueField="ProductID" AutoPostBack="True">
            </asp:DropDownList>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [ProductID], [ProductName], [SupplierID] FROM [Products]"></asp:SqlDataSource>
        </div>

        <div>
             <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [Products] WHERE ([ProductID] = @ProductID)">
                 <SelectParameters>
                     <asp:ControlParameter ControlID="DropDownList1" Name="ProductID" PropertyName="SelectedValue" Type="Int32" />
                 </SelectParameters>
             </asp:SqlDataSource>

            <br />
             <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Seleccionar Producto" Width="171px" />
            <br />
            <br />
            <asp:DetailsView ID="DetailsView1" runat="server" Height="50px" Width="125px" AutoGenerateRows="True" BackColor="White" BorderColor="#CC9966" BorderStyle="None" BorderWidth="1px" CellPadding="4" DataKeyNames="ProductID" DataSourceID="SqlDataSource2">
                <EditRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="#663399" />
                <Fields>
                    <asp:BoundField DataField="ProductID" HeaderText="ProductID" InsertVisible="False" ReadOnly="True" SortExpression="ProductID" />
                    <asp:BoundField DataField="ProductName" HeaderText="ProductName" SortExpression="ProductName" />
                    <asp:BoundField DataField="SupplierID" HeaderText="SupplierID" SortExpression="SupplierID" />
                    <asp:BoundField DataField="CategoryID" HeaderText="CategoryID" SortExpression="CategoryID" />
                    <asp:BoundField DataField="QuantityPerUnit" HeaderText="QuantityPerUnit" SortExpression="QuantityPerUnit" />
                    <asp:BoundField DataField="UnitPrice" HeaderText="UnitPrice" SortExpression="UnitPrice" />
                    <asp:BoundField DataField="UnitsInStock" HeaderText="UnitsInStock" SortExpression="UnitsInStock" />
                    <asp:BoundField DataField="UnitsOnOrder" HeaderText="UnitsOnOrder" SortExpression="UnitsOnOrder" />
                    <asp:BoundField DataField="ReorderLevel" HeaderText="ReorderLevel" SortExpression="ReorderLevel" />
                    <asp:CheckBoxField DataField="Discontinued" HeaderText="Discontinued" SortExpression="Discontinued" />
                </Fields>
                <FooterStyle BackColor="#FFFFCC" ForeColor="#330099" />
                <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="#FFFFCC" />
                <PagerStyle BackColor="#FFFFCC" ForeColor="#330099" HorizontalAlign="Center" />
                <RowStyle BackColor="White" ForeColor="#330099" />
             </asp:DetailsView>
             <br />
             <asp:SqlDataSource ID="sourceCustomers" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [CustomerID], [ContactName], [CompanyName] FROM [Customers] ORDER BY [ContactName]"></asp:SqlDataSource>
             <br />
             <asp:DropDownList ID="lstCustomers" runat="server" AutoPostBack="True" DataSourceID="sourceCustomers" DataTextField="ContactName" DataValueField="CustomerID">
             </asp:DropDownList>
             <br />
             <br />
             <br />
             <asp:SqlDataSource ID="sourceCustomersID" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                 OnSelected="sourceCustomersID_Selected" 
                 OnSelecting="sourceCustomersID_Selecting"
                 SelectCommand="SELECT [OrderID], [CustomerID], [ShippedDate], [OrderDate] FROM [Orders] WHERE (([CustomerID] = @CustomerID) AND ([OrderDate] &gt; @OrderDate))">
                 <SelectParameters>
                     <asp:ControlParameter ControlID="lstCustomers" Name="CustomerID" PropertyName="SelectedValue" Type="String" />
                     <asp:Parameter Name="OrderDate" Type="DateTime" />
                 </SelectParameters>
             </asp:SqlDataSource>
             <br />
            <!--
                Consideramos dos controles para almacenar datos de la base de datos NorthWnd

                El primero seria un tipo List con todos los clientes, extraidos de la tabla Customers Una vez seleccionado un cliente,
                se hace un postback automatico y todas las ordenes de pedido hechas por ese cliente (tabla Orders se muestran en
                un segundo control GridView

                En el GridView mostraremos los campos OrderID OrderDate y ShippedDate de la table Orders

                Usaremos dos SqlDataSource uno para el tipo List y otro para el GridView

                Finalmente definiremos un parametro OrderDate para mostrar las ordenes de pedido con un determinado rango
                temporal, en este caso con una fecha posterior a la que decidamos
                -->
             <asp:GridView ID="gridOrders" runat="server" AutoGenerateColumns="False" DataKeyNames="OrderID" DataSourceID="sourceCustomersID">
                 <Columns>
                     <asp:BoundField DataField="OrderID" HeaderText="OrderID" InsertVisible="False" ReadOnly="True" SortExpression="OrderID" />
                     <asp:BoundField DataField="CustomerID" HeaderText="CustomerID" SortExpression="CustomerID" />
                     <asp:BoundField DataField="ShippedDate" HeaderText="ShippedDate" SortExpression="ShippedDate" />
                     <asp:BoundField DataField="OrderDate" HeaderText="OrderDate" SortExpression="OrderDate" />
                 </Columns>
             </asp:GridView>
             <br />
             <asp:Label ID="lblError" runat="server" Text="Label"></asp:Label>
        </div>
    </form>
</body>
</html>
