const express = require('express')
const app = express()
const port = 3000
const path = require('path');
const { mainModule } = require('process');

const http = require('http').createServer(app);
http.listen(port, function () {
  console.log('listening on 3000')
});

app.use(express.static( path.join(__dirname, '../blog/build')))

app.get('/', function(request, response) {
  response.sendFile( path.join(__dirname, '../blog/build/index.html'))
})