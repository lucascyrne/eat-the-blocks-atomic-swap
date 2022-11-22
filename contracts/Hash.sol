pragma solidity ^0.8.7;

contract Hash {
    function calculateHash(string memory _key) external view returns(bytes32) {
        return keccak256(abi.encodePacked(_key));
    }
}