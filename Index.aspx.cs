using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Diagnostics;
using Newtonsoft.Json.Linq;
using System.IO;
using Vertica.Data.VerticaClient;
using Syncfusion.JavaScript.Web;
using System.Collections;
using Syncfusion.JavaScript.DataVisualization.Models.Diagram;
//using static IronPython.Modules.PythonMD5;
//using Quartz;
using System.Threading;
using Syncfusion.JavaScript.Mobile;
//using static System.Net.Mime.MediaTypeNames;
using System.Activities.Statements;
using Amazon;
using Syncfusion.JavaScript;
using System.Drawing;
using Microsoft.Web.Services3.Addressing;
using Microsoft.Scripting.Utils;
using System.Data.SqlTypes;
//using static IronPython.Modules.PythonMD5;

// 091123 [##] code for Grid Export
using Syncfusion.EJ.Export;

using Syncfusion.XlsIO;
using System.Reflection;
using System.Web.Script.Serialization;
using Syncfusion.JavaScript.Models;
// 091123 [##] code ends

// 082123 [##] code for datagrid link
using System.CodeDom;
using System.Text;
using Syncfusion.JavaScript.Shared.Serializer;
using Newtonsoft.Json;
using IronPython.Runtime.Operations;
using Quartz.Util;
using RestSharp;
using Syncfusion.JavaScript.DataVisualization;
using Syncfusion.JavaScript.DataVisualization.Models;
// 082123 [##] code for datagrid link end
public partial class Index : System.Web.UI.Page
{
    public static String root_path = AppDomain.CurrentDomain.BaseDirectory;
    public static String rootUrl = "http://localhost:52733/";
    public static DataTable dataTable = new DataTable();
    public static string linkColName = "PARTY_ID";
    Grid Data_Grids = new Grid();

    
    protected void Page_Load(object sender, EventArgs e)
    {
        //if (!IsPostBack)
        //{
        string dt = File.ReadAllText(root_path + @"DataSet\Example1.json");
        DataTable datatab = UseNewtonsoftJson(dt);
        BindDataSource();
       
        //}
    }

  
    public static DataTable UseNewtonsoftJson(string sampleJson)
    {

        if (string.IsNullOrWhiteSpace(sampleJson))
        {
            return dataTable;
        }
        dataTable = JsonConvert.DeserializeObject<DataTable>(sampleJson);
        return dataTable;
    }
    public void BindDataSource()
    {
        Data_Grids.ID = "GridSample";
        Data_Grids.EditSettings.AllowEditing = true;
        Data_Grids.EditSettings.EditMode = Syncfusion.JavaScript.EditMode.Batch;
        Data_Grids.ToolbarSettings.ShowToolbar = true;
        Data_Grids.ToolbarSettings.ToolbarItems = new List<string> { "update", "cancel", "excelExport", "pdfExport" };
        Data_Grids.DataSource = dataTable;
        Data_Grids.ServerPdfExporting += FlatGrid_ServerPdfExporting;
        Data_Grids.ServerExcelExporting += FlatGrid_ServerExcelExporting;
        Data_Grids.DataBind();
        multigrid.Controls.Add(Data_Grids);

        PostBackTrigger trigger = new PostBackTrigger();
        trigger.ControlID = Data_Grids.UniqueID;
        multigridupdate.Triggers.Add(trigger);
        multigridupdate.Update();
    }

    protected void page_LoadComplete(object sender, EventArgs e)
    {
        updateEditColumn();
    }

    protected void updateEditColumn()
    {
        //foreach(DataColumn col in dataTable.Columns)
        //{
        //    if (col.ColumnName.Equals(linkColName))
        //    {
        //        var redirectURL = rootUrl + "index.aspx?&popup";
        //        string columnformat = "<a onclick=\"setchnageclick(this,'" + redirectURL + "', '" + Data_Grids.ID.ToString() + "');\" href=#>" + col.ColumnName + "</a>";
        //        this.Data_Grids.Columns.Add(new Syncfusion.JavaScript.Models.Column() { Field = col.ColumnName, AllowEditing = false, Template = columnformat, });
        //    }

        //        this.Data_Grids.Columns.Add(new Syncfusion.JavaScript.Models.Column() { Field = col.ColumnName, AllowEditing = true });

        //}
    }

    // 091123 [##] code for Export
    protected void FlatGrid_ServerExcelExporting(object sender, Syncfusion.JavaScript.Web.GridEventArgs e)
    {
        try
        {
            Debug.WriteLine("******* In FlatGrid_ServerExcelExporting(). ********");
            ExcelExport exp = new ExcelExport();
            GridProperties obj = ConvertGridObject(e.Arguments["model"].ToString());
            GridExcelExport exp1 = new GridExcelExport() { IsTemplateColumnIncluded = true, Theme = "flat-lime", FileName = "Export.xlsx", Excelversion = ExcelVersion.Xlsx };
            DataTable sourceDT = (DataTable)dataTable;
            IEnumerable dataObject = sourceDT.Select();
            exp.Export(obj, dataObject, exp1);
        }
        catch (Exception ex)
        {
            Debug.WriteLine("*******Exception In FlatGrid_ServerExcelExporting(). ********");
            Debug.WriteLine("***************\n" + ex);
        }
    }

    

    protected void FlatGrid_ServerPdfExporting(object sender, Syncfusion.JavaScript.Web.GridEventArgs e)
    {
        try
        {
            Debug.WriteLine("******* In FlatGrid_ServerPdfExporting(). ********");
            PdfExport exp = new PdfExport();
            GridProperties obj = ConvertGridObject(e.Arguments["model"].ToString());
            GridPdfExport exp1 = new GridPdfExport() { IsTemplateColumnIncluded = true, Theme = "flat-lime", FileName = "Export.pdf" };
            DataTable sourceDT = (DataTable)dataTable;
            IEnumerable dataObject = sourceDT.Select();
            exp.Export(obj, dataObject, exp1);
        }
        catch (Exception ex)
        {
            Debug.WriteLine("*******Exception In FlatGrid_ServerExcelExporting(). ********");
            Debug.WriteLine("***************\n" + ex);
        }
    }

    private GridProperties ConvertGridObject(string gridProperty)
    {
        JavaScriptSerializer serializer = new JavaScriptSerializer();
        IEnumerable div = (IEnumerable)serializer.Deserialize(gridProperty, typeof(IEnumerable));
        GridProperties gridProp = this.Data_Grids.Model;
        foreach (KeyValuePair<string, object> data in div)
        {
            var property = gridProp.GetType().GetProperty(data.Key, BindingFlags.Instance | BindingFlags.Public | BindingFlags.IgnoreCase);

            if (property != null)
            {
                Type type = property.PropertyType;
                string serialize = serializer.Serialize(data.Value);
                object value = serializer.Deserialize(serialize, type);
                property.SetValue(gridProp, value, null);
            }
        }
        return gridProp;
    }

    // 091123 [##] code ends

   

}