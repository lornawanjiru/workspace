//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.11;

contract DevProfile{

    address private developer;
    address[] private outsider;
     struct dev{
        string name;
        string job_email;
        string url;
    }
    dev[] private devs;
    string[] comment;
    uint public amount = 1 ether;
   
    //events
    event likeadded();
    event commentsadded();



    //modifiers
    modifier isDev() {
        require(msg.sender == developer, "Cant add info if not a dev");
        _;
    }
    modifier Outsider{
       require(msg.value >= 2 ether && msg.sender != developer,"For you to like or comment you have to send the developer 2 ether or more.You cant like your own profile.");
       payable(developer).transfer(amount);
       _;
    }


    //construct
    constructor(){
       developer = msg.sender;
    }

    //fuctions

    function addinfo(string memory _name, string memory _jobemail, string memory _url) public isDev{
           dev memory devinfo = dev({name: _name, job_email: _jobemail, url: _url});
           devs.push(devinfo);
    }
    
    function getDevinfo() view public returns(dev[] memory ) {
          return (devs);
    }
    
    function like() public payable Outsider{
       emit likeadded();
       outsider.push(msg.sender);
    }

    function comments(string memory _comment) public payable Outsider{ 
         emit commentsadded();    
         comment.push(_comment);
    }

    function comment_info() view public returns (string[] memory){
          return comment;
    }
    function like_info() view public returns (address[] memory){
          return outsider;
    }
    
    

}
