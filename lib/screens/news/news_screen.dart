import 'package:flutter/material.dart';
import '../../models/article_model.dart';
import 'article_detail_screen.dart';
import 'create_article_screen.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedTabIndex = 0;
  final TextEditingController _searchController = TextEditingController();

  final List<String> _categories = [
    'Tất cả',
    'Dinh dưỡng',
    'Thể thao',
    'Chăm sóc bản thân',
  ];

  final List<ArticleModel> _articles = [
    ArticleModel(
      id: '1',
      title: 'Khám phá nghệ thuật trong việc cân bằng calo mỗi ngày',
      author: 'Gia Bảo',
      authorAvatar: 'assets/images/avatar1.png',
      imageUrl: 'assets/images/Article Image.png',
      category: 'Dinh dưỡng',
      timeAgo: '2 ngày trước',
      views: 1250,
      isFeatured: true,
      description: 'Tìm hiểu cách cân bằng calo hợp lý cho cơ thể khỏe mạnh...',
    ),
    ArticleModel(
      id: '2',
      title: 'Béo bụng do luôi vận động',
      author: 'Thanh Trà',
      authorAvatar: 'assets/images/article-1.png',
      imageUrl: 'assets/images/article-1.png',
      category: 'Vận động',
      timeAgo: '7 phút trước',
      views: 523,
      description: 'Ngồi nhiều, ăn đồ ngọt và thiếu vận động là nguyên nhân chính khiến mỡ...',
    ),
    ArticleModel(
      id: '3',
      title: 'Cách giúp bạn ngủ sâu và thức dậy với làn da tươi trẻ',
      author: 'Bích Tuyền',
      authorAvatar: 'assets/images/article-2.png',
      imageUrl: 'assets/images/article-2.png',
      category: 'Chăm sóc bản thân',
      timeAgo: '30 phút trước',
      views: 892,
      description: 'Các bước chăm sóc da ban đêm giúp làn da tươi trẻ...',
    ),
    ArticleModel(
      id: '4',
      title: '5 thói điểm uống nước',
      author: 'Bích Thy',
      authorAvatar: 'assets/images/article-3.png',
      imageUrl: 'assets/images/article-3.png',
      category: 'Dinh dưỡng',
      timeAgo: '1 giờ trước',
      views: 1450,
      description: 'Tìm hiểu 5 loại nước tốt nhất cho sức khỏe...',
    ),
    ArticleModel(
      id: '5',
      title: 'Hướng dẫn đơn giản cho làn da khỏe',
      author: 'Thảo Lê',
      authorAvatar: 'assets/images/article-4.png',
      imageUrl: 'assets/images/article-4.png',
      category: 'Chăm sóc bản thân',
      timeAgo: '3 giờ trước',
      views: 678,
      description: 'Các bước rửa mặt hợp lý (dầu trạng → sữa rửa mặt → toner) và lựa chọn sản...',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _categories.length, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _selectedTabIndex = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  List<ArticleModel> _getFilteredArticles() {
    if (_selectedTabIndex == 0) return _articles;
    final category = _categories[_selectedTabIndex];
    return _articles.where((article) => article.category == category).toList();
  }

  void _navigateToCreateArticle() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CreateArticleScreen(),
      ),
    );

    if (result == true && mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.pink.shade50,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.person,
                          color: Colors.pink.shade300,
                          size: 28,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Vi',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            Text(
                              'Tin tức có nhãn',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Upload Icon với background trắng, bo tròn và shadow xanh
                      GestureDetector(
                        onTap: _navigateToCreateArticle,
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF00BCD4).withOpacity(0.2),
                                blurRadius: 20,
                                spreadRadius: 5,
                                offset: const Offset(0, 0),
                              ),
                              BoxShadow(
                                color: const Color(0xFF00BCD4).withOpacity(0.1),
                                blurRadius: 30,
                                spreadRadius: 10,
                                offset: const Offset(0, 0),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Image.asset(
                              'assets/images/upload.png',
                              width: 24,
                              height: 24,
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) {
                                return Icon(
                                  Icons.upload_file,
                                  color: const Color(0xFF00BCD4),
                                  size: 24,
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  TabBar(
                    controller: _tabController,
                    isScrollable: true,
                    indicatorColor: Colors.transparent,
                    labelPadding: const EdgeInsets.only(right: 8),
                    dividerColor: Colors.transparent,
                    tabAlignment: TabAlignment.start,
                    padding: EdgeInsets.zero,
                    tabs: _categories.asMap().entries.map((entry) {
                      final index = entry.key;
                      final category = entry.value;
                      final isSelected = _selectedTabIndex == index;

                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: isSelected ? const Color(0xFF00BCD4) : Colors.grey[200],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          category,
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.grey[700],
                            fontSize: 13,
                            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    height: 42,
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: TextField(
                      controller: _searchController,
                      style: const TextStyle(fontSize: 13),
                      decoration: InputDecoration(
                        hintText: 'Tìm bài viết, chủ đề hoặc tác giả...',
                        hintStyle: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 13,
                        ),
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.grey[500],
                          size: 20,
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: _categories.map((category) {
                  final articles = _getFilteredArticles();
                  final featuredArticle = articles.firstWhere(
                        (article) => article.isFeatured,
                    orElse: () => articles.first,
                  );

                  return ListView(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    children: [
                      if (_selectedTabIndex == 0) ...[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: _buildFeaturedArticle(featuredArticle),
                        ),
                        const SizedBox(height: 24),
                      ],
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'Bài viết dành cho bạn',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      ...articles
                          .where((article) => !article.isFeatured || _selectedTabIndex != 0)
                          .map((article) => _buildArticleCard(article)),
                    ],
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeaturedArticle(ArticleModel article) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ArticleDetailScreen(article: article),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade300, width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  article.imageUrl,
                  width: double.infinity,
                  height: 160,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: double.infinity,
                      height: 160,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF00BCD4), Color(0xFF0097A7)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                        child: Icon(Icons.image, size: 60, color: Colors.white54),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.orange.shade100,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Text(
                          'Bài viết nổi bật ',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.orange.shade700,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '🔥',
                          style: TextStyle(fontSize: 11),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Text(
                    article.timeAgo,
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                article.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                  height: 1.3,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  CircleAvatar(
                    radius: 14,
                    backgroundColor: Colors.pink.shade50,
                    child: Icon(
                      Icons.person,
                      size: 16,
                      color: Colors.pink.shade300,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    article.author,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Spacer(),
                  Icon(Icons.more_horiz, color: Colors.grey[600], size: 18),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildArticleCard(ArticleModel article) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ArticleDetailScreen(article: article),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                article.imageUrl,
                width: 120,
                height: 120,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(Icons.image, size: 40, color: Colors.grey[400]),
                  );
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 10,
                        backgroundColor: Colors.pink.shade50,
                        child: Icon(
                          Icons.person,
                          size: 12,
                          color: Colors.pink.shade300,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          article.author,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[700],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Text(
                        '10/2025',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    article.title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                      height: 1.3,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    article.description ?? 'Nội dung bài viết...',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                      height: 1.4,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          article.category,
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                      Text(
                        '${article.views} views',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}