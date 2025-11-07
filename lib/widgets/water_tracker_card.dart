import 'package:flutter/material.dart';
import 'dart:async';

class WaterTrackerCard extends StatefulWidget {
  const WaterTrackerCard({Key? key}) : super(key: key);

  @override
  State<WaterTrackerCard> createState() => _WaterTrackerCardState();
}

class _WaterTrackerCardState extends State<WaterTrackerCard> {
  int _totalWater = 0;
  final int _waterGoal = 2000;
  final int _waterPerClick = 100;

  final List<Map<String, dynamic>> _timeSlots = [
    {'range': '6am - 8am', 'start': 6, 'end': 8},
    {'range': '8am - 10am', 'start': 8, 'end': 10},
    {'range': '10am - 12pm', 'start': 10, 'end': 12},
    {'range': '12pm - 2pm', 'start': 12, 'end': 14},
    {'range': '2pm - 4pm', 'start': 14, 'end': 16},
    {'range': '4pm - 6pm', 'start': 16, 'end': 18},
    {'range': '6pm - 8pm', 'start': 18, 'end': 20},
    {'range': '8pm - 10pm', 'start': 20, 'end': 22},
  ];

  final Map<String, int> _waterByTimeSlot = {};

  Timer? _clickTimer;
  int _clickCount = 0;

  @override
  void initState() {
    super.initState();
    for (var s in _timeSlots) {
      _waterByTimeSlot[s['range']] = 0;
    }
  }

  @override
  void dispose() {
    _clickTimer?.cancel();
    super.dispose();
  }

  String _getCurrentTimeSlot() {
    final hour = DateTime.now().hour;
    for (var s in _timeSlots) {
      if (hour >= s['start'] && hour < s['end']) return s['range'];
    }
    return _timeSlots[0]['range'];
  }

  void _onBarTap() {
    setState(() {
      _clickCount++;
      _clickTimer?.cancel();

      if (_clickCount == 1) {
        final slot = _getCurrentTimeSlot();
        _totalWater += _waterPerClick;
        _waterByTimeSlot[slot] = (_waterByTimeSlot[slot] ?? 0) + _waterPerClick;
      }

      _clickTimer = Timer(const Duration(milliseconds: 500), () {
        if (_clickCount == 2) {
          final slot = _getCurrentTimeSlot();
          if (_totalWater >= _waterPerClick) {
            _totalWater -= _waterPerClick;
            final cur = _waterByTimeSlot[slot] ?? 0;
            if (cur >= _waterPerClick) _waterByTimeSlot[slot] = cur - _waterPerClick;
          }
        }
        _clickCount = 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final progress = (_totalWater / _waterGoal).clamp(0.0, 1.0);
    final visibleSlots = _timeSlots.where((s) => (_waterByTimeSlot[s['range']] ?? 0) > 0).toList();

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10)],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left: KHUNG chứa thanh + nội dung (CHIỀU CAO = Sleep + Foot + khoảng cách)
          Expanded(
            child: Container(
              height: 308, // 130 (sleep) + 14 (spacing) + 164 (foot) = 308
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.grey.shade200, width: 1),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.03),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Thanh dọc
                  GestureDetector(
                    onTap: _onBarTap,
                    child: Container(
                      width: 35,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF0F0F0),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Stack(
                        children: [
                          // Nước
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: FractionallySizedBox(
                              heightFactor: progress,
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [Color(0xFF4FC3F7), Color(0xFF0EA5E9)],
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(width: 16),

                  // Nội dung
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Lượng nước\nhôm nay',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            height: 1.3,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '$_totalWater ml',
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF06B6D4),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Chạm để thêm +100ml',
                          style: TextStyle(fontSize: 10, color: Colors.grey[500]),
                        ),

                        // Icon water chỉ hiện khi chưa có nước (bên ngoài thanh)
                        if (_totalWater == 0) ...[
                          const SizedBox(height: 12),
                          Center(
                            child: Image.asset(
                              'assets/images/water_1.png',
                              width: 50,
                              height: 50,
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) {
                                return const Text('💧', style: TextStyle(fontSize: 40));
                              },
                            ),
                          ),
                        ],

                        const SizedBox(height: 16),

                        // Time slots
                        if (visibleSlots.isNotEmpty)
                          Expanded(
                            child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: visibleSlots.map((s) {
                                  final r = s['range'] as String;
                                  final ml = _waterByTimeSlot[r] ?? 0;
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 8),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 5,
                                          height: 5,
                                          decoration: const BoxDecoration(
                                            color: Color(0xFF06B6D4),
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: Text(
                                            r,
                                            style: const TextStyle(
                                              fontSize: 10,
                                              color: Color(0xFF888888),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          '${ml}ml',
                                          style: const TextStyle(
                                            fontSize: 10,
                                            color: Color(0xFF06B6D4),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
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

          const SizedBox(width: 16),

          // Right: 2 Cards
          Column(
            children: [
              // Giấc ngủ
              Container(
                width: 130,
                height: 130,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Colors.grey.shade200, width: 1),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.03),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Giấc ngủ',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey[700],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Text(
                          '8h 20m',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF06B6D4),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: Center(
                        child: Image.asset(
                          'assets/images/sleep.png',
                          width: 80,
                          height: 80,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return const Text('😴', style: TextStyle(fontSize: 50));
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 14),

              // Hoạt động
              Container(
                width: 130,
                height: 164,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Colors.grey.shade200, width: 1),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.03),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hoạt động',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey[700],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      '1200 Bước',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF06B6D4),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: Center(
                        child: Image.asset(
                          'assets/images/foot.png',
                          width: 90,
                          height: 90,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return const Text('👟', style: TextStyle(fontSize: 50));
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}