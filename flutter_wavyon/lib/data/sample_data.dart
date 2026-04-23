import 'package:flutter/material.dart';

import '../app/theme.dart';
import '../models/app_models.dart';

const favoriteBoards = <String>['NCT 127', '자유게시판', 'Trade'];

const artistBoards = <String>[
  'NCT 127',
  'NewJeans',
  'Stray Kids',
  'IVE',
  'aespa',
  'RIIZE',
];

const infoBoards = <String>['Trade', '공연정보'];
const extraBoards = <String>['자유게시판', '실시간 뉴스'];

const homeFavorites = <FavoriteItem>[
  FavoriteItem(
    id: 'NCT 127',
    label: 'NCT 127',
    symbol: 'N',
    backgroundColor: Color(0xFFD9F99D),
    foregroundColor: Color(0xFF65A30D),
  ),
  FavoriteItem(
    id: 'NewJeans',
    label: 'NewJeans',
    symbol: 'J',
    backgroundColor: Color(0xFFBFDBFE),
    foregroundColor: Color(0xFF2563EB),
  ),
  FavoriteItem(
    id: 'Trade',
    label: 'Trade',
    symbol: 'T',
    backgroundColor: Color(0xFFDBEAFE),
    foregroundColor: Color(0xFF2563EB),
  ),
  FavoriteItem(
    id: 'Concert Info',
    label: 'Concert',
    symbol: 'C',
    backgroundColor: Color(0xFFE0E7FF),
    foregroundColor: Color(0xFF4F46E5),
  ),
];

const homeNews = <NewsItem>[
  NewsItem(
    id: 'news-1',
    title: 'NCT 127, 월드 투어 추가 공연 확정',
    tag: 'HOT',
    time: '10분 전',
    body: '추가 공연 일정과 셔틀 연동 동선, 팬 커뮤니티 실시간 스레드가 함께 업데이트되었습니다.',
  ),
  NewsItem(
    id: 'news-2',
    title: 'NewJeans, 글로벌 팝업 사전예약 오픈',
    tag: 'NEWS',
    time: '1시간 전',
    body: '팝업스토어 예약, 위치 안내, 예약 상세 정보가 Trip 영역과 바로 연결됩니다.',
  ),
];

const homePopularPosts = <RankingPost>[
  RankingPost(
    id: 'hot-post-1',
    rank: 1,
    title: '이번 셔틀 타시는 분들 현장 나눔 정보!',
  ),
  RankingPost(
    id: 'hot-post-2',
    rank: 2,
    title: '고척돔 시야 제한석 후기 (사진 유)',
  ),
];

const homeHotDeal = HotDealItem(
  title: 'K-Beauty 에스테틱 50% 특가',
  description: '빠른 액션 배너 톤과 CTA 밀도를 그대로 맞춘 홈 하단 핫딜 카드입니다.',
);

const tripProducts = <ProductItem>[
  ProductItem(
    id: 'trip-1',
    category: 'HOTSPOT',
    title: 'NCT 성지순례 투어 1박 2일',
    description: '검색량 245% 급상승',
    priceLabel: '125,000 KRW',
    badge: '급상승 1위',
    badgeBackground: Color(0xFFFEE2E2),
    badgeForeground: Color(0xFFDC2626),
    location: '서울 주요 팬 성지',
    imageLabel: 'IMAGE',
  ),
  ProductItem(
    id: 'trip-2',
    category: 'HOTSPOT',
    title: '서울 야경 크루즈 & K-Food 파티',
    description: '외국인 팬덤 예약 1위',
    priceLabel: '89,000 KRW',
    badge: '인기',
    badgeBackground: Color(0xFFDBEAFE),
    badgeForeground: Color(0xFF1D4ED8),
    location: '서울 도심',
    imageLabel: 'IMAGE',
  ),
  ProductItem(
    id: 'trip-3',
    category: 'FOOD',
    title: '홍대 K-POP 다이닝 포차',
    description: '팬덤 전용 10% 할인 세트 운영',
    priceLabel: '현장 결제',
    badge: '10% OFF',
    badgeBackground: Color(0xFFFFEDD5),
    badgeForeground: Color(0xFFEA580C),
    location: '홍대입구역 9번 출구',
    imageLabel: 'FOOD',
  ),
  ProductItem(
    id: 'trip-4',
    category: 'POPUP',
    title: 'NCT 127 \'WALK\' 팝업스토어',
    description: '예약, 굿즈존, 체험존을 한 번에 연결한 팝업 템플릿',
    priceLabel: '무료 입장',
    badge: '사전예약',
    badgeBackground: Color(0xFFF3E8FF),
    badgeForeground: Color(0xFF9333EA),
    location: 'The Hyundai Seoul B1',
    imageLabel: 'POPUP',
  ),
  ProductItem(
    id: 'trip-5',
    category: 'BEAUTY',
    title: '청담 메이크업 체험',
    description: '아티스트 스타일링 체험과 예약형 뷰티 코스',
    priceLabel: '132,000 KRW',
    badge: '20% OFF',
    badgeBackground: Color(0xFFFCE7F3),
    badgeForeground: Color(0xFFDB2777),
    location: '청담동 뷰티 스트리트',
    imageLabel: 'BEAUTY',
  ),
];

const communityPosts = <CommunityPost>[
  CommunityPost(
    id: 'community-1',
    tag: '자유',
    title: '내일 콘서트 끝나고 셔틀 타러 가는 길 안 복잡할까요?',
    author: 'WavyUser_01',
    time: '10분 전',
    likes: 24,
    comments: 8,
    stats: '조회 1.2k',
    excerpt:
        '현장 동선까지 같이 정리해주셔서 너무 도움됐어요.',
  ),
  CommunityPost(
    id: 'community-2',
    tag: '질문',
    title: '팝업스토어 대기열 지금 어떤가요?',
    author: '해찬맘',
    time: '15분 전',
    likes: 5,
    comments: 12,
    stats: '조회 201',
    excerpt:
        'Live Thread 열리면 같이 들어가서 실시간 정보 공유해요!',
  ),
  CommunityPost(
    id: 'community-3',
    tag: '정보',
    title: '고척돔 2층 N구역 시야 사진 공유합니다.',
    author: '엔시티즌',
    time: '30분 전',
    likes: 156,
    comments: 40,
    stats: '조회 533',
    excerpt:
        '예매/결제 링크도 같이 붙으면 더 좋을 것 같아요.',
  ),
  CommunityPost(
    id: 'community-4',
    tag: '자유',
    title: '이번 MD 진짜 예쁘게 잘 뽑은듯 ㅠㅠ',
    author: '마크광',
    time: '1시간 전',
    likes: 82,
    comments: 15,
    stats: '조회 122',
    excerpt:
        '셔틀 1호차 타시는 분들 같이 가요!',
  ),
  CommunityPost(
    id: 'community-5',
    tag: '자유',
    title: '셔틀 1호차 타시는 분들 같이 가요!',
    author: '팬더마우스',
    time: '2시간 전',
    likes: 14,
    comments: 3,
    excerpt:
        '현장 나눔 가능한 분들 있으면 댓글 남겨주세요.',
  ),
];

const tradeItems = <TradeItem>[
  TradeItem(
    id: 'trade-1',
    title: 'NCT 정우 포카 양도',
    priceLabel: '20,000원',
    statusKey: 'ON_SALE',
    lastStateText: '마지막 상태 · 판매중',
    thumbnailLabel: 'IMAGE',
    sellerNickname: 'WavySell_01',
    buyerNickname: 'Jay_Trade',
    unreadCount: 2,
  ),
  TradeItem(
    id: 'trade-2',
    title: '응원봉 대여 (직거래)',
    priceLabel: '15,000원',
    statusKey: 'RESERVED',
    lastStateText: '마지막 상태 · 예약자 확정',
    thumbnailLabel: 'IMAGE',
    sellerNickname: 'LampSeller',
    buyerNickname: 'SeatM_user',
    unreadCount: 1,
  ),
  TradeItem(
    id: 'trade-3',
    title: '미개봉 앨범 일괄',
    priceLabel: '40,000원',
    statusKey: 'COMPLETED',
    lastStateText: '마지막 상태 · 거래완료',
    thumbnailLabel: 'IMAGE',
    sellerNickname: 'AlbumLine',
    buyerNickname: 'MintBuyer',
  ),
  TradeItem(
    id: 'trade-4',
    title: '굿즈 세트 문의글',
    priceLabel: '-',
    statusKey: 'HIDDEN_REPORTED',
    lastStateText: '마지막 상태 · 신고로 숨김',
    thumbnailLabel: 'IMAGE',
    sellerNickname: 'HiddenSeller',
    buyerNickname: 'SafeUser',
  ),
  TradeItem(
    id: 'trade-5',
    title: 'Photocard swap proposal',
    priceLabel: '-',
    statusKey: 'HIDDEN_BLOCKED',
    lastStateText: 'Hidden because the seller was blocked.',
    thumbnailLabel: 'IMAGE',
    sellerNickname: 'BlockedUser',
    buyerNickname: 'MutedUser',
  ),
];

const roomChats = <ChatRoomItem>[
  ChatRoomItem(
    id: 'room-1',
    name: '기사: 박진우 (1호차)',
    body: '탑승객님, 출발 5분 전입니다. 도착 확인 부탁드립니다.',
    time: '오후 2:05',
    unread: 2,
    type: 'DRIVER',
    online: true,
  ),
  ChatRoomItem(
    id: 'room-2',
    name: 'NCT포카교환',
    body: '혹시 아직 교환 가능한가요?',
    time: '월요일',
    unread: 0,
    type: 'USER',
    online: false,
  ),
];

const notifications = <NotificationItem>[
  NotificationItem(
    id: 'noti-1',
    category: 'COMMUNITY',
    title: '새 댓글이 달렸어요',
    body: '내 게시글에 새로운 댓글이 추가되었습니다.',
    time: '10분 전',
  ),
  NotificationItem(
    id: 'noti-2',
    category: 'PAYMENT',
    title: '결제가 완료되었어요',
    body: '셔틀 예약 결제가 정상적으로 완료되었습니다.',
    time: '1시간 전',
  ),
  NotificationItem(
    id: 'noti-3',
    category: 'TRADE',
    title: 'Trade 상태가 변경되었어요',
    body: '거래 상대방이 완료 처리하여 읽기 전용으로 전환되었습니다.',
    time: '어제',
  ),
  NotificationItem(
    id: 'noti-4',
    category: 'RESERVATION',
    title: '예약 QR 자동 갱신 안내',
    body: '예약 1건당 QR 1개이며, QR은 10분 단위로 자동 갱신됩니다.',
    time: '1시간 전',
    read: true,
  ),
];

const systemAlerts = <NotificationItem>[
  NotificationItem(
    id: 'alert-1',
    category: 'SYSTEM',
    title: '서비스 점검 안내',
    body: '오늘 03:00부터 03:30까지 QR 재생성 API 점검이 예정되어 있습니다.',
    time: '방금',
  ),
  NotificationItem(
    id: 'alert-2',
    category: 'RESERVATION',
    title: '예약 QR 자동 갱신 안내',
    body: '예약 1건당 QR 1개이며, QR은 10분 단위로 자동 갱신됩니다.',
    time: '1시간 전',
    read: true,
  ),
  NotificationItem(
    id: 'alert-3',
    category: 'TRADE',
    title: 'Trade 채팅 상태 변경',
    body: '거래 상태가 완료 처리되어 입력창이 읽기 전용으로 전환되었습니다.',
    time: '어제',
    read: true,
  ),
];

const myAuthProviders = <AuthProviderItem>[
  AuthProviderItem(name: 'Kakao', state: '최근 사용', isActive: true),
  AuthProviderItem(name: 'Apple', state: '간편가입 가능', isActive: false),
  AuthProviderItem(name: 'Google', state: '간편가입 가능', isActive: false),
];

const myMenuEntries = <MenuEntry>[
  MenuEntry(
    label: '내 예약',
    icon: Icons.receipt_long_rounded,
    routeId: AppRouteId.myReservations,
    count: 2,
  ),
  MenuEntry(
    label: '내 티켓',
    icon: Icons.confirmation_num_rounded,
    routeId: AppRouteId.myTickets,
    count: 3,
  ),
  MenuEntry(
    label: '결제 / 환불 / 양도',
    icon: Icons.credit_card_rounded,
    routeId: AppRouteId.paymentCenter,
  ),
  MenuEntry(
    label: '포인트 / 쿠폰',
    icon: Icons.monetization_on_rounded,
    routeId: AppRouteId.pointsCoupons,
    count: 4,
  ),
  MenuEntry(
    label: '고객센터',
    icon: Icons.support_agent_rounded,
    routeId: AppRouteId.support,
  ),
  MenuEntry(
    label: '설정',
    icon: Icons.settings_rounded,
    routeId: AppRouteId.settings,
  ),
];

const mySignedIn = true;

const reservations = <ReservationItem>[
  ReservationItem(
    id: 'reservation-1',
    title: 'NCT 127 \'WALK\' 팝업',
    kind: '팝업스토어',
    time: '내일 15:00',
    location: '성수동',
    status: '예약확정',
  ),
  ReservationItem(
    id: 'reservation-2',
    title: '강남 스킨케어 패키지',
    kind: '뷰티',
    time: '05.20 11:00',
    location: '강남역',
    status: '예약확정',
  ),
  ReservationItem(
    id: 'reservation-3',
    title: 'NCT 127 고척돔 셔틀',
    kind: 'Ticket',
    time: '2026.04.22 14:00',
    location: '인천공항 T1 출국장 앞',
    status: 'QR',
  ),
  ReservationItem(
    id: 'reservation-4',
    title: 'NCT 127 \'WALK\' 팝업 입장',
    kind: 'Ticket',
    time: '2026.04.23 15:00',
    location: '더현대 서울 B1',
    status: 'QR',
  ),
  ReservationItem(
    id: 'reservation-5',
    title: '청담 메이크업 체험',
    kind: 'Ticket',
    time: '2026.04.11 11:20',
    location: '청담동 뷰티 스트리트',
    status: 'QR',
  ),
];

const paymentHistory = <PaymentRecord>[
  PaymentRecord(
    id: 'pay-1',
    title: 'NCT 127 셔틀 결제',
    date: '2026.04.18 14:30',
    amount: '42,000원',
  ),
  PaymentRecord(
    id: 'pay-2',
    title: '청담 메이크업 예약',
    date: '2026.04.11 11:20',
    amount: '132,000원',
  ),
];

const refundHistory = <PaymentRecord>[
  PaymentRecord(
    id: 'refund-1',
    title: '팝업 예약 취소 환불',
    date: '2026.03.30 10:00',
    amount: '-12,000원',
  ),
];

const transferHistory = <PaymentRecord>[
  PaymentRecord(
    id: 'transfer-1',
    title: '양도 거래 정산',
    date: '2026.03.21 09:50',
    amount: '1건',
  ),
];

const supportItems = <SupportItem>[
  SupportItem(
    title: 'QR이 갱신되지 않으면 어떻게 하나요?',
    body: '네트워크를 다시 확인한 뒤 재시도해 주세요. 문제가 지속되면 고객센터로 문의해 주세요.',
  ),
  SupportItem(
    title: 'Trade 신고나 차단은 어떻게 반영되나요?',
    body: '거래글 상태와 배지는 유지되며, 완료/신고/차단 상태에 따라 채팅방이 읽기 전용으로 전환됩니다.',
  ),
  SupportItem(
    title: '환불 내역은 어디서 확인하나요?',
    body: '결제 / 환불 / 양도 화면에서 내역을 한 번에 확인할 수 있습니다.',
  ),
];

const liveThreads = <LiveThreadItem>[
  LiveThreadItem(
    id: 'thread-1',
    title: 'NCT 127 팬덤 실시간 화력 집중!',
    remain: '22h',
    users: 1240,
    hot: true,
  ),
  LiveThreadItem(
    id: 'thread-2',
    title: '팝업 굿즈 대기열 실시간 공유',
    remain: '5h',
    users: 45,
    hot: false,
  ),
];

const defaultLanguages = <String>['ko', 'ja', 'en', 'zh'];

final communityBoardFeed = List<CommunityPost>.unmodifiable(communityPosts);
final freeBoardFeed = List<CommunityPost>.unmodifiable(communityPosts.reversed);
final liveNewsFeed = List<NewsItem>.unmodifiable(homeNews);
final hotspotTripProducts = tripProducts
    .where((item) => item.category == 'HOTSPOT')
    .toList(growable: false);
final foodTripProducts = tripProducts
    .where((item) => item.category == 'FOOD')
    .toList(growable: false);
final travelTripProducts = tripProducts
    .where((item) => item.category == 'POPUP' || item.category == 'BEAUTY')
    .toList(growable: false);

const activeBlueGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    WavyonColors.primary,
    WavyonColors.indigo,
    WavyonColors.violet,
  ],
);
