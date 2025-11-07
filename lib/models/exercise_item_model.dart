class ExerciseItemModel {
  final String id;
  final String name;
  final String duration; // "15 lần" hoặc "05:00"
  final String imageUrl;

  ExerciseItemModel({
    required this.id,
    required this.name,
    required this.duration,
    required this.imageUrl,
  });
}