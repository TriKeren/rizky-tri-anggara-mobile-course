// Model data untuk pengumuman akademik
class Announcement {
  final int id;
  final String title;
  final String content;
  final String author;
  final String category; // 'Akademik', 'Beasiswa', 'Kegiatan', 'Prestasi'
  final String date;
  final int readCount;

  const Announcement({
    required this.id,
    required this.title,
    required this.content,
    required this.author,
    required this.category,
    required this.date,
    this.readCount = 0,
  });

  // Factory constructor untuk deserialisasi data JSON dari REST API
  factory Announcement.fromJson(Map<String, dynamic> json) {
    return Announcement(
      id: json['id'] is int ? json['id'] as int : int.tryParse(json['id'].toString()) ?? 0,
      title: json['title'] as String? ?? 'Tanpa Judul',
      content: json['content'] as String? ?? json['body'] as String? ?? '',
      author: json['author'] as String? ?? 'Admin Jurusan',
      category: json['category'] as String? ?? 'Akademik',
      date: json['date'] as String? ?? '2026-09-01',
      readCount: json['readCount'] is int ? json['readCount'] as int : 0,
    );
  }

  // Konversi objek model ke format Map/JSON untuk request HTTP (POST/PUT)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'author': author,
      'category': category,
      'date': date,
      'readCount': readCount,
    };
  }

  // Data dummy tiruan untuk fallback saat offline atau uji coba lokal
  static List<Announcement> getSampleAnnouncements() {
    return const [
      Announcement(
        id: 1,
        title: 'Jadwal Pengisian KRS Semester Ganjil 2026/2027',
        content: 'Pengisian Kartu Rencana Studi (KRS) untuk mahasiswa tingkat 3 Sarjana Terapan TRPL dimulai tanggal 1 hingga 7 September 2026. Pastikan telah menyelesaikan bimbingan dosen wali.',
        author: 'Bagian Akademik Poliwangi',
        category: 'Akademik',
        date: '2026-09-01',
        readCount: 142,
      ),
      Announcement(
        id: 2,
        title: 'Pendaftaran Program Magang Industri Bersertifikat Batch 7',
        content: 'Kesempatan magang 6 bulan di perusahaan teknologi mitra jurusan. Mahasiswa semester 5 yang memenuhi syarat IPK minimal 3.00 dapat mengunggah portofolio GitHub.',
        author: 'Koordinator Magang TRPL',
        category: 'Kegiatan',
        date: '2026-09-02',
        readCount: 89,
      ),
      Announcement(
        id: 3,
        title: 'Sosialisasi Beasiswa Unggulan & Bantuan UKT 2026',
        content: 'Informasi persyaratan beasiswa prestasi akademik dan bantuan dana pendidikan semester 5. Berkas administrasi diserahkan ke sekretariat jurusan sebelum 15 September.',
        author: 'Kemahasiswaan Poliwangi',
        category: 'Beasiswa',
        date: '2026-08-28',
        readCount: 215,
      ),
      Announcement(
        id: 4,
        title: 'Tim Mahasiswa TRPL Juara 1 Hackathon Nasional Mobile Dev',
        content: 'Selamat kepada tim mahasiswa TRPL angkatan 2024 yang berhasil meraih peringkat pertama dalam kompetisi nasional pengembangan aplikasi berbasis Flutter.',
        author: 'Himpunan Mahasiswa TI',
        category: 'Prestasi',
        date: '2026-08-25',
        readCount: 304,
      ),
    ];
  }
}