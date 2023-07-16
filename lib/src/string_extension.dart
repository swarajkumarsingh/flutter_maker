extension StringExtension on String {
  String get capitalize =>
      isEmpty ? '' : '${this[0].toUpperCase()}${substring(1)}';
  String get lower =>
      isEmpty ? '' : '${this[0].toLowerCase()}${substring(1)}';
}
