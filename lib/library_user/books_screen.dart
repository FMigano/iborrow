import 'package:flutter/material.dart';
import '../core/app_export.dart';
import 'book_detail_screen.dart';

/// Books/Library screen for iBorrow application
/// Redesigned with breadcrumb, consistent paddings, and pleasant cards
class BooksScreen extends StatefulWidget {
  const BooksScreen({super.key});

  @override
  State<BooksScreen> createState() => _BooksScreenState();
}

class _BooksScreenState extends State<BooksScreen> {
  final TextEditingController _searchController = TextEditingController();

  // Sample book data - replace with real data from Supabase
  final List<Map<String, dynamic>> topReadBooks = [
    {
      'title': 'The Great Gatsby',
      'author': 'F. Scott Fitzgerald',
      'image': 'https://covers.openlibrary.org/b/id/8225261-M.jpg',
      'rating': 4.5,
      'category': 'Classic Literature',
    },
    {
      'title': 'To Kill a Mockingbird',
      'author': 'Harper Lee',
      'image': 'https://covers.openlibrary.org/b/id/8434586-M.jpg',
      'rating': 4.8,
      'category': 'Classic Literature',
    },
    {
      'title': '1984',
      'author': 'George Orwell',
      'image': 'https://covers.openlibrary.org/b/id/7222246-M.jpg',
      'rating': 4.7,
      'category': 'Dystopian Fiction',
    },
    {
      'title': 'Pride and Prejudice',
      'author': 'Jane Austen',
      'image': 'https://covers.openlibrary.org/b/id/7883916-M.jpg',
      'rating': 4.6,
      'category': 'Romance',
    },
    {
      'title': 'The Catcher in the Rye',
      'author': 'J.D. Salinger',
      'image': 'https://covers.openlibrary.org/b/id/8133317-M.jpg',
      'rating': 4.2,
      'category': 'Coming of Age',
    },
    {
      'title': 'Lord of the Flies',
      'author': 'William Golding',
      'image': 'https://covers.openlibrary.org/b/id/8134974-M.jpg',
      'rating': 4.3,
      'category': 'Adventure',
    },
  ];

  final List<Map<String, dynamic>> recommendedBooks = [
    {
      'title': 'Dune',
      'author': 'Frank Herbert',
      'image': 'https://covers.openlibrary.org/b/id/8234166-M.jpg',
      'rating': 4.6,
      'category': 'Science Fiction',
    },
    {
      'title': 'The Hobbit',
      'author': 'J.R.R. Tolkien',
      'image': 'https://covers.openlibrary.org/b/id/6979861-M.jpg',
      'rating': 4.7,
      'category': 'Fantasy',
    },
    {
      'title': 'Fahrenheit 451',
      'author': 'Ray Bradbury',
      'image': 'https://covers.openlibrary.org/b/id/8194018-M.jpg',
      'rating': 4.4,
      'category': 'Dystopian Fiction',
    },
  ];

  final List<String> categories = const [
    'All',
    'Fiction',
    'Non-Fiction',
    'Sci-Fi',
    'Romance',
    'Classics',
  ];
  int selectedCategory = 0;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    // TODO: Implement search functionality
  }

  void _onViewAllRecommended() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('View all recommended books coming soon!'),
        backgroundColor: appTheme.colorFFFC85,
      ),
    );
  }

  void _onBookTapped(Map<String, dynamic> book) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BookDetailScreen(book: book)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.colorFFFFF2,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Breadcrumb(items: const ['Home', 'Library']),
                SizedBox(height: 12.h),
                Text(
                  'Browse Library',
                  style: TextStyleHelper.instance.display36Regular.copyWith(
                    fontSize: 28.fSize,
                    height: 1.1,
                  ),
                ),
                SizedBox(height: 16.h),
                _SearchBar(
                  controller: _searchController,
                  onChanged: _onSearchChanged,
                ),
                SizedBox(height: 14.h),
                _CategoryChips(
                  categories: categories,
                  selectedIndex: selectedCategory,
                  onSelected: (i) => setState(() => selectedCategory = i),
                ),
                SizedBox(height: 24.h),

                // Top Read
                _SectionHeader(
                  title: 'Top Read',
                  trailing: _SeeAll(onTap: () {}),
                ),
                SizedBox(height: 12.h),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.72,
                    crossAxisSpacing: 14.h,
                    mainAxisSpacing: 14.h,
                  ),
                  itemCount: topReadBooks.length,
                  itemBuilder: (context, index) {
                    final book = topReadBooks[index];
                    return _BookCard(
                      book: book,
                      onTap: () => _onBookTapped(book),
                    );
                  },
                ),
                SizedBox(height: 24.h),

                // Recommended
                _SectionHeader(
                  title: 'Recommended For You',
                  trailing: _SeeAll(onTap: _onViewAllRecommended),
                ),
                SizedBox(height: 12.h),
                SizedBox(
                  height: 190.h,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: recommendedBooks.length,
                    separatorBuilder: (_, __) => SizedBox(width: 14.h),
                    itemBuilder: (context, index) {
                      final book = recommendedBooks[index];
                      return SizedBox(
                        width: 150.h,
                        child: _BookCard(
                          book: book,
                          onTap: () => _onBookTapped(book),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Breadcrumb extends StatelessWidget {
  final List<String> items;
  const _Breadcrumb({required this.items});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 6.h,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        for (int i = 0; i < items.length; i++) ...[
          Text(
            items[i],
            style: TextStyleHelper.instance.label12Regular.copyWith(
              color: appTheme.greyCustom,
            ),
          ),
          if (i != items.length - 1)
            Icon(Icons.chevron_right, size: 14.h, color: appTheme.greyCustom),
        ],
      ],
    );
  }
}

class _SearchBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  const _SearchBar({required this.controller, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: 'Search by title, author, or genre',
        prefixIcon: Icon(Icons.search, color: appTheme.blackCustom),
        filled: true,
      ),
      style: TextStyleHelper.instance.body16Regular,
    );
  }
}

class _CategoryChips extends StatelessWidget {
  final List<String> categories;
  final int selectedIndex;
  final ValueChanged<int> onSelected;
  const _CategoryChips({
    required this.categories,
    required this.selectedIndex,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, __) => SizedBox(width: 8.h),
        itemBuilder: (context, i) {
          final selected = i == selectedIndex;
          return InkWell(
            onTap: () => onSelected(i),
            borderRadius: BorderRadius.circular(18.h),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.h),
              decoration: BoxDecoration(
                color: selected
                    ? appTheme.primaryOrange.withValues(alpha: 0.15)
                    : appTheme.whiteCustom,
                borderRadius: BorderRadius.circular(18.h),
                border: Border.all(
                  color: selected ? appTheme.primaryOrange : appTheme.grey200,
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                categories[i],
                style: TextStyleHelper.instance.label12Regular.copyWith(
                  color: selected ? appTheme.primaryOrange : appTheme.blackCustom,
                  fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final Widget? trailing;
  const _SectionHeader({required this.title, this.trailing});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyleHelper.instance.title18Bold.copyWith(
            fontSize: 20.fSize,
          ),
        ),
        const Spacer(),
        if (trailing != null) trailing!,
      ],
    );
  }
}

class _SeeAll extends StatelessWidget {
  final VoidCallback onTap;
  const _SeeAll({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6.h),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 6.h),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('See all', style: TextStyleHelper.instance.body13Regular),
            SizedBox(width: 6.h),
            Icon(Icons.arrow_forward_ios, size: 12.h, color: appTheme.blackCustom),
          ],
        ),
      ),
    );
  }
}

class _BookCard extends StatelessWidget {
  final Map<String, dynamic> book;
  final VoidCallback onTap;
  const _BookCard({required this.book, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: appTheme.whiteCustom,
          borderRadius: BorderRadius.circular(12.h),
          boxShadow: [
            BoxShadow(
              color: appTheme.greyCustom.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
          border: Border.all(color: appTheme.grey200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cover
            Expanded(
              flex: 6,
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(12.h)),
                child: Image.network(
                  book['image'],
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: appTheme.colorFFFC85.withValues(alpha: 0.2),
                      child: Center(
                        child: Icon(Icons.book, size: 40.h, color: appTheme.colorFFFC85),
                      ),
                    );
                  },
                ),
              ),
            ),
            // Meta
            Expanded(
              flex: 4,
              child: Padding(
                padding: EdgeInsets.all(12.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      book['title'],
                      style: TextStyleHelper.instance.body13Regular.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 14.fSize,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      book['author'],
                      style: TextStyleHelper.instance.label12Regular.copyWith(
                        color: appTheme.greyCustom,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Icon(Icons.star, size: 14.h, color: Colors.amber),
                        SizedBox(width: 4.h),
                        Text(
                          (book['rating'] ?? 0).toString(),
                          style: TextStyleHelper.instance.label12Regular.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}