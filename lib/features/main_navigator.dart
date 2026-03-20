import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../core/theme/app_colors.dart';
import '../core/widgets/glass_card.dart';
import '../models/app_mode.dart';
import 'home/screens/home_screen.dart';
import 'home/screens/analytics_screen.dart';
import 'home/screens/alert_center_screen.dart';
import 'home/screens/profile_settings_screen.dart';
import 'hospital/screens/patient_monitoring_screen.dart';
import 'hospital/screens/hospital_analytics_screen.dart';
import 'government/screens/government_dashboard_screen.dart';
import 'splash/screens/splash_screen.dart';

class MainNavigator extends StatefulWidget {
  const MainNavigator({super.key});

  @override
  State<MainNavigator> createState() => _MainNavigatorState();
}

class _MainNavigatorState extends State<MainNavigator> {
  int _currentIndex = 0;

  final List<Widget> _homeTabs = const [
    HomeScreen(),
    AnalyticsScreen(),
    AlertCenterScreen(),
    ProfileSettingsScreen(),
  ];

  final List<Widget> _hospitalTabs = const [
    PatientMonitoringScreen(),
    HospitalAnalyticsScreen(),
    AlertCenterScreen(),
    ProfileSettingsScreen(),
  ];

  final List<Widget> _govTabs = const [
    GovernmentDashboardScreen(),
    AnalyticsScreen(),
    AlertCenterScreen(),
    ProfileSettingsScreen(),
  ];

  String _getModeLabel(AppMode m) => m == AppMode.hospital
      ? "HOSPITAL"
      : m == AppMode.government
          ? "GOVERNMENT"
          : "HOME";
  Color _getModeColor(AppMode m) => m == AppMode.hospital
      ? AppColors.secondary
      : m == AppMode.government
          ? AppColors.warning
          : AppColors.primary;
  IconData _getModeIcon(AppMode m) => m == AppMode.hospital
      ? Icons.local_hospital
      : m == AppMode.government
          ? Icons.account_balance
          : Icons.home;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<AppMode>(
      valueListenable: appModeNotifier,
      builder: (context, currentMode, _) {
        final currentTabs = currentMode == AppMode.hospital
            ? _hospitalTabs
            : currentMode == AppMode.government
                ? _govTabs
                : _homeTabs;
        if (_currentIndex >= currentTabs.length) _currentIndex = 0;
        final mColor = _getModeColor(currentMode);

        return Scaffold(
          extendBody: true,
          body: Stack(
            children: [
              _buildBackgroundGlow(mColor),
              SafeArea(
                bottom: false,
                child: Column(
                  children: [
                    _buildTopBar(context, currentMode, mColor),
                    Expanded(
                        child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            child: currentTabs[_currentIndex])),
                  ],
                ),
              ),
            ],
          ),
          floatingActionButton:
              currentMode == AppMode.home ? _buildFab() : null,
          bottomNavigationBar: _buildBottomNav(currentMode),
        );
      },
    );
  }

  Widget _buildBackgroundGlow(Color mColor) {
    return Stack(
      children: [
        Positioned(
            top: -150,
            left: -150,
            child: _GlowDisk(color: mColor.withOpacity(0.15))),
        Positioned(
            bottom: -150,
            right: -150,
            child: _GlowDisk(color: AppColors.secondary.withOpacity(0.1))),
      ],
    );
  }

  Widget _buildTopBar(BuildContext context, AppMode mode, Color color) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
        child: Row(children: [
          GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacement(PageRouteBuilder(
                  pageBuilder: (_, __, ___) =>
                      const SplashScreen(immediatePortals: true),
                  transitionDuration: const Duration(milliseconds: 800),
                  transitionsBuilder: (_, animation, __, child) =>
                      FadeTransition(opacity: animation, child: child),
                ));
              },
              child: GlassCard(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  borderRadius: BorderRadius.circular(12),
                  child: const Row(children: [
                    Icon(Icons.arrow_back_ios_new,
                        size: 14, color: AppColors.text1),
                    SizedBox(width: 6),
                    Text("Portals",
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold))
                  ]))),
          const Spacer(),
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: color)),
              child: Row(children: [
                Icon(_getModeIcon(mode), size: 12, color: color),
                const SizedBox(width: 6),
                Text(_getModeLabel(mode),
                    style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: color))
              ]))
        ]));
  }

  Widget _buildFab() {
    return FloatingActionButton.extended(
      onPressed: () {},
      backgroundColor: AppColors.primary,
      icon: const Icon(Icons.mic, color: AppColors.bg0),
      label: const Text("AI Assistant",
          style: TextStyle(color: AppColors.bg0, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildBottomNav(AppMode mode) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.bg0.withOpacity(0.8),
          border:
              Border(top: BorderSide(color: Colors.white.withOpacity(0.05)))),
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (idx) {
              HapticFeedback.selectionClick();
              setState(() => _currentIndex = idx);
            },
            backgroundColor: Colors.transparent,
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: _getModeColor(mode),
            unselectedItemColor: AppColors.text3,
            showUnselectedLabels: true,
            selectedLabelStyle:
                const TextStyle(fontWeight: FontWeight.w600, fontSize: 11),
            unselectedLabelStyle:
                const TextStyle(fontWeight: FontWeight.w400, fontSize: 11),
            items: mode == AppMode.hospital
                ? _hospitalNavItems()
                : mode == AppMode.government
                    ? _govNavItems()
                    : _homeNavItems(),
          ),
        ),
      ),
    );
  }

  List<BottomNavigationBarItem> _homeNavItems() => const [
        BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            activeIcon: Icon(Icons.favorite),
            label: 'Home'),
        BottomNavigationBarItem(
            icon: Icon(Icons.insights),
            activeIcon: Icon(Icons.insights),
            label: 'Analytics'),
        BottomNavigationBarItem(
            icon: Icon(Icons.notifications_none),
            activeIcon: Icon(Icons.notifications),
            label: 'Alerts'),
        BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            activeIcon: Icon(Icons.settings),
            label: 'Settings'),
      ];

  List<BottomNavigationBarItem> _hospitalNavItems() => const [
        BottomNavigationBarItem(
            icon: Icon(Icons.people_alt_outlined),
            activeIcon: Icon(Icons.people),
            label: 'Patients'),
        BottomNavigationBarItem(
            icon: Icon(Icons.analytics_outlined),
            activeIcon: Icon(Icons.analytics),
            label: 'Analytics'),
        BottomNavigationBarItem(
            icon: Icon(Icons.notifications_none),
            activeIcon: Icon(Icons.notifications),
            label: 'Alerts'),
        BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            activeIcon: Icon(Icons.settings),
            label: 'Settings'),
      ];

  List<BottomNavigationBarItem> _govNavItems() => const [
        BottomNavigationBarItem(
            icon: Icon(Icons.public_outlined),
            activeIcon: Icon(Icons.public),
            label: 'District'),
        BottomNavigationBarItem(
            icon: Icon(Icons.analytics_outlined),
            activeIcon: Icon(Icons.analytics),
            label: 'Trends'),
        BottomNavigationBarItem(
            icon: Icon(Icons.notifications_none),
            activeIcon: Icon(Icons.notifications),
            label: 'Alerts'),
        BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            activeIcon: Icon(Icons.settings),
            label: 'Settings'),
      ];
}

class _GlowDisk extends StatelessWidget {
  final Color color;
  const _GlowDisk({required this.color});
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 400,
        height: 400,
        decoration: BoxDecoration(shape: BoxShape.circle, color: color),
        child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
            child: const SizedBox()));
  }
}
