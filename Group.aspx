<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Group.aspx.cs" Inherits="Group" %>

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
        <div>

            <ej:Grid ID="DataGrid" runat="server" AllowSorting="True" AllowPaging="True" ShowSummary="true" AllowFiltering="true" IsResponsive="true"
                CssClass="table-responsive" >
                <ClientSideEvents Load="load" CellSave="beforebatchadd" BeforeBatchSave="progress" />
                <FilterSettings FilterType="Excel" />
                <PageSettings ShowDefaults="true" />
                <EditSettings AllowEditing="True" AllowAdding="True" AllowDeleting="True" EditMode="Batch" ShowDeleteConfirmDialog="true"></EditSettings>
                <ToolbarSettings ShowToolbar="True" ToolbarItems="add,edit,delete,update,cancel"></ToolbarSettings>
                <SummaryRows>
                    <summarycolumn SummaryType="Sum" DisplayColumn="Freight" />
                    
                </SummaryRows>
               
           </ej:Grid>
            <Columns>
       
        <!-- Add more columns as needed -->
    </Columns>
            <div id="summaryElement">Sum: Loading...</div>
        </div>
    </form>
    <script>
        $(document).ready(function () {
            // Assuming you have a grid with an ID "DataGrid"
            var grid = $("#DataGrid").data("ejGrid");
            alert(grid.model)

            // Function to calculate the sum of a specific column
            function calculateSum(columnName) {
                var data = grid.model.currentViewData;
                var sum = data.reduce(function (acc, currentRow) {
                    return acc + parseFloat(currentRow[columnName]);
                }, 0);
                return sum;
            }

            // Initial update of the summary
            function updateSummary() {
                var sum = calculateSum("Freight");
                document.getElementById("summaryElement").innerHTML = "Sum: " + sum;
            }

            // Wait for the grid to load and then update the summary
            grid.option("queryCellInfo", function (args) {
                if (args.colName === "Freight" && args.requestType === "refresh") {
                    updateSummary();
                }
            });
        });
    </script>
</body>
</html>
