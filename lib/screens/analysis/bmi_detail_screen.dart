import 'package:flutter/material.dart';
import '../../models/user_model.dart';
import '../../widgets/update_weight_height_dialog.dart';
import '../main_wrapper.dart';

class BMIDetailScreen extends StatefulWidget {
  final UserModel user;
  final Function(double weight, double height) onUpdate;

  const BMIDetailScreen({
    Key? key,
    required this.user,
    required this.onUpdate,
  }) : super(key: key);

  @override
  State<BMIDetailScreen> createState() => _BMIDetailScreenState();
}

class _BMIDetailScreenState extends State<BMIDetailScreen> {
  late UserModel _currentUser;

  @override
  void initState() {
    super.initState();
    _currentUser = widget.user;
  }

  double _calculateBMI() {
    if (_currentUser.height <= 0 || _currentUser.weight <= 0) return 0;
    double heightInMeters = _currentUser.height / 100;
    return _currentUser.weight / (heightInMeters * heightInMeters);
  }

  double _getBMIPosition() {
    double bmi = _calculateBMI();
    if (bmi <= 15) return 0.0;
    if (bmi >= 40) return 1.0;
    return (bmi - 15) / (40 - 15);
  }

  void _showUpdateDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => UpdateWeightHeightDialog(
        currentWeight: _currentUser.weight,
        currentHeight: _currentUser.height,
        onUpdate: (weight, height) {
          setState(() {
            _currentUser = UserModel(
              name: _currentUser.name,
              weight: weight,
              height: height,
              age: _currentUser.age,
              gender: _currentUser.gender,
            );
          });
          widget.onUpdate(weight, height);
        },
      ),
    );
  }

  Widget _buildBMIScale() {
    double bmi = _calculateBMI();
    double position = _getBMIPosition();

    return Column(
      children: [
        // Marker badge at top with arrow
        Stack(
          children: [
            Container(
              height: 40,
              alignment: Alignment.centerLeft,
              child: FractionallySizedBox(
                widthFactor: position,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.black87,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            bmi.toStringAsFixed(1),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        const SizedBox(height: 2),
                        CustomPaint(
                          size: const Size(8, 6),
                          painter: TrianglePainter(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 2),
        // BMI Scale bar
        Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                height: 28,
                decoration: const BoxDecoration(
                  color: Color(0xFF4CAF50),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(14),
                    bottomLeft: Radius.circular(14),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 3),
            Expanded(
              flex: 4,
              child: Container(
                height: 28,
                decoration: BoxDecoration(
                  color: const Color(0xFF4DD0E1),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
            const SizedBox(width: 3),
            Expanded(
              flex: 7,
              child: Container(
                height: 28,
                decoration: BoxDecoration(
                  color: const Color(0xFF2196F3),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
            const SizedBox(width: 3),
            Expanded(
              flex: 4,
              child: Container(
                height: 28,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFB74D),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
            const SizedBox(width: 3),
            Expanded(
              flex: 8,
              child: Container(
                height: 28,
                decoration: const BoxDecoration(
                  color: Color(0xFFF44336),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(14),
                    bottomRight: Radius.circular(14),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        LayoutBuilder(
          builder: (context, constraints) {
            double totalWidth = constraints.maxWidth;
            double unit = totalWidth / 25;

            return SizedBox(
              height: 20,
              child: Stack(
                children: [
                  const Positioned(
                    left: 0,
                    child: Text(
                      '15',
                      style: TextStyle(fontSize: 11, color: Colors.black54, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Positioned(
                    left: unit * 2 - 6,
                    child: const Text(
                      '17',
                      style: TextStyle(fontSize: 11, color: Colors.black54, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Positioned(
                    left: unit * 6 - 6,
                    child: const Text(
                      '21',
                      style: TextStyle(fontSize: 11, color: Colors.black54, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Positioned(
                    left: unit * 13 - 6,
                    child: const Text(
                      '28',
                      style: TextStyle(fontSize: 11, color: Colors.black54, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Positioned(
                    left: unit * 17 - 6,
                    child: const Text(
                      '32',
                      style: TextStyle(fontSize: 11, color: Colors.black54, fontWeight: FontWeight.w500),
                    ),
                  ),
                  const Positioned(
                    right: 0,
                    child: Text(
                      '40',
                      style: TextStyle(fontSize: 11, color: Colors.black54, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildLegendItem(Color color, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 20,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(fontSize: 11, color: Colors.black87),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    double bmi = _calculateBMI();
    double heightInMeters = _currentUser.height / 100;
    double minWeight = 18.5 * heightInMeters * heightInMeters;
    double maxWeight = 24.9 * heightInMeters * heightInMeters;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            // Reset navigation về Trang chủ
            final mainWrapperState = context.findAncestorStateOfType<MainWrapperState>();
            mainWrapperState?.resetToHome();
          },
        ),
        title: const Text(
          'Chi tiết BMI',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // User info card
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 32,
                      backgroundColor: Colors.pink.shade100,
                      child: Icon(
                        Icons.person,
                        size: 38,
                        color: Colors.pink.shade300,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _currentUser.name,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Tình trạng cơ thể của bạn',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Stats row
              Container(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStatItem('${_currentUser.height.toInt()}cm', 'Chiều cao'),
                    Container(width: 1, height: 40, color: Colors.grey.shade300),
                    _buildStatItem('${_currentUser.weight.toInt()}kg', 'Cân nặng'),
                    Container(width: 1, height: 40, color: Colors.grey.shade300),
                    _buildStatItem('${_currentUser.age}y', 'Tuổi'),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // BMI Section
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const Text(
                      'Chỉ số khối cơ thể (BMI) của bạn',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      bmi.toStringAsFixed(1),
                      style: const TextStyle(
                        fontSize: 56,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2196F3),
                      ),
                    ),
                    const SizedBox(height: 24),
                    _buildBMIScale(),
                    const SizedBox(height: 20),
                    Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 12,
                      runSpacing: 10,
                      children: [
                        _buildLegendItem(const Color(0xFF4CAF50), 'Gầy'),
                        _buildLegendItem(const Color(0xFF4DD0E1), 'Hơi thiếu cân'),
                        _buildLegendItem(const Color(0xFF2196F3), 'Bình thường'),
                        _buildLegendItem(const Color(0xFFFFB74D), 'Béo phì độ I'),
                        _buildLegendItem(const Color(0xFFF44336), 'Béo phì độ II'),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Healthy weight
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const Text(
                      'Cân nặng hợp lý cho chiều cao',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black87),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      '${minWeight.toStringAsFixed(1)} kg - ${maxWeight.toStringAsFixed(1)} kg',
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2196F3),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Update button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () => _showUpdateDialog(context),
                  icon: const Icon(Icons.edit, size: 20),
                  label: const Text(
                    'Cập nhật cân nặng & chiều cao',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFF2196F3),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: const BorderSide(color: Color(0xFF2196F3), width: 2),
                    ),
                    elevation: 0,
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2196F3),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
        ),
      ],
    );
  }
}

class TrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black87
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(size.width / 2, size.height)
      ..lineTo(0, 0)
      ..lineTo(size.width, 0)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}