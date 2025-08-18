import 'package:flutter/material.dart';
import '../core/app_export.dart';

/// Saved books screen for iBorrow application
/// Redesigned with breadcrumb, clean empty states, and consistent paddings
class SavedScreen extends StatefulWidget {
  const SavedScreen({super.key});

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _showSearchDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Search Saved Books'),
        content: Text('Search functionality coming soon!'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showCreateShelfDialog() {
    final TextEditingController shelfNameController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Create New Shelf',
          style: TextStyleHelper.instance.title18Bold,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: shelfNameController,
              decoration: InputDecoration(
                labelText: 'Shelf Name',
                hintText: 'Enter shelf name',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: TextStyle(color: appTheme.gray500)),
          ),
          ElevatedButton(
            onPressed: () {
              if (shelfNameController.text.isNotEmpty) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Shelf "${shelfNameController.text}" created!',
                    ),
                    backgroundColor: appTheme.primaryOrange,
                  ),
                );
              }
            },
            child: Text('Create'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.lightCream,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16.h),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _Breadcrumb(items: const ['Home', 'Saved']),
                        SizedBox(height: 8.h),
                        Text(
                          'Saved',
                          style: TextStyleHelper.instance.display36RegularInter.copyWith(
                            fontSize: 28.fSize,
                            fontWeight: FontWeight.w700,
                            color: appTheme.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: _showSearchDialog,
                    icon: Icon(Icons.search, size: 24.h, color: appTheme.black),
                  ),
                ],
              ),
            ),
            _TabSwitcher(controller: _tabController),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [_BooksTab(onBrowse: _showSearchDialog), _ShelvesTab(onCreate: _showCreateShelfDialog)],
              ),
            ),
          ],
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

class _TabSwitcher extends StatelessWidget {
  final TabController controller;
  const _TabSwitcher({required this.controller});

  @override
  Widget build(BuildContext context) {
 	  return Container(
		  margin: EdgeInsets.symmetric(horizontal: 16.h),
		  decoration: BoxDecoration(
			color: appTheme.fieldGray.withValues(alpha: 0.3),
			borderRadius: BorderRadius.circular(25.h),
		  ),
		    child: TabBar(
			  controller: controller,
			  labelColor: appTheme.whiteCustom,
			  unselectedLabelColor: appTheme.blackCustom,
			  indicator: BoxDecoration(
				color: appTheme.primaryOrange,
				borderRadius: BorderRadius.circular(25.h),
			  ),
			    indicatorSize: TabBarIndicatorSize.tab,
			    labelStyle: TextStyleHelper.instance.body14.copyWith(
				  fontWeight: FontWeight.w600,
			  ),
			  unselectedLabelStyle: TextStyleHelper.instance.body14.copyWith(
				fontWeight: FontWeight.w400,
			),
			tabs: const [
				Tab(text: 'Books'),
				Tab(text: 'Shelves'),
			  ],
		  ),
	  );
  }
}

class _BooksTab extends StatelessWidget {
  final VoidCallback onBrowse;
  const _BooksTab({required this.onBrowse});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.h),
      child: Column(
        children: [
          SizedBox(height: 16.h),
          Expanded(
            child: _EmptyStateCard(
              icon: Icons.bookmark_border,
              title: 'No saved books yet',
              subtitle: 'Start exploring the library to save your favorite books',
              buttonText: 'Browse Library',
              onTap: onBrowse,
            ),
          ),
        ],
      ),
    );
  }
}

class _ShelvesTab extends StatelessWidget {
  final VoidCallback onCreate;
  const _ShelvesTab({required this.onCreate});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.h),
      child: Column(
        children: [
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'My Shelves',
                style: TextStyleHelper.instance.title18Bold.copyWith(
                  fontSize: 20.fSize,
                ),
              ),
              IconButton(
                onPressed: onCreate,
                icon: Icon(
                  Icons.add,
                  size: 24.h,
                  color: appTheme.primaryOrange,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Expanded(
            child: _EmptyStateCard(
              icon: Icons.library_books,
              title: 'No shelves created yet',
              subtitle: 'Create shelves to organize your favorite books',
              buttonText: 'Create Shelf',
              onTap: onCreate,
            ),
          ),
        ],
      ),
    );
  }
}

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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 60.h, color: appTheme.greyCustom),
          SizedBox(height: 12.h),
          Text(
            title,
            style: TextStyleHelper.instance.title18Bold.copyWith(
              color: appTheme.black,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8.h),
          Text(
            subtitle,
            style: TextStyleHelper.instance.body14.copyWith(
              color: appTheme.greyCustom,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16.h),
          SizedBox(
            height: 42.h,
            child: ElevatedButton(
              onPressed: onTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: appTheme.primaryOrange,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 20.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.h),
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