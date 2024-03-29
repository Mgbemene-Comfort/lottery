//SPDX-License-Identifier: MIT 
pragma solidity ^0.8.0;

contract Lottery{
    
    address public manager;
 
    address[] public players;

    function lottery() public {
        manager = msg.sender;
    }

    function enter() public payable{

        require(msg.value > .01 ether);
        players.push(msg.sender);
    }

    function random() private view returns(uint){
        return  uint (keccak256(abi.encode(block.timestamp,  players)));
    }
    function pickWinner() public restricted{
        
        uint index = random() % players.length;
        
        payable (players[index]).transfer(address(this).balance);
        
        players = new address[](0);
    }

    modifier restricted(){
        require(msg.sender == manager);
        _;

    }
}