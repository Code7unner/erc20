// SPDX-License-Identifier: GPL-3.0
    
pragma solidity >=0.4.22 <0.9.0;
import "remix_tests.sol"; // this import is automatically injected by Remix.
import "remix_accounts.sol";
import "../contracts/LimbusToken.sol";
import "../contracts/ERC20.sol";

contract testSuite {
    LimbusToken token;
    
    string tokenName = "LimbusToken";
    string tokenSymbol = "LTX";
    uint8 tokenDecimals = 18;
    uint256 tokenTotalSupply = 50000;
    uint256 amount = 5;
    uint256 balance = 50000;

    function beforeAll() public {
        token = new LimbusToken(balance);
        token.transfer(msg.sender, amount);
    }

    function checkSuccess() public {
        Assert.equal(token.name(), tokenName, "name should be equal to LimbusToken");
        Assert.equal(token.symbol(), tokenSymbol, "symbol should be equal to LTX");
        Assert.equal(token.decimals(), tokenDecimals, "decimals should be equal to 18");
        Assert.equal(token.totalSupply(), tokenTotalSupply, "total supply should be equal to 50000");
        Assert.equal(token.balanceOf(msg.sender), amount, "balance should be equal to 5");
        Assert.equal(token.allowance(msg.sender, msg.sender), 0, "allowance should be equal to 0");
        Assert.equal(token.approve(msg.sender, amount), true, "approve is not completed");
        Assert.equal(token.transfer(msg.sender, amount), true, "transfer is not completed");
    }
    
    function checkSenderAndValue() public payable {
        Assert.equal(msg.sender, TestsAccounts.getAccount(0), "Invalid sender");
        Assert.equal(msg.value, 0, "Invalid value");
    }
}
