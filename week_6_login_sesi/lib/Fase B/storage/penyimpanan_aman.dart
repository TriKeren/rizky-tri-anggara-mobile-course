abstract class PenyimpananAman {
  Future<void> tulis(String kunci, String nilai);
  Future<String?> baca(String kunci);
  Future<void> hapus(String kunci);

  /// Antarmuka demo untuk membandingkan kemampuan adapter; bukan alat forensik.
  Future<String?> bacaMentah(String kunci);
}
@override
Future<String?> bacaMentah(String kunci) async {
  // Ilustrasi batas API: plugin tidak menyediakan pembacaan mentah
  // melalui kontrak ini. Ini bukan pemeriksaan forensik isi disk.
  return null;
}

abstract class SesiRepository {
  String get nama;
  String get keterangan;
  bool get bertahanSetelahRestart;

  Future<SesiPengguna?> baca();
  Future<void> simpan(SesiPengguna sesi);
  Future<void> hapus();
  Future<bool> adaSesi();

  /// Nilai ini adalah demonstrasi batas API, bukan pemeriksaan isi disk.
  Future<String?> intipMentah();
}