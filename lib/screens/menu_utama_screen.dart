import 'package:flutter/material.dart';
import 'dashboard_screen.dart';
import 'statistik_screen.dart';

class MenuUtamaScreen extends StatelessWidget {
  const MenuUtamaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- HEADER (Hallo, OSIS & Notifikasi) ---
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Hallo, OSIS',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  IconButton(
                    icon: const Icon(Icons.notifications_none_outlined, color: Colors.black, size: 28),
                    onPressed: () {},
                  ),
                ],
              ),
              const Divider(color: Colors.black26, thickness: 1),
              const SizedBox(height: 16),

              // --- ROW INFO KARTU ATAS ---
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 140,
                      decoration: BoxDecoration(color: const Color(0xFF1E2856), borderRadius: BorderRadius.circular(16)),
                      padding: const EdgeInsets.all(12),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Total Terlambat', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500)),
                          Text('HARI INI', style: TextStyle(color: Colors.white70, fontSize: 10)),
                          SizedBox(height: 8),
                          Text('3', style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
                          Text('Siswa', style: TextStyle(color: Colors.white70, fontSize: 11)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Container(
                      height: 140,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: const [BoxShadow(color: Color(0x14000000), blurRadius: 10, offset: Offset(0, 4))],
                      ),
                      padding: const EdgeInsets.all(12),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Jam Aktif', style: TextStyle(color: Colors.black87, fontSize: 13, fontWeight: FontWeight.w600)),
                          SizedBox(height: 12),
                          Text('06:30 -', style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
                          Text('07:30', style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // --- TEKS "MENU UTAMA" ---
              const Text(
                'MENU UTAMA',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, letterSpacing: 0.8),
              ),
              const SizedBox(height: 16),

              // --- GRID MENU ---
              Row(
                children: [
                  Expanded(child: _buildGridButton(title: 'Pilih Kelas', icon: Icons.groups_outlined, onTap: null)),
                  const SizedBox(width: 16),
                  Expanded(child: _buildGridButton(title: 'Rekap Hari Ini', icon: Icons.bar_chart_outlined, onTap: null)),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _buildGridButton(
                      title: 'Ekspor Data',
                      icon: Icons.file_upload_outlined,
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const DashboardScreen())),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildGridButton(
                      title: 'Statistik',
                      icon: Icons.trending_up_rounded,
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const StatistikScreen())),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.44,
                  child: _buildGridButton(title: 'Pengaturan', icon: Icons.settings_outlined, onTap: null),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGridButton({required String title, required IconData icon, required VoidCallback? onTap}) {
    return Container(
      height: 105,
      decoration: BoxDecoration(color: const Color(0xFFE2E4E8), borderRadius: BorderRadius.circular(16)),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 36, color: Colors.black87),
              const SizedBox(height: 8),
              Text(
                title,
                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.black87),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}