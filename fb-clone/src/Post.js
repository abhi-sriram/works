import { Avatar } from "@material-ui/core";
import ThumbUpOutlinedIcon from '@material-ui/icons/ThumbUpOutlined';
import ChatBubbleOutlineOutlinedIcon from '@material-ui/icons/ChatBubbleOutlineOutlined';
import NearMeOutlinedIcon from '@material-ui/icons/NearMeOutlined';
import ExpandMoreOutlinedIcon from '@material-ui/icons/ExpandMoreOutlined';
import AccountCircleOutlinedIcon from '@material-ui/icons/AccountCircleOutlined';
import React from "react";
import "./Post.css";

function Post({ profileUrl, name,
     timestamp, message, imageUrl }) {
  return <div className="post">
            <div className="post__info">
                <Avatar src={profileUrl}  alt={name}/>
                <div>
                    <h4>{name}</h4>
                    <p>{new Date(timestamp?.toDate()).toUTCString()}</p>
                </div>
            </div>
            <div className="post__message">
                <h3>{message}</h3>
            </div>
            <div className="post__image">
                <img src={imageUrl} alt={imageUrl}/>
            </div>
            <div className="post__options">
                <div className="post__option">
                    <ThumbUpOutlinedIcon />
                    <p>Like</p>
                </div>
                <div className="post__option">
                    <ChatBubbleOutlineOutlinedIcon />
                    <p>Comment</p>
                </div>
                <div className="post__option">
                    <NearMeOutlinedIcon />
                    <p>Share</p>
                </div>
                <div className="post__option">
                    <AccountCircleOutlinedIcon />
                    <ExpandMoreOutlinedIcon />
                </div>
            </div>
        </div>;
}

export default Post;
