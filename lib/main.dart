import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';
import 'screens/dashboard_page.dart';
import 'screens/guru_dashboard_page.dart';
import 'screens/mpk_dashboard_page.dart';
import 'screens/profile_page.dart';
import 'screens/settings_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'kr4bat_go',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1A237E)),
        useMaterial3: true,
      ),
      home: const WelcomeScreen(),
    );
  }
}

class MainNavigation extends StatefulWidget {
  final String role; 
  const MainNavigation({super.key, required this.role});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  Widget _getDashboard() {
    if (widget.role == 'Guru') {
      return const GuruDashboardPage();
    } else if (widget.role == 'MPK') {
      return const MpkDashboardPage();
    } else {
      return const DashboardPage(); 
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      _getDashboard(),
      ProfilPage(role: widget.role), 
      const PengaturanPage(),
    ];

    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        selectedItemColor: const Color(0xFF1A237E),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard_outlined), activeIcon: Icon(Icons.dashboard), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), activeIcon: Icon(Icons.person), label: 'Profil'),
          BottomNavigationBarItem(icon: Icon(Icons.settings_outlined), activeIcon: Icon(Icons.settings), label: 'Pengaturan'),
        ],
      ),
    );
  }
}