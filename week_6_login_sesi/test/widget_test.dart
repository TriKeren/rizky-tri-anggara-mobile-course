import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:week_6_login_sesi/main.dart';
import 'package:week_6_login_sesi/Fase%20A/services/auth_api.dart';
import 'package:week_6_login_sesi/Fase%20A/services/sesi_memori.dart';

void main() {
  testWidgets('Validasi form login', (WidgetTester tester) async {
    await tester.pumpWidget(
      Modul06App(
        api: const AuthApi(tunda: Duration.zero),
        sesiMemori: SesiMemori(),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Masuk ke Portal Akademik'), findsOneWidget);

    // Tekan tombol masuk tanpa mengisi form.
    await tester.tap(find.text('Masuk'));
    await tester.pumpAndSettle();

    expect(find.text('Email wajib diisi.'), findsOneWidget);
  });

  testWidgets('Pengguna dapat login dan logout',
      (WidgetTester tester) async {
    final SesiMemori memori = SesiMemori();

    await tester.pumpWidget(
      Modul06App(
        api: const AuthApi(tunda: Duration.zero),
        sesiMemori: memori,
      ),
    );

    await tester.pumpAndSettle();

    final Finder fields = find.byType(TextFormField);

    await tester.enterText(fields.at(0), 'student@trpl.test');
    await tester.enterText(fields.at(1), 'belajar123');

    await tester.tap(find.text('Masuk'));
    await tester.pumpAndSettle();

    expect(find.text('Beranda'), findsOneWidget);
    expect(memori.adaSesi, isTrue);

    await tester.tap(find.text('Keluar'));
    await tester.pumpAndSettle();

    expect(find.text('Masuk ke Portal Akademik'), findsOneWidget);
    expect(memori.adaSesi, isFalse);
  });

  testWidgets('Login dengan kata sandi salah ditolak',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      Modul06App(
        api: const AuthApi(tunda: Duration.zero),
        sesiMemori: SesiMemori(),
      ),
    );

    await tester.pumpAndSettle();

    final Finder fields = find.byType(TextFormField);

    await tester.enterText(fields.at(0), 'student@trpl.test');
    await tester.enterText(fields.at(1), 'password-salah');

    await tester.tap(find.text('Masuk'));
    await tester.pumpAndSettle();

    expect(find.text('Email atau kata sandi salah.'), findsOneWidget);
  });
}