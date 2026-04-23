import 'package:flutter/material.dart';

import '../app/theme.dart';
import '../models/app_models.dart';
import '../screens/chat_screen.dart';
import '../screens/community_screen.dart';
import '../screens/home_screen.dart';
import '../screens/my_screen.dart';
import '../screens/route_detail_page.dart';
import '../screens/trip_screen.dart';

class WavyonShell extends StatefulWidget {
  const WavyonShell({super.key});

  @override
  State<WavyonShell> createState() => _WavyonShellState();
}

class _WavyonShellState extends State<WavyonShell> {
  MainTab currentTab = MainTab.home;

  void openRoute(AppRoute route) {
    Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 280),
        reverseTransitionDuration: const Duration(milliseconds: 220),
        pageBuilder: (context, animation, secondaryAnimation) {
          return RouteDetailPage(route: route, onNavigate: openRoute);
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final offsetAnimation = Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(
            CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
          );

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final body = switch (currentTab) {
      MainTab.home => HomeScreen(onNavigate: openRoute),
      MainTab.trip => TripScreen(onNavigate: openRoute),
      MainTab.community => CommunityScreen(onNavigate: openRoute),
      MainTab.chat => ChatScreen(onNavigate: openRoute),
      MainTab.my => MyScreen(onNavigate: openRoute),
    };

    return Scaffold(
      backgroundColor: WavyonColors.canvas,
      body: Column(
        children: [
          _MainHeader(
            unreadCount: 3,
            onOpenSettings: () => openRoute(const AppRoute(AppRouteId.settings, title: '설정')),
            onOpenNotifications: () => openRoute(
              const AppRoute(AppRouteId.notifications, title: '알림'),
            ),
            onOpenWeather: () => openRoute(const AppRoute(AppRouteId.weather, title: '현지 날씨 정보')),
          ),
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 260),
              switchInCurve: Curves.easeOut,
              switchOutCurve: Curves.easeIn,
              child: KeyedSubtree(
                key: ValueKey(currentTab),
                child: body,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _BottomNav(
        activeTab: currentTab,
        unreadChatCount: 3,
        onChange: (tab) => setState(() => currentTab = tab),
      ),
    );
  }
}

class _MainHeader extends StatelessWidget {
  const _MainHeader({
    required this.unreadCount,
    required this.onOpenSettings,
    required this.onOpenNotifications,
    required this.onOpenWeather,
  });

  final int unreadCount;
  final VoidCallback onOpenSettings;
  final VoidCallback onOpenNotifications;
  final VoidCallback onOpenWeather;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: WavyonColors.line)),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 10),
          child: Column(
            children: [
              SizedBox(
                height: 40,
                child: Row(
                  children: [
                    ShaderMask(
                      shaderCallback: (bounds) => WavyonGradients.text.createShader(bounds),
                      child: const Text(
                        'WAVYON',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w900,
                          fontStyle: FontStyle.italic,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const Spacer(),
                    _HeaderIconButton(
                      icon: Icons.settings_outlined,
                      onTap: onOpenSettings,
                    ),
                    const SizedBox(width: 2),
                    _HeaderIconButton(
                      icon: Icons.notifications_none_rounded,
                      onTap: onOpenNotifications,
                      badgeCount: unreadCount,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: onOpenWeather,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: WavyonColors.line),
                    boxShadow: WavyonShadows.card,
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: WavyonShadows.card,
                        ),
                        child: const Icon(
                          Icons.wb_sunny_outlined,
                          size: 18,
                          color: WavyonColors.blue,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Expanded(
                        child: Row(
                          children: [
                            Text(
                              '서울 (Seoul)',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w900,
                                color: WavyonColors.text,
                              ),
                            ),
                            SizedBox(width: 6),
                            Text(
                              '22°C 맑음',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w800,
                                color: WavyonColors.blue,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(
                        Icons.chevron_right_rounded,
                        size: 18,
                        color: WavyonColors.muted,
                      ),
                    ],
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

class _HeaderIconButton extends StatelessWidget {
  const _HeaderIconButton({
    required this.icon,
    required this.onTap,
    this.badgeCount = 0,
  });

  final IconData icon;
  final VoidCallback onTap;
  final int badgeCount;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 38,
      height: 38,
      child: Stack(
        children: [
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(999),
              child: Center(
                child: Icon(
                  icon,
                  size: 20,
                  color: WavyonColors.subtleText,
                ),
              ),
            ),
          ),
          if (badgeCount > 0)
            const Positioned(
              right: 8,
              top: 8,
              child: CircleAvatar(
                radius: 3,
                backgroundColor: WavyonColors.red,
              ),
            ),
        ],
      ),
    );
  }
}

class _BottomNav extends StatelessWidget {
  const _BottomNav({
    required this.activeTab,
    required this.unreadChatCount,
    required this.onChange,
  });

  final MainTab activeTab;
  final int unreadChatCount;
  final ValueChanged<MainTab> onChange;

  @override
  Widget build(BuildContext context) {
    const items = [
      (MainTab.home, '홈', Icons.home_outlined, Icons.home_rounded),
      (MainTab.trip, 'Trip', Icons.map_outlined, Icons.map_rounded),
      (MainTab.community, 'Community', Icons.groups_outlined, Icons.groups_rounded),
      (MainTab.chat, 'Chat', Icons.chat_bubble_outline_rounded, Icons.chat_rounded),
      (MainTab.my, 'My', Icons.person_outline_rounded, Icons.person_rounded),
    ];

    return Container(
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 14),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.96),
        border: const Border(top: BorderSide(color: WavyonColors.line)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x08000000),
            blurRadius: 20,
            offset: Offset(0, -10),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: items.map((item) {
            final tab = item.$1;
            final active = tab == activeTab;
            final icon = active ? item.$4 : item.$3;

            return GestureDetector(
              onTap: () => onChange(tab),
              child: Opacity(
                opacity: active ? 1 : 0.34,
                child: AnimatedScale(
                  duration: const Duration(milliseconds: 180),
                  scale: active ? 1.08 : 1,
                  child: SizedBox(
                    width: 68,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: active ? const Color(0xFFEFF6FF) : Colors.transparent,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Icon(
                                icon,
                                size: 22,
                                color: active ? WavyonColors.primary : WavyonColors.subtleText,
                              ),
                              if (tab == MainTab.chat && unreadChatCount > 0)
                                Positioned(
                                  right: -6,
                                  top: -5,
                                  child: Container(
                                    constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                                    padding: const EdgeInsets.symmetric(horizontal: 4),
                                    decoration: BoxDecoration(
                                      color: WavyonColors.red,
                                      borderRadius: BorderRadius.circular(999),
                                      border: Border.all(color: Colors.white, width: 2),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      '$unreadChatCount',
                                      style: const TextStyle(
                                        fontSize: 8,
                                        fontWeight: FontWeight.w900,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item.$2,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w900,
                            color: active ? WavyonColors.primary : WavyonColors.subtleText,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
