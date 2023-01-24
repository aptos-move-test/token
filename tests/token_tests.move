import 0x0.Token;

// Test creating a token contract and initializing the total supply
test {
    let amrit = address(1);
    let amit = address(2);
    let shyam = address(3);
    let token_contract = create_contract(Token, 100);

    // Test that the total supply is set correctly
    assert(token_contract.total_supply() == 100, "Total supply not set correctly.");

    // Test that the contract creator's balance is set to the total supply
    assert(token_contract.balance_of(get_txn_sender()) == 100, "Contract creator's balance not set correctly.");

    // Test transferring tokens from one address to another
    token_contract.transfer(amit, 20);
    assert(token_contract.balance_of(amrit) == 80, "amrit's balance not updated correctly after transfer.");
    assert(token_contract.balance_of(amit) == 20, "amit's balance not updated correctly after transfer.");

    // Test trying to transfer more tokens than an address has
    token_contract.transfer(shyam, 100);
    assert(token_contract.balance_of(shyam) == 0, "shyam's balance should not have been updated.");
    assert(token_contract.balance_of(amrit) == 80, "amrit's balance should not have been updated.");
}
