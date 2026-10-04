import 'package:flutter/material.dart';
import 'package:week_4_future_and_rest_api/screens/announcement_list_screen.dart';
import 'services/announcement_api.dart';

const bool kModeSimulasi = bool.fromEnvironment("SIMULASI");

void main(List<String> args) {
  runApp(const MyApp());  
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Modul 04 - Future & REST API Dasar',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF02847C)),
        useMaterial3: true,
      ),
      home: AnnouncementListScreen(
        api: AnnouncementApi(modeSimulasi: kModeSimulasi),
      ),
    );
  }
}