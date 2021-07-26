pragma solidity >=0.7.0 <0.9.0;

contract Owner {
    address public owner;
    
    constructor() public {
        owner = msg.sender;
    }
    
    modifier check() {
        require(msg.sender == owner, 'You are not the owner of this vault');
        _;
    }
}

contract Keeper {
    string vault_information;

    constructor(string memory secret) public {
        vault_information = secret;
    }
    
    function get() public view returns(string memory) {
        return vault_information;
    }
}

contract Vault is Owner {
    address my_vault;
    
    constructor(string memory _secret) public {
        Keeper create = new Keeper(_secret);
        my_vault = address(create);
        super;
    }
    
    function unlock_vault() public check view returns(string memory) {
        Keeper vault = Keeper(my_vault);
        return vault.get();
    }
}