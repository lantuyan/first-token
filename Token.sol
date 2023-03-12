// Code by lantuyan
pragma solidity ^0.8.18;

contract NQL {
    mapping (address => uint) public balances;
    mapping (address => mapping (address => uint)) public allowance;

    event Approval(address indexed owner, address indexed spender, uint value);
    event Transfer(address indexed owner, address indexed spender, uint value);

    uint public totalSupply = 1000 * 10**6 * 18;
    string public name = "lantuyan";
    string public symbol = "NQL";
    uint public decimals = 18;

    constructor() {
        balances[msg.sender] = totalSupply;
    }
    function balanceOf(address owner) public view returns(uint) {
        return balances[owner];
    }
    
    function transfer(address to, uint value) public returns(bool){
        require(balanceOf(msg.sender) > value,"none fund");
        balances[msg.sender] -= value;
        balances[to] += value;
        emit Transfer(msg.sender, to, value);
        return true;
    }
    function transferFrom(address from, address to, uint value) public returns (bool){
        require (balanceOf(from) >= value,"None fund");
        require (allowance[from][msg.sender] >= value,"None fund");
        balances[from] -= value;
        balances[to] += value;
        emit Transfer(from, to, value);
        return true;
    }

    // spender: người được phép chi tiêu token của mình. // chịu phí.
    // sender: người thực hiện lệnh gửi/gọi.
    function approved (address spender, uint value) public returns(bool) {
        allowance[msg.sender][spender] = value;
        emit Approval(msg.sender, spender, value);
        return true;
    }
}