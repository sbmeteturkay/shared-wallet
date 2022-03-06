pragma solidity ^0.8.0;
//SPDX-License-Identifier: UNLICENSED
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/math/SafeMath.sol";
import "./Allowance.sol";

contract SimpleWallet is Allowance{

    event MoneySent(address _beneficiary,uint _amount);
    event MoneyRecevied(address _from,uint _amount);
    function transferToFallback(address payable _to) public payable {
        _to.transfer(msg.value);
    }
    function withDrawMoney(address payable _to, uint _amount) public  onlyOwner{
        require(_amount<=address(this).balance,"There is not enough funds in smart contract");
        if(owner()!=msg.sender){
            reduveAllowance(msg.sender,_amount);
        }
        emit MoneySent(msg.sender,_amount);
        _to.transfer(_amount);
    }

    function renounceOwnership() public override view onlyOwner{
        revert("Can't renounceOwnership in this contract");
    }

    fallback () external payable{
        emit MoneyRecevied(msg.sender,msg.value);
    }
    receive () external payable{
        emit MoneyRecevied(msg.sender,msg.value);
    }
}