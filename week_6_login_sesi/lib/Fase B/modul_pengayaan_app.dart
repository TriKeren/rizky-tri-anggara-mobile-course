GerbangSesi(
  controller: _kendali,
  form: (BuildContext context) =>
      LoginPengayaanScreen(controller: _kendali),
  beranda: (BuildContext context, SesiPengguna sesi) =>
      BerandaPengayaanScreen(controller: _kendali, sesi: sesi),
)