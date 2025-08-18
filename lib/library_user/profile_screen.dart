import 'package:flutter/material.dart';
import '../core/app_export.dart';

/// Profile screen showing user's account information and settings
/// Redesigned with breadcrumb, consistent paddings, and tidy cards
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  void _showEditProfile() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Edit profile functionality coming soon!'),
        backgroundColor: appTheme.primaryOrange,
      ),
    );
  }

  void _showAccountSettings() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Account settings coming soon!'),
        backgroundColor: appTheme.primaryOrange,
      ),
    );
  }

  void _showNotificationSettings() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Notification settings coming soon!'),
        backgroundColor: appTheme.primaryOrange,
      ),
    );
  }

  void _showPrivacySettings() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Privacy settings coming soon!'),
        backgroundColor: appTheme.primaryOrange,
      ),
    );
  }

  void _showHelpSupport() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Help & support coming soon!'),
        backgroundColor: appTheme.primaryOrange,
      ),
    );
  }

  void _onLogout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Logout', style: TextStyleHelper.instance.title18Bold),
        content: Text(
          'Are you sure you want to logout?',
          style: TextStyleHelper.instance.body16Regular,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: TextStyle(color: appTheme.gray500)),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              try {
                await Supabase.instance.client.auth.signOut();
              } catch (_) {}
              NavigatorService.pushReplacementNamed(AppRoutes.loginScreen);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade400,
            ),
            child: Text('Logout', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _statItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(12.h),
          decoration: BoxDecoration(
            color: appTheme.primaryOrange.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12.h),
          ),
          child: Icon(icon, size: 24.h, color: appTheme.primaryOrange),
        ),
        SizedBox(height: 8.h),
        Text(
          value,
          style: TextStyleHelper.instance.title18Bold.copyWith(
            fontSize: 20.fSize,
            color: appTheme.black,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          label,
          style: TextStyleHelper.instance.label12Regular.copyWith(
            color: appTheme.gray500,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _settingItem(String title, IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 16.h),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: appTheme.fieldGray.withValues(alpha: 0.3),
              width: 1,
            ),
          ),
        ),
        child: Row(
          children: [
            Icon(icon, size: 24.h, color: appTheme.gray500),
            SizedBox(width: 16.h),
            Expanded(
              child: Text(
                title,
                style: TextStyleHelper.instance.body16Regular.copyWith(
                  color: appTheme.black,
                ),
              ),
            ),
            Icon(Icons.arrow_forward_ios, size: 16.h, color: appTheme.gray500),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.lightCream,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header + Breadcrumb
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _Breadcrumb(items: const ['Home', 'Profile']),
                        SizedBox(height: 8.h),
                        Text(
                          'Profile',
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
                    onPressed: _showEditProfile,
                    icon: Icon(Icons.edit, size: 24.h, color: appTheme.black),
                  ),
                ],
              ),
              SizedBox(height: 24.h),

              // Profile Card
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.h),
                  boxShadow: [
                    BoxShadow(
                      color: appTheme.gray500.withValues(alpha: 0.08),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50.h,
                      backgroundColor: appTheme.primaryOrange.withValues(alpha: 0.15),
                      child: Icon(
                        Icons.person,
                        size: 60.h,
                        color: appTheme.primaryOrange,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'John Doe',
                      style: TextStyleHelper.instance.title18Bold.copyWith(
                        fontSize: 24.fSize,
                        color: appTheme.black,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'john.doe@university.edu',
                      style: TextStyleHelper.instance.body14.copyWith(
                        color: appTheme.gray500,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: appTheme.primaryOrange.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12.h),
                      ),
                      child: Text(
                        'Computer Science Student',
                        style: TextStyleHelper.instance.label12Regular.copyWith(
                          color: appTheme.primaryOrange,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.h),

              // Stats
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.h),
                  boxShadow: [
                    BoxShadow(
                      color: appTheme.gray500.withValues(alpha: 0.08),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Library Stats',
                      style: TextStyleHelper.instance.title18Bold.copyWith(
                        fontSize: 18.fSize,
                        color: appTheme.black,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      children: [
                        Expanded(child: _statItem('Books Borrowed', '12', Icons.book)),
                        Expanded(child: _statItem('Books Saved', '5', Icons.bookmark)),
                        Expanded(child: _statItem('Overdue', '0', Icons.warning)),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.h),

              // Settings
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.h),
                  boxShadow: [
                    BoxShadow(
                      color: appTheme.gray500.withValues(alpha: 0.08),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(20.h),
                      child: Text(
                        'Settings',
                        style: TextStyleHelper.instance.title18Bold.copyWith(
                          fontSize: 18.fSize,
                          color: appTheme.black,
                        ),
                      ),
                    ),
                    _settingItem('Account Settings', Icons.settings, _showAccountSettings),
                    _settingItem('Notification Preferences', Icons.notifications, _showNotificationSettings),
                    _settingItem('Privacy & Security', Icons.shield, _showPrivacySettings),
                    _settingItem('Help & Support', Icons.help, _showHelpSupport),
                    _settingItem('About iBorrow', Icons.info, _showHelpSupport),
                  ],
                ),
              ),
              SizedBox(height: 24.h),

              // Logout Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _onLogout,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.shade400,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.h),
                    ),
                  ),
                  child: Text(
                    'Logout',
                    style: TextStyleHelper.instance.body16Regular.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
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
              color: appTheme.gray500,
            ),
          ),
          if (i != items.length - 1)
            Icon(Icons.chevron_right, size: 14.h, color: appTheme.gray500),
        ],
      ],
    );
  }
}