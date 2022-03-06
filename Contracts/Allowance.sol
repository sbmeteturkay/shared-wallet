pragma solidity ^0.8.0;
contract Allowance is Ownable{

    using SafeMath for uint;

    event AllowanceChanged(address indexed _forWho, address indexed _forWhom, uint _oldAmount, uint _newAmount);
    mapping(address=>uint) public allowance;

    function addAllowance(address _who, uint _amount) public onlyOwner{
        emit AllowanceChanged(_who,msg.sender,allowance[_who],_amount);
        allowance[_who]=_amount;
    }
    function reduveAllowance(address _who,uint _amount)internal {
        emit AllowanceChanged(_who,msg.sender,allowance[_who],allowance[_who].sub(_amount));
        allowance[_who]=allowance[_who].sub(_amount);
    }
    modifier ownerOrAllowed(uint _amount){
        require(owner()==msg.sender||allowance[msg.sender]>_amount,"You are not allowed");
        _;
    }
}