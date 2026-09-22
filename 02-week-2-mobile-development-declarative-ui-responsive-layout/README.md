# Laporan Praktikum Modul 02: Declarative UI & Responsive Layout

- **Nama**: Rizky Tri Anggara
- **NIM**: 362558302096
- **Kelas / Prodi**: 2C / Sarjana Terapan TRPL
- **Mata Kuliah**: Pemrograman Perangkat Bergerak (Semester 3)

---

## 1. Ringkasan Implementasi
[Jelaskan bagaimana Anda merancang dashboard responsif dengan LayoutBuilder dan tema Material 3]
Dimensi layar pada modul kali ini di ukur secara statis dengan meletakkan LayoutBuilder sebagai child utama dari Scaffold. Widget ini menangkap constraints yang diturunkan oleh parent dan dikirimkan ke tata letak yang berbeda berdasarkan constraint.maxwidth.


## 2. Bukti Tangkapan Layar (Running App)
| Mode Portrait (Light) | Mode Dark Theme | Mode Landscape / Tablet (2 Kolom) |
|---|---|---|
| ![Portrait](./screenshots/running_portrait.png) | ![Dark](./screenshots/running_dark.png) | ![Wide](./screenshots/running_wide.png) |

## 3. Kendala Layout yang Dihadapi & Solusinya
- **Kendala**: [Contoh: Terjadi overflow pada nama matakuliah yang panjang]
- **Solusi**: [Contoh: Membungkus Text dengan Expanded dan menambahkan maxLines: 2 serta TextOverflow.ellipsis]

## 4. Jawaban Pertanyaan Refleksi
1. **Efisiensi Single-pass BoxConstraints**: [...]
2. **Kriteria Modularisasi Widget**: [...]
3. **Manfaat M3 ThemeData Terpusat**: [...]