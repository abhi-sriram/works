import React from 'react';
import Story from './Story';
import './StoryReels.css'

function StoryReels() {
    return (
        <div className="storyReels">
            <Story
               src="https://images.unsplash.com/photo-1611615795585-09375908c82b?ixid=MXwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwyfHx8ZW58MHx8fA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60"
               profileSrc="https://www.latestlaws.com/media/2015/04/Warren-Buffett.jpg"
               title="Warren B"
             />
            <Story 
                src="https://images.unsplash.com/photo-1612124119639-d9f418cbfa9b?ixid=MXwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwxM3x8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60"
               profileSrc="https://upload.wikimedia.org/wikipedia/commons/thumb/1/18/Mark_Zuckerberg_F8_2019_Keynote_%2832830578717%29_%28cropped%29.jpg/723px-Mark_Zuckerberg_F8_2019_Keynote_%2832830578717%29_%28cropped%29.jpg"
               title="Mark J"
            />
            <Story 
                src="https://images.unsplash.com/photo-1569389397653-c04fe624e663?ixid=MXwxMjA3fDF8MHxlZGl0b3JpYWwtZmVlZHwxNnx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60"
               profileSrc="https://upload.wikimedia.org/wikipedia/commons/8/85/Elon_Musk_Royal_Society_%28crop1%29.jpg"
               title="Elon M"
            />
            <Story 
                src="https://images.unsplash.com/photo-1612200489095-db6fc8276c06?ixid=MXwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwyMHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60"
               profileSrc="https://api.time.com/wp-content/uploads/2020/09/time-100-Sundar-Pichai.jpg"
               title="Sundar P"
            />
            
            
        </div>
    )
}

export default StoryReels;
