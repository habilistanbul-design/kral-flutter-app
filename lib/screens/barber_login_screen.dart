import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../services/auth_service.dart';
import 'barber_dashboard_screen.dart';

class BarberLoginScreen extends StatefulWidget {
  const BarberLoginScreen({super.key});

  @override
  State<BarberLoginScreen> createState() => _BarberLoginScreenState();
}

class _BarberLoginScreenState extends State<BarberLoginScreen> {
  final List<String> _pin = [];
  final int _pinLength = 4;
  String? _error;
  bool _loading = false;

  void _addDigit(String digit) {
    if (_pin.length < _pinLength) {
      setState(() {
        _pin.add(digit);
        _error = null;
      });
      if (_pin.length == _pinLength) {
        _verifyPin();
      }
    }
  }

  void _removeDigit() {
    if (_pin.isNotEmpty) {
      setState(() {
        _pin.removeLast();
        _error = null;
      });
    }
  }

  Future<void> _verifyPin() async {
    setState(() => _loading = true);
    final pin = _pin.join();
    final authService = AuthService();
    final error = await authService.loginWithPin(pin);
    setState(() => _loading = false);

    if (error == null && mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => BarberDashboardScreen(barber: authService.currentBarber!),
        ),
      );
    } else {
      setState(() {
        _error = error;
        _pin.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(color: const Color(0xFF1C1B1A)),
          Positioned.fill(
            child: Image.network(
              'https://images.unsplash.com/photo-1585747860019-024de42a4a5c?w=1200&q=80',
              fit: BoxFit.cover,
              color: Colors.black.withOpacity(0.6),
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xFF1C1B1A), Color(0xFF2C2518)],
                    ),
                  ),
                );
              },
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
                const SizedBox(height: 8),
                Text(
                  'Berber Girişi',
                  style: GoogleFonts.manrope(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
                const Spacer(),
                Text(
                  'PIN Kodunuzu Girin',
                  style: GoogleFonts.libreCaslonText(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(_pinLength, (index) {
                    final filled = index < _pin.length;
                    return Container(
                      width: 48,
                      height: 48,
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        color: filled
                            ? AppTheme.primaryFixedDim.withOpacity(0.15)
                            : Colors.white.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: _error != null
                              ? AppTheme.error
                              : filled
                                  ? AppTheme.primaryFixedDim
                                  : Colors.white24,
                          width: filled ? 2 : 1,
                        ),
                      ),
                      child: Center(
                        child: _loading
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: AppTheme.primaryFixedDim,
                                ),
                              )
                            : filled
                                ? Container(
                                    width: 12,
                                    height: 12,
                                    decoration: const BoxDecoration(
                                      color: AppTheme.primaryFixedDim,
                                      shape: BoxShape.circle,
                                    ),
                                  )
                                : null,
                      ),
                    );
                  }),
                ),
                if (_error != null) ...[
                  const SizedBox(height: 16),
                  Text(
                    _error!,
                    style: GoogleFonts.manrope(color: AppTheme.error, fontSize: 14),
                  ),
                ],
                const SizedBox(height: 48),
                _buildKeypad(),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKeypad() {
    return Column(
      children: [
        for (var row in [
          ['1', '2', '3'],
          ['4', '5', '6'],
          ['7', '8', '9'],
          ['', '0', '⌫'],
        ])
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: row.map((digit) {
              if (digit.isEmpty) return const SizedBox(width: 72);
              return Padding(
                padding: const EdgeInsets.all(6),
                child: GestureDetector(
                  onTap: digit == '⌫' ? _removeDigit : () => _addDigit(digit),
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: digit == '⌫'
                          ? Colors.red.withOpacity(0.15)
                          : Colors.white.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: digit == '⌫'
                            ? AppTheme.error.withOpacity(0.3)
                            : Colors.white12,
                      ),
                    ),
                    child: Center(
                      child: digit == '⌫'
                          ? const Icon(Icons.backspace_outlined, color: AppTheme.error, size: 22)
                          : Text(
                              digit,
                              style: GoogleFonts.manrope(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
      ],
    );
  }
}
