// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

contract Refer {

    struct user{
        address referrer;
        address customer;
    }
    address private owner;
    mapping(address=>user) public chain;
    mapping(address=>mapping(uint=>address))public referredAddress;
    mapping(address=>uint) public referralCount;

    constructor(address _owner){
        chain[msg.sender]=user(msg.sender,msg.sender);
        owner=_owner;
    }

    function add() external {
        require(chain[msg.sender].referrer==address(0),"Already referred once");
        if(referralCount[owner] < 2){
            chain[msg.sender]= user(owner,msg.sender);
            referralCount[owner]++;
            referredAddress[owner][referralCount[owner]]=msg.sender;
        }else{
            if(referralCount[referredAddress[owner][1]]<2){
                chain[msg.sender]=user(referredAddress[owner][1],msg.sender);
                referralCount[referredAddress[owner][1]]++;
                referredAddress[referredAddress[owner][1]][referralCount[referredAddress[owner][1]]]=msg.sender;
            }
            else{
                chain[msg.sender]=user(referredAddress[owner][2],msg.sender);
                referralCount[referredAddress[owner][2]]++;
                referredAddress[referredAddress[owner][2]][referralCount[referredAddress[owner][2]]]=msg.sender;
                
            }
        }
        
        
    }
}