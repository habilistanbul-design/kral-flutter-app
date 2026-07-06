import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../theme/app_theme.dart';
import '../services/firestore_service.dart';
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
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.menu),
        title: Text('KRAL', style: GoogleFonts.libreCaslonText(fontSize: 32, fontWeight: FontWeight.w700, letterSpacing: 6, color: AppTheme.primary)),
        actions: [
          CircleAvatar(
            radius: 14,
            backgroundImage: user?.photoURL != null
                ? NetworkImage(user!.photoURL!)
                : null,
            child: user?.photoURL == null
                ? Text(
                    (user?.displayName ?? 'M')[0].toUpperCase(),
                    style: GoogleFonts.manrope(fontSize: 12, color: Colors.white),
                  )
                : null,
          ),
        ],
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
            Container(
              decoration: BoxDecoration(
                color: AppTheme.surfaceContainerHigh,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => showActive = true),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: showActive ? AppTheme.surfaceContainerLowest : Colors.transparent,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: showActive ? [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)] : null,
                        ),
                        child: Text('Aktif Randevular', textAlign: TextAlign.center, style: GoogleFonts.manrope(fontWeight: FontWeight.w600, color: showActive ? AppTheme.primary : AppTheme.onSurfaceVariant)),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => showActive = false),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: !showActive ? AppTheme.surfaceContainerLowest : Colors.transparent,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: !showActive ? [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)] : null,
                        ),
                        child: Text('Geçmiş Randevular', textAlign: TextAlign.center, style: GoogleFonts.manrope(fontWeight: FontWeight.w600, color: !showActive ? AppTheme.primary : AppTheme.onSurfaceVariant)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: showActive ? _buildActiveAppointments() : _buildPastAppointments(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNav(currentIndex: 1),
    );
  }

  Widget _buildActiveAppointments() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.event_available, size: 48, color: AppTheme.outlineVariant),
            const SizedBox(height: 16),
            Text('Yaklaşan randevunuz yok', style: GoogleFonts.manrope(color: AppTheme.onSurfaceVariant)),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () => Navigator.pushReplacementNamed(context, '/'),
              child: Text('Randevu Al', style: GoogleFonts.manrope(color: AppTheme.primary, fontWeight: FontWeight.w600)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPastAppointments() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.history, size: 48, color: AppTheme.outlineVariant),
            const SizedBox(height: 16),
            Text('Geçmiş randevu bulunmuyor', style: GoogleFonts.manrope(color: AppTheme.onSurfaceVariant)),
          ],
        ),
      ),
    );
  }
}
