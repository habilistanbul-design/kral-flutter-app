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
      floatingActionButton: Container(
        width: 56,
        height: 56,
        decoration: const BoxDecoration(
          color: AppTheme.primary,
          shape: BoxShape.circle,
        ),
        child: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.add, color: Colors.white, size: 28),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
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
              height: 380,
              child: Stack(
                children: [
                  SizedBox(
                    height: 320,
                    width: double.infinity,
                    child: const ColoredBox(color: Color(0xFF1C1B1A)),
                  ),
                  Positioned.fill(
                    child: Image.network(
                      'https://images.unsplash.com/photo-1585747860019-024de42a4a5c?w=1200&q=80',
                      fit: BoxFit.cover,
                      height: 320,
                      errorBuilder: (context, error, stackTrace) {
                        return const SizedBox();
                      },
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 80,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            AppTheme.surface,
                          ],
                        ),
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
                          width: 110,
                          height: 110,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: AppTheme.primary.withOpacity(0.08),
                                blurRadius: 30,
                              ),
                            ],
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
                                Text('KRAL', style: GoogleFonts.libreCaslonText(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white)),
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
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.primary.withOpacity(0.05),
                      blurRadius: 30,
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: -20,
                      right: -20,
                      child: Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppTheme.primaryFixedDim.withOpacity(0.1),
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppTheme.primaryFixedDim.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text('ÖZEL TEKLİF', style: GoogleFonts.manrope(fontSize: 12, fontWeight: FontWeight.w600, color: AppTheme.primary, letterSpacing: 1)),
                        ),
                        const SizedBox(height: 12),
                        Text('%20 İndirimli\nİlk Tıraş', style: GoogleFonts.libreCaslonText(fontSize: 24, fontWeight: FontWeight.w600, color: AppTheme.primary)),
                        const SizedBox(height: 8),
                        Text('Premium hizmetimizle tanışmanız için\nilk randevunuza özel indirim.', style: GoogleFonts.manrope(fontSize: 14, color: AppTheme.onSurfaceVariant)),
                        const SizedBox(height: 16),
                        SizedBox(
                          height: 40,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.error,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            ),
                            child: Text('Hemen Kullan', style: GoogleFonts.manrope(fontWeight: FontWeight.w600)),
                          ),
                        ),
                      ],
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
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.event, size: 16, color: AppTheme.primary),
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
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryFixedDim.withOpacity(0.08),
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
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: AppTheme.onSurface),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                            child: Text('İPTAL ET', style: GoogleFonts.manrope(color: AppTheme.onSurface, letterSpacing: 2)),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.primaryContainer,
                              foregroundColor: AppTheme.onPrimaryContainer,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                            child: Text('ERTELE', style: GoogleFonts.manrope(letterSpacing: 2)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(child: _GoldThread()),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 48,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 24),
                children: [
                  _buildChip('TÜMÜ', true),
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
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 0.75,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final barber = barbers[index];
                  return Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.primary.withOpacity(0.05),
                          blurRadius: 30,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            CircleAvatar(
                              radius: 28,
                              backgroundImage: NetworkImage(barber.avatarUrl),
                              backgroundColor: AppTheme.surfaceContainerLow,
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                padding: const EdgeInsets.all(2),
                                decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                                child: Container(
                                  padding: const EdgeInsets.all(3),
                                  decoration: const BoxDecoration(color: AppTheme.primary, shape: BoxShape.circle),
                                  child: const Icon(Icons.star, size: 8, color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          barber.name,
                          style: GoogleFonts.libreCaslonText(fontSize: 14, fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          barber.title.toUpperCase(),
                          style: GoogleFonts.manrope(fontSize: 9, color: AppTheme.onSurfaceVariant, letterSpacing: 1),
                          textAlign: TextAlign.center,
                        ),
                        const Spacer(),
                        SizedBox(
                          width: double.infinity,
                          height: 32,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (_) => const BookingScreen()));
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.error,
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                            ),
                            child: Text('Randevu Al', style: GoogleFonts.manrope(fontWeight: FontWeight.w600, fontSize: 11)),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                childCount: barbers.length,
              ),
            ),
          ),
          const SliverToBoxAdapter(child: _GoldThread()),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
              child: Column(
                children: [
                  Text('Sanatımız', style: GoogleFonts.manrope(fontSize: 12, color: AppTheme.onSurfaceVariant, letterSpacing: 1)),
                  const SizedBox(height: 4),
                  Text('Portfolyo', style: GoogleFonts.libreCaslonText(fontSize: 28, fontWeight: FontWeight.w600)),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 1.2,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final titles = ['Klasik Kesim', 'Sakal Şekillendirme', 'Premium Paket', 'Cilt Bakımı'];
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.network(
                          'https://i.pravatar.cc/400?img=${10 + index * 3}',
                          fit: BoxFit.cover,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black.withOpacity(0.6),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 12,
                          left: 12,
                          child: Text(
                            titles[index],
                            style: GoogleFonts.manrope(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                childCount: 4,
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
      bottomNavigationBar: const BottomNav(currentIndex: 0),
    );
  }

  static Widget _buildChip(String label, bool selected) {
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

class _GoldThread extends StatelessWidget {
  const _GoldThread();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: Container(
        height: 1,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.transparent, AppTheme.primaryContainer, Colors.transparent],
          ),
        ),
      ),
    );
  }
}
