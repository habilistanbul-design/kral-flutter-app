import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../services/firestore_service.dart';
import '../widgets/bottom_nav.dart';
import 'booking_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final firestore = FirestoreService();

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
                          colors: [Colors.transparent, AppTheme.surface],
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
                            boxShadow: [BoxShadow(color: AppTheme.primary.withOpacity(0.08), blurRadius: 30)],
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
                        StreamBuilder<SalonProfile?>(
                          stream: firestore.getSalonProfile(),
                          builder: (context, snapshot) {
                            final salon = snapshot.data;
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  salon?.name ?? 'Kral Barbershop',
                                  style: GoogleFonts.libreCaslonText(fontSize: 24, fontWeight: FontWeight.w600),
                                ),
                                Row(
                                  children: [
                                    const Icon(Icons.location_on, size: 14, color: AppTheme.onSurfaceVariant),
                                    Text(
                                      salon?.address ?? 'Nişantaşı, İstanbul',
                                      style: GoogleFonts.manrope(color: AppTheme.onSurfaceVariant),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          },
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
                  boxShadow: [BoxShadow(color: AppTheme.primary.withOpacity(0.05), blurRadius: 30)],
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
          const SliverToBoxAdapter(child: _GoldThread()),
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
          StreamBuilder<List<Barber>>(
            stream: firestore.getBarbers(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SliverToBoxAdapter(
                  child: Center(child: Padding(
                    padding: EdgeInsets.all(40),
                    child: CircularProgressIndicator(color: AppTheme.primary),
                  )),
                );
              }
              final barbers = snapshot.data ?? [];
              if (barbers.isEmpty) {
                return const SliverToBoxAdapter(
                  child: Center(child: Padding(
                    padding: EdgeInsets.all(40),
                    child: Text('Henüz berber bulunmuyor'),
                  )),
                );
              }
              return SliverPadding(
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
                          boxShadow: [BoxShadow(color: AppTheme.primary.withOpacity(0.05), blurRadius: 30)],
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
                            Text(barber.name, style: GoogleFonts.libreCaslonText(fontSize: 14, fontWeight: FontWeight.w600), textAlign: TextAlign.center, maxLines: 1, overflow: TextOverflow.ellipsis),
                            Text(barber.expertise.toUpperCase(), style: GoogleFonts.manrope(fontSize: 9, color: AppTheme.onSurfaceVariant, letterSpacing: 1), textAlign: TextAlign.center, maxLines: 1, overflow: TextOverflow.ellipsis),
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
              );
            },
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
                        Image.network('https://i.pravatar.cc/400?img=${10 + index * 3}', fit: BoxFit.cover),
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Colors.transparent, Colors.black.withOpacity(0.6)],
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 12,
                          left: 12,
                          child: Text(titles[index], style: GoogleFonts.manrope(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white)),
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
          gradient: LinearGradient(colors: [Colors.transparent, AppTheme.primaryContainer, Colors.transparent]),
        ),
      ),
    );
  }
}
