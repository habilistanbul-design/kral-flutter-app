import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../data/mock_data.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  String? selectedBarber = 'b1';
  String? selectedService = 's1';
  String? selectedTime = '10:00';
  final noteController = TextEditingController();
  bool showToast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Randevu Al', style: GoogleFonts.libreCaslonText(fontSize: 24, fontWeight: FontWeight.w600)),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Step 1: Barber
                _buildStepLabel('Adım 1', 'Berberinizi Seçin'),
                const SizedBox(height: 16),
                SizedBox(
                  height: 180,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: barbers.length,
                    itemBuilder: (context, index) {
                      final barber = barbers[index];
                      final isSelected = selectedBarber == barber.id;
                      return GestureDetector(
                        onTap: () => setState(() => selectedBarber = barber.id),
                        child: Container(
                          width: 150,
                          margin: const EdgeInsets.only(right: 16),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: isSelected ? AppTheme.primary.withOpacity(0.05) : AppTheme.surfaceContainerLowest,
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
                              Text(barber.title, style: GoogleFonts.manrope(fontSize: 11, color: AppTheme.secondary)),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 24),
                // Gold thread
                Container(height: 1, decoration: const BoxDecoration(gradient: LinearGradient(colors: [Colors.transparent, AppTheme.primaryContainer, Colors.transparent]))),
                const SizedBox(height: 24),
                // Step 2: Service
                _buildStepLabel('Adım 2', 'Hizmet Seçimi'),
                const SizedBox(height: 16),
                ...services.map((service) {
                  final isSelected = selectedService == service.id;
                  return GestureDetector(
                    onTap: () => setState(() => selectedService = service.id),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: isSelected ? AppTheme.primary.withOpacity(0.05) : AppTheme.surfaceContainerLowest,
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
                                Text('${service.duration} • ${service.description}', style: GoogleFonts.manrope(fontSize: 12, color: AppTheme.secondary)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
                const SizedBox(height: 24),
                // Step 3: Date
                _buildStepLabel('Adım 3', 'Tarih Seçin'),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: AppTheme.surfaceContainerLowest,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppTheme.outlineVariant.withOpacity(0.2)),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Ekim 2023', style: GoogleFonts.manrope(fontWeight: FontWeight.w600)),
                          Row(
                            children: [
                              IconButton(onPressed: () {}, icon: const Icon(Icons.chevron_left)),
                              IconButton(onPressed: () {}, icon: const Icon(Icons.chevron_right)),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      GridView.count(
                        crossAxisCount: 7,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: List.generate(35, (index) {
                          final day = index - 4;
                          if (day < 1 || day > 31) return const SizedBox();
                          final isSelected = day == 4;
                          return Center(
                            child: GestureDetector(
                              onTap: () {},
                              child: Container(
                                width: 36,
                                height: 36,
                                decoration: BoxDecoration(
                                  color: isSelected ? AppTheme.primary : null,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: Text(
                                    '$day',
                                    style: GoogleFonts.manrope(
                                      fontWeight: FontWeight.w500,
                                      color: isSelected ? Colors.white : AppTheme.onSurface,
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
                // Step 4: Time
                _buildStepLabel('Adım 4', 'Saat Seçin'),
                const SizedBox(height: 16),
                GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, mainAxisSpacing: 12, crossAxisSpacing: 12),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: generateTimeSlots().length,
                  itemBuilder: (context, index) {
                    final slot = generateTimeSlots()[index];
                    final isSelected = selectedTime == slot.time;
                    return GestureDetector(
                      onTap: slot.available ? () => setState(() => selectedTime = slot.time) : null,
                      child: Container(
                        decoration: BoxDecoration(
                          color: !slot.available ? AppTheme.surfaceContainer : (isSelected ? AppTheme.primary.withOpacity(0.1) : null),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: isSelected ? AppTheme.primary : AppTheme.outlineVariant.withOpacity(0.2),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            slot.time,
                            style: GoogleFonts.manrope(
                              fontWeight: FontWeight.w600,
                              color: !slot.available ? AppTheme.onSurfaceVariant.withOpacity(0.3) : (isSelected ? AppTheme.primary : AppTheme.onSurface),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 24),
                // Step 5: Note
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
          // Bottom button
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
                  onPressed: () {
                    setState(() => showToast = true);
                    Future.delayed(const Duration(seconds: 3), () => setState(() => showToast = false));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryContainer,
                    foregroundColor: AppTheme.onPrimaryContainer,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Randevuyu Onayla', style: GoogleFonts.manrope(fontWeight: FontWeight.w600)),
                      const SizedBox(width: 8),
                      const Icon(Icons.check_circle, size: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // Toast
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
    );
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
}
