import {useState, useEffect} from 'react';
import './App.css';
import { CKEditor } from '@ckeditor/ckeditor5-react';
import ClassicEditor from '@ckeditor/ckeditor5-build-classic';
import Parser from 'html-react-parser';
import Axios from 'axios';

function App() {
  const [boardContent, setboardContent]  = useState({
    title: '',
    content: ''
  })


  const [viewContent, setViewContent] = useState([]);

  useEffect(()=>{
    Axios.get('http://localhost:3333/api/get').then((response)=>{
      setViewContent(response.data);
    })
  }, [setViewContent]);

  const submitReview = ()=>{
    Axios.post('http://localhost:3333/api/insert', {
      title: boardContent.title,
      content: boardContent.content
    }).then(()=>{
      window.location.reload();
      alert('등록 완료!');
    })
  };

  const getValue = e => {
    const { name, value } = e.target;
    setboardContent({
      ...boardContent,
      [name]: value  
    })
    console.log(boardContent);
  }
  return (
    <div className="App">
      <div class="black-nav">
        <div>Babsae's Fan site</div>
      </div>
      <h1>게시판</h1>
      <div className='board-container'>
        {viewContent && viewContent?.map(element =>
          <div key={element.idx}>
            <h2>{element.title}</h2>
            <div>
              {console.log(element)}
              {Parser(element.content)}
            </div>
          </div>
          )}
      </div>
      <div className='form-wrapper'>
        <input className="title-input" type='text' placeholder='제목' onChange={getValue} name='title' />
        <CKEditor
          editor={ClassicEditor}
          data="<p>Hello from CKEditor 5!</p>"
          onReady={editor => {
            // You can store the "editor" and use when it is needed.
            console.log('Editor is ready to use!', editor);
          }}
          onChange={(event, editor) => {
            const data = editor.getData();
            console.log({ event, editor, data });
            setboardContent({
              ...boardContent,
              content: data
            })
            console.log(boardContent);
          }}
          onBlur={(event, editor) => {
            console.log('Blur.', editor);
          }}
          onFocus={(event, editor) => {
            console.log('Focus.', editor);
          }}
        />
      </div>
      <button
      className="submit-button"
      onClick={submitReview}
      >입력</button>
    </div>
  );
}

export default App;