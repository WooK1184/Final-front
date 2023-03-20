const express = require('express');
const app = express();
const mysql = require('mysql');
const bodyParser = require('body-parser');
const { urlencoded } = require('body-parser');
const cors = require('cors');
const dotenv = require('dotenv');
dotenv.config()
const port = process.env.PORT;

const { HOST, USER, PASSWORD } = process.env
const db = mysql.createPool({
    host: HOST,
    user: USER,
    password: PASSWORD,
    charset: 'utf8mb4'
});

db.getConnection((err, connection) => {
    if (err) throw err;
    connection.query('CREATE DATABASE IF NOT EXISTS simpleboard', (err, result) => {
      if (err) throw err;
      console.log('Database created');
      connection.query('USE simpleboard', (err, result) => {
        if (err) throw err;
        console.log('Database selected');
  
        // 테이블 생성
        const sql = `CREATE TABLE IF NOT EXISTS simpleboard (
                      idx INT NOT NULL AUTO_INCREMENT,
                      title CHAR(100) NOT NULL,
                      content TEXT NOT NULL,
                      PRIMARY KEY(idX)
                    )`;
        connection.query(sql, (err, result) => {
          if (err) throw err;
          console.log('Table created');
          connection.release(); // 연결 반환
        });
      });
    });
  });

console.log("여기는")  

app.use(cors());
app.use(express.json());
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.raw());
app.use(bodyParser.text());

console.log('여기가 문제야?')

app.get("/api/get", (req, res)=>{
    const sqlQuery = "SELECT * FROM simpleboard;";
    db.query(sqlQuery, (err, result)=>{
        res.send(result); 
    })
})

app.post("/api/insert", (req, res) => {
    const title = req.body.title;
    const content = req.body.content;
    const sqlQuery = "INSERT INTO simpleboard (title, content) VALUES (?,?)";
    db.query(sqlQuery, [title, content], (err, result) => {
        res.send('success!'); 
    });
});

console.log('아니면 여기가 문제야?')
app.use(function(req, res, next) {
  res.header("Content-Type", "application/json; charset=utf-8");
  next();
});

app.listen(port, ()=>{
    console.log(`running on port ${port}`);
});