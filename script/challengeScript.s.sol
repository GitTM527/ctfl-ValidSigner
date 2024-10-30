// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.13;

import {Script, console2} from "forge-std/Script.sol";

import "../src/Challenge.sol";
import "../src/Challenge2.sol";

contract ChalengeScript is Script {
  
    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        // Challenge chal =  Challenge(0x771F8f8FD270eD99db6a3B5B7e1d9f6417394249);
        // Attack attack = new Attack();
        ChallengeTwo chal2 =  ChallengeTwo(0x8D6B11D53A4CE78658d8335EafAa1e77A2FB101d);
        Exploit ex = new Exploit();
        ex.passkey(address(chal2));
        ex.point(address(chal2));
        ex.add(address(chal2));
        vm.stopBroadcast();
        }

}