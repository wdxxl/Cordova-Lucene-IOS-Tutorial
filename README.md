
Still have issue, Currently not Workable for those steps.


cordova create Cordova_Github_Version com.wdxxl.cordova LuceneApp

cordova plugins add https://github.com/sqli/sqli-cordova-lucene-plugin.git

cordova plugins add cordova-plugin-file

cordova platform add ios


update index.html under stage folder & copy paste full_text_index related folders
```
<html>
    <head>
        <title>Hello World</title>
        <meta http-equiv="Content-type" content="text/html; charset=utf-8"/>
        <script type="text/javascript" charset="utf-8" src="cordova.js"></script>
        <script type="text/javascript" charset="utf-8" src="js/index.js"></script>
        <script type="text/javascript" charset="utf-8">
        function success(result){
            $('#searchNb').html(result.nbHits + ' docs');
            $('#searchResult').html('');
            $('#searchResult').append('<ul>');
            result.docs.forEach(function (doc) {
                                $('#searchResult').append('<li>' + doc.commonDmcId + '</li>');
                                });
            $('#searchResult').append('</ul>');
            alert("success");
        }
        
        function failure(result){
            alert("failure");
        }
        
        function search() {
            var textValue = "football"; //document.getElementById("myText").value;
            var indexPath = cordova.file.applicationDirectory+"www/storage/sdcard/full_text_index/";
            alert(indexPath);
            LucenePlugin.init(indexPath, "content", 10);
            LucenePlugin.search(textValue, success, failure);
        }
        </script>
    </head>
    <body style="padding-top:20px;">
        <input id="myText" type="text"/>
        <input type="button" id="btn" onclick="search()" value="Button" />
        <span id="searchNb"/>
        <div id="searchResult"/>
    </body>
</html>

```