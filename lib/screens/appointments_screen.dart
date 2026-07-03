import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../widgets/bottom_nav.dart';

class AppointmentsScreen extends StatefulWidget {
  const AppointmentsScreen({super.key});

  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
  bool showActive = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.menu),
        title: Text('KRAL', style: GoogleFonts.libreCaslonText(fontSize: 32, fontWeight: FontWeight.w700, letterSpacing: 6, color: AppTheme.primary)),
        actions: const [CircleAvatar(radius: 14, backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=5'))],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Randevularım', style: GoogleFonts.libreCaslonText(fontSize: 28, fontWeight: FontWeight.w600, color: AppTheme.primary)),
            const SizedBox(height: 4),
            Container(width: 80, height: 1, color: AppTheme.primaryContainer),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => showActive = true),
                    child: Container(
                      padding: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(color: showActive ? AppTheme.primaryContainer : Colors.transparent, width: 2)),
                      ),
                      child: Text(
                        'Aktif Randevular',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.manrope(
                          fontWeight: FontWeight.w600,
                          color: showActive ? AppTheme.primary : AppTheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => showActive = false),
                    child: Container(
                      padding: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(color: !showActive ? AppTheme.primaryContainer : Colors.transparent, width: 2)),
                      ),
                      child: Text(
                        'Geçmiş Randevular',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.manrope(
                          fontWeight: FontWeight.w600,
                          color: !showActive ? AppTheme.primary : AppTheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Expanded(
              child: showActive ? _buildActiveAppointment() : _buildPastAppointments(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNav(currentIndex: 1),
    );
  }

  Widget _buildActiveAppointment() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppTheme.outlineVariant.withOpacity(0.2)),
        boxShadow: [BoxShadow(color: AppTheme.primary.withOpacity(0.05), blurRadius: 30)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: AppTheme.primary.withOpacity(0.05),
                borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(12)),
              ),
              child: Text('GELECEK', style: GoogleFonts.manrope(fontSize: 11, fontWeight: FontWeight.w600, color: AppTheme.primary, letterSpacing: 2)),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const CircleAvatar(radius: 28, backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=1')),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Ahmet Yılmaz', style: GoogleFonts.libreCaslonText(fontSize: 20, fontWeight: FontWeight.w600)),
                  Text('Saç Kesimi & Stil', style: GoogleFonts.manrope(color: AppTheme.onSurfaceVariant)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              const Icon(Icons.calendar_today, size: 16, color: AppTheme.primaryContainer),
              const SizedBox(width: 8),
              Text('20 Mayıs 2024', style: GoogleFonts.manrope(fontWeight: FontWeight.w600)),
              const SizedBox(width: 24),
              const Icon(Icons.schedule, size: 16, color: AppTheme.primaryContainer),
              const SizedBox(width: 8),
              Text('14:30', style: GoogleFonts.manrope(fontWeight: FontWeight.w600)),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: AppTheme.primaryContainer.withOpacity(0.05),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.timer, size: 16, color: AppTheme.primary),
                const SizedBox(width: 8),
                Text('1 Gün 5 Saat Kaldı', style: GoogleFonts.manrope(fontWeight: FontWeight.w600, color: AppTheme.primary)),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(side: const BorderSide(color: AppTheme.onSurface)),
                  child: Text('İPTAL ET', style: GoogleFonts.manrope(color: AppTheme.onSurface, letterSpacing: 2)),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryContainer, foregroundColor: AppTheme.onPrimaryContainer),
                  child: Text('ERTELE', style: GoogleFonts.manrope(letterSpacing: 2)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPastAppointments() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppTheme.outlineVariant.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          const CircleAvatar(radius: 24, backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=3')),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Mehmet Demir', style: GoogleFonts.manrope(fontWeight: FontWeight.w600)),
                Text('Sakal Tıraşı & Bakım', style: GoogleFonts.manrope(fontSize: 12, color: AppTheme.onSurfaceVariant)),
              ],
            ),
          ),
          Text('12 Mayıs', style: GoogleFonts.manrope(fontSize: 12, color: AppTheme.onSurfaceVariant)),
        ],
      ),
    );
  }
}
