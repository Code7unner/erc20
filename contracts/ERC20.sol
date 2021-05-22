// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./Context.sol";

contract ERC20 is Context {
    using SafeMath for uint256;
    
    mapping (address => uint256) private balances_;

    mapping (address => mapping (address => uint256)) private allowances_;

    uint256 private totalSupply_;

    string private name_;
    string private symbol_;
    
    
    constructor(string memory _name, string memory _symbol) {
        name_ = _name;
        symbol_ = _symbol;
    }
    
    function name() public view returns (string memory) {
        return name_;
    }

    function symbol() public view returns (string memory) {
        return symbol_;
    }

    function decimals() public pure returns (uint8) {
        return 18;
    }
    
    function totalSupply() public view returns (uint256) {
        return totalSupply_;
    }

    function balanceOf(address _owner) public view returns (uint256 balance) {
        return balances_[_owner];
    }

    function transfer(address _to, uint256 _value) public returns (bool success) {
        _transfer(_msgSender(), _to, _value);
        return true;
    }

    function allowance(address _owner, address _spender) public view returns (uint256) {
        return allowances_[_owner][_spender];
    }

    function approve(address _spender, uint256 _value) public returns (bool success) {
        _approve(_msgSender(), _spender, _value);
        return true;
    }

    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
        _transfer(_from, _to, _value);

        uint256 currentAllowance = allowances_[_from][_msgSender()];
        require(currentAllowance >= _value, "ERC20: transfer amount exceeds allowance");
        unchecked {
            _approve(_from, _msgSender(), currentAllowance.sub(_value));
        }

        return true;
    }
    
    function _transfer(address _sender, address _recipient, uint256 _value) internal virtual {
        require(_sender != address(0), "ERC20: transfer from the zero address");
        require(_recipient != address(0), "ERC20: transfer to the zero address");

        _beforeTokenTransfer(_sender, _recipient, _value);

        uint256 senderBalance = balances_[_sender];
        require(senderBalance >= _value, "ERC20: transfer amount exceeds balance");
        unchecked {
            balances_[_sender] = senderBalance.sub(_value);
        }
        balances_[_recipient] = balances_[_recipient].add(_value);

        emit Transfer(_sender, _recipient, _value);
    }
    
    function _approve(address _owner, address _spender, uint256 _value) internal virtual {
        require(_owner != address(0), "ERC20: approve from the zero address");
        require(_spender != address(0), "ERC20: approve to the zero address");

        allowances_[_owner][_spender] = _value;
        emit Approval(_owner, _spender, _value);
    }
    
    function mint(address _account, uint256 _amount) internal virtual {
        require(_account != address(0), "ERC20: mint to the zero address");

        _beforeTokenTransfer(address(0), _account, _amount);

        totalSupply_ = totalSupply_.add(_amount);
        balances_[_account] = balances_[_account].add(_amount);
        emit Transfer(address(0), _account, _amount);
    }

    function burn(uint256 _amount) internal virtual {
        uint256 accountBalance = balances_[msg.sender];
        require(accountBalance >= _amount, "ERC20: burn amount exceeds balance");
        unchecked {
            balances_[msg.sender] = accountBalance.sub(_amount);
        }
        totalSupply_ = totalSupply_.sub(_amount);

        emit Transfer(msg.sender, address(0), _amount);
    }

    function _beforeTokenTransfer(address from, address to, uint256 amount) internal virtual { }

    event Transfer(address indexed _from, address indexed _to, uint256 _value);

    event Approval(address indexed _owner, address indexed _spender, uint256 _value);
}

library SafeMath {
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        assert(b <= a);
        return a - b;
    }
    
    function add(uint256 a, uint256 b) internal pure returns (uint256)   {
        uint256 c = a + b;
        assert(c >= a);
        return c;
    }
}