class Train {
  String trainNo;
  String trainName;

  Train({
    required this.trainNo,
    required this.trainName,
  });
}

class Clerk {
  String id;
  String name;

  Clerk({
    required this.id,
    required this.name,
  });

  void form_detail() {
    print('Clerk $name ($id) processing reservation form details...');
  }

  void cancellation_form() {
    print('Clerk $name ($id) processing cancellation form...');
  }
}

class RailwaySystem {
  String id;

  RailwaySystem({required this.id});

  void response() {
    print('Railway System [$id] responding to request...');
  }
}

class Payment {
  double amount;

  Payment({required this.amount});
}

class Ticket {
  String pnrNo;
  String status;
  int noofPersons;
  String chargeType;

  Ticket({
    required this.pnrNo,
    required this.status,
    required this.noofPersons,
    required this.chargeType,
  });

  void newTicket() {
    print('New Ticket generated: PNR $pnrNo | Status: $status | Passengers: $noofPersons');
  }

  void deleteTicket() {
    status = 'Cancelled';
    print('Ticket PNR $pnrNo has been deleted/cancelled.');
  }
}

class Passenger {
  String name;
  String address;
  int age;
  String gender;

  Passenger({
    required this.name,
    required this.address,
    required this.age,
    required this.gender,
  });

  void searchTrain(String query) {
    print('Passenger $name searching for train: $query');
  }

  Ticket bookTicket(Train train, int numPersons, Payment payment) {
    print('Passenger $name booking ticket for ${train.trainName} (${train.trainNo})');
    var ticket = Ticket(
      pnrNo: 'PNR-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}',
      status: 'Confirmed',
      noofPersons: numPersons,
      chargeType: 'Online Payment',
    );
    ticket.newTicket();
    return ticket;
  }

  void cancelTicket(Ticket ticket) {
    print('Passenger $name requested cancellation for PNR: ${ticket.pnrNo}');
    ticket.deleteTicket();
  }

  void payCharges(Payment payment) {
    print('Passenger $name paid \$${payment.amount.toStringAsFixed(2)}');
  }

  void modifyForm() {
    print('Passenger $name updated form details.');
  }
}

void main() {
  var train = Train(trainNo: 'EXP-101', trainName: 'Express Liner');
  var passenger = Passenger(
    name: 'Michael Scott',
    address: '1725 Slough Avenue',
    age: 42,
    gender: 'Male',
  );
  var clerk = Clerk(id: 'CLK-007', name: 'Pam Beesly');
  var railwaySystem = RailwaySystem(id: 'SYS-MAIN');

  passenger.searchTrain('Express Liner');

  var payment = Payment(amount: 150.0);
  passenger.payCharges(payment);

  var ticket = passenger.bookTicket(train, 2, payment);

  clerk.form_detail();
  railwaySystem.response();

  passenger.cancelTicket(ticket);
  clerk.cancellation_form();
}