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
      MaterialPageRoute(
        builder: (_) => RouteDetailPage(route: route, onNavigate: openRoute),
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
      appBar: currentTab == MainTab.my
          ? null
          : AppBar(
              toolbarHeight: 88,
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                      colors: [Color(0xFF2563EB), Color(0xFF8B5CF6), Color(0xFFEC4899), Color(0xFFF59E0B)],
                    ).createShader(bounds),
                    child: const Text(
                      'WAVYON',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  InkWell(
                    onTap: () => openRoute(const AppRoute(AppRouteId.weather, title: 'Weather')),
                    borderRadius: BorderRadius.circular(18),
                    child: Ink(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: WavyonColors.line),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.wb_sunny_rounded, size: 18, color: Colors.blue),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Seoul | 22C | Clear',
                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800),
                            ),
                          ),
                          Icon(Icons.chevron_right_rounded, size: 18),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              actions: [
                IconButton(
                  onPressed: () => openRoute(const AppRoute(AppRouteId.settings, title: 'Settings')),
                  icon: const Icon(Icons.settings_outlined),
                ),
                Stack(
                  children: [
                    IconButton(
                      onPressed: () => openRoute(const AppRoute(AppRouteId.notifications, title: 'Notifications')),
                      icon: const Icon(Icons.notifications_none_rounded),
                    ),
                    const Positioned(
                      right: 12,
                      top: 14,
                      child: CircleAvatar(radius: 4, backgroundColor: Colors.red),
                    ),
                  ],
                ),
                const SizedBox(width: 8),
              ],
            ),
      body: body,
      bottomNavigationBar: NavigationBar(
        height: 78,
        selectedIndex: MainTab.values.indexOf(currentTab),
        onDestinationSelected: (index) => setState(() => currentTab = MainTab.values[index]),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home_rounded), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.map_outlined), selectedIcon: Icon(Icons.map_rounded), label: 'Trip'),
          NavigationDestination(icon: Icon(Icons.groups_outlined), selectedIcon: Icon(Icons.groups_rounded), label: 'Community'),
          NavigationDestination(icon: Icon(Icons.chat_bubble_outline_rounded), selectedIcon: Icon(Icons.chat_rounded), label: 'Chat'),
          NavigationDestination(icon: Icon(Icons.person_outline_rounded), selectedIcon: Icon(Icons.person_rounded), label: 'My'),
        ],
      ),
    );
  }
}
