class Product {
  final int id;
  final String title;
  final String thumbnail;
  final double price;
  final double discountPercentage;
  int quantity;

  Product({required this.id, required this.title, required this.thumbnail, required this.price, required this.discountPercentage, this.quantity = 0});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      thumbnail: json['thumbnail'],
      price: json['price'].toDouble(),
      discountPercentage: json['discountPercentage'].toDouble(),
    );
  }

  Product copyWith({int? quantity}) {
    return Product(
      id: id,
      title: title,
      thumbnail: thumbnail,
      price: price,
      discountPercentage: discountPercentage,
      quantity: quantity ?? this.quantity,
    );
  }
}
