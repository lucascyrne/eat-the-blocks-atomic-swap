pragma solidity ^0.8.7;

interface IERC20 {
    function transfer(address to, uint256 amount) external returns (bool);
    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) external returns (bool);
}

contract HTLC {
    uint public startTime;
    uint public lockTime = 10000 seconds;
    string public secret; // abracadabra
    bytes32 public hash = 0xfd69353b27210d2567bc0ade61674bbc3fc01a558a61c2a0cb2b13d96f9387cd;
    address public recipient; // Bob or Alice depending on the Blockchain deployed
    address public owner; // For the refund function
    uint public amount;
    IERC20 public token;

    constructor(address _recipient, address _token, uint _amount) {
        recipient = _recipient;
        owner = msg.sender;
        token = IERC20(_token);
        amount = _amount;
    }

    function fund() external {
        startTime = block.timestamp;
        token.transferFrom(msg.sender, address(this), amount);
    }

    function withdraw(string memory _secret) external {
        require((keccak256(abi.encodePacked(_secret))) == hash, "Wrong secret");
        secret = _secret;
        token.transfer(recipient, amount);
    }

    function refund() external {
        require(block.timestamp > startTime + lockTime, "Too early!");
        token.transfer(owner, amount);
    }
} 