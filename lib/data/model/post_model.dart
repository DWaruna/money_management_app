class PostModel {
  final int id;
  final String title;
  final String category;
  final String description;
  final double price;

  PostModel({
    required this.id,
    required this.title,
    required this.category,
    required this.description,
    required this.price,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: int.tryParse(json['id'].toString()) ?? 0,
      title: json['title'] as String,
      category: json['category'] as String,
      description: json['description'] as String,
      price: double.tryParse(json['price'].toString()) ?? 0.0,
    );
  }
}
