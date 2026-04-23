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
    if (route.id == AppRouteId.tripProductDetail) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            ListView(
              padding: const EdgeInsets.fromLTRB(20, 18, 20, 120),
              children: _buildSections(context),
            ),
            SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 14, 20, 0),
                child: Row(
                  children: [
                    _OverlayCircleButton(
                      icon: Icons.chevron_left_rounded,
                      onTap: () => Navigator.of(context).pop(),
                    ),
                    const Spacer(),
                    const _OverlayCircleButton(icon: Icons.ios_share_rounded),
                  ],
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: _buildBottomBar(context),
      );
    }

    if (route.id == AppRouteId.notifications) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            _SubHeader(
              title: route.title ?? _fallbackTitle(route.id),
              onBack: () => Navigator.of(context).pop(),
              right: _buildHeaderAction(context),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 120),
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: SearchBarCard(placeholder: '알림 검색'),
                  ),
                  const SizedBox(height: 18),
                  ..._notificationRows(context),
                ],
              ),
            ),
          ],
        ),
      );
    }

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

  TradeItem _tradeItemFromRoute() {
    final tradeId = route.payload['id'];
    return tradeItems.firstWhere(
      (entry) => entry.id == tradeId,
      orElse: () => tradeItems.first,
    );
  }

  ProductItem _productFromRoute() {
    final productId = route.payload['id'];
    return tripProducts.firstWhere(
      (entry) => entry.id == productId,
      orElse: () => tripProducts.first,
    );
  }

  bool _isTradeReadOnly(String statusKey) {
    return statusKey == 'COMPLETED' ||
        statusKey == 'HIDDEN_REPORTED' ||
        statusKey == 'HIDDEN_BLOCKED' ||
        statusKey == 'DELETED';
  }

  Widget? _buildHeaderAction(BuildContext context) {
    switch (route.id) {
      case AppRouteId.notifications:
        return GestureDetector(
          onTap: () {},
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
            decoration: BoxDecoration(
              color: const Color(0xFFEFF6FF),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Text(
              '모두 읽음',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w900,
                color: WavyonColors.blue,
              ),
            ),
          ),
        );
      case AppRouteId.newsDetail:
        return const Icon(Icons.ios_share_rounded, size: 20, color: WavyonColors.muted);
      case AppRouteId.tradeDetail:
        return GestureDetector(
          onTap: () => onNavigate(
            AppRoute(AppRouteId.tradeEdit, title: '거래글 수정', payload: route.payload),
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.edit_outlined, size: 12, color: WavyonColors.subtleText),
                SizedBox(width: 6),
                Text(
                  '수정',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                    color: WavyonColors.subtleText,
                  ),
                ),
              ],
            ),
          ),
        );
      case AppRouteId.liveChatList:
        return GestureDetector(
          onTap: () => onNavigate(const AppRoute(AppRouteId.liveThreadCreate, title: '라이브 스레드 만들기')),
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
              label: '고객센터',
              variant: WavyonButtonVariant.ghost,
            ),
            WavyonButton(label: '다시 불러오기'),
          ],
        );
      case AppRouteId.reservationDetail:
        return BottomFixedActionBar(
          children: [
            WavyonButton(
              label: '결제 / 환불 / 양도',
              variant: WavyonButtonVariant.ghost,
              onPressed: () => onNavigate(const AppRoute(AppRouteId.paymentCenter, title: '결제 / 환불 / 양도')),
            ),
            WavyonButton(
              label: '고객센터',
              onPressed: () => onNavigate(const AppRoute(AppRouteId.support, title: '고객센터')),
            ),
          ],
        );
      case AppRouteId.tripProductDetail:
        return _TripProductActionBar(
          onPrimaryTap: () => onNavigate(
              AppRoute(
                AppRouteId.tripBooking,
              title: '예약 / 결제',
              payload: {'id': _productFromRoute().id},
            ),
          ),
        );
      case AppRouteId.tripBooking:
        return BottomFixedActionBar(
          children: [
            WavyonButton(
              label: '취소',
              variant: WavyonButtonVariant.ghost,
              onPressed: () => Navigator.of(context).pop(),
            ),
            WavyonButton(
              label: '결제하고 예약 완료',
              onPressed: () => onNavigate(
                AppRoute(
                  AppRouteId.tripBookingComplete,
                  title: '예약 완료',
                  payload: {'id': _productFromRoute().id},
                ),
              ),
            ),
          ],
        );
      case AppRouteId.tripBookingComplete:
        return BottomFixedActionBar(
          children: [
            WavyonButton(
              label: '결제 상세',
              variant: WavyonButtonVariant.ghost,
              onPressed: () => onNavigate(const AppRoute(AppRouteId.paymentCenter, title: '결제 / 환불 / 양도')),
            ),
            WavyonButton(
              label: '내 예약',
              onPressed: () => onNavigate(const AppRoute(AppRouteId.myReservations, title: '내 예약')),
            ),
          ],
        );
      case AppRouteId.tradeDetail:
        final item = _tradeItemFromRoute();
        final readOnly = _isTradeReadOnly(item.statusKey);
        return BottomFixedActionBar(
          children: [
            WavyonButton(
              label: '신고 / 차단',
              variant: WavyonButtonVariant.ghost,
              onPressed: () {},
            ),
            WavyonButton(
              label: readOnly ? '대화 보기' : '채팅하기',
              onPressed: () => onNavigate(
                AppRoute(AppRouteId.tradeChat, title: 'Trade 채팅', payload: route.payload),
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
            WavyonButton(label: '등록하기'),
          ],
        );
      case AppRouteId.tradeChat:
        return _TradeChatActionBar(
          readOnly: _isTradeReadOnly(_tradeItemFromRoute().statusKey),
        );
      case AppRouteId.chatRoom:
        return const _ComposerBar();
      default:
        return null;
    }
  }

  List<Widget> _buildSections(BuildContext context) {
    switch (route.id) {
      case AppRouteId.notifications:
        return _notificationRows(context);
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
          titleHint: '제목을 입력하세요',
          bodyHint: '현장 정보, 반응, 참고 링크처럼 꼭 필요한 맥락만 짧고 또렷하게 작성해 주세요.',
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
          titleHint: '거래글 제목을 입력하세요',
          bodyHint: '상품 상태, 가격, 거래 장소, 주의사항을 분명하게 적어두면 이후 확인이 쉬워집니다.',
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

  List<Widget> _notificationRows(BuildContext context) {
    return notifications.map((item) {
      final style = notificationCategoryStyle(item.category);
      return Padding(
        padding: const EdgeInsets.only(bottom: 1),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          decoration: BoxDecoration(
            color: item.read ? Colors.white : const Color(0xFFF8FBFF),
            border: const Border(bottom: BorderSide(color: Color(0xFFF8FAFC))),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 2),
                child: Icon(
                  Icons.notifications_active_outlined,
                  size: 18,
                  color: WavyonColors.blue,
                ),
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
    }).toList();
  }

  List<Widget> _qrSections() {
    return [
      WavyonCard(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 10,
              decoration: BoxDecoration(
                gradient: WavyonGradients.banner1,
                borderRadius: BorderRadius.circular(999),
              ),
            ),
            const SizedBox(height: 18),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                BadgeChip(
                  label: '사용 가능',
                  background: Color(0xFFEFF6FF),
                  foreground: WavyonColors.blue,
                  border: Color(0xFFBFDBFE),
                ),
                SizedBox(width: 8),
                Text(
                  '예약 1건당 QR 1개',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    color: WavyonColors.muted,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Text(
              'NCT 127 고척돔행 셔틀',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: WavyonColors.text,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              '1호차 (경기77바1234)',
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
              child: const Icon(Icons.qr_code_2_rounded, size: 150, color: WavyonColors.ink),
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
                '저장 / 공유 / 캡처는 허용되지 않습니다.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  color: WavyonColors.red,
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              '현재 QR을 사용해 탑승 검수가 가능합니다. 10분 후 자동 갱신됩니다.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11,
                height: 1.55,
                fontWeight: FontWeight.w700,
                color: WavyonColors.subtleText,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: WavyonColors.line),
              ),
              child: const Column(
                children: [
                  InfoRow(label: '출발', value: '14:00 출발 예정'),
                  InfoRow(label: '탑승장소', value: '인천공항 T1 출국장 앞'),
                  InfoRow(label: '예약인원', value: '2명 (동승자 포함)', emphasize: true),
                  InfoRow(label: '최근 갱신', value: '14:20'),
                ],
              ),
            ),
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
              children: [
                const Expanded(
                  child: Text(
                    '상품 예약',
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: WavyonColors.muted),
                  ),
                ),
                BadgeChip(
                  label: item.status,
                  background: const Color(0xFFEFF6FF),
                  foreground: WavyonColors.blue,
                  border: const Color(0xFFBFDBFE),
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
                  InfoRow(label: '카테고리', value: item.kind),
                  InfoRow(label: '예약 일시', value: item.time, emphasize: true),
                  InfoRow(label: '장소', value: item.location),
                  const InfoRow(label: '예약자', value: 'KIM WAVY'),
                  InfoRow(label: '예약 번호', value: 'RSV-${item.id}'),
                ],
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 14),
      const WavyonCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '예약 안내',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w900,
                color: WavyonColors.text,
              ),
            ),
            SizedBox(height: 10),
            Text(
              '내 예약 상세는 상품 기준 예약 정보를 노출하며, QR은 포함하지 않습니다. 결제·환불·양도 상세는 별도 센터에서 확인합니다.',
              style: TextStyle(
                fontSize: 11,
                height: 1.6,
                fontWeight: FontWeight.w700,
                color: WavyonColors.subtleText,
              ),
            ),
          ],
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
        '${news.body}\n\n연관 라이브 스레드와 기사 흐름을 분리해서, 뉴스 상세가 단순 리스트처럼 보이지 않도록 맞췄습니다.',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      const SizedBox(height: 18),
      GestureDetector(
        onTap: () => onNavigate(const AppRoute(AppRouteId.liveChatList, title: '라이브 스레드')),
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
                '연관 라이브 스레드',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w900, color: Colors.white),
              ),
              SizedBox(height: 8),
              Text(
                '기사에서 바로 실시간 토론 흐름으로 넘어갈 수 있도록 연결합니다.',
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
      WavyonCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEFF6FF),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    'W',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w900,
                      color: WavyonColors.primary,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(post.author, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w900, color: WavyonColors.text)),
                      const SizedBox(height: 2),
                      Text(
                        '${post.time} | ${post.stats ?? '1.2k views'}',
                        style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: WavyonColors.muted),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.more_horiz_rounded, color: WavyonColors.muted),
              ],
            ),
            const SizedBox(height: 18),
            Text(post.title, style: const TextStyle(fontSize: 20, height: 1.22, fontWeight: FontWeight.w900, color: WavyonColors.text)),
            const SizedBox(height: 16),
            Text(
              '${post.excerpt ?? ''}\n\nThe detail page keeps the social actions and comments in the same layered card flow as the React prototype.',
              style: const TextStyle(
                fontSize: 13,
                height: 1.6,
                fontWeight: FontWeight.w700,
                color: WavyonColors.subtleText,
              ),
            ),
            const SizedBox(height: 18),
            const _MediaPlaceholder(height: 190, radius: 30, label: 'IMAGE'),
            const SizedBox(height: 18),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(color: Color(0xFFF8FAFC)),
                  bottom: BorderSide(color: Color(0xFFF8FAFC)),
                ),
              ),
              child: Row(
                children: [
                  const _StatLabel(icon: Icons.favorite_border_rounded, value: '420'),
                  const SizedBox(width: 20),
                  const _StatLabel(icon: Icons.chat_bubble_outline_rounded, value: '85'),
                  const Spacer(),
                  Row(
                    children: const [
                      Icon(Icons.share_outlined, size: 14, color: WavyonColors.muted),
                      SizedBox(width: 6),
                      Text(
                        'Share',
                        style: TextStyle(fontSize: 11, fontWeight: FontWeight.w900, color: WavyonColors.muted),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 18),
      _commentSection(),
    ];
  }

  List<Widget> _communityBoardSections(BuildContext context) {
    final isFreeBoard = route.id == AppRouteId.freeBoard;
    final posts = isFreeBoard ? freeBoardFeed.take(4).toList(growable: false) : communityPosts;

    return [
      if (!isFreeBoard) ...[
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFEFF6FF),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: const Color(0xFFBFDBFE)),
            boxShadow: WavyonShadows.card,
          ),
          child: const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.info_outline_rounded, size: 18, color: WavyonColors.blue),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'NCT 127 팬덤 게시판',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900, color: WavyonColors.blue),
                    ),
                    SizedBox(height: 6),
                    Text(
                      '팬덤 게시판 더보기 진입 시 사용하는 전용 목록 페이지입니다.',
                      style: TextStyle(fontSize: 11, height: 1.45, fontWeight: FontWeight.w700, color: WavyonColors.subtleText),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        const SearchBarCard(placeholder: 'NCT 127 게시판 글 검색'),
        const SizedBox(height: 14),
      ] else ...[
        const SectionTitle(
          title: '자유게시판',
          subtitle: '실시간 뉴스처럼 바로 글 리스트를 노출하고, 더보기로 전용 목록 페이지에 진입합니다.',
        ),
        const SizedBox(height: 14),
      ],
      ...posts.map(
        (post) => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: WavyonCard(
            onTap: () => onNavigate(const AppRoute(AppRouteId.communityDetail, title: '게시글 상세보기')),
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
                Row(
                  children: [
                    Text(
                      isFreeBoard ? post.author : 'NCT 127 · ${post.author}',
                      style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: WavyonColors.muted),
                    ),
                    const Spacer(),
                    _StatLabel(
                      icon: Icons.chat_bubble_outline_rounded,
                      value: '${post.comments}',
                      iconSize: 11,
                      fontSize: 10,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      post.stats ?? '조회 122',
                      style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: WavyonColors.muted),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ];
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
        '카테고리',
        style: TextStyle(fontSize: 11, fontWeight: FontWeight.w900, color: WavyonColors.text),
      ),
      const SizedBox(height: 10),
      Wrap(
        spacing: 8,
        runSpacing: 8,
        children: const [
          FilterChipButton(label: '자유', active: true),
          FilterChipButton(label: '정보', active: false),
          FilterChipButton(label: '질문', active: false),
          FilterChipButton(label: '후기', active: false),
        ],
      ),
      const SizedBox(height: 16),
      WavyonTextField(hint: titleHint),
      const SizedBox(height: 12),
      const WavyonTextField(
        hint: '내용을 입력하세요',
        maxLines: 8,
      ),
      const SizedBox(height: 12),
      InlineNotice(
        title: '작성 가이드',
        description: bodyHint,
      ),
    ];
  }

  List<Widget> _tripCategorySections(BuildContext context) {
    final rawCategory = '${route.payload['category'] ?? route.title ?? 'FOOD'}'.toUpperCase();
    final items = switch (rawCategory) {
      'HOTSPOT' => hotspotTripProducts,
      'FOOD' => foodTripProducts,
      'POPUP' => tripProducts.where((item) => item.category == 'POPUP').toList(growable: false),
      'BEAUTY' => tripProducts.where((item) => item.category == 'BEAUTY').toList(growable: false),
      _ => tripProducts,
    };

    return [
      const SearchBarCard(placeholder: '매장명 / 상품명 검색', withFilter: true),
      const SizedBox(height: 18),
      Wrap(
        spacing: 8,
        runSpacing: 8,
        children: const [
          FilterChipButton(label: '전체', active: true),
          FilterChipButton(label: '인기순', active: false),
          FilterChipButton(label: '예약가능', active: false),
          FilterChipButton(label: '할인', active: false),
        ],
      ),
      const SizedBox(height: 18),
      ...items.map(
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
    final product = _productFromRoute();

    return [
      _edgeToEdge(
        _ProductHero(product: product),
      ),
      const SizedBox(height: 16),
      WavyonCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '공통 상품 템플릿',
                        style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: WavyonColors.muted),
                      ),
                      const SizedBox(height: 6),
                      _PriceWithUnit(priceLabel: product.priceLabel),
                    ],
                  ),
                ),
                BadgeChip(
                  label: product.category,
                  background: const Color(0xFFEFF6FF),
                  foreground: WavyonColors.blue,
                  border: const Color(0xFFBFDBFE),
                ),
              ],
            ),
            const SizedBox(height: 16),
            InfoRow(label: '가격', value: product.priceLabel, emphasize: true),
            InfoRow(label: '위치', value: product.location),
            InfoRow(label: '카테고리', value: product.category),
          ],
        ),
      ),
      const SizedBox(height: 18),
      const Text(
        '상품 하이라이트',
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900, color: WavyonColors.text),
      ),
      const SizedBox(height: 14),
      _FeatureRow(text: '기존 HOTSPOT 카드와 동일한 톤으로 상세 정보를 확장합니다.'),
      const SizedBox(height: 12),
      _FeatureRow(text: '예약 시 날짜, 인원, 요청 사항, 포인트/쿠폰 사용을 함께 처리합니다.'),
      const SizedBox(height: 12),
      _FeatureRow(text: '예약/결제 완료 화면은 별도 랜딩 페이지로 분리합니다.'),
      const SizedBox(height: 18),
      WavyonCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '포함 / 제외',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900, color: WavyonColors.text),
            ),
            const SizedBox(height: 10),
            const Text(
              '포함 사항, 현장 안내, 이용 정책을 설계서 기준 정보 슬롯으로 유지합니다.',
              style: TextStyle(fontSize: 11, height: 1.5, fontWeight: FontWeight.w700, color: WavyonColors.subtleText),
            ),
            const SizedBox(height: 12),
            InfoRow(label: '위치', value: product.location),
            const InfoRow(label: '예약 방식', value: '일정 선택 후 결제'),
            const InfoRow(label: '포인트 / 쿠폰', value: '사용 가능'),
          ],
        ),
      ),
    ];
  }

  List<Widget> _tripBookingSections() {
    final product = _productFromRoute();

    return [
      WavyonCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '예약 상품',
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: WavyonColors.muted),
            ),
            const SizedBox(height: 6),
            Text(
              product.title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: WavyonColors.text),
            ),
            const SizedBox(height: 8),
            Text(
              product.location,
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: WavyonColors.subtleText),
            ),
          ],
        ),
      ),
      const SizedBox(height: 14),
      WavyonCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              '예약 정보',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900, color: WavyonColors.text),
            ),
            SizedBox(height: 14),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                _BookingChoiceTile(label: '2026.04.22', active: true),
                _BookingChoiceTile(label: '2026.04.23', active: false),
                _BookingChoiceTile(label: '2026.04.24', active: false),
              ],
            ),
            SizedBox(height: 10),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                _BookingChoiceTile(label: '1명', active: false, compact: true),
                _BookingChoiceTile(label: '2명', active: true, compact: true),
                _BookingChoiceTile(label: '3명', active: false, compact: true),
              ],
            ),
            SizedBox(height: 12),
            WavyonTextField(
              hint: '요청 사항',
              maxLines: 4,
            ),
          ],
        ),
      ),
      const SizedBox(height: 14),
      WavyonCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '포인트 / 쿠폰 / 결제',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900, color: WavyonColors.text),
            ),
            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: WavyonColors.line),
              ),
              child: const Column(
                children: [
                  InfoRow(label: '보유 포인트', value: '12,500P'),
                  InfoRow(label: '사용 포인트', value: '1,000P', emphasize: true),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: const [
                FilterChipButton(label: '사용 안 함', active: false),
                FilterChipButton(label: '1,000P', active: true),
                FilterChipButton(label: '3,000P', active: false),
                FilterChipButton(label: '전액 사용', active: false),
              ],
            ),
            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: WavyonColors.line),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Row(
                    children: [
                      Text(
                        '사용 가능 쿠폰',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900, color: WavyonColors.text),
                      ),
                      Spacer(),
                      Text(
                        '2개 보유',
                        style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: WavyonColors.muted),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  _CouponSelectionRow(
                    title: '팬덤 10% 할인',
                    date: '2026.04.30까지',
                    active: true,
                  ),
                  SizedBox(height: 8),
                  _CouponSelectionRow(
                    title: '공항 픽업 혜택',
                    date: '2026.05.05까지',
                    active: false,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: WavyonColors.line),
              ),
              child: Column(
                children: [
                  const InfoRow(label: '적용 쿠폰', value: '팬덤 10% 할인'),
                  const InfoRow(label: '예약 날짜', value: '2026.04.22'),
                  const InfoRow(label: '예약 인원', value: '2명'),
                  InfoRow(label: '총 결제금액', value: product.priceLabel, emphasize: true),
                ],
              ),
            ),
          ],
        ),
      ),
    ];
  }

  List<Widget> _tripBookingCompleteSections() {
    final product = _productFromRoute();

    return [
      WavyonCard(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: const Color(0xFFEFF6FF),
                borderRadius: BorderRadius.circular(999),
              ),
              child: const Icon(Icons.check_circle_rounded, color: WavyonColors.blue, size: 32),
            ),
            const SizedBox(height: 16),
            const Text(
              '예약 완료',
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: WavyonColors.blue),
            ),
            const SizedBox(height: 10),
            const Text(
              '예약이 완료되었습니다',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: WavyonColors.text),
            ),
            const SizedBox(height: 8),
            Text(
              '${product.title} 예약과 결제가 정상적으로 완료되었습니다. 이후 내역은 예약 상세와 결제 화면에서 다시 확인할 수 있습니다.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 11, height: 1.5, fontWeight: FontWeight.w700, color: WavyonColors.subtleText),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: WavyonColors.line),
              ),
              child: Column(
                children: [
                  InfoRow(label: '상품명', value: product.title),
                  const InfoRow(label: '예약 번호', value: 'RSV-BOOKING-2042'),
                  const InfoRow(label: '결제 상태', value: '결제 완료', emphasize: true),
                ],
              ),
            ),
          ],
        ),
      ),
    ];
  }

  List<Widget> _tradeDetailSections() {
    final item = _tradeItemFromRoute();
    final style = tradeStatusStyle(item.statusKey);

    return [
      WavyonCard(
        padding: EdgeInsets.zero,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _MediaPlaceholder(height: 190, radius: 25, label: 'IMAGE', topOnly: true),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      BadgeChip(
                        label: tradeStatusLabel(item.statusKey),
                        background: style.background,
                        foreground: style.foreground,
                        border: style.border,
                      ),
                      const Spacer(),
                      Text(
                        item.priceLabel,
                        style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: WavyonColors.muted),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(item.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: WavyonColors.text)),
                  const SizedBox(height: 6),
                  Text(
                    item.lastStateText,
                    style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: WavyonColors.subtleText),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 14),
      Row(
        children: [
          Expanded(
            child: WavyonCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '판매자',
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: WavyonColors.muted),
                  ),
                  const SizedBox(height: 6),
                  Text(item.sellerNickname, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w900, color: WavyonColors.text)),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: WavyonCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '구매자',
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: WavyonColors.muted),
                  ),
                  const SizedBox(height: 6),
                  Text(item.buyerNickname, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w900, color: WavyonColors.text)),
                ],
              ),
            ),
          ),
        ],
      ),
      const SizedBox(height: 14),
      const InlineNotice(
        title: '거래 상태 안내',
        description: '신고 또는 차단 상태여도 배지와 히스토리는 유지되고, 채팅 입력만 제한됩니다.',
      ),
    ];
  }

  List<Widget> _tradeChatSections() {
    final item = _tradeItemFromRoute();
    final readOnly = _isTradeReadOnly(item.statusKey);
    final style = tradeStatusStyle(item.statusKey);

    final thread = readOnly
        ? const <Widget>[
            ChatBubble(kind: 'system', text: '기존 대화는 읽을 수 있습니다. 거래 상태가 변경되어 입력창이 잠겼습니다.'),
            SizedBox(height: 16),
            ChatBubble(
              kind: 'other',
              sender: 'Jay_Trade',
              time: '14:02',
              text: '확인했습니다. 여기서 약속 장소만 다시 볼게요.',
            ),
          ]
        : const <Widget>[
            ChatBubble(kind: 'system', text: '기존 대화는 읽을 수 없습니다. 거래 상태가 변경되면 입력창 정책이 즉시 반영됩니다.'),
            SizedBox(height: 16),
            ChatBubble(
              kind: 'other',
              sender: 'Jay_Trade',
              time: '14:02',
              text: '혹시 아직 거래 가능한가요?',
            ),
            SizedBox(height: 12),
            ChatBubble(
              kind: 'me',
              text: '네, 현재 판매중입니다. 공연장 2번 게이트 앞 직거래 가능해요.',
            ),
            SizedBox(height: 12),
            ChatBubble(
              kind: 'other',
              sender: 'Jay_Trade',
              time: '14:07',
              text: '좋아요. 우선 예약 부탁드릴게요.',
            ),
          ];

    return [
      WavyonCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '거래글 요약',
                        style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: WavyonColors.muted),
                      ),
                      const SizedBox(height: 4),
                      Text(item.title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w900, color: WavyonColors.text)),
                    ],
                  ),
                ),
                BadgeChip(
                  label: tradeStatusLabel(item.statusKey),
                  background: style.background,
                  foreground: style.foreground,
                  border: style.border,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: WavyonColors.line),
              ),
                child: Column(
                  children: [
                  InfoRow(label: '상대방 닉네임', value: item.buyerNickname),
                  InfoRow(label: '가격', value: item.priceLabel, emphasize: true),
                  ],
                ),
              ),
          ],
        ),
      ),
      const SizedBox(height: 14),
      InlineNotice(
        title: readOnly ? '읽기 전용 안내' : '거래 안내',
        description: readOnly
            ? '완료, 신고, 차단 상태의 거래는 대화 기록만 유지되고 새 메시지는 보낼 수 없습니다.'
            : '거래 장소와 상품 상태를 분명하게 남겨두면 이후 분쟁 확인이 쉬워집니다.',
        danger: readOnly,
      ),
      const SizedBox(height: 16),
      ...thread,
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
      WavyonCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                BadgeChip(
                  label: item.category,
                  background: style.background,
                  foreground: style.foreground,
                  border: style.border,
                ),
                const SizedBox(width: 8),
                Text(item.time, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: WavyonColors.muted)),
              ],
            ),
            const SizedBox(height: 18),
            Text(item.title, style: const TextStyle(fontSize: 18, height: 1.2, fontWeight: FontWeight.w900, color: WavyonColors.text)),
            const SizedBox(height: 14),
            Text(
              item.body,
              style: const TextStyle(
                fontSize: 12,
                height: 1.65,
                fontWeight: FontWeight.w700,
                color: WavyonColors.subtleText,
              ),
            ),
          ],
        ),
      ),
    ];
  }

  List<Widget> _reservationListSections() {
    if (route.id == AppRouteId.myTickets) {
      final tickets = reservations.where((item) => item.kind == 'Ticket').toList(growable: false);
      return [
        const SearchBarCard(placeholder: '티켓 검색'),
        const SizedBox(height: 18),
        ...tickets.map(
          (item) => Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: _TicketListCard(
              item: item,
              onQrTap: () => onNavigate(const AppRoute(AppRouteId.qrCenter, title: 'QR 탑승권')),
            ),
          ),
        ),
      ];
    }

    final bookingItems = reservations.where((item) => item.kind != 'Ticket').toList(growable: false);
    return [
      const SearchBarCard(placeholder: '예약 내역 검색'),
      const SizedBox(height: 18),
      ...bookingItems.map(
        (item) => Padding(
          padding: const EdgeInsets.only(bottom: 14),
          child: _ReservationListCard(
            item: item,
            onTap: () => onNavigate(
              AppRoute(AppRouteId.reservationDetail, title: '예약 상세', payload: {'id': item.id}),
            ),
          ),
        ),
      ),
    ];
  }

  List<Widget> _paymentSections(BuildContext context) {
    if (route.id == AppRouteId.paymentDetail) {
      final detail = paymentHistory.firstWhere(
        (item) => item.id == route.payload['id'],
        orElse: () => paymentHistory.first,
      );

      return [
        WavyonCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: const [
                  Expanded(
                    child: Text(
                      '상품 정보',
                      style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: WavyonColors.muted),
                    ),
                  ),
                  BadgeChip(
                    label: '결제 완료',
                    background: Color(0xFFEFF6FF),
                    foreground: WavyonColors.blue,
                    border: Color(0xFFBFDBFE),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(detail.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: WavyonColors.text)),
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
                    InfoRow(label: '일시', value: detail.date),
                    InfoRow(label: '금액', value: detail.amount, emphasize: true),
                    const InfoRow(label: '주문번호', value: 'ORD-pay-1'),
                    const InfoRow(label: '처리유형', value: 'PAYMENT'),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        const WavyonCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '상세 안내',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w900, color: WavyonColors.text),
              ),
              SizedBox(height: 10),
              Text(
                '해당 상품에 대한 결제 승인 정보와 주문 기준 항목을 노출합니다.',
                style: TextStyle(fontSize: 11, height: 1.6, fontWeight: FontWeight.w700, color: WavyonColors.subtleText),
              ),
            ],
          ),
        ),
      ];
    }

    final currentTab = '${route.payload['tab'] ?? 'payment'}';
    final records = switch (currentTab) {
      'refund' => refundHistory,
      'transfer' => transferHistory,
      _ => paymentHistory,
    };

    return [
      const SearchBarCard(placeholder: '결제 / 환불 / 양도 검색'),
      const SizedBox(height: 18),
      SegmentTabs<String>(
        items: const [
          SegmentTabItem(value: 'payment', label: '결제'),
          SegmentTabItem(value: 'refund', label: '환불'),
          SegmentTabItem(value: 'transfer', label: '양도'),
        ],
        value: currentTab,
        onChanged: (value) => onNavigate(
          AppRoute(AppRouteId.paymentCenter, title: '결제 / 환불 / 양도', payload: {'tab': value}),
        ),
      ),
      const SizedBox(height: 18),
      ...records.map(
        (item) => Padding(
          padding: const EdgeInsets.only(bottom: 14),
          child: _PaymentListCard(
            item: item,
            onTap: currentTab == 'payment'
                ? () => onNavigate(
                      AppRoute(AppRouteId.paymentDetail, title: '결제 상세', payload: {'id': item.id}),
                    )
                : null,
          ),
        ),
      ),
    ];
  }

  List<Widget> _pointsCouponSections() {
    final currentTab = '${route.payload['tab'] ?? 'points'}';

    return [
      const SearchBarCard(placeholder: '포인트 / 쿠폰 검색'),
      const SizedBox(height: 16),
      Row(
        children: const [
          Expanded(
            child: _PointSummaryTile(
              label: '보유 포인트',
              value: '12,500P',
              dark: true,
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: _PointSummaryTile(
              label: '사용 가능 쿠폰',
              value: '4개',
            ),
          ),
        ],
      ),
      const SizedBox(height: 18),
      SegmentTabs<String>(
        items: const [
          SegmentTabItem(value: 'points', label: '포인트'),
          SegmentTabItem(value: 'coupons', label: '쿠폰'),
        ],
        value: currentTab,
        onChanged: (value) => onNavigate(
          AppRoute(AppRouteId.pointsCoupons, title: '포인트 / 쿠폰', payload: {'tab': value}),
        ),
      ),
      const SizedBox(height: 14),
      if (currentTab == 'points') ...const [
        _PointsHistoryCard(title: '셔틀 예약 적립', date: '2026.04.18', delta: '+420P', positive: true),
        SizedBox(height: 12),
        _PointsHistoryCard(title: '쿠폰 교환', date: '2026.04.15', delta: '-500P'),
      ] else ...const [
        _CouponListCard(kind: '쿠폰', title: '홍대 맛집 10% 할인권', date: '2026.04.15'),
        SizedBox(height: 12),
        _CouponListCard(kind: '쿠폰', title: 'NCT 응원봉 보관함 쿠폰', date: '2026.04.12'),
        SizedBox(height: 12),
        _CouponListCard(kind: '쿠폰', title: 'K-Beauty 에스테틱 할인권', date: '2026.04.10'),
        SizedBox(height: 12),
        _CouponListCard(kind: '아이템', title: '아티스트 모션 이모티콘', date: '2026.04.09', accent: Color(0xFFF3E8FF), accentText: Color(0xFF9333EA)),
      ],
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
        title: '언어',
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
        title: '일반 및 알림',
        icon: Icons.settings_outlined,
      ),
      const SizedBox(height: 12),
      WavyonCard(
        padding: EdgeInsets.zero,
        child: Column(
          children: const [
            _SettingsToggleRow(label: '푸시 알림 수신', enabled: true),
            Divider(height: 1, color: WavyonColors.line),
            _SettingsToggleRow(label: '마케팅 정보 수신 동의', enabled: false),
            Divider(height: 1, color: WavyonColors.line),
            _SettingsToggleRow(label: 'Trade 상태 변경 알림', enabled: false),
          ],
        ),
      ),
      const SizedBox(height: 18),
      const SectionTitle(
        title: '계정',
        icon: Icons.help_outline_rounded,
      ),
      const SizedBox(height: 12),
      WavyonCard(
        padding: EdgeInsets.zero,
        child: Column(
          children: [
            _SimpleSettingsRow(label: '로그아웃'),
            Divider(height: 1, color: WavyonColors.line),
            _SimpleSettingsRow(label: '회원 탈퇴', danger: true),
          ],
        ),
      ),
    ];
  }

  List<Widget> _liveChatSections() {
    return [
      const SearchBarCard(placeholder: '라이브 스레드 검색'),
      const SizedBox(height: 14),
      const InlineNotice(
        title: '24시간 라이브 스레드',
        description: '스레드는 24시간 뒤 자동 종료되며, 상단 버튼으로 바로 새 글을 만들 수 있습니다.',
      ),
      const SizedBox(height: 14),
      ...liveThreads.map(
        (thread) => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: WavyonCard(
            onTap: () => onNavigate(const AppRoute(AppRouteId.communityDetail, title: '게시글 상세보기')),
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
                            '${thread.remain} 남음',
                            style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: WavyonColors.muted),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(thread.title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w900, color: WavyonColors.text)),
                      const SizedBox(height: 8),
                      Text(
                        '지금 ${thread.users}명이 대화하고 있어요',
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

    if (room.id == 'room-1') {
      return [
        const ChatBubble(kind: 'system', text: '2026년 4월 10일'),
        const SizedBox(height: 18),
        ChatBubble(
          kind: 'other',
          sender: room.name,
          time: room.time,
          text: room.body,
        ),
      ];
    }

    return [
      const ChatBubble(kind: 'system', text: '2026년 4월 10일'),
      const SizedBox(height: 18),
      ChatBubble(
        kind: 'other',
        sender: room.name,
        time: '10:02',
        text: room.body,
      ),
      const SizedBox(height: 14),
      const ChatBubble(
        kind: 'me',
        text: '네 가능해요. 공연장 앞에서 보실래요?',
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
                  _WeatherLocationChip(),
                  SizedBox(height: 18),
                  Text(
                    '22°',
                    style: TextStyle(fontSize: 56, height: 1, fontWeight: FontWeight.w900, color: Colors.white),
                  ),
                  SizedBox(height: 6),
                  Text(
                    '체감 24° · 맑음',
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
            _WeatherRow(day: '오늘', weather: '22° / 15°', icon: Icons.wb_sunny_outlined),
            Divider(height: 1, color: WavyonColors.line),
            _WeatherRow(day: '내일', weather: '25° / 16°', icon: Icons.sunny),
            Divider(height: 1, color: WavyonColors.line),
            _WeatherRow(day: '수요일', weather: '20° / 14°', icon: Icons.grain_rounded),
            Divider(height: 1, color: WavyonColors.line),
            _WeatherRow(day: '목요일', weather: '23° / 15°', icon: Icons.wb_sunny_outlined),
            Divider(height: 1, color: WavyonColors.line),
            _WeatherRow(day: '금요일', weather: '26° / 17°', icon: Icons.sunny),
          ],
        ),
      ),
      const SizedBox(height: 14),
      const InlineNotice(
        title: '옷차림 추천 가이드',
        description: '일교차가 커서 귀가 시 쌀쌀할 수 있습니다. 얇은 겉옷을 함께 준비하는 흐름으로 디자인을 맞췄습니다.',
      ),
    ];
  }

  Widget _edgeToEdge(Widget child) {
    return Builder(
      builder: (context) {
        final width = MediaQuery.of(context).size.width;
        return Transform.translate(
          offset: const Offset(-20, -18),
          child: OverflowBox(
            minWidth: width,
            maxWidth: width,
            alignment: Alignment.topCenter,
            child: child,
          ),
        );
      },
    );
  }

  Widget _commentSection() {
    return WavyonCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Text(
                '게시글 댓글',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w900, color: WavyonColors.text),
              ),
              Spacer(),
              _PillToggle(label: '최신순', active: true),
              SizedBox(width: 8),
              _PillToggle(label: '인기순', active: false),
            ],
          ),
          const SizedBox(height: 14),
          ...communityPosts.take(2).map(
            (post) => Padding(
              padding: EdgeInsets.only(bottom: post == communityPosts[1] ? 0 : 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        post.author,
                        style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w900, color: WavyonColors.text),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        post.time,
                        style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w800, color: WavyonColors.muted),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    post.excerpt ?? post.title,
                    style: const TextStyle(fontSize: 11, height: 1.45, fontWeight: FontWeight.w700, color: WavyonColors.subtleText),
                  ),
                  const SizedBox(height: 8),
                  _CommentLikePill(value: '${post.likes}'),
                  if (post != communityPosts[1])
                    const Padding(
                      padding: EdgeInsets.only(top: 14),
                      child: Divider(height: 1, color: WavyonColors.line),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              _PaginationDot(label: '1', active: true),
              SizedBox(width: 8),
              _PaginationDot(label: '2', active: false),
              SizedBox(width: 8),
              _PaginationDot(label: '3', active: false),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: const [
              Expanded(
                child: WavyonTextField(hint: '댓글을 입력하세요...'),
              ),
              SizedBox(width: 10),
              _FilledIconButton(icon: Icons.send_rounded),
            ],
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
      AppRouteId.notifications => '알림',
      AppRouteId.qrCenter => 'QR 탑승권',
      AppRouteId.reservationDetail => '예약 상세',
      AppRouteId.newsDetail => '뉴스 상세',
      AppRouteId.communityDetail => '게시글 상세보기',
      AppRouteId.tripCategory => '카테고리',
      AppRouteId.tripProductDetail => '상품 상세',
      AppRouteId.tradeDetail => '거래 상세',
      AppRouteId.tradeChat => 'Trade 채팅',
      AppRouteId.systemAlertDetail => '시스템 알림 상세',
      AppRouteId.myReservations => '내 예약',
      AppRouteId.myTickets => '내 티켓',
      AppRouteId.paymentCenter => '결제 / 환불 / 양도',
      AppRouteId.paymentDetail => '결제 상세',
      AppRouteId.pointsCoupons => '포인트 / 쿠폰',
      AppRouteId.support => '고객센터',
      AppRouteId.settings => '설정',
      AppRouteId.liveChatList => '라이브 스레드',
      AppRouteId.chatRoom => '채팅방',
      AppRouteId.weather => '현지 날씨 정보',
      AppRouteId.tripBooking => '예약 / 결제',
      AppRouteId.tripBookingComplete => '예약 완료',
      AppRouteId.liveThreadCreate => '라이브 스레드 만들기',
      AppRouteId.communityBoardList => '팬덤 게시판',
      AppRouteId.fandomWrite => '글쓰기',
      AppRouteId.tradeWrite => '거래글 작성',
      AppRouteId.tradeEdit => '거래글 수정',
      AppRouteId.freeBoard => '자유게시판',
      AppRouteId.fandomBoard => '팬덤 게시판',
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

class _ReservationListCard extends StatelessWidget {
  const _ReservationListCard({
    required this.item,
    required this.onTap,
  });

  final ReservationItem item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return WavyonCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const BadgeChip(
                label: '예약확정',
                background: Color(0xFFEFF6FF),
                foreground: WavyonColors.blue,
                border: Color(0xFFBFDBFE),
              ),
              const Spacer(),
              Text(
                item.time,
                style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: WavyonColors.muted),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(item.title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w900, color: WavyonColors.text)),
          const SizedBox(height: 8),
          Text(
            item.location,
            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: WavyonColors.subtleText),
          ),
        ],
      ),
    );
  }
}

class _TicketListCard extends StatelessWidget {
  const _TicketListCard({
    required this.item,
    required this.onQrTap,
  });

  final ReservationItem item;
  final VoidCallback onQrTap;

  String get quantity {
    switch (item.id) {
      case 'reservation-3':
        return '2명';
      case 'reservation-4':
        return '1매';
      default:
        return '1건';
    }
  }

  @override
  Widget build(BuildContext context) {
    return WavyonCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Expanded(
                child: Text(
                  'Ticket',
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: WavyonColors.muted),
                ),
              ),
              GestureDetector(
                onTap: onQrTap,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEFF6FF),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Text(
                    'QR',
                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.w900, color: WavyonColors.blue),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(item.title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w900, color: WavyonColors.text)),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: WavyonColors.line),
            ),
            child: Column(
              children: [
                InfoRow(label: '이용 일시', value: item.time),
                InfoRow(label: '이용 장소', value: item.location),
                InfoRow(label: '수량', value: quantity, emphasize: true),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PaymentListCard extends StatelessWidget {
  const _PaymentListCard({
    required this.item,
    this.onTap,
  });

  final PaymentRecord item;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return WavyonCard(
      onTap: onTap,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w900, color: WavyonColors.text)),
                const SizedBox(height: 8),
                Text(
                  item.date,
                  style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: WavyonColors.muted),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Text(
            item.amount,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w900, color: WavyonColors.text),
          ),
        ],
      ),
    );
  }
}

class _CouponListCard extends StatelessWidget {
  const _CouponListCard({
    required this.kind,
    required this.title,
    required this.date,
    this.accent = const Color(0xFFEFF6FF),
    this.accentText = WavyonColors.blue,
  });

  final String kind;
  final String title;
  final String date;
  final Color accent;
  final Color accentText;

  @override
  Widget build(BuildContext context) {
    return WavyonCard(
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BadgeChip(
                  label: kind,
                  background: accent,
                  foreground: accentText,
                  border: accent,
                ),
                const SizedBox(height: 12),
                Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w900, color: WavyonColors.text)),
                const SizedBox(height: 6),
                Text(date, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: WavyonColors.muted)),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFEFF6FF),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Text(
              '사용하기',
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.w900, color: WavyonColors.blue),
            ),
          ),
        ],
      ),
    );
  }
}

class _OverlayCircleButton extends StatelessWidget {
  const _OverlayCircleButton({
    required this.icon,
    this.onTap,
  });

  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(999),
        child: Ink(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.28),
            borderRadius: BorderRadius.circular(999),
          ),
          child: Icon(icon, size: 22, color: Colors.white),
        ),
      ),
    );
  }
}

class _TripProductActionBar extends StatelessWidget {
  const _TripProductActionBar({
    required this.onPrimaryTap,
  });

  final VoidCallback onPrimaryTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
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
            const _FilledIconButton(
              icon: Icons.favorite_border_rounded,
              ghost: true,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: WavyonButton(
                label: '예약 진행',
                onPressed: onPrimaryTap,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TradeChatActionBar extends StatelessWidget {
  const _TradeChatActionBar({
    required this.readOnly,
  });

  final bool readOnly;

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
        child: readOnly
            ? Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: WavyonColors.line),
                ),
                child: const Text(
                  '이 거래 채팅방은 읽기 전용입니다.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900, color: WavyonColors.muted),
                ),
              )
            : Row(
                children: const [
                  _FilledIconButton(
                    icon: Icons.image_outlined,
                    ghost: true,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: WavyonTextField(hint: '메시지를 입력하세요...'),
                  ),
                  SizedBox(width: 10),
                  SizedBox(
                    width: 92,
                    child: WavyonButton(
                      label: '전송',
                      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

class _BookingChoiceTile extends StatelessWidget {
  const _BookingChoiceTile({
    required this.label,
    required this.active,
    this.compact = false,
  });

  final String label;
  final bool active;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: compact ? 18 : 22,
        vertical: 14,
      ),
      decoration: BoxDecoration(
        color: active ? WavyonColors.primary : const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: active ? WavyonColors.primary : WavyonColors.line,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w900,
          color: active ? Colors.white : WavyonColors.subtleText,
        ),
      ),
    );
  }
}

class _CouponSelectionRow extends StatelessWidget {
  const _CouponSelectionRow({
    required this.title,
    required this.date,
    required this.active,
  });

  final String title;
  final String date;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: active ? const Color(0xFFEFF6FF) : Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: active ? WavyonColors.primary : WavyonColors.line,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w900, color: WavyonColors.text),
                ),
                const SizedBox(height: 4),
                Text(
                  date,
                  style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w800, color: WavyonColors.muted),
                ),
              ],
            ),
          ),
          Text(
            active ? 'Applied' : 'Select',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w900,
              color: active ? WavyonColors.blue : WavyonColors.muted,
            ),
          ),
        ],
      ),
    );
  }
}

class _ProductHero extends StatelessWidget {
  const _ProductHero({required this.product});

  final ProductItem product;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 380,
      child: Stack(
        children: [
          const Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(color: Color(0xFFE2E8F0)),
              child: _MediaPlaceholder(height: 380, radius: 0, label: 'IMAGE'),
            ),
          ),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    WavyonColors.ink.withOpacity(0.28),
                    WavyonColors.ink.withOpacity(0.82),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: 20,
            right: 20,
            bottom: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BadgeChip(
                  label: product.badge,
                  background: product.badgeBackground,
                  foreground: product.badgeForeground,
                  border: product.badgeBackground,
                ),
                const SizedBox(height: 12),
                Text(
                  product.title,
                  style: const TextStyle(
                    fontSize: 24,
                    height: 1.15,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  '4.9 / 128 reviews',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFFE2E8F0),
                  ),
                ),
                const SizedBox(height: 14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    5,
                    (index) => Container(
                      width: index == 0 ? 20 : 8,
                      height: 8,
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        color: index == 0 ? Colors.white : Colors.white.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(999),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MediaPlaceholder extends StatelessWidget {
  const _MediaPlaceholder({
    required this.height,
    required this.radius,
    required this.label,
    this.topOnly = false,
  });

  final double height;
  final double radius;
  final String label;
  final bool topOnly;

  @override
  Widget build(BuildContext context) {
    final borderRadius = topOnly
        ? BorderRadius.only(
            topLeft: Radius.circular(radius),
            topRight: Radius.circular(radius),
          )
        : BorderRadius.circular(radius);

    return Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFE2E8F0),
        borderRadius: borderRadius,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.image_outlined, size: 30, color: WavyonColors.muted),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w900,
              letterSpacing: 2,
              color: WavyonColors.muted,
            ),
          ),
        ],
      ),
    );
  }
}

class _PriceWithUnit extends StatelessWidget {
  const _PriceWithUnit({required this.priceLabel});

  final String priceLabel;

  @override
  Widget build(BuildContext context) {
    final parts = priceLabel.split(' ');
    if (parts.length == 2) {
      return RichText(
        text: TextSpan(
          style: const TextStyle(color: WavyonColors.text),
          children: [
            TextSpan(
              text: parts.first,
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
            ),
            TextSpan(
              text: ' ${parts.last}',
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: WavyonColors.muted),
            ),
          ],
        ),
      );
    }

    return Text(
      priceLabel,
      style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w900, color: WavyonColors.text),
    );
  }
}

class _FeatureRow extends StatelessWidget {
  const _FeatureRow({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 22,
          height: 22,
          decoration: BoxDecoration(
            color: const Color(0xFFEFF6FF),
            borderRadius: BorderRadius.circular(999),
          ),
          child: const Icon(Icons.check_rounded, size: 14, color: WavyonColors.blue),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 13,
              height: 1.4,
              fontWeight: FontWeight.w700,
              color: WavyonColors.subtleText,
            ),
          ),
        ),
      ],
    );
  }
}

class _PointSummaryTile extends StatelessWidget {
  const _PointSummaryTile({
    required this.label,
    required this.value,
    this.dark = false,
  });

  final String label;
  final String value;
  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: dark ? WavyonGradients.dark : null,
        color: dark ? null : const Color(0xFFEFF6FF),
        borderRadius: BorderRadius.circular(30),
        border: dark ? null : Border.all(color: const Color(0xFFBFDBFE)),
        boxShadow: dark ? WavyonShadows.strong : WavyonShadows.card,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.w800,
              color: dark ? Colors.white.withOpacity(0.6) : WavyonColors.blue.withOpacity(0.6),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w900,
              color: dark ? Colors.white : WavyonColors.text,
            ),
          ),
        ],
      ),
    );
  }
}

class _PointsHistoryCard extends StatelessWidget {
  const _PointsHistoryCard({
    required this.title,
    required this.date,
    required this.delta,
    this.positive = false,
  });

  final String title;
  final String date;
  final String delta;
  final bool positive;

  @override
  Widget build(BuildContext context) {
    return WavyonCard(
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w900, color: WavyonColors.text)),
                const SizedBox(height: 4),
                Text(date, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: WavyonColors.muted)),
              ],
            ),
          ),
          Text(
            delta,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w900,
              color: positive ? WavyonColors.blue : WavyonColors.red,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatLabel extends StatelessWidget {
  const _StatLabel({
    required this.icon,
    required this.value,
    this.iconSize = 14,
    this.fontSize = 11,
  });

  final IconData icon;
  final String value;
  final double iconSize;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: iconSize, color: WavyonColors.muted),
        const SizedBox(width: 5),
        Text(
          value,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w900,
            color: WavyonColors.muted,
          ),
        ),
      ],
    );
  }
}

class _CommentLikePill extends StatelessWidget {
  const _CommentLikePill({required this.value});

  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.favorite_border_rounded, size: 12, color: WavyonColors.subtleText),
          const SizedBox(width: 6),
          Text(
            value,
            style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: WavyonColors.subtleText),
          ),
        ],
      ),
    );
  }
}

class _FilledIconButton extends StatelessWidget {
  const _FilledIconButton({
    required this.icon,
    this.ghost = false,
  });

  final IconData icon;
  final bool ghost;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: ghost ? const Color(0xFFF8FAFC) : WavyonColors.primary,
        borderRadius: BorderRadius.circular(18),
        border: ghost ? Border.all(color: WavyonColors.line) : null,
        boxShadow: ghost ? const [] : WavyonShadows.blue,
      ),
      child: Icon(
        icon,
        size: 18,
        color: ghost ? WavyonColors.subtleText : Colors.white,
      ),
    );
  }
}

class _PillToggle extends StatelessWidget {
  const _PillToggle({
    required this.label,
    required this.active,
  });

  final String label;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: active ? const Color(0xFFEFF6FF) : const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w900,
          color: active ? WavyonColors.blue : WavyonColors.muted,
        ),
      ),
    );
  }
}

class _PaginationDot extends StatelessWidget {
  const _PaginationDot({
    required this.label,
    required this.active,
  });

  final String label;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: active ? WavyonColors.primary : const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(999),
      ),
      alignment: Alignment.center,
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w900,
          color: active ? Colors.white : WavyonColors.subtleText,
        ),
      ),
    );
  }
}

class _SimpleSettingsRow extends StatelessWidget {
  const _SimpleSettingsRow({
    required this.label,
    this.danger = false,
  });

  final String label;
  final bool danger;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: danger ? WavyonColors.red : WavyonColors.subtleText,
          ),
        ),
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
              child: WavyonTextField(hint: '메시지를 입력하세요...'),
            ),
            const SizedBox(width: 10),
            const SizedBox(
              width: 92,
              child: WavyonButton(
                label: '전송',
                padding: EdgeInsets.symmetric(horizontal: 18, vertical: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WeatherLocationChip extends StatelessWidget {
  const _WeatherLocationChip();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.18),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(Icons.location_on_outlined, size: 14, color: Colors.white),
          SizedBox(width: 6),
          Text(
            'GPS 기반 현재 위치 · 서울특별시 성동구',
            style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: Colors.white),
          ),
        ],
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
