pragma solidity ^0.4.13;

contract Operations {
    
    // top level - PMO
    // state
    // DM
    // pradhan
    // contractor
    
    address public owner; // finance minister is the owner
    address public PMO;
    address public StateGovt;
    address public DM;
    address public Pradhan;
    //uint state_id=1;
    
    mapping (uint => uint ) public projectCostPromised; //projectCostPromised[roadConstruction] = 200000000;
    mapping (address => uint) public balance;// balance[address] = value
    
    
    //constructor. Initialised only once 
    function Operations() {
        owner = msg.sender;
    }
  
    // Getter function to get the address. This is designed to get the address
    // in javascript code
    function getPmoAddress() constant returns(address) {
        return PMO;
    }
    
    function getStateGovtAddress() constant returns(address){
        return StateGovt;
    }
    
    function getDMAddress() constant returns(address){
        return DM;
    }
    
    function getPradhanAddress() constant returns(address){
        return Pradhan;
    }
  //**************************************************************************//
                                    //EVENTS FOR DEBUGGING
//**************************************************************************//                                    
  
    // event for debugging 
    event SendAmountByPMO(address PMO, address _sendTo, uint _amount);
    
    event checkAddress(address PMO);
    
//***************************************************************************//
//                              OWNERS
//***************************************************************************//
    
    modifier onlyOwner ( ){
        require(owner == msg.sender);
        _;
    }
    
    modifier onlyPMO (address _pmo) {
       require(PMO == _pmo);
        _;
    }
    
    modifier onlyStateGovt (address _stategovt){
        require(StateGovt == _stategovt);
        _;
    }
    
    modifier only_DM (address _dm){
        require (DM == _dm);
        _;
    }
    
    modifier only_Pradhan(address _pradhan){
        require(Pradhan == _pradhan);
        _;
    }
    //************************************************************************//
    //                          ASSIGNING ADDRESS By THE RESPECTIVE AUTHORITY
    //***********************************************************************//
    
    /// this function shall be called by FM only
    function setPMO(address _pmoAddress) onlyOwner {
        PMO = _pmoAddress; // PMO address set
    }
    
    //called by PMO only
    function setStateGovt(address _stategovtAddress) {  
        //onlyPMO(msg.sender)
        checkAddress(msg.sender);
        require(msg.sender == PMO); 
        StateGovt = _stategovtAddress;
    }
    
    //called by StateGovt only
    function setDM(address _dm) onlyStateGovt(msg.sender) {
        checkAddress(msg.sender); 
        DM = _dm;
    }
    
    //called by DM
    function setPradhan(address _pradhan) only_DM(msg.sender) {
      //require(msg.sender==DM);
      Pradhan=_pradhan;
     
    }
//***************************************************************************//
//                    UPDATE THE BALANCE
//****************************************************************************//
    
    // this is used to update the balance of the PMO and only FM can do that
    function updateBalanceOfPMO( uint _amount) onlyOwner {
    // finance minister
    balance[PMO] = _amount;
    
    }
    //only PMO can do this
    function updateBalanceofStateGovt(uint _amount) onlyPMO(msg.sender) {
        //only PMO
        balance[StateGovt]=_amount;
    }
    
    //only stategovt. can do this
    function updateBalanceOf_DM(uint _amount) onlyStateGovt(msg.sender) {
        balance[DM] = _amount;
    }
    
    function updateBalanceOf_Pradhan(uint _amount) only_DM(msg.sender) {
        balance[Pradhan] = _amount;
    }


    /***********************************************************************/
     //            SEND AMOUNT TO LOWER LEVEL
    /************************************************************************/                 
    
    /// before calling this function, make sure that the PMO is set by the FM by calling function `setPMO()`
    function sendAmountBYPMO(uint amount, address sendto)
    onlyPMO(msg.sender)
    {
            require (amount > 0 && balance[PMO] > amount ) ;
            balance[msg.sender] = balance[msg.sender]-amount;
            balance[sendto] = balance[sendto] + amount;
            // event to print the values
            SendAmountByPMO(msg.sender, sendto, amount);
            
        // amount is in WEI=> e.g. 1 Ether= 10^18 Wei
        
    }
    
    function sendAmountByS_Govt(uint amount, address sendto) onlyStateGovt(msg.sender) {
        require(amount > 0 && balance[msg.sender] > amount);
        balance[msg.sender] = balance[msg.sender]-amount;
        balance[sendto] = balance[sendto] + amount;
        
    }
    
    function sendAmount_by_DM(address sendto,uint amount) only_DM(msg.sender) {
        require(balance[msg.sender] > amount && amount > 0);
        balance[msg.sender]-=amount;
        balance[sendto]+=amount;
    }
    
    function sendAMount_by_Pradhan(address sendto, uint amount) only_Pradhan(msg.sender) {
        require(balance[msg.sender] > amount && amount > 0);
        balance[msg.sender]-=amount;
        balance[sendto]+=amount;
    }
 /****************************************************************************
    
    
    */
}