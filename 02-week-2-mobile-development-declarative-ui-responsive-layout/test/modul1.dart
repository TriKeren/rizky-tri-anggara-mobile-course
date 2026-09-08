import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prak_awal_mobile/modul1/Profile_Screen.dart';

void main() {
  group('Modul 01 Autograding: Flutter Setup & Profile App', () {
    testWidgets('1. ProfileScreen memuat AppBar dengan judul yang tepat', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: ProfileScreen()),
      );

      // Verifikasi AppBar dan Judul
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.textContaining('Profil Mahasiswa'), findsOneWidget);
    });

    testWidgets('2. ProfileScreen menampilkan Avatar Mahasiswa dan Card Informasi', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: ProfileScreen()),
      );

      // Verifikasi Avatar Icon
      expect(find.byIcon(Icons.school_rounded), findsOneWidget);

      // Verifikasi Card dan Informasi Pokok Mahasiswa
      expect(find.byType(Card), findsAtLeastNWidgets(1));
      expect(find.text('Jurusan / Kampus'), findsOneWidget);
      expect(find.text('Program Studi'), findsOneWidget);
      expect(find.text('Semester & Angkatan'), findsOneWidget);
    });

    testWidgets('3. Tombol verifikasi status berfungsi dan menampilkan SnackBar', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: ProfileScreen()),
      );

      // Temukan tombol aksi verifikasi
      final buttonFinder = find.byType(ElevatedButton);
      expect(buttonFinder, findsOneWidget);

      // Tekan tombol verifikasi
      await tester.tap(buttonFinder);
      await tester.pump(); // Memicu animasi munculnya SnackBar

      // Verifikasi SnackBar muncul di layar
      expect(find.byType(SnackBar), findsOneWidget);
    });
  });
}