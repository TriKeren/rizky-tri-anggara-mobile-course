@override
Future<String?> intipMentah() async {
  final SharedPreferences prefs = await _prefs;
  // Demonstrasi ini memperlihatkan bahwa adapter preferensi dapat
  // mengembalikan nilai token melalui API biasa.
  return prefs.getString(kunciSesi);
}