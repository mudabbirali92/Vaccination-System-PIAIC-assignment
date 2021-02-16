pragma solidity ^0.6.0;

/*
1. Deploy the UserInfo contract first..
2. After deploying you will see setInformation button. Expand it and enter relative infromatione e.g. desired address whom you want to vaccinate, age and setting flag for that address
3. you can now see the information of address that you have updated infromation of by pressing showInfo button..
4. In order to deploy second contract you have to enter an address of previously deployed contract.
5. you can just simply copy that address from deployed contract with double page icon..
6. Now in gettingVaccinated button just enter an address and phase you want to vaccinate..
7. Enjoy your code is working fine..
*/

// contract of user's information to be deployed on ethereum VM.. 
contract UserInfo 
{
    // we have defined struct of Vaccine consumer here
    struct   Consumer 
    {
        uint age;
        bool isHealthWorker;
       
    } 
    // Now we have declared mapping for above struct in drder to keep track of specific address' information as mentioned in struct...
    mapping (address=>Consumer)  users;
  
    
    function setInformation(address _address,uint _age, bool _isHealthWorker) public returns (string memory)
    {
        //In order to access struct in mapping and declaring varibales of strcut in mapping
        //following syntax is used in the form of indexing
        //for more details about this syntax please refer: https://deanschmid1.medium.com/using-function-to-modify-structs-directly-in-solidity-mappings-809ccce6201b
        
        users[_address].age=_age;// set desire address you want him to be vaccinated..
        users[_address].isHealthWorker=_isHealthWorker; // set flag whether he/she is health worker...
    
    }
    
    // we are displaying informationfor specific address here only
    function showInfo()public view returns(uint,bool)
    {
        
        return (users[msg.sender].age,users[msg.sender].isHealthWorker);
    }
    
    // this function will be used in next contract in order to hold information as defined in struct... 
     function transferInfo(address adr) external view returns(uint,bool)// dont mess with it after deploying this contract.... leave it as is.
     {
         return (users[adr].age,users[adr].isHealthWorker);
     }
}

// Now in this contract we will be administrating Vaccine.
contract Vaccination 
{
    UserInfo  conractsAddress;
    
    struct   Consumer 
    {
        uint age;
        bool isHealthWorker;
        bool isVaccinated;
    } 
   
    mapping (address=>Consumer)  users;
    
    // this is used to get the address of previoulsy delpoyed conttact that will help in intantiating object later...
    constructor(address previousAddresses) public
    {
        conractsAddress=UserInfo(previousAddresses);
    }
    
    
     //Now play around with your own logic that once a specific address is vaccinated then is not allowed for second time..
     // other miscellaneous conditions are mentioned in assignment's details...
     function gettingVaccinated(uint phase,address _address)public returns(string memory)
     {    
         // this will just access the information that was used and already deployed on block chain i.e. UserInfo....
         (users[_address].age,users[_address].isHealthWorker)=conractsAddress.transferInfo(_address);
         
         //////////////////////////////////// conditions start//////////////////////////////////////////////////////////////////////////////////
         if(users[_address].isHealthWorker==true && phase==1 && users[_address].isVaccinated==false)
         {
             users[_address].isVaccinated=true;
             return "Successfully vaccinated";
         }
         else if (users[_address].isHealthWorker==true && phase==1 && users[_address].isVaccinated==true)
         {
             
             return "Sorry you have been already vaccinated";
         }
         else if (users[_address].isHealthWorker==true && phase!=1 && (users[_address].isVaccinated==true ||
         users[_address].isVaccinated==false))
         {
             
             return "Sorry you are not allowed in this phase";
         }
         
         
         if(users[_address].isHealthWorker==false && phase==2 && users[_address].age>=50 && users[_address].isVaccinated==false)
         {
             users[_address].isVaccinated=true;
             return "Successfully vaccinated";
         }
         else if (users[_address].isHealthWorker==false && phase==2 && users[_address].age>=50 && users[_address].isVaccinated==true)
         {
             return "Sorry you have been already vaccinated";
         }
         else if (users[_address].isHealthWorker==false && phase!=2 && users[_address].age>=50 && (users[_address].isVaccinated==true||
         users[_address].isVaccinated==false))
         {
             
             return "Sorry you are not allowed in this phase";
         }
         
         
         if(users[_address].isHealthWorker==false && phase==3 && users[_address].age>=40 && users[_address].age<=50 && users[_address].isVaccinated==false)
         {
             users[_address].isVaccinated=true;
             return "Successfully vaccinated";
         }
         else if (users[_address].isHealthWorker==false && phase==3 && users[_address].age>=40 && users[_address].age<=50 && users[_address].isVaccinated==true)
         {
             return "Sorry you have been already vaccinated";
         }
         else if (users[_address].isHealthWorker==false && phase!=3 && users[_address].age>=40 && users[_address].age<=50 && (users[_address].isVaccinated==true
         ||users[_address].isVaccinated==false))
         {
             
             return "Sorry you are not allowed in this phase";
         }
         
         if(users[_address].isHealthWorker==false && phase==2 && users[_address].age<50  && (users[_address].isVaccinated==true
         ||users[_address].isVaccinated==false))
         {
            return "Sorry you are under age for this phase..";
         }
         else if (users[_address].isHealthWorker==false && phase==3 && users[_address].age<40 && (users[_address].isVaccinated==true
         ||users[_address].isVaccinated==false))
         {
             return "Sorry you are under age for this phase..";
         }
        
     }
// For any help please refer to my github account
// https://github.com/mudabbirali92
    
}
 
    
    

