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
         <asp:SqlDataSource ID="sourceCategories" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [Categories]"></asp:SqlDataSource>
            <br />
            <br />
            <asp:GridView ID="GridView1" runat="server" DataKeyNames="CategoryID" DataSourceID="sourceCategories">
                <Columns>
                    <asp:CommandField ButtonType="Button" ShowSelectButton="True" />
                </Columns>
                <SelectedRowStyle BorderColor="Red" BorderStyle="Dashed" />
            </asp:GridView>
        </div>
        <p>
            <asp:SqlDataSource ID="sourceProducts" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [ProductID], [ProductName], [CategoryID], [UnitPrice] FROM [Products] WHERE ([CategoryID] = @CategoryID)">
                <SelectParameters>
                    <asp:ControlParameter ControlID="GridView1" Name="CategoryID" PropertyName="SelectedDataKey.Value" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
        </p>
        <p>
            <asp:GridView ID="GridView2" runat="server" DataSourceID="sourceProducts">
            </asp:GridView>
        </p>
        <p>
            &nbsp;</p>
        <p>
            &nbsp;</p>
        
    </form>
</body>
</html>
