class Methods {
  static bool isNumeric(String s) {
    if (s == null) {
      return false;
    } else if (int.tryParse(s) == null) {
      return false;
    } else
      return true;
  }
}
