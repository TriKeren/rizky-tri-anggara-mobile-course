import 'package:flutter/material.dart';
import 'modul1/Profile_Screen.dart';
import 'modul2/academic_dashboard_screen.dart';
// import 'modul_03/modul_03_app.dart';
// import 'modul_04/modul_04_app.dart';

void main() {
  runApp(const PoliwangiStarterApp());
}

class PoliwangiStarterApp extends StatelessWidget {
  const PoliwangiStarterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Poliwangi Mobile Codelabs 2026',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0284C7),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      home: const ModuleLauncherScreen(),
    );
  }
}

class ModuleLauncherScreen extends StatefulWidget {
  const ModuleLauncherScreen({super.key});

  // Konfigurasi batas modul aktif perkuliahan (diatur oleh Dosen Pengampu)
  // Mahasiswa hanya dapat mengakses modul dengan nomor <= activeModuleUntil
  static const int activeModuleUntil = 1; // Saat ini: Minggu ke-1 (Hanya Modul 01 terbuka)

  // Token akses kelas untuk membuka modul saat praktikum di lab
  static const Map<int, String> modulePasscodes = {
    2: 'TRPL-M02',
    3: 'TRPL-M03',
    4: 'TRPL-M04',
    5: 'TRPL-M05',
    6: 'TRPL-M06',
    7: 'TRPL-M07',
  };
  static const String masterPasscode = 'POLIWANGI2026';

  @override
  State<ModuleLauncherScreen> createState() => _ModuleLauncherScreenState();
}

class _ModuleLauncherScreenState extends State<ModuleLauncherScreen> {
  // Menyimpan daftar modul yang telah di-unlock via token kelas selama sesi berjalan
  final Set<int> _unlockedModules = {};

  bool _isModuleUnlocked(int moduleNumber) {
    return moduleNumber <= ModuleLauncherScreen.activeModuleUntil ||
        _unlockedModules.contains(moduleNumber);
  }

  void _showUnlockDialog(BuildContext context, {int? targetModule, String? title}) {
    final controller = TextEditingController();
    final isSingleModule = targetModule != null;

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Row(
          children: [
            const Icon(Icons.vpn_key_rounded, color: Color(0xFF0284C7)),
            const SizedBox(width: 8),
            Text(isSingleModule ? 'Buka Modul #0$targetModule' : 'Akses Dosen / Token Kelas'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isSingleModule
                  ? 'Materi "$title" dijadwalkan untuk perkuliahan Minggu ke-$targetModule.'
                  : 'Masukkan Token Kelas harian untuk membuka modul tertentu, atau Master Passcode Dosen untuk membuka seluruh modul perkuliahan.',
              style: const TextStyle(fontSize: 13, color: Color(0xFF475569)),
            ),
            const SizedBox(height: 12),
            const Text(
              'Masukkan Kode Token:',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF1E293B)),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: controller,
              autofocus: true,
              textCapitalization: TextCapitalization.characters,
              decoration: InputDecoration(
                hintText: isSingleModule ? 'Contoh: TRPL-M0$targetModule' : 'Contoh: POLIWANGI2026',
                border: const OutlineInputBorder(),
                isDense: true,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () {
              final input = controller.text.trim().toUpperCase();

              // 1. Cek Master Passcode (Membuka Seluruh 16 Modul untuk Dosen)
              if (input == ModuleLauncherScreen.masterPasscode) {
                setState(() {
                  _unlockedModules.addAll(List.generate(16, (i) => i + 1));
                });
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('👨‍🏫 Mode Dosen Aktif: Seluruh modul (01–16) berhasil dibuka!'),
                    backgroundColor: Color(0xFF059669),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
                return;
              }

              // 2. Cek Token Spesifik Modul
              if (isSingleModule) {
                final validPasscode = ModuleLauncherScreen.modulePasscodes[targetModule];
                if (input == validPasscode) {
                  setState(() {
                    _unlockedModules.add(targetModule);
                  });
                  Navigator.pop(ctx);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Modul #0$targetModule berhasil dibuka!'),
                      backgroundColor: const Color(0xFF059669),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                  return;
                }
              } else {
                // Cek jika mencocokkan salah satu token modul
                for (final entry in ModuleLauncherScreen.modulePasscodes.entries) {
                  if (input == entry.value) {
                    setState(() {
                      _unlockedModules.add(entry.key);
                    });
                    Navigator.pop(ctx);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Modul #0${entry.key} berhasil dibuka!'),
                        backgroundColor: const Color(0xFF059669),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                    return;
                  }
                }
              }

              // Jika salah
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Token akses salah. Silakan tanyakan kepada dosen di kelas.'),
                  backgroundColor: Colors.redAccent,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            child: const Text('Buka Akses'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text(
          'Poliwangi Mobile Codelabs',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF0284C7),
        foregroundColor: Colors.white,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.vpn_key_rounded),
            tooltip: 'Akses Dosen / Buka Token Kelas',
            onPressed: () => _showUnlockDialog(context),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Banner info status perkuliahan
          Container(
            padding: const EdgeInsets.all(14),
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: const Color(0xFFE0F2FE),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFBAE6FD)),
            ),
            child: Row(
              children: [
                const Icon(Icons.info_outline, color: Color(0xFF0284C7), size: 20),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    _unlockedModules.length >= 10
                        ? '👨‍🏫 Mode Dosen Aktif: Seluruh 16 modul terbuka untuk ditinjau.'
                        : 'Perkuliahan Aktif: Minggu ke-${ModuleLauncherScreen.activeModuleUntil} (Modul 01 Terbuka). Modul lanjutan dibuka bertahap sesuai jadwal dosen.',
                    style: const TextStyle(color: Color(0xFF0369A1), fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),

          // Section 1: Fondasi Flutter (Modul 01–07)
          _buildSectionHeader('Fase 1: Fondasi & Core Architecture (Minggu 1–7)'),
          _buildModuleCard(
            moduleNumber: 1,
            title: 'Mobile Ecosystem & Profile App',
            subtitle: 'Setup toolchain, Dart Sound Null Safety & Hot Reload',
            builder: () => const ProfileScreen(),
          ),
          const SizedBox(height: 10),
          _buildModuleCard(
            moduleNumber: 2,
            title: 'Declarative UI & Responsive Dashboard',
            subtitle: 'BoxConstraints, LayoutBuilder 1 vs 2 Kolom, Material 3',
            builder: () => const AcademicDashboardScreen(),
          ),
          const SizedBox(height: 10),
          // _buildModuleCard(
          //   moduleNumber: 3,
          //   title: 'Navigation & State Management',
          //   subtitle: 'GoRouter & Riverpod StateNotifier (KRS App)',
          //   builder: () => const Modul03App(),
          // ),
          const SizedBox(height: 10),
          // _buildModuleCard(
          //   moduleNumber: 4,
          //   title: 'Networking & REST API',
          //   subtitle: 'Dio Client, Repository Pattern & 4-State UI',
          //   builder: () => const Modul04App(),
          // ),
          const SizedBox(height: 10),
          _buildModuleCard(
            moduleNumber: 5,
            title: 'Local Storage & Offline-First Strategy',
            subtitle: 'SharedPreferences, Hive / SQLite, Secure Storage',
            builder: () => const _PlaceholderScreen(moduleNumber: 5, title: 'Local Storage & Offline-First Strategy'),
          ),
          const SizedBox(height: 10),
          _buildModuleCard(
            moduleNumber: 6,
            title: 'Authentication, Security & FCM',
            subtitle: 'JWT lifecycle, token refresh, dan push notification',
            builder: () => const _PlaceholderScreen(moduleNumber: 6, title: 'Authentication, Security & FCM'),
          ),
          const SizedBox(height: 10),
          _buildModuleCard(
            moduleNumber: 7,
            title: 'Clean Architecture & MVVM',
            subtitle: 'SOLID principles, Use Cases, dan get_it Dependency Injection',
            builder: () => const _PlaceholderScreen(moduleNumber: 7, title: 'Clean Architecture & MVVM'),
          ),

          const SizedBox(height: 20),
          // Section 2: Evaluasi UTS (Minggu 8)
          _buildSectionHeader('Evaluasi Tengah Semester (Minggu 8)'),
          _buildModuleCard(
            moduleNumber: 8,
            title: 'Mid Project Review (UTS)',
            subtitle: 'Live Coding UI Challenge mandiri & audit portofolio Git',
            builder: () => const _PlaceholderScreen(moduleNumber: 8, title: 'Mid Project Review (UTS)'),
          ),

          const SizedBox(height: 20),
          // Section 3: AI, Quality & Deployment (Minggu 9–15)
          _buildSectionHeader('Fase 2: AI, Testing, CI/CD & Deployment (Minggu 9–15)'),
          _buildModuleCard(
            moduleNumber: 9,
            title: 'AI-Assisted Development',
            subtitle: 'Validasi kritis output AI dan prompt engineering Flutter',
            builder: () => const _PlaceholderScreen(moduleNumber: 9, title: 'AI-Assisted Development'),
          ),
          const SizedBox(height: 10),
          _buildModuleCard(
            moduleNumber: 10,
            title: 'AI Feature Integration',
            subtitle: 'Integrasi Google Gemini API & ML Kit Text Recognition',
            builder: () => const _PlaceholderScreen(moduleNumber: 10, title: 'AI Feature Integration'),
          ),
          const SizedBox(height: 10),
          _buildModuleCard(
            moduleNumber: 11,
            title: 'Performance Optimization',
            subtitle: 'DevTools Flame Graph, deteksi jank, dan repainting',
            builder: () => const _PlaceholderScreen(moduleNumber: 11, title: 'Performance Optimization'),
          ),
          const SizedBox(height: 10),
          _buildModuleCard(
            moduleNumber: 12,
            title: 'Testing & Quality Assurance',
            subtitle: 'Unit test, WidgetTester, mocking mocktail, dan coverage',
            builder: () => const _PlaceholderScreen(moduleNumber: 12, title: 'Testing & Quality Assurance'),
          ),
          const SizedBox(height: 10),
          _buildModuleCard(
            moduleNumber: 13,
            title: 'CI/CD & Automation',
            subtitle: 'GitHub Actions workflow pipeline dan Android keystore signing',
            builder: () => const _PlaceholderScreen(moduleNumber: 13, title: 'CI/CD & Automation'),
          ),
          const SizedBox(height: 10),
          _buildModuleCard(
            moduleNumber: 14,
            title: 'Deployment & Monitoring',
            subtitle: 'Firebase App Distribution, Crashlytics, dan Play Console beta',
            builder: () => const _PlaceholderScreen(moduleNumber: 14, title: 'Deployment & Monitoring'),
          ),
          const SizedBox(height: 10),
          _buildModuleCard(
            moduleNumber: 15,
            title: 'Secure Mobile Development',
            subtitle: 'OWASP Mobile Top 10, obfuscation, dan certificate pinning',
            builder: () => const _PlaceholderScreen(moduleNumber: 15, title: 'Secure Mobile Development'),
          ),

          const SizedBox(height: 20),
          // Section 4: UAS Capstone Expo (Minggu 16)
          _buildSectionHeader('Evaluasi Akhir Semester (Minggu 16)'),
          _buildModuleCard(
            moduleNumber: 16,
            title: 'Final Capstone Expo (UAS)',
            subtitle: 'Demo live scenario test & individual code defense',
            builder: () => const _PlaceholderScreen(moduleNumber: 16, title: 'Final Capstone Expo (UAS)'),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, left: 4.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.bold,
          color: Color(0xFF64748B),
          letterSpacing: 0.3,
        ),
      ),
    );
  }

  Widget _buildModuleCard({
    required int moduleNumber,
    required String title,
    required String subtitle,
    required Widget Function() builder,
  }) {
    final unlocked = _isModuleUnlocked(moduleNumber);

    if (unlocked) {
      return _ModuleCard(
        moduleNumber: moduleNumber,
        title: title,
        subtitle: subtitle,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => builder()),
          );
        },
      );
    } else {
      return _LockedModuleCard(
        moduleNumber: moduleNumber,
        title: title,
        subtitle: subtitle,
        onTap: () => _showUnlockDialog(context, targetModule: moduleNumber, title: title),
      );
    }
  }
}

class _ModuleCard extends StatelessWidget {
  final int moduleNumber;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _ModuleCard({
    required this.moduleNumber,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: CircleAvatar(
          backgroundColor: const Color(0xFF0284C7),
          foregroundColor: Colors.white,
          child: Text('#$moduleNumber', style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
        subtitle: Text(subtitle, style: const TextStyle(color: Color(0xFF64748B), fontSize: 12)),
        trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
        onTap: onTap,
      ),
    );
  }
}

class _LockedModuleCard extends StatelessWidget {
  final int moduleNumber;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _LockedModuleCard({
    required this.moduleNumber,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: const Color(0xFFF1F5F9),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: CircleAvatar(
          backgroundColor: const Color(0xFF94A3B8),
          foregroundColor: Colors.white,
          child: Text('#$moduleNumber'),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF64748B), fontSize: 15),
        ),
        subtitle: Text(
          'Terkunci • Menunggu sesi perkuliahan Minggu ke-$moduleNumber',
          style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 12),
        ),
        trailing: const Icon(Icons.lock_rounded, color: Color(0xFF94A3B8)),
        onTap: onTap,
      ),
    );
  }
}

class _PlaceholderScreen extends StatelessWidget {
  final int moduleNumber;
  final String title;

  const _PlaceholderScreen({
    required this.moduleNumber,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Modul #$moduleNumber: $title'),
        backgroundColor: const Color(0xFF0284C7),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.construction_rounded, size: 64, color: Color(0xFF0284C7)),
              const SizedBox(height: 16),
              Text(
                'Modul #$moduleNumber Segera Hadir',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                'Materi "$title" sedang dalam tahap penyiapan aktif untuk jadwal perkuliahan Minggu ke-$moduleNumber oleh Dosen Pengampu.',
                textAlign: TextAlign.center,
                style: const TextStyle(color: Color(0xFF64748B), fontSize: 13),
              ),
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back),
                label: const Text('Kembali ke Menu Utama'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}