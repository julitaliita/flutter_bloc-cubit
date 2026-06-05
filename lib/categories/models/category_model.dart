class CategoryModel {
  final int id;
  final String documentId;
  final String name;
  final String description;
  final String? createdAt;
  final String? updatedAt;
  final String? publishedAt;

  CategoryModel({
    required this.id,
    required this.documentId,
    required this.name,
    required this.description,
    this.createdAt,
    this.updatedAt,
    this.publishedAt,
  });

  factory CategoryModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return CategoryModel(
      id: json['id'],
      documentId:
          json['documentId'] ?? '',
      name: json['name'] ?? '',
      description:
          json['description'] ?? '',
      createdAt:
          json['createdAt'],
      updatedAt:
          json['updatedAt'],
      publishedAt:
          json['publishedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description':
          description,
    };
  }
}