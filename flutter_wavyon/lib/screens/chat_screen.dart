import 'package:flutter/material.dart';

import '../app/theme.dart';
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
  String currentTab = 'ROOMS';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(bottom: BorderSide(color: WavyonColors.line)),
            boxShadow: WavyonShadows.card,
          ),
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Chat',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 16),
              SegmentTabs<String>(
                items: const [
                  SegmentTabItem(value: 'ROOMS', label: '채팅방'),
                  SegmentTabItem(value: 'TRADE', label: 'Trade'),
                  SegmentTabItem(value: 'SYSTEM', label: '시스템 알림'),
                ],
                value: currentTab,
                onChanged: (value) => setState(() => currentTab = value),
              ),
              const SizedBox(height: 12),
              SearchBarCard(
                placeholder: switch (currentTab) {
                  'ROOMS' => '채팅방 검색',
                  'TRADE' => 'Trade 채팅 검색',
                  _ => '시스템 알림 검색',
                },
              ),
            ],
          ),
        ),
        Expanded(
          child: switch (currentTab) {
            'ROOMS' => _RoomsView(onNavigate: widget.onNavigate),
            'TRADE' => _TradeChatView(onNavigate: widget.onNavigate),
            _ => _SystemView(onNavigate: widget.onNavigate),
          },
        ),
      ],
    );
  }
}

class _RoomsView extends StatelessWidget {
  const _RoomsView({required this.onNavigate});

  final RouteHandler onNavigate;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.only(bottom: 110),
      itemCount: roomChats.length,
      separatorBuilder: (_, _) => const Divider(height: 1, color: Color(0xFFF8FAFC)),
      itemBuilder: (context, index) {
        final room = roomChats[index];
        final isDriver = room.type == 'DRIVER';

        return Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => onNavigate(
              AppRoute(AppRouteId.chatRoom, title: room.name, payload: {'id': room.id}),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Row(
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          color: isDriver ? const Color(0xFFDBEAFE) : Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: isDriver ? null : Border.all(color: WavyonColors.line),
                          boxShadow: WavyonShadows.card,
                        ),
                        child: Icon(
                          isDriver ? Icons.directions_bus_rounded : Icons.person_rounded,
                          size: 24,
                          color: isDriver ? WavyonColors.blue : WavyonColors.muted,
                        ),
                      ),
                      if (room.online)
                        Positioned(
                          right: -2,
                          bottom: -2,
                          child: Container(
                            width: 14,
                            height: 14,
                            decoration: BoxDecoration(
                              color: const Color(0xFF22C55E),
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                room.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              room.time,
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          room.body,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 11,
                            height: 1.35,
                            fontWeight: FontWeight.w700,
                            color: WavyonColors.subtleText,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (room.unread > 0) ...[
                    const SizedBox(width: 12),
                    Container(
                      width: 20,
                      height: 20,
                      decoration: const BoxDecoration(
                        color: WavyonColors.red,
                        shape: BoxShape.circle,
                        boxShadow: WavyonShadows.card,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '${room.unread}',
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _TradeChatView extends StatelessWidget {
  const _TradeChatView({required this.onNavigate});

  final RouteHandler onNavigate;

  @override
  Widget build(BuildContext context) {
    final visibleTradeItems = tradeItems
        .where((item) => item.statusKey != 'DELETED')
        .toList(growable: false);

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 120),
      children: [
        ...visibleTradeItems.map(
          (item) {
            final style = tradeStatusStyle(item.statusKey);
            final readOnly = item.statusKey == 'COMPLETED' ||
                item.statusKey == 'HIDDEN_BLOCKED' ||
                item.statusKey == 'HIDDEN_REPORTED';
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: WavyonCard(
                onTap: () => onNavigate(
                  AppRoute(AppRouteId.tradeChat, title: item.title, payload: {'id': item.id}),
                ),
                padding: const EdgeInsets.all(18),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: const Icon(
                        Icons.chat_bubble_outline_rounded,
                        size: 20,
                        color: WavyonColors.muted,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  item.title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.titleMedium,
                                ),
                              ),
                              const SizedBox(width: 8),
                              BadgeChip(
                                label: tradeStatusLabel(item.statusKey),
                                background: style.background,
                                foreground: style.foreground,
                                border: style.border,
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text(
                            item.lastStateText,
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: WavyonColors.subtleText,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Text(
                                '상대방: ${item.buyerNickname}',
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                              const Spacer(),
                              if (readOnly)
                                const Text(
                                  'read-only',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w900,
                                    color: WavyonColors.muted,
                                  ),
                                ),
                              if (item.unreadCount > 0) ...[
                                const SizedBox(width: 10),
                                Container(
                                  constraints: const BoxConstraints(minWidth: 20, minHeight: 20),
                                  padding: const EdgeInsets.symmetric(horizontal: 6),
                                  decoration: const BoxDecoration(
                                    color: WavyonColors.red,
                                    borderRadius: BorderRadius.all(Radius.circular(999)),
                                    boxShadow: WavyonShadows.card,
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    '${item.unreadCount}',
                                    style: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class _SystemView extends StatelessWidget {
  const _SystemView({required this.onNavigate});

  final RouteHandler onNavigate;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 120),
      children: [
        ...systemAlerts.map(
          (alert) {
            final style = notificationCategoryStyle(alert.category);
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: WavyonCard(
                onTap: () => onNavigate(
                  AppRoute(
                    AppRouteId.systemAlertDetail,
                    title: alert.title,
                    payload: {'id': alert.id},
                  ),
                ),
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        BadgeChip(
                          label: alert.category,
                          background: style.background,
                          foreground: style.foreground,
                          border: style.border,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          alert.time,
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      alert.title,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      alert.body,
                      style: const TextStyle(
                        fontSize: 11,
                        height: 1.5,
                        fontWeight: FontWeight.w700,
                        color: WavyonColors.subtleText,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
