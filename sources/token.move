module Token {
  // The total supply of the token
  let total_supply: u64;
  // A mapping from account addresses to their token balance
  let balances: map<address, u64>;

  // Initializes the total supply and assigns all of the tokens to the contract creator
  init(supply: u64) {
    total_supply = supply;
    balances[get_txn_sender()] = supply;
  }

  // Transfers tokens from the sender's balance to the recipient's balance
  fun transfer(recipient: address, amount: u64) {
    assert(balances[get_txn_sender()] >= amount, "Not enough balance.");
    balances[get_txn_sender()] -= amount;
    balances[recipient] += amount;
  }

  // Returns the token balance of a given account address
  fun balance_of(account: address): u64 {
    return balances[account];
  }
}
