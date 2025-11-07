import 'package:flutter/material.dart';
import '../../models/notification_model.dart';

class NotificationsScreen extends StatelessWidget {
  NotificationsScreen({Key? key}) : super(key: key);

  // Sample notifications data
  final List<NotificationModel> notifications = [
    NotificationModel(
      id: '1',
      title: 'Đã đến giờ bổ sung nước',
      subtitle: 'Khoảng 10 phút trước',
      icon: '💧',
      time: DateTime.now().subtract(const Duration(minutes: 10)),
    ),
    NotificationModel(
      id: '2',
      title: 'Đừng quên ghi lại giấc ngủ của bạn',
      subtitle: '3 giờ trước',
      icon: '😴',
      time: DateTime.now().subtract(const Duration(hours: 3)),
    ),
    NotificationModel(
      id: '3',
      title: 'Đã có thống kê sức khỏe hôm nay',
      subtitle: '4 giờ trước',
      icon: '📊',
      time: DateTime.now().subtract(const Duration(hours: 4)),
    ),
    NotificationModel(
      id: '4',
      title: 'Tuyệt vời! Bạn đã hoàn thành m..',
      subtitle: '23/10',
      icon: '🎉',
      time: DateTime(2024, 10, 23),
    ),
    NotificationModel(
      id: '5',
      title: 'Chưa có dữ liệu nào hôm nay',
      subtitle: '23/10',
      icon: '⚠️',
      time: DateTime(2024, 10, 23),
    ),
    NotificationModel(
      id: '6',
      title: 'Đã ngồi hơi lâu rồi đấy',
      subtitle: '23/10',
      icon: '🪑',
      time: DateTime(2024, 10, 23),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Thông báo',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: notifications.length,
        separatorBuilder: (context, index) => Divider(
          height: 1,
          thickness: 1,
          color: Colors.grey[200],
          indent: 80,
        ),
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return _buildNotificationItem(notification);
        },
      ),
    );
  }

  Widget _buildNotificationItem(NotificationModel notification) {
    return Container(
      color: Colors.white,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: _getIconBackgroundColor(notification.icon),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              notification.icon,
              style: const TextStyle(fontSize: 24),
            ),
          ),
        ),
        title: Text(
          notification.title,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            notification.subtitle,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey[600],
            ),
          ),
        ),
      ),
    );
  }

  Color _getIconBackgroundColor(String icon) {
    switch (icon) {
      case '💧':
        return const Color(0xFFE3F2FD); // Light blue
      case '😴':
        return const Color(0xFFFFF3E0); // Light orange
      case '📊':
        return const Color(0xFFFFEBEE); // Light red
      case '🎉':
        return const Color(0xFFFCE4EC); // Light pink
      case '⚠️':
        return const Color(0xFFFFF9C4); // Light yellow
      case '🪑':
        return const Color(0xFFE1F5FE); // Light cyan
      default:
        return const Color(0xFFF5F5F5); // Light grey
    }
  }
}