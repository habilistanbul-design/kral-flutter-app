import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../widgets/bottom_nav.dart';
import 'register_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.menu),
        title: Text('KRAL', style: GoogleFonts.libreCaslonText(fontSize: 32, fontWeight: FontWeight.w700, letterSpacing: 6, color: AppTheme.primary)),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            child: const CircleAvatar(radius: 18, backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=5')),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const CircleAvatar(radius: 60, backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=5')),
            const SizedBox(height: 16),
            Text('Ahmet Yılmaz', style: GoogleFonts.libreCaslonText(fontSize: 28, fontWeight: FontWeight.w600)),
            Text('Kral Deneyimi\'nde 12. randevu', style: GoogleFonts.manrope(color: AppTheme.onSurfaceVariant)),
            const SizedBox(height: 24),
            Container(height: 1, decoration: const BoxDecoration(gradient: LinearGradient(colors: [Colors.transparent, AppTheme.primaryContainer, Colors.transparent]))),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppTheme.surfaceContainerLowest,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppTheme.primary.withOpacity(0.2)),
                boxShadow: [BoxShadow(color: AppTheme.primary.withOpacity(0.05), blurRadius: 30)],
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(color: AppTheme.primaryFixed, borderRadius: BorderRadius.circular(8)),
                    child: const Icon(Icons.swap_horiz, color: AppTheme.primary),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Kuaför Değiştir', style: GoogleFonts.libreCaslonText(fontSize: 20, fontWeight: FontWeight.w600)),
                        Text('QR kodu tarayarak veya listeden seçerek', style: GoogleFonts.manrope(fontSize: 14, color: AppTheme.onSurfaceVariant)),
                      ],
                    ),
                  ),
                  const Icon(Icons.chevron_right, color: AppTheme.primary),
                ],
              ),
            ),
            const SizedBox(height: 24),
            _buildSection('Hesap Bilgileri', Icons.person_outline, [
              _buildInfoRow('İsim', 'Ahmet Yılmaz'),
              _buildInfoRow('Telefon', '+90 532 123 45 67'),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primary, foregroundColor: AppTheme.onPrimary, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28))),
                  child: Text('Profili Kaydet', style: GoogleFonts.manrope(fontWeight: FontWeight.w600, letterSpacing: 2)),
                ),
              ),
            ]),
            const SizedBox(height: 24),
            _buildSection('Randevu Geçmişi', Icons.calendar_month, [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(border: Border.all(color: AppTheme.outlineVariant), borderRadius: BorderRadius.circular(8)),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(color: AppTheme.primaryFixed, borderRadius: BorderRadius.circular(8)),
                      child: const Icon(Icons.content_cut, color: AppTheme.primary),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Kral Deneyimi', style: GoogleFonts.libreCaslonText(fontSize: 18, fontWeight: FontWeight.w600)),
                          Text('12 Eylül, 14:30 • Berber Ali', style: GoogleFonts.manrope(fontSize: 14, color: AppTheme.onSurfaceVariant)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ]),
            const SizedBox(height: 24),
            _buildSection('Destek', Icons.support_agent, [
              _buildButton('Yardım Merkezi', Icons.help_outline, () {}),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => const RegisterScreen()),
                      (route) => false,
                    );
                  },
                  icon: const Icon(Icons.logout, color: AppTheme.error),
                  label: Text('ÇIKIŞ YAP', style: GoogleFonts.manrope(color: AppTheme.error, fontWeight: FontWeight.w600, letterSpacing: 2)),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppTheme.error),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    padding: const EdgeInsets.all(16),
                  ),
                ),
              ),
            ]),
            const SizedBox(height: 100),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNav(currentIndex: 2),
    );
  }

  Widget _buildSection(String title, IconData icon, List<Widget> children) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: AppTheme.primary.withOpacity(0.05), blurRadius: 30)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: AppTheme.primary),
              const SizedBox(width: 12),
              Text(title, style: GoogleFonts.libreCaslonText(fontSize: 20, fontWeight: FontWeight.w600)),
            ],
          ),
          const SizedBox(height: 24),
          ...children,
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label.toUpperCase(), style: GoogleFonts.manrope(fontSize: 12, color: AppTheme.onSurfaceVariant, letterSpacing: 2)),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            decoration: BoxDecoration(
              color: AppTheme.surfaceContainer,
              borderRadius: BorderRadius.circular(28),
              border: Border.all(color: AppTheme.outlineVariant),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(value, style: GoogleFonts.manrope(fontSize: 16)),
                const Icon(Icons.edit, size: 18, color: AppTheme.outline),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String label, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(border: Border.all(color: AppTheme.outlineVariant), borderRadius: BorderRadius.circular(8)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: GoogleFonts.manrope(fontSize: 16)),
            Icon(icon, color: AppTheme.outline),
          ],
        ),
      ),
    );
  }
}
