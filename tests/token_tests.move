module AptosTokenTests {
    use AptosToken

    // Test creating a token contract and initializing the total supply
    #[test]
    public entry fun test_create_contract() {
        let token_contract = AptosToken::new(100);
        // Test that the total supply is set correctly
        assert(token_contract.total_supply() == 100, "Total supply not set correctly.");
        // Test that the contract creator's balance is set to the total supply
        assert(token_contract.balance_of(get_txn_sender()) == 100, "Contract creator's balance not set correctly.");
    }

    // Test transferring tokens from one address to another
    #[test]
    public entry fun test_transfer() {
        let token_contract = AptosToken::new(100);
        let to = address(1);
        let value = 20;
        // Test that the transfer is successful
        assert(token_contract.transfer(to, value), "Transfer failed.");
        // Test that the sender's balance is updated correctly
        assert(token_contract.balance_of(get_txn_sender()) == 80, "Sender's balance not updated correctly after transfer.");
        // Test that the recipient's balance is updated correctly
        assert(token_contract.balance_of(to) == 20, "Recipient's balance not updated correctly after transfer.");
    }

    // Test trying to transfer more tokens than an address has
    #[test]
    public entry fun test_transfer_insufficient_balance() {
        let token_contract = AptosToken::new(100);
        let to = address(1);
        let value = 120;
        // Test that the transfer fails
        assert(!token_contract.transfer(to, value), "Transfer should have failed due to insufficient balance.");
        // Test that the sender's balance is not updated
        assert(token_contract.balance_of(get_txn_sender()) == 100, "Sender's balance should not have been updated.");
        // Test that the recipient's balance is not updated
        assert(token_contract.balance_of(to) == 0, "Recipient's balance should not have been updated.");
    }

    // Test trying to transfer to a null address
    #[test]
    public entry fun test_transfer_to_null_address() {
        let token_contract = AptosToken::new(100);
        let to = address(0);
        let value = 20;
        // Test that the transfer fails
        assert(!token_contract.transfer(to, value), "Transfer should have failed due to null address.");
        // Test that the sender's balance is not updated
        assert(token_contract.balance_of(get_txn_sender()) == 100, "Sender's balance should not have been updated.");
    }
}
