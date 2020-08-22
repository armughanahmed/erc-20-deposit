pragma solidity ^0.6.0;
import './Token.sol';
import "@openzeppelin/upgrades/contracts/Initializable.sol";
contract ContractA is Initializable{
    Token public _token;
    mapping(address=>uint256) _balance;
    function initialize(Token addr) public initializer{
        _token=addr;
    }
    function deposit(address owner) public{
        uint256 _tokens=_token.balanceOf(owner);    
        //_token.approve(address(this),_tokens);
        _token.transferHelper(owner,address(this),_tokens);
        _balance[owner]=_tokens;
        timeout=block.timestamp;
    }
    function timeOut() public view returns(uint){
        return timeout;
    }
    function withdraw(address owner) public{
        require(block.timestamp>=timeout + 15 seconds,"time not expired");
        _token.transferHelper(address(this),owner,_balance[owner]);
        _balance[owner]=0;
    }
    function getBalance(address owner) public view returns(uint256){
        return _token.balanceOf(owner);
    }
    function getBalance1(address owner) public view returns(uint256){
        return _balance[owner];
    }
    function getAddress() public view returns(address){
        return address(this);
    }
    function getTokenAddress() public view returns(address){
        return address(_token);
    }
    function getCurrentTime() public view returns(uint){
        return block.timestamp;
    }
    function updateTime(uint secs) public returns(uint){
        timeout=block.timestamp+secs;
    }
    uint timeout;
}