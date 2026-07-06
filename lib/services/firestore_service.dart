import 'package:cloud_firestore/cloud_firestore.dart';

class Barber {
  final String id;
  final String name;
  final String expertise;
  final String pin;
  final String photoUrl;
  final bool isActive;
  final String status;
  final String leaveDays;

  Barber({
    required this.id,
    required this.name,
    required this.expertise,
    required this.pin,
    required this.photoUrl,
    required this.isActive,
    required this.status,
    required this.leaveDays,
  });

  factory Barber.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Barber(
      id: doc.id,
      name: data['name'] ?? '',
      expertise: data['expertise'] ?? '',
      pin: data['pin'] ?? '',
      photoUrl: data['photoUrl'] ?? '',
      isActive: data['isActive'] ?? true,
      status: data['status'] ?? '',
      leaveDays: data['leaveDays'] ?? '',
    );
  }

  String get avatarUrl => photoUrl.isNotEmpty
      ? photoUrl
      : 'https://i.pravatar.cc/150?img=${name.hashCode % 10 + 1}';

  String get title => expertise;
}

class Service {
  final String id;
  final String name;
  final String description;
  final int duration;
  final int price;
  final bool isActive;

  Service({
    required this.id,
    required this.name,
    required this.description,
    required this.duration,
    required this.price,
    required this.isActive,
  });

  factory Service.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Service(
      id: doc.id,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      duration: data['duration'] ?? 0,
      price: data['price'] ?? 0,
      isActive: data['isActive'] ?? true,
    );
  }
}

class Appointment {
  final String id;
  final String customerId;
  final String customerName;
  final String customerPhone;
  final String barberId;
  final String barberName;
  final String serviceName;
  final String date;
  final String time;
  final int duration;
  final int price;
  final String status;
  final String note;
  final DateTime createdAt;

  Appointment({
    required this.id,
    required this.customerId,
    required this.customerName,
    required this.customerPhone,
    required this.barberId,
    required this.barberName,
    required this.serviceName,
    required this.date,
    required this.time,
    required this.duration,
    required this.price,
    required this.status,
    required this.note,
    required this.createdAt,
  });

  factory Appointment.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Appointment(
      id: doc.id,
      customerId: data['customerId'] ?? '',
      customerName: data['customerName'] ?? '',
      customerPhone: data['customerPhone'] ?? '',
      barberId: data['barberId'] ?? '',
      barberName: data['barberName'] ?? '',
      serviceName: data['serviceName'] ?? '',
      date: data['date'] ?? '',
      time: data['time'] ?? '',
      duration: data['duration'] ?? 0,
      price: data['price'] ?? 0,
      status: data['status'] ?? 'upcoming',
      note: data['note'] ?? '',
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }
}

class SalonProfile {
  final String id;
  final String name;
  final String address;
  final String phone;
  final String logoUrl;
  final String imageUrl;

  SalonProfile({
    required this.id,
    required this.name,
    required this.address,
    required this.phone,
    required this.logoUrl,
    required this.imageUrl,
  });

  factory SalonProfile.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return SalonProfile(
      id: doc.id,
      name: data['name'] ?? '',
      address: data['address'] ?? '',
      phone: data['phone'] ?? '',
      logoUrl: data['logoUrl'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
    );
  }
}

class Customer {
  final String id;
  final String name;
  final String phone;
  final String email;
  final String role;

  Customer({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.role,
  });

  factory Customer.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Customer(
      id: doc.id,
      name: data['name'] ?? '',
      phone: data['phone'] ?? '',
      email: data['email'] ?? '',
      role: data['role'] ?? 'customer',
    );
  }
}

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // ===== BARBERS =====
  Stream<List<Barber>> getBarbers() {
    return _db.collection('barbers').where('isActive', isEqualTo: true).snapshots().map(
          (snapshot) => snapshot.docs.map((doc) => Barber.fromFirestore(doc)).toList(),
        );
  }

  Future<Barber?> getBarberByPin(String pin) async {
    final snapshot = await _db
        .collection('barbers')
        .where('pin', isEqualTo: pin)
        .where('isActive', isEqualTo: true)
        .limit(1)
        .get();
    if (snapshot.docs.isNotEmpty) {
      return Barber.fromFirestore(snapshot.docs.first);
    }
    return null;
  }

  Future<Barber?> getBarberById(String id) async {
    final doc = await _db.collection('barbers').doc(id).get();
    if (doc.exists) {
      return Barber.fromFirestore(doc);
    }
    return null;
  }

  // ===== SERVICES (berbere ait) =====
  Stream<List<Service>> getBarberServices(String barberId) {
    return _db
        .collection('barbers')
        .doc(barberId)
        .collection('services')
        .where('isActive', isEqualTo: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs.map((doc) => Service.fromFirestore(doc)).toList(),
        );
  }

  Future<List<Service>> getBarberServicesOnce(String barberId) async {
    final snapshot = await _db
        .collection('barbers')
        .doc(barberId)
        .collection('services')
        .where('isActive', isEqualTo: true)
        .get();
    return snapshot.docs.map((doc) => Service.fromFirestore(doc)).toList();
  }

  // ===== APPOINTMENTS (berbere ait) =====
  Stream<List<Appointment>> getBarberAppointments(String barberId) {
    return _db
        .collection('barbers')
        .doc(barberId)
        .collection('appointments')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs.map((doc) => Appointment.fromFirestore(doc)).toList(),
        );
  }

  Stream<List<Appointment>> getBarberAppointmentsByDate(String barberId, String date) {
    return _db
        .collection('barbers')
        .doc(barberId)
        .collection('appointments')
        .where('date', isEqualTo: date)
        .orderBy('time')
        .snapshots()
        .map(
          (snapshot) => snapshot.docs.map((doc) => Appointment.fromFirestore(doc)).toList(),
        );
  }

  Stream<List<Appointment>> getBarberUpcomingAppointments(String barberId) {
    final today = DateTime.now().toIso8601String().substring(0, 10);
    return _db
        .collection('barbers')
        .doc(barberId)
        .collection('appointments')
        .where('status', isEqualTo: 'upcoming')
        .where('date', isGreaterThanOrEqualTo: today)
        .orderBy('date')
        .orderBy('time')
        .snapshots()
        .map(
          (snapshot) => snapshot.docs.map((doc) => Appointment.fromFirestore(doc)).toList(),
        );
  }

  Future<void> createAppointment(String barberId, Appointment appointment) async {
    await _db
        .collection('barbers')
        .doc(barberId)
        .collection('appointments')
        .add({
      'customerId': appointment.customerId,
      'customerName': appointment.customerName,
      'customerPhone': appointment.customerPhone,
      'barberId': appointment.barberId,
      'barberName': appointment.barberName,
      'serviceName': appointment.serviceName,
      'date': appointment.date,
      'time': appointment.time,
      'duration': appointment.duration,
      'price': appointment.price,
      'status': appointment.status,
      'note': appointment.note,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> updateAppointmentStatus(String barberId, String appointmentId, String status) async {
    await _db
        .collection('barbers')
        .doc(barberId)
        .collection('appointments')
        .doc(appointmentId)
        .update({'status': status});
  }

  // ===== SALON PROFILE =====
  Stream<SalonProfile?> getSalonProfile() {
    return _db.collection('salon_profile').limit(1).snapshots().map(
          (snapshot) => snapshot.docs.isNotEmpty
              ? SalonProfile.fromFirestore(snapshot.docs.first)
              : null,
        );
  }

  // ===== CUSTOMERS =====
  Future<void> createCustomer(Customer customer) async {
    await _db.collection('customers').add({
      'name': customer.name,
      'phone': customer.phone,
      'email': customer.email,
      'role': customer.role,
    });
  }

  Future<Customer?> getCustomerByPhone(String phone) async {
    final snapshot = await _db
        .collection('customers')
        .where('phone', isEqualTo: phone)
        .limit(1)
        .get();
    if (snapshot.docs.isNotEmpty) {
      return Customer.fromFirestore(snapshot.docs.first);
    }
    return null;
  }

  // ===== ALL SERVICES (tüm berberlerin hizmetlerini topla) =====
  Future<List<Service>> getAllServices() async {
    final barbersSnap = await _db.collection('barbers').where('isActive', isEqualTo: true).get();
    final allServices = <Service>[];
    for (final barberDoc in barbersSnap.docs) {
      final servicesSnap = await _db
          .collection('barbers')
          .doc(barberDoc.id)
          .collection('services')
          .where('isActive', isEqualTo: true)
          .get();
      allServices.addAll(servicesSnap.docs.map((doc) => Service.fromFirestore(doc)));
    }
    return allServices;
  }

  // ===== TOP-LEVEL SERVICES (eğer üst seviyede varsa) =====
  Stream<List<Service>> getTopLevelServices() {
    return _db.collection('services').where('isActive', isEqualTo: true).snapshots().map(
          (snapshot) => snapshot.docs.map((doc) => Service.fromFirestore(doc)).toList(),
        );
  }

  // ===== TOP-LEVEL APPOINTMENTS (eğer üst seviyede varsa) =====
  Stream<List<Appointment>> getAllAppointments() {
    return _db.collection('appointments').orderBy('createdAt', descending: true).snapshots().map(
          (snapshot) => snapshot.docs.map((doc) => Appointment.fromFirestore(doc)).toList(),
        );
  }
}
