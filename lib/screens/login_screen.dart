import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscureText = true; // Untuk menyembunyikan/menampilkan password
  final TextEditingController _nisController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login() {
    // Ketika tombol MASUK KE PORTAL diklik, langsung arahkan ke Dashboard
    Navigator.pushReplacementNamed(context, '/dashboard');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 60),
              // Judul Aplikasi Atas
              const Center(
                child: Text(
                  "KR4BAT GO",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E2856), // Warna biru gelap sesuai tema
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              const SizedBox(height: 60),
              // Teks Selamat Datang
              const Text(
                "Selamat Datang,",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E2856),
                ),
              ),
              const Text(
                "Sobat KR4BAT!",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E2856),
                ),
              ),
              const SizedBox(height: 40),

              // Input NIS / Email Sekolah
              TextField(
                controller: _nisController,
                decoration: InputDecoration(
                  hintText: "NIS / Email Sekolah",
                  hintStyle: TextStyle(color: Colors.grey.shade600, fontSize: 14),
                  prefixIcon: Icon(Icons.account_circle_outlined, color: Colors.grey.shade700),
                  filled: true,
                  fillColor: const Color(0xFFF5F5F5),
                  contentPadding: const EdgeInsets.symmetric(vertical: 16.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: const BorderSide(color: Color(0xFF1E2856), width: 1.5),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Input Kata Sandi
              TextField(
                controller: _passwordController,
                obscureText: _obscureText,
                decoration: InputDecoration(
                  hintText: "Kata Sandi",
                  hintStyle: TextStyle(color: Colors.grey.shade600, fontSize: 14),
                  prefixIcon: Icon(Icons.lock_outline, color: Colors.grey.shade700),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                      color: Colors.grey.shade700,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
                  filled: true,
                  fillColor: const Color(0xFFF5F5F5),
                  contentPadding: const EdgeInsets.symmetric(vertical: 16.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: const BorderSide(color: Color(0xFF1E2856), width: 1.5),
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Tombol MASUK KE PORTAL
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1E2856), // Biru gelap persis foto
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    elevation: 0,
                  ),
                  onPressed: _login,
                  child: const Text(
                    "MASUK KE PORTAL",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}