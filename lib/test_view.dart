import 'package:flutter/material.dart';

void main() => runApp(
  const MaterialApp(debugShowCheckedModeBanner: false, home: LoadingPage()),
);

// Loading screen that matches the design screenshot
class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});
  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _b1;
  late final Animation<double> _b2;
  late final Animation<double> _b3;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);

    _b1 = Tween(begin: 0.4, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.8, curve: Curves.easeInOut),
      ),
    );
    _b2 = Tween(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.15, 0.95, curve: Curves.easeInOut),
      ),
    );
    _b3 = Tween(begin: 0.45, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 1.0, curve: Curves.easeInOut),
      ),
    );

    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;
      _controller.stop();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (c) => const RekapKeterlambatanPage()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF1E4DA0), Color(0xFF0F3B78)],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Membuka rekap...',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 32),
              Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white70, width: 2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: SizedBox(
                    width: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        _barAnimated(_b1),
                        _barAnimated(_b2),
                        _barAnimated(_b3),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 28),
              const Text(
                'Mohon tunggu sebentar',
                style: TextStyle(color: Colors.white70),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _barAnimated(Animation<double> anim) => AnimatedBuilder(
    animation: anim,
    builder: (context, child) {
      final h = 56.0 * anim.value + 8;
      return Container(
        width: 12,
        height: h,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 2),
          borderRadius: BorderRadius.circular(6),
        ),
      );
    },
  );
}

class RekapKeterlambatanPage extends StatefulWidget {
  const RekapKeterlambatanPage({super.key});
  @override
  State<RekapKeterlambatanPage> createState() => _RekapKeterlambatanPageState();
}

class _RekapKeterlambatanPageState extends State<RekapKeterlambatanPage> {
  String _kategori = "Data Keterlambatan";
  DateTime _tanggal = DateTime.now();
  TimeOfDay _waktu = TimeOfDay.now();

  Future<void> _pilihTanggal() async {
    DateTime? p = await showDatePicker(
      context: context,
      initialDate: _tanggal,
      firstDate: DateTime(2025),
      lastDate: DateTime(2030),
    );
    if (p != null) setState(() => _tanggal = p);
  }

  Future<void> _pilihWaktu() async {
    TimeOfDay? p = await showTimePicker(context: context, initialTime: _waktu);
    if (p != null) setState(() => _waktu = p);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEef2f6),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "Rekap Keterlambatan",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Kategori
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  _kategoriButton(
                    "Data Keterlambatan",
                    _kategori == "Data Keterlambatan"
                        ? Colors.grey.shade300
                        : Colors.white,
                  ),
                  _kategoriButton(
                    "Data Kehadiran",
                    _kategori == "Data Kehadiran" ? Colors.red : Colors.white,
                    isRed: _kategori == "Data Kehadiran",
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            // Kalender & Jam
            Row(
              children: [
                _fieldTap(
                  "Tanggal",
                  "${_tanggal.day}-${_tanggal.month}-${_tanggal.year}",
                  Icons.calendar_today,
                  _pilihTanggal,
                ),
                const SizedBox(width: 10),
                _fieldTap(
                  "Jam",
                  _waktu.format(context),
                  Icons.access_time,
                  _pilihWaktu,
                ),
              ],
            ),
            const SizedBox(height: 15),
            // Teks Rekap (Warna Putih di dalam Box Biru)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                _kategori,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () {},
                child: const Text("Simpan dan Tutup"),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                onPressed: () {},
                child: const Text(
                  "Lanjutkan",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _kategoriButton(String label, Color color, {bool isRed = false}) =>
      Expanded(
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => setState(() => _kategori = label),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.center,
            child: Text(
              label,
              style: TextStyle(
                color: isRed ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      );

  Widget _fieldTap(
    String label,
    String value,
    IconData icon,
    VoidCallback onTap,
  ) => Expanded(
    child: Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(fontSize: 10)),
              Row(
                children: [
                  Text(value),
                  const Spacer(),
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: Icon(icon, size: 18, color: Colors.blue),
                    onPressed: onTap,
                    splashRadius: 20,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}