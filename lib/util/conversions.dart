String convertGramsIntoPounds(int grams) {
  return (grams / 10 * 2.2046).toStringAsFixed(1);
}

String convertMetresIntoFeet(int metre) {
  return (metre / 10 * 3.28084).toStringAsFixed(1);
}
