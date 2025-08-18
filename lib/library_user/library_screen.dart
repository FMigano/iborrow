import 'package:flutter/material.dart';
import '../core/app_export.dart';

/// Library screen showing all available books for browsing
/// Redesigned with breadcrumb, filters, and pleasant grid
class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  final List<Map<String, dynamic>> allBooks = [
    {
      'title': 'Dune',
      'author': 'Frank Herbert',
      'image': 'https://covers.openlibrary.org/b/id/8234166-M.jpg',
      'rating': 4.6,
    },
    {
      'title': 'The Hobbit',
      'author': 'J.R.R. Tolkien',
      'image': 'https://covers.openlibrary.org/b/id/6979861-M.jpg',
      'rating': 4.7,
    },
    {
      'title': 'Sapiens',
      'author': 'Yuval Noah Harari',
      'image': 'https://covers.openlibrary.org/b/id/8128690-M.jpg',
      'rating': 4.5,
    },
    {
      'title': '1984',
      'author': 'George Orwell',
      'image': 'https://covers.openlibrary.org/b/id/7222246-M.jpg',
      'rating': 4.7,
    },
  ];

	final List<String> filters = const ['All', 'New', 'Popular', 'Available'];
	int selectedFilter = 0;

	final TextEditingController _searchCtrl = TextEditingController();

	@override
	void dispose() {
		_searchCtrl.dispose();
		super.dispose();
	}

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			backgroundColor: appTheme.colorFFFFF2,
			body: SafeArea(
				child: Padding(
					padding: EdgeInsets.all(20.h),
					child: Column(
						crossAxisAlignment: CrossAxisAlignment.start,
						children: [
							_Breadcrumb(items: const ['Home', 'Library']),
							SizedBox(height: 12.h),
							Text(
								'Library',
								style: TextStyleHelper.instance.display36Regular.copyWith(
									fontSize: 28.fSize,
									height: 1.1,
								),
							),
							SizedBox(height: 16.h),
							_LibrarySearchBar(
								controller: _searchCtrl,
								onChanged: (v) {},
							),
							SizedBox(height: 16.h),
							_FilterChips(
								filters: filters,
								selectedIndex: selectedFilter,
								onSelected: (i) => setState(() => selectedFilter = i),
							),
							SizedBox(height: 16.h),
							Expanded(
								child: GridView.builder(
									gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
										crossAxisCount: 2,
										childAspectRatio: 0.72,
										crossAxisSpacing: 14.h,
										mainAxisSpacing: 14.h,
									),
									itemCount: allBooks.length,
									itemBuilder: (context, index) {
										final book = allBooks[index];
										return _BookCard(book: book);
									},
								),
							),
						],
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

class _FilterChips extends StatelessWidget {
  final List<String> filters;
  final int selectedIndex;
  final ValueChanged<int> onSelected;
  const _FilterChips({
    required this.filters,
    required this.selectedIndex,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
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
                filters[i],
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

class _BookCard extends StatelessWidget {
  final Map<String, dynamic> book;
  const _BookCard({required this.book});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: appTheme.whiteCustom,
        borderRadius: BorderRadius.circular(12.h),
        border: Border.all(color: appTheme.grey200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.network(
                      book['image'],
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
                  Positioned(
                    left: 8.h,
                    top: 8.h,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 6.h, vertical: 2.h),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(6.h),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.star, color: Colors.amber, size: 12.h),
                          SizedBox(width: 3.h),
                          Text(
                            (book['rating'] ?? 0).toString(),
                            style: TextStyleHelper.instance.label12Regular.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(12.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    book['title'],
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyleHelper.instance.body13Regular.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    book['author'],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyleHelper.instance.label12Regular.copyWith(
                      color: appTheme.greyCustom,
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
class _LibrarySearchBar extends StatelessWidget {
	final TextEditingController controller;
	final ValueChanged<String> onChanged;
	const _LibrarySearchBar({required this.controller, required this.onChanged});

	@override
	Widget build(BuildContext context) {
		return Container(
			height: 48.h,
			decoration: BoxDecoration(
				color: appTheme.whiteCustom,
				borderRadius: BorderRadius.circular(10.h),
				border: Border.all(color: appTheme.blackCustom, width: 1),
			),
			child: Padding(
				padding: EdgeInsets.symmetric(horizontal: 14.h),
				child: Row(
					children: [
						Icon(Icons.search, size: 22.h, color: appTheme.blackCustom),
						SizedBox(width: 10.h),
						Expanded(
							child: TextField(
								controller: controller,
								onChanged: onChanged,
								decoration: const InputDecoration(
									isCollapsed: true,
									border: InputBorder.none,
									hintText: 'Search by title, author, or genre',
								),
								style: TextStyleHelper.instance.body16Regular,
							),
						),
						Icon(Icons.arrow_forward_ios, size: 14.h, color: appTheme.blackCustom),
					],
				),
			),
		);
	}
}