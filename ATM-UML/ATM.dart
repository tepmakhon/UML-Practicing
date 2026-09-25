class Bank {
  String code;
  String address;

  Bank({
    required this.code,
    required this.address,
  });

  void manages() {
    print('Bank $code manages cards and accounts.');
  }

  void maintains() {
    print('Bank $code maintains ATM infrastructure.');
  }
}

class Customer {
  String name;
  String address;
  String dob;

  Customer({
    required this.name,
    required this.address,
    required this.dob,
  });

  void owns() {
    print('Customer $name owns registered accounts and cards.');
  }
}

class DebitCard {
  String cardNo;
  String ownedBy;

  DebitCard({
    required this.cardNo,
    required this.ownedBy,
  });

  void access() {
    print('Access granted using Debit Card: $cardNo');
  }
}

abstract class Account {
  String type;
  String owner;

  Account({
    required this.type,
    required this.owner,
  });
}

class CurrentAccount extends Account {
  String accountNo;
  double balance;

  CurrentAccount({
    required this.accountNo,
    required this.balance,
    required String owner,
  }) : super(type: 'Current', owner: owner);

  void debit(double amount) {
    if (balance >= amount) {
      balance -= amount;
      print('Debited \$${amount.toStringAsFixed(2)} from Current Account $accountNo');
    } else {
      print('Insufficient balance in Current Account $accountNo');
    }
  }

  void credit(double amount) {
    balance += amount;
    print('Credited \$${amount.toStringAsFixed(2)} to Current Account $accountNo');
  }
}

class SavingsAccount extends Account {
  String accountNo;
  double balance;

  SavingsAccount({
    required this.accountNo,
    required this.balance,
    required String owner,
  }) : super(type: 'Savings', owner: owner);

  void debit(double amount) {
    if (balance >= amount) {
      balance -= amount;
      print('Debited \$${amount.toStringAsFixed(2)} from Savings Account $accountNo');
    } else {
      print('Insufficient balance in Savings Account $accountNo');
    }
  }

  void credit(double amount) {
    balance += amount;
    print('Credited \$${amount.toStringAsFixed(2)} to Savings Account $accountNo');
  }
}

class ATMInfo {
  String location;
  String managedBy;

  ATMInfo({
    required this.location,
    required this.managedBy,
  });

  void identifies() {
    print('ATM located at $location managed by $managedBy');
  }

  void transactions() {
    print('Processing ATM transactions at location: $location');
  }
}

abstract class ATMTransaction {
  String transactionID;
  String date;
  String type;

  ATMTransaction({
    required this.transactionID,
    required this.date,
    required this.type,
  });

  void modifies() {
    print('Executing transaction $transactionID of type $type');
  }
}

class Withdrawl extends ATMTransaction {
  double amount;

  Withdrawl({
    required this.amount,
    required String transactionID,
    required String date,
  }) : super(transactionID: transactionID, date: date, type: 'Withdrawal');

  void withdrawMoney(Account account) {
    modifies();
    if (account is CurrentAccount) {
      account.debit(amount);
    } else if (account is SavingsAccount) {
      account.debit(amount);
    }
  }
}

class Query extends ATMTransaction {
  String queryID;
  String queryType;

  Query({
    required this.queryID,
    required this.queryType,
    required String transactionID,
    required String date,
  }) : super(transactionID: transactionID, date: date, type: 'Query');

  void processing(Account account) {
    modifies();
    if (account is CurrentAccount) {
      print('Query $queryID: Current Account Balance is \$${account.balance.toStringAsFixed(2)}');
    } else if (account is SavingsAccount) {
      print('Query $queryID: Savings Account Balance is \$${account.balance.toStringAsFixed(2)}');
    }
  }
}

class Transfer extends ATMTransaction {
  double amount;
  String accountNo;

  Transfer({
    required this.amount,
    required this.accountNo,
    required String transactionID,
    required String date,
  }) : super(transactionID: transactionID, date: date, type: 'Transfer');

  void performTransfer(Account sourceAccount) {
    modifies();
    if (sourceAccount is CurrentAccount) {
      sourceAccount.debit(amount);
    } else if (sourceAccount is SavingsAccount) {
      sourceAccount.debit(amount);
    }
    print('Transferred \$${amount.toStringAsFixed(2)} to Account $accountNo');
  }
}

class PINValidation extends ATMTransaction {
  String oldPIN;
  String newPIN;

  PINValidation({
    required this.oldPIN,
    required this.newPIN,
    required String transactionID,
    required String date,
  }) : super(transactionID: transactionID, date: date, type: 'PIN Change');

  void pinChange() {
    modifies();
    print('PIN changed successfully.');
  }
}

void main() {
  var bank = Bank(code: 'BNK-001', address: '100 Financial Way');
  var customer = Customer(name: 'John Doe', address: '789 Oak St', dob: '1990-05-15');
  var debitCard = DebitCard(cardNo: '4532-1111-2222-3333', ownedBy: customer.name);

  var savings = SavingsAccount(accountNo: 'SAV-8821', balance: 1200.0, owner: customer.name);

  var atm = ATMInfo(location: 'Central Mall Arcade', managedBy: bank.code);

  bank.manages();
  bank.maintains();
  atm.identifies();
  debitCard.access();

  var withdrawalTxn = Withdrawl(amount: 200.0, transactionID: 'TXN-901', date: '2026-09-24');
  withdrawalTxn.withdrawMoney(savings);

  var balanceQuery = Query(queryID: 'QRY-11', queryType: 'Balance Check', transactionID: 'TXN-902', date: '2026-09-24');
  balanceQuery.processing(savings);

  var pinTxn = PINValidation(oldPIN: '1234', newPIN: '5678', transactionID: 'TXN-903', date: '2026-09-24');
  pinTxn.pinChange();
}