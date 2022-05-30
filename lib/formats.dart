mixin Formats {
  String moneyFormat(String price) {
    if (price.length > 2) {
      price = price.replaceAll(RegExp(r'\D'), '');
      price = price.replaceAll(RegExp(r'\B(?=(\d{3})+(?!\d))'), ',');
    }
    return "$price \$";
  }
}
