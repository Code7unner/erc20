// Implements ERC 20 Token standard: https://github.com/ethereum/EIPs/issues/20

pragma solidity ^0.4.4;

import "./Token.sol";

contract LimbusToken is Token {
    string public name = "Limbus Bucks";
    uint8 public decimals = 18;
    string public symbol = "LBX";
    string public version = 'H0.1'; 
    
    mapping (address => uint256) balances;
    
    mapping (address => mapping (address => uint256)) allowed;
    uint256 public totalSupply;
    
    function totalSupply() public constant returns (uint256 supply) {
        return totalSupply;
    }
    
    function transfer(address _to, uint256 _value) public returns (bool success) {
        if (balances[msg.sender] >= _value && balances[_to] + _value > balances[_to]) {
            balances[msg.sender] -= _value;
            balances[_to] += _value;
            emit Transfer(msg.sender, _to, _value);
            return true;
        } else { return false; }
    }
    
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
        if (balances[_from] >= _value && allowed[_from][msg.sender] >= _value && balances[_to] + _value > balances[_to]) {
            balances[_to] += _value;
            balances[_from] -= _value;
            allowed[_from][msg.sender] -= _value;
            emit Transfer(_from, _to, _value);
            return true;
        } else { return false; }
    }
    
     function balanceOf(address _owner) public constant returns (uint256 balance) {
        return balances[_owner];
    }
    
    function approve(address _spender, uint256 _value) public returns (bool success) {
        allowed[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }
    
    function allowance(address _owner, address _spender) public constant returns (uint256 remaining) {
      return allowed[_owner][_spender];
    }
    
    function name() public view returns (string) {
        return name;
    }
    
    function symbol() public view returns (string) {
        return symbol;
    }
    
    function decimals() public view returns (uint8) {
        return decimals;
    }
}