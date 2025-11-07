class GoalModel {
  final String id;
  final String type; // 'water', 'steps', 'sleep'
  final String title;
  final double targetValue;
  final String unit;
  final String icon;

  GoalModel({
    required this.id,
    required this.type,
    required this.title,
    required this.targetValue,
    required this.unit,
    required this.icon,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'title': title,
      'targetValue': targetValue,
      'unit': unit,
      'icon': icon,
    };
  }

  factory GoalModel.fromJson(Map<String, dynamic> json) {
    return GoalModel(
      id: json['id'],
      type: json['type'],
      title: json['title'],
      targetValue: json['targetValue'],
      unit: json['unit'],
      icon: json['icon'],
    );
  }
}