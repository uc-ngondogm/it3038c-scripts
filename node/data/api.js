var http = require("http"); 
var data = require("./widgets.json");

function listGreen(res) { 
    var colorGreen = data.filter(function(item) { 
      return item.color === "green"; 
    }); 
    res.writeHead(200, {"Content-Type": "text/json"});
    res.end(JSON.stringify(colorGreen)); 
} 
 
var server = http.createServer(function(req, res){ 
    if (req.url === "/") { 
        res.writeHead(200, {"Content-Type": "text/json"}); 
        res.end(JSON.stringify(data)); 
    }
    else if (req.url === "/green") {
      listGreen(res)
    } 
    else { 
        res.writeHead(404, {"Content-Type": "text/plain"});       
        res.end("Data not found");         
    } 
}); 
 
server.listen(3000); 
console.log("Server is listening on port 3000"); 
