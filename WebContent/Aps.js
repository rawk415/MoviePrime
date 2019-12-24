import React, { Component } from 'react';
import './App.css';

class App extends Component {
  render() {
    return (
      <div className="App">
        <form className="myForm">
          <div className="form-group">
            <label htmlFor="nameInput">이름</label>
            <input
              type="text"
              className="form-control"
              id="nameInput"
              placeholder="홍길동"
            />
          </div>
          <div className="form-group">
            <label htmlFor="emailInput">이메일</label>
            <input
              type="email"
              className="form-control"
              id="emailInput"
              aria-describedby="emailHelp"
              placeholder="abc@gmail.com"
            />
          </div>
          <div className="form-group">
            <label htmlFor="phoneNumberInput">휴대폰 번호</label>
            <input
              type="text"
              className="form-control"
              id="phoneNumberInput"
              placeholder="010-1234-1234"
            />
          </div>
          <button type="submit" className="btn btn-primary btn-block">
            Submit
          </button>
        </form>
      </div>
    );
  }
}

export default App;