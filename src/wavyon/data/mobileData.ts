
import type {
  CommunityDepthSelection,
  MenuItem,
  NotificationItem,
  QrDisplayState,
  ReservationStatus,
  TradeItem,
} from '../lib/types';

export const favoriteBoards = ['NCT 127', '자유게시판', 'Trade'];

export const homeFavorites = [
  { id: 'NCT 127', symbol: '💚', className: 'bg-lime-100 text-lime-600' },
  { id: 'NewJeans', symbol: '👖', className: 'bg-blue-100 text-blue-600' },
  { id: 'Trade', symbol: '🔄', className: 'bg-blue-50 text-blue-600' },
  { id: '공연정보', symbol: '🎫', className: 'bg-indigo-100 text-indigo-600' },
];

export const homeNews = [
  {
    id: 'news-1',
    title: 'NCT 127, 월드 투어 추가 공연 확정',
    tag: 'HOT',
    time: '10분 전',
    body:
      '추가 공연 일정 공개와 함께 셔틀·현장 동선 안내 페이지 연결이 필요합니다.',
  },
  {
    id: 'news-2',
    title: 'NewJeans, 글로벌 팝업 사전예약 오픈',
    tag: 'NEWS',
    time: '1시간 전',
    body: 'Trip 영역의 팝업 상세와 예약 흐름으로 연결됩니다.',
  },
];

export const homePopularPosts = [
  {
    id: 'post-hot-1',
    rank: 1,
    title: '이번 셔틀 타시는 분들 현장 나눔 정보!',
  },
  {
    id: 'post-hot-2',
    rank: 2,
    title: '고척돔 시야 제한석 후기 (사진 유)',
  },
];

export const homeHotDeal = {
  title: 'K-Beauty 에스테틱 50% 특가',
  description: 'Trip > K-뷰티 상세에서 같은 카드 규격으로 연결',
};

export const tripReservations = [
  {
    id: 'reservation-1',
    type: '팝업스토어',
    title: "NCT 127 'WALK' 팝업",
    time: '내일 15:00',
    location: '성수동',
    status: 'BOOKED' as ReservationStatus,
  },
  {
    id: 'reservation-2',
    type: 'K-Beauty',
    title: '강남 스킨케어 패키지',
    time: '05.20 11:00',
    location: '강남역',
    status: 'BOOKED' as ReservationStatus,
  },
];

export const tripProductCategories = [
  {
    id: 'HOTSPOT',
    title: 'HOTSPOT',
    helper: '실시간 트렌드 반영',
  },
  {
    id: 'FOOD',
    title: '제휴 맛집',
    helper: '공통 상품 템플릿',
  },
  {
    id: 'POPUP',
    title: '팝업스토어',
    helper: '공통 상품 템플릿',
  },
  {
    id: 'BEAUTY',
    title: 'K-뷰티',
    helper: '공통 상품 템플릿',
  },
];

export const tripProducts = [
  {
    id: 'trip-1',
    category: 'HOTSPOT',
    title: 'NCT 성지순례 투어 1박 2일',
    description: '검색량 245% 급상승',
    badge: '급상승 1위',
    badgeClass: 'bg-red-50 text-red-600',
    priceLabel: '125,000 KRW',
    location: '서울 주요 성지',
    imageLabel: 'IMAGE',
  },
  {
    id: 'trip-2',
    category: 'HOTSPOT',
    title: '서울 야경 크루즈 & K-Food 파티',
    description: '외국인 팬덤 예약 1위',
    badge: '인기',
    badgeClass: 'bg-blue-50 text-blue-700',
    priceLabel: '89,000 KRW',
    location: '여의도 선착장',
    imageLabel: 'IMAGE',
  },
  {
    id: 'trip-3',
    category: 'FOOD',
    title: '홍대 K-POP 다이닝 포차',
    description: '팬덤 전용 10% 할인 세트 운영',
    badge: '10% 할인',
    badgeClass: 'bg-orange-50 text-orange-600',
    priceLabel: '현장 결제',
    location: '홍대입구역 9번 출구',
    imageLabel: 'FOOD',
  },
  {
    id: 'trip-4',
    category: 'POPUP',
    title: "NCT 127 'WALK' 팝업스토어",
    description: '단독 굿즈 판매 및 인터랙티브 포토존 운영',
    badge: '사전예약',
    badgeClass: 'bg-purple-50 text-purple-600',
    priceLabel: '무료 입장',
    location: '더현대 서울 B1',
    imageLabel: 'POPUP',
  },
  {
    id: 'trip-5',
    category: 'BEAUTY',
    title: '청담 아이돌 메이크업 체험',
    description: '실제 담당 원장 1:1 예약',
    badge: '20% 할인',
    badgeClass: 'bg-pink-50 text-pink-600',
    priceLabel: '132,000 KRW',
    location: '청담동 뷰티 스트리트',
    imageLabel: 'BEAUTY',
  },
];

export const emptyTripReservations = [];

export const communityInitialSelection: CommunityDepthSelection = {
  depth1: 'NCT 127',
  depth2: '전체',
  depth3: '전체',
};

export const communityDepthMap: Record<string, Record<string, string[]>> = {
  즐겨찾기: {
    고정: ['전체'],
  },
  자유게시판: {
    전체: ['전체'],
  },
  'NCT 127': {
    전체: ['전체', 'Live Thread'],
    응원: ['전체'],
    후기: ['현장', '시야'],
  },
  '정보 및 교환': {
    Trade: ['전체', '판매중', '예약중', '완료'],
    공연정보: ['전체', '셔틀', '공지'],
  },
};

export const communityPosts = [
  {
    id: 'community-1',
    title: '이번 셔틀 타시는 분들 현장 나눔 정보!',
    author: 'Wavy_Fan_01',
    stats: '댓글 85 · 조회 1.2k',
    excerpt:
      '셔틀 1호차 탑승자 기준으로 현장 나눔 가능합니다. 댓글로 시간 맞춰요.',
  },
  {
    id: 'community-2',
    title: '고척돔 시야제한석 후기 모음',
    author: 'Wavy_View_77',
    stats: '댓글 32 · 조회 860',
    excerpt:
      'N구역 / M구역 사진 포함. 돌출 기준 체감과 응원봉 시야까지 정리했습니다.',
  },
];

export const liveThreads = [
  {
    id: 'thread-1',
    title: '고척돔 시야제한석 정보 공유',
    remain: '22h',
    users: 1240,
    hot: true,
  },
  {
    id: 'thread-2',
    title: '오늘 팝업 굿즈 대리구매 구해요',
    remain: '5h',
    users: 45,
    hot: false,
  },
];

export const tradeItems: TradeItem[] = [
  {
    id: 'trade-1',
    title: 'NCT 정우 포카 양도',
    priceLabel: '20,000원',
    status: 'ON_SALE',
    lastStateText: '마지막 상태 · 판매중',
    unreadCount: 2,
    thumbnailLabel: 'IMAGE',
    sellerNickname: 'WavySell_01',
    buyerNickname: 'Jay_Trade',
  },
  {
    id: 'trade-2',
    title: '응원봉 대여 (직거래)',
    priceLabel: '15,000원',
    status: 'RESERVED',
    lastStateText: '마지막 상태 · 예약자 확정',
    unreadCount: 1,
    thumbnailLabel: 'IMAGE',
    sellerNickname: 'LampSeller',
    buyerNickname: 'SeatM_user',
  },
  {
    id: 'trade-3',
    title: '미개봉 앨범 일괄',
    priceLabel: '40,000원',
    status: 'COMPLETED',
    lastStateText: '마지막 상태 · 거래완료',
    thumbnailLabel: 'IMAGE',
    sellerNickname: 'AlbumLine',
    buyerNickname: 'MintBuyer',
  },
  {
    id: 'trade-4',
    title: '굿즈 세트 문의글',
    priceLabel: '-',
    status: 'HIDDEN_REPORTED',
    lastStateText: '마지막 상태 · 신고로 숨김',
    thumbnailLabel: 'IMAGE',
    sellerNickname: 'HiddenSeller',
    buyerNickname: 'SafeUser',
  },
  {
    id: 'trade-5',
    title: '포카 교환 제안',
    priceLabel: '-',
    status: 'HIDDEN_BLOCKED',
    lastStateText: '마지막 상태 · 차단으로 숨김',
    thumbnailLabel: 'IMAGE',
    sellerNickname: 'BlockedUser',
    buyerNickname: 'MutedUser',
  },
  {
    id: 'trade-6',
    title: '현장 구매 대행',
    priceLabel: '-',
    status: 'DELETED',
    lastStateText: '마지막 상태 · 삭제됨',
    thumbnailLabel: 'IMAGE',
    sellerNickname: 'DeletedSeller',
    buyerNickname: 'Viewer',
  },
];

export const tradeChatMessages = [
  {
    id: 'msg-system-1',
    kind: 'system' as const,
    text: '기존 대화는 읽을 수 있습니다. 거래 상태가 변경되면 입력창 정책이 즉시 반영됩니다.',
  },
  {
    id: 'msg-1',
    kind: 'other' as const,
    sender: 'Jay_Trade',
    time: '14:02',
    text: '혹시 아직 거래 가능할까요?',
  },
  {
    id: 'msg-2',
    kind: 'me' as const,
    sender: '나',
    time: '14:04',
    text: '네, 현재 판매중입니다. 공연장 2번 게이트 앞 직거래 가능해요.',
  },
  {
    id: 'msg-3',
    kind: 'other' as const,
    sender: 'Jay_Trade',
    time: '14:07',
    text: '좋아요. 우선 예약 부탁드릴게요.',
  },
];

export const tradeReadonlyMessages = [
  {
    id: 'msg-system-2',
    kind: 'system' as const,
    text: '거래가 완료되어 입력이 비활성화되었습니다. 기존 대화는 계속 확인할 수 있습니다.',
  },
  {
    id: 'msg-4',
    kind: 'other' as const,
    sender: 'MintBuyer',
    time: '09:11',
    text: '입금 확인했습니다. 감사합니다!',
  },
  {
    id: 'msg-5',
    kind: 'me' as const,
    sender: '나',
    time: '09:12',
    text: '안전 거래 완료 처리했어요. 좋은 관람 되세요.',
  },
];

export const roomChats = [
  {
    id: 'room-1',
    name: '기사: 박진우 (1호차)',
    body: '탑승객님, 출발 5분 전입니다. 도착 확인 부탁드립니다.',
    time: '오후 2:05',
    unread: 2,
    type: 'DRIVER',
    online: true,
  },
  {
    id: 'room-2',
    name: 'NCT포카교환',
    body: '혹시 아직 교환 가능할까요?',
    time: '월요일',
    unread: 0,
    type: 'USER',
    online: false,
  },
];

export const systemAlerts: NotificationItem[] = [
  {
    id: 'alert-1',
    category: 'SYSTEM',
    title: '서비스 점검 안내',
    body: '오늘 03:00부터 03:30까지 QR 재생성 API 점검이 예정되어 있습니다.',
    time: '방금',
    read: false,
    targetRoute: 'system-alert-detail',
    targetParams: { id: 'alert-1' },
  },
  {
    id: 'alert-2',
    category: 'RESERVATION',
    title: '예약 QR 자동 갱신 안내',
    body: '예약 1건당 QR 1개이며, QR은 10분 단위로 자동 갱신됩니다.',
    time: '1시간 전',
    read: true,
    targetRoute: 'system-alert-detail',
    targetParams: { id: 'alert-2' },
  },
  {
    id: 'alert-3',
    category: 'TRADE',
    title: 'Trade 채팅 상태 변경',
    body: '거래 상태가 완료 처리되어 입력창이 읽기 전용으로 전환되었습니다.',
    time: '어제',
    read: true,
    targetRoute: 'system-alert-detail',
    targetParams: { id: 'alert-3' },
  },
];

export const notifications: NotificationItem[] = [
  {
    id: 'noti-1',
    category: 'COMMUNITY',
    title: '새로운 댓글',
    body: '내 게시글에 새 댓글이 달렸습니다.',
    time: '10분 전',
    read: false,
    targetRoute: 'community-detail',
    targetParams: { id: 'community-1' },
  },
  {
    id: 'noti-2',
    category: 'PAYMENT',
    title: '결제 완료',
    body: 'NCT 127 고척돔 셔틀 결제가 성공적으로 완료되었습니다.',
    time: '1시간 전',
    read: false,
    targetRoute: 'reservation-detail',
    targetParams: { id: 'reservation-1' },
  },
  {
    id: 'noti-3',
    category: 'TRADE',
    title: 'Trade 예약 상태 변경',
    body: '응원봉 대여 글이 RESERVED 상태로 변경되었습니다.',
    time: '2시간 전',
    read: false,
    targetRoute: 'trade-detail',
    targetParams: { id: 'trade-2' },
  },
  {
    id: 'noti-4',
    category: 'NOTICE',
    title: '공지사항',
    body: '커뮤니티 카테고리 구조가 3depth 기준으로 정리되었습니다.',
    time: '어제',
    read: true,
    targetRoute: 'system-alert-detail',
    targetParams: { id: 'alert-1' },
  },
  {
    id: 'noti-5',
    category: 'RESERVATION',
    title: '예약 리마인드',
    body: '내일 15:00 팝업스토어 예약이 예정되어 있습니다.',
    time: '어제',
    read: true,
    targetRoute: 'my-reservations',
  },
];

export const qrBase = {
  reservationId: 'reservation-1',
  title: 'NCT 127 고척돔행 셔틀',
  vehicle: '1호차 (경기77바1234)',
  departure: '14:00 출발 예정',
  place: '인천공항 T1 출국장 앞',
  people: '2명 (동승자 포함)',
  refreshedAt: '14:20',
};

export const qrStateDescriptions: Record<QrDisplayState, string> = {
  ACTIVE: '현재 QR을 사용해 탑승 검수가 가능합니다. 10분 후 자동 갱신됩니다.',
  EXPIRED: 'QR 유효시간이 지났습니다. 즉시 재생성 버튼 영역으로 전환됩니다.',
  REGENERATING: '새 QR을 불러오는 중입니다. 이전 QR은 사용할 수 없습니다.',
  OFFLINE: '네트워크 연결이 불안정합니다. 연결 복구 후 QR을 다시 불러옵니다.',
  FAILURE: 'QR 생성에 실패했습니다. 재시도 또는 고객센터 연결이 필요합니다.',
};

export const myProfile = {
  name: 'KIM WAVY',
  email: 'wavy_fan_912@service.com',
  verifiedLabel: '본인인증 완료 회원',
};

export const mySummary = {
  reservations: 2,
  tickets: 3,
  points: 12500,
  coupons: 4,
};

export const myMenu: MenuItem[] = [
  { id: 'my-reservations', label: '내 예약', count: 2, route: 'my-reservations' },
  { id: 'my-tickets', label: '내 티켓', count: 3, route: 'my-tickets' },
  { id: 'payment-center', label: '결제 / 환불 / 양도', route: 'payment-center' },
  { id: 'points-coupons', label: '포인트 / 쿠폰', count: 4, route: 'points-coupons' },
  { id: 'support', label: '고객센터', route: 'support' },
  { id: 'settings', label: '설정', route: 'settings' },
];

export const paymentHistory = {
  payment: [
    { id: 'pay-1', title: 'NCT 127 셔틀 결제', date: '2026.04.18 14:30', amount: '42,000원' },
    { id: 'pay-2', title: '청담 메이크업 예약', date: '2026.04.11 11:20', amount: '132,000원' },
  ],
  refund: [
    { id: 'refund-1', title: '팝업 사전예약 취소', date: '2026.03.30 10:00', amount: '-12,000원' },
  ],
  transfer: [
    { id: 'transfer-1', title: '셔틀 예약 양도 완료', date: '2026.03.21 09:50', amount: '1건 완료' },
  ],
};

export const pointHistory = [
  { id: 'point-1', title: '셔틀 예약 적립', date: '2026.04.18', delta: '+420P' },
  { id: 'point-2', title: '쿠폰 교환', date: '2026.04.15', delta: '-500P' },
];

export const couponItems = [
  { id: 'coupon-1', name: '홍대 맛집 10% 할인권', date: '2026.04.15', kind: 'coupon' },
  { id: 'coupon-2', name: 'NCT 응원봉 보관함 쿠폰', date: '2026.04.12', kind: 'coupon' },
  { id: 'coupon-3', name: 'K-Beauty 에스테틱 할인권', date: '2026.04.10', kind: 'coupon' },
  { id: 'coupon-4', name: '아티스트 모션 이모티콘', date: '2026.04.09', kind: 'item' },
];

export const supportItems = [
  {
    id: 'support-1',
    title: 'QR이 재생성되지 않을 때',
    body: '오프라인/실패 상태에서 연결 복구 후 다시 시도하거나 고객센터로 문의합니다.',
  },
  {
    id: 'support-2',
    title: 'Trade 사기/신고 처리',
    body: 'Trade 상세에서 신고 후, HIDDEN_REPORTED 상태 노출 정책을 따릅니다.',
  },
  {
    id: 'support-3',
    title: '예약/환불 정책',
    body: '예약 상세 및 결제/환불/양도 센터에서 동일한 상태 정보를 확인합니다.',
  },
];

export const defaultLanguages = ['ko', 'ja', 'en', 'zh'];
