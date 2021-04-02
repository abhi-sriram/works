import { Avatar } from '@material-ui/core';
import VideocamIcon from '@material-ui/icons/Videocam';
import PhotoLibraryOutlinedIcon from '@material-ui/icons/PhotoLibraryOutlined';
import EmojiEmotionsOutlinedIcon from '@material-ui/icons/EmojiEmotionsOutlined';
import React ,{useState}from 'react';
import './MessageSender.css';
import { useStateValue } from './StateProvider';
import db from './firebase';
import firebase from 'firebase';

function MessageSender() {

    const [input,setInput] = useState("");
    const [urlInput,setUrlInput] = useState("");
    const [{user},dispatch] = useStateValue();

    const handleSubmit = (e)=>{
        e.preventDefault();
        if(input.trim()!==''){
            db.collection('posts').add({
                imageURL:urlInput,
                message:input,
                name:user.displayName,
                photoURL: user.photoURL,
                timestamp:firebase.firestore.FieldValue.serverTimestamp()
            })
        }
        
        setInput('');
        setUrlInput('');
    }
    
    return (
        <div className="messageSender">
            <div className="messageSender__top">
                <form>
                    <Avatar src={user.photoURL} alt={user.displayName} />
                    <input 
                        onChange={(e)=>{setInput(e.target.value)}}
                        value={input} 
                        className="messageSender__input"  placeholder={`What's on your mind ${user.displayName} ?`} />
                    <input 
                        onChange={(e)=>{setUrlInput(e.target.value)}}
                        value={urlInput} 
                        placeholder="image URL(optional)"/>
                    <button onClick={handleSubmit} type="submit">&nbsp; Send</button>
                </form>
            </div>
            <div className="messageSender__bottom">
                <div className="messageSender__elements">
                    <VideocamIcon style={{color:'red'}} />
                    <h4>Live Vedio</h4>
                </div>
                <div className="messageSender__elements">
                    <PhotoLibraryOutlinedIcon style={{color:'green'}} />
                    <h4>Photo/Vedio</h4>
                </div>
                <div className="messageSender__elements">
                    <EmojiEmotionsOutlinedIcon style={{color:'orange'}} />
                    <h4>Feeling/Activity</h4>
                </div>
            </div>
        </div>
    )
}

export default MessageSender;
