module AptosToken {
    // Total supply of tokens
    let total_supply: u64;
    // Mapping from address to balance
    let balances: map<address, u64>;
    // event for transfer of tokens
    event Transfer(address, address, u64);

    // constructor to initialize total supply
    public new(initial_supply: u64) {
        total_supply = initial_supply;
        balances[get_txn_sender()] = initial_supply;
    }

    // function to get the balance of an address
    public fun balance_of(address: address): u64 {
        return balances[address];
    }

    // function to transfer tokens from one address to another
    public fun transfer(to: address, value: u64): bool {
        // check if sender has enough balance
        require(balances[get_txn_sender()] >= value, "Sender has insufficient balance.");
        // check if recipient address is not null
        require(to != address(0), "Recipient address is null.");
        // update sender's balance
        balances[get_txn_sender()] -= value;
        // update recipient's balance
        balances[to] += value;
        // emit event
        emit Transfer(get_txn_sender(), to, value);
        return true;
    }
}
