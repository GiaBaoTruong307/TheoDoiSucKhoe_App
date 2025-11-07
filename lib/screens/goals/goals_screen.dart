import 'package:flutter/material.dart';
import '../../models/daily_activity_model.dart';

class GoalsScreen extends StatefulWidget {
  const GoalsScreen({Key? key}) : super(key: key);

  @override
  State<GoalsScreen> createState() => _GoalsScreenState();
}

class _GoalsScreenState extends State<GoalsScreen> with SingleTickerProviderStateMixin {
  String _selectedPeriod = 'Tuần này';
  int? _selectedDayIndex;
  final PageController _goalPageController = PageController();
  int _currentGoalPage = 0;
  bool _isDropdownOpen = false;
  late AnimationController _dropdownAnimationController;
  late Animation<double> _dropdownAnimation;
  OverlayEntry? _overlayEntry;
  final GlobalKey _dropdownButtonKey = GlobalKey();

  final DailyGoalModel goals = DailyGoalModel(
    waterGoal: 4000,
    stepsGoal: 5000,
    sleepGoal: 7.5,
  );

  final List<DailyActivityModel> weekData = [
    DailyActivityModel(
      date: DateTime.now().subtract(const Duration(days: 6)),
      waterIntake: 1500,
      steps: 2000,
      sleepHours: 4.5,
    ),
    DailyActivityModel(
      date: DateTime.now().subtract(const Duration(days: 5)),
      waterIntake: 3200,
      steps: 4500,
      sleepHours: 7.0,
    ),
    DailyActivityModel(
      date: DateTime.now().subtract(const Duration(days: 4)),
      waterIntake: 1900,
      steps: 3000,
      sleepHours: 6.0,
    ),
    DailyActivityModel(
      date: DateTime.now().subtract(const Duration(days: 3)),
      waterIntake: 2800,
      steps: 3500,
      sleepHours: 5.5,
    ),
    DailyActivityModel(
      date: DateTime.now().subtract(const Duration(days: 2)),
      waterIntake: 3800,
      steps: 4800,
      sleepHours: 8.0,
    ),
    DailyActivityModel(
      date: DateTime.now().subtract(const Duration(days: 1)),
      waterIntake: 2200,
      steps: 3200,
      sleepHours: 6.5,
    ),
    DailyActivityModel(
      date: DateTime.now(),
      waterIntake: 3400,
      steps: 4200,
      sleepHours: 7.2,
    ),
  ];

  final List<Map<String, dynamic>> recentActivities = [
    {
      'title': 'Đã uống 300ml nước',
      'time': '3 phút trước',
      'icon': Icons.water_drop,
      'color': Color(0xFF42A5F5),
      'bgColor': Color(0xFFE3F2FD),
    },
    {
      'title': 'Đã uống 200ml nước',
      'time': '30 phút trước',
      'icon': Icons.water_drop,
      'color': Color(0xFF42A5F5),
      'bgColor': Color(0xFFE3F2FD),
    },
    {
      'title': 'Bạn đã đi được 2000 bước',
      'time': '55 phút trước',
      'icon': Icons.directions_walk,
      'color': Color(0xFFFFA726),
      'bgColor': Color(0xFFFFF3E0),
    },
    {
      'title': 'Đã uống 200ml nước',
      'time': '57 phút trước',
      'icon': Icons.water_drop,
      'color': Color(0xFF42A5F5),
      'bgColor': Color(0xFFE3F2FD),
    },
  ];

  @override
  void initState() {
    super.initState();
    _dropdownAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _dropdownAnimation = CurvedAnimation(
      parent: _dropdownAnimationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _removeOverlay();
    _goalPageController.dispose();
    _dropdownAnimationController.dispose();
    super.dispose();
  }

  void _toggleDropdown() {
    if (_isDropdownOpen) {
      _removeOverlay();
    } else {
      _showOverlay();
    }
    setState(() {
      _isDropdownOpen = !_isDropdownOpen;
    });
  }

  void _showOverlay() {
    final RenderBox? renderBox = _dropdownButtonKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    final offset = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;

    _overlayEntry = OverlayEntry(
      builder: (context) => GestureDetector(
        onTap: _toggleDropdown,
        behavior: HitTestBehavior.translucent,
        child: Stack(
          children: [
            Positioned(
              left: offset.dx,
              top: offset.dy + size.height + 8,
              child: FadeTransition(
                opacity: _dropdownAnimation,
                child: ScaleTransition(
                  scale: _dropdownAnimation,
                  alignment: Alignment.topRight,
                  child: Material(
                    color: Colors.transparent,
                    child: Container(
                      width: 140,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: ['Tuần này', 'Tuần trước', '7 ngày gần đây']
                            .map((period) {
                          final isSelected = _selectedPeriod == period;
                          return InkWell(
                            onTap: () {
                              setState(() {
                                _selectedPeriod = period;
                              });
                              _toggleDropdown();
                            },
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? const Color(0xFF42A5F5).withOpacity(0.1)
                                    : Colors.transparent,
                                borderRadius: period == 'Tuần này'
                                    ? const BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  topRight: Radius.circular(12),
                                )
                                    : period == '7 ngày gần đây'
                                    ? const BorderRadius.only(
                                  bottomLeft: Radius.circular(12),
                                  bottomRight: Radius.circular(12),
                                )
                                    : null,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      period,
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: isSelected
                                            ? const Color(0xFF1E88E5)
                                            : Colors.black87,
                                        fontWeight: isSelected
                                            ? FontWeight.w600
                                            : FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                  if (isSelected)
                                    const Icon(
                                      Icons.check,
                                      size: 16,
                                      color: Color(0xFF1E88E5),
                                    ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
    _dropdownAnimationController.forward();
  }

  void _removeOverlay() {
    _dropdownAnimationController.reverse().then((_) {
      _overlayEntry?.remove();
      _overlayEntry = null;
    });
  }

  String _getVietnameseWeekday(int index) {
    const weekdays = ['Thứ 2', 'Thứ 3', 'Thứ 4', 'Thứ 5', 'Thứ 6', 'Thứ 7', 'CN'];
    return weekdays[index];
  }

  double _getCompletionPercentage(DailyActivityModel data) {
    double waterPercent = (data.waterIntake / goals.waterGoal).clamp(0.0, 1.0);
    double stepsPercent = (data.steps / goals.stepsGoal).clamp(0.0, 1.0);
    double sleepPercent = (data.sleepHours / goals.sleepGoal).clamp(0.0, 1.0);
    return (waterPercent + stepsPercent + sleepPercent) / 3;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8),
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 18),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        title: const Text(
          'Mục tiêu',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildGoalsSection(),
            const SizedBox(height: 24),
            _buildProgressSection(),
            const SizedBox(height: 24),
            _buildChart(),
            const SizedBox(height: 24),
            _buildRecentActivities(),
            const SizedBox(height: 120),
          ],
        ),
      ),
    );
  }

  Widget _buildGoalsSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1E88E5), Color(0xFF42A5F5)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1E88E5).withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Mục tiêu hôm nay',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.edit,
                  color: Color(0xFF1E88E5),
                  size: 18,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 70,
            child: PageView(
              controller: _goalPageController,
              onPageChanged: (index) {
                setState(() {
                  _currentGoalPage = index;
                });
              },
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _buildGoalItem(
                        icon: 'assets/images/water_2.png',
                        value: '${goals.waterGoal} ml',
                        label: 'Nước uống',
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _buildGoalItem(
                        icon: 'assets/images/foot_1.png',
                        value: '${goals.stepsGoal}',
                        label: 'Bước chân',
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: _buildGoalItem(
                        icon: 'assets/images/sleep_icon.png',
                        value: '${goals.sleepGoal.toStringAsFixed(1)}h',
                        label: 'Giấc ngủ',
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(child: Container()),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(2, (index) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 3),
                width: _currentGoalPage == index ? 20 : 6,
                height: 6,
                decoration: BoxDecoration(
                  color: _currentGoalPage == index
                      ? Colors.white
                      : Colors.white.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(3),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildGoalItem({
    required String icon,
    required String value,
    required String label,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Image.asset(
            icon,
            width: 40,
            height: 40,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: const Color(0xFFE3F2FD),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Icon(Icons.image, color: Color(0xFF1E88E5), size: 16),
              );
            },
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    color: Color(0xFF1E88E5),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  label,
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 11,
                    height: 1.2,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Tiến độ hoạt động',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          GestureDetector(
            key: _dropdownButtonKey,
            onTap: _toggleDropdown,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xFF42A5F5).withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: const Color(0xFF42A5F5).withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _selectedPeriod,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFF1E88E5),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 6),
                  AnimatedRotation(
                    turns: _isDropdownOpen ? 0.5 : 0,
                    duration: const Duration(milliseconds: 300),
                    child: const Icon(
                      Icons.keyboard_arrow_down,
                      size: 20,
                      color: Color(0xFF1E88E5),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChart() {
    const maxHeight = 180.0;

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final columnWidth = (constraints.maxWidth) / 7;

          return Stack(
            clipBehavior: Clip.none,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: List.generate(weekData.length, (index) {
                  final data = weekData[index];
                  final completionPercent = _getCompletionPercentage(data);
                  final height = completionPercent * maxHeight;
                  final isSelected = _selectedDayIndex == index;
                  final isEvenDay = index % 2 == 0;

                  return Flexible(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedDayIndex = isSelected ? null : index;
                        });
                      },
                      child: Column(
                        children: [
                          SizedBox(
                            height: maxHeight + 20,
                            child: Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                Container(
                                  width: 32,
                                  height: maxHeight + 20,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                Container(
                                  width: 32,
                                  height: height.clamp(30.0, maxHeight),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: isEvenDay
                                          ? [
                                        const Color(0xFF1E88E5),
                                        const Color(0xFF42A5F5)
                                      ]
                                          : [
                                        const Color(0xFF64B5F6),
                                        const Color(0xFF90CAF9)
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                    ),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            _getVietnameseWeekday(index),
                            style: TextStyle(
                              fontSize: 11,
                              color: isSelected
                                  ? const Color(0xFF1E88E5)
                                  : Colors.grey[600],
                              fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
              if (_selectedDayIndex != null)
                Positioned(
                  left: (_selectedDayIndex! * columnWidth) + (columnWidth / 2) - 55,
                  top: (maxHeight + 20) - (_getCompletionPercentage(weekData[_selectedDayIndex!]) * maxHeight) - 105,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.grey[300]!,
                            width: 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.15),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildCompactTooltipRow(
                              'Nước uống:',
                              '${weekData[_selectedDayIndex!].waterIntake}/${goals.waterGoal}ml',
                              const Color(0xFF42A5F5),
                            ),
                            const SizedBox(height: 6),
                            _buildCompactTooltipRow(
                              'Bước chân:',
                              '${weekData[_selectedDayIndex!].steps}/${goals.stepsGoal}',
                              const Color(0xFFFFA726),
                            ),
                            const SizedBox(height: 6),
                            _buildCompactTooltipRow(
                              'Giấc ngủ:',
                              '${weekData[_selectedDayIndex!].sleepHours.toStringAsFixed(1)}/${goals.sleepGoal.toStringAsFixed(1)}h',
                              const Color(0xFF66BB6A),
                            ),
                          ],
                        ),
                      ),
                      CustomPaint(
                        size: const Size(16, 8),
                        painter: ArrowPainter(
                          color: Colors.white,
                          borderColor: Colors.grey[300]!,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildCompactTooltipRow(String label, String value, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 5,
          height: 5,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          '$label $value',
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 9,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildRecentActivities() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Hoạt động gần đây',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          ...recentActivities.map((activity) => _buildActivityItem(
            title: activity['title'],
            time: activity['time'],
            icon: activity['icon'],
            iconColor: activity['color'],
            bgColor: activity['bgColor'],
          )).toList(),
        ],
      ),
    );
  }

  Widget _buildActivityItem({
    required String title,
    required String time,
    required IconData icon,
    required Color iconColor,
    required Color bgColor,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  time,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.more_vert,
            color: Colors.grey[400],
            size: 20,
          ),
        ],
      ),
    );
  }
}

class ArrowPainter extends CustomPainter {
  final Color color;
  final Color borderColor;

  ArrowPainter({required this.color, required this.borderColor});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width / 2, size.height);
    path.lineTo(size.width, 0);
    path.close();

    canvas.drawPath(path, paint);
    canvas.drawPath(path, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}