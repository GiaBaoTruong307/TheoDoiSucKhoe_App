import 'package:flutter/material.dart';
import '../../models/goal_model.dart';
import 'goals_screen.dart';

class AddGoalScreen extends StatefulWidget {
  const AddGoalScreen({Key? key}) : super(key: key);

  @override
  State<AddGoalScreen> createState() => _AddGoalScreenState();
}

class _AddGoalScreenState extends State<AddGoalScreen> {
  final Map<String, double> _goalValues = {
    'water': 2000,
    'steps': 5000,
    'sleep': 8,
  };

  final Map<String, List<double>> _valueOptions = {
    'water': [1000, 1500, 2000, 2500, 3000, 3500, 4000],
    'steps': [3000, 4000, 5000, 6000, 7000, 8000, 10000],
    'sleep': [6, 6.5, 7, 7.5, 8, 8.5, 9],
  };

  int _selectedDay = 14;
  final List<int> _daysWithGoals = [15, 16, 17]; // Những ngày đã set mục tiêu

  void _showValuePicker(String type) {
    final options = _valueOptions[type]!;
    final currentValue = _goalValues[type]!;
    final currentIndex = options.indexOf(currentValue);

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          height: 300,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey.shade200),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Hủy'),
                    ),
                    const Text(
                      'Chọn mục tiêu',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Xong'),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListWheelScrollView.useDelegate(
                  itemExtent: 50,
                  diameterRatio: 1.5,
                  physics: const FixedExtentScrollPhysics(),
                  controller: FixedExtentScrollController(
                    initialItem: currentIndex >= 0 ? currentIndex : 0,
                  ),
                  onSelectedItemChanged: (index) {
                    setState(() {
                      _goalValues[type] = options[index];
                    });
                  },
                  childDelegate: ListWheelChildBuilderDelegate(
                    childCount: options.length,
                    builder: (context, index) {
                      final value = options[index];
                      String displayValue;
                      if (type == 'water') {
                        displayValue = '${value.toInt()} ml';
                      } else if (type == 'steps') {
                        displayValue = '${value.toInt()} km';
                      } else {
                        displayValue = '${value.toStringAsFixed(value == value.toInt() ? 0 : 1)} giờ';
                      }

                      return Center(
                        child: Text(
                          displayValue,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _saveGoal() {
    // Navigate sang GoalsScreen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const GoalsScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(20),
              color: Colors.white,
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.pink.shade50,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.person,
                          color: Colors.pink.shade300,
                          size: 28,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Thiên Vi',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            Text(
                              'Mục tiêu hằng ngày',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const SizedBox(width: 100),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: const Color(0xFFFFD54F), width: 2),
                          ),
                          child: const Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Dựa trên BMI của bạn, mục tiêu bước chân hôm nay nên là 5000 bước 💪',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.black87,
                                    height: 1.4,
                                  ),
                                ),
                              ),
                              SizedBox(width: 6),
                              Text('✨', style: TextStyle(fontSize: 22)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Content
            Expanded(
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  SingleChildScrollView(
                    padding: EdgeInsets.zero,
                    child: Column(
                      children: [
                        const SizedBox(height: 60),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE3F2FD),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Mục tiêu của bạn',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    Text(
                                      'T10.2025',
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.blue.shade600,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                _buildCalendar(),
                                const SizedBox(height: 24),
                                _buildCompactGoalItem(
                                  imagePath: 'assets/images/water_2.png',
                                  title: 'Uống nước',
                                  value: _goalValues['water']!,
                                  unit: 'ml',
                                  type: 'water',
                                ),
                                const SizedBox(height: 16),
                                _buildCompactGoalItem(
                                  imagePath: 'assets/images/foot_1.png',
                                  title: 'Bước chân',
                                  value: _goalValues['steps']!,
                                  unit: 'km',
                                  type: 'steps',
                                ),
                                const SizedBox(height: 16),
                                _buildCompactGoalItem(
                                  imagePath: 'assets/images/sleep_icon.png',
                                  title: 'Giấc ngủ',
                                  value: _goalValues['sleep']!,
                                  unit: 'giờ',
                                  type: 'sleep',
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: SizedBox(
                            width: double.infinity,
                            height: 56,
                            child: ElevatedButton(
                              onPressed: _saveGoal,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF29B6F6),
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                elevation: 0,
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Chỉnh sửa mục tiêu',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Icon(Icons.edit, size: 20),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                      ],
                    ),
                  ),
                  Positioned(
                    left: 20,
                    top: -50,
                    child: Image.asset(
                      'assets/images/onboarding2.png',
                      width: 120,
                      height: 120,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            color: const Color(0xFF4FC3F7).withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Center(
                            child: Text('💧', style: TextStyle(fontSize: 50)),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCalendar() {
    final days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    final dates = [14, 15, 16, 17, 18, 19, 20];

    return Column(
      children: [
        // Tên các ngày
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: days.map((day) {
            return SizedBox(
              width: 44,
              child: Text(
                day,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 12),
        // Các ngày với trạng thái
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: dates.map((date) {
            final isSelected = date == _selectedDay;
            final hasGoal = _daysWithGoals.contains(date);
            final noGoal = !isSelected && !hasGoal;

            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedDay = date;
                });
              },
              child: Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0xFF2196F3)
                      : hasGoal
                      ? const Color(0xFFF5F5F5)
                      : const Color(0xFFE0E0E0),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Stack(
                  children: [
                    Center(
                      child: Text(
                        '$date',
                        style: TextStyle(
                          fontSize: 16,
                          color: isSelected
                              ? Colors.white
                              : noGoal
                              ? Colors.grey.shade600
                              : Colors.black87,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    if (hasGoal && !isSelected)
                      Positioned(
                        bottom: 8,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: Container(
                            width: 20,
                            height: 2,
                            decoration: BoxDecoration(
                              color: const Color(0xFF2196F3),
                              borderRadius: BorderRadius.circular(1),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildCompactGoalItem({
    required String imagePath,
    required String title,
    required double value,
    required String unit,
    required String type,
  }) {
    String displayValue;
    if (unit == 'ml') {
      displayValue = '${value.toInt()} $unit';
    } else if (unit == 'km') {
      displayValue = '${value.toInt()} $unit';
    } else {
      displayValue = '${value.toStringAsFixed(value == value.toInt() ? 0 : 1)} $unit';
    }

    return Row(
      children: [
        Image.asset(
          imagePath,
          width: 56,
          height: 56,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: const Color(0xFF4FC3F7).withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.image, size: 28),
            );
          },
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ),
        GestureDetector(
          onTap: () => _showValuePicker(type),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  displayValue,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(width: 4),
                const Icon(Icons.keyboard_arrow_down, size: 16, color: Colors.black54),
              ],
            ),
          ),
        ),
      ],
    );
  }
}