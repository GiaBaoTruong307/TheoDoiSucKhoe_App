class NotificationModel {
  final String id;
  final String title;
  final String subtitle;
  final String icon;
  final DateTime time;
  final bool isRead;

  NotificationModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.time,
    this.isRead = false,
  });

  String getTimeAgo() {
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inDays > 0) {
      return '${time.day}/${time.month}';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} giờ trước';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} phút trước';
    } else {
      return 'Vừa xong';
    }
  }
}