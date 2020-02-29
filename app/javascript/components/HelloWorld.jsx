import React, { useState } from "react";
import Button from "./Button";

const HelloWorld = () => {
  const [visible, setVisible] = useState(true);
  const [text, setText] = useState("Hello World");

  return (
    <>
      <Button color="danger" onClick={() => setVisible(!visible)}>
        Toggle Greeting
      </Button>
      {visible && <h1>{text}</h1>}
      <input
        id="header_text_input"
        type="text"
        onChange={e => {
          setText(e.target.value);
          e.target.value === "hide!" ? setVisible(false) : setVisible(true);
        }}
        value={text}
      />
    </>
  );
};
export default HelloWorld;
