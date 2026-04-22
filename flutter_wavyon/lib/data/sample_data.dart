import 'package:flutter/material.dart';

import '../app/theme.dart';
import '../models/app_models.dart';

const homeFavorites = <FavoriteItem>[
  FavoriteItem(label: 'NCT 127', symbol: 'N', color: Color(0xFFD9F99D)),
  FavoriteItem(label: 'NewJeans', symbol: 'J', color: Color(0xFFBFDBFE)),
  FavoriteItem(label: 'Trade', symbol: 'T', color: Color(0xFFDBEAFE)),
  FavoriteItem(label: 'Concert', symbol: 'C', color: Color(0xFFE0E7FF)),
];

const homeNews = <NewsItem>[
  NewsItem(
    id: 'news-1',
    title: 'NCT 127 shuttle route expanded for the final event day',
    tag: 'HOT',
    time: '10 min',
    body: 'Updated pickup, entry, and guidance information for the final event experience.',
  ),
  NewsItem(
    id: 'news-2',
    title: 'NewJeans Seoul popup booking now open',
    tag: 'NEWS',
    time: '1 hr',
    body: 'Trip reservations and popup details are now available in the experience area.',
  ),
];

const tripProducts = <ProductItem>[
  ProductItem(
    id: 'trip-1',
    category: 'HOTSPOT',
    title: 'Seoul fan route day package',
    description: 'Popular route with city pickup and guided stops.',
    price: '125,000 KRW',
    badge: 'Best seller',
    badgeColor: WavyonColors.red,
    location: 'Seoul major spots',
  ),
  ProductItem(
    id: 'trip-2',
    category: 'HOTSPOT',
    title: 'Night walk and K-food tour',
    description: 'A lighter route focused on food and evening photo spots.',
    price: '89,000 KRW',
    badge: 'New',
    badgeColor: WavyonColors.blue,
    location: 'Euljiro',
  ),
  ProductItem(
    id: 'trip-3',
    category: 'FOOD',
    title: 'K-pop themed dinner course',
    description: 'Discounted dining package with fan-friendly menu options.',
    price: 'Pay on site',
    badge: '10% off',
    badgeColor: WavyonColors.amber,
    location: 'Hongdae',
  ),
  ProductItem(
    id: 'trip-4',
    category: 'POPUP',
    title: 'NCT 127 final popup store',
    description: 'Entry booking, merchandise area, and activity zone.',
    price: 'Free entry',
    badge: 'Reservation',
    badgeColor: WavyonColors.pink,
    location: 'Hyundai Seoul B1',
  ),
  ProductItem(
    id: 'trip-5',
    category: 'BEAUTY',
    title: 'K-beauty make up experience',
    description: 'One-on-one appointment with a guided styling flow.',
    price: '132,000 KRW',
    badge: '20% off',
    badgeColor: Color(0xFFDB2777),
    location: 'Cheongdam',
  ),
];

const communityPosts = <CommunityPost>[
  CommunityPost(
    id: 'post-1',
    title: 'Best arrival route for first-time concert visitors?',
    author: 'WavyUser_01',
    meta: '85 comments | 1.2k views',
    tag: 'Guide',
  ),
  CommunityPost(
    id: 'post-2',
    title: 'Seat view comparison for sections N and M',
    author: 'ViewMaster',
    meta: '32 comments | 860 views',
    tag: 'Info',
  ),
  CommunityPost(
    id: 'post-3',
    title: 'Looking for two-way merch trade before the show',
    author: 'TradeWave',
    meta: '14 comments | 210 views',
    tag: 'Trade',
  ),
];

const tradeItems = <TradeItem>[
  TradeItem(
    id: 'trade-1',
    title: 'NCT photocard set',
    price: '20,000 KRW',
    status: 'On sale',
    summary: 'Latest state: item is still available.',
    counterparty: 'Jay_Trade',
    unread: 2,
  ),
  TradeItem(
    id: 'trade-2',
    title: 'Seat transfer inquiry',
    price: '15,000 KRW',
    status: 'Reserved',
    summary: 'Latest state: reservation requested.',
    counterparty: 'SeatM_user',
    unread: 1,
  ),
  TradeItem(
    id: 'trade-3',
    title: 'Album package bundle',
    price: '40,000 KRW',
    status: 'Completed',
    summary: 'Latest state: transaction completed.',
    counterparty: 'MintBuyer',
  ),
];

const roomChats = <ChatRoomItem>[
  ChatRoomItem(
    id: 'room-1',
    name: 'Driver Park (Group Shuttle)',
    body: 'Pickup starts in about five minutes. Please check your location.',
    time: '2:05 PM',
    unread: 2,
    driverStyle: true,
  ),
  ChatRoomItem(
    id: 'room-2',
    name: 'NCT photocard trade',
    body: 'Is the exchange still available?',
    time: 'Yesterday',
    unread: 0,
    driverStyle: false,
  ),
];

const notifications = <NotificationItem>[
  NotificationItem(
    id: 'noti-1',
    category: 'Community',
    title: 'New reply on your post',
    body: 'A new comment was added to your recent community post.',
    time: '10 min',
  ),
  NotificationItem(
    id: 'noti-2',
    category: 'Payment',
    title: 'Payment completed',
    body: 'Your shuttle booking payment was completed successfully.',
    time: '1 hr',
  ),
  NotificationItem(
    id: 'noti-3',
    category: 'Trade',
    title: 'Trade status updated',
    body: 'Your trade thread status changed to Reserved.',
    time: '2 hr',
    read: true,
  ),
];

const systemAlerts = <NotificationItem>[
  NotificationItem(
    id: 'alert-1',
    category: 'System',
    title: 'Scheduled QR service maintenance',
    body: 'QR refresh APIs are scheduled for a short maintenance window tonight.',
    time: 'Now',
  ),
  NotificationItem(
    id: 'alert-2',
    category: 'Reservation',
    title: 'Automatic QR refresh policy',
    body: 'Each reservation keeps one active QR that refreshes automatically.',
    time: '1 hr',
    read: true,
  ),
];

const myMenuEntries = <MenuEntry>[
  MenuEntry(label: 'My reservations', icon: Icons.receipt_long_rounded, routeId: AppRouteId.myReservations, count: 2),
  MenuEntry(label: 'My tickets', icon: Icons.confirmation_num_rounded, routeId: AppRouteId.myTickets, count: 3),
  MenuEntry(label: 'Payments', icon: Icons.credit_card_rounded, routeId: AppRouteId.paymentCenter),
  MenuEntry(label: 'Points & coupons', icon: Icons.monetization_on_rounded, routeId: AppRouteId.pointsCoupons, count: 4),
  MenuEntry(label: 'Support', icon: Icons.support_agent_rounded, routeId: AppRouteId.support),
  MenuEntry(label: 'Settings', icon: Icons.settings_rounded, routeId: AppRouteId.settings),
];

const reservations = <ReservationItem>[
  ReservationItem(
    id: 'reservation-1',
    title: 'NCT 127 final shuttle',
    kind: 'Shuttle',
    time: 'Apr 22 | 3:00 PM',
    location: 'Incheon Airport',
    status: 'Booked',
  ),
  ReservationItem(
    id: 'reservation-2',
    title: 'NCT 127 popup store',
    kind: 'Popup',
    time: 'Apr 23 | 3:00 PM',
    location: 'The Hyundai Seoul',
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
    title: 'K-beauty booking',
    date: '2026.04.11 11:20',
    amount: '132,000 KRW',
  ),
];

const refundHistory = <PaymentRecord>[
  PaymentRecord(
    id: 'refund-1',
    title: 'Popup reservation cancelation',
    date: '2026.03.30 10:00',
    amount: '-12,000 KRW',
  ),
];

const transferHistory = <PaymentRecord>[
  PaymentRecord(
    id: 'transfer-1',
    title: 'Transfer request completed',
    date: '2026.03.21 09:50',
    amount: '1 case',
  ),
];

const supportItems = <SupportItem>[
  SupportItem(
    title: 'What if QR does not refresh?',
    body: 'Retry after restoring your connection, then contact support if the issue remains.',
  ),
  SupportItem(
    title: 'How are trade blocks handled?',
    body: 'Trade detail and moderation states should be visible in the draft implementation.',
  ),
  SupportItem(
    title: 'Where can I check refunds?',
    body: 'Use payment center to review payment, refund, and transfer history in one place.',
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
    title: 'Popup merch wait time updates',
    remain: '5h',
    users: 45,
    hot: false,
  ),
];
