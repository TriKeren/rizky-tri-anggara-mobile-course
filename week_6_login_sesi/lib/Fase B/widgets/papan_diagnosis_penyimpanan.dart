Future<void> _intip() async {
  setState(() => _sedangMengintip = true);
  final String? hasil = await widget.repository.intipMentah();
  if (!mounted) return;
  setState(() {
    _hasilIntip = hasil;
    _sudahMengintip = true;
    _sedangMengintip = false;
  });
}