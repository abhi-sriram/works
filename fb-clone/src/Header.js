import React from "react";
import "./Header.css";
import SearchIcon from "@material-ui/icons/Search";
import HomeIcon from '@material-ui/icons/Home';
import FlagIcon from '@material-ui/icons/Flag';
import SubscriptionsIcon from '@material-ui/icons/Subscriptions';
import SupervisedUserCircleIcon from '@material-ui/icons/SupervisedUserCircle';
import StorefrontIcon from '@material-ui/icons/Storefront';
import AddIcon from '@material-ui/icons/Add';
import QuestionAnswerIcon from '@material-ui/icons/QuestionAnswer';
import NotificationsActiveIcon from '@material-ui/icons/NotificationsActive';
import ExpandMoreIcon from '@material-ui/icons/ExpandMore';
import { IconButton } from '@material-ui/core';
import { Avatar } from '@material-ui/core';
import { useStateValue } from "./StateProvider";

function Header() {
  const [{user},dispatch] = useStateValue();
  return (
    <div className="header">
      <div className="header__left">
        <img
          src="https://upload.wikimedia.org/wikipedia/commons/thumb/5/51/Facebook_f_logo_%282019%29.svg/1024px-Facebook_f_logo_%282019%29.svg.png"
          alt="facebook-logo"
        />
        <div className="header__search">
          <SearchIcon />
          <input placeholder="Search facebook..."  type="text" />
        </div>
      </div>
      <div className="header__middle">

        <div className="header__option">
            <div className="header__option--active">
            <HomeIcon  fontSize="large" />
            </div>
            
        </div>
        <div className="header__option">
            <FlagIcon fontSize="large"/>
        </div>
        <div className="header__option">
            <SubscriptionsIcon fontSize="large" />
        </div>
        <div className="header__option">
            <StorefrontIcon fontSize="large" />
        </div>
        <div className="header__option">
            <SupervisedUserCircleIcon fontSize="large" />
        </div>
      </div>
      <div className="header__right">
            <div className="header__name">
                <Avatar src={user.photoURL} alt={user.displayName}/>
                <h4>{user.displayName}</h4>
            </div>
            <IconButton >
                <AddIcon />
            </IconButton>
            <IconButton >
                <QuestionAnswerIcon />
            </IconButton>
            <IconButton >
                <NotificationsActiveIcon />
            </IconButton>
            <IconButton >
                <ExpandMoreIcon />
            </IconButton>
      </div>
    </div>
  );
}   

export default Header;
