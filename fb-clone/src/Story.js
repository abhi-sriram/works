import React from 'react';
import './Story.css'
import Avatar from '@material-ui/core/Avatar';

function Story({src,profileSrc,title}) {
    return (
        <div style={{backgroundImage:`url(${src})`}} className="story">
            <Avatar className="story__avatar" src={profileSrc} alt={title}/>
            <h4>{title}</h4>
        </div>
    )
}

export default Story;
