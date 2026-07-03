import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../data/mock_data.dart';
import '../widgets/bottom_nav.dart';
import 'booking_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: AppTheme.background,
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
              Container(
                margin: const EdgeInsets.only(right: 16),
                child: const CircleAvatar(
                  radius: 16,
                  backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=5'),
                ),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 350,
              child: Stack(
                children: [
                  Container(
                    height: 300,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage('https://images.unsplash.com/photo-1585747860019-024de42a4a5c?w=800'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 24,
                    right: 24,
                    child: Row(
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 20)],
                          ),
                          padding: const EdgeInsets.all(8),
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppTheme.primaryContainer,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('KRAL', style: GoogleFonts.libreCaslonText(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white)),
                                Text('BARBERSHOP', style: GoogleFonts.manrope(fontSize: 8, fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 2)),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('Kral Barbershop', style: GoogleFonts.libreCaslonText(fontSize: 24, fontWeight: FontWeight.w600)),
                            Row(
                              children: [
                                const Icon(Icons.location_on, size: 14, color: AppTheme.onSurfaceVariant),
                                Text(' Nişantaşı, İstanbul', style: GoogleFonts.manrope(color: AppTheme.onSurfaceVariant)),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppTheme.surfaceContainerLow,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppTheme.outlineVariant),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppTheme.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text('Özel Teklif', style: GoogleFonts.manrope(fontSize: 12, fontWeight: FontWeight.w600, color: AppTheme.primary, letterSpacing: 1)),
                          ),
                          const SizedBox(height: 12),
                          Text('%20 İndirimli\nİlk Tıraş', style: GoogleFonts.libreCaslonText(fontSize: 24, fontWeight: FontWeight.w600, color: AppTheme.primary)),
                          const SizedBox(height: 8),
                          Text('Premium hizmetimizle tanışmanız için\nilk randevunuza özel indirim.', style: GoogleFonts.manrope(fontSize: 14, color: AppTheme.onSurfaceVariant)),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(backgroundColor: AppTheme.error, foregroundColor: Colors.white),
                      child: Text('Hemen Kullan', style: GoogleFonts.manrope(fontWeight: FontWeight.w600)),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppTheme.surfaceContainerHigh,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppTheme.outlineVariant),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.event_upcoming, size: 16, color: AppTheme.primary),
                        const SizedBox(width: 8),
                        Text('YAKLAŞAN RANDEVUNUZ', style: GoogleFonts.manrope(fontSize: 14, fontWeight: FontWeight.w600, letterSpacing: 2)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        CircleAvatar(radius: 24, backgroundImage: NetworkImage(barbers[0].avatarUrl)),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(barbers[0].name, style: GoogleFonts.libreCaslonText(fontSize: 20, fontWeight: FontWeight.w600)),
                            Text('Saç Kesimi & Stil', style: GoogleFonts.manrope(fontSize: 12, color: AppTheme.onSurfaceVariant)),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Icon(Icons.schedule, size: 14, color: AppTheme.onSurfaceVariant),
                        Text(' Yarın, 14:30', style: GoogleFonts.manrope(fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: AppTheme.primary.withOpacity(0.1),
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
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(side: const BorderSide(color: AppTheme.onSurface)),
                            child: Text('İptal Et', style: GoogleFonts.manrope(color: AppTheme.onSurface)),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryContainer, foregroundColor: AppTheme.onPrimaryContainer),
                            child: Text('Ertele', style: GoogleFonts.manrope()),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(child: Padding(padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24), child: Divider(color: AppTheme.outlineVariant))),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 48,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 24),
                children: [
                  _buildChip('Tümü', true),
                  _buildChip('Saç Kesimi', false),
                  _buildChip('Sakal Tasarımı', false),
                  _buildChip('Cilt Bakımı', false),
                  _buildChip('Kral Paketi', false),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Usta Eller', style: GoogleFonts.libreCaslonText(fontSize: 28, fontWeight: FontWeight.w600)),
                      Text('Kral\'ın yetenekli ekibiyle tanışın.', style: GoogleFonts.manrope(color: AppTheme.onSurfaceVariant)),
                    ],
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text('Tümünü Gör', style: GoogleFonts.manrope(color: AppTheme.primary, fontWeight: FontWeight.w600)),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final barber = barbers[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [BoxShadow(color: AppTheme.primary.withOpacity(0.05), blurRadius: 30)],
                    ),
                    child: Row(
                      children: [
                        Stack(
                          children: [
                            CircleAvatar(radius: 40, backgroundImage: NetworkImage(barber.avatarUrl)),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                padding: const EdgeInsets.all(2),
                                decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: const BoxDecoration(color: AppTheme.primary, shape: BoxShape.circle),
                                  child: const Icon(Icons.star, size: 10, color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(barber.name, style: GoogleFonts.libreCaslonText(fontSize: 20, fontWeight: FontWeight.w600)),
                              const SizedBox(height: 4),
                              Text(barber.title.toUpperCase(), style: GoogleFonts.manrope(fontSize: 12, color: AppTheme.onSurfaceVariant, letterSpacing: 2)),
                              const SizedBox(height: 12),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (_) => const BookingScreen()));
                                  },
                                  style: ElevatedButton.styleFrom(backgroundColor: AppTheme.error, foregroundColor: Colors.white),
                                  child: Text('Randevu Al', style: GoogleFonts.manrope(fontWeight: FontWeight.w600)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              childCount: barbers.length,
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
      bottomNavigationBar: const BottomNav(currentIndex: 0),
    );
  }

  Widget _buildChip(String label, bool selected) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: selected ? AppTheme.primary : AppTheme.surfaceContainerHigh,
          foregroundColor: selected ? AppTheme.onPrimary : AppTheme.onSurfaceVariant,
          side: selected ? null : const BorderSide(color: AppTheme.outlineVariant),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
        child: Text(label, style: GoogleFonts.manrope(fontWeight: FontWeight.w600)),
      ),
    );
  }
}
