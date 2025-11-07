import 'package:flutter/material.dart';
import '../../models/exercise_model.dart';
import '../../models/exercise_item_model.dart';
import '../../widgets/exercise_item_card.dart';

class ExerciseDetailScreen extends StatefulWidget {
  final ExerciseModel exercise;

  const ExerciseDetailScreen({Key? key, required this.exercise}) : super(key: key);

  @override
  State<ExerciseDetailScreen> createState() => _ExerciseDetailScreenState();
}

class _ExerciseDetailScreenState extends State<ExerciseDetailScreen> {
  bool isFavorite = false;

  // Danh sách bài tập theo mẫu bạn chụp
  final List<Map<String, dynamic>> set1 = [
    {
      'name': 'Khởi động',
      'duration': '05:00',
      'image': 'assets/images/khoidong.png',
    },
    {
      'name': 'Nhảy Jumping Jack',
      'duration': '12 lần',
      'image': 'assets/images/jumpingjack.png',
    },
    {
      'name': 'Nhảy dây',
      'duration': '15 lần',
      'image': 'assets/images/nhayday.png',
    },
    {
      'name': 'Squat',
      'duration': '20 lần',
      'image': 'assets/images/squat.png',
    },
    {
      'name': 'Giơ tay ngang vai',
      'duration': '00:53',
      'image': 'assets/images/giotay.png',
    },
    {
      'name': 'Nghỉ ngơi & uống nước',
      'duration': '02:00',
      'image': 'assets/images/nghi.png',
    },
  ];

  final List<Map<String, dynamic>> set2 = [
    {
      'name': 'Chống đẩy nghiêng',
      'duration': '12 lần',
      'image': 'assets/images/chongdaynghieng.png',
    },
    {
      'name': 'Chống đẩy',
      'duration': '15 lần',
      'image': 'assets/images/chongday.png',
    },
    {
      'name': 'Nhảy dây',
      'duration': '15 lần',
      'image': 'assets/images/nhayday.png',
    },
    {
      'name': 'Duỗi người',
      'duration': '20 lần',
      'image': 'assets/images/duoinguoi.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(10),
            ),
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.black87,
                size: 18,
              ),
              onPressed: () => Navigator.pop(context),
              padding: EdgeInsets.zero,
            ),
          ),
        ),
        title: Text(
          widget.exercise.title,
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 32), // Giới hạn dưới cùng để không bị che
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Section
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.exercise.title,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                '${widget.exercise.exercises} bài tập | ${widget.exercise.minutes} phút | ${widget.exercise.calories} calo tiêu hao',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isFavorite = !isFavorite;
                              });
                            },
                            child: Icon(
                              isFavorite ? Icons.favorite : Icons.favorite_border,
                              color: isFavorite ? Colors.red : Colors.grey[400],
                              size: 28,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      // Equipment Section
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Bạn cần chuẩn bị',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          Text(
                            '3 vật dụng',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          _buildEquipmentImage(
                            'assets/images/ta.png',
                            'Tạ tay',
                          ),
                          const SizedBox(width: 12),
                          _buildEquipmentImage(
                            'assets/images/day.png',
                            'Dây nhảy',
                          ),
                          const SizedBox(width: 12),
                          _buildEquipmentImage(
                            'assets/images/binhnuoc.png',
                            'Bình nước',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),

                // Exercise List Section
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Các bài tập',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          Text(
                            '2 Sets',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      // Set 1
                      const Text(
                        'Set 1',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 12),
                      ...set1.map((item) {
                        return ExerciseItemCard(
                          item: ExerciseItemModel(
                            id: item['name'],
                            name: item['name'],
                            duration: item['duration'],
                            imageUrl: item['image'],
                          ),
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Bắt đầu: ${item['name']}'),
                                backgroundColor: const Color(0xFF00BCD4),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          },
                        );
                      }).toList(),
                      const SizedBox(height: 20),
                      // Set 2
                      const Text(
                        'Set 2',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 12),
                      ...set2.map((item) {
                        return ExerciseItemCard(
                          item: ExerciseItemModel(
                            id: item['name'],
                            name: item['name'],
                            duration: item['duration'],
                            imageUrl: item['image'],
                          ),
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Bắt đầu: ${item['name']}'),
                                backgroundColor: const Color(0xFF00BCD4),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          },
                        );
                      }).toList(),
                    ],
                  ),
                ),
                const SizedBox(height: 32), // Giới hạn dưới cùng để không bị che
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEquipmentImage(String imagePath, String label) {
    return Expanded(
      child: Column(
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Image.asset(
                imagePath,
                width: 66,
                height: 76,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(Icons.image, size: 40, color: Colors.grey[400]);
                },
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }
}