import 'package:flutter/material.dart';
// PERBAIKAN IMPORT: Diarahkan ke dashboard_page.dart (bukan dashboard_screen.dart) sesuai gambar folder lib kamu
import 'dashboard_page.dart'; 

class StatistikScreen extends StatefulWidget {
  const StatistikScreen({super.key});

  @override
  State<StatistikScreen> createState() => _StatistikScreenState();
}

class _StatistikScreenState extends State<StatistikScreen> {
  bool _isLoading = true;
  int _selectedDayIndex = 0; // 0: Hari 1, 1: Hari 2, 2: Hari 3

  // Data sesuai gambar Figma kamu
  final List<Map<String, dynamic>> _statData = [
    {
      "dayLabel": "Hari 1",
      "dateLabel": "(Rabu, 08/04)",
      "total": "3",
      "tooltip": "Hari 1: 3 Siswa",
      "value": 3.0,
    },
    {
      "dayLabel": "Hari 2",
      "dateLabel": "(Kamis, 09/04)",
      "total": "3",
      "tooltip": "Hari 2: 3 Siswa",
      "value": 3.0,
    },
    {
      "dayLabel": "Hari 3",
      "dateLabel": "(Jumat, 10/04)",
      "total": "2",
      "tooltip": "Hari 3: 2 Siswa",
      "value": 2.0,
    },
  ];

  @override
  void initState() {
    super.initState();
    // Simulasi loading screen "Mohon tunggu sebentar" selama 2 detik
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // 1. TAMPILAN LOADING SCREEN (Sesuai gambar paling kiri)
    if (_isLoading) {
      return Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF0D47A1),
                Color(0xFF1E2856),
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Membuka statistik...",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40.0),
              // Ikon Grafik Naik Kustom
              Container(
                padding: const EdgeInsets.all(20.0),
                child: SizedBox(
                  width: 100,
                  height: 80,
                  child: CustomPaint(
                    painter: LoadingChartIconPainter(),
                  ),
                ),
              ),
              const SizedBox(height: 40.0),
              const Text(
                "Mohon tunggu sebentar",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14.0,
                ),
              ),
            ],
          ),
        ),
      );
    }

    // 2. TAMPILAN UTAMA STATISTIK
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E2856),
        elevation: 0,
        centerTitle: false,
        title: const Text(
          "Statistik",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // Kembali ke halaman menu sebelumnya
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Badge Rentang Tanggal
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
              decoration: BoxDecoration(
                color: const Color(0xFFBBDEFB),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: const Text(
                "08 April 2026 - 10 April 2026",
                style: TextStyle(
                  color: Color(0xFF1E2856),
                  fontSize: 11.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 40.0),

            // AREA GRAFIK LINE CHART
            Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 200,
                  child: CustomPaint(
                    painter: LineChartPainter(
                      data: _statData,
                      selectedIndex: _selectedDayIndex,
                    ),
                  ),
                ),

                // Tooltip Overlay Dinamis di Atas Grafik
                SizedBox(
                  width: double.infinity,
                  height: 200,
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      double chartWidth = constraints.maxWidth - 40;
                      double spacing = chartWidth / 2;
                      double startX = 30;

                      List<double> xPositions = [
                        startX,
                        startX + spacing,
                        startX + (spacing * 2)
                      ];
                      
                      List<double> yPositions = [
                        200 - (30 + ((_statData[0]['value'] as double) / 4.0) * 140),
                        200 - (30 + ((_statData[1]['value'] as double) / 4.0) * 140),
                        200 - (30 + ((_statData[2]['value'] as double) / 4.0) * 140),
                      ];

                      return Stack(
                        children: List.generate(_statData.length, (index) {
                          bool isThisSelected = _selectedDayIndex == index;
                          return Positioned(
                            left: xPositions[index] - 45,
                            top: yPositions[index] - 35,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
                              decoration: BoxDecoration(
                                color: isThisSelected ? const Color(0xFF1E2856) : const Color(0xFFE3F2FD),
                                borderRadius: BorderRadius.circular(4.0),
                                border: Border.all(color: const Color(0xFF1E2856), width: 0.5),
                              ),
                              child: Text(
                                _statData[index]['tooltip'],
                                style: TextStyle(
                                  color: isThisSelected ? Colors.white : const Color(0xFF1E2856),
                                  fontSize: 9.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          );
                        }),
                      );
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10.0),

            // LABEL X-AXIS (Hari & Tanggal) YANG BISA DI-TAP
            LayoutBuilder(
              builder: (context, constraints) {
                double itemWidth = (constraints.maxWidth - 40) / 3;
                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(width: 20), 
                    Row(
                      children: List.generate(_statData.length, (index) {
                        bool isSelected = _selectedDayIndex == index;
                        return InkWell(
                          onTap: () {
                            setState(() {
                              _selectedDayIndex = index;
                            });
                          },
                          child: Container(
                            width: itemWidth,
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            decoration: BoxDecoration(
                              color: isSelected ? const Color(0xFFBBDEFB) : Colors.transparent,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  _statData[index]['dayLabel'],
                                  style: const TextStyle(
                                    fontSize: 11.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  _statData[index]['dateLabel'],
                                  style: const TextStyle(
                                    fontSize: 9.0,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 30.0),

            // TOTAL INDIKATOR BAWAH
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(_statData.length, (index) {
                return Column(
                  children: [
                    Text(
                      "${_statData[index]['dayLabel']} Total",
                      style: const TextStyle(fontSize: 10.0, color: Colors.black54),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      _statData[index]['total'],
                      style: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

// =========================================================================
// ENGINE GRAPHIC PAINTER (UNTUK MENGGAMBAR LINE CHART BENTUK FIGMA)
// =========================================================================
class LineChartPainter extends CustomPainter {
  final List<Map<String, dynamic>> data;
  final int selectedIndex;

  LineChartPainter({required this.data, required this.selectedIndex});

  @override
  void paint(Canvas canvas, Size size) {
    double startX = 30; 
    double endX = size.width - 10;
    double chartWidth = endX - startX;
    double spacing = chartWidth / 2;

    double startY = size.height - 30;
    double endY = 10;
    double chartHeight = startY - endY;

    // 1. Gambar Garis Pandu Horizontal & Label Y-Axis (0 sampai 4)
    Paint gridPaint = Paint()
      ..color = Colors.grey[300]!
      ..strokeWidth = 1.0;

    TextPainter textPainter = TextPainter(textDirection: TextDirection.ltr);

    for (int i = 0; i <= 4; i++) {
      double y = startY - (i / 4.0) * chartHeight;
      canvas.drawLine(Offset(startX, y), Offset(endX, y), gridPaint);
      
      textPainter.text = TextSpan(
        text: "$i",
        style: const TextStyle(color: Colors.black54, fontSize: 10.0),
      );
      textPainter.layout();
      textPainter.paint(canvas, Offset(10, y - 6));
    }

    // Hitung Koordinat Titik Data
    List<Offset> points = [];
    for (int i = 0; i < data.length; i++) {
      double x = startX + (i * spacing);
      double y = startY - (data[i]['value'] / 4.0) * chartHeight;
      points.add(Offset(x, y));
    }

    // 2. Gambar Jalur Garis Biru Penghubung Titik
    Paint linePaint = Paint()
      ..color = const Color(0xFF64B5F6)
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;
    
    Path path = Path();
    path.moveTo(points[0].dx, points[0].dy);
    for (int i = 1; i < points.length; i++) {
      path.lineTo(points[i].dx, points[i].dy);
    }
    canvas.drawPath(path, linePaint);

    // 3. Gambar Bulatan Titik Koordinat
    Paint pointPaint = Paint()..style = PaintingStyle.fill;
    Paint borderPointPaint = Paint()
      ..color = const Color(0xFF1E2856)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    for (int i = 0; i < points.length; i++) {
      pointPaint.color = const Color(0xFF1E2856);
      canvas.drawCircle(points[i], 4.0, pointPaint);
      canvas.drawCircle(points[i], 4.0, borderPointPaint);
    }
  }

  @override
  bool shouldRepaint(covariant LineChartPainter oldDelegate) {
    return oldDelegate.selectedIndex != selectedIndex;
  }
}

// =========================================================================
// PAINTER KHUSUS UNTUK IKON LOADING SCREEN (LOGO GRAFIK PUTIH)
// =========================================================================
class LoadingChartIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint iconPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(const Offset(0, 0), Offset(0, size.height), iconPaint);
    canvas.drawLine(Offset(0, size.height), Offset(size.width, size.height), iconPaint);

    Path arrowPath = Path();
    arrowPath.moveTo(10, size.height - 15);
    arrowPath.lineTo(size.width * 0.4, size.height * 0.6);
    arrowPath.lineTo(size.width * 0.65, size.height * 0.7);
    arrowPath.lineTo(size.width - 5, size.height * 0.2);

    canvas.drawPath(arrowPath, iconPaint);

    Path head = Path();
    head.moveTo(size.width - 15, size.height * 0.2 - 2);
    head.lineTo(size.width - 5, size.height * 0.2);
    head.lineTo(size.width - 8, size.height * 0.2 + 12);
    canvas.drawPath(head, iconPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}