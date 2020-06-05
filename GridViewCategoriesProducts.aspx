<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GridViewCategoriesProducts.aspx.cs" Inherits="datasource1.GridViewCategoriesProducts" %>

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
                tenemos un GridView como primer control desde el cual seleccionar una fila, también podemos seleccionar
                SelectedValue como propiedad para configurar un SqlDataSource pero si tenemos un GridView podemos
                utilizar también un DataKeyName
                Utilizaremos la propiedad DataKeyNames del GridView que de alguna forma sigue la pista 
                de la fila seleccionada en un control de este tipo


                un sqldatasource que manda un select a un gridview,
                el gridview tiene  otro sqldatasource vinculado con el selecparameter (mandando la DataKeyNames="CategoryID"),
                de modo que cuando se seleccione un elemento en el primer grid
                le manda al segundo sqldatasource esa var, este sqldatasource2 hace un select con la datakeyname
                y rellena el segundo gridview con él

                -un sqldatasource que hace un select y rellena un gridview1
                -un gridview1 vinculado al sqldatasource1 para ser rellenado
                    DataKeyNames="CategoryID" DataSourceID="sourceCategories"
                    tiene un boton que mandara el datakeynames a otro sqldatasource2
                    cuando se selecciona algo se cambia el estilo <SelectedRowStyle BorderColor="Red" BorderStyle="Dashed" />
                    con solo poner esto ya nos hace una autofuncion selected <Columns>
                    <asp:CommandField ButtonType="Button" ShowSelectButton="True" />
                </Columns>
                <SelectedRowStyle BorderColor="Red" BorderStyle="Dashed" />

                -un segundo sqldatasource; que hace un select con la var que le mando el gridview1 WHERE ([CategoryID] = @CategoryID)
                    <SelectParameters>
                    <asp:ControlParameter ControlID="GridView1" Name="CategoryID" PropertyName="SelectedDataKey.Value" Type="Int32" />
                </SelectParameters>

                -un segundo gridview que muestra el select del segundo sqldatasource
                    
                
                -->
         <asp:SqlDataSource ID="sourceCategories" runat="server" 
             ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
             SelectCommand="SELECT * FROM [Categories]"></asp:SqlDataSource>
            <br />
            <br />
            <!--
                DataKeyNames CategoryID -> sigue la pista de la fila seleccionada
                -->
            <asp:GridView ID="GridView1" runat="server" DataKeyNames="CategoryID" DataSourceID="sourceCategories"
                OnSelectedIndexChanged="GridView1_SelectedIndexChanged" AutoGenerateColumns="False" ShowFooter="True">
                <Columns>
                    <asp:CommandField ShowSelectButton="True" />
                    <asp:BoundField DataField="CategoryID" HeaderText="CategoryID" InsertVisible="False" ReadOnly="True" SortExpression="CategoryID" FooterText="End Category" />
                    <asp:BoundField DataField="CategoryName" HeaderText="CategoryName" SortExpression="CategoryName" />
                    <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description" />
                </Columns>
                <SelectedRowStyle BorderColor="Red" BorderStyle="Dashed" />
            </asp:GridView>
             <br />
            <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>
        </div>
        <p>
            <!--
                En el SqlDataSource que sirva como fuente de datos del segundo GridView 
                el parámetro debe hacer referencia a este DataKeyName
                PropertyName="SelectedDataKey.Value"


                -->
            <asp:SqlDataSource ID="sourceProducts" runat="server" 
                ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                SelectCommand="SELECT [ProductID], [ProductName], [SupplierID], [UnitPrice], [UnitsInStock] FROM [Products] WHERE ([CategoryID] = @CategoryID)">
                <SelectParameters>
                    <asp:ControlParameter ControlID="GridView1" Name="CategoryID" PropertyName="SelectedValue" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
        </p>
        <p>
            <asp:GridView ID="GridView2" runat="server" DataSourceID="sourceProducts" AutoGenerateColumns="False" DataKeyNames="ProductID">
                <Columns>
                    <asp:BoundField DataField="ProductID" HeaderText="ProductID" ReadOnly="True" InsertVisible="False" SortExpression="ProductID"></asp:BoundField>
                    <asp:BoundField DataField="ProductName" HeaderText="ProductName" SortExpression="ProductName"></asp:BoundField>
                    <asp:BoundField DataField="SupplierID" HeaderText="SupplierID" SortExpression="SupplierID"></asp:BoundField>
                    <asp:BoundField DataField="UnitPrice" HeaderText="UnitPrice" SortExpression="UnitPrice"></asp:BoundField>
                    <asp:BoundField DataField="UnitsInStock" HeaderText="UnitsInStock" SortExpression="UnitsInStock"></asp:BoundField>
                </Columns>
            </asp:GridView>
        </p>
        <p>
            &nbsp;</p>
        <p>
            &nbsp;</p>
        
    </form>
</body>
</html>
