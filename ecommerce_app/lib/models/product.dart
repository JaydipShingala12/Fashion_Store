class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final String category;
  final String gender;
  final List<String> sizes;
  final List<String> colors;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.category,
    required this.gender,
    required this.sizes,
    required this.colors,
  });
} 