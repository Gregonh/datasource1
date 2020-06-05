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
                y rellena el segundo gridview con él. 
                CON LA EXTENSION DEL EJERCICIO: el segundo sqldatasource también hace un update con la var que le llega

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
                Y EN LA EXTENSION DEL EJERCICIO HACE UN UPDATE TAMBIEN

                -un segundo gridview que muestra el select del segundo sqldatasource
                    
                
                -->
         <asp:SqlDataSource ID="sourceCategories" runat="server" 
             ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
             SelectCommand="SELECT * FROM [Categories]"></asp:SqlDataSource>
            <br />
            <br />
            <!--
                DataKeyNames CategoryID -> sigue la pista de la fila seleccionada
                -activa la funcion GridView1_SelectedIndexChanged que muestra en el label de abajo
                el id del producto seleccionado
                - tiene un footer y un selectedrowstyle para cambiar el estilo de la fila seleccionada
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
                En el SqlDataSource ID="sourceProducts" que sirve como fuente de datos del segundo GridView 
                el parámetro debe hacer referencia a este DataKeyName
                PropertyName="SelectedDataKey.Value"

                AHORA NO SE USA

                <asp:SqlDataSource ID="sourceProducts" runat="server" 
                ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                SelectCommand="SELECT [ProductID], [ProductName], [CategoryID], [UnitPrice] FROM [Products] 
                WHERE ([CategoryID] = @CategoryID)">
                <SelectParameters>
                    <asp:ControlParameter ControlID="GridView1" Name="CategoryID" PropertyName="SelectedDataKey.Value" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>

                -->
            
        </p>

         <p>
             <!--
                 otro sqldatasource que utiliza la var seleccionada del primer gridview para hacer un select y con ese select hacer 
                 un update
                 
                 --->
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                SelectCommand="SELECT [ProductID], [SupplierID], [ProductName], [UnitPrice] FROM [Products] WHERE ([CategoryID] = @CategoryID)" 
                UpdateCommand="UPDATE [Products] SET [SupplierID] = @SupplierID, [ProductName] = @ProductName, [UnitPrice] = @UnitPrice 
                WHERE ([ProductID] = @ProductID)">
                 <SelectParameters>
                    <asp:ControlParameter ControlID="GridView1" Name="CategoryID" PropertyName="SelectedDataKey.Value" Type="Int32" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="SupplierID" Type="Int32" />
                    <asp:Parameter Name="ProductName" Type="String" />
                    <asp:Parameter Name="UnitPrice" Type="Decimal" />
                    <asp:Parameter Name="ProductID" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>
        </p>
        <!--
            AHORA NO SE USA
        <p>
            <asp:SqlDataSource ID="SqlDataSource2" runat="server"
                ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                SelectCommand="SELECT [ProductID], [ProductName], [SupplierID], [UnitPrice], [UnitsInStock] FROM [Products] WHERE ([CategoryID] = @CategoryID)" 
                UpdateCommand="UPDATE [Products] SET [ProductName] = @ProductName, [SupplierID] = @SupplierID, [UnitPrice] = @UnitPrice, [UnitsInStock] = @UnitsInStock WHERE [ProductID] = @ProductID">
                <SelectParameters>
                    <asp:ControlParameter ControlID="GridView1" Name="CategoryID" PropertyName="SelectedDataKey.Value" Type="Int32" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="ProductName" Type="String" />
                    <asp:Parameter Name="SupplierID" Type="Int32" />
                    <asp:Parameter Name="UnitPrice" Type="Decimal" />
                    <asp:Parameter Name="UnitsInStock" Type="Int16" />
                    <asp:Parameter Name="ProductID" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>

        </p>-->
        <p>
            &nbsp;</p>


        <p>
            <!--<asp:CommandField ShowEditButton="True" />
                para mostrar los botones de actualizar o cancelar y cargar el updateparameter
                por eso tiene DataKeyNames="ProductID" para poder cargar el update de la fila seleccionada
                tener en cuenta que si le damos al gridview editar columnas > podemos poner la columnas que queremos
                poder cambiar al hacer el update, habria que cambiar el readonly="true" insertvisible="false" para no
                poder cambiarlo como en el ejemplo de abajo que no nos permite cambiar el id
                -->
            <asp:GridView ID="GridView2" runat="server" DataSourceID="SqlDataSource1" 
                AutoGenerateColumns="False" DataKeyNames="ProductID">
                <Columns>
                    <asp:CommandField ShowEditButton="True" />
                    <asp:BoundField DataField="ProductID" HeaderText="ProductID" InsertVisible="False" ReadOnly="True" SortExpression="ProductID" />
                    <asp:BoundField DataField="SupplierID" HeaderText="SupplierID" SortExpression="SupplierID" />
                    <asp:BoundField DataField="ProductName" HeaderText="ProductName" SortExpression="ProductName" />
                    <asp:BoundField DataField="UnitPrice" HeaderText="UnitPrice" SortExpression="UnitPrice" />
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
