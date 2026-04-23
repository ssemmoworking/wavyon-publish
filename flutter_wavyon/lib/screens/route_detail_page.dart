import 'package:flutter/material.dart';

import '../app/theme.dart';
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
      backgroundColor: WavyonColors.canvas,
      body: Column(
        children: [
          _SubHeader(
            title: route.title ?? _fallbackTitle(route.id),
            onBack: () => Navigator.of(context).pop(),
            right: _buildHeaderAction(context),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 18, 20, 120),
              children: _buildSections(context),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomBar(context),
    );
  }

  Widget? _buildHeaderAction(BuildContext context) {
    switch (route.id) {
      case AppRouteId.newsDetail:
        return const Icon(Icons.ios_share_rounded, size: 20, color: WavyonColors.muted);
      case AppRouteId.liveChatList:
        return GestureDetector(
          onTap: () => onNavigate(const AppRoute(AppRouteId.liveThreadCreate, title: 'Create Live Thread')),
          child: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: WavyonColors.primary,
              borderRadius: BorderRadius.circular(12),
              boxShadow: WavyonShadows.card,
            ),
            child: const Icon(Icons.add_rounded, size: 18, color: Colors.white),
          ),
        );
      case AppRouteId.chatRoom:
        return const Icon(Icons.search_rounded, size: 20, color: WavyonColors.muted);
      default:
        return null;
    }
  }

  Widget? _buildBottomBar(BuildContext context) {
    switch (route.id) {
      case AppRouteId.qrCenter:
        return const BottomFixedActionBar(
          children: [
            WavyonButton(
              label: 'Support',
              variant: WavyonButtonVariant.ghost,
            ),
            WavyonButton(label: 'Refresh QR'),
          ],
        );
      case AppRouteId.reservationDetail:
        return BottomFixedActionBar(
          children: [
            WavyonButton(
              label: 'Payments',
              variant: WavyonButtonVariant.ghost,
              onPressed: () => onNavigate(const AppRoute(AppRouteId.paymentCenter, title: 'Payments')),
            ),
            WavyonButton(
              label: 'Support',
              onPressed: () => onNavigate(const AppRoute(AppRouteId.support, title: 'Support')),
            ),
          ],
        );
      case AppRouteId.tripBooking:
      case AppRouteId.tripBookingComplete:
        return BottomFixedActionBar(
          children: [
            WavyonButton(
              label: route.id == AppRouteId.tripBookingComplete ? 'Done' : 'Continue',
              onPressed: () {},
            ),
          ],
        );
      case AppRouteId.tradeDetail:
        return BottomFixedActionBar(
          children: [
            WavyonButton(
              label: 'Edit',
              variant: WavyonButtonVariant.ghost,
              onPressed: () => onNavigate(
                AppRoute(AppRouteId.tradeEdit, title: 'Edit Trade', payload: route.payload),
              ),
            ),
            WavyonButton(
              label: 'Open Chat',
              onPressed: () => onNavigate(
                AppRoute(AppRouteId.tradeChat, title: 'Trade Chat', payload: route.payload),
              ),
            ),
          ],
        );
      case AppRouteId.tradeWrite:
      case AppRouteId.tradeEdit:
      case AppRouteId.fandomWrite:
      case AppRouteId.liveThreadCreate:
        return const BottomFixedActionBar(
          children: [
            WavyonButton(label: 'Submit'),
          ],
        );
      case AppRouteId.tradeChat:
      case AppRouteId.chatRoom:
        return const _ComposerBar();
      default:
        return null;
    }
  }

  List<Widget> _buildSections(BuildContext context) {
    switch (route.id) {
      case AppRouteId.notifications:
        return _notificationSections(context);
      case AppRouteId.qrCenter:
        return _qrSections();
      case AppRouteId.reservationDetail:
        return _reservationDetailSections();
      case AppRouteId.newsDetail:
        return _newsDetailSections(context);
      case AppRouteId.communityDetail:
        return _communityDetailSections();
      case AppRouteId.communityBoardList:
      case AppRouteId.freeBoard:
      case AppRouteId.fandomBoard:
        return _communityBoardSections(context);
      case AppRouteId.fandomWrite:
      case AppRouteId.liveThreadCreate:
        return _editorSections(
          context,
          titleHint: 'Title',
          bodyHint: 'Share the key details, reactions, and context for the thread.',
        );
      case AppRouteId.tripCategory:
        return _tripCategorySections(context);
      case AppRouteId.tripProductDetail:
        return _tripProductDetailSections();
      case AppRouteId.tripBooking:
        return _tripBookingSections();
      case AppRouteId.tripBookingComplete:
        return _tripBookingCompleteSections();
      case AppRouteId.tradeDetail:
        return _tradeDetailSections();
      case AppRouteId.tradeChat:
        return _tradeChatSections();
      case AppRouteId.tradeWrite:
      case AppRouteId.tradeEdit:
        return _editorSections(
          context,
          titleHint: 'Trade title',
          bodyHint: 'Explain the item state, price, meetup point, and rules clearly.',
        );
      case AppRouteId.systemAlertDetail:
        return _systemAlertSections();
      case AppRouteId.myReservations:
      case AppRouteId.myTickets:
        return _reservationListSections();
      case AppRouteId.paymentCenter:
      case AppRouteId.paymentDetail:
        return _paymentSections(context);
      case AppRouteId.pointsCoupons:
        return _pointsCouponSections();
      case AppRouteId.support:
        return _supportSections();
      case AppRouteId.settings:
        return _settingsSections();
      case AppRouteId.liveChatList:
        return _liveChatSections();
      case AppRouteId.chatRoom:
        return _chatRoomSections();
      case AppRouteId.weather:
        return _weatherSections();
    }
  }

  List<Widget> _notificationSections(BuildContext context) {
    return [
      const SearchBarCard(placeholder: 'Search notifications'),
      const SizedBox(height: 18),
      ...notifications.map((item) {
        final style = notificationCategoryStyle(item.category);
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: WavyonCard(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 2),
                  child: Icon(Icons.notifications_active_outlined, size: 18, color: WavyonColors.blue),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(item.title, style: Theme.of(context).textTheme.titleMedium),
                          ),
                          const SizedBox(width: 8),
                          Text(item.time, style: Theme.of(context).textTheme.labelSmall),
                        ],
                      ),
                      const SizedBox(height: 8),
                      BadgeChip(
                        label: item.category,
                        background: style.background,
                        foreground: style.foreground,
                        border: style.border,
                      ),
                      const SizedBox(height: 10),
                      Text(item.body, style: Theme.of(context).textTheme.bodyLarge),
                    ],
                  ),
                ),
                if (!item.read)
                  const Padding(
                    padding: EdgeInsets.only(top: 6, left: 10),
                    child: CircleAvatar(radius: 3, backgroundColor: WavyonColors.red),
                  ),
              ],
            ),
          ),
        );
      }),
    ];
  }

  List<Widget> _qrSections() {
    return [
      WavyonCard(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 12,
              decoration: BoxDecoration(
                gradient: WavyonGradients.banner1,
                borderRadius: BorderRadius.circular(999),
              ),
            ),
            const SizedBox(height: 18),
            const BadgeChip(
              label: 'Active QR',
              background: Color(0xFFEFF6FF),
              foreground: WavyonColors.blue,
              border: Color(0xFFBFDBFE),
            ),
            const SizedBox(height: 10),
            const Text(
              'NCT 127 Final Shuttle',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: WavyonColors.text,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'One QR per reservation | auto refresh draft',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: WavyonColors.muted,
              ),
            ),
            const SizedBox(height: 22),
            Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: WavyonColors.line),
              ),
              child: const Icon(Icons.qr_code_2_rounded, size: 150, color: WavyonColors.text),
            ),
            const SizedBox(height: 18),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFFFEF2F2),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFFECACA)),
              ),
              child: const Text(
                'Do not share, forward, or capture this QR outside the app.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  color: WavyonColors.red,
                ),
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 14),
      const WavyonCard(
        child: Column(
          children: [
            InfoRow(label: 'Departure', value: 'Apr 22 | 3:00 PM'),
            InfoRow(label: 'Pickup', value: 'Incheon Airport T1'),
            InfoRow(label: 'People', value: '2', emphasize: true),
            InfoRow(label: 'Refreshed', value: '14:20'),
          ],
        ),
      ),
    ];
  }

  List<Widget> _reservationDetailSections() {
    final reservationId = route.payload['id'];
    final item = reservations.firstWhere(
      (entry) => entry.id == reservationId,
      orElse: () => reservations.first,
    );

    return [
      WavyonCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Reservation detail',
                        style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: WavyonColors.muted),
                      ),
                    ],
                  ),
                ),
                BadgeChip(
                  label: 'Booked',
                  background: Color(0xFFEFF6FF),
                  foreground: WavyonColors.blue,
                  border: Color(0xFFBFDBFE),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(item.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: WavyonColors.text)),
            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: WavyonColors.line),
              ),
              child: Column(
                children: [
                  InfoRow(label: 'Category', value: item.kind),
                  InfoRow(label: 'Date', value: item.time, emphasize: true),
                  InfoRow(label: 'Location', value: item.location),
                  InfoRow(label: 'Reservation ID', value: 'RSV-${item.id}'),
                ],
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 14),
      const WavyonCard(
        child: Text(
          'This detail page keeps payment, support, and QR actions separated so the layout still feels like a real product screen.',
          style: TextStyle(
            fontSize: 11,
            height: 1.5,
            fontWeight: FontWeight.w700,
            color: WavyonColors.subtleText,
          ),
        ),
      ),
    ];
  }

  List<Widget> _newsDetailSections(BuildContext context) {
    final newsId = route.payload['id'];
    final news = homeNews.firstWhere(
      (entry) => entry.id == newsId,
      orElse: () => homeNews.first,
    );

    return [
      const WavyonCard(
        padding: EdgeInsets.zero,
        child: PlaceholderThumb(size: 320, radius: 24),
      ),
      const SizedBox(height: 16),
      const BadgeChip(
        label: 'K-POP NEWS',
        background: Color(0xFFEFF6FF),
        foreground: WavyonColors.blue,
        border: Color(0xFFBFDBFE),
      ),
      const SizedBox(height: 12),
      Text(news.title, style: Theme.of(context).textTheme.headlineMedium),
      const SizedBox(height: 12),
      const Text(
        'WAVYON Desk | 2026.04.20 10:30',
        style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: WavyonColors.muted),
      ),
      const SizedBox(height: 18),
      Text(
        '${news.body}\n\nThe Flutter page now keeps the same article-to-live-thread hierarchy instead of collapsing into a plain list.',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      const SizedBox(height: 18),
      GestureDetector(
        onTap: () => onNavigate(const AppRoute(AppRouteId.liveChatList, title: 'Live Chat')),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: WavyonGradients.banner4,
            borderRadius: BorderRadius.circular(26),
            boxShadow: WavyonShadows.strong,
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Related Live Thread',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w900, color: Colors.white),
              ),
              SizedBox(height: 8),
              Text(
                'Jump into the realtime discussion flow from the article just like the React draft.',
                style: TextStyle(
                  fontSize: 10,
                  height: 1.4,
                  fontWeight: FontWeight.w700,
                  color: Color(0xCCFFFFFF),
                ),
              ),
            ],
          ),
        ),
      ),
    ];
  }

  List<Widget> _communityDetailSections() {
    final post = communityPosts.first;

    return [
      const BadgeChip(
        label: 'Community',
        background: Color(0xFFEEF2FF),
        foreground: WavyonColors.indigo,
        border: Color(0xFFC7D2FE),
      ),
      const SizedBox(height: 12),
      Text(post.title, style: const TextStyle(fontSize: 22, height: 1.18, fontWeight: FontWeight.w900, color: WavyonColors.text)),
      const SizedBox(height: 10),
      Text(
        '${post.author} | ${post.time}',
        style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: WavyonColors.muted),
      ),
      const SizedBox(height: 16),
      const WavyonCard(
        padding: EdgeInsets.zero,
        child: PlaceholderThumb(size: 320, radius: 24),
      ),
      const SizedBox(height: 16),
      Text(
        post.excerpt ?? '',
        style: const TextStyle(
          fontSize: 13,
          height: 1.6,
          fontWeight: FontWeight.w700,
          color: WavyonColors.subtleText,
        ),
      ),
      const SizedBox(height: 18),
      _commentSection(),
    ];
  }

  List<Widget> _communityBoardSections(BuildContext context) {
    return communityPosts
        .map(
          (post) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: WavyonCard(
              onTap: () => onNavigate(const AppRoute(AppRouteId.communityDetail, title: 'Community Detail')),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      BadgeChip(
                        label: post.tag,
                        background: const Color(0xFFEFF6FF),
                        foreground: WavyonColors.blue,
                        border: const Color(0xFFBFDBFE),
                      ),
                      const SizedBox(width: 8),
                      Text(post.time, style: Theme.of(context).textTheme.labelSmall),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(post.title, style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 8),
                  Text(
                    '${post.author} | ❤ ${post.likes} | 💬 ${post.comments}',
                    style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: WavyonColors.muted),
                  ),
                ],
              ),
            ),
          ),
        )
        .toList();
  }

  List<Widget> _editorSections(
    BuildContext context, {
    required String titleHint,
    required String bodyHint,
  }) {
    return [
      WavyonCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Attach images',
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.w900, color: WavyonColors.text),
            ),
            const SizedBox(height: 12),
            Row(
              children: const [
                Expanded(child: PlaceholderThumb(size: 92)),
                SizedBox(width: 10),
                Expanded(child: _UploadTile()),
                SizedBox(width: 10),
                Expanded(child: _UploadTile()),
              ],
            ),
          ],
        ),
      ),
      const SizedBox(height: 14),
      const Text(
        'Category',
        style: TextStyle(fontSize: 11, fontWeight: FontWeight.w900, color: WavyonColors.text),
      ),
      const SizedBox(height: 10),
      Wrap(
        spacing: 8,
        runSpacing: 8,
        children: const [
          FilterChipButton(label: 'Free', active: true),
          FilterChipButton(label: 'Info', active: false),
          FilterChipButton(label: 'Question', active: false),
          FilterChipButton(label: 'Review', active: false),
        ],
      ),
      const SizedBox(height: 16),
      WavyonTextField(hint: titleHint),
      const SizedBox(height: 12),
      const WavyonTextField(
        hint: 'Body',
        maxLines: 8,
      ),
      const SizedBox(height: 12),
      InlineNotice(
        title: 'Writing guide',
        description: bodyHint,
      ),
    ];
  }

  List<Widget> _tripCategorySections(BuildContext context) {
    return [
      const SearchBarCard(placeholder: 'Search trip products', withFilter: true),
      const SizedBox(height: 18),
      ...tripProducts.map(
        (product) => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _ProductListCard(
            product: product,
            onTap: () => onNavigate(
              AppRoute(AppRouteId.tripProductDetail, title: product.title, payload: {'id': product.id}),
            ),
          ),
        ),
      ),
    ];
  }

  List<Widget> _tripProductDetailSections() {
    final productId = route.payload['id'];
    final product = tripProducts.firstWhere(
      (entry) => entry.id == productId,
      orElse: () => tripProducts.first,
    );

    return [
      const WavyonCard(
        padding: EdgeInsets.zero,
        child: PlaceholderThumb(size: 320, radius: 24),
      ),
      const SizedBox(height: 16),
      BadgeChip(
        label: product.badge,
        background: product.badgeBackground,
        foreground: product.badgeForeground,
        border: product.badgeBackground,
      ),
      const SizedBox(height: 12),
      Text(product.title, style: const TextStyle(fontSize: 22, height: 1.18, fontWeight: FontWeight.w900, color: WavyonColors.text)),
      const SizedBox(height: 8),
      Text(product.description, style: const TextStyle(fontSize: 12, height: 1.5, fontWeight: FontWeight.w700, color: WavyonColors.subtleText)),
      const SizedBox(height: 18),
      WavyonCard(
        child: Column(
          children: [
            InfoRow(label: 'Price', value: product.priceLabel, emphasize: true),
            InfoRow(label: 'Location', value: product.location),
            InfoRow(label: 'Category', value: product.category),
          ],
        ),
      ),
    ];
  }

  List<Widget> _tripBookingSections() {
    return [
      ..._tripProductDetailSections(),
      const SizedBox(height: 14),
      const WavyonCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Booking draft',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900, color: WavyonColors.text),
            ),
            SizedBox(height: 10),
            InfoRow(label: 'Date', value: 'Apr 23 | 3:00 PM'),
            InfoRow(label: 'Guests', value: '2'),
            InfoRow(label: 'Policy', value: 'Shown as a compact summary card'),
          ],
        ),
      ),
    ];
  }

  List<Widget> _tripBookingCompleteSections() {
    return [
      const EmptyState(
        title: 'Booking complete',
        description: 'The booking completion screen now follows the same card language as the rest of the Flutter app.',
        icon: Icons.check_circle_outline_rounded,
      ),
      const SizedBox(height: 14),
      const WavyonCard(
        child: Column(
          children: [
            InfoRow(label: 'Reservation', value: 'RSV-20260423'),
            InfoRow(label: 'Time', value: 'Apr 23 | 3:00 PM'),
            InfoRow(label: 'Location', value: 'The Hyundai Seoul'),
          ],
        ),
      ),
    ];
  }

  List<Widget> _tradeDetailSections() {
    final tradeId = route.payload['id'];
    final item = tradeItems.firstWhere(
      (entry) => entry.id == tradeId,
      orElse: () => tradeItems.first,
    );
    final style = tradeStatusStyle(item.statusKey);

    return [
      const WavyonCard(
        padding: EdgeInsets.zero,
        child: PlaceholderThumb(size: 320, radius: 24),
      ),
      const SizedBox(height: 16),
      BadgeChip(
        label: tradeStatusLabel(item.statusKey),
        background: style.background,
        foreground: style.foreground,
        border: style.border,
      ),
      const SizedBox(height: 12),
      Text(item.title, style: const TextStyle(fontSize: 22, height: 1.18, fontWeight: FontWeight.w900, color: WavyonColors.text)),
      const SizedBox(height: 6),
      Text(item.priceLabel, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: WavyonColors.text)),
      const SizedBox(height: 14),
      WavyonCard(
        child: Column(
          children: [
            InfoRow(label: 'Seller', value: item.sellerNickname),
            InfoRow(label: 'Buyer', value: item.buyerNickname),
            InfoRow(label: 'Latest state', value: item.lastStateText),
          ],
        ),
      ),
      const SizedBox(height: 14),
      const InlineNotice(
        title: 'Trade moderation',
        description: 'Reported or blocked states still preserve their own visibility and badge styling in the converted UI.',
      ),
    ];
  }

  List<Widget> _tradeChatSections() {
    return [
      const ChatBubble(kind: 'system', text: 'The existing conversation remains visible even when the room becomes read-only.'),
      const SizedBox(height: 16),
      const ChatBubble(
        kind: 'other',
        sender: 'Jay_Trade',
        time: '14:02',
        text: 'Is this still available for a direct meetup near the venue?',
      ),
      const SizedBox(height: 12),
      const ChatBubble(
        kind: 'me',
        text: 'Yes, I can meet by Gate 2 before the show starts.',
      ),
      const SizedBox(height: 12),
      const ChatBubble(
        kind: 'other',
        sender: 'Jay_Trade',
        time: '14:07',
        text: 'Perfect. Please reserve it for me.',
      ),
    ];
  }

  List<Widget> _systemAlertSections() {
    final alertId = route.payload['id'];
    final item = systemAlerts.firstWhere(
      (entry) => entry.id == alertId,
      orElse: () => systemAlerts.first,
    );
    final style = notificationCategoryStyle(item.category);

    return [
      BadgeChip(
        label: item.category,
        background: style.background,
        foreground: style.foreground,
        border: style.border,
      ),
      const SizedBox(height: 12),
      Text(item.title, style: const TextStyle(fontSize: 22, height: 1.18, fontWeight: FontWeight.w900, color: WavyonColors.text)),
      const SizedBox(height: 10),
      Text(item.time, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: WavyonColors.muted)),
      const SizedBox(height: 16),
      WavyonCard(
        child: Text(
          item.body,
          style: const TextStyle(
            fontSize: 12,
            height: 1.55,
            fontWeight: FontWeight.w700,
            color: WavyonColors.subtleText,
          ),
        ),
      ),
    ];
  }

  List<Widget> _reservationListSections() {
    return reservations
        .map(
          (item) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: WavyonCard(
              onTap: () => onNavigate(
                AppRoute(AppRouteId.reservationDetail, title: item.title, payload: {'id': item.id}),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w900, color: WavyonColors.text)),
                  const SizedBox(height: 8),
                  Text(
                    '${item.kind} | ${item.time}',
                    style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: WavyonColors.subtleText),
                  ),
                  const SizedBox(height: 4),
                  Text(item.location, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: WavyonColors.muted)),
                ],
              ),
            ),
          ),
        )
        .toList();
  }

  List<Widget> _paymentSections(BuildContext context) {
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
  }

  List<Widget> _pointsCouponSections() {
    return [
      const WavyonCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Points & Coupons',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: WavyonColors.text),
            ),
            SizedBox(height: 12),
            InfoRow(label: 'Points', value: '12,500P', emphasize: true),
            InfoRow(label: 'Active coupons', value: '4'),
          ],
        ),
      ),
    ];
  }

  List<Widget> _supportSections() {
    return supportItems
        .map(
          (item) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: WavyonCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w900, color: WavyonColors.text)),
                  const SizedBox(height: 8),
                  Text(item.body, style: const TextStyle(fontSize: 11, height: 1.5, fontWeight: FontWeight.w700, color: WavyonColors.subtleText)),
                ],
              ),
            ),
          ),
        )
        .toList();
  }

  List<Widget> _settingsSections() {
    return [
      const SectionTitle(
        title: 'Language',
        icon: Icons.language_rounded,
      ),
      const SizedBox(height: 12),
      SegmentTabs<String>(
        items: defaultLanguages
            .map((language) => SegmentTabItem(value: language, label: language))
            .toList(),
        value: 'ko',
        onChanged: (_) {},
      ),
      const SizedBox(height: 18),
      const SectionTitle(
        title: 'General & Alerts',
        icon: Icons.settings_outlined,
      ),
      const SizedBox(height: 12),
      WavyonCard(
        padding: EdgeInsets.zero,
        child: Column(
          children: const [
            _SettingsToggleRow(label: 'Push notifications', enabled: true),
            Divider(height: 1, color: WavyonColors.line),
            _SettingsToggleRow(label: 'Marketing consent', enabled: false),
            Divider(height: 1, color: WavyonColors.line),
            _SettingsToggleRow(label: 'Trade alerts', enabled: false),
          ],
        ),
      ),
    ];
  }

  List<Widget> _liveChatSections() {
    return [
      const SearchBarCard(placeholder: 'Search live threads'),
      const SizedBox(height: 14),
      const InlineNotice(
        title: '24-hour live thread',
        description:
            'Threads expire automatically after 24 hours, and the create button stays in the header for quick access.',
      ),
      const SizedBox(height: 14),
      ...liveThreads.map(
        (thread) => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: WavyonCard(
            onTap: () => onNavigate(const AppRoute(AppRouteId.communityDetail, title: 'Community Detail')),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          if (thread.hot)
                            const BadgeChip(
                              label: 'HOT',
                              background: Color(0xFFDC2626),
                              foreground: Colors.white,
                              border: Color(0xFFDC2626),
                            ),
                          if (thread.hot) const SizedBox(width: 8),
                          Text(
                            '${thread.remain} left',
                            style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: WavyonColors.muted),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(thread.title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w900, color: WavyonColors.text)),
                      const SizedBox(height: 8),
                      Text(
                        '${thread.users} users joined',
                        style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: WavyonColors.blue),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right_rounded, color: Color(0xFFCBD5E1)),
              ],
            ),
          ),
        ),
      ),
    ];
  }

  List<Widget> _chatRoomSections() {
    final roomId = route.payload['id'];
    final room = roomChats.firstWhere(
      (entry) => entry.id == roomId,
      orElse: () => roomChats.first,
    );

    return [
      const ChatBubble(kind: 'system', text: '2026.04.10'),
      const SizedBox(height: 16),
      ChatBubble(
        kind: 'other',
        sender: room.name,
        time: '14:02',
        text: room.id == 'room-1'
            ? 'Pickup starts in five minutes. Please check your location.'
            : 'Is the exchange still available?',
      ),
      const SizedBox(height: 12),
      const ChatBubble(
        kind: 'me',
        text: 'Thanks, I am heading there now.',
      ),
    ];
  }

  List<Widget> _weatherSections() {
    return [
      Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: WavyonGradients.banner1,
          borderRadius: BorderRadius.circular(35),
          boxShadow: WavyonShadows.strong,
        ),
        child: Row(
          children: [
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '22C',
                    style: TextStyle(fontSize: 56, height: 1, fontWeight: FontWeight.w900, color: Colors.white),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'Feels like 24C and clear',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFFE2E8F0)),
                  ),
                ],
              ),
            ),
            Icon(Icons.wb_sunny_outlined, size: 74, color: Colors.amberAccent),
          ],
        ),
      ),
      const SizedBox(height: 16),
      WavyonCard(
        child: Column(
          children: const [
            _WeatherRow(day: 'Today', weather: '22C / 15C', icon: Icons.wb_sunny_outlined),
            Divider(height: 1, color: WavyonColors.line),
            _WeatherRow(day: 'Tomorrow', weather: '25C / 16C', icon: Icons.sunny),
            Divider(height: 1, color: WavyonColors.line),
            _WeatherRow(day: 'Thu', weather: '20C / 14C', icon: Icons.grain_rounded),
            Divider(height: 1, color: WavyonColors.line),
            _WeatherRow(day: 'Fri', weather: '23C / 15C', icon: Icons.wb_sunny_outlined),
          ],
        ),
      ),
      const SizedBox(height: 14),
      const InlineNotice(
        title: 'Packing guide',
        description:
            'Concert and airport movement can feel cooler at night, so this card keeps the contextual notice style from the React draft.',
      ),
    ];
  }

  Widget _commentSection() {
    return WavyonCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Text(
                'Comments',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w900, color: WavyonColors.text),
              ),
            ],
          ),
          const SizedBox(height: 14),
          ...communityPosts.take(2).map(
            (post) => Padding(
              padding: EdgeInsets.only(bottom: post == communityPosts[1] ? 0 : 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post.author,
                    style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w900, color: WavyonColors.text),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    post.excerpt ?? post.title,
                    style: const TextStyle(fontSize: 11, height: 1.45, fontWeight: FontWeight.w700, color: WavyonColors.subtleText),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget _paymentCard(BuildContext context, PaymentRecord item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: WavyonCard(
        child: Row(
          children: [
            const Icon(Icons.receipt_long_rounded, color: WavyonColors.subtleText),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.title, style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 4),
                  Text(item.date, style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
            ),
            Text(
              item.amount,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w900, color: WavyonColors.text),
            ),
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

class _SubHeader extends StatelessWidget {
  const _SubHeader({
    required this.title,
    required this.onBack,
    this.right,
  });

  final String title;
  final VoidCallback onBack;
  final Widget? right;

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
          padding: const EdgeInsets.fromLTRB(16, 6, 16, 12),
          child: Row(
            children: [
              IconButton(
                onPressed: onBack,
                icon: const Icon(Icons.chevron_left_rounded, size: 28),
                color: WavyonColors.text,
              ),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    color: WavyonColors.text,
                  ),
                ),
              ),
              SizedBox(
                width: 36,
                height: 36,
                child: right == null ? const SizedBox.shrink() : Center(child: right),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _UploadTile extends StatelessWidget {
  const _UploadTile();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 92,
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: WavyonColors.line, style: BorderStyle.solid),
      ),
      child: const Center(
        child: Text(
          'Add image',
          style: TextStyle(fontSize: 11, fontWeight: FontWeight.w900, color: WavyonColors.muted),
        ),
      ),
    );
  }
}

class _ProductListCard extends StatelessWidget {
  const _ProductListCard({
    required this.product,
    required this.onTap,
  });

  final ProductItem product;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return WavyonCard(
      onTap: onTap,
      child: Row(
        children: [
          PlaceholderThumb(label: product.imageLabel, size: 72),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BadgeChip(
                  label: product.badge,
                  background: product.badgeBackground,
                  foreground: product.badgeForeground,
                  border: product.badgeBackground,
                ),
                const SizedBox(height: 8),
                Text(product.title, style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 4),
                Text(product.description, style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(height: 8),
                Text(product.priceLabel, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w900, color: WavyonColors.text)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingsToggleRow extends StatelessWidget {
  const _SettingsToggleRow({
    required this.label,
    required this.enabled,
  });

  final String label;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: WavyonColors.subtleText),
            ),
          ),
          Container(
            width: 48,
            height: 26,
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: enabled ? WavyonColors.blue : const Color(0xFFE2E8F0),
              borderRadius: BorderRadius.circular(999),
            ),
            child: Align(
              alignment: enabled ? Alignment.centerRight : Alignment.centerLeft,
              child: const DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: SizedBox(width: 20, height: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ComposerBar extends StatelessWidget {
  const _ComposerBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.96),
        border: const Border(top: BorderSide(color: WavyonColors.line)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x08000000),
            blurRadius: 20,
            offset: Offset(0, -8),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: WavyonColors.line),
              ),
              child: const Icon(Icons.image_outlined, size: 20, color: WavyonColors.muted),
            ),
            const SizedBox(width: 10),
            const Expanded(
              child: WavyonTextField(hint: 'Type a message'),
            ),
            const SizedBox(width: 10),
            const SizedBox(
              width: 92,
              child: WavyonButton(
                label: 'Send',
                padding: EdgeInsets.symmetric(horizontal: 18, vertical: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WeatherRow extends StatelessWidget {
  const _WeatherRow({
    required this.day,
    required this.weather,
    required this.icon,
  });

  final String day;
  final String weather;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Row(
        children: [
          Expanded(
            child: Text(
              day,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w900, color: WavyonColors.subtleText),
            ),
          ),
          Icon(icon, size: 20, color: WavyonColors.amber),
          const SizedBox(width: 18),
          Text(
            weather,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w900, color: WavyonColors.text),
          ),
        ],
      ),
    );
  }
}
