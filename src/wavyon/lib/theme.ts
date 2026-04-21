
import type { NotificationCategory, QrDisplayState, TradeStatus } from './types';

export const wavyonTheme = {
  primary: '#1e3a8a',
  secondary: '#dc2626',
  bg: '#f8fafc',
  gradients: {
    text: 'linear-gradient(90deg, #2563eb, #8b5cf6, #ec4899, #f59e0b)',
    banner1: 'linear-gradient(135deg, #1e3a8a 0%, #4338ca 50%, #9333ea 100%)',
    banner2: 'linear-gradient(135deg, #8b5cf6 0%, #ec4899 50%, #f43f5e 100%)',
    banner3: 'linear-gradient(135deg, #06b6d4 0%, #3b82f6 50%, #8b5cf6 100%)',
    banner4: 'linear-gradient(135deg, #db2777 0%, #ea580c 100%)',
    dark: 'linear-gradient(135deg, #0f172a 0%, #1e1b4b 100%)',
  },
} as const;

export const tradeStatusLabel: Record<TradeStatus, string> = {
  ON_SALE: '판매중',
  RESERVED: '예약중',
  COMPLETED: '거래완료',
  HIDDEN_REPORTED: '신고 숨김',
  HIDDEN_BLOCKED: '차단 숨김',
  DELETED: '삭제됨',
};

export const tradeStatusClass: Record<TradeStatus, string> = {
  ON_SALE: 'bg-green-50 text-green-600 border border-green-100',
  RESERVED: 'bg-orange-50 text-orange-600 border border-orange-100',
  COMPLETED: 'bg-slate-100 text-slate-500 border border-slate-200',
  HIDDEN_REPORTED: 'bg-red-50 text-red-600 border border-red-100',
  HIDDEN_BLOCKED: 'bg-slate-200 text-slate-600 border border-slate-300',
  DELETED: 'bg-slate-100 text-slate-400 border border-slate-200',
};

export const notificationCategoryClass: Record<NotificationCategory, string> = {
  SYSTEM: 'bg-red-50 text-red-600 border border-red-100',
  PAYMENT: 'bg-green-50 text-green-600 border border-green-100',
  TRADE: 'bg-blue-50 text-blue-700 border border-blue-100',
  COMMUNITY: 'bg-indigo-50 text-indigo-700 border border-indigo-100',
  NOTICE: 'bg-purple-50 text-purple-700 border border-purple-100',
  RESERVATION: 'bg-orange-50 text-orange-600 border border-orange-100',
};

export const qrStateLabel: Record<QrDisplayState, string> = {
  ACTIVE: '사용 가능',
  EXPIRED: '만료됨',
  REGENERATING: '재생성 중',
  OFFLINE: '오프라인',
  FAILURE: '생성 실패',
};

export const qrStateClass: Record<QrDisplayState, string> = {
  ACTIVE: 'bg-blue-50 text-blue-700 border border-blue-100',
  EXPIRED: 'bg-red-50 text-red-600 border border-red-100',
  REGENERATING: 'bg-purple-50 text-purple-700 border border-purple-100',
  OFFLINE: 'bg-orange-50 text-orange-600 border border-orange-100',
  FAILURE: 'bg-slate-100 text-slate-600 border border-slate-200',
};

export const cx = (...classes: Array<string | false | null | undefined>) =>
  classes.filter(Boolean).join(' ');
