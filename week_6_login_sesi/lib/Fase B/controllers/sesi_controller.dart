enum StatusSesi { memeriksa, keluar, memproses, masuk, gagal, kedaluwarsa }

Future<void> pulihkan() async {
  _ubah(StatusSesi.memeriksa, bersihkanPesan: true);

  final SesiPengguna? tersimpan = await repository.baca();
  if (tersimpan == null) {
    _ubah(StatusSesi.keluar, sesi: null);
    return;
  }

  if (tersimpan.sudahKedaluwarsa(jam())) {
    await repository.hapus();   // Sesi mati dibuang, bukan dibiarkan.
    _sesi = null;
    _ubah(StatusSesi.kedaluwarsa,
        pesan: 'Sesi Anda sudah berakhir. Silakan masuk kembali.');
    return;
  }

  _ubah(StatusSesi.masuk, sesi: tersimpan);
}

Future<void> perbaruiSesi({Duration masaBerlaku = const Duration(hours: 2)}) async {
  final SesiPengguna? sekarang = _sesi;
  if (sekarang == null) return;

  if (sekarang.sudahKedaluwarsa(jam())) {
    await repository.hapus();
    _sesi = null;
    _ubah(StatusSesi.kedaluwarsa,
        pesan: 'Sesi sudah berakhir dan tidak dapat diperbarui.');
    return;
  }

  final SesiPengguna baru =
      await api.perbaruiSesi(sekarang, masaBerlaku: masaBerlaku);
  await repository.simpan(baru);
  _ubah(StatusSesi.masuk, sesi: baru);
}