<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GridViewPractica1_2.aspx.cs" Inherits="datasource1.GridViewPractica1_2" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                SelectCommand="SELECT [ProductID], [ProductName], [UnitPrice], [QuantityPerUnit] FROM [Products]"></asp:SqlDataSource>
        </div>
        <!--
           - destacar q tiene un ShowFooter="True"
            despues el <FooterStyle BorderStyle="Double" Font-Bold="True" />
           - <ItemStyle BorderStyle="Dashed" /> para poner con rayas LAS FILAS
            - <ControlStyle BorderStyle="Dashed" />
                <HeaderStyle BackColor="Lime" BorderStyle="Dotted" /> ESTO ES PARA EL HEADER SOLO

            -->
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
            DataKeyNames="ProductID" DataSourceID="SqlDataSource1" ShowFooter="True">
            <Columns>
                <asp:BoundField DataField="ProductID" FooterText="Identifier" 
                 HeaderText="ProductID" InsertVisible="False" ReadOnly="True" SortExpression="ProductID">
                <FooterStyle BorderStyle="Double" Font-Bold="True" />
                <ItemStyle BorderStyle="Dashed" />
                </asp:BoundField>
                <asp:BoundField DataField="ProductName" HeaderText="ProductName" SortExpression="ProductName" />
                <asp:BoundField DataField="UnitPrice" DataFormatString="{0:C}" HeaderText="UnitPrice" SortExpression="UnitPrice" />
                <asp:BoundField DataField="QuantityPerUnit" HeaderText="QuantityPerUnit" SortExpression="QuantityPerUnit">
                <ControlStyle BorderStyle="Dashed" />
                <HeaderStyle BackColor="Lime" BorderStyle="Dotted" />
                </asp:BoundField>
            </Columns>
        </asp:GridView>
        <br />
        <br />
        <asp:SqlDataSource ID="SqlOrders" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [OrderID], [CustomerID], [OrderDate], [ShipAddress], [ShippedDate] FROM [Orders]"></asp:SqlDataSource>
        <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>
        <br />
        <br />
        <!--
            el grid tiene 3 funciones que actuarán dos en el label de arriba
            -Agregamos GridView y añadimos una columna tipo CommandField con
            ShowSelectButton a true y el texto del boton a “seleccion"
            <asp: CommandField ShowSelectButton ="true" ButtonType ="button"
            SelectText ="seleccionar“/>

            - Programamos eventos relacionados con la selección y con el relleno de los datos
            en el GridView

                SelectedIndexChanging: Cancelamos la selección si CustomerID es ="hanar“

                SelectedIndexChanged: Mostramos en Label que CustomerID se ha seleccionado

                RowDataBound: Asignamos un color diferente a determinadas filas del GridView
            -->
        <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" DataKeyNames="OrderID" DataSourceID="SqlOrders" OnRowDataBound="GridView2_RowDataBound" OnSelectedIndexChanged="GridView2_SelectedIndexChanged" OnSelectedIndexChanging="GridView2_SelectedIndexChanging">
            <Columns>
                <asp:CommandField ShowSelectButton="True" />
                <asp:BoundField DataField="OrderID" HeaderText="OrderID" InsertVisible="False" ReadOnly="True" SortExpression="OrderID" />
                <asp:BoundField DataField="CustomerID" HeaderText="CustomerID" SortExpression="CustomerID" />
                <asp:BoundField DataField="OrderDate" HeaderText="OrderDate" SortExpression="OrderDate" />
                <asp:BoundField DataField="ShipAddress" HeaderText="ShipAddress" SortExpression="ShipAddress" />
                <asp:BoundField DataField="ShippedDate" HeaderText="ShippedDate" SortExpression="ShippedDate" />
                <asp:CommandField ButtonType="Button" SelectText="Seleccionar" />
            </Columns>
        </asp:GridView>
        
        <!--
            La otra forma de seleccionar una fila no requiere (CON BUTTONFIELD)
            añadir una nueva columna, podemos utilizar una
            columna existente para ello (A DIFERENCIA DEL DE ARRIBA QUE USA UN COMMANDFIELD
            
            Para ello, eliminamos la columna tipo
            CommandField y añadimos una columna tipo
            ButtonField y asignamos la propiedad DataTextField
            al nombre del campo que queramos usar como
            botón

             Utilizaremos el evento
            GridView RowCommand el cual s e produce
            cuando se hace click en el botón que hemos
            creado antes en el control Aprovecharemos
            que un ButtonField puede invocar algunas
            funciones definidas en CommandName por
            ejemplo Select, y ser por gestionado por
            codigo El argumento del CommandName es
            el indice de la fila seleccionada


            -tiene una funcion que actua en el label de arriba justo
            - <asp:ButtonField CommandName="Select" DataTextField="OrderID" Text="Botón" />
            ese boton activa la funcion, el commandname es usado en la funcion para la comprobacion
            if del principio, si tiene el valor "select" entonces empieza la funcion  if (e.CommandName == "Select")
            el DataTextField="OrderID" corresponde en la funcion al commandargument-> int index = Convert.ToInt32(e.CommandArgument);
            y también es lo que se muestra como texto en el boton

           
            -->
        <br />
        <asp:Label ID="Label2" runat="server" Text="Label"></asp:Label>
        <br />
        <asp:GridView ID="GridView3" runat="server" AutoGenerateColumns="False" DataKeyNames="OrderID" DataSourceID="SqlOrders" OnRowCommand="GridView3_RowCommand">
            <Columns>
                <asp:BoundField DataField="OrderID" HeaderText="OrderID" InsertVisible="False" ReadOnly="True" SortExpression="OrderID" />
                <asp:BoundField DataField="CustomerID" HeaderText="CustomerID" SortExpression="CustomerID" />
                <asp:BoundField DataField="OrderDate" HeaderText="OrderDate" SortExpression="OrderDate" />
                <asp:BoundField DataField="ShipAddress" HeaderText="ShipAddress" SortExpression="ShipAddress" />
                <asp:BoundField DataField="ShippedDate" HeaderText="ShippedDate" SortExpression="ShippedDate" />
                <asp:ButtonField CommandName="Select" DataTextField="OrderID" Text="Botón" />
            </Columns>
        </asp:GridView>
    </form>
</body>
</html>
