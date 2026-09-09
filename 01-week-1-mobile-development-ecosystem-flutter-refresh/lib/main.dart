import 'package:flutter/material.dart';

void main() {
  runApp(const PoliwangiProfileApp());
}

class PoliwangiProfileApp extends StatelessWidget {
  const PoliwangiProfileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Profil Mahasiswa TRPL',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0284C7)),
        useMaterial3: true,
      ),
      home: const ProfileScreen(),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  final String? githubUsername = 'https://github.com/TriKeren?tab=repositories';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text(
          'Profil Mahasiswa',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF0284C7),
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // ── Avatar ─────────────────────────────────────────────
              Container(
                width: 96,
                height: 96,
                decoration: BoxDecoration(
                  color: const Color(0xFFE0F2FE),
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFF0284C7), width: 3),
                ),
                child: const Icon(
                  Icons.school_rounded,
                  size: 52,
                  color: Color(0xFF0284C7),
                ),
              ),
              const SizedBox(height: 16),

              // ── GANTI: Nama Anda ──────────────────────────────────
              const Text(
                'Rizky Tri Anggara',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 6),

              // ── GANTI: NIM Anda ───────────────────────────────────
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFDBEAFE),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'NIM: 3625588302096',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1D4ED8),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // ── Kartu Info Akademik ──────────────────────────────
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: const BorderSide(color: Color(0xFFE2E8F0)),
                ),
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      _InfoRow(
                        icon: Icons.business_rounded,
                        label: 'Jurusan',
                        value: 'Bisnis dan Informatika',
                      ),
                      Divider(height: 24, color: Color(0xFFF1F5F9)),
                      _InfoRow(
                        icon: Icons.code_rounded,
                        label: 'Program Studi',
                        value: 'Sarjana Terapan TRPL',
                      ),
                      Divider(height: 24, color: Color(0xFFF1F5F9)),
                      _InfoRow(
                        icon: Icons.location_on_rounded,
                        label: 'Kampus',
                        value: 'Politeknik Negeri Banyuwangi',
                      ),
                      Divider(height: 24, color: Color(0xFFF1F5F9)),
                      _InfoRow(
                        icon: Icons.link_rounded,
                        label: 'Repository Github',
                        value: githubUsername ?? '(Belum Diatur)',
                      ),
                      _InfoRow(
                        icon: Icons.star_rounded,
                        label: 'Fokus Keahlian',
                        value: 'Mobile UI/UX & Mobile Development',
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton.icon(
                onPressed: () {
                  // ScaffoldMessenger mengelola tampilan pesan feedback (SnackBar) di atas layar aktif
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      // Konten teks informasi status
                      content: const Text(
                        'Status: Mahasiswa Aktif TRPL — Angkatan 2024',
                      ),
                      backgroundColor: const Color(
                        0xFF0284C7,
                      ), // Warna background biru Poliwangi
                      behavior: SnackBarBehavior
                          .floating, // Mengambang melayang di atas batas bawah layar
                      duration: const Duration(
                        seconds: 3,
                      ), // Durasi tampil otomatis sebelum menghilang
                    ),
                  );
                },
                icon: const Icon(
                  Icons.verified_user_rounded,
                ), // Ikon verifikasi bercentang
                label: const Text(
                  'Verifikasi Status Mahasiswa',
                ), // Teks label tombol aksi
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFFF0F9FF),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 20, color: const Color(0xFF0284C7)),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 11,
                  color: Color(0xFF64748B),
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF0F172A),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
