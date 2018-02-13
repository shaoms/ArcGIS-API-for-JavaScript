<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1, maximum-scale=1, user-scalable=no">
    <title>地图打印</title>

   <link rel="stylesheet" href="https://js.arcgis.com/3.23/dijit/themes/claro/claro.css">
   <link rel="stylesheet" href="https://js.arcgis.com/3.23/esri/css/esri.css">
   <script src="https://js.arcgis.com/3.23/"></script>
    <link rel="stylesheet" type="text/css" href="../css/mystyle.css" />
   
    <script>
        require([
            "esri/layers/ArcGISDynamicMapServiceLayer",
            "esri/map","esri/config",
            "esri/tasks/PrintTask",  
            "esri/tasks/PrintTemplate",  
            "esri/tasks/PrintParameters",  
            "dojo/domReady!"
        ], function(ArcGISDynamicMapServiceLayer, Map, esriConfig, PrintTask, PrintTemplate, PrintParameters){
            var lyr = new ArcGISDynamicMapServiceLayer("https://sms.esrichina.com/server/rest/services/test/22/MapServer");  //该服务要共享everyone
            var mymap = new Map("viewDiv", {
                basemap: "osm",
                zoom: 9,  
                //showInfoWindowOnClick:true,
                center: [116.402544,39.915378]  // Sets center point of view using longitude,latitude
            });
            mymap.addLayer(lyr);
            var button = document.getElementById("button");  
            button.onclick = function(){  
                    var printTask = new PrintTask("https://sms.esrichina.com:6443/arcgis/rest/services/Utilities/PrintingTools/GPServer/Export%20Web%20Map%20Task");  
                    var template = new PrintTemplate();  
                    template.exportOptions = {  
                        width: 800,  
                        height: 600,  
                        dpi: 96  
                    };  
                    template.format = "PDF";  
                    template.layout = "A3 Portrait";  
                    template.preserveScale = false;  
                    var params = new PrintParameters();  
                    params.map = mymap;  
                    params.template = template;  
                    printTask.execute(params, function(evt){  
                       console.log(evt);
                        window.open(evt.url,"_blank");  //在新的标签页打开打印连接
                        //window.location = getRootPath() + "/handler/SavePrintResultHandler.ashx?resultUrl=" + evt.url;
                    });  
                }  



        });
    </script>
   
</head>
<body>
<div id="viewDiv"></div>
<button id="button" title="打印">打印</button>
</body>
</html>
