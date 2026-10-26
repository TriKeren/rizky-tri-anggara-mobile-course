import '../models/sesi_pengguna.dart';

/// Penyimpanan sesi di RAM saja. Data hilang saat proses aplikasi berhenti.
class SesiMemori {
  SesiPengguna? _sesi;
  int jumlahPenulisan = 0;

  SesiPengguna? baca() => _sesi;

  bool get adaSesi => _sesi != null;

  Future<void> simpan(SesiPengguna sesi) async {
    _sesi = sesi;
    jumlahPenulisan++;
  }

  Future<void> hapus() async {
    _sesi = null;
  }
}
