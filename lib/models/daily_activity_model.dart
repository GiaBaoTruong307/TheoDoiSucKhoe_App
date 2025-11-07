class DailyActivityModel {
  final DateTime date;
  final int waterIntake; // ml
  final int steps;
  final double sleepHours;

  DailyActivityModel({
    required this.date,
    required this.waterIntake,
    required this.steps,
    required this.sleepHours,
  });

  String getWeekday() {
    const weekdays = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    return weekdays[date.weekday % 7];
  }
}

class DailyGoalModel {
  final int waterGoal; // ml
  final int stepsGoal;
  final double sleepGoal; // hours

  DailyGoalModel({
    required this.waterGoal,
    required this.stepsGoal,
    required this.sleepGoal,
  });
}