import 'package:flutter/material.dart';

class RekapKeterlambatanPage extends StatelessWidget {
  const RekapKeterlambatanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEDF1F7),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1D2A57),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Detail Data Keterlambatan",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1D2A57),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // --- KOTAK INFO TANGGAL ---
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Tanggal:",
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black87),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "10 April 2026 (Rekap Harian)",
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black54),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),

                      // --- TABEL DATA SISWA TERLAMBAT ---
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Table(
                            columnWidths: const {
                              0: FlexColumnWidth(1.2),
                              1: FlexColumnWidth(4),
                              2: FlexColumnWidth(3),
                            },
                            border: TableBorder.all(
                              color: Colors.grey.shade200,
                              width: 1,
                            ),
                            children: [
                              TableRow(
                                decoration: BoxDecoration(color: Colors.grey.shade300),
                                children: const [
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 12.0),
                                    child: Text("No.", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 12.0),
                                    child: Text("Nama Siswa", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 12.0),
                                    child: Text("K-Point Status", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 16.0),
                                    child: Text("1.", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Dede Oktaviani", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                                        Text("(X-TJKT 2)", style: TextStyle(color: Colors.grey, fontSize: 11)),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
                                    child: _buildPointBadge("6.55"),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 16.0),
                                    child: Text("2.", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Alena Lakira", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                                        Text("(X-TO 2)", style: TextStyle(color: Colors.grey, fontSize: 11)),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
                                    child: _buildPointBadge("6.41"),
                                  ),
                                ],
                              ),
                              const TableRow(
                                children: [
                                  Padding(padding: EdgeInsets.symmetric(vertical: 16.0), child: Text("")),
                                  Padding(padding: EdgeInsets.symmetric(vertical: 16.0), child: Text("")),
                                  Padding(padding: EdgeInsets.symmetric(vertical: 16.0), child: Text("")),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // --- TOMBOL DOWNLOAD LAPORAN ---
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1D2A57),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  elevation: 2,
                ),
                onPressed: () {
                  // Memanggil rute ekspor data sesuai konfigurasi main.dart kamu
                  Navigator.pushNamed(context, '/export_data');
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.download_rounded, color: Colors.white, size: 20),
                    SizedBox(width: 8),
                    Text(
                      "Download Laporan",
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPointBadge(String score) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF24E43),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.warning_amber_rounded, color: Colors.white, size: 12),
          const SizedBox(width: 4),
          Text(
            score,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
          ),
        ],
      ),
    );
  }
}