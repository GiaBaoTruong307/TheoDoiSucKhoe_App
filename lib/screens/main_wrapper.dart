import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../models/goal_model.dart';
import 'home/home_screen.dart';
import 'analysis/bmi_detail_screen.dart';
import 'goals/add_goal_screen.dart';
import 'news/news_screen.dart';
import 'profile/profile_screen.dart';

class MainWrapper extends StatefulWidget {
  final UserModel user;

  const MainWrapper({Key? key, required this.user}) : super(key: key);

  @override
  State<MainWrapper> createState() => MainWrapperState();
}

class MainWrapperState extends State<MainWrapper> {
  int _currentIndex = 0;
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  late UserModel _currentUser;

  @override
  void initState() {
    super.initState();
    _currentUser = widget.user;
  }

  void _updateUserData(double weight, double height) {
    setState(() {
      _currentUser = UserModel(
        name: _currentUser.name,
        weight: weight,
        height: height,
        age: _currentUser.age,
        gender: _currentUser.gender,
      );
    });
  }

  void navigateToAnalysis() {
    setState(() {
      _currentIndex = 1;
    });
    _navigatorKey.currentState?.push(
      MaterialPageRoute(
        builder: (context) => BMIDetailScreen(
          user: _currentUser,
          onUpdate: _updateUserData,
        ),
      ),
    );
  }

  void resetToHome() {
    setState(() {
      _currentIndex = 0;
    });
    _navigatorKey.currentState?.pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => HomeScreen(user: _currentUser)),
          (route) => false,
    );
  }

  void _openAddGoalScreen() {
    setState(() {
      _currentIndex = 2;
    });

    _navigatorKey.currentState?.push(
      MaterialPageRoute(builder: (context) => const AddGoalScreen()),
    ).then((result) {
      setState(() {
        _currentIndex = 0;
      });

      if (result != null && result is GoalModel) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Đã thêm mục tiêu: ${result.title}'),
            backgroundColor: const Color(0xFF00BCD4),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        );
      }
    });
  }

  void _onNavItemTapped(int index) {
    if (_currentIndex == index) return;

    setState(() {
      _currentIndex = index;
    });

    switch (index) {
      case 0:
        _navigatorKey.currentState?.pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => HomeScreen(user: _currentUser)),
              (route) => false,
        );
        break;
      case 1:
        _navigatorKey.currentState?.push(
          MaterialPageRoute(
            builder: (context) => BMIDetailScreen(
              user: _currentUser,
              onUpdate: _updateUserData,
            ),
          ),
        );
        break;
      case 2:
        _openAddGoalScreen();
        break;
      case 3:
        _navigatorKey.currentState?.pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const NewsScreen()),
              (route) => false,
        );
        break;
      case 4:
        _navigatorKey.currentState?.pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => ProfileScreen(user: _currentUser)),
              (route) => false,
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Navigator(
        key: _navigatorKey,
        onGenerateRoute: (settings) {
          return MaterialPageRoute(
            builder: (context) => HomeScreen(user: _currentUser),
          );
        },
      ),
      extendBody: true,
      bottomNavigationBar: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 20, left: 16, right: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 20,
                  offset: const Offset(0, -3),
                  spreadRadius: 0,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: SizedBox(
                height: 75,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildNavItem(0, Icons.home_rounded, 'Trang chủ'),
                    _buildNavItem(1, Icons.calendar_today_rounded, 'Phân tích'),
                    const Expanded(child: SizedBox()),
                    _buildNavItem(3, Icons.grid_view_rounded, 'Tin tức'),
                    _buildNavItem(4, Icons.person_rounded, 'Hồ sơ'),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 45,
            child: GestureDetector(
              onTap: () => _onNavItemTapped(2),
              child: Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF00BCD4), Color(0xFF0097A7)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF00BCD4).withOpacity(0.5),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Icon(
                  Icons.add,
                  color: _currentIndex == 2 ? Colors.black : Colors.white,
                  size: 34,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    final isActive = _currentIndex == index;

    return Expanded(
      child: InkWell(
        onTap: () => _onNavItemTapped(index),
        splashColor: const Color(0xFF00BCD4).withOpacity(0.1),
        highlightColor: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isActive ? const Color(0xFF00BCD4) : Colors.grey[600],
              size: 26,
            ),
            const SizedBox(height: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                color: isActive ? const Color(0xFF00BCD4) : Colors.grey[600],
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}