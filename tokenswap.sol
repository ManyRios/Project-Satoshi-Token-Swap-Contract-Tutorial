pragma solidity ^0.5.16;


import './bsctoken.sol'; //import the created BEP20 token before


contract tokenswap is Ownable{
    
    IBEP20 public _tokenA;
    IBEP20 public _tokenB;
    
    
    //Tokens equals to IBEP20 contract 
    constructor( address token )public {
        _tokenA = IBEP20(token);
        _tokenB = new TOKENA("toSwapp", address(this)); //Create new token as an istance of tokenA  
         
    }
    
    event sent(uint amount); 
    
    //Swap exchange
    
    function swap( uint _amount) public{
        address from = msg.sender;
        address to = address(this);
        require( _tokenA.decimals() == _tokenB.decimals(), "the amount must be exact to swap" );
        _tokenA.transferFrom( from, to, _amount );//transfer amounts to the other tokens
        _tokenA._burn( from, _amount ); // burning the tokens in the address of the first address
        _tokenB.transfer( from, _amount ); // the exchange complete
        emit sent(_amount);// If swap success event is sent
    }

}