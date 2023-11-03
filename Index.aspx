<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Index.aspx.cs" Inherits="Index" %>


<%@ Register Assembly="Syncfusion.EJ, Version=20.4460.0.38, Culture=neutral, PublicKeyToken=3D67ED1F87D44C89" Namespace="Syncfusion.JavaScript.Web" TagPrefix="ej" %>
<%@ Register Assembly="Syncfusion.EJ.Web, Version=20.4460.0.38, Culture=neutral, PublicKeyToken=3D67ED1F87D44C89" Namespace="Syncfusion.JavaScript.Web" TagPrefix="ej" %>
<%-- // 091123 [##] Added for Datagrid Export --%>
<%@ Register Assembly="Syncfusion.EJ.Export, Version=20.4460.0.38, Culture=neutral, PublicKeyToken=3D67ED1F87D44C89" Namespace="Syncfusion.JavaScript.Web" TagPrefix="ej" %>
<%@ Register Assembly="Syncfusion.XlsIO.Base, Version=20.4460.0.38, Culture=neutral, PublicKeyToken=3D67ED1F87D44C89" Namespace="Syncfusion.JavaScript.Web" TagPrefix="ej" %>
<%@ Register Assembly="Syncfusion.Pdf.Base, Version=20.4460.0.38, Culture=neutral, PublicKeyToken=3D67ED1F87D44C89" Namespace="Syncfusion.JavaScript.Web" TagPrefix="ej" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
     <link href="http://cdn.syncfusion.com/20.4.0.38/js/web/flat-azure/ej.web.all.min.css" rel="stylesheet" />

    <script src="http://cdn.syncfusion.com/js/assets/external/jquery-3.3.1.min.js"></script>

    <script src="http://cdn.syncfusion.com/js/assets/external/jquery.easing.1.3.min.js"></script>

    <script src="http://cdn.syncfusion.com/js/assets/external/jquery.globalize.min.js"></script>

    <script src="http://cdn.syncfusion.com/js/assets/external/jsrender.min.js"></script>

    <script src="http://cdn.syncfusion.com/20.4.0.38/js/web/ej.web.all.min.js"></script>

    <script src="http://cdn.syncfusion.com/20.4.0.38/js/common/ej.webform.min.js"></script>
</head>
<body>
    <form id="form1" runat="server">
         <asp:ScriptManager ID="scritPANEID" runat="server"></asp:ScriptManager>
        <div>
              <asp:UpdatePanel runat="server" ID="multigridupdate" UpdateMode="Conditional">
            <ContentTemplate>
                <div runat="server" id="multigrid">
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
        </div>
    </form>
</body>
</html>
