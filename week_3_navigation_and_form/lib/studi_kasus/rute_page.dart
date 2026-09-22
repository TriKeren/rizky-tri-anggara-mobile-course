import 'package:flutter/material.dart';
import 'package:week_3_navigation_and_form/studi_kasus/succes_rute.dart';

class RutePage extends StatelessWidget {
  const RutePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Petunjuk Rute',
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 180,
              decoration: BoxDecoration(
                color: const Color(0xFFEAF5F1),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const Icon(
                    Icons.alt_route,
                    size: 100,
                    color: Color(0xFF087FF5),
                  ),

                  Positioned(
                    top: 25,
                    right: 40,
                    child: Icon(
                      Icons.location_on,
                      size: 45,
                      color: Colors.red.shade400,
                    ),
                  ),

                  Positioned(
                    bottom: 25,
                    left: 40,
                    child: Icon(
                      Icons.location_on,
                      size: 40,
                      color: Colors.blue.shade600,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            const Text(
              'Ikuti jalur ini untuk\nmenuju Taman Kampus.',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF102A56),
              ),
            ),

            const SizedBox(height: 18),

            _RouteStep(
              number: '1',
              text: 'Dari gerbang utama, lurus 100 m.',
            ),

            const SizedBox(height: 12),

            _RouteStep(
              number: '2',
              text: 'Belok kanan di Gedung A.',
            ),

            const SizedBox(height: 12),

            _RouteStep(
              number: '3',
              text: 'Taman Kampus ada di sebelah kiri.',
            ),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SuccessPage(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF087FF5),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Selesai',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RouteStep extends StatelessWidget {
  final String number;
  final String text;

  const _RouteStep({
    required this.number,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 32,
          height: 32,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: Color(0xFF4EA1F7),
            shape: BoxShape.circle,
          ),
          child: Text(
            number,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        const SizedBox(width: 12),

        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF44546A),
            ),
          ),
        ),
      ],
    );
  }
}