import 'package:flutter/material.dart';

class ExerciseItemDetailScreen extends StatefulWidget {
  const ExerciseItemDetailScreen({Key? key}) : super(key: key);

  @override
  State<ExerciseItemDetailScreen> createState() => _ExerciseItemDetailScreenState();
}

class _ExerciseItemDetailScreenState extends State<ExerciseItemDetailScreen> {
  final List<_DurationOption> options = [
    _DurationOption('Đốt cháy 100 Calo', '03', 'phút'),
    _DurationOption('Đốt cháy 120 Calo', '05', 'phút'),
    _DurationOption('Đốt cháy 150 Calo', '10', 'phút'),
  ];
  int selectedIndex = 1;

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
        title: const Text(
          'Set 1: Khởi động',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ... Video/Image + mô tả như cũ ...
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        'assets/images/khoidong.png',
                        width: double.infinity,
                        height: 180,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: double.infinity,
                            height: 180,
                            color: Colors.grey[300],
                            child: const Icon(Icons.image, size: 60, color: Colors.white54),
                          );
                        },
                      ),
                    ),
                    Positioned(
                      left: 16,
                      bottom: 16,
                      child: Row(
                        children: [
                          Icon(Icons.play_arrow, color: Colors.white, size: 32),
                          const SizedBox(width: 8),
                          Text(
                            '0:10 / 5:00',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              shadows: [
                                Shadow(
                                  color: Colors.black54,
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      right: 16,
                      bottom: 16,
                      child: Row(
                        children: [
                          Icon(Icons.volume_up, color: Colors.white, size: 24),
                          const SizedBox(width: 8),
                          Icon(Icons.settings, color: Colors.white, size: 24),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Bài tập khởi động toàn thân',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Mức độ: Dễ | Đốt cháy: -150 calo',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Mô tả',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[800],
                          height: 1.5,
                        ),
                        children: [
                          const TextSpan(
                            text:
                            'Khởi động là bước đầu tiên và quan trọng trước khi bắt đầu luyện tập. Các động tác khởi động giúp làm nóng cơ thể, tăng nhịp tim, kích hoạt cơ bắp và giảm nguy cơ chấn thương. ',
                          ),
                          TextSpan(
                            text: 'Read More...',
                            style: TextStyle(
                              color: Color(0xFF00BCD4),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Thời lượng gợi ý',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 12),
                    // Thời lượng gợi ý dạng trượt
                    SizedBox(
                      height: 140,
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemCount: options.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 2),
                        itemBuilder: (context, index) {
                          final isSelected = index == selectedIndex;
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedIndex = index;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                border: Border(
                                  bottom: BorderSide(
                                    color: Colors.grey[200]!,
                                    width: 1,
                                  ),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.local_fire_department,
                                    color: Colors.red,
                                    size: 22,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    options[index].label,
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: isSelected ? Colors.grey[800] : Colors.grey[400],
                                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(
                                    options[index].value,
                                    style: TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                      color: isSelected ? Colors.grey[800] : Colors.grey[400],
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    options[index].unit,
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: isSelected ? Colors.grey[800] : Colors.grey[400],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Bắt đầu luyện tập!'),
                              backgroundColor: Color(0xFF00BCD4),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF00BCD4),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                        child: const Text(
                          'Bắt đầu luyện tập',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DurationOption {
  final String label;
  final String value;
  final String unit;
  _DurationOption(this.label, this.value, this.unit);
}