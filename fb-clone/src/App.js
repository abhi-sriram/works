import React from "react";
import "./App.css";
import Header from "./Header";
import Sidebar from "./Sidebar";
import Feed from "./Feed";
import Widget from "./Widget";
import Login from "./Login";
import { useStateValue } from "./StateProvider";
import Head from "react-document-configuration";

function App() {
  const [{user},dispatch] = useStateValue();
  return (
    <div className="app">
      <Head title="Facebook-Clone" icon="https://upload.wikimedia.org/wikipedia/commons/5/51/Facebook_f_logo_%282019%29.svg" />
      {user == null ? (
        <Login />
      ) : (
        <>
          <Header />
          <div className="app__body">
            <Sidebar />
            <Feed />
            <Widget />
          </div>
        </>
      )}
    </div>
  );
}

export default App;
