import 'package:flutter/material.dart';
import 'package:kr4bat_go/detail_keterlambatan_export.dart'; 
import 'package:kr4bat_go/pages/pilih_kelas_page.dart'; //

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _currentIndex = 0; // 0: Beranda, 1: Profil, 2: Pengaturan

  void _showSnackbar(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), duration: const Duration(seconds: 1)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEDF1F7), 
      appBar: AppBar(
        backgroundColor: const Color(0xFF1D2A57), 
        elevation: 0,
        automaticallyImplyLeading: false, 
        title: const Text(
          "Hallo, OSIS",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none_outlined, color: Colors.white), 
            onPressed: () => _showSnackbar("Belum ada notifikasi baru"),
          ),
        ],
      ),
      body: Stack(
        children: [
          // Konten Utama (Scrollable)
          SingleChildScrollView(
            padding: const EdgeInsets.only(left: 24.0, right: 24.0, top: 24.0, bottom: 100.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // --- BAGIAN ATAS: TOTAL TERLAMBAT & JAM AKTIF ---
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 125,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1D2A57), 
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Total Terlambat\nHARI INI",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white70, fontSize: 11, height: 1.2),
                            ),
                            SizedBox(height: 6),
                            Text(
                              "3",
                              style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Siswa",
                              style: TextStyle(color: Colors.white70, fontSize: 11),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Container(
                        height: 125,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Jam Aktif",
                              style: TextStyle(color: Colors.black54, fontSize: 12, fontWeight: FontWeight.w500),
                            ),
                            SizedBox(height: 8),
                            Text(
                              "06:30 -\n07:30",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.black87, fontSize: 16, fontWeight: FontWeight.bold, height: 1.3),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 32),
                const Text(
                  "MENU UTAMA",
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black54, letterSpacing: 0.5),
                ),
                const SizedBox(height: 16),
                
                // --- GRID 4 FITUR UTAMA ---
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                  childAspectRatio: 1.0,
                  children: [
                    _buildMenuCard(
                      icon: Icons.people_alt_outlined,
                      label: "Pilih Kelas",
                      onTap: () {
                        // Semua parameter wajib buatan temanmu sudah terpenuhi utuh di sini!
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PilihKelasPage(
                              tingkat: "X", 
                              currentThemeIndex: 0, 
                              onThemeChanged: _dummyThemeCallback, // Memanggil fungsi callback tiruan di bawah
                            ), 
                          ),
                        );
                      },
                    ),
                    _buildMenuCard(
                      icon: Icons.bar_chart_outlined,
                      label: "Rekap Hari Ini",
                      onTap: () {
                        Navigator.pushNamed(context, '/loading_rekap');
                      },
                    ),
                    _buildMenuCard(
                      icon: Icons.cloud_download_outlined,
                      label: "Ekspor Data",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ExportDataScreen(),
                          ),
                        );
                      },
                    ),
                    _buildMenuCard(
                      icon: Icons.trending_up_outlined,
                      label: "Statistik",
                      onTap: () {
                        _showSnackbar("Membuka Halaman Statistik...");
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),

          // --- CUSTOM NAVBAR KOTAK PANJANG DI BAWAH ---
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.all(16.0),
              height: 65,
              decoration: BoxDecoration(
                color: const Color(0xFF1D2A57), 
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  )
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavbarItem(
                    index: 0,
                    icon: Icons.home_filled,
                    label: "Beranda",
                    onTap: () {
                      setState(() => _currentIndex = 0);
                    },
                  ),
                  _buildNavbarItem(
                    index: 1,
                    icon: Icons.person_rounded,
                    label: "Profil",
                    onTap: () {
                      setState(() => _currentIndex = 1);
                      _showSnackbar("Membuka Halaman Profil...");
                    },
                  ),
                  _buildNavbarItem(
                    index: 2,
                    icon: Icons.settings_rounded,
                    label: "Pengaturan",
                    onTap: () {
                      setState(() => _currentIndex = 2);
                      _showSnackbar("Membuka Halaman Pengaturan...");
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Fungsi tiruan untuk memenuhi parameter callback tema
  static void _dummyThemeCallback(int index) {}

  Widget _buildNavbarItem({
    required int index,
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    final isSelected = _currentIndex == index;
    final color = isSelected ? Colors.white : Colors.white.withOpacity(0.5);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 22),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(color: color, fontSize: 11, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuCard({required IconData icon, required String label, required VoidCallback onTap}) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(24.0),
      elevation: 0.5,
      child: InkWell(
        borderRadius: BorderRadius.circular(24.0),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40.0, color: const Color(0xFF1D2A57)),
              const SizedBox(height: 12.0),
              Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold, color: Color(0xFF1D2A57)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}