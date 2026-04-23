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
    required this.id,
    required this.label,
    required this.symbol,
    required this.backgroundColor,
    required this.foregroundColor,
  });

  final String id;
  final String label;
  final String symbol;
  final Color backgroundColor;
  final Color foregroundColor;
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

class RankingPost {
  const RankingPost({
    required this.id,
    required this.rank,
    required this.title,
  });

  final String id;
  final int rank;
  final String title;
}

class ProductItem {
  const ProductItem({
    required this.id,
    required this.category,
    required this.title,
    required this.description,
    required this.priceLabel,
    required this.badge,
    required this.badgeBackground,
    required this.badgeForeground,
    required this.location,
    required this.imageLabel,
  });

  final String id;
  final String category;
  final String title;
  final String description;
  final String priceLabel;
  final String badge;
  final Color badgeBackground;
  final Color badgeForeground;
  final String location;
  final String imageLabel;
}

class CommunityPost {
  const CommunityPost({
    required this.id,
    required this.tag,
    required this.title,
    required this.author,
    required this.time,
    required this.likes,
    required this.comments,
    this.stats,
    this.excerpt,
  });

  final String id;
  final String tag;
  final String title;
  final String author;
  final String time;
  final int likes;
  final int comments;
  final String? stats;
  final String? excerpt;
}

class ChatRoomItem {
  const ChatRoomItem({
    required this.id,
    required this.name,
    required this.body,
    required this.time,
    required this.unread,
    required this.type,
    required this.online,
  });

  final String id;
  final String name;
  final String body;
  final String time;
  final int unread;
  final String type;
  final bool online;
}

class TradeItem {
  const TradeItem({
    required this.id,
    required this.title,
    required this.priceLabel,
    required this.statusKey,
    required this.lastStateText,
    required this.thumbnailLabel,
    required this.sellerNickname,
    required this.buyerNickname,
    this.unreadCount = 0,
  });

  final String id;
  final String title;
  final String priceLabel;
  final String statusKey;
  final String lastStateText;
  final String thumbnailLabel;
  final String sellerNickname;
  final String buyerNickname;
  final int unreadCount;
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

class AuthProviderItem {
  const AuthProviderItem({
    required this.name,
    required this.state,
    required this.isActive,
  });

  final String name;
  final String state;
  final bool isActive;
}

class HotDealItem {
  const HotDealItem({
    required this.title,
    required this.description,
  });

  final String title;
  final String description;
}
