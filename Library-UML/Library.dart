class Book {
  String bookId;
  String author;
  String name;
  double price;
  String rackNo;
  String status;
  String edition;
  String dateOfPurchase;

  Book({
    required this.bookId,
    required this.author,
    required this.name,
    required this.price,
    required this.rackNo,
    required this.status,
    required this.edition,
    required this.dateOfPurchase,
  });

  void displayBookDetails() {
    print('Book [$bookId]: $name by $author (Status: $status, Rack: $rackNo)');
  }

  void updateStatus(String newStatus) {
    status = newStatus;
    print('Book $bookId status updated to: $status');
  }
}

class Journals extends Book {
  Journals({
    required String bookId,
    required String author,
    required String name,
    required double price,
    required String rackNo,
    required String status,
    required String edition,
    required String dateOfPurchase,
  }) : super(
          bookId: bookId,
          author: author,
          name: name,
          price: price,
          rackNo: rackNo,
          status: status,
          edition: edition,
          dateOfPurchase: dateOfPurchase,
        );
}

class Magzines extends Book {
  Magzines({
    required String bookId,
    required String author,
    required String name,
    required double price,
    required String rackNo,
    required String status,
    required String edition,
    required String dateOfPurchase,
  }) : super(
          bookId: bookId,
          author: author,
          name: name,
          price: price,
          rackNo: rackNo,
          status: status,
          edition: edition,
          dateOfPurchase: dateOfPurchase,
        );
}

class StudyBooks extends Book {
  StudyBooks({
    required String bookId,
    required String author,
    required String name,
    required double price,
    required String rackNo,
    required String status,
    required String edition,
    required String dateOfPurchase,
  }) : super(
          bookId: bookId,
          author: author,
          name: name,
          price: price,
          rackNo: rackNo,
          status: status,
          edition: edition,
          dateOfPurchase: dateOfPurchase,
        );
}

class MemberRecord {
  String memberId;
  String type;
  String dateOfMembership;
  int noBookIssued;
  int maxBookLimit;
  String name;
  String address;
  String phoneNo;

  MemberRecord({
    required this.memberId,
    required this.type,
    required this.dateOfMembership,
    required this.noBookIssued,
    required this.maxBookLimit,
    required this.name,
    required this.address,
    required this.phoneNo,
  });

  void retriveMember() {
    print('Member Record [$memberId]: $name ($type) - Books Issued: $noBookIssued/$maxBookLimit');
  }

  void increaseBookIssued() {
    if (noBookIssued < maxBookLimit) {
      noBookIssued++;
      print('Book issued to $name. Total issued: $noBookIssued');
    } else {
      print('Cannot issue book. Max limit ($maxBookLimit) reached for $name.');
    }
  }

  void decreaseBookIssued() {
    if (noBookIssued > 0) {
      noBookIssued--;
      print('Book returned by $name. Total issued: $noBookIssued');
    }
  }

  void payBill(Bill bill) {
    print('Member $name paid bill #${bill.billNo} of \$${bill.amount.toStringAsFixed(2)}');
  }
}

class Student extends MemberRecord {
  Student({
    required String memberId,
    required String dateOfMembership,
    required int noBookIssued,
    required int maxBookLimit,
    required String name,
    required String address,
    required String phoneNo,
  }) : super(
          memberId: memberId,
          type: 'Student',
          dateOfMembership: dateOfMembership,
          noBookIssued: noBookIssued,
          maxBookLimit: maxBookLimit,
          name: name,
          address: address,
          phoneNo: phoneNo,
        );
}

class Faculty extends MemberRecord {
  Faculty({
    required String memberId,
    required String dateOfMembership,
    required int noBookIssued,
    required int maxBookLimit,
    required String name,
    required String address,
    required String phoneNo,
  }) : super(
          memberId: memberId,
          type: 'Faculty',
          dateOfMembership: dateOfMembership,
          noBookIssued: noBookIssued,
          maxBookLimit: maxBookLimit,
          name: name,
          address: address,
          phoneNo: phoneNo,
        );
}

class Librarian {
  String name;
  String password;

  Librarian({
    required this.name,
    required this.password,
  });

  void searchBook(String query) {
    print('Librarian $name searching for book: $query');
  }

  bool verifyMember(MemberRecord member) {
    print('Verifying member status for ID: ${member.memberId}');
    return true;
  }

  void issueBook(Book book, MemberRecord member) {
    if (verifyMember(member) && member.noBookIssued < member.maxBookLimit) {
      book.updateStatus('Issued');
      member.increaseBookIssued();
      print('Book "${book.name}" successfully issued to ${member.name}.');
    }
  }

  double calculateFine(int overdueDays) {
    double fineRatePerDay = 1.5;
    return overdueDays * fineRatePerDay;
  }

  Bill createBill(String billNo, MemberRecord member, double amount) {
    var bill = Bill(
      billNo: billNo,
      date: DateTime.now().toIso8601String().split('T')[0],
      memberId: member.memberId,
      amount: amount,
    );
    bill.billCreate();
    return bill;
  }

  void returnBook(Book book, MemberRecord member) {
    book.updateStatus('Available');
    member.decreaseBookIssued();
    print('Book "${book.name}" returned by ${member.name}.');
  }
}

class Transaction {
  String transId;
  String memberId;
  String bookId;
  String dateOfIssue;
  String dueDate;

  Transaction({
    required this.transId,
    required this.memberId,
    required this.bookId,
    required this.dateOfIssue,
    required this.dueDate,
  });

  void createTransaction() {
    print('Transaction [$transId] created: Book $bookId issued to Member $memberId on $dateOfIssue.');
  }

  void deleteTransaction() {
    print('Transaction [$transId] deleted.');
  }

  void retrieveTransaction() {
    print('Transaction [$transId]: Book $bookId -> Member $memberId (Due: $dueDate)');
  }
}

class Bill {
  String billNo;
  String date;
  String memberId;
  double amount;

  Bill({
    required this.billNo,
    required this.date,
    required this.memberId,
    required this.amount,
  });

  void billCreate() {
    print('Bill [$billNo] generated for Member $memberId. Amount: \$${amount.toStringAsFixed(2)}');
  }

  void billUpdate(double newAmount) {
    amount = newAmount;
    print('Bill [$billNo] updated to \$${amount.toStringAsFixed(2)}');
  }
}

void main() {
  var librarian = Librarian(name: 'Sarah Connor', password: 'adminPassword123');

  var student = Student(
    memberId: 'STU-1001',
    dateOfMembership: '2025-09-01',
    noBookIssued: 0,
    maxBookLimit: 3,
    name: 'Alex Mercer',
    address: 'Campus Dorm A',
    phoneNo: '+123456789',
  );

  var studyBook = StudyBooks(
    bookId: 'BK-501',
    author: 'Robert C. Martin',
    name: 'Clean Code',
    price: 45.0,
    rackNo: 'RACK-B2',
    status: 'Available',
    edition: '1st',
    dateOfPurchase: '2024-01-15',
  );

  librarian.searchBook('Clean Code');
  studyBook.displayBookDetails();

  librarian.issueBook(studyBook, student);

  var transaction = Transaction(
    transId: 'TXN-001',
    memberId: student.memberId,
    bookId: studyBook.bookId,
    dateOfIssue: '2026-09-10',
    dueDate: '2026-09-20',
  );
  transaction.createTransaction();

  double fineAmount = librarian.calculateFine(4); 
  if (fineAmount > 0) {
    var bill = librarian.createBill('BILL-801', student, fineAmount);
    student.payBill(bill);
  }

  librarian.returnBook(studyBook, student);
}