class User {
  String emailID;
  String password;
  String firstName;
  String lastName;
  String streetAddress;
  String zipcode;
  String city;
  String state;
  String country;
  String phone;

  User({
    required this.emailID,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.streetAddress,
    required this.zipcode,
    required this.city,
    required this.state,
    required this.country,
    required this.phone,
  });

  bool login(String email, String pwd) {
    if (email == emailID && pwd == password) {
      print('User logged in successfully.');
      return true;
    }
    print('Invalid credentials.');
    return false;
  }

  void registration() {
    print('User registered: $emailID');
  }

  void logout() {
    print('User logged out.');
  }
}

class Seller extends User {
  String ID;
  String itemName;
  String itemID;
  double discount;
  String category;

  Seller({
    required this.ID,
    required this.itemName,
    required this.itemID,
    required this.discount,
    required this.category,
    required String emailID,
    required String password,
    required String firstName,
    required String lastName,
    required String streetAddress,
    required String zipcode,
    required String city,
    required String state,
    required String country,
    required String phone,
  }) : super(
          emailID: emailID,
          password: password,
          firstName: firstName,
          lastName: lastName,
          streetAddress: streetAddress,
          zipcode: zipcode,
          city: city,
          state: state,
          country: country,
          phone: phone,
        );
}

class Customer extends User {
  String cID;
  String shipName;
  String shipAddress;
  int noofItems;

  Customer({
    required this.cID,
    required this.shipName,
    required this.shipAddress,
    required this.noofItems,
    required String emailID,
    required String password,
    required String firstName,
    required String lastName,
    required String streetAddress,
    required String zipcode,
    required String city,
    required String state,
    required String country,
    required String phone,
  }) : super(
          emailID: emailID,
          password: password,
          firstName: firstName,
          lastName: lastName,
          streetAddress: streetAddress,
          zipcode: zipcode,
          city: city,
          state: state,
          country: country,
          phone: phone,
        );

  void payment() {
    print('Processing payment for customer $cID...');
  }

  void addCard(CCDetails card) {
    print('Card ${card.cardNo} added for $shipName.');
  }

  void addToCart(CartDetails cart, String itemID, double amount) {
    cart.add(itemID, amount);
    noofItems++;
  }

  void cancel(Cancellation cancellation) {
    cancellation.update();
  }
}

class CartDetails {
  String creditNo;
  String itemID;
  double amount;
  String category;

  CartDetails({
    required this.creditNo,
    required this.itemID,
    required this.amount,
    required this.category,
  });

  void add(String id, double price) {
    itemID = id;
    amount += price;
    print('Added item $id to cart. Total amount: \$${amount.toStringAsFixed(2)}');
  }

  void checkOut(PaymentSystem paymentSystem) {
    print('Checking out cart with total \$${amount.toStringAsFixed(2)}');
    paymentSystem.paymentDetails();
  }
}

class CCDetails {
  String cardNo;
  String issueDate;
  String expiryDate;

  CCDetails({
    required this.cardNo,
    required this.issueDate,
    required this.expiryDate,
  });

  bool verifyDetails() {
    print('Verifying card details for card ending in ${cardNo.substring(cardNo.length - 4)}...');
    return true;
  }

  void performTransac(Transaction transaction) {
    if (verifyDetails()) {
      transaction.commit();
    } else {
      transaction.rollback();
    }
  }
}

class Cancellation {
  String cID;
  String itemID;
  double amount;

  Cancellation({
    required this.cID,
    required this.itemID,
    required this.amount,
  });

  void retrieve() {
    print('Retrieving cancellation details for item $itemID');
  }

  void update() {
    print('Cancellation process updated for customer $cID');
  }
}

class PaymentSystem {
  String custID;
  String custName;
  String billAddress;
  String cardNo;

  PaymentSystem({
    required this.custID,
    required this.custName,
    required this.billAddress,
    required this.cardNo,
  });

  void viewOrder() {
    print('Displaying order for customer $custName ($custID)');
  }

  void paymentDetails() {
    print('Payment details processed for billing address: $billAddress');
  }
}

class Transaction {
  String transID;
  String transDate;
  double amount;

  Transaction({
    required this.transID,
    required this.transDate,
    required this.amount,
  });

  void commit() {
    print('Transaction $transID committed successfully for \$${amount.toStringAsFixed(2)}.');
  }

  void rollback() {
    print('Transaction $transID failed and rolled back.');
  }
}

void main() {
  var customer = Customer(
    cID: 'CUST101',
    shipName: 'Jane Doe',
    shipAddress: '456 Elm St',
    noofItems: 0,
    emailID: 'jane.doe@example.com',
    password: 'securePassword123',
    firstName: 'Jane',
    lastName: 'Doe',
    streetAddress: '456 Elm St',
    zipcode: '90001',
    city: 'Los Angeles',
    state: 'CA',
    country: 'USA',
    phone: '+1987654321',
  );

  customer.login('jane.doe@example.com', 'securePassword123');

  var cart = CartDetails(
    creditNo: '4111222233334444',
    itemID: '',
    amount: 0.0,
    category: 'Books',
  );

  customer.addToCart(cart, 'BOOK-987', 29.99);

  var card = CCDetails(
    cardNo: '4111222233334444',
    issueDate: '01/24',
    expiryDate: '12/28',
  );

  customer.addCard(card);

  var paymentSystem = PaymentSystem(
    custID: customer.cID,
    custName: customer.firstName,
    billAddress: customer.streetAddress,
    cardNo: card.cardNo,
  );

  cart.checkOut(paymentSystem);

  var txn = Transaction(
    transID: 'TXN-5501',
    transDate: '2026-09-24',
    amount: cart.amount,
  );

  card.performTransac(txn);
  customer.logout();
}