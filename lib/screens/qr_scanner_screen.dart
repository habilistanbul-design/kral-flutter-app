import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class QRScannerScreen extends StatelessWidget {
  const QRScannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage('https://images.unsplash.com/photo-1585747860019-024de42a4a5c?w=800'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(Colors.black45, BlendMode.darken),
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
                      ),
                      Text(
                        'KRAL',
                        style: GoogleFonts.libreCaslonText(
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          letterSpacing: 8,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.flash_on, color: Colors.white, size: 28),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                // QR instruction
                Text(
                  'QR Kodunu Okutun',
                  style: GoogleFonts.libreCaslonText(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Kuaförünüzdeki QR kodunu hizalayın',
                  style: GoogleFonts.manrope(fontSize: 16, color: Colors.white70),
                ),
                const SizedBox(height: 40),
                // QR Frame
                SizedBox(
                  width: 280,
                  height: 280,
                  child: Stack(
                    children: [
                      // Corners
                      Positioned(top: 0, left: 0, child: _buildCorner(topLeft: true)),
                      Positioned(top: 0, right: 0, child: _buildCorner(topRight: true)),
                      Positioned(bottom: 0, left: 0, child: _buildCorner(bottomLeft: true)),
                      Positioned(bottom: 0, right: 0, child: _buildCorner(bottomRight: true)),
                      // Scan area
                      Positioned(
                        top: 16,
                        left: 16,
                        right: 16,
                        bottom: 16,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white24),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Stack(
                              children: [
                                Container(color: Colors.white.withOpacity(0.05)),
                                // Animated scan line
                                TweenAnimationBuilder<double>(
                                  tween: Tween(begin: 0, end: 1),
                                  duration: const Duration(seconds: 3),
                                  builder: (context, value, _) {
                                    return Positioned(
                                      top: value * 248,
                                      left: 0,
                                      right: 0,
                                      child: Container(
                                        height: 2,
                                        decoration: const BoxDecoration(
                                          gradient: LinearGradient(colors: [Colors.transparent, AppTheme.primaryFixedDim, Colors.transparent]),
                                        ),
                                      ),
                                    );
                                  },
                                  onEnd: () {},
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(100),
                // Buttons
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 48),
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.error,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.qr_code_2),
                              const SizedBox(width: 8),
                              Text('Kuaförüne Bağlan', style: GoogleFonts.manrope(fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(width: 40, height: 1, color: Colors.white24),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text('Veya', style: GoogleFonts.manrope(color: Colors.white54, fontSize: 12)),
                          ),
                          Container(width: 40, height: 1, color: Colors.white24),
                        ],
                      ),
                      const SizedBox(height: 24),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Kodu Manuel Girin',
                          style: GoogleFonts.manrope(
                            color: AppTheme.primaryFixedDim,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline,
                            decorationColor: AppTheme.primaryFixedDim.withOpacity(0.3),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('Kodsuz Devam Et', style: GoogleFonts.manrope(color: Colors.white54)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(40),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCorner({bool topLeft = false, bool topRight = false, bool bottomLeft = false, bool bottomRight = false}) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        border: Border(
          top: topLeft || topRight ? const BorderSide(color: AppTheme.primaryFixedDim, width: 4) : BorderSide.none,
          bottom: bottomLeft || bottomRight ? const BorderSide(color: AppTheme.primaryFixedDim, width: 4) : BorderSide.none,
          left: topLeft || bottomLeft ? const BorderSide(color: AppTheme.primaryFixedDim, width: 4) : BorderSide.none,
          right: topRight || bottomRight ? const BorderSide(color: AppTheme.primaryFixedDim, width: 4) : BorderSide.none,
        ),
        borderRadius: BorderRadius.only(
          topLeft: topLeft ? const Radius.circular(8) : Radius.zero,
          topRight: topRight ? const Radius.circular(8) : Radius.zero,
          bottomLeft: bottomLeft ? const Radius.circular(8) : Radius.zero,
          bottomRight: bottomRight ? const Radius.circular(8) : Radius.zero,
        ),
      ),
    );
  }
}
