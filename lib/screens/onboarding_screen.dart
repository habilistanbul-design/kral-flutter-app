import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import 'register_screen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
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
                const SizedBox(height: 40),
                Text(
                  'KRAL',
                  style: GoogleFonts.libreCaslonText(
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    letterSpacing: 12,
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      Container(
                        width: 60,
                        height: 1,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.transparent, AppTheme.primaryContainer, Colors.transparent],
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      Text(
                        'Krallara Layık\nTıraş Seni Bekliyor',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.libreCaslonText(
                          fontSize: 36,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 40),
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (_) => const RegisterScreen()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.error,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
                          ),
                          child: Text(
                            'KAYIT OL',
                            style: GoogleFonts.manrope(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 3,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 60),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildDot(true),
                    const SizedBox(width: 12),
                    _buildDot(false),
                    const SizedBox(width: 12),
                    _buildDot(false),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  'Aşağı Kaydır',
                  style: GoogleFonts.manrope(
                    fontSize: 12,
                    color: Colors.white54,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 8),
                const Icon(Icons.expand_more, color: AppTheme.primaryFixedDim, size: 28),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDot(bool active) {
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: active ? AppTheme.primary : Colors.white30,
        boxShadow: active ? [BoxShadow(color: AppTheme.primary.withOpacity(0.3), blurRadius: 8)] : null,
      ),
    );
  }
}
