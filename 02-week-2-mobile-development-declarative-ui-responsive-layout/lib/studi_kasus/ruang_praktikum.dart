import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class RuangPraktikum extends StatefulWidget {
  const RuangPraktikum({super.key});

  @override
  State<RuangPraktikum> createState() => _RuangPraktikumState();
}

class _RuangPraktikumState extends State<RuangPraktikum> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0284C7)),
      ),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // JUDUL
                const Text(
                  'Ruang Praktikum Hari Ini',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF101A34),
                  ),
                ),

                const SizedBox(height: 16),

                // SUMMARY
                Wrap(
                  spacing: 12,
                  runSpacing: 8,
                  children: [
                    _buildSummary(
                      icon: Icons.calendar_month,
                      text: '3 sesi',
                      backgroundColor: const Color(0xFFE5F3FF),
                      iconColor: const Color(0xFF1688D4),
                      textColor: const Color(0xFF175A88),
                    ),

                    _buildSummary(
                      icon: Icons.meeting_room,
                      text: '1 ruang tersedia',
                      backgroundColor: const Color(0xFFE2F6EC),
                      iconColor: const Color(0xFF218B5C),
                      textColor: const Color(0xFF23704D),
                    ),
                  ],
                ),

                const SizedBox(height: 16),
                LayoutBuilder(
                  builder: (context, constraints) {
                    final cardWidth = constraints.maxWidth < 600
                        ? constraints.maxWidth
                        : (constraints.maxWidth - 14) / 2;

                    return Wrap(
                      spacing: 14,
                      runSpacing: 14,
                      children: [
                        SizedBox(
                          width: cardWidth,
                          child: _buildCourseCard(
                            title: 'Mobile Programming',
                            time: '08.00 – 10.00',
                            room: 'Lab 1',
                            status: 'Berlangsung',
                            statusColor: const Color(0xFF168BD7),
                            statusTextColor: Colors.white,
                            message: 'Sedang digunakan\noleh praktikan',
                            messageColor: const Color(0xFFE4F2FF),
                            messageIcon: Icons.groups,
                            messageIconColor: const Color(0xFF1688D4),
                          ),
                        ),

                        SizedBox(
                          width: cardWidth,
                          child: _buildCourseCard(
                            title: 'Rekayasa Perangkat Lunak',
                            time: '10.00 – 12.00',
                            room: 'Lab 2',
                            status: 'Akan datang',
                            statusColor: const Color(0xFFFFE3A7),
                            statusTextColor: const Color(0xFF8A4C00),
                            message: 'Sesi akan dimulai\nsebentar lagi',
                            messageColor: const Color(0xFFFFF5DF),
                            messageIcon: Icons.access_time,
                            messageIconColor: const Color(0xFF5E3D0B),
                          ),
                        ),

                        SizedBox(
                          width: cardWidth,
                          child: _buildCourseCard(
                            title: 'Basis Data',
                            time: '13.00 – 15.00',
                            room: 'Lab 3',
                            status: 'Selesai',
                            statusColor: const Color(0xFFE5E7EA),
                            statusTextColor: const Color(0xFF344054),
                            message: 'Sesi telah selesai',
                            messageColor: const Color(0xFFF0F3F6),
                            messageIcon: Icons.check_circle,
                            messageIconColor: const Color(0xFF344054),
                          ),
                        ),

                        SizedBox(
                          width: cardWidth,
                          child: _buildAvailableRoomCard(),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // SUMMARY
  Widget _buildSummary({
    required IconData icon,
    required String text,
    required Color backgroundColor,
    required Color iconColor,
    required Color textColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: iconColor, size: 20),

          const SizedBox(width: 8),

          Text(text, style: TextStyle(color: textColor, fontSize: 15)),
        ],
      ),
    );
  }

  Widget _buildCourseCard({
    required String title,
    required String time,
    required String room,
    required String status,
    required Color statusColor,
    required Color statusTextColor,
    required String message,
    required Color messageColor,
    required IconData messageIcon,
    required Color messageIconColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFDDE3EB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  title,
                  softWrap: true,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF101A34),
                  ),
                ),
              ),

              const SizedBox(width: 8),

              // STATUS
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  color: statusColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: statusTextColor,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),
          Row(
            children: [
              const Icon(Icons.access_time, size: 23, color: Color(0xFF344054)),

              const SizedBox(width: 10),

              Expanded(
                child: Text(
                  time,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Color(0xFF263650),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 9),
          Row(
            children: [
              const Icon(Icons.location_on, size: 23, color: Color(0xFF344054)),

              const SizedBox(width: 10),

              Expanded(
                child: Text(
                  room,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Color(0xFF263650),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: messageColor,
              borderRadius: BorderRadius.circular(12),
            ),

            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ICON
                Icon(messageIcon, size: 28, color: messageIconColor),

                const SizedBox(width: 12),

                // Expanded HANYA untuk Text
                Expanded(
                  child: Text(
                    message,
                    softWrap: true,
                    style: const TextStyle(
                      fontSize: 15,
                      height: 1.3,
                      color: Color(0xFF263650),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // AVAILABLE ROOM CARD
  Widget _buildAvailableRoomCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFF4FCF8),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFD1EADF)),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // JUDUL + STATUS
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: const Text(
                  'Lab 2',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF101A34),
                  ),
                ),
              ),

              const SizedBox(width: 8),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 13,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF269B69),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'Tersedia',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          // INFORMASI RUANG
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.meeting_room,
                size: 28,
                color: Color(0xFF344054),
              ),

              const SizedBox(width: 13),

              Expanded(
                child: const Text(
                  'Ruang tersedia\ndi luar jadwal sesi',
                  softWrap: true,
                  style: TextStyle(
                    fontSize: 15,
                    height: 1.3,
                    color: Color(0xFF263650),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // MESSAGE TERSEDIA
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFDDF4E9),
              borderRadius: BorderRadius.circular(12),
            ),

            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.meeting_room,
                  size: 28,
                  color: Color(0xFF218B5C),
                ),

                const SizedBox(width: 13),

                Expanded(
                  child: const Text(
                    'Siap digunakan\nuntuk praktikum lain',
                    softWrap: true,
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.25,
                      color: Color(0xFF315D4B),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
