
export type MainTab = 'home' | 'trip' | 'community' | 'chat' | 'my';

export type RouteId =
  | 'notifications'
  | 'qr-center'
  | 'reservation-detail'
  | 'news-detail'
  | 'community-detail'
  | 'trip-category'
  | 'trip-product-detail'
  | 'trade-detail'
  | 'trade-chat'
  | 'system-alert-detail'
  | 'my-reservations'
  | 'my-tickets'
  | 'payment-center'
  | 'payment-detail'
  | 'points-coupons'
  | 'support'
  | 'settings'
  | 'live-chat-list'
  | 'chat-room'
  | 'weather'
  | 'trip-booking'
  | 'trip-booking-complete'
  | 'live-thread-create'
  | 'community-board-list';

export type RouteState = {
  id: RouteId;
  params?: Record<string, unknown>;
};

export type TradeStatus =
  | 'ON_SALE'
  | 'RESERVED'
  | 'COMPLETED'
  | 'HIDDEN_REPORTED'
  | 'HIDDEN_BLOCKED'
  | 'DELETED';

export type NotificationCategory =
  | 'SYSTEM'
  | 'PAYMENT'
  | 'TRADE'
  | 'COMMUNITY'
  | 'NOTICE'
  | 'RESERVATION';

export type QrDisplayState =
  | 'ACTIVE'
  | 'EXPIRED'
  | 'REGENERATING'
  | 'OFFLINE'
  | 'FAILURE';

export type ReservationStatus = 'BOOKED' | 'USED' | 'CANCELLED';

export type ChatTab = 'ROOMS' | 'TRADE' | 'SYSTEM';

export type CommunityDepthSelection = {
  depth1: string;
  depth2: string;
  depth3: string;
};

export type TradeItem = {
  id: string;
  title: string;
  priceLabel: string;
  status: TradeStatus;
  lastStateText: string;
  unreadCount?: number;
  thumbnailLabel: string;
  sellerNickname: string;
  buyerNickname: string;
};

export type NotificationItem = {
  id: string;
  category: NotificationCategory;
  title: string;
  body: string;
  time: string;
  read: boolean;
  targetRoute?: RouteId;
  targetParams?: Record<string, unknown>;
};

export type MenuItem = {
  id: string;
  label: string;
  count?: number;
  route?: RouteId;
};

export type Navigate = (id: RouteId, params?: Record<string, unknown>) => void;
