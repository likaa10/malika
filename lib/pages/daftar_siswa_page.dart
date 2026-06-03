import 'package:flutter/material.dart';
import '../rekap_data.dart';

class DaftarSiswaPage extends StatefulWidget {
  final String namaKelas;
  const DaftarSiswaPage({super.key, required this.namaKelas});

  @override
  State<DaftarSiswaPage> createState() => _DaftarSiswaPageState();
}

class _DaftarSiswaPageState extends State<DaftarSiswaPage> {
  // 1. Siapkan dua daftar (Kelas 10 dan 11)
  final List<String> _dataKelas10 = [
    "ALENA LAKIRA",
    "ALIFA PUTRI HERVIZA",
    "ALMIRA KHAERUNISA",
    "ANITA FEBRIANTI MAULIDA",
    "ARYA DWI HERWANTO",
    "DEDE OKTAVIANI",
    "DESWITA HERAWATI",
    "DIANA PUTRI",
    "FAHRI RAMADHAN",
    "GIOVANNI ARYA",
  ];

  final List<String> _dataKelas11 = [
    "Adellia Indra",
    "Ahmad Firdausy Ahla",
    "Ahmad Zuhud Baihaqi",
    "Alsya Juliana Rizki",
    "ANNISA RAMADHANI",
    "AULIA JULIANA",
    "Bima Sakti Putra Pupito",
    "DARA SYIFA MAGHFIRA",
    "DIAN ISLAMI FATWA",
    "IBNI IFTIKHAR FATTAH",
  ];

  // 2. Gunakan variabel kosong yang akan diisi nanti
  late List<String> _namaSiswa;
  late List<bool> _isTerlambat;

  @override
  void initState() {
    super.initState();
    // 3. LOGIKA PENENTU: Di sini kuncinya!
    // Karena `namaKelas` dibentuk sebagai "<tingkat> <nama kelas>
    // kita ambil token pertama (tingkat) untuk menentukan daftar.
    final tingkatToken = widget.namaKelas
        .split(RegExp(r"\s+"))[0]
        .toLowerCase();
    if (tingkatToken == '11' || tingkatToken == 'xi') {
      _namaSiswa = _dataKelas11;
    } else {
      _namaSiswa = _dataKelas10;
    }

    _isTerlambat = List.generate(_namaSiswa.length, (index) => false);
  }

  void _tampilkanDialog(int index) {
    bool isSekarangTerlambat = _isTerlambat[index];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        contentPadding: const EdgeInsets.fromLTRB(24, 30, 24, 20),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Ikon dengan warna yang sesuai desain
            Icon(
              isSekarangTerlambat ? Icons.delete_outline : Icons.help_outline,
              size: 64,
              color: isSekarangTerlambat
                  ? const Color(0xFFE53935)
                  : const Color(0xFF162A5A),
            ),
            const SizedBox(height: 20),
            Text(
              isSekarangTerlambat
                  ? "Hapus Pencatatan?"
                  : "Tandai sebagai terlambat?",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 20,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              isSekarangTerlambat
                  ? "Yakin ingin menghapus pencatatan '${_namaSiswa[index]}' pada 07:04 WIB?"
                  : "${_namaSiswa[index]}\n07:04 WIB",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black54,
                height: 1.4,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              "Batal",
              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: isSekarangTerlambat
                  ? const Color(0xFFE53935)
                  : const Color(0xFF162A5A),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {
              setState(() => _isTerlambat[index] = !isSekarangTerlambat);
              Navigator.pop(context);
              _tampilkanDialogSukses(isSekarangTerlambat);
            },
            child: Text(
              isSekarangTerlambat ? "Ya, Hapus" : "Catat",
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _tampilkanDialogSukses(bool isTerlambat) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isTerlambat ? Icons.cancel : Icons.check_circle,
              size: 70,
              color: isTerlambat
                  ? const Color(0xFFE53935)
                  : const Color(0xFF4CAF50),
            ),
            const SizedBox(height: 20),
            Text(
              isTerlambat
                  ? "Data Terlambat Terhapus!"
                  : "Data Terlambat Tersimpan!",
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Tutup"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF162A5A),
            ),
            onPressed: () {
              // Tutup dialog terlebih dahulu, lalu kembali ke layar pertama (beranda)
              Navigator.pop(context); // tutup dialog
              Navigator.popUntil(context, (route) => route.isFirst);
            },
            child: const Text(
              "Kembali ke Beranda",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int totalTerlambat = _isTerlambat.where((e) => e).length;

    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF162A5A),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RekapDataPage(
                namaKelas: widget.namaKelas,
                totalSiswa: _namaSiswa.length,
                totalTerlambat: _isTerlambat.where((e) => e).length,
              ),
            ),
          );
        },
        child: const Icon(Icons.description, color: Colors.white),
      ),
      body: Column(
        children: [
          // HEADER (Sama seperti sebelumnya)
          Container(
            padding: const EdgeInsets.fromLTRB(20, 60, 20, 30),
            decoration: const BoxDecoration(
              color: Color(0xFF162A5A),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(32),
                bottomRight: Radius.circular(32),
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      widget.namaKelas,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildStat("TOTAL SISWA", "${_namaSiswa.length}"),
                    Container(width: 1, height: 30, color: Colors.white24),
                    _buildStat("TERLAMBAT", "$totalTerlambat"),
                  ],
                ),
              ],
            ),
          ),

          // LIST SISWA
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              itemCount: _namaSiswa.length,
              itemBuilder: (context, index) {
                bool isTerlambat = _isTerlambat[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.grey.shade200),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.03),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.grey.shade100,
                        child: Icon(Icons.person, color: Colors.grey.shade600),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Text(
                          _namaSiswa[index],
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),

                      // Status Tag yang memanggil Pop-Up
                      GestureDetector(
                        onTap: () => _tampilkanDialog(index),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: isTerlambat
                                ? Colors.red.shade50
                                : Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              Text(
                                isTerlambat ? "TERLAMBAT" : "HADIR",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: isTerlambat
                                      ? Colors.red
                                      : Colors.grey.shade600,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Icon(
                                Icons.check_circle,
                                size: 14,
                                color: isTerlambat
                                    ? Colors.red
                                    : Colors.grey.shade400,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStat(String title, String value) => Column(
    children: [
      Text(
        value,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
      Text(
        title,
        style: const TextStyle(
          color: Colors.white70,
          fontSize: 10,
          letterSpacing: 1,
        ),
      ),
    ],
  );
}