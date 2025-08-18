import 'package:flutter/material.dart';
import '../core/app_export.dart';
import '../widgets/custom_image_view.dart';

/// Home screen showing user's dashboard with currently borrowing books and recommendations
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Mock user data - replace with actual user data from Supabase
  final String userName = "BookLover123";

  // Mock book data - replace with actual data from Supabase
  final List<BookModel> currentlyBorrowing = [
    BookModel(
      title: "The Quantum Universe",
      author: "Brian Cox",
      coverUrl:
          "https://images.unsplash.com/photo-1544716278-ca5e3f4abd8c?w=300",
      dueDate: "2025-08-21",
    ),
  ];

  final List<BookModel> scienceFictionBooks = [
    BookModel(
      title: "Dune",
      author: "Frank Herbert",
      coverUrl:
          "https://images.unsplash.com/photo-1589829085413-56de8ae18c73?w=300",
    ),
    BookModel(
      title: "Foundation",
      author: "Isaac Asimov",
      coverUrl:
          "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=300",
    ),
    BookModel(
      title: "Neuromancer",
      author: "William Gibson",
      coverUrl:
          "https://images.unsplash.com/photo-1481627834876-b7833e8f5570?w=300",
    ),
  ];

  final List<BookModel> recommendedBooks = [
    BookModel(
      title: "Sapiens",
      author: "Yuval Noah Harari",
      coverUrl:
          "https://images.unsplash.com/photo-1512820790803-83ca734da794?w=300",
    ),
    BookModel(
      title: "The Midnight Library",
      author: "Matt Haig",
      coverUrl:
          "https://images.unsplash.com/photo-1535905557558-afc4877cca3d?w=300",
    ),
    BookModel(
      title: "Atomic Habits",
      author: "James Clear",
      coverUrl:
          "https://images.unsplash.com/photo-1544947950-fa07a98d237f?w=300",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.colorFFFFF2,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(bottom: 80.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top app bar area
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 16.h),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppBreadcrumb(items: const ['Home']),
                          SizedBox(height: 10.h),
                          Text(
                            'Welcome back, $userName',
                            style: TextStyleHelper.instance.title18Bold.copyWith(
                              fontSize: 20.fSize,
                            ),
                          ),
                          SizedBox(height: 6.h),
                          Text(
                            'Find your next great read',
                            style: TextStyleHelper.instance.body13Regular.copyWith(
                              color: appTheme.greyCustom,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: _showNotifications,
                      icon: Icon(
                        Icons.notifications_outlined,
                        size: 24.h,
                        color: appTheme.blackCustom,
                      ),
                    ),
                  ],
                ),
              ),

              // Search CTA
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.h),
                child: _BrowseLibraryButton(onTap: _onBrowseLibrary),
              ),
              SizedBox(height: 16.h),

              // Currently Borrowing
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.h),
                child: SectionHeader(
                  title: 'Currently Borrowing',
                  trailing: currentlyBorrowing.isNotEmpty
                      ? GestureDetector(
                          onTap: () {},
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Details',
                                style: TextStyleHelper.instance.body13Regular.copyWith(
                                  color: appTheme.colorFFBA5A,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(width: 6.h),
                              Icon(Icons.open_in_new, size: 16.h, color: appTheme.colorFFBA5A),
                            ],
                          ),
                        )
                      : null,
                ),
              ),
              SizedBox(height: 10.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.h),
                child: currentlyBorrowing.isNotEmpty
                    ? _BorrowingLargeCard(book: currentlyBorrowing.first)
                    : _EmptyStateCard(
                        icon: Icons.book_outlined,
                        title: 'No books currently borrowed',
                        subtitle: 'Browse the library and borrow your first book',
                        buttonText: 'Browse Library',
                        onTap: _onBrowseLibrary,
                      ),
              ),

              SizedBox(height: 24.h),

              // Science Fiction Section
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.h),
                child: SectionHeader(
                  title: 'Science Fiction',
                  trailing: _SeeAll(onTap: () {}),
                ),
              ),
              SizedBox(height: 12.h),
              SizedBox(height: 180.h, child: _HorizontalBooks(books: scienceFictionBooks)),

              SizedBox(height: 24.h),

              // Recommended Section
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.h),
                child: SectionHeader(
                  title: 'Recommended for You',
                  trailing: _SeeAll(onTap: _onSeeAllRecommended),
                ),
              ),
              SizedBox(height: 12.h),
              SizedBox(height: 180.h, child: _HorizontalBooks(books: recommendedBooks)),
            ],
          ),
        ),
      ),
    );
  }

  void _showNotifications() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Notifications feature coming soon!'),
        backgroundColor: appTheme.colorFFFC85,
      ),
    );
  }

  void _onBrowseLibrary() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Browse Library functionality coming soon!'),
        backgroundColor: appTheme.colorFFFC85,
      ),
    );
  }

  void _onSeeAllRecommended() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('View all recommended books coming soon!'),
        backgroundColor: appTheme.colorFFFC85,
      ),
    );
  }
}

/// Breadcrumb component
class AppBreadcrumb extends StatelessWidget {
  final List<String> items;
  const AppBreadcrumb({super.key, required this.items});

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

/// Section header with optional trailing action
class SectionHeader extends StatelessWidget {
  final String title;
  final Widget? trailing;

  const SectionHeader({super.key, required this.title, this.trailing});

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

/// Small "See all" action
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

/// Browse Library button (prominent)
class _BrowseLibraryButton extends StatelessWidget {
  final VoidCallback onTap;
  const _BrowseLibraryButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48.h,
      decoration: BoxDecoration(
        color: appTheme.whiteCustom,
        borderRadius: BorderRadius.circular(10.h),
        border: Border.all(color: appTheme.blackCustom, width: 1),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10.h),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.h),
          child: Row(
            children: [
              Icon(Icons.search, size: 22.h, color: appTheme.blackCustom),
              SizedBox(width: 10.h),
              Expanded(
                child: Text(
                  'Explore our Library',
                  style: TextStyleHelper.instance.body16Regular,
                ),
              ),
              Icon(Icons.arrow_forward_ios, size: 14.h, color: appTheme.blackCustom),
            ],
          ),
        ),
      ),
    );
  }
}

/// Large borrowing card
class _BorrowingLargeCard extends StatelessWidget {
  final BookModel book;
  const _BorrowingLargeCard({required this.book});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 156.h,
      decoration: BoxDecoration(
        color: appTheme.whiteCustom,
        borderRadius: BorderRadius.circular(12.h),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(color: appTheme.grey200),
      ),
      child: Row(
        children: [
          // Cover
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12.h),
              bottomLeft: Radius.circular(12.h),
            ),
            child: SizedBox(
              width: 120.h,
              height: 156.h,
              child: CustomImageView(
                imagePath: book.coverUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Details
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(14.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    book.title,
                    style: TextStyleHelper.instance.body16Regular.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    'by ${book.author}',
                    style: TextStyleHelper.instance.body13Regular.copyWith(
                      color: appTheme.greyCustom,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: appTheme.colorFFFC85.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(6.h),
                        ),
                        child: Text(
                          'Due: ${book.dueDate}',
                          style: TextStyleHelper.instance.label12Regular.copyWith(
                            color: appTheme.colorFFBA5A,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Icon(Icons.more_horiz, color: appTheme.greyCustom, size: 20.h),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Generic empty state card
class _EmptyStateCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String buttonText;
  final VoidCallback onTap;

  const _EmptyStateCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.buttonText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.h),
      decoration: BoxDecoration(
        color: appTheme.whiteCustom,
        borderRadius: BorderRadius.circular(12.h),
        border: Border.all(color: appTheme.grey200),
      ),
      child: Column(
        children: [
          Icon(icon, size: 40.h, color: appTheme.greyCustom),
          SizedBox(height: 10.h),
          Text(
            title,
            style: TextStyleHelper.instance.title18Bold.copyWith(
              color: appTheme.black,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 6.h),
          Text(
            subtitle,
            style: TextStyleHelper.instance.body13Regular.copyWith(
              color: appTheme.greyCustom,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 14.h),
          SizedBox(
            height: 40.h,
            child: ElevatedButton(
              onPressed: onTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: appTheme.colorFFBA5A,
                foregroundColor: appTheme.white,
                padding: EdgeInsets.symmetric(horizontal: 18.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.h),
                ),
              ),
              child: Text(
                buttonText,
                style: TextStyleHelper.instance.buttonText,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Horizontal books scroller
class _HorizontalBooks extends StatelessWidget {
  final List<BookModel> books;
  const _HorizontalBooks({required this.books});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 20.h),
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, i) => _BookCardCompact(book: books[i]),
      separatorBuilder: (_, __) => SizedBox(width: 14.h),
      itemCount: books.length,
    );
  }
}

/// Compact book card
class _BookCardCompact extends StatelessWidget {
  final BookModel book;
  const _BookCardCompact({required this.book});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 132.h,
      decoration: BoxDecoration(
        color: appTheme.whiteCustom,
        borderRadius: BorderRadius.circular(10.h),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // cover
            Expanded(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: CustomImageView(
                      imagePath: book.coverUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned.fill(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withValues(alpha: 0.4),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // meta
            Padding(
              padding: EdgeInsets.all(10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    book.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyleHelper.instance.body13Regular.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    book.author,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyleHelper.instance.label12Regular.copyWith(
                      color: appTheme.blackCustom.withValues(alpha: 0.6),
                    ),
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

/// Book model class for representing book data
class BookModel {
  final String title;
  final String author;
  final String coverUrl;
  final String? dueDate;

  BookModel({
    required this.title,
    required this.author,
    required this.coverUrl,
    this.dueDate,
  });
}