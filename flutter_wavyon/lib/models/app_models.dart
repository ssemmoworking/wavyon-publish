import 'package:flutter/material.dart';

enum MainTab { home, trip, community, chat, my }

enum AppRouteId {
  notifications,
  qrCenter,
  reservationDetail,
  newsDetail,
  communityDetail,
  tripCategory,
  tripProductDetail,
  tradeDetail,
  tradeChat,
  systemAlertDetail,
  myReservations,
  myTickets,
  paymentCenter,
  paymentDetail,
  pointsCoupons,
  support,
  settings,
  liveChatList,
  chatRoom,
  weather,
  tripBooking,
  tripBookingComplete,
  liveThreadCreate,
  communityBoardList,
  fandomWrite,
  tradeWrite,
  tradeEdit,
  freeBoard,
  fandomBoard,
}

class AppRoute {
  const AppRoute(this.id, {this.title, this.payload = const {}});

  final AppRouteId id;
  final String? title;
  final Map<String, Object?> payload;
}

typedef RouteHandler = void Function(AppRoute route);

class FavoriteItem {
  const FavoriteItem({
    required this.label,
    required this.symbol,
    required this.color,
  });

  final String label;
  final String symbol;
  final Color color;
}

class NewsItem {
  const NewsItem({
    required this.id,
    required this.title,
    required this.tag,
    required this.time,
    required this.body,
  });

  final String id;
  final String title;
  final String tag;
  final String time;
  final String body;
}

class ProductItem {
  const ProductItem({
    required this.id,
    required this.category,
    required this.title,
    required this.description,
    required this.price,
    required this.badge,
    required this.badgeColor,
    required this.location,
  });

  final String id;
  final String category;
  final String title;
  final String description;
  final String price;
  final String badge;
  final Color badgeColor;
  final String location;
}

class CommunityPost {
  const CommunityPost({
    required this.id,
    required this.title,
    required this.author,
    required this.meta,
    required this.tag,
  });

  final String id;
  final String title;
  final String author;
  final String meta;
  final String tag;
}

class ChatRoomItem {
  const ChatRoomItem({
    required this.id,
    required this.name,
    required this.body,
    required this.time,
    required this.unread,
    required this.driverStyle,
  });

  final String id;
  final String name;
  final String body;
  final String time;
  final int unread;
  final bool driverStyle;
}

class TradeItem {
  const TradeItem({
    required this.id,
    required this.title,
    required this.price,
    required this.status,
    required this.summary,
    required this.counterparty,
    this.unread = 0,
  });

  final String id;
  final String title;
  final String price;
  final String status;
  final String summary;
  final String counterparty;
  final int unread;
}

class NotificationItem {
  const NotificationItem({
    required this.id,
    required this.category,
    required this.title,
    required this.body,
    required this.time,
    this.read = false,
  });

  final String id;
  final String category;
  final String title;
  final String body;
  final String time;
  final bool read;
}

class MenuEntry {
  const MenuEntry({
    required this.label,
    required this.icon,
    required this.routeId,
    this.count,
  });

  final String label;
  final IconData icon;
  final AppRouteId routeId;
  final int? count;
}

class ReservationItem {
  const ReservationItem({
    required this.id,
    required this.title,
    required this.kind,
    required this.time,
    required this.location,
    required this.status,
  });

  final String id;
  final String title;
  final String kind;
  final String time;
  final String location;
  final String status;
}

class PaymentRecord {
  const PaymentRecord({
    required this.id,
    required this.title,
    required this.date,
    required this.amount,
  });

  final String id;
  final String title;
  final String date;
  final String amount;
}

class SupportItem {
  const SupportItem({
    required this.title,
    required this.body,
  });

  final String title;
  final String body;
}

class LiveThreadItem {
  const LiveThreadItem({
    required this.id,
    required this.title,
    required this.remain,
    required this.users,
    required this.hot,
  });

  final String id;
  final String title;
  final String remain;
  final int users;
  final bool hot;
}
