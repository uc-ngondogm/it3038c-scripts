var http = require("http");
var fs = require("fs");
var os = require("os");
var ip = require('ip');

//function getUptime(){
   //serverTime = os.uptime();
   //return serverTime
//}
// Get the number of CPUs
var cpuCount = os.cpus().length

// Get the server uptime
serverTime = os.uptime();
var ut_min = serverTime/60;
var ut_hour = ut_min/60;
var ut_date = ut_hour/24

serverTime = Math.floor(serverTime);
ut_min = Math.floor(ut_min);
ut_hour = Math.floor(ut_hour/24);
ut_date = Math.floor(ut_date);  

ut_date = ut_date%24
ut_hour = ut_hour%60;
ut_min = ut_min%60;
serverTime = serverTime%60;
var uptime = ( + ut_date + " Day(s) " + ut_hour + " Hour(s) " + ut_min + " minute(s) and " + serverTime + " second(s)");
// Get the number of total memory in Byte
var totalRAM = os.totalmem();
var total = (totalRAM / (1024 * 1024));

// Get the number of available memory in Byte
var freeRAM = os.freemem();
var free = (freeRAM / (1024 * 1024));

var server = http.createServer(function(req, res){
    if (req.url === "/") {
        fs.readFile("./public/index.html", "UTF-8", function(err, body){
        res.writeHead(200, {"Content-Type": "text/html"});
        res.end(body);
    });
    }
    else if(req.url.match("/sysinfo")) {
        myHostName=os.hostname();
        html=`    
        <!DOCTYPE html>
          <html>
          <head>
              <title>Node JS Response</title>
              </head>
              <body>
              <p>Hostname: ${myHostName}</p>
              <p>IP: ${ip.address()}</p>
              <p>Server Uptime: ${uptime}</p>
              <p>Total Memory: ${total}MB</p>
              <p>Free Memory: ${free}MB</p>
              <p>Number of CPUs: ${cpuCount}</p>            
              </body>
          </html>` 
        res.writeHead(200, {"Content-Type": "text/html"});
        res.end(html);
    }
    else {
        res.writeHead(404, {"Content-Type": "text/plain"});
        res.end(`404 File Not Found at ${req.url}`);
    }
  
}).listen(3000)

console.log("Server listening on port 3000")