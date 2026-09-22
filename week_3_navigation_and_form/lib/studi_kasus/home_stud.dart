import 'package:flutter/material.dart';
import 'package:week_3_navigation_and_form/studi_kasus/detail_lokasi.dart';

class HomeStud extends StatelessWidget {
  const HomeStud({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Wisata Kampus',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF087FF5),
        foregroundColor: Colors.white,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 180,
              decoration: BoxDecoration(
                color: const Color(0xFFEAF5FF),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(
                Icons.account_balance,
                size: 100,
                color: Color(0xFF087FF5),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Selamat Datang!',
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color: Color(0xFF102A56),
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Temukan tempat menarik\ndi kampus kami.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF44546A),
              ),
            ),

            const SizedBox(height: 25),

            // Taman Kampus
            _DestinationCard(
              icon: Icons.park,
              title: 'Taman Kampus',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailLokasi(),
                  ),
                );
              },
            ),

            const SizedBox(height: 12),

            // Perpustakaan
            _DestinationCard(
              icon: Icons.local_library,
              title: 'Perpustakaan',
              onTap: () {
              },
            ),

            const SizedBox(height: 12),

            // Laboratorium
            _DestinationCard(
              icon: Icons.groups,
              title: 'Laboratorium',
              onTap: () {
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _DestinationCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _DestinationCard({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFFF5F9FD),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: const Color(0xFFE4F1FF),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: const Color(0xFF087FF5),
                size: 28,
              ),
            ),

            const SizedBox(width: 15),

            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF142A4A),
                ),
              ),
            ),

            const Icon(
              Icons.chevron_right,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}