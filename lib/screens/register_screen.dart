import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import 'home_screen.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage('https://images.unsplash.com/photo-1503951914875-452162b0f3f1?w=800'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black45, BlendMode.darken),
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back, color: AppTheme.primary),
                    ),
                    const Spacer(),
                    Text(
                      'KRAL',
                      style: GoogleFonts.libreCaslonText(
                        fontSize: 32,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        letterSpacing: 8,
                      ),
                    ),
                    const Spacer(),
                    const SizedBox(width: 48),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      const SizedBox(height: 16),
                      Text(
                        'Zanaatkar bir dokunuş için\nilk adımı atın.',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.manrope(
                          fontSize: 16,
                          color: Colors.white70,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 32),
                      Stack(
                        children: [
                          Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppTheme.surfaceContainerLow,
                              border: Border.all(color: AppTheme.outlineVariant),
                            ),
                            child: const Icon(Icons.photo_camera, size: 40, color: AppTheme.primary),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: const BoxDecoration(
                                color: AppTheme.primary,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.add, size: 16, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
                      _buildInput(hint: 'Ad Soyad', icon: Icons.person_outline),
                      const SizedBox(height: 24),
                      _buildInput(hint: 'Telefon Numarası', icon: Icons.phone_outlined),
                      const SizedBox(height: 24),
                      Container(
                        height: 1,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.transparent, AppTheme.primaryContainer, Colors.transparent],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Checkbox(
                            value: false,
                            onChanged: (_) {},
                            activeColor: AppTheme.primary,
                            side: const BorderSide(color: AppTheme.outlineVariant),
                          ),
                          Expanded(
                            child: Text(
                              'Kullanım koşulları ve KVKK metnini okudum, kabul ediyorum.',
                              style: GoogleFonts.manrope(
                                fontSize: 12,
                                color: Colors.white,
                                height: 1.4,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (_) => const HomeScreen()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.error,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'KAYIT OL',
                                style: GoogleFonts.manrope(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 3,
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Icon(Icons.arrow_forward, size: 18),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      TextButton(
                        onPressed: () {},
                        child: Text.rich(
                          TextSpan(
                            text: 'Zaten üye misiniz? ',
                            style: GoogleFonts.manrope(color: Colors.white),
                            children: [
                              TextSpan(
                                text: 'Giriş Yap',
                                style: GoogleFonts.manrope(
                                  color: AppTheme.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInput({required String hint, required IconData icon}) {
    return TextField(
      style: GoogleFonts.manrope(color: Colors.white, fontSize: 18),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.manrope(color: Colors.white38),
        prefixIcon: Icon(icon, color: AppTheme.primary),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppTheme.outlineVariant),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppTheme.primaryContainer, width: 2),
        ),
      ),
    );
  }
}
