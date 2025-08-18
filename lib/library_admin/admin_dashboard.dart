import 'package:flutter/material.dart';
import '../core/app_export.dart';

/// Admin dashboard for iBorrow application
/// Main screen for library administrators to manage books and users
class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.colorFFFFF2,
      appBar: AppBar(
        backgroundColor: appTheme.colorFFBA5A,
        title: Text(
          'iBorrow - Admin Panel',
          style: TextStyleHelper.instance.title18Bold.copyWith(
            color: appTheme.whiteCustom,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, color: appTheme.whiteCustom),
            onPressed: () => _showComingSoon('Notifications'),
          ),
          IconButton(
            icon: Icon(Icons.logout, color: appTheme.whiteCustom),
            onPressed: _onLogout,
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStatsSection(),
            SizedBox(height: 24.h),
            _buildQuickActions(),
            SizedBox(height: 24.h),
            _buildRecentActivity(),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsSection() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.h),
      decoration: BoxDecoration(
        color: appTheme.whiteCustom,
        borderRadius: BorderRadius.circular(12.h),
        boxShadow: [
          BoxShadow(
            color: appTheme.greyCustom.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Library Statistics',
            style: TextStyleHelper.instance.title18Bold,
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                child: _buildStatCard('Total Books', '1,254', Icons.book),
              ),
              SizedBox(width: 12.h),
              Expanded(
                child: _buildStatCard('Active Users', '342', Icons.people),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(child: _buildStatCard('Borrowed', '89', Icons.bookmark)),
              SizedBox(width: 12.h),
              Expanded(child: _buildStatCard('Overdue', '7', Icons.warning)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(12.h),
      decoration: BoxDecoration(
        color: appTheme.colorFFFFF2,
        borderRadius: BorderRadius.circular(8.h),
        border: Border.all(color: appTheme.colorFFBA5A.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, size: 24.h, color: appTheme.colorFFBA5A),
          SizedBox(height: 8.h),
          Text(
            value,
            style: TextStyleHelper.instance.title18Bold.copyWith(
              color: appTheme.colorFFBA5A,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            title,
            style: TextStyleHelper.instance.label12Regular,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Quick Actions', style: TextStyleHelper.instance.title18Bold),
        SizedBox(height: 16.h),
        Row(
          children: [
            Expanded(
              child: _buildActionCard(
                'Add Book',
                Icons.add_box,
                () => _showComingSoon('Add Book'),
              ),
            ),
            SizedBox(width: 12.h),
            Expanded(
              child: _buildActionCard(
                'Manage Users',
                Icons.people_alt,
                () => _showComingSoon('Manage Users'),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        Row(
          children: [
            Expanded(
              child: _buildActionCard(
                'View Reports',
                Icons.analytics,
                () => _showComingSoon('View Reports'),
              ),
            ),
            SizedBox(width: 12.h),
            Expanded(
              child: _buildActionCard(
                'Settings',
                Icons.settings,
                () => _showComingSoon('Settings'),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionCard(String title, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 80.h,
        decoration: BoxDecoration(
          color: appTheme.whiteCustom,
          borderRadius: BorderRadius.circular(12.h),
          border: Border.all(color: appTheme.colorFFBA5A.withValues(alpha: 0.3)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 24.h, color: appTheme.colorFFBA5A),
            SizedBox(height: 8.h),
            Text(
              title,
              style: TextStyleHelper.instance.label12Regular,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentActivity() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Recent Activity', style: TextStyleHelper.instance.title18Bold),
        SizedBox(height: 16.h),
        Expanded(
          child: ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) {
              return _buildActivityItem(
                'User borrowed "Book Title ${index + 1}"',
                '${index + 1} hour${index == 0 ? '' : 's'} ago',
                Icons.bookmark_add,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildActivityItem(String title, String time, IconData icon) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.all(12.h),
      decoration: BoxDecoration(
        color: appTheme.whiteCustom,
        borderRadius: BorderRadius.circular(8.h),
        border: Border.all(color: appTheme.grey200),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.h),
            decoration: BoxDecoration(
              color: appTheme.colorFFBA5A.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8.h),
            ),
            child: Icon(icon, size: 16.h, color: appTheme.colorFFBA5A),
          ),
          SizedBox(width: 12.h),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyleHelper.instance.body13Regular),
                SizedBox(height: 4.h),
                Text(
                  time,
                  style: TextStyleHelper.instance.label10Regular.copyWith(
                    color: appTheme.greyCustom,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showComingSoon(String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$feature feature coming soon!'),
        backgroundColor: appTheme.colorFFBA5A,
      ),
    );
  }

  void _onLogout() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Logout'),
          content: Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                try {
                  await Supabase.instance.client.auth.signOut();
                } catch (_) {}
                NavigatorService.pushReplacementNamed(AppRoutes.loginScreen);
              },
              child: Text('Logout'),
            ),
          ],
        );
      },
    );
  }
}
