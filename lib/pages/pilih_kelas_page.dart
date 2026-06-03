import 'package:flutter/material.dart';
import 'daftar_siswa_page.dart';

// --- PUSAT KENDALI TEMA (Global) ---
class ThemeManager {
  static final ValueNotifier<ThemeMode> themeMode = ValueNotifier(
    ThemeMode.light,
  );
  static void toggleTheme(ThemeMode mode) => themeMode.value = mode;
}

// Asumsikan ThemeManager sudah dibuat di file terpisah atau di main.dart
// Untuk contoh ini, kita gunakan setState sederhana agar langsung berfungsi di halaman ini.

class PilihKelasPage extends StatefulWidget {
  final String tingkat;
  final int currentThemeIndex;
  final Function(int) onThemeChanged;

  const PilihKelasPage({
    Key? key,
    required this.tingkat,
    required this.currentThemeIndex,
    required this.onThemeChanged,
  }) : super(key: key);

  @override
  State<PilihKelasPage> createState() => _PilihKelasPageState();
}

class _PilihKelasPageState extends State<PilihKelasPage> {
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, dynamic>> _semuaKelas = [
    {"nama": "PPLG 1", "warna": const Color(0xFFAD1457), "icon": Icons.code},
    {
      "nama": "PPLG 2",
      "warna": const Color(0xFFD81B60),
      "icon": Icons.computer,
    },
    {"nama": "TJKT 1", "warna": const Color(0xFFF4511E), "icon": Icons.router},
    {"nama": "TJKT 2", "warna": const Color(0xFFFB8C00), "icon": Icons.dns},
    {
      "nama": "TJKT 3",
      "warna": const Color(0xFFFDD835),
      "icon": Icons.settings_input_component,
    },
    {"nama": "TPFL 1", "warna": const Color(0xFFC0CA33), "icon": Icons.build},
    {
      "nama": "TPFL 2",
      "warna": const Color(0xFF66BB6A),
      "icon": Icons.precision_manufacturing,
    },
    {
      "nama": "TPFL 3",
      "warna": const Color(0xFF26A69A),
      "icon": Icons.engineering,
    },
    {
      "nama": "TO 1",
      "warna": const Color(0xFF42A5F5),
      "icon": Icons.directions_car,
    },
    {"nama": "TO 2", "warna": const Color(0xFF5C6BC0), "icon": Icons.settings},
  ];

  List<Map<String, dynamic>> _hasilPencarian = [];

  @override
  void initState() {
    super.initState();
    _hasilPencarian = _semuaKelas;
  }

  void _cariKelas(String query) {
    setState(() {
      _hasilPencarian = _semuaKelas.where((kelas) {
        final namaKelas = "${widget.tingkat} ${kelas['nama']}".toLowerCase();
        return namaKelas.contains(query.toLowerCase());
      }).toList();
    });
  }

  // Fungsi untuk menampilkan Dialog Tema
  void _tampilkanDialogTema() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Pilih Tema"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile(
              title: const Text("Tema Terang"),
              value: 0,
              groupValue: widget.currentThemeIndex,
              onChanged: (val) {
                widget.onThemeChanged(val!);
                Navigator.pop(context);
              },
            ),
            RadioListTile(
              title: const Text("Tema Gelap"),
              value: 1,
              groupValue: widget.currentThemeIndex,
              onChanged: (val) {
                widget.onThemeChanged(val!);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF162A5A),
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text("Pilih Kelas", style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                children: [
                  const Icon(Icons.search, color: Colors.grey),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      onChanged: _cariKelas,
                      decoration: const InputDecoration(
                        hintText: "Cari...",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  // Tombol Filter (Garis 3)
                  IconButton(
                    icon: const Icon(Icons.filter_list, color: Colors.grey),
                    onPressed: _tampilkanDialogTema,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2.2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemCount: _hasilPencarian.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DaftarSiswaPage(
                            namaKelas:
                                "${widget.tingkat} ${_hasilPencarian[index]['nama']}",
                          ),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: _hasilPencarian[index]["warna"],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "${widget.tingkat} ${_hasilPencarian[index]['nama']}",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                const Icon(
                                  Icons.people,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            _hasilPencarian[index]["icon"],
                            color: Colors.white.withOpacity(0.5),
                            size: 40,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}