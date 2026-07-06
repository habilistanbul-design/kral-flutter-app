import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../services/firestore_service.dart';
import '../widgets/bottom_nav.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final FirestoreService _firestore = FirestoreService();
  String? selectedBarberId;
  String? selectedServiceId;
  String? selectedTime;
  DateTime selectedDate = DateTime.now();
  final noteController = TextEditingController();
  bool showToast = false;
  List<Barber> _barbers = [];
  List<Service> _services = [];

  @override
  void initState() {
    super.initState();
    _firestore.getBarbers().listen((barbers) {
      if (mounted) setState(() => _barbers = barbers);
    });
  }

  void _loadBarberServices(String barberId) async {
    final services = await _firestore.getBarberServicesOnce(barberId);
    if (mounted) setState(() => _services = services);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Randevu Al', style: GoogleFonts.libreCaslonText(fontSize: 24, fontWeight: FontWeight.w600)),
        backgroundColor: AppTheme.surface,
        surfaceTintColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildStepLabel('Adım 1', 'Berberinizi Seçin'),
                const SizedBox(height: 16),
                SizedBox(
                  height: 180,
                  child: _barbers.isEmpty
                      ? const Center(child: CircularProgressIndicator(color: AppTheme.primary))
                      : ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _barbers.length,
                          itemBuilder: (context, index) {
                            final barber = _barbers[index];
                            final isSelected = selectedBarberId == barber.id;
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedBarberId = barber.id;
                                  selectedServiceId = null;
                                  _services = [];
                                });
                                _loadBarberServices(barber.id);
                              },
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                width: 150,
                                margin: const EdgeInsets.only(right: 16),
                                padding: const EdgeInsets.all(16),
                                transform: isSelected ? (Matrix4.identity()..translate(0.0, -2.0)) : Matrix4.identity(),
                                decoration: BoxDecoration(
                                  color: isSelected ? AppTheme.primaryFixedDim.withOpacity(0.05) : AppTheme.surfaceContainerLowest,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: isSelected ? AppTheme.primaryContainer : AppTheme.outlineVariant.withOpacity(0.2),
                                    width: isSelected ? 2 : 1,
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.network(barber.avatarUrl, fit: BoxFit.cover, width: double.infinity),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(barber.name, style: GoogleFonts.manrope(fontWeight: FontWeight.w600, fontSize: 13)),
                                    Text(barber.expertise, style: GoogleFonts.manrope(fontSize: 11, color: AppTheme.secondary), maxLines: 1, overflow: TextOverflow.ellipsis),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ),
                const SizedBox(height: 24),
                const _GoldThread(),
                const SizedBox(height: 24),
                _buildStepLabel('Adım 2', 'Hizmet Seçimi'),
                const SizedBox(height: 16),
                if (selectedBarberId == null)
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Text('Önce bir berber seçin', style: GoogleFonts.manrope(color: AppTheme.onSurfaceVariant)),
                    ),
                  )
                else if (_services.isEmpty)
                  const Center(child: CircularProgressIndicator(color: AppTheme.primary))
                else
                  ..._services.map((service) {
                    final isSelected = selectedServiceId == service.id;
                    return GestureDetector(
                      onTap: () => setState(() => selectedServiceId = service.id),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: isSelected ? AppTheme.primaryFixedDim.withOpacity(0.05) : AppTheme.surfaceContainerLowest,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isSelected ? AppTheme.primaryContainer : AppTheme.outlineVariant.withOpacity(0.2),
                            width: isSelected ? 2 : 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(service.name, style: GoogleFonts.manrope(fontWeight: FontWeight.w600, fontSize: 16)),
                                  const SizedBox(height: 4),
                                  Text('${service.duration} dk • ${service.description}', style: GoogleFonts.manrope(fontSize: 12, color: AppTheme.secondary)),
                                ],
                              ),
                            ),
                            Text('${service.price} TL', style: GoogleFonts.manrope(fontWeight: FontWeight.w700, color: AppTheme.primary, fontSize: 16)),
                          ],
                        ),
                      ),
                    );
                  }),
                const SizedBox(height: 24),
                _buildStepLabel('Adım 3', 'Tarih Seçin'),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: AppTheme.surfaceContainerLowest,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [BoxShadow(color: AppTheme.primary.withOpacity(0.05), blurRadius: 30)],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(_getMonthName(selectedDate.month), style: GoogleFonts.manrope(fontWeight: FontWeight.w600)),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () => setState(() => selectedDate = DateTime(selectedDate.year, selectedDate.month - 1)),
                                icon: const Icon(Icons.chevron_left),
                              ),
                              IconButton(
                                onPressed: () => setState(() => selectedDate = DateTime(selectedDate.year, selectedDate.month + 1)),
                                icon: const Icon(Icons.chevron_right),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: ['Pzt', 'Sal', 'Çar', 'Per', 'Cum', 'Cmt', 'Paz'].map((d) {
                          return Expanded(
                            child: Center(child: Text(d, style: GoogleFonts.manrope(fontSize: 12, fontWeight: FontWeight.w500, color: AppTheme.onSurfaceVariant))),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 8),
                      GridView.count(
                        crossAxisCount: 7,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: List.generate(35, (index) {
                          final day = index - 4;
                          if (day < 1 || day > 31) return const SizedBox();
                          final isToday = day == selectedDate.day && selectedDate.month == DateTime.now().month;
                          final isPast = day < DateTime.now().day && selectedDate.month == DateTime.now().month && selectedDate.year == DateTime.now().year;
                          return Center(
                            child: GestureDetector(
                              onTap: isPast ? null : () => setState(() => selectedDate = DateTime(selectedDate.year, selectedDate.month, day)),
                              child: Container(
                                width: 36,
                                height: 36,
                                decoration: BoxDecoration(
                                  color: isToday ? AppTheme.primary : null,
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: isToday ? [BoxShadow(color: AppTheme.primary.withOpacity(0.3), blurRadius: 8)] : null,
                                ),
                                child: Center(
                                  child: Text(
                                    '$day',
                                    style: GoogleFonts.manrope(
                                      fontWeight: FontWeight.w500,
                                      color: isPast ? AppTheme.onSurfaceVariant.withOpacity(0.3) : isToday ? Colors.white : AppTheme.onSurface,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                _buildStepLabel('Adım 4', 'Saat Seçin'),
                const SizedBox(height: 16),
                GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, mainAxisSpacing: 12, crossAxisSpacing: 12),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _generateTimeSlots().length,
                  itemBuilder: (context, index) {
                    final slot = _generateTimeSlots()[index];
                    final isSelected = selectedTime == slot['time'];
                    final available = slot['available'] as bool;
                    return GestureDetector(
                      onTap: available ? () => setState(() => selectedTime = slot['time'] as String) : null,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        decoration: BoxDecoration(
                          color: !available ? AppTheme.surfaceContainer : (isSelected ? AppTheme.primaryFixedDim.withOpacity(0.1) : null),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: isSelected ? AppTheme.primary : AppTheme.outlineVariant.withOpacity(0.2)),
                        ),
                        child: Center(
                          child: Text(
                            slot['time'] as String,
                            style: GoogleFonts.manrope(
                              fontWeight: FontWeight.w600,
                              color: !available ? AppTheme.onSurfaceVariant.withOpacity(0.3) : (isSelected ? AppTheme.primary : AppTheme.onSurface),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 24),
                _buildStepLabel('Adım 5', 'Not Ekle (Opsiyonel)'),
                const SizedBox(height: 16),
                TextField(
                  controller: noteController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText: 'Örn: Saç kesiminde yanlar biraz daha kısa olsun...',
                    hintStyle: GoogleFonts.manrope(color: AppTheme.onSurfaceVariant),
                    border: const UnderlineInputBorder(borderSide: BorderSide(color: AppTheme.outline)),
                    focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: AppTheme.primaryContainer, width: 2)),
                  ),
                ),
                const SizedBox(height: 100),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppTheme.surface.withOpacity(0.95),
                border: const Border(top: BorderSide(color: AppTheme.outlineVariant)),
              ),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _canBook()
                      ? () {
                          setState(() => showToast = true);
                          Future.delayed(const Duration(seconds: 3), () {
                            if (mounted) setState(() => showToast = false);
                          });
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryContainer,
                    foregroundColor: AppTheme.onPrimaryContainer,
                    disabledBackgroundColor: AppTheme.surfaceContainerHigh,
                    disabledForegroundColor: AppTheme.onSurfaceVariant,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.check_circle, size: 20),
                      const SizedBox(width: 8),
                      Text('Randevuyu Onayla', style: GoogleFonts.manrope(fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (showToast)
            Positioned(
              top: 80,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF31302E),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Text('Randevunuz başarıyla oluşturuldu!', style: GoogleFonts.manrope(color: Colors.white, fontWeight: FontWeight.w600)),
                ),
              ),
            ),
        ],
      ),
      bottomNavigationBar: const BottomNav(currentIndex: 1),
    );
  }

  bool _canBook() {
    return selectedBarberId != null && selectedServiceId != null && selectedTime != null;
  }

  List<Map<String, dynamic>> _generateTimeSlots() {
    final times = ['09:00', '09:30', '10:00', '10:30', '11:00', '11:30', '12:00', '13:00', '13:30', '14:00', '14:30', '15:00', '15:30', '16:00', '16:30', '17:00', '17:30', '18:00'];
    final now = DateTime.now();
    final isToday = selectedDate.day == now.day && selectedDate.month == now.month;
    return times.map((t) {
      if (!isToday) return {'time': t, 'available': true};
      final parts = t.split(':');
      final slotTime = DateTime(now.year, now.month, now.day, int.parse(parts[0]), int.parse(parts[1]));
      return {'time': t, 'available': slotTime.isAfter(now)};
    }).toList();
  }

  Widget _buildStepLabel(String step, String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(step.toUpperCase(), style: GoogleFonts.manrope(fontSize: 14, fontWeight: FontWeight.w600, color: AppTheme.primary, letterSpacing: 2)),
        const SizedBox(height: 8),
        Text(title, style: GoogleFonts.libreCaslonText(fontSize: 28, fontWeight: FontWeight.w600)),
      ],
    );
  }

  String _getMonthName(int month) {
    const months = ['', 'Ocak', 'Şubat', 'Mart', 'Nisan', 'Mayıs', 'Haziran', 'Temmuz', 'Ağustos', 'Eylül', 'Ekim', 'Kasım', 'Aralık'];
    return '${months[month]} ${selectedDate.year}';
  }
}

class _GoldThread extends StatelessWidget {
  const _GoldThread();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.transparent, AppTheme.primaryContainer, Colors.transparent],
        ),
      ),
    );
  }
}
