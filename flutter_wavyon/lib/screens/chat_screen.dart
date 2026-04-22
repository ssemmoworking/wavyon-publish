import 'package:flutter/material.dart';

import '../data/sample_data.dart';
import '../models/app_models.dart';
import '../widgets/design_system.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({
    super.key,
    required this.onNavigate,
  });

  final RouteHandler onNavigate;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    const tabs = ['Rooms', 'Trade', 'System'];

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 120),
      children: [
        Text('Chat', style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 16),
        SegmentedButton<int>(
          segments: const [
            ButtonSegment(value: 0, label: Text('Rooms')),
            ButtonSegment(value: 1, label: Text('Trade')),
            ButtonSegment(value: 2, label: Text('System')),
          ],
          selected: {currentIndex},
          onSelectionChanged: (value) => setState(() => currentIndex = value.first),
        ),
        const SizedBox(height: 14),
        AppTextField(hint: 'Search ${tabs[currentIndex]}', icon: Icons.search_rounded),
        const SizedBox(height: 20),
        if (currentIndex == 0)
          ...roomChats.map(
            (chat) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: WavyonCard(
                onTap: () => widget.onNavigate(AppRoute(AppRouteId.chatRoom, title: chat.name, payload: {'id': chat.id})),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: chat.driverStyle ? const Color(0xFFDBEAFE) : const Color(0xFFF1F5F9),
                      child: Icon(
                        chat.driverStyle ? Icons.directions_bus_rounded : Icons.person_rounded,
                        color: chat.driverStyle ? Colors.blue : Colors.grey,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(child: Text(chat.name, style: Theme.of(context).textTheme.titleMedium)),
                              Text(chat.time, style: Theme.of(context).textTheme.bodyMedium),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text(chat.body, style: Theme.of(context).textTheme.bodyMedium),
                        ],
                      ),
                    ),
                    if (chat.unread > 0) ...[
                      const SizedBox(width: 12),
                      CircleAvatar(
                        radius: 12,
                        backgroundColor: Colors.red,
                        child: Text('${chat.unread}', style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w800)),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        if (currentIndex == 1)
          ...tradeItems.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: WavyonCard(
                onTap: () => widget.onNavigate(AppRoute(AppRouteId.tradeChat, title: item.title, payload: {'id': item.id})),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(child: Text(item.title, style: Theme.of(context).textTheme.titleMedium)),
                        BadgeChip(label: item.status, color: Colors.blue, foreground: Colors.blue),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(item.summary, style: Theme.of(context).textTheme.bodyMedium),
                    const SizedBox(height: 10),
                    Text('Counterparty: ${item.counterparty}', style: Theme.of(context).textTheme.bodyMedium),
                  ],
                ),
              ),
            ),
          ),
        if (currentIndex == 2)
          ...systemAlerts.map(
            (alert) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: WavyonCard(
                onTap: () => widget.onNavigate(AppRoute(AppRouteId.systemAlertDetail, title: alert.title, payload: {'id': alert.id})),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        BadgeChip(label: alert.category, color: Colors.indigo, foreground: Colors.indigo),
                        const SizedBox(width: 8),
                        Text(alert.time, style: Theme.of(context).textTheme.bodyMedium),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(alert.title, style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 8),
                    Text(alert.body, style: Theme.of(context).textTheme.bodyMedium),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}
