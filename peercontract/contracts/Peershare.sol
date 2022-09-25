// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

import "./ECDSA.sol";

// smart contract to add new user, new cars and any ride on the blockchain
contract Peershare {
    mapping(bytes32 => bytes) userSignature;

    function addUser(bytes32 userHash, bytes memory signature)
        public
        returns (bool)
    {
        // Get signer from signature
        address signer = ECDSA.recover(
            ECDSA.toEthSignedMessageHash(
                keccak256(abi.encodePacked(userHash, msg.sender))
            ),
            signature
        );

        // Verify if the sender is the owner
        require(
            signer == msg.sender,
            "Unauthorised signer has been dectected."
        );

        // Add user signature
        userSignature[userHash] = signature;

        return true;
    }

    // TODO: add new car to blockchain
}
