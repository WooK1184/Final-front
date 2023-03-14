const express = require('express');
const app = express();
const mysql = require('mysql');
const bodyParser = require('body-parser');
const { urlencoded } = require('body-parser');
const cors = require('cors');
const dotenv = require('dotenv');
dotenv.config()
const port = process.env.PORT;
const url = process.env.URL;

const { HOSTNAME, USERNAME, PASSWORD, DATABASE } = process.env
const db = mysql.createPool({
    HOST: HOSTNAME,
    USER: USERNAME,
    PASSWORD: PASSWORD,
    DATABASE: DATABASE
});

app.use(cors());
app.use(express.json());
app.use(bodyParser.urlencoded({ extended: true }));

app.get("/api/get", (req, res)=>{
    const sqlQuery = "SELECT * FROM simpleboard;";
    db.query(sqlQuery, (err, result)=>{
        res.send(result);
    })
})

app.post("http://localhost:3333/api/insert", (req, res) => {
    const title = req.body.title;
    const content = req.body.content;
    const sqlQuery = "INSERT INTO simpleboard (title, content) VALUES (?,?)";
    db.query(sqlQuery, [title, content], (err, result) => {
        res.send('success!');
    });
});

app.listen(port, ()=>{
    console.log(`running on port ${port}`);
});