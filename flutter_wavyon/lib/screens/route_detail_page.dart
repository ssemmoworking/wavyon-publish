import 'package:flutter/material.dart';

import '../data/sample_data.dart';
import '../models/app_models.dart';
import '../widgets/design_system.dart';

class RouteDetailPage extends StatelessWidget {
  const RouteDetailPage({
    super.key,
    required this.route,
    required this.onNavigate,
  });

  final AppRoute route;
  final RouteHandler onNavigate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(route.title ?? _fallbackTitle(route.id)),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
        children: _buildSections(context),
      ),
    );
  }

  List<Widget> _buildSections(BuildContext context) {
    switch (route.id) {
      case AppRouteId.notifications:
        return [
          const AppTextField(hint: 'Search notifications', icon: Icons.search_rounded),
          const SizedBox(height: 18),
          ...notifications.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: WavyonCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        BadgeChip(label: item.category, color: Colors.blue, foreground: Colors.blue),
                        const SizedBox(width: 8),
                        Text(item.time),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(item.title, style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 8),
                    Text(item.body, style: Theme.of(context).textTheme.bodyMedium),
                  ],
                ),
              ),
            ),
          ),
        ];
      case AppRouteId.qrCenter:
        return [
          WavyonCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                BadgeChip(label: 'Active QR', color: Colors.blue, foreground: Colors.blue),
                SizedBox(height: 14),
                Text('NCT 127 Final Shuttle', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900)),
                SizedBox(height: 6),
                Text('One QR per reservation | auto refresh draft'),
                SizedBox(height: 22),
                Icon(Icons.qr_code_2_rounded, size: 180),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const WavyonCard(
            child: Column(
              children: [
                _InfoLine(label: 'Departure', value: 'Apr 22 | 3:00 PM'),
                _InfoLine(label: 'Pickup', value: 'Incheon Airport T1'),
                _InfoLine(label: 'People', value: '2'),
                _InfoLine(label: 'Refreshed', value: '14:20'),
              ],
            ),
          ),
        ];
      case AppRouteId.reservationDetail:
        return [
          ...reservations.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: WavyonCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.title, style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 8),
                    Text('${item.kind} | ${item.time}'),
                    const SizedBox(height: 4),
                    Text(item.location),
                    const SizedBox(height: 8),
                    BadgeChip(label: item.status, color: Colors.blue, foreground: Colors.blue),
                  ],
                ),
              ),
            ),
          ),
        ];
      case AppRouteId.newsDetail:
        final newsId = route.payload['id'];
        final news = homeNews.firstWhere(
          (item) => item.id == newsId,
          orElse: () => homeNews.first,
        );
        return [
          const Center(child: PlaceholderThumb(size: 220)),
          const SizedBox(height: 16),
          Text(news.title, style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 10),
          Text(news.body, style: Theme.of(context).textTheme.bodyLarge),
          const SizedBox(height: 20),
          WavyonCard(
            onTap: () => onNavigate(const AppRoute(AppRouteId.liveChatList, title: 'Live Chat')),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Related Live Thread', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900)),
                SizedBox(height: 8),
                Text('Use this as the Flutter replacement for the draft news-to-thread entry flow.'),
              ],
            ),
          ),
        ];
      case AppRouteId.communityDetail:
      case AppRouteId.communityBoardList:
      case AppRouteId.freeBoard:
      case AppRouteId.fandomBoard:
        return _communityList(context);
      case AppRouteId.fandomWrite:
      case AppRouteId.liveThreadCreate:
        return _editor('Title', 'Body');
      case AppRouteId.tripCategory:
      case AppRouteId.tripProductDetail:
      case AppRouteId.tripBooking:
      case AppRouteId.tripBookingComplete:
        return [
          ...tripProducts.map(
            (product) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: WavyonCard(
                child: Row(
                  children: [
                    const PlaceholderThumb(size: 72),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(product.title, style: Theme.of(context).textTheme.titleMedium),
                          const SizedBox(height: 6),
                          Text(product.description),
                          const SizedBox(height: 8),
                          Text(product.price, style: const TextStyle(fontWeight: FontWeight.w900)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          PrimaryButton(label: route.id == AppRouteId.tripBookingComplete ? 'Done' : 'Continue'),
        ];
      case AppRouteId.tradeDetail:
      case AppRouteId.tradeChat:
        return _tradeList(context);
      case AppRouteId.tradeWrite:
      case AppRouteId.tradeEdit:
        return _editor('Trade title', 'Description');
      case AppRouteId.systemAlertDetail:
        return [
          ...systemAlerts.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: WavyonCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.title, style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 8),
                    Text(item.body),
                  ],
                ),
              ),
            ),
          ),
        ];
      case AppRouteId.myReservations:
      case AppRouteId.myTickets:
        return [
          ...reservations.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: WavyonCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.title, style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 8),
                    Text('${item.kind} | ${item.time}'),
                    const SizedBox(height: 4),
                    Text(item.location),
                  ],
                ),
              ),
            ),
          ),
        ];
      case AppRouteId.paymentCenter:
      case AppRouteId.paymentDetail:
        return [
          const SectionTitle(title: 'Payment'),
          const SizedBox(height: 12),
          ...paymentHistory.map((item) => _paymentCard(context, item)),
          const SizedBox(height: 16),
          const SectionTitle(title: 'Refund'),
          const SizedBox(height: 12),
          ...refundHistory.map((item) => _paymentCard(context, item)),
          const SizedBox(height: 16),
          const SectionTitle(title: 'Transfer'),
          const SizedBox(height: 12),
          ...transferHistory.map((item) => _paymentCard(context, item)),
        ];
      case AppRouteId.pointsCoupons:
        return [
          const WavyonCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Points & Coupons', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900)),
                SizedBox(height: 8),
                Text('12,500P | 4 active coupons'),
              ],
            ),
          ),
        ];
      case AppRouteId.support:
        return [
          ...supportItems.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: WavyonCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.title, style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 8),
                    Text(item.body),
                  ],
                ),
              ),
            ),
          ),
        ];
      case AppRouteId.settings:
        return [
          const WavyonCard(
            child: Column(
              children: [
                _ToggleRow(label: 'Push notifications', enabled: true),
                _ToggleRow(label: 'Marketing consent', enabled: false),
                _ToggleRow(label: 'Trade status alerts', enabled: false),
              ],
            ),
          ),
        ];
      case AppRouteId.weather:
        return [
          const WavyonCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Seoul Weather', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900)),
                SizedBox(height: 8),
                Text('22C | Clear'),
              ],
            ),
          ),
        ];
      case AppRouteId.liveChatList:
        return [
          ...liveThreads.map(
            (thread) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: WavyonCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        if (thread.hot) const BadgeChip(label: 'HOT', color: Colors.red, foreground: Colors.red),
                        if (thread.hot) const SizedBox(width: 8),
                        Text('${thread.remain} left'),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(thread.title, style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 8),
                    Text('${thread.users} users joined'),
                  ],
                ),
              ),
            ),
          ),
        ];
      case AppRouteId.chatRoom:
        return [
          const WavyonCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Chat Draft', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900)),
                SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerLeft,
                  child: _Bubble(text: 'Pickup starts in five minutes.', me: false),
                ),
                SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerRight,
                  child: _Bubble(text: 'Thanks, I am heading there now.', me: true),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const AppTextField(hint: 'Type a message'),
        ];
    }
  }

  List<Widget> _communityList(BuildContext context) {
    return communityPosts
        .map(
          (post) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: WavyonCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BadgeChip(label: post.tag, color: Colors.indigo, foreground: Colors.indigo),
                  const SizedBox(height: 10),
                  Text(post.title, style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 8),
                  Text('${post.author} | ${post.meta}'),
                ],
              ),
            ),
          ),
        )
        .toList();
  }

  List<Widget> _tradeList(BuildContext context) {
    return tradeItems
        .map(
          (item) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: WavyonCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(child: Text(item.title, style: Theme.of(context).textTheme.titleMedium)),
                      BadgeChip(label: item.status, color: Colors.blue, foreground: Colors.blue),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(item.price, style: const TextStyle(fontWeight: FontWeight.w900)),
                  const SizedBox(height: 8),
                  Text(item.summary),
                ],
              ),
            ),
          ),
        )
        .toList();
  }

  List<Widget> _editor(String titleHint, String bodyHint) {
    return [
      AppTextField(hint: titleHint),
      const SizedBox(height: 12),
      AppTextField(hint: bodyHint),
      const SizedBox(height: 18),
      const PrimaryButton(label: 'Submit'),
    ];
  }

  static Widget _paymentCard(BuildContext context, PaymentRecord item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: WavyonCard(
        child: Row(
          children: [
            const Icon(Icons.receipt_long_rounded),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.title, style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 4),
                  Text(item.date),
                ],
              ),
            ),
            Text(item.amount, style: const TextStyle(fontWeight: FontWeight.w900)),
          ],
        ),
      ),
    );
  }

  static String _fallbackTitle(AppRouteId id) {
    return switch (id) {
      AppRouteId.notifications => 'Notifications',
      AppRouteId.qrCenter => 'QR Center',
      AppRouteId.reservationDetail => 'Reservation Detail',
      AppRouteId.newsDetail => 'News Detail',
      AppRouteId.communityDetail => 'Community Detail',
      AppRouteId.tripCategory => 'Trip Category',
      AppRouteId.tripProductDetail => 'Trip Product',
      AppRouteId.tradeDetail => 'Trade Detail',
      AppRouteId.tradeChat => 'Trade Chat',
      AppRouteId.systemAlertDetail => 'System Alert',
      AppRouteId.myReservations => 'My Reservations',
      AppRouteId.myTickets => 'My Tickets',
      AppRouteId.paymentCenter => 'Payments',
      AppRouteId.paymentDetail => 'Payment Detail',
      AppRouteId.pointsCoupons => 'Points & Coupons',
      AppRouteId.support => 'Support',
      AppRouteId.settings => 'Settings',
      AppRouteId.liveChatList => 'Live Chat',
      AppRouteId.chatRoom => 'Chat Room',
      AppRouteId.weather => 'Weather',
      AppRouteId.tripBooking => 'Trip Booking',
      AppRouteId.tripBookingComplete => 'Booking Complete',
      AppRouteId.liveThreadCreate => 'Create Live Thread',
      AppRouteId.communityBoardList => 'Community Board',
      AppRouteId.fandomWrite => 'Write Post',
      AppRouteId.tradeWrite => 'Write Trade',
      AppRouteId.tradeEdit => 'Edit Trade',
      AppRouteId.freeBoard => 'Free Board',
      AppRouteId.fandomBoard => 'Fandom Board',
    };
  }
}

class _InfoLine extends StatelessWidget {
  const _InfoLine({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(child: Text(label, style: Theme.of(context).textTheme.bodyMedium)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w800)),
        ],
      ),
    );
  }
}

class _ToggleRow extends StatelessWidget {
  const _ToggleRow({
    required this.label,
    required this.enabled,
  });

  final String label;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      contentPadding: EdgeInsets.zero,
      value: enabled,
      onChanged: (_) {},
      title: Text(label, style: const TextStyle(fontWeight: FontWeight.w700)),
    );
  }
}

class _Bubble extends StatelessWidget {
  const _Bubble({
    required this.text,
    required this.me,
  });

  final String text;
  final bool me;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 280),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: me ? Colors.blue : Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: me ? Colors.blue : const Color(0xFFE8ECF4)),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: me ? Colors.white : const Color(0xFF0F172A),
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
