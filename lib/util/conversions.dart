String covertGramsIntoPounds(int grams) {
  return (grams / 10 * 2.2046).toStringAsFixed(1);
}

String covertMetresIntoFeet(int metre) {
  return (metre / 10 * 3.28084).toStringAsFixed(1);
}
