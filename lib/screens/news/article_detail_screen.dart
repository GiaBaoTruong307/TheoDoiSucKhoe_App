import 'package:flutter/material.dart';
import '../../models/article_model.dart';

class ArticleDetailScreen extends StatefulWidget {
  final ArticleModel article;

  const ArticleDetailScreen({Key? key, required this.article}) : super(key: key);

  @override
  State<ArticleDetailScreen> createState() => _ArticleDetailScreenState();
}

class _ArticleDetailScreenState extends State<ArticleDetailScreen> {
  bool _isLiked = false;
  int _likeCount = 4100;
  int _commentCount = 281;

  void _toggleLike() {
    setState(() {
      if (_isLiked) {
        _isLiked = false;
        _likeCount--;
      } else {
        _isLiked = true;
        _likeCount++;
      }
    });
  }

  String _formatNumber(int number) {
    if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}k';
    }
    return number.toString();
  }

  void _showComments() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => CommentsBottomSheet(
        commentCount: _commentCount,
        onCommentAdded: () {
          setState(() {
            _commentCount++;
          });
        },
      ),
    );
  }

  void _showReportDialog() {
    String? selectedReason;
    bool blockAuthor = false;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Báo cáo bài viết',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Spam
                    InkWell(
                      onTap: () {
                        setState(() {
                          selectedReason = 'spam';
                        });
                      },
                      child: Row(
                        children: [
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: selectedReason == 'spam'
                                    ? const Color(0xFFD32F2F)
                                    : Colors.grey.shade400,
                                width: 2,
                              ),
                            ),
                            child: selectedReason == 'spam'
                                ? Center(
                              child: Container(
                                width: 10,
                                height: 10,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFFD32F2F),
                                ),
                              ),
                            )
                                : null,
                          ),
                          const SizedBox(width: 12),
                          const Text(
                            'Spam',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Quấy rối
                    InkWell(
                      onTap: () {
                        setState(() {
                          selectedReason = 'harassment';
                        });
                      },
                      child: Row(
                        children: [
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: selectedReason == 'harassment'
                                    ? const Color(0xFFD32F2F)
                                    : Colors.grey.shade400,
                                width: 2,
                              ),
                            ),
                            child: selectedReason == 'harassment'
                                ? Center(
                              child: Container(
                                width: 10,
                                height: 10,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFFD32F2F),
                                ),
                              ),
                            )
                                : null,
                          ),
                          const SizedBox(width: 12),
                          const Text(
                            'Quấy rối',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Vi phạm quy tắc
                    InkWell(
                      onTap: () {
                        setState(() {
                          selectedReason = 'violation';
                        });
                      },
                      child: Row(
                        children: [
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: selectedReason == 'violation'
                                    ? const Color(0xFFD32F2F)
                                    : Colors.grey.shade400,
                                width: 2,
                              ),
                            ),
                            child: selectedReason == 'violation'
                                ? Center(
                              child: Container(
                                width: 10,
                                height: 10,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFFD32F2F),
                                ),
                              ),
                            )
                                : null,
                          ),
                          const SizedBox(width: 12),
                          const Text(
                            'Vi phạm quy tắc',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Chặn tác giả
                    InkWell(
                      onTap: () {
                        setState(() {
                          blockAuthor = !blockAuthor;
                        });
                      },
                      child: Row(
                        children: [
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                color: blockAuthor
                                    ? const Color(0xFFD32F2F)
                                    : Colors.grey.shade400,
                                width: 2,
                              ),
                              color: blockAuthor ? const Color(0xFFD32F2F) : Colors.transparent,
                            ),
                            child: blockAuthor
                                ? const Icon(
                              Icons.check,
                              size: 14,
                              color: Colors.white,
                            )
                                : null,
                          ),
                          const SizedBox(width: 12),
                          const Expanded(
                            child: Text(
                              'Chặn tác giả của bài viết này',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Buttons
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: Colors.grey.shade300, width: 1.5),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                            ),
                            child: const Text(
                              'Hủy',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: selectedReason != null
                                ? () {
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Đã gửi báo cáo thành công'),
                                  backgroundColor: Color(0xFF00BCD4),
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            }
                                : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFD32F2F),
                              foregroundColor: Colors.white,
                              disabledBackgroundColor: Colors.grey.shade300,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                            ),
                            child: const Text(
                              'Báo cáo',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Warning text
                    Text(
                      'Báo cáo vi phạm bản quyền hoặc nhãn hiệu, vui lòng đọc quy định của chúng tôi.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
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
          'Tin tức',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 120),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text(
                widget.article.title,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 16),

              // Author Info
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.pink.shade50,
                    child: Icon(
                      Icons.person,
                      size: 22,
                      color: Colors.pink.shade300,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.article.author,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        Text(
                          '2 ngày trước  • Th10 16, 2025',
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
              const SizedBox(height: 20),

              // Article Image
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  widget.article.imageUrl,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF00BCD4), Color(0xFF0097A7)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Center(
                        child: Icon(Icons.image, size: 60, color: Colors.white54),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 12),

              // Image Caption
              Center(
                child: Text(
                  'Calorie Check!',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Content
              Text(
                'Kiểm tra lượng calo - Calorie Check!',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Trong hành trình duy trì vóc dáng và sức khỏe, việc cân bằng lượng calo nạp vào và tiêu hao mỗi ngày đóng vai trò vô cùng quan trọng. Nhiều người thường chỉ chú ý đến việc ăn ít đi.',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey[800],
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Nhưng nếu, việc sử dụng công nghệ, các ứng dụng theo dõi calo giúp người dùng dễ dàng kiểm soát chế độ ăn uống của mình. Chỉ cần nhập thức phẩm bạn tiêu thụ, ứng dụng sẽ tự động tính toán lượng calo và gợi ý giúp bạn duy trì sự cân bằng năng lý tưởng.',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey[800],
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Lý do nên theo dõi lượng calo:',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '• Giúp nhận biết nhu cầu năng lượng thực sự cần thiết cho cơ thể.',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey[800],
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 32),

              // Action Buttons
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Like Button
                  GestureDetector(
                    onTap: _toggleLike,
                    child: Row(
                      children: [
                        Icon(
                          _isLiked ? Icons.favorite : Icons.favorite_border,
                          color: _isLiked ? Colors.red : Colors.black87,
                          size: 24,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          _formatNumber(_likeCount),
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.black87,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 24),

                  // Comment Button
                  GestureDetector(
                    onTap: _showComments,
                    child: Row(
                      children: [
                        Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.black87,
                              width: 1.8,
                            ),
                          ),
                          child: Stack(
                            children: [
                              Positioned.fill(
                                child: CustomPaint(
                                  painter: CommentIconPainter(),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          _commentCount.toString(),
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.black87,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),

                  // Share Button
                  GestureDetector(
                    onTap: () {
                      // TODO: Share article
                    },
                    child: Container(
                      height: 24,
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.ios_share,
                        color: Colors.black87,
                        size: 24,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),

                  // More Button
                  GestureDetector(
                    onTap: _showReportDialog,
                    child: Container(
                      height: 24,
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.more_horiz,
                        color: Colors.black87,
                        size: 24,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Custom painter for comment icon
class CommentIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black87
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8;

    // Draw three dots
    final dotRadius = 1.5;
    final centerY = size.height / 2;

    // Left dot
    canvas.drawCircle(Offset(size.width * 0.3, centerY), dotRadius, Paint()..color = Colors.black87..style = PaintingStyle.fill);

    // Middle dot
    canvas.drawCircle(Offset(size.width * 0.5, centerY), dotRadius, Paint()..color = Colors.black87..style = PaintingStyle.fill);

    // Right dot
    canvas.drawCircle(Offset(size.width * 0.7, centerY), dotRadius, Paint()..color = Colors.black87..style = PaintingStyle.fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Comments Bottom Sheet
class CommentsBottomSheet extends StatefulWidget {
  final int commentCount;
  final VoidCallback onCommentAdded;

  const CommentsBottomSheet({
    Key? key,
    required this.commentCount,
    required this.onCommentAdded,
  }) : super(key: key);

  @override
  State<CommentsBottomSheet> createState() => _CommentsBottomSheetState();
}

class _CommentsBottomSheetState extends State<CommentsBottomSheet> {
  final TextEditingController _commentController = TextEditingController();
  bool _hideAnonymous = false;
  bool _isBold = false;
  bool _isItalic = false;

  final List<CommentModel> _comments = [
    CommentModel(
      userName: 'Thanh Trà',
      userAvatar: '👨',
      content: 'Bài viết rất hữu ích! Nhờ theo dõi calo mà mình đã giảm được 2kg trong tháng này. Cộng cụ Calorie Check của app thật sự tiện lợi. Rất khuyến khích mọi người dùng!',
      likes: 211,
      replies: 0,
      timeAgo: '2 giờ trước',
      isLiked: false,
    ),
    CommentModel(
      userName: 'Trà My',
      userAvatar: '👩',
      content: 'Cảm ơn bài viết! Mình thấy việc tính toán calo hai rắc rối lúc đầu, nhưng sau một tuần dùng app thì mọi thứ dễ dàng hơn nhiều. Mình tập trung ăn nhiều rau củ quả hơn. Bản năo mới bắt đầu củ kiến nhận nhé!',
      likes: 78,
      replies: 0,
      timeAgo: '5 giờ trước',
      isLiked: true,
    ),
  ];

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  void _postComment() {
    if (_commentController.text.trim().isNotEmpty) {
      widget.onCommentAdded();
      _commentController.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Đã đăng bình luận'),
          backgroundColor: Color(0xFF00BCD4),
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              // Header
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
                    Text(
                      'Bình luận (${widget.commentCount})',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close, size: 24),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
              ),

              // Comment Input
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  border: Border(
                    bottom: BorderSide(color: Colors.grey.shade200),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 18,
                          backgroundColor: Colors.pink.shade100,
                          child: const Text(
                            '👤',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Text(
                            'Thiên Vi',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Column(
                        children: [
                          TextField(
                            controller: _commentController,
                            maxLines: 3,
                            decoration: InputDecoration(
                              hintText: 'Bạn nghĩ gì?',
                              hintStyle: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade400,
                              ),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.all(12),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(color: Colors.grey.shade200),
                              ),
                            ),
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _isBold = !_isBold;
                                    });
                                  },
                                  icon: Text(
                                    'B',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: _isBold ? Colors.black87 : Colors.grey.shade600,
                                    ),
                                  ),
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
                                ),
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _isItalic = !_isItalic;
                                    });
                                  },
                                  icon: Text(
                                    'i',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.w500,
                                      color: _isItalic ? Colors.black87 : Colors.grey.shade600,
                                    ),
                                  ),
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
                                ),
                                const Spacer(),
                                TextButton(
                                  onPressed: () {
                                    _commentController.clear();
                                  },
                                  child: Text(
                                    'Hủy',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey.shade700,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                ElevatedButton(
                                  onPressed: _postComment,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF00BCD4),
                                    foregroundColor: Colors.white,
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                  ),
                                  child: const Text(
                                    'Bình luận',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _hideAnonymous = !_hideAnonymous;
                            });
                          },
                          child: Row(
                            children: [
                              Container(
                                width: 18,
                                height: 18,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(
                                    color: _hideAnonymous ? const Color(0xFF00BCD4) : Colors.grey.shade400,
                                    width: 2,
                                  ),
                                  color: _hideAnonymous ? const Color(0xFF00BCD4) : Colors.transparent,
                                ),
                                child: _hideAnonymous
                                    ? const Icon(
                                  Icons.check,
                                  size: 12,
                                  color: Colors.white,
                                )
                                    : null,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Bình luận Ẩn danh',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Comments List Header
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: const Row(
                  children: [
                    Text(
                      'Phù hợp nhất',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),

              // Comments List
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: _comments.length,
                  itemBuilder: (context, index) {
                    final comment = _comments[index];
                    return CommentItem(
                      comment: comment,
                      onLike: () {
                        setState(() {
                          comment.isLiked = !comment.isLiked;
                          if (comment.isLiked) {
                            comment.likes++;
                          } else {
                            comment.likes--;
                          }
                        });
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// Comment Model
class CommentModel {
  String userName;
  String userAvatar;
  String content;
  int likes;
  int replies;
  String timeAgo;
  bool isLiked;

  CommentModel({
    required this.userName,
    required this.userAvatar,
    required this.content,
    required this.likes,
    required this.replies,
    required this.timeAgo,
    this.isLiked = false,
  });
}

// Comment Item Widget
class CommentItem extends StatelessWidget {
  final CommentModel comment;
  final VoidCallback onLike;

  const CommentItem({
    Key? key,
    required this.comment,
    required this.onLike,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.grey.shade200,
            child: Text(
              comment.userAvatar,
              style: const TextStyle(fontSize: 20),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  comment.userName,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  comment.content,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade800,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    GestureDetector(
                      onTap: onLike,
                      child: Row(
                        children: [
                          Icon(
                            comment.isLiked ? Icons.favorite : Icons.favorite_border,
                            size: 18,
                            color: comment.isLiked ? Colors.red : Colors.grey.shade600,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            comment.likes.toString(),
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Row(
                      children: [
                        Icon(
                          Icons.chat_bubble_outline,
                          size: 18,
                          color: Colors.grey.shade600,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          comment.replies.toString(),
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}