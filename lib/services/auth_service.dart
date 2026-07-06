import 'package:cloud_firestore/cloud_firestore.dart';
import 'firestore_service.dart';

class AuthService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirestoreService _firestore = FirestoreService();

  Barber? _currentBarber;
  Customer? _currentCustomer;

  Barber? get currentBarber => _currentBarber;
  Customer? get currentCustomer => _currentCustomer;
  bool get isLoggedIn => _currentBarber != null || _currentCustomer != null;

  Future<String?> loginWithPin(String pin) async {
    final barber = await _firestore.getBarberByPin(pin);
    if (barber != null) {
      _currentBarber = barber;
      _currentCustomer = null;
      return null;
    }
    return 'Geçersiz PIN';
  }

  Future<String?> loginCustomer(String phone) async {
    final customer = await _firestore.getCustomerByPhone(phone);
    if (customer != null) {
      _currentCustomer = customer;
      _currentBarber = null;
      return null;
    }
    return 'Kayıt bulunamadı';
  }

  Future<String?> registerCustomer(String name, String phone, String email) async {
    final existing = await _firestore.getCustomerByPhone(phone);
    if (existing != null) {
      _currentCustomer = existing;
      _currentBarber = null;
      return null;
    }
    final customer = Customer(
      id: '',
      name: name,
      phone: phone,
      email: email,
      role: 'customer',
    );
    await _firestore.createCustomer(customer);
    _currentCustomer = await _firestore.getCustomerByPhone(phone);
    _currentBarber = null;
    return null;
  }

  void logout() {
    _currentBarber = null;
    _currentCustomer = null;
  }
}
