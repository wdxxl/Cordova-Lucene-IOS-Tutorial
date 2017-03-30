
**Lucene 1.4.3 for IOS Demo Steps.**

```javascript
Steps: 
    1. Use Java project to generate index of Lucene 1.4.3;
    2. upload this lucene143.zip to your HTTP server;
    3. Download lucene143.zip to your App's documentsDirectory;
    4. Unzip lucene143.zip also at documentsDirectory;
    5. Lucene search those indexes;

update index.html under stage folder.
```



```sh
cordova create Cordova_Github_Version com.wdxxl.cordova LuceneApp

cordova plugin add https://github.com/sqli/sqli-cordova-lucene-plugin.git

cordova plugin add cordova-plugin-file
cordova plugin add cordova-plugin-http
cordova plugin add cordova-plugin-zip

cordova platform add ios

--------------------------------
*Steps to update plugin*
cordova plugin list
cordova plugin remove sqli-cordova-lucene-plugin

*Add Local Plugins*
cordova plugin add /Users/oukagaku/sqli-cordova-lucene-plugin/
cordova platform add ios

```


```html
<html>
    <head>
        <title>Hello World</title>
        <meta http-equiv="Content-type" content="text/html; charset=utf-8"/>
        <script type="text/javascript" charset="utf-8" src="cordova.js"></script>
        <script type="text/javascript" charset="utf-8" src="js/index.js"></script>
        <script type="text/javascript" charset="utf-8">
        function success(result){
            document.getElementById("searchResult").innerHTML = "";
            document.getElementById("searchNb").innerHTML = result.nbHits + ' docs';
            var ul = document.getElementById("searchResult");
            if(result.nbHits > 0){
                for(var i=0; i<result.nbHits; i++) {
                    var li = document.createElement("li");
                    li.appendChild(document.createTextNode(result.docs[i].content));
                    ul.appendChild(li);
                }
            }
        }
        
        function failure(result){
            alert("failure");
        }
        
        function search() {
            var textValue = document.getElementById("myText").value;
            var indexPath = cordova.file.documentsDirectory + 'lucene143/field/';
            LucenePlugin.init(indexPath, "content", 10);
            LucenePlugin.search(textValue, success, failure);
        }
        
        function downloadIndex(){
            var url = "http://weitaiping.com/lucene143.zip";
            var params = {};
            var headers = {};
            var filePath = cordova.file.documentsDirectory + "lucene143.zip";
            CordovaHttpPlugin.downloadFile(url, params, headers, filePath,
                                    function(entry) {
                                        unzipIndex(filePath);
                                    },
                                    function(response) {
                                        alert(response.error);
                                    });
        }
        
        function unzipIndex(fileName){
            var outputDirectory = cordova.file.documentsDirectory;
            
            zip.unzip(fileName, outputDirectory,
                      function(entry) {
                        alert("success");
                      },
                      function(response) {
                        //alert(response.error);
                      });
        }
        </script>
    </head>
    <body style="padding-top:20px;">
        <input id="myText" type="text"/>
        <input type="button" id="btn" onclick="downloadIndex()" value="download" />
        <input type="button" id="btn" onclick="search()" value="Search" />
        </br>
        <span id="searchNb">search number hits</span>
        </br>
        <div>
            <ul id="searchResult"></ul>
        </div>
    </body>
</html>


```