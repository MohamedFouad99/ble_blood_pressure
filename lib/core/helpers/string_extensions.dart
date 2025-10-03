// date: 8 May 2025
// by: Fouad
// last modified at: 8 May 2025
// description: This file contains extension methods for the String class.
extension StringBeautifier on String {
  String beautify() {
    return split('-').map((e) => e[0].toUpperCase() + e.substring(1)).join(' ');
  }
}
