import 'package:flutter/material.dart';

class RekapDataPage extends StatelessWidget {
  final String namaKelas;
  final int totalSiswa;
  final int totalTerlambat;

  const RekapDataPage({
    super.key,
    required this.namaKelas,
    required this.totalSiswa,
    required this.totalTerlambat,
  });

  @override
  Widget build(BuildContext context) {
    int totalHadir = totalSiswa - totalTerlambat;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      // AppBar Putih Bersih
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () {
            // Kembali ke halaman paling awal (Pilih Tingkat)
            Navigator.popUntil(context, (route) => route.isFirst);
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            // Header Judul Rekapitulasi (Biru Tua, Teks Putih)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                color: const Color(0xFF162A5A),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Center(
                child: Text(
                  "Rekapitulasi",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Nama Kelas
            Text(
              namaKelas,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF162A5A),
              ),
            ),
            const SizedBox(height: 20),

            // Card Statistik
            Expanded(
              child: ListView(
                children: [
                  _buildStatCard(
                    "Total Siswa",
                    "$totalSiswa",
                    Icons.people_outline,
                    const Color(0xFF162A5A),
                  ),
                  const SizedBox(height: 16),
                  _buildStatCard(
                    "Hadir",
                    "$totalHadir",
                    Icons.check_circle_outline,
                    Colors.green,
                  ),
                  const SizedBox(height: 16),
                  _buildStatCard(
                    "Terlambat",
                    "$totalTerlambat",
                    Icons.warning_amber_rounded,
                    Colors.redAccent,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(width: 20),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}