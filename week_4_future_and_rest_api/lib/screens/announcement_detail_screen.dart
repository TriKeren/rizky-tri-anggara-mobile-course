import 'package:flutter/material.dart';

import '../models/announcement.dart';

class AnnouncementDetailScreen extends StatelessWidget {
  const AnnouncementDetailScreen({super.key, required this.announcement});

  final Announcement announcement;

  @override
  Widget build(BuildContext context) {
    final TextTheme teks = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Detail Pengumuman')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              announcement.title,
              style: teks.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              '${announcement.category} • ${announcement.date} • '
              '${announcement.author}',
              style: teks.bodySmall,
            ),
            const SizedBox(height: 16),
            Text(announcement.content, style: teks.bodyLarge),
            const SizedBox(height: 16),
            Text('Dibaca ${announcement.readCount} kali'),
          ],
        ),
      ),
    );
  }
}