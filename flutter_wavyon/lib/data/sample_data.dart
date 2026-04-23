import 'package:flutter/material.dart';

import '../app/theme.dart';
import '../models/app_models.dart';

const favoriteBoards = <String>['NCT 127', 'Free Board', 'Trade'];

const artistBoards = <String>[
  'NCT 127',
  'NewJeans',
  'Stray Kids',
  'IVE',
  'aespa',
  'RIIZE',
];

const infoBoards = <String>['Trade', 'Concert Info'];
const extraBoards = <String>['Free Board', 'Live News'];

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
    title: 'NCT 127 added extra shuttle runs for the final concert weekend',
    tag: 'HOT',
    time: '10 min',
    body:
        'Pickup slots, final entry routing, and live crowd notes were updated together for the event day flow.',
  ),
  NewsItem(
    id: 'news-2',
    title: 'NewJeans Seoul popup reservation flow is now open in the trip section',
    tag: 'NEWS',
    time: '1 hr',
    body:
        'Popup booking, location guidance, and reservation details are now linked from the trip experience area.',
  ),
];

const homePopularPosts = <RankingPost>[
  RankingPost(
    id: 'hot-post-1',
    rank: 1,
    title: 'Who is sharing arrival gate updates for the final show today?',
  ),
  RankingPost(
    id: 'hot-post-2',
    rank: 2,
    title: 'Section view photos and merch queue tips are being updated here',
  ),
];

const homeHotDeal = HotDealItem(
  title: 'K-beauty styling package connected to the fan-trip route',
  description: 'The quick action is meant to feel like the React hot deal banner.',
);

const tripProducts = <ProductItem>[
  ProductItem(
    id: 'trip-1',
    category: 'HOTSPOT',
    title: 'NCT fan route day pass with shuttle pickup',
    description: 'Fastest-growing route this week with guided pickup and event stopovers.',
    priceLabel: '125,000 KRW',
    badge: 'Hot #1',
    badgeBackground: Color(0xFFFEE2E2),
    badgeForeground: Color(0xFFDC2626),
    location: 'Major Seoul fan spots',
    imageLabel: 'IMAGE',
  ),
  ProductItem(
    id: 'trip-2',
    category: 'HOTSPOT',
    title: 'Seoul night walk and K-food fan route',
    description: 'Evening course built around quick fan meetups and photo spots.',
    priceLabel: '89,000 KRW',
    badge: 'Popular',
    badgeBackground: Color(0xFFDBEAFE),
    badgeForeground: Color(0xFF1D4ED8),
    location: 'Euljiro',
    imageLabel: 'IMAGE',
  ),
  ProductItem(
    id: 'trip-3',
    category: 'FOOD',
    title: 'K-pop themed dinner course',
    description: 'Fan-friendly dining route with a 10% discount and easy booking.',
    priceLabel: 'Pay on site',
    badge: '10% OFF',
    badgeBackground: Color(0xFFFFEDD5),
    badgeForeground: Color(0xFFEA580C),
    location: 'Hongdae',
    imageLabel: 'FOOD',
  ),
  ProductItem(
    id: 'trip-4',
    category: 'POPUP',
    title: 'NCT 127 WALK popup store pass',
    description: 'Reservation, merchandise area, and activity zone in one flow.',
    priceLabel: 'Free entry',
    badge: 'Reservation',
    badgeBackground: Color(0xFFF3E8FF),
    badgeForeground: Color(0xFF9333EA),
    location: 'The Hyundai Seoul B1',
    imageLabel: 'POPUP',
  ),
  ProductItem(
    id: 'trip-5',
    category: 'BEAUTY',
    title: 'Cheongdam idol-style makeup session',
    description: 'One-on-one booking with a stylist-guided beauty flow.',
    priceLabel: '132,000 KRW',
    badge: '20% OFF',
    badgeBackground: Color(0xFFFCE7F3),
    badgeForeground: Color(0xFFDB2777),
    location: 'Cheongdam beauty street',
    imageLabel: 'BEAUTY',
  ),
];

const communityPosts = <CommunityPost>[
  CommunityPost(
    id: 'community-1',
    tag: 'Guide',
    title: 'Best arrival route for first-time concert visitors?',
    author: 'WavyUser_01',
    time: '10 min',
    likes: 24,
    comments: 8,
    stats: '85 comments | 1.2k views',
    excerpt:
        'Collected the quickest gate entry flow, merch line timing, and meetup spots from today\'s visitors.',
  ),
  CommunityPost(
    id: 'community-2',
    tag: 'Info',
    title: 'Section N and M seat-view comparison with updated photos',
    author: 'ViewMaster',
    time: '30 min',
    likes: 156,
    comments: 40,
    stats: '32 comments | 860 views',
    excerpt:
        'Includes close-up view references, how much the stage feels offset, and merch queue visibility.',
  ),
  CommunityPost(
    id: 'community-3',
    tag: 'Free',
    title: 'Anyone heading in from Terminal 1 and sharing a taxi?',
    author: 'SeoulMeetup',
    time: '1 hr',
    likes: 82,
    comments: 15,
    stats: '14 comments | 210 views',
    excerpt:
        'A lightweight meetup thread for fans planning to move from the airport together before the event.',
  ),
  CommunityPost(
    id: 'community-4',
    tag: 'Question',
    title: 'How early should I reach the popup if my slot is 3 PM?',
    author: 'PopupGuide',
    time: '2 hr',
    likes: 14,
    comments: 3,
    excerpt:
        'Trying to estimate queue time, merch stock timing, and the best order to move through the space.',
  ),
];

const tradeItems = <TradeItem>[
  TradeItem(
    id: 'trade-1',
    title: 'NCT photocard transfer set',
    priceLabel: '20,000 KRW',
    statusKey: 'ON_SALE',
    lastStateText: 'Latest status: still available for direct meetup trade.',
    thumbnailLabel: 'IMAGE',
    sellerNickname: 'WavySell_01',
    buyerNickname: 'Jay_Trade',
    unreadCount: 2,
  ),
  TradeItem(
    id: 'trade-2',
    title: 'Seat transfer inquiry before the concert',
    priceLabel: '15,000 KRW',
    statusKey: 'RESERVED',
    lastStateText: 'Latest status: reservation request confirmed.',
    thumbnailLabel: 'IMAGE',
    sellerNickname: 'LampSeller',
    buyerNickname: 'SeatM_user',
    unreadCount: 1,
  ),
  TradeItem(
    id: 'trade-3',
    title: 'Unopened album bundle',
    priceLabel: '40,000 KRW',
    statusKey: 'COMPLETED',
    lastStateText: 'Latest status: transaction completed successfully.',
    thumbnailLabel: 'IMAGE',
    sellerNickname: 'AlbumLine',
    buyerNickname: 'MintBuyer',
  ),
  TradeItem(
    id: 'trade-4',
    title: 'Question about merch pickup slot exchange',
    priceLabel: '-',
    statusKey: 'HIDDEN_REPORTED',
    lastStateText: 'Hidden after a report review.',
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
    name: 'Driver Park (Final shuttle)',
    body: 'Pickup starts in about five minutes. Please check your current location.',
    time: '2:05 PM',
    unread: 2,
    type: 'DRIVER',
    online: true,
  ),
  ChatRoomItem(
    id: 'room-2',
    name: 'NCT photocard trade',
    body: 'Is the exchange still available before the show?',
    time: 'Yesterday',
    unread: 0,
    type: 'USER',
    online: false,
  ),
];

const notifications = <NotificationItem>[
  NotificationItem(
    id: 'noti-1',
    category: 'COMMUNITY',
    title: 'New reply on your post',
    body: 'A new comment was added to your community thread.',
    time: '10 min',
  ),
  NotificationItem(
    id: 'noti-2',
    category: 'PAYMENT',
    title: 'Payment completed',
    body: 'Your shuttle booking payment was completed successfully.',
    time: '1 hr',
  ),
  NotificationItem(
    id: 'noti-3',
    category: 'TRADE',
    title: 'Trade status updated',
    body: 'Your trade thread moved to the reserved state.',
    time: '2 hr',
  ),
  NotificationItem(
    id: 'noti-4',
    category: 'NOTICE',
    title: 'Community categories updated',
    body: 'The board structure now uses the 3-depth organization from the React draft.',
    time: 'Yesterday',
    read: true,
  ),
];

const systemAlerts = <NotificationItem>[
  NotificationItem(
    id: 'alert-1',
    category: 'SYSTEM',
    title: 'Short QR maintenance window',
    body: 'QR refresh APIs are scheduled for a short maintenance window tonight.',
    time: 'Now',
  ),
  NotificationItem(
    id: 'alert-2',
    category: 'RESERVATION',
    title: 'Automatic QR refresh policy',
    body: 'Each reservation keeps one active QR and refreshes automatically every 10 minutes.',
    time: '1 hr',
    read: true,
  ),
  NotificationItem(
    id: 'alert-3',
    category: 'TRADE',
    title: 'Trade chat changed to read-only',
    body: 'The transaction finished, so the input field was disabled for the room.',
    time: 'Yesterday',
    read: true,
  ),
];

const myAuthProviders = <AuthProviderItem>[
  AuthProviderItem(name: 'Kakao', state: 'Recently used', isActive: true),
  AuthProviderItem(name: 'Apple', state: 'Available', isActive: false),
  AuthProviderItem(name: 'Google', state: 'Available', isActive: false),
];

const myMenuEntries = <MenuEntry>[
  MenuEntry(
    label: 'My reservations',
    icon: Icons.receipt_long_rounded,
    routeId: AppRouteId.myReservations,
    count: 2,
  ),
  MenuEntry(
    label: 'My tickets',
    icon: Icons.confirmation_num_rounded,
    routeId: AppRouteId.myTickets,
    count: 3,
  ),
  MenuEntry(
    label: 'Payments / Refunds / Transfers',
    icon: Icons.credit_card_rounded,
    routeId: AppRouteId.paymentCenter,
  ),
  MenuEntry(
    label: 'Points & coupons',
    icon: Icons.monetization_on_rounded,
    routeId: AppRouteId.pointsCoupons,
    count: 4,
  ),
  MenuEntry(
    label: 'Support',
    icon: Icons.support_agent_rounded,
    routeId: AppRouteId.support,
  ),
  MenuEntry(
    label: 'Settings',
    icon: Icons.settings_rounded,
    routeId: AppRouteId.settings,
  ),
];

const reservations = <ReservationItem>[
  ReservationItem(
    id: 'reservation-1',
    title: 'NCT 127 final shuttle',
    kind: 'Shuttle',
    time: 'Apr 22 | 3:00 PM',
    location: 'Incheon Airport T1',
    status: 'Booked',
  ),
  ReservationItem(
    id: 'reservation-2',
    title: 'NCT 127 popup store entry',
    kind: 'Popup',
    time: 'Apr 23 | 3:00 PM',
    location: 'The Hyundai Seoul B1',
    status: 'Booked',
  ),
];

const paymentHistory = <PaymentRecord>[
  PaymentRecord(
    id: 'pay-1',
    title: 'NCT 127 shuttle booking',
    date: '2026.04.18 14:30',
    amount: '42,000 KRW',
  ),
  PaymentRecord(
    id: 'pay-2',
    title: 'Cheongdam makeup reservation',
    date: '2026.04.11 11:20',
    amount: '132,000 KRW',
  ),
];

const refundHistory = <PaymentRecord>[
  PaymentRecord(
    id: 'refund-1',
    title: 'Popup reservation cancellation',
    date: '2026.03.30 10:00',
    amount: '-12,000 KRW',
  ),
];

const transferHistory = <PaymentRecord>[
  PaymentRecord(
    id: 'transfer-1',
    title: 'Ticket transfer completed',
    date: '2026.03.21 09:50',
    amount: '1 case',
  ),
];

const supportItems = <SupportItem>[
  SupportItem(
    title: 'What if the QR does not refresh?',
    body:
        'Retry after restoring your connection, then contact support if the issue remains in the failure state.',
  ),
  SupportItem(
    title: 'How are trade reports and blocks handled?',
    body:
        'Trade detail and moderation states should remain visible in the UI even after the conversation becomes read-only.',
  ),
  SupportItem(
    title: 'Where can I check refunds?',
    body:
        'Use the payment center to review payment, refund, and transfer history in one place.',
  ),
];

const liveThreads = <LiveThreadItem>[
  LiveThreadItem(
    id: 'thread-1',
    title: 'Section view updates and queue sharing',
    remain: '22h',
    users: 1240,
    hot: true,
  ),
  LiveThreadItem(
    id: 'thread-2',
    title: 'Popup merch wait-time updates',
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
