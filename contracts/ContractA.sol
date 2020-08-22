pragma solidity ^0.6.0;
import './Token.sol';
import "@openzeppelin/upgrades/contracts/Initializable.sol";
contract ContractA is Initializable{
    Token public _token;
    mapping(address=>uint256) _balance;
    function initialize(Token addr) public initializer{
        _token=addr;
    }
    function deposit(address owner,uint256 _tokens) public{
        //_token.approve(address(this),_tokens);
        _token.transferHelper(owner,address(this),_tokens);
        _balance[owner]=_tokens;
        timeout[owner]=block.timestamp;
    }
    function timeOut(address owner) public view returns(uint){
        return timeout[owner];
    }
    function withdraw(address owner) public{
        require(block.timestamp>=timeout[owner] + 15 seconds,"time not expired");
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
    function updateTime(uint secs,address owner) public returns(uint){
        timeout[owner]=block.timestamp+secs;
    }
    mapping(address=>uint) timeout;
}