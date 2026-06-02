import 'package:flutter/material.dart';

class ProfilPage extends StatelessWidget {
  final String role; 

  const ProfilPage({super.key, required this.role});

  @override
  Widget build(BuildContext context) {
    String namaUser = 'Osis 1';
    String emailUser = 'osisk4@gmail.com';
    IconData iconProfil = Icons.school;

    if (role == 'Guru') {
      namaUser = 'Bapak/Ibu Guru';
      emailUser = 'guru.kr4bat@sekolah.sch.id';
      iconProfil = Icons.co_present;
    } else if (role == 'MPK') {
      namaUser = 'Tim MPK Perwakilan';
      emailUser = 'mpk.kr4bat@gmail.com';
      iconProfil = Icons.gavel;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Pengguna', style: TextStyle(fontWeight: FontWeight.bold)),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Center(
              child: CircleAvatar(
                radius: 45,
                backgroundColor: const Color(0xFF1A237E),
                child: Icon(iconProfil, size: 45, color: Colors.white),
              ),
            ),
            const SizedBox(height: 32),
            _buildProfileTile('Nama: $namaUser'),
            const SizedBox(height: 12),
            _buildProfileTile('Email / Username: $emailUser'),
            const SizedBox(height: 12),
            _buildProfileTile('Akses Akun: $role'),
            const SizedBox(height: 12),
            _buildProfileTile('Password: ******'),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileTile(String label) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
    );
  }
}