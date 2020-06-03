<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SqlDataSourceUpdate.aspx.cs" Inherits="datasource1.SqlDataSourceUpdate" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
             <br />
            <br />
            <asp:ListBox ID="ListBox1" runat="server" DataSourceID="sourceProducts" DataTextField="ProductName" DataValueField="ProductID" AutoPostBack="True" Height="100px"></asp:ListBox>
            <!--un listbox que tiene que tener un datasource id con el mismo nombre que el sqldatasource de abajo, ahora su datasource para hacer el select-->
            <asp:SqlDataSource ID="sourceProducts" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [ProductID], [ProductName] FROM [Products]"></asp:SqlDataSource>
            <br />
            <br />
            <!--un sqldata source para hacer un update, antes tiene un select para poder ver lo que queremos cambiar-->
            <asp:SqlDataSource ID="sourceProductDetails" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                SelectCommand="SELECT [ProductID], [ProductName], [QuantityPerUnit], [UnitPrice], [UnitsInStock], [UnitsOnOrder], [ReorderLevel], [Discontinued] FROM [Products] WHERE ([ProductID] = @ProductID)" 
                UpdateCommand="UPDATE [Products] SET [ProductName] = @ProductName, [QuantityPerUnit] = @QuantityPerUnit, [UnitPrice] = @UnitPrice, [UnitsInStock] = @UnitsInStock, [UnitsOnOrder] = @UnitsOnOrder, [ReorderLevel] = @ReorderLevel, [Discontinued] = @Discontinued WHERE [ProductID] = @ProductID">
                 <SelectParameters>
                     <!-- un controlparameter con el nombre de la lista en el control id y en propertyname selected value-->
                    <asp:ControlParameter ControlID="ListBox1" Name="ProductID" PropertyName="SelectedValue" Type="Int32" />
                </SelectParameters>
             </asp:SqlDataSource>
            <br />
            <br />
            <!--un detailview con un datasourceid que tiene el nombre delsqldatasource de justo arriba-->
            <asp:DetailsView ID="DetailsView1" runat="server" AutoGenerateEditButton="True" DataSourceID="sourceProductDetails" Height="50px" Width="125px">
            </asp:DetailsView>
            <br />
            <br />
            <br />
            <br />
            <br />
            <asp:ListBox ID="ListBox2" runat="server" AutoPostBack="True" DataSourceID="RegionID" DataTextField="RegionDescription" DataValueField="RegionID"></asp:ListBox>
            <asp:SqlDataSource ID="RegionID" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [RegionID], [RegionDescription] FROM [Region]"></asp:SqlDataSource>
            <br />
            <br />
            <asp:SqlDataSource ID="DetailsRegion" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                DeleteCommand="DELETE FROM [Region] WHERE [RegionID] = @RegionID" 
                InsertCommand="INSERT INTO [Region] ([RegionID], [RegionDescription]) VALUES (@RegionID, @RegionDescription)" 
                SelectCommand="SELECT [RegionID], [RegionDescription] FROM [Region] WHERE ([RegionID] = @RegionID)"
                UpdateCommand="UPDATE [Region] SET [RegionDescription] = @RegionDescription WHERE [RegionID] = @RegionID" 
                OnInserted="DetailsRegion_Inserted" >
                 <InsertParameters>
                    <asp:Parameter Name="RegionID" Type="Int32" />
                    <asp:Parameter Name="RegionDescription" Type="String" />
                </InsertParameters>
                <SelectParameters>
                    <asp:ControlParameter ControlID="ListBox2" Name="RegionID" PropertyName="SelectedValue" Type="Int32" />
                </SelectParameters>
              </asp:SqlDataSource>
            <br />
            <asp:DetailsView ID="DetailsView2" runat="server" DataSourceID="DetailsRegion" Height="50px" Width="125px">
                <Fields>
                    <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" ShowInsertButton="True" />
                </Fields>
            </asp:DetailsView>
            <br />
            <br />
        </div>
    </form>
</body>
</html>
