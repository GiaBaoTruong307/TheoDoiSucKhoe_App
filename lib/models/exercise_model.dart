import 'exercise_item_model.dart';

class ExerciseModel {
  final String id;
  final String title;
  final int exercises;
  final int minutes;
  final int calories;
  final String imageUrl;
  final List<String> equipment;
  final List<ExerciseItemModel> sets;

  ExerciseModel({
    required this.id,
    required this.title,
    required this.exercises,
    required this.minutes,
    required this.calories,
    required this.imageUrl,
    required this.equipment,
    required this.sets,
  });
}