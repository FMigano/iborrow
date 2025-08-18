import 'package:flutter/material.dart';
import '../core/app_export.dart';
import 'home_screen.dart';
import 'library_screen.dart';
import 'saved_screen.dart';
import 'profile_screen.dart';

/// Main navigation wrapper for user screens with modern bottom navigation
class UserMainScreen extends StatefulWidget {
  const UserMainScreen({super.key});

  @override
  State<UserMainScreen> createState() => _UserMainScreenState();
}

class _UserMainScreenState extends State<UserMainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    LibraryScreen(),
    SavedScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.colorFFFFF2,
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: _ModernNavBar(
        index: _currentIndex,
        onChanged: (i) => setState(() => _currentIndex = i),
      ),
    );
  }
}

class _ModernNavBar extends StatelessWidget {
  final int index;
  final ValueChanged<int> onChanged;
  const _ModernNavBar({required this.index, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return NavigationBarTheme(
      data: NavigationBarThemeData(
        height: 56.h,
        backgroundColor: appTheme.colorFFFC85, // restored orange background
        indicatorColor: Colors.white.withValues(alpha: 0.20),
        surfaceTintColor: Colors.transparent,
        labelTextStyle: MaterialStateProperty.resolveWith((states) {
          final selected = states.contains(MaterialState.selected);
          return TextStyleHelper.instance.label12Regular.copyWith(
            color: selected
                ? appTheme.whiteCustom
                : appTheme.whiteCustom.withValues(alpha: 0.85),
            fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
          );
        }),
      ),
      child: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: onChanged,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.home_outlined,
                color: appTheme.whiteCustom.withValues(alpha: 0.85), size: 20.h),
            selectedIcon: _PillIcon(
              icon: Icons.home,
              bgColor: Colors.white.withValues(alpha: 0.25),
              iconColor: appTheme.whiteCustom,
            ),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.library_books_outlined,
                color: appTheme.whiteCustom.withValues(alpha: 0.85), size: 20.h),
            selectedIcon: _PillIcon(
              icon: Icons.library_books,
              bgColor: Colors.white.withValues(alpha: 0.25),
              iconColor: appTheme.whiteCustom,
            ),
            label: 'Library',
          ),
          NavigationDestination(
            icon: Icon(Icons.star_border,
                color: appTheme.whiteCustom.withValues(alpha: 0.85), size: 20.h),
            selectedIcon: _PillIcon(
              icon: Icons.star,
              bgColor: Colors.white.withValues(alpha: 0.25),
              iconColor: appTheme.whiteCustom,
            ),
            label: 'Saved',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline,
                color: appTheme.whiteCustom.withValues(alpha: 0.85), size: 20.h),
            selectedIcon: _PillIcon(
              icon: Icons.person,
              bgColor: Colors.white.withValues(alpha: 0.25),
              iconColor: appTheme.whiteCustom,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class _PillIcon extends StatelessWidget {
  final IconData icon;
  final Color bgColor;
  final Color iconColor;
  const _PillIcon({
    required this.icon,
    required this.bgColor,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40.h,
      height: 28.h,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16.h),
      ),
      alignment: Alignment.center,
      child: Icon(icon, size: 18.h, color: iconColor),
    );
  }
}