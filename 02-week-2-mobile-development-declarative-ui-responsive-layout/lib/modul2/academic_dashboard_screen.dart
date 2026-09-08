import 'package:flutter/material.dart';
import 'models/course.dart';
import 'widgets/course_card.dart';
import 'widgets/header_banner.dart';

class AcademicDashboardScreen extends StatefulWidget {
  const AcademicDashboardScreen({super.key});

  @override
  State<AcademicDashboardScreen> createState() =>
      _AcademicDashboardScreenState();
}

class _AcademicDashboardScreenState extends State<AcademicDashboardScreen> {
  final List<Course> _courses = Course.getSampleCourses();
  bool _isDarkMode = false;
  String _selectedCategory = 'Semua';

  void _toggleDarkMode() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Menampilkan Data
    final filteredCourses = _selectedCategory == 'Semua'
        ? _courses
        : _courses.where((course) => course == _selectedCategory).toList();

    return Theme(
      data: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0284C7),
          brightness: _isDarkMode ? Brightness.dark : Brightness.light,
        ),
        useMaterial3: true,
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Dashboard Akademik TRPL',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: const Color(0xFF0284C7),
          foregroundColor: Colors.white,
          actions: [
            IconButton(
              icon: Icon(
                _isDarkMode
                    ? Icons.light_mode_rounded
                    : Icons.dark_mode_rounded,
              ),
              tooltip: _isDarkMode ? 'Mode Terang' : 'Mode Gelap',
              onPressed: _toggleDarkMode,
            ),
          ],
        ),
        // Responsif
        body: LayoutBuilder(
          builder: (context, constraints) {
            // Tablet / Web / Landscape menggunakan 2 kolom
            if (constraints.maxWidth >= 600) {
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // banner profil (const dihapus, courses diisi _courses)
                    // KODE BARU
                    Expanded(
                      flex: 2,
                      child: SizedBox(
                        height:
                            250, // <-- Atur tingginya di sini (coba ubah jadi 200, 250, atau 300 sesuai selera)
                        child: HeaderBanner(courses: _courses),
                      ),
                    ),
                    const SizedBox(width: 20),

                    // grid 2 kolom daftar mata kuliah
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Filter kategori
                          Wrap(
                            spacing: 8.0,
                            children: ['Semua', 'Teori', 'Praktikum'].map((
                              category,
                            ) {
                              return ChoiceChip(
                                label: Text(category),
                                selected: _selectedCategory == category,
                                onSelected: (selected) {
                                  if (selected) {
                                    setState(() {
                                      _selectedCategory = category;
                                    });
                                  }
                                },
                              );
                            }).toList(),
                          ),
                          const SizedBox(height: 16),
                          Expanded(
                            child: GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 16,
                                    mainAxisSpacing: 16,
                                    childAspectRatio: 1.4,
                                  ),
                              itemCount: filteredCourses.length,
                              itemBuilder: (context, index) {
                                return CourseCard(
                                  course: filteredCourses[index],
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }

            // tata letak 1 kolom vertikal
            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // PERBAIKAN: Hapus const, isi dengan _courses
                HeaderBanner(courses: _courses),
                const SizedBox(height: 16),

                // PERBAIKAN: Teks jumlah menyesuaikan data yang difilter
                Text(
                  'Mata Kuliah Semester 5 (${filteredCourses.length} Terdaftar)',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),

                // Filter Kategori (Mobile)
                Wrap(
                  spacing: 8.0,
                  children: ['Semua', 'Teori', 'Praktikum'].map((category) {
                    return ChoiceChip(
                      label: Text(category),
                      selected: _selectedCategory == category,
                      onSelected: (selected) {
                        if (selected) {
                          setState(() {
                            _selectedCategory = category;
                          });
                        }
                      },
                    );
                  }).toList(),
                ),

                // PERBAIKAN: Gunakan filteredCourses di sini
                ...filteredCourses.map((course) => CourseCard(course: course)),
              ],
            );
          },
        ),
      ),
    );
  }
}
