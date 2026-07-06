import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../services/firestore_service.dart';
import '../services/auth_service.dart';
import 'barber_login_screen.dart';

class BarberDashboardScreen extends StatefulWidget {
  final Barber barber;
  const BarberDashboardScreen({super.key, required this.barber});

  @override
  State<BarberDashboardScreen> createState() => _BarberDashboardScreenState();
}

class _BarberDashboardScreenState extends State<BarberDashboardScreen> {
  final FirestoreService _firestore = FirestoreService();
  bool showActive = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surface,
      appBar: AppBar(
        backgroundColor: AppTheme.surface,
        foregroundColor: AppTheme.primary,
        title: Text(
          'KRAL',
          style: GoogleFonts.libreCaslonText(
            fontSize: 28,
            fontWeight: FontWeight.w600,
            letterSpacing: 6,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              AuthService().logout();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const BarberLoginScreen()),
              );
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProfileHeader(),
            const SizedBox(height: 24),
            const _GoldThread(),
            const SizedBox(height: 24),
            _buildStatusCard(),
            const SizedBox(height: 24),
            const _GoldThread(),
            const SizedBox(height: 24),
            _buildTabBar(),
            const SizedBox(height: 16),
            showActive ? _buildUpcomingAppointments() : _buildPastAppointments(),
            const SizedBox(height: 24),
            const _GoldThread(),
            const SizedBox(height: 24),
            _buildMyServices(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Row(
      children: [
        Stack(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(widget.barber.avatarUrl),
              backgroundColor: AppTheme.surfaceContainerLow,
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Container(
                  width: 14,
                  height: 14,
                  decoration: const BoxDecoration(
                    color: AppTheme.primary,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.star, size: 8, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.barber.name,
              style: GoogleFonts.libreCaslonText(fontSize: 24, fontWeight: FontWeight.w600),
            ),
            Text(
              widget.barber.expertise.toUpperCase(),
              style: GoogleFonts.manrope(
                fontSize: 12,
                color: AppTheme.onSurfaceVariant,
                letterSpacing: 2,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatusCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: AppTheme.primary.withOpacity(0.05), blurRadius: 30)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'DURUMUM',
            style: GoogleFonts.manrope(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppTheme.onSurfaceVariant,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            widget.barber.status.isNotEmpty ? widget.barber.status : 'Müsait',
            style: GoogleFonts.libreCaslonText(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          if (widget.barber.leaveDays.isNotEmpty) ...[
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.event_busy, size: 16, color: AppTheme.error),
                const SizedBox(width: 8),
                Text(
                  'İzin Günleri: ${widget.barber.leaveDays}',
                  style: GoogleFonts.manrope(fontSize: 12, color: AppTheme.onSurfaceVariant),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
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
                  boxShadow: showActive
                      ? [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)]
                      : null,
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
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: !showActive ? AppTheme.surfaceContainerLowest : Colors.transparent,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: !showActive
                      ? [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)]
                      : null,
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
    );
  }

  Widget _buildUpcomingAppointments() {
    return StreamBuilder<List<Appointment>>(
      stream: _firestore.getBarberUpcomingAppointments(widget.barber.id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator(color: AppTheme.primary));
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(40),
              child: Column(
                children: [
                  Icon(Icons.event_available, size: 48, color: AppTheme.outlineVariant),
                  const SizedBox(height: 16),
                  Text('Yaklaşan randevu yok', style: GoogleFonts.manrope(color: AppTheme.onSurfaceVariant)),
                ],
              ),
            ),
          );
        }
        final appointments = snapshot.data!;
        return Column(
          children: appointments.map((apt) => _buildAppointmentCard(apt)).toList(),
        );
      },
    );
  }

  Widget _buildPastAppointments() {
    return StreamBuilder<List<Appointment>>(
      stream: _firestore.getBarberAppointments(widget.barber.id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator(color: AppTheme.primary));
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(40),
              child: Column(
                children: [
                  Icon(Icons.history, size: 48, color: AppTheme.outlineVariant),
                  const SizedBox(height: 16),
                  Text('Geçmiş randevu yok', style: GoogleFonts.manrope(color: AppTheme.onSurfaceVariant)),
                ],
              ),
            ),
          );
        }
        final appointments = snapshot.data!;
        return Column(
          children: appointments.map((apt) => _buildAppointmentCard(apt, isPast: true)).toList(),
        );
      },
    );
  }

  Widget _buildAppointmentCard(Appointment apt, {bool isPast = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: AppTheme.primary.withOpacity(0.05), blurRadius: 30)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                apt.customerName,
                style: GoogleFonts.libreCaslonText(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: apt.status == 'upcoming'
                      ? AppTheme.primaryFixedDim.withOpacity(0.1)
                      : apt.status == 'completed'
                          ? Colors.green.withOpacity(0.1)
                          : AppTheme.error.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  apt.status == 'upcoming'
                      ? 'GELECEK'
                      : apt.status == 'completed'
                          ? 'TAMAMLANDI'
                          : 'İPTAL',
                  style: GoogleFonts.manrope(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: apt.status == 'upcoming'
                        ? AppTheme.primary
                        : apt.status == 'completed'
                            ? Colors.green
                            : AppTheme.error,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            apt.serviceName,
            style: GoogleFonts.manrope(color: AppTheme.onSurfaceVariant),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.calendar_today, size: 14, color: AppTheme.primaryContainer),
              const SizedBox(width: 6),
              Text(apt.date, style: GoogleFonts.manrope(fontWeight: FontWeight.w600, fontSize: 13)),
              const SizedBox(width: 16),
              const Icon(Icons.schedule, size: 14, color: AppTheme.primaryContainer),
              const SizedBox(width: 6),
              Text(apt.time, style: GoogleFonts.manrope(fontWeight: FontWeight.w600, fontSize: 13)),
            ],
          ),
          if (apt.note.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              'Not: ${apt.note}',
              style: GoogleFonts.manrope(fontSize: 12, color: AppTheme.onSurfaceVariant),
            ),
          ],
          if (!isPast && apt.status == 'upcoming') ...[
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => _updateStatus(apt.id, 'cancelled'),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppTheme.error),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: Text('İPTAL ET', style: GoogleFonts.manrope(color: AppTheme.error, fontSize: 12, letterSpacing: 1)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _updateStatus(apt.id, 'completed'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryContainer,
                      foregroundColor: AppTheme.onPrimaryContainer,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: Text('TAMAMLA', style: GoogleFonts.manrope(fontSize: 12, letterSpacing: 1)),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Future<void> _updateStatus(String appointmentId, String status) async {
    await _firestore.updateAppointmentStatus(widget.barber.id, appointmentId, status);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(status == 'completed' ? 'Randevu tamamlandı' : 'Randevu iptal edildi'),
          backgroundColor: status == 'completed' ? Colors.green : AppTheme.error,
        ),
      );
    }
  }

  Widget _buildMyServices() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'HİZMETLERİM',
          style: GoogleFonts.manrope(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: AppTheme.onSurfaceVariant,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 8),
        StreamBuilder<List<Service>>(
          stream: _firestore.getBarberServices(widget.barber.id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator(color: AppTheme.primary));
            }
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppTheme.surfaceContainerLowest,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Henüz hizmet eklenmemiş',
                  style: GoogleFonts.manrope(color: AppTheme.onSurfaceVariant),
                  textAlign: TextAlign.center,
                ),
              );
            }
            final services = snapshot.data!;
            return Column(
              children: services.map((service) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppTheme.surfaceContainerLowest,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              service.name,
                              style: GoogleFonts.manrope(fontWeight: FontWeight.w600),
                            ),
                            Text(
                              '${service.duration} dk',
                              style: GoogleFonts.manrope(fontSize: 12, color: AppTheme.onSurfaceVariant),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        '${service.price} TL',
                        style: GoogleFonts.manrope(
                          fontWeight: FontWeight.w700,
                          color: AppTheme.primary,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            );
          },
        ),
      ],
    );
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
