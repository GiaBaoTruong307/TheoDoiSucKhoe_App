import 'package:flutter/material.dart';
import '../../models/user_model.dart';
import '../../models/exercise_model.dart';
import '../../models/exercise_item_model.dart';
import '../../widgets/bmi_card.dart';
import '../../widgets/daily_goal_card.dart';
import '../../widgets/water_tracker_card.dart';
import '../../widgets/exercise_card.dart';
import '../notifications/notifications_screen.dart';
import '../main_wrapper.dart';
import 'exercise_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  final UserModel user;

  const HomeScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _selectedMood;

  final List<ExerciseModel> _exercises = [
    ExerciseModel(
      id: '1',
      title: 'Bài tập toàn thân',
      exercises: 11,
      minutes: 32,
      calories: 320,
      imageUrl: 'assets/images/exercise-1.png',
      equipment: ['dumbbell', 'rope', 'bottle'],
      sets: [
        ExerciseItemModel(
          id: '1',
          name: 'Khởi động',
          duration: '05:00',
          imageUrl: 'assets/images/warm-up.png',
        ),
        ExerciseItemModel(
          id: '2',
          name: 'Nhảy Jumping Jack',
          duration: '12 lần',
          imageUrl: 'assets/images/jumping-jack.png',
        ),
        ExerciseItemModel(
          id: '3',
          name: 'Nhảy dây',
          duration: '15 lần',
          imageUrl: 'assets/images/jump-rope.png',
        ),
        ExerciseItemModel(
          id: '4',
          name: 'Squat',
          duration: '20 lần',
          imageUrl: 'assets/images/squat.png',
        ),
      ],
    ),
    ExerciseModel(
      id: '2',
      title: 'Bài tập chân',
      exercises: 12,
      minutes: 40,
      calories: 280,
      imageUrl: 'assets/images/exercise-2.png',
      equipment: ['dumbbell'],
      sets: [
        ExerciseItemModel(
          id: '1',
          name: 'Squat',
          duration: '20 lần',
          imageUrl: 'assets/images/squat.png',
        ),
        ExerciseItemModel(
          id: '2',
          name: 'Lunge',
          duration: '15 lần',
          imageUrl: 'assets/images/lunge.png',
        ),
      ],
    ),
    ExerciseModel(
      id: '3',
      title: 'Bài tập cơ bụng',
      exercises: 14,
      minutes: 20,
      calories: 180,
      imageUrl: 'assets/images/exercise-3.png',
      equipment: [],
      sets: [
        ExerciseItemModel(
          id: '1',
          name: 'Plank',
          duration: '02:00',
          imageUrl: 'assets/images/plank.png',
        ),
        ExerciseItemModel(
          id: '2',
          name: 'Crunch',
          duration: '20 lần',
          imageUrl: 'assets/images/crunch.png',
        ),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Xin chào',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                      Text(
                        widget.user.name,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NotificationsScreen(),
                        ),
                      );
                    },
                    child: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.grey.shade300,
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.notifications_outlined,
                        color: Colors.black87,
                        size: 22,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Mood section
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (_selectedMood == null) {
                      _selectedMood = 'excited';
                    } else if (_selectedMood == 'excited') {
                      _selectedMood = 'anxious';
                    } else {
                      _selectedMood = 'excited';
                    }
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF00BCD4),
                        Color(0xFFFF6B9D),
                        Color(0xFFFFC107),
                        Color(0xFF4CAF50),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: _selectedMood == null
                        ? _buildInitialMood()
                        : (_selectedMood == 'excited'
                        ? _buildExcitedMood()
                        : _buildAnxiousMood()),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // BMI Card
              BMICard(
                weight: widget.user.weight,
                height: widget.user.height,
                onTap: () {
                  final mainWrapperState =
                  context.findAncestorStateOfType<MainWrapperState>();
                  mainWrapperState?.navigateToAnalysis();
                },
              ),
              const SizedBox(height: 16),

              // Daily Goal Card
              const DailyGoalCard(),
              const SizedBox(height: 16),

              // Water Tracker Card
              const WaterTrackerCard(),
              const SizedBox(height: 24),

              // Exercise Section
              const Text(
                'Hôm nay bạn muốn tập gì?',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 16),

              // Exercise Cards
              ..._exercises.map((exercise) {
                return ExerciseCard(
                  exercise: exercise,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ExerciseDetailScreen(exercise: exercise),
                      ),
                    );
                  },
                );
              }).toList(),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInitialMood() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Hôm nay bạn cảm thấy thế nào?',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    'Ghi lại tâm trạng của bạn',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF00BCD4),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'Mới',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Image.asset(
          'assets/images/emotions.png',
          width: 65,
          height: 65,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            return const Text('🤠', style: TextStyle(fontSize: 50));
          },
        ),
      ],
    );
  }

  Widget _buildExcitedMood() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Hôm nay tôi cảm thấy thật phấn khích và tràn đầy năng lượng !!',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  height: 1.3,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Thay đổi',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey[500],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Column(
          children: [
            Image.asset(
              'assets/images/excited.png',
              width: 65,
              height: 65,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return const Text('🤠', style: TextStyle(fontSize: 50));
              },
            ),
            const SizedBox(height: 4),
          ],
        ),
      ],
    );
  }

  Widget _buildAnxiousMood() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Hôm nay tôi có chút lo lắng, mong mọi thứ sẽ ổn.',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  height: 1.3,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Thay đổi',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey[500],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Column(
          children: [
            Image.asset(
              'assets/images/anxious.png',
              width: 65,
              height: 65,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return const Text('😔', style: TextStyle(fontSize: 50));
              },
            ),
            const SizedBox(height: 4)
          ],
        ),
      ],
    );
  }
}