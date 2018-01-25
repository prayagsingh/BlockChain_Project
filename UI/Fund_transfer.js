var myContractInstance;

function startApp(_myContractInstance){
    console.error("startup");
	myContractInstance=_myContractInstance;
    
}

function addPMO_address() {
    var pmo_address = document.getElementById('AddPMO_address').value;
    
    var add_pmo_address = myContractInstance.setPMO(pmo_address,function(err,result){
        if(!err){
            console.log("Pmo Address added successfully. "+ result);
          }
          else {
              console.err("@@@@@@@@@@ Found ERROR "+error);
          }
    });
}

function getPmoAddress() {
    var getPmoAddress = myContractInstance.getPmoAddress(function(err,result){
        if(!err){
            console.log("Pmo Address is: "+ result);
          }
          else {
              console.err("@@@@@@@@@@ Found ERROR "+error);
          }   
    });
}

function addPMO_fund() {
    var pmo_fund = document.getElementById('AddPMO_Fund').value;
    var add_pmo_fund = myContractInstance.updateBalanceOfPMO(pmo_fund,function(err,result){
        if(!err){
            console.log("Pmo Address added successfully. "+ result);
          }
          else {
              console.err(error);
          }
    });
}

function addStateGovt_address(){

}

function addStateGovt_fund(){

}

function addFM() {

}