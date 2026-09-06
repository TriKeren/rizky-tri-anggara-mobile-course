class Profil {
  String nama;
  String nim;
  String? email;

  Profil({
    required this.nama,
    required this.nim,
    this.email,
  });

  void TampilkanInfo() {
    print('[$nim] $nama | Email : ${email ?? "(Belum ada Email)"}');
  }
}

void proses() {
  Profil profil1 = Profil(
    nama: "Rizky Tri Anggara", 
    nim: "362558302096", 
    email: "tri@poliwangi.ac.id",
    );

  Profil profil2 = Profil(
    nama: "Anggara Tri", 
    nim: "#62556302065",
    );

    profil1.TampilkanInfo();
    profil2.TampilkanInfo();
}