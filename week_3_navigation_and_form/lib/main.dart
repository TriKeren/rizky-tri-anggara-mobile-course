import 'package:flutter/material.dart';
// import 'package:week_3_navigation_and_form/pages/home_page.dart';
import 'package:week_3_navigation_and_form/studi_kasus/home_stud.dart';
// import 'package:flutter/cupertino.dart'; //ini buat UI MacOS

void main() {
  runApp(const WisataKampus());
}

class WisataKampus extends StatelessWidget {
  const WisataKampus({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Belajar Navigator',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: HomeStud(),
    );
  }
}