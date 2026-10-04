import 'package:flutter/material.dart';
import 'package:week_4_future_and_rest_api/widget/announcement_card.dart';
import '../models/announcement.dart';
import '../services/announcement_api.dart';
import 'announcement_detail_screen.dart';

class AnnouncementListScreen extends StatefulWidget {
  const AnnouncementListScreen({super.key, this.api});

  final AnnouncementApi? api;

  @override
  State<AnnouncementListScreen> createState() => _AnnouncementListScreenState();
}

class _AnnouncementListScreenState extends State<AnnouncementListScreen> {
  static const List<String> _kategori = <String>[
    'Semua',
    'Akademik',
    'Beasiswa',
    'Kegiatan',
    'Prestasi',
  ];

  late final AnnouncementApi _api = widget.api ?? AnnouncementApi();
  late Future<List<Announcement>> _futurePengumuman;
  String _kategoriTerpilih = 'Semua';

  @override
  void initState() {
    super.initState();
    // Future dibuat sekali di sini, bukan di build()
    _futurePengumuman = _api.ambilPengumuman();
  }

  @override
  void dispose() {
    _api.tutup();
    super.dispose();
  }

  Future<void> _muatUlang() async {
    final Future<List<Announcement>> futureBaru = _api.ambilPengumuman();
    setState(() {
      _futurePengumuman = futureBaru;
    });
    try {
      await futureBaru;
    } catch (_) {
      // error ditampilkan FutureBuilder lewat snapshot.hasError
    }
  }

  void _pilihKategori(String kategori) {
    if (kategori == _kategoriTerpilih) return;
    setState(() => _kategoriTerpilih = kategori);
  }

  void _bukaDetail(Announcement announcement) {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (_) => AnnouncementDetailScreen(announcement: announcement),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Portal Pengumuman TRPL'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Segarkan Data',
            onPressed: _muatUlang,
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          _buildBarisFilter(),
          const Divider(height: 1),
          Expanded(
            child: FutureBuilder<List<Announcement>>(
              future: _futurePengumuman,
              builder: (context, snapshot) {
                // urutan pemeriksaan ini tidak boleh ditukar
                if (snapshot.connectionState != ConnectionState.done) {
                  return _buildMemuat();
                }
                if (snapshot.hasError) {
                  return _buildGagal(snapshot.error!);
                }

                final List<Announcement> semua =
                    snapshot.data ?? const <Announcement>[];
                final List<Announcement> tampil = _kategoriTerpilih == 'Semua'
                    ? semua
                    : semua
                          .where(
                            (Announcement item) =>
                                item.category.toLowerCase() ==
                                _kategoriTerpilih.toLowerCase(),
                          )
                          .toList(growable: false);

                if (tampil.isEmpty) return _buildKosong();
                return _buildDaftar(tampil);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBarisFilter() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: _kategori
            .map(
              (String k) => Padding(
                padding: const EdgeInsets.only(right: 8),
                child: ChoiceChip(
                  label: Text(k),
                  selected: _kategoriTerpilih == k,
                  onSelected: (_) => _pilihKategori(k),
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildMemuat() {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text('Memuat pengumuman dari server...'),
        ],
      ),
    );
  }

  Widget _buildGagal(Object error) {
    final String pesan = error.toString().replaceFirst('Exception: ', '');
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              Icons.error_outline,
              size: 56,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 12),
            Text(
              'Gagal Memuat Data',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(pesan, textAlign: TextAlign.center),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: _muatUlang,
              icon: const Icon(Icons.refresh),
              label: const Text('Coba Lagi'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildKosong() {
    final String teks = _kategoriTerpilih == 'Semua'
        ? 'Belum ada pengumuman.'
        : 'Tidak ada pengumuman untuk kategori "$_kategoriTerpilih".';
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Icon(Icons.inbox_outlined, size: 56),
            const SizedBox(height: 12),
            Text(teks, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }

  Widget _buildDaftar(List<Announcement> items) {
    return RefreshIndicator(
      onRefresh: _muatUlang,
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(12),
        itemCount: items.length,
        itemBuilder: (context, index) => AnnouncementCard(
          announcement: items[index],
          onTap: () => _bukaDetail(items[index]),
        ),
      ),
    );
  }
}