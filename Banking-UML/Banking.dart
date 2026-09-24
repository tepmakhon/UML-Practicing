class Customer {
  String customerName;
  String accNumber;
  String address;
  String phone;

  Customer({
    required this.customerName,
    required this.accNumber,
    required this.address,
    required this.phone,
  });

  void createAccount() {
    print('Account created for $customerName');
  }

  void deposit(Account account, double amount) {
    account.balance += amount;
    print('Deposited \$${amount.toStringAsFixed(2)} to account ${account.accNo}');
  }

  void withdraw(Account account, double amount) {
    if (account.balance >= amount) {
      account.balance -= amount;
      print('Withdrew \$${amount.toStringAsFixed(2)} from account ${account.accNo}');
    } else {
      print('Insufficient balance in account ${account.accNo}');
    }
  }
}

class Account {
  String accNo;
  String custName;
  double balance;

  Account({
    required this.accNo,
    required this.custName,
    required this.balance,
  });

  void updateAcc({String? newCustName}) {
    if (newCustName != null) {
      custName = newCustName;
    }
    print('Account $accNo details updated');
  }

  void checkAcc() {
    print('Account No: $accNo | Holder: $custName | Balance: \$${balance.toStringAsFixed(2)}');
  }
}

class Bank {
  String custDetails;
  String loanDetails;
  String transNo;
  String transDate;
  String transTime;

  Bank({
    required this.custDetails,
    required this.loanDetails,
    required this.transNo,
    required this.transDate,
    required this.transTime,
  });

  void giveLoan(Customer customer, double amount) {
    print('Loan of \$${amount.toStringAsFixed(2)} granted to ${customer.customerName}');
  }

  void updateDetails(Customer customer) {
    print('Updated bank records for customer: ${customer.customerName}');
  }

  void collectMoney(Account account, double amount) {
    account.balance -= amount;
    print('Collected \$${amount.toStringAsFixed(2)} from account ${account.accNo}');
  }

  void transaction(Account sourceAcc, Account targetAcc, double amount) {
    if (sourceAcc.balance >= amount) {
      sourceAcc.balance -= amount;
      targetAcc.balance += amount;
      print('Transferred \$${amount.toStringAsFixed(2)} from ${sourceAcc.accNo} to ${targetAcc.accNo}');
    } else {
      print('Transaction failed due to insufficient funds');
    }
  }
}

void main() {
  var customer = Customer(
    customerName: 'Alice Johnson',
    accNumber: 'ACC1001',
    address: '123 Main St',
    phone: '+1234567890',
  );

  var account = Account(
    accNo: 'ACC1001',
    custName: customer.customerName,
    balance: 500.0,
  );

  var bank = Bank(
    custDetails: 'Alice Johnson - Primary',
    loanDetails: 'No active loans',
    transNo: 'TXN001',
    transDate: '2026-09-24',
    transTime: '16:00:00',
  );

  customer.createAccount();
  account.checkAcc();
  customer.deposit(account, 200.0);
  customer.withdraw(account, 100.0);
  account.checkAcc();
  bank.giveLoan(customer, 5000.0);
}