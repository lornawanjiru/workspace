//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.11;

contract DevProfile{
    //defining variables.
    //Used private so that it cant be accessed by other contracts 
    address public developer;
    address[] private outsider;
    //Used a struct to define the variables that i will need to be outputted by the dev and outsider.
     struct dev{
        string name;
        string job_email;
        string url;
    }
    //To add data/information to the struct defined above i used private devs variable.
    dev[] private devs;
    //Declaring the comment array that will be used to store commets from the outsiders.
    string[] comment;
    // The appreciation token for the developer everytime you want to comment or like. 
    uint private amount = 1 ether;
   
    //events
    event likeadded();
    event commentsadded();


    //There codes that are repetitive in my contract hence i used the modifiers to hold the code.
    //modifiers
    //This modifier is used for limiting the people who add/view some infomation as developers 
    //Developers are the once who create the contract instance.
    modifier isDev() {
        require(msg.sender == developer, "Cant add/view this if not a dev");
        _;
    }
    //Outsiders are the other people who are not developers and they have to send ether anytime they comment or like. 
    modifier Outsider{
       require(msg.value >= 2 ether && msg.sender != developer,"For you to like or comment you have to send the developer 2 ether or more.You cant like your own profile.");
       //its payable cause the action is involved with sending ethers. In this code the developer is being sent to.
       payable(developer).transfer(amount);
       _;
    }


    //construct
    constructor(){
       developer = msg.sender;
    }

    //fuctions
    //Function for adding developers information.Only the developer is allowed to add the information.
    function addinfo(string memory _name, string memory _jobemail, string memory _url) public isDev{
           dev memory devinfo = dev({name: _name, job_email: _jobemail, url: _url});
           devs.push(devinfo);
    }
    //this function lets the outsiders view the profile of the developer.
    function Dev_profile() view public returns(dev[] memory){
        return devs;
    }
    //This function is used to display the developers information including the likes and comments.
    function getDevinfo() view public isDev returns(dev[] memory,string[] memory,uint likes){
          return (devs,comment,outsider.length);
    }
    //function for adding a like.
    function like() public payable Outsider{
       emit likeadded();
       outsider.push(msg.sender);
    }
    //function to add a comment.
    function comments(string memory _comment) public payable Outsider{ 
         emit commentsadded();    
         comment.push(_comment);
    }

}
