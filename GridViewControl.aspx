<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GridViewControl.aspx.cs" Inherits="datasource1.GridViewControl" %>

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


                - se crea el sqldatasource para hacer un select;
                el id se usa despues en el gridview para vincularlo (con el datasourceid)
                el datakeyname en gridview es la clave primaria
                
                - se crear otro sqldatasorce para hacer select

                -un gridview para mostrar el select del primer sqldatasource
                datasource para llamar al primersql
                    OnRowDataBound="GridView1_RowDataBound" para llamar a la funcion del .cs, es una funcion que te enseña el precio
                     con un color, si es mayor de 50 le pone otro color

                - un label para dos funciones del gridview2

                - un gridview2 vinculado al segundosql
                    tiene tres funciones OnSelectedIndexChanged="GridView2_SelectedIndexChanged" 
                    OnSelectedIndexChanging="GridView2_SelectedIndexChanging" OnRowDataBound="GridView2_RowDataBound"
                   GridView2_SelectedIndexChanging: no permite seleccionar el elemento hanar y te enseña un mensaje de error
                    GridView2_SelectedIndexChanged: pone en el label lo seleccionado
                    GridView2_RowDataBound: cambiar el estilo para aquellos con datetime

                - abajo ambos gridview tienen los estilos que se aplicaran cuando seleccionemos una opcion

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
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="ProductID" 
                DataSourceID="sourceProducts" OnRowDataBound="GridView1_RowDataBound">
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
                    <asp:ButtonField ButtonType="Button" DataTextField="ProductID" Text="Botón" CommandName="Select" />
                </Columns>
                <HeaderStyle BackColor="#CCFFCC" BorderColor="#990000" />
                <SelectedRowStyle BorderColor="#FF9900" BorderStyle="Dotted" Font-Bold="True" />
            </asp:GridView>
            <!--
                Selecting o seleccionando un item se refiere a la posibilidad de
                hacer click en una fila y cambiar su color o alguna propiedad e
                indicar que el usuario esta trabajando con esa fila del GridView
                Primero temenos que definir un Style diferente para la fila
                seleccionada Para ello usaremos la propiedad SelectedRowStyle

                -->
            <br />
            <br />

            <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>

            <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" DataKeyNames="OrderID" DataSourceID="sourceOrders" 
                OnSelectedIndexChanged="GridView2_SelectedIndexChanged" 
                OnSelectedIndexChanging="GridView2_SelectedIndexChanging" OnRowDataBound="GridView2_RowDataBound">
                <Columns>
                    <asp:CommandField ButtonType="Button" ShowSelectButton="True" />
                    <asp:BoundField DataField="OrderID" HeaderText="Identificador" InsertVisible="False" ReadOnly="True" SortExpression="OrderID" />
                    <asp:BoundField DataField="CustomerID" HeaderText="Identificador Cliente" SortExpression="CustomerID" />
                    <asp:BoundField DataField="OrderDate" DataFormatString="{0:F}" HeaderText="OrderDate" SortExpression="OrderDate" />
                    <asp:BoundField DataField="ShipAddress" HeaderText="ShipAddress" SortExpression="ShipAddress" />
                    <asp:BoundField DataField="ShippedDate" HeaderText="ShippedDate" SortExpression="ShippedDate" />
                </Columns>
                <HeaderStyle BackColor="#9999FF" Font-Bold="True" BorderStyle="Dashed" />
                <RowStyle BackColor="#CCFF99" BorderColor="Red" />
                <SelectedRowStyle BorderColor="#0033CC" BorderStyle="Groove" BorderWidth="5px" Font-Bold="True" />
            </asp:GridView>
            <br />
            <br />
        </div>
    </form>
</body>
</html>
