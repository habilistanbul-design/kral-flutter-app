class Barber {
  final String id;
  final String name;
  final String title;
  final String avatarUrl;

  Barber({required this.id, required this.name, required this.title, required this.avatarUrl});
}

class Service {
  final String id;
  final String name;
  final String description;
  final String duration;
  final int price;

  Service({required this.id, required this.name, required this.description, required this.duration, required this.price});
}

class TimeSlot {
  final String time;
  final bool available;

  TimeSlot({required this.time, required this.available});
}

final List<Barber> barbers = [
  Barber(id: 'b1', name: 'Ahmet Yılmaz', title: 'Usta Berber', avatarUrl: 'https://i.pravatar.cc/150?img=1'),
  Barber(id: 'b2', name: 'Caner Kaya', title: 'Stilist', avatarUrl: 'https://i.pravatar.cc/150?img=2'),
  Barber(id: 'b3', name: 'Murat Demir', title: 'Sakal Uzmanı', avatarUrl: 'https://i.pravatar.cc/150?img=3'),
];

final List<Service> services = [
  Service(id: 's1', name: 'Klasik Saç Kesimi', description: 'Stil Danışmanlığı Dahil', duration: '45 Dakika', price: 500),
  Service(id: 's2', name: 'Kral Sakal Bakımı', description: 'Sıcak Havlu Masajı', duration: '30 Dakika', price: 350),
  Service(id: 's3', name: 'Premium Paket', description: 'Saç + Sakal + Bakım', duration: '75 Dakika', price: 800),
];

List<TimeSlot> generateTimeSlots() {
  final times = ['10:00', '10:30', '11:00', '11:30', '12:00', '13:30', '14:00', '14:30', '15:00'];
  return times.map((t) => TimeSlot(time: t, available: t != '12:00')).toList();
}
