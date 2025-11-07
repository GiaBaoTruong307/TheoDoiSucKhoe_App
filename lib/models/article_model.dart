class ArticleModel {
  final String id;
  final String title;
  final String author;
  final String authorAvatar;
  final String imageUrl;
  final String category;
  final String timeAgo;
  final int views;
  final bool isFeatured;
  final String? description;

  ArticleModel({
    required this.id,
    required this.title,
    required this.author,
    required this.authorAvatar,
    required this.imageUrl,
    required this.category,
    required this.timeAgo,
    required this.views,
    this.isFeatured = false,
    this.description,
  });
}