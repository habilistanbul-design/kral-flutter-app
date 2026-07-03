import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../screens/home_screen.dart';
import '../screens/appointments_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/booking_screen.dart';

class BottomNav extends StatelessWidget {
  final int currentIndex;
  const BottomNav({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLowest,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildItem(0, Icons.home, 'Ana Sayfa', context),
              _buildItem(1, Icons.calendar_month, 'Randevular', context),
              _buildItem(2, Icons.person, 'Profil', context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildItem(int index, IconData icon, String label, BuildContext context) {
    final isActive = currentIndex == index;
    return GestureDetector(
      onTap: () {
        if (index != currentIndex) {
          Widget screen;
          switch (index) {
            case 0: screen = const HomeScreen(); break;
            case 1: screen = const AppointmentsScreen(); break;
            case 2: screen = const ProfileScreen(); break;
            default: screen = const HomeScreen();
          }
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => screen));
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: isActive ? AppTheme.primary : AppTheme.onSurfaceVariant, size: 24),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              color: isActive ? AppTheme.primary : AppTheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
