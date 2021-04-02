import firebase from "firebase";

const firebaseConfig = {
    apiKey: "AIzaSyAFBSuCPvnI4OSIOlXQW95WBgfwTT96Qic",
    authDomain: "facebook-clone-676f9.firebaseapp.com",
    projectId: "facebook-clone-676f9",
    storageBucket: "facebook-clone-676f9.appspot.com",
    messagingSenderId: "578507738692",
    appId: "1:578507738692:web:1fe417da6da4e7f295b611"
  };

  const firebaseApp = firebase.initializeApp(firebaseConfig);
  const db = firebaseApp.firestore();
  const auth = firebase.auth();
  const provider = new firebase.auth.GoogleAuthProvider();

  export {auth, provider};
  export default db;