import { Button } from "@material-ui/core";
import React from "react";
import './Login.css';
import {auth, provider} from './firebase';
import {actionTypes} from './reducer';
import {useStateValue} from './StateProvider';

function Login() {

    const [state,dispatch] = useStateValue();

  const login = () => {
    auth.signInWithPopup(provider)
    .then(result=>{
       dispatch({
        type: actionTypes.SET_USER,
        user:result.user,
       });
       
    }).catch(err => {console.log(err);})
  };
  return (
    <div className="login">
      <div>
        <img
          src="https://upload.wikimedia.org/wikipedia/commons/thumb/5/51/Facebook_f_logo_%282019%29.svg/1024px-Facebook_f_logo_%282019%29.svg.png"
          alt="facebook-logo"
        />
        <img
          src="https://upload.wikimedia.org/wikipedia/commons/thumb/8/89/Facebook_Logo_%282019%29.svg/1920px-Facebook_Logo_%282019%29.svg.png"
          alt="facebook-text"
        />
      </div>
      <Button onClick={login}>Sign in</Button>
    </div>
  );
}

export default Login;
