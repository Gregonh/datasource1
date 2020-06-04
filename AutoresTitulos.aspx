<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AutoresTitulos.aspx.cs" Inherits="datasource1.AutoresTitulos" %>

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
               creamos un listbox para enseñar los titulos de los autores al seleccionar un item
               primero creamos el sqldatasource con la conexion string que ya tenemos en el web.config
               en la listbox tenemos un metodo que se acciona al seleccionar una opcion
               por otro lado tenemos tambien un tipo radiobutton que tambien usa el sqldatasource 1 y tiene otra funcion
               
               el datatext es lo que mostramos para seleccionar, y el datavalue otro campo que se mostrará con la funcion
               -->
         <h1>Autores y Titulos</h1>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:ConnectionStringASPNETStepByStep %>" 
            DataSourceMode="DataReader" SelectCommand="SELECT * FROM [DotNetReferences]">
        </asp:SqlDataSource>
        <asp:ListBox ID="ListBox1" runat="server" AutoPostBack="True" 
            onselectedindexchanged="ListBox1_SelectedIndexChanged" Width="150px"></asp:ListBox>
        <br /><br />
        Item seleccionado: <asp:Label ID="Label1" runat="server" Text=""></asp:Label>
        <br /><br />
        <asp:RadioButtonList ID="RadioButtonList1" runat="server" AutoPostBack="True" 
            DataSourceID="SqlDataSource1" DataTextField="AuthorLastName" 
            DataValueField="Title" 
            onselectedindexchanged="RadioButtonList1_SelectedIndexChanged">
        </asp:RadioButtonList>   
        </div>
    </form>
</body>
</html>
