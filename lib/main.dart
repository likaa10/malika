import 'package:flutter/material.dart';
// IMPORT UNTUK FORMAT BAHASA INDONESIA (AGAR KALENDER & TANGGAL TIDAK EROR)
import 'package:flutter_localizations/flutter_localizations.dart'; 

import 'screens/welcome_screen.dart'; 
import 'screens/login_screen.dart';
import 'screens/dashboard_page.dart';
import 'detail_keterlambatan_export.dart'; // Import file export data
import 'pages/rekap/loading_rekap.dart';
import 'pages/rekap/rekap_keterlambatan_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KR4BAT GO',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        useMaterial3: true,
      ),
      
      // KONFIGURASI BAHASA INDONESIA UNTUK KALENDER / DATE PICKER
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('id', 'ID'), // Mengatur regional ke Indonesia
      ],
      
      // HALAMAN PERTAMA YANG DIBUKA
      home: const WelcomeScreen(), 
      
      // DAFTAR RUTE HALAMAN APLIKASI KAMU
      routes: {
        '/welcome': (context) => const WelcomeScreen(),
        '/login': (context) => const LoginScreen(),
        '/dashboard': (context) => const DashboardPage(),
        '/loading_rekap': (context) => const LoadingPage(), 
        '/rekap_keterlambatan': (context) => const RekapKeterlambatanPage(),
        '/export_data': (context) => const ExportDataScreen(), // Jalur panggil langsung ekspor data
      },
    );
  }
}