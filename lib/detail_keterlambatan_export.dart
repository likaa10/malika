import 'package:flutter/material.dart';

class ExportDataScreen extends StatefulWidget {
  final DateTime? initialDate;
  const ExportDataScreen({super.key, this.initialDate});

  @override
  State<ExportDataScreen> createState() => _ExportDataScreenState();
}

class _ExportDataScreenState extends State<ExportDataScreen> {
  DateTime selectedDate = DateTime(2026, 4, 10);

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  // --- 1. POP UP PILIHAN MEDIA (BOTTOM SHEET) ---
  void _showFormatFileBottomSheet(String format) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Format File",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _buildMediaItem(Icons.chat_bubble_outline, "WhatsApp", () {
                    Navigator.pop(context); // Tutup BottomSheet
                    _showSuccessDialog(); // Lanjut ke dialog sukses
                  }),
                  const SizedBox(width: 16),
                  _buildMediaItem(Icons.mail_outline, "Email", () {
                    Navigator.pop(context);
                    _showSuccessDialog();
                  }),
                  const SizedBox(width: 16),
                  _buildMediaItem(Icons.share_outlined, "Lainnya", () {
                    Navigator.pop(context);
                    _showSuccessDialog();
                  }),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  // --- 2. DIALOG BERHASIL DIKIRIM ---
  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false, // User wajib klik tombol
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircleAvatar(
                  radius: 28,
                  backgroundColor: Color(0xFF4CAF50), // Warna Hijau Sukses
                  child: Icon(Icons.check, color: Colors.white, size: 36),
                ),
                const SizedBox(height: 16),
                const Text(
                  "Laporan Berhasil Dikirim!",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
                ),
                const SizedBox(height: 8),
                Text(
                  "Laporan Keterlambatan tanggal ${selectedDate.day} April ${selectedDate.year} telah dikirim ke Tim Guru.",
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 12, color: Colors.black54),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.black38),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Batal", style: TextStyle(color: Colors.black87, fontSize: 12)),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1D2A57), // Tombol Biru Navy
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        onPressed: () {
                            // KEMBALI KE HALAMAN REKAP KETERLAMBATAN DAN HAPUS SEMUA ROUTE SEBELUMNYA
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              '/rekap_keterlambatan',
                              (route) => false,
                            );
                          },
                        child: const Text(
                          "Lht Laporan Guru",
                          style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

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
          "Export Data",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- PILIH TANGGAL ---
            const Text(
              "Pilih Tanggal",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            const SizedBox(height: 8),
            InkWell(
              onTap: () => _selectDate(context),
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.black38, width: 1),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${selectedDate.day.toString().padLeft(2, '0')} April ${selectedDate.year}",
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black87),
                    ),
                    const Icon(Icons.calendar_today_outlined, size: 20, color: Colors.black54),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 32),
            
            // --- FORMAT FILE GRID ---
            const Text(
              "Format File",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            const SizedBox(height: 16),
            
            Row(
              children: [
                Expanded(
                  child: _buildExportCard(
                    icon: Icons.picture_as_pdf,
                    title: "Export",
                    subtitle: "Export PDF",
                    onTap: () => _showFormatFileBottomSheet("PDF"),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildExportCard(
                    icon: Icons.table_chart,
                    title: "Export",
                    subtitle: "Spreadsheet",
                    onTap: () => _showFormatFileBottomSheet("Spreadsheet"),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildExportCard(
                    icon: Icons.description,
                    title: "Export",
                    subtitle: "Export Excel",
                    onTap: () => _showFormatFileBottomSheet("Excel"),
                  ),
                ),
                const Expanded(child: SizedBox()),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExportCard({required IconData icon, required String title, required String subtitle, required VoidCallback onTap}) {
    return Container(
      height: 130,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300, width: 1),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 36, color: Colors.black87),
              const SizedBox(height: 8),
              Text(title, style: const TextStyle(fontSize: 11, color: Colors.black54)),
              Text(subtitle, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black87)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMediaItem(IconData icon, String label, VoidCallback onTap) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300, width: 1),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 28, color: Colors.black87),
              const SizedBox(height: 6),
              Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: Colors.black87)),
            ],
          ),
        ),
      ),
    );
  }
}