import React, { useState } from 'react';  
import logo from './logo.svg';
import './App.css';

function App() {

  let [글제목, 글제목변경] = useState(['팬이에요!', '오늘 점심 뭐 드셨나요?!', '콘서트 언제하나요?']);
  let [좋아요, 좋아요변경] = useState(0);
  return (
    <div className="App">
      <div class="black-nav">
        <div>global Fan site</div>
      </div>
      <h4>게시판</h4>
      <div className="list">
        <h3> { 글제목[0] } <span onClick={ ()=>{좋아요변경(좋아요 + 1)}}>👍</span>{좋아요}</h3>
        <p>2023.03.11</p>
        <hr/>
      </div>
      <div className="list">
        <h3> { 글제목[1] } </h3>
        <p>2023.03.12</p>
        <hr/>
      </div>
      <div className="list">
        <h3> { 글제목[2] } </h3>
        <p>2023.03.13</p>
        <hr/>
      </div>
    </div>  
  );
}

export default App;
