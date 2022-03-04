//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.11;

contract DevProfile{
    address private developer;
    address[] private outsider;
    constructor(){
       developer = msg.sender;
    }
    struct dev{
        string name;
        string job_email;
        string url;
    }
    dev[] private devs;
    string[] comment;
    uint public amount = 1 ether;
    //modifiers
    modifier isDev() {
        require(msg.sender == developer, "Cant add info if not a dev");
        _;
    }
    function addinfo(string memory _name, string memory _jobemail, string memory _url) public isDev{
           dev memory devinfo = dev({name: _name, job_email: _jobemail, url: _url});
           devs.push(devinfo);
    }
    
    function getDevinfo() view public returns(dev[] memory ) {
          return (devs);
    }
    
    function like() public payable{
       require(msg.value >= 2 ether && msg.sender != developer,"For you to like or comment you have to send the developer 2 ether or more.You cant like your own profile.");
       payable(developer).transfer(amount);
       outsider.push(msg.sender);
    }

    function comments(string memory _comment) public payable{ 
         payable(developer).transfer(amount);      
         comment.push(_comment);
    }
    function comment_info() view public returns (string[] memory){
          return comment;
    }
    function like_info() view public returns (address[] memory){
          return outsider;
    }
    


    // modifier Outsider(){
    //     require(msg.sender != developer && msg.value > 2 ether, "For you to like or comment you have to send the developer 2 ether or more.You cant like your own profile.");
    //     _;
    // }
    
    
    // function receiver() external payable {
         
    // }
    
    // 
    
    // mapping (address => string)public like;
    // function likemes(string memory _like) public{
    //        like[msg.sender] = _like;
    // }
    // mapping (address => string) public comments;
    // function message(string memory _comments) public{
    //       comments[msg.sender] = _comments;
    // }
    
   
    

}
