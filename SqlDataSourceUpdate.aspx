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
            <!-- SqlDataSource puede también aplicar cambios a la base de datos

            No todos los controles soportan esta capacidad por ejemplo los tipo List como ListBox etc
                
                Siempre que hagamos esto y le pongamos el simbolo @(ProductName se convierte en @ProductName
                necesitamos definir el parámetro explicitamente ya que los controles de datos de ASP net automáticamente
                los rellenar á n con los valores de la base de datos en caso de SQL Update) para permitirnos su modificación
                Por otro lado necesitamos activar esta capacidad en el control de datos por ejemplo DetailsView La
                propiedad AutoGenerateEditButton true
                -->

            <asp:ListBox ID="ListBox1" runat="server" DataSourceID="sourceProducts" DataTextField="ProductName" DataValueField="ProductID" AutoPostBack="True" Height="100px"></asp:ListBox>
            <!--un listbox que tiene que tener un datasource id con el mismo nombre que el sqldatasource de abajo, ahora su datasource para hacer el select. Tiene que tener un datavalueField con el mismo nombre
                que el controlParameter de abajo
                
                Definimos dos controles SQLDataSource

                Uno que sirva como fuente de datos del
                control tipo List y que seleccione los campos
                ProductName y ProductID de la tabla Products

                Otro que sirva para recuperar la fila de la tabla
                Products que tenga como ProductID el
                seleccionado en la lista anterior (se ve el el select parameter) y que nos
                permita también actualizer los campos Este
                SQLDataSource servirá como Fuente de datos
                del control DetailsView
                -->
            <asp:SqlDataSource ID="sourceProducts" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [ProductID], [ProductName] FROM [Products]"></asp:SqlDataSource>
            <br />
            <br />
            <!--un sqldata source para hacer un update, antes tiene un select para poder ver lo que queremos cambiar-->


             <!--
                Cuando actualizamos datos tenemos el riesgo de que haya un problema de concurrencia si elegimos modificar un
                registro que estan siendo editado por otro usuario

                Una técnica para solucionar esto consiste en hacer un commando UPDATE con una clausula WHERE donde todos los
                campos del registro sean iguales a los que se seleccionaron inicialmente al mostrar el regsistro
                UPDATE [Products]
                SET [ ProductName]= @ProductName,  [QuantityPerUnit] =  @QuantityPerUnit (... y el resto de campo como los anteriores)
                WHERE [ProductID]= @ProductID AND ProductName=@original_ProductName AND UnitPrice= @original_UnitPrice
                AND
                UnitsInStock= @original_UnitsInStock (.. y resto de campos igual con And y lo otro)
                Antes de que este commando funcione debemos indicarle al SqlDataSource que mantenga los valores antiguos y que
                los asigne a los parametros cuyo nombre empiezan por original_
                
                Haremos esto mediante dos propiedades
                ConflictDetection = "CompareAllValues" // por defecto es OverwriteChanges
                OldValuesParameterFormatString ="original_{0}"
                
                // SqlDataSource no lanza una excepción para notificar si el UPDATE no se ha realizado
                Necesitamos manejar el evento Updated y comprobar la propiedad
                SqlDataSourceStatusEventArgs AffectedRows

                Si es este valor es 0 no se ha actualizado ning ú n registro y deberiamos notificar al
                usuario sobre un posible problema de concurrencia e intentar el Update de nuevo,
                una vez cargado el registro nuevamente
                
                
                -->

            <asp:SqlDataSource ID="sourceProductDetails" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
                SelectCommand="SELECT [ProductID], [ProductName], [QuantityPerUnit], [UnitPrice], [UnitsInStock], [UnitsOnOrder], [ReorderLevel], [Discontinued] FROM [Products] WHERE ([ProductID] = @ProductID)" 
               UpdateCommand="UPDATE [Products] SET [ProductName] = @ProductName, [QuantityPerUnit] = @QuantityPerUnit,
                              [UnitPrice] = @UnitPrice, [UnitsInStock] = @UnitsInStock, [UnitsOnOrder] = @UnitsOnOrder,
                             [ReorderLevel] = @ReorderLevel, [Discontinued] = @Discontinued
                              WHERE [ProductID] = @ProductID
                              AND ProductName=@original_ProductName AND UnitPrice=@original_UnitPrice 
                              AND UnitsInStock=@original_UnitsInStock AND UnitsOnOrder=@original_UnitsOnOrder 
                              AND ReorderLevel=@original_ReorderLevel AND Discontinued=@original_Discontinued" 
                ConflictDetection="CompareAllValues"
                OldValuesParameterFormatString="original_{0}"
                OnUpdated="sourceProductDetails_Updated"> 
                 <SelectParameters>
                    <asp:ControlParameter ControlID="ListBox1" Name="ProductID" PropertyName="SelectedValue" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
             <!-- un controlparameter con el nombre de la lista en el control id y en propertyname selected value-->
            <br />
            <br />
            <!--un detailview con un datasourceid que tiene el nombre delsqldatasource de justo arriba
                Usar un control DetailsView permite mostrar una
                fila por cada campo de la tabla que hayamos
                obtenido Siempre que la propiedad
                AutoGenerateRows true
                
                -->
            <asp:DetailsView ID="DetailsView1" runat="server" AutoGenerateEditButton="True" DataSourceID="sourceProductDetails" Height="50px" Width="125px">
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
                    <asp:CommandField ShowDeleteButton="True" ShowInsertButton="True" />
                </Fields>
            
            
            </asp:DetailsView>
            
            <asp:SqlDataSource ID="sourceProductDetailsNew" runat="server" 
                  ConflictDetection="CompareAllValues" 
                  ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                  OldValuesParameterFormatString="original_{0}" 
                  SelectCommand="SELECT * FROM [Products] WHERE ([ProductID] = @ProductID)"
                  UpdateCommand="UPDATE [Products] SET [ProductName] = @ProductName, [SupplierID] = @SupplierID, [CategoryID] = @CategoryID, [QuantityPerUnit] = @QuantityPerUnit, [UnitPrice] = @UnitPrice, [UnitsInStock] = @UnitsInStock, [UnitsOnOrder] = @UnitsOnOrder, [ReorderLevel] = @ReorderLevel, [Discontinued] = @Discontinued WHERE [ProductID] = @original_ProductID AND [ProductName] = @original_ProductName AND (([SupplierID] = @original_SupplierID) OR ([SupplierID] IS NULL AND @original_SupplierID IS NULL)) AND (([CategoryID] = @original_CategoryID) OR ([CategoryID] IS NULL AND @original_CategoryID IS NULL)) AND (([QuantityPerUnit] = @original_QuantityPerUnit) OR ([QuantityPerUnit] IS NULL AND @original_QuantityPerUnit IS NULL)) AND (([UnitPrice] = @original_UnitPrice) OR ([UnitPrice] IS NULL AND @original_UnitPrice IS NULL)) AND (([UnitsInStock] = @original_UnitsInStock) OR ([UnitsInStock] IS NULL AND @original_UnitsInStock IS NULL)) AND (([UnitsOnOrder] = @original_UnitsOnOrder) OR ([UnitsOnOrder] IS NULL AND @original_UnitsOnOrder IS NULL)) AND (([ReorderLevel] = @original_ReorderLevel) OR ([ReorderLevel] IS NULL AND @original_ReorderLevel IS NULL)) AND [Discontinued] = @original_Discontinued" 
                  OnUpdated="sourceProductDetails_Updated" DeleteCommand="DELETE FROM [Products] WHERE [ProductID] = @original_ProductID AND [ProductName] = @original_ProductName AND (([SupplierID] = @original_SupplierID) OR ([SupplierID] IS NULL AND @original_SupplierID IS NULL)) AND (([CategoryID] = @original_CategoryID) OR ([CategoryID] IS NULL AND @original_CategoryID IS NULL)) AND (([QuantityPerUnit] = @original_QuantityPerUnit) OR ([QuantityPerUnit] IS NULL AND @original_QuantityPerUnit IS NULL)) AND (([UnitPrice] = @original_UnitPrice) OR ([UnitPrice] IS NULL AND @original_UnitPrice IS NULL)) AND (([UnitsInStock] = @original_UnitsInStock) OR ([UnitsInStock] IS NULL AND @original_UnitsInStock IS NULL)) AND (([UnitsOnOrder] = @original_UnitsOnOrder) OR ([UnitsOnOrder] IS NULL AND @original_UnitsOnOrder IS NULL)) AND (([ReorderLevel] = @original_ReorderLevel) OR ([ReorderLevel] IS NULL AND @original_ReorderLevel IS NULL)) AND [Discontinued] = @original_Discontinued" InsertCommand="INSERT INTO [Products] ([ProductName], [SupplierID], [CategoryID], [QuantityPerUnit], [UnitPrice], [UnitsInStock], [UnitsOnOrder], [ReorderLevel], [Discontinued]) VALUES (@ProductName, @SupplierID, @CategoryID, @QuantityPerUnit, @UnitPrice, @UnitsInStock, @UnitsOnOrder, @ReorderLevel, @Discontinued)">
                    <DeleteParameters>
                        <asp:Parameter Name="original_ProductID" Type="Int32" />
                        <asp:Parameter Name="original_ProductName" Type="String" />
                        <asp:Parameter Name="original_SupplierID" Type="Int32" />
                        <asp:Parameter Name="original_CategoryID" Type="Int32" />
                        <asp:Parameter Name="original_QuantityPerUnit" Type="String" />
                        <asp:Parameter Name="original_UnitPrice" Type="Decimal" />
                        <asp:Parameter Name="original_UnitsInStock" Type="Int16" />
                        <asp:Parameter Name="original_UnitsOnOrder" Type="Int16" />
                        <asp:Parameter Name="original_ReorderLevel" Type="Int16" />
                        <asp:Parameter Name="original_Discontinued" Type="Boolean" />
                    </DeleteParameters>
                    <InsertParameters>
                        <asp:Parameter Name="ProductName" Type="String" />
                        <asp:Parameter Name="SupplierID" Type="Int32" />
                        <asp:Parameter Name="CategoryID" Type="Int32" />
                        <asp:Parameter Name="QuantityPerUnit" Type="String" />
                        <asp:Parameter Name="UnitPrice" Type="Decimal" />
                        <asp:Parameter Name="UnitsInStock" Type="Int16" />
                        <asp:Parameter Name="UnitsOnOrder" Type="Int16" />
                        <asp:Parameter Name="ReorderLevel" Type="Int16" />
                        <asp:Parameter Name="Discontinued" Type="Boolean" />
                    </InsertParameters>
                    <SelectParameters>
                      <asp:ControlParameter ControlID="ListBox1" Name="ProductID" PropertyName="SelectedValue" Type="Int32" />
                  </SelectParameters>
                  <UpdateParameters>
                      <asp:Parameter Name="ProductName" Type="String" />
                      <asp:Parameter Name="SupplierID" Type="Int32" />
                      <asp:Parameter Name="CategoryID" Type="Int32" />
                      <asp:Parameter Name="QuantityPerUnit" Type="String" />
                      <asp:Parameter Name="UnitPrice" Type="Decimal" />
                      <asp:Parameter Name="UnitsInStock" Type="Int16" />
                      <asp:Parameter Name="UnitsOnOrder" Type="Int16" />
                      <asp:Parameter Name="ReorderLevel" Type="Int16" />
                      <asp:Parameter Name="Discontinued" Type="Boolean" />
                      <asp:Parameter Name="original_ProductID" Type="Int32" />
                      <asp:Parameter Name="original_ProductName" Type="String" />
                      <asp:Parameter Name="original_SupplierID" Type="Int32" />
                      <asp:Parameter Name="original_CategoryID" Type="Int32" />
                      <asp:Parameter Name="original_QuantityPerUnit" Type="String" />
                      <asp:Parameter Name="original_UnitPrice" Type="Decimal" />
                      <asp:Parameter Name="original_UnitsInStock" Type="Int16" />
                      <asp:Parameter Name="original_UnitsOnOrder" Type="Int16" />
                      <asp:Parameter Name="original_ReorderLevel" Type="Int16" />
                      <asp:Parameter Name="original_Discontinued" Type="Boolean" />
                  </UpdateParameters>
              </asp:SqlDataSource>
              <br />
              <br />
              <br />
            
            
            
            
            
            
            
            <br />
            <br />
             <asp:Label ID="lblInfo" runat="server" Text="Label"></asp:Label>
            <br />
            <br />
            <br />
            <!-- por ahora funciona solo el update para cambiar el nombre de la region-->
            <!--el listbox tiene el datesourceid con el mismo nombre que el sqldatasource y hace un select;
                un datavalueField con el nombre del parametro del insertParameter, pero no estoy seguro-->
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
