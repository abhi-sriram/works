import React, { useEffect, useState } from "react";
import MessageSender from "./MessageSender";
import Post from "./Post";
import StoryReels from "./StoryReels";
import db from "./firebase";

function Feed() {
  const [posts, setPosts] = useState([]);

  useEffect(() => {
    db.collection("posts").orderBy("timestamp","desc").onSnapshot((snapshot) => {
      setPosts(snapshot.docs.map((doc) => ({ id: doc.id, data: doc.data() })));
    });
    
  }, []);

  
    // posts.forEach((post) => (
    //   console.log(
    //     post.id,
    //       post.data.photoURL,
    //       post.data.name,
    //       post.data.timestamp,
    //       post.data.message,
    //       post.data.imageURL
    //   )
        
        
    //   ));
 

  return (
    <div className="feed">
      <StoryReels />
      <MessageSender />

      {posts.map((post) => (
        <Post
            key={post.id}
          profileUrl={post.data.photoURL}
          name={post.data.name}
          timestamp={post.data.timestamp}
          message={post.data.message}
          imageUrl={post.data.imageURL}
        />
      ))}
     
    </div>
  );
}

export default Feed;
