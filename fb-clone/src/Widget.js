import React from "react";
import './Widget.css';

function Widget() {
  return (
    <div className="widget">
      <iframe
        src="https://www.facebook.com/plugins/page.php?href=https%3A%2F%2Fwww.facebook.com%2FFunky_babai-2253429501583309%2F&tabs=timeline&width=340&height=500&small_header=false&adapt_container_width=true&hide_cover=false&show_facepile=true&appId=2362811237335864"
        width="340"
        height="100%"
        title="Facebook"
        style={{ border: "none", overflow: "hidden" }}
        scrolling="no"
        frameborder="0"
        allow="autoplay; clipboard-write; encrypted-media; picture-in-picture; web-share"
      ></iframe>
    </div>
  );
}

export default Widget;
