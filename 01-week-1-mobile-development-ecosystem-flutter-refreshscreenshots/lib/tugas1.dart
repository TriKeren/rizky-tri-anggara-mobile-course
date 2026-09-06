double HitungLuasPersegiPanjang(double panjang, double lebar) {
  return panjang * lebar;
}

void proses() {
  double panjang = 7.0;
  double lebar = 5.0;

  double luas = HitungLuasPersegiPanjang(panjang, lebar);

  print('Luas Persegi Panjang dengan panjang ${panjang} dan lebar ${lebar} adalah ${luas.toStringAsFixed(2)} cm²');
}