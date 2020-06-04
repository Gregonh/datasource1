<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MoreUpdateInsertDelete.aspx.cs" Inherits="datasource1.MoreUpdateInsertDelete" %>

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
                añadimos listbox
                necesitamos dos sqldatasource; uno para rellenar la lista (con el select que hace) y otro para poder hacer los insert, update y delete.
                el id es usado en los controlparameter de cada tipo:insert, delete, update
                el datasourceid utiliza el id del primer sqldatasource que llena la lista con el select.

                el segundo sqldatasource es para hacer delete, insert y update

                despues un detailsview; que tiene un datakeysnames con el datavaluefield del listbox
                un datasourceid con el segundosqldatasource para almacenar los resultados de las consultas insert, update delete...


                
                -->
            <asp:ListBox ID="ListBox1" runat="server" AutoPostBack="True" DataSourceID="SqlDataTerritories" DataTextField="TerritoryDescription" DataValueField="TerritoryID"></asp:ListBox>
            <br />
            <asp:SqlDataSource ID="SqlDataTerritories" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [TerritoryID], [TerritoryDescription] FROM [Territories]"></asp:SqlDataSource>
            <br />
            <br />
            <br />
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" DeleteCommand="DELETE FROM [Territories] WHERE [TerritoryID] = @TerritoryID" InsertCommand="INSERT INTO [Territories] ([TerritoryID], [TerritoryDescription], [RegionID]) VALUES (@TerritoryID, @TerritoryDescription, @RegionID)" SelectCommand="SELECT * FROM [Territories] WHERE ([TerritoryID] = @TerritoryID)" UpdateCommand="UPDATE [Territories] SET [TerritoryDescription] = @TerritoryDescription, [RegionID] = @RegionID WHERE [TerritoryID] = @TerritoryID">
                <DeleteParameters>
                    <asp:ControlParameter ControlID="ListBox1" Name="TerritoryID" PropertyName="SelectedValue" Type="String" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="TerritoryID" Type="String" />
                    <asp:Parameter Name="TerritoryDescription" Type="String" />
                    <asp:Parameter Name="RegionID" Type="Int32" />
                </InsertParameters>
                <SelectParameters>
                    <asp:ControlParameter ControlID="ListBox1" Name="TerritoryID" PropertyName="SelectedValue" Type="String" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="TerritoryDescription" Type="String" />
                    <asp:Parameter Name="RegionID" Type="Int32" />
                    <asp:Parameter Name="TerritoryID" Type="String" />
                </UpdateParameters>
            </asp:SqlDataSource>
            <br />
            <asp:DetailsView ID="DetailsView1" runat="server" AutoGenerateRows="False" DataKeyNames="TerritoryID" DataSourceID="SqlDataSource1" Height="50px" Width="125px">
                <Fields>
                    <asp:BoundField DataField="TerritoryID" HeaderText="TerritoryID" ReadOnly="True" SortExpression="TerritoryID" />
                    <asp:BoundField DataField="TerritoryDescription" HeaderText="TerritoryDescription" SortExpression="TerritoryDescription" />
                    <asp:BoundField DataField="RegionID" HeaderText="RegionID" SortExpression="RegionID" />
                    <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" ShowInsertButton="True" />
                </Fields>
            </asp:DetailsView>
            <br />
        </div>
    </form>
</body>
</html>
