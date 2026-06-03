import 'package:flutter/material.dart';
import 'pilih_kelas_page.dart';

class PilihTingkatPage extends StatelessWidget {
  final int currentThemeIndex;
  final Function(int) onThemeChanged;

  const PilihTingkatPage({
    Key? key,
    // PERBAIKAN: Dibuat opsional dengan nilai default agar dashboard-mu tidak error saat memanggil halaman ini
    this.currentThemeIndex = 0,
    this.onThemeChanged = _defaultOnThemeChanged,
  }) : super(key: key);

  // Fungsi fallback default jika dashboard tidak mengirimkan fungsi beralih tema
  static void _defaultOnThemeChanged(int index) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF162A5A),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Row(
          children: [
            Icon(Icons.people_alt_rounded, color: Colors.white, size: 22),
            SizedBox(width: 8),
            Text(
              'Pilih Tingkat',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: Column(
          children: [
            _buildTingkatCard(
              context,
              tingkat: "10",
              judul: "KELAS 10",
              // Gradasi untuk Kelas 10
              colors: [const Color(0xFFE58867), const Color(0xFFC76D56)],
              // Path ke gambar dekoratif Kelas 10
              imagePath: 'assets/gambar_kelas_10.png',
            ),
            const SizedBox(height: 16),
            _buildTingkatCard(
              context,
              tingkat: "11",
              judul: "KELAS 11",
              // Gradasi untuk Kelas 11
              colors: [const Color(0xFF0F3256), const Color(0xFF38575B)],
              // Path ke gambar dekoratif Kelas 11
              imagePath: 'assets/gambar_kelas_11.png',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTingkatCard(
    BuildContext context, {
    required String tingkat,
    required String judul,
    required List<Color> colors,
    required String imagePath,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PilihKelasPage(
              tingkat: tingkat,
              currentThemeIndex: currentThemeIndex,
              onThemeChanged: onThemeChanged,
            ),
          ),
        );
      },
      child: Container(
        width: double.infinity,
        height: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          // Bayangan halus agar kartu menonjol
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
          // Gradasi latar belakang
          gradient: LinearGradient(
            colors: colors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Stack(
          children: [
            // Konten teks di sebelah kiri
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    judul,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Tahun ajaran 2025/2026',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            // Gambar dekoratif di sisi kanan
            Positioned(
              right: 0,
              top: 0,
              bottom: 0,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
                child: Opacity(
                  opacity: 0.8, // Sedikit transparansi agar menyatu
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                    width: 140, // Lebar gambar disesuaikan
                    // Builder untuk menangani jika gambar tidak ditemukan
                    errorBuilder: (context, error, stackTrace) =>
                        const SizedBox(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}