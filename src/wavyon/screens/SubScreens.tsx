
import {
  AlertTriangle,
  BellRing,
  BusFront,
  CalendarDays,
  CloudRain,
  CloudSun,
  Check,
  ChevronRight,
  CheckCircle2,
  Coins,
  CreditCard,
  Globe,
  Headset,
  Heart,
  PlaneTakeoff,
  HelpCircle,
  Image as ImageIcon,
  Info,
  MapPin,
  MessageCircle,
  MoreHorizontal,
  Plus,
  QrCode,
  Send,
  RefreshCw,
  Search,
  Settings,
  Share2,
  ShieldAlert,
  ShieldCheck,
  Sun,
  Ticket,
  Users2,
  User,
  XCircle,
} from 'lucide-react';
import { useMemo, useState } from 'react';

import {
  couponItems,
  defaultLanguages,
  homeNews,
  mySummary,
  notifications,
  paymentHistory,
  pointHistory,
  qrBase,
  qrStateDescriptions,
  roomChats,
  supportItems,
  systemAlerts,
  tradeChatMessages,
  tradeItems,
  tradeReadonlyMessages,
  tripProducts,
  tripReservations,
  communityPosts,
  liveThreads,
} from '../data/mobileData';
import type { Navigate, RouteState, TradeStatus, QrDisplayState } from '../lib/types';
import {
  notificationCategoryClass,
  qrStateClass,
  qrStateLabel,
  tradeStatusClass,
  tradeStatusLabel,
  wavyonTheme,
} from '../lib/theme';
import { SubHeader } from '../components/layout';
import {
  BottomFixedActionBar,
  CardContainer,
  ChatBubble,
  CTAButton,
  EmptyState,
  ImagePlaceholder,
  InfoRow,
  InlineNotice,
  ListSearchBar,
  SegmentTabs,
  SettingRow,
  StatusBadge,
} from '../components/primitives';

const readOnlyStatuses: TradeStatus[] = ['COMPLETED', 'HIDDEN_BLOCKED'];

const ticketRows = [
  {
    id: 'ticket-1',
    title: 'NCT 127 고척돔 셔틀',
    status: '사용예정',
    time: '2026.04.22 14:00',
    place: '인천공항 T1 출국장 앞',
    quantity: '2명',
    reservationId: 'reservation-1',
  },
  {
    id: 'ticket-2',
    title: "NCT 127 'WALK' 팝업 입장",
    status: '사용예정',
    time: '2026.04.23 15:00',
    place: '더현대 서울 B1',
    quantity: '1매',
    reservationId: 'reservation-2',
  },
  {
    id: 'ticket-3',
    title: '청담 메이크업 체험',
    status: '사용완료',
    time: '2026.04.11 11:20',
    place: '청담동 뷰티 스트리트',
    quantity: '1건',
    reservationId: 'reservation-3',
  },
];

const paymentDetailTemplates = {
  payment: {
    label: '결제 상세',
    status: '결제 완료',
    summary: '해당 상품에 대한 결제 승인 정보와 주문 기준 항목을 노출합니다.',
  },
  refund: {
    label: '환불 상세',
    status: '환불 완료',
    summary: '취소 요청 일시, 환불 수단, 환불 완료 일시를 노출합니다.',
  },
  transfer: {
    label: '양도 상세',
    status: '양도 완료',
    summary: '양도 신청자, 양도 대상, 상태 변동 이력을 노출합니다.',
  },
} as const;

const renderPriceWithUnit = (priceLabel: string) => {
  if (priceLabel.includes(' KRW')) {
    const [value, unit] = priceLabel.split(' ');
    return (
      <h3 className="text-3xl font-black tracking-tight text-slate-900">
        {value} <span className="text-sm opacity-50">{unit}</span>
      </h3>
    );
  }

  return <h3 className="text-3xl font-black tracking-tight text-slate-900">{priceLabel}</h3>;
};


const detailComments = [
  { id: 'comment-1', author: 'WavyUser_01', time: '10분 전', body: '현장 동선까지 같이 정리해주셔서 너무 도움됐어요.', likes: 12 },
  { id: 'comment-2', author: 'NeoFan', time: '6분 전', body: 'Live Thread 열리면 같이 들어가서 실시간 정보 공유해요!', likes: 7 },
  { id: 'comment-3', author: '서울원정러', time: '방금', body: '예약/결제 링크도 같이 붙으면 더 좋을 것 같아요.', likes: 4 },
];

const boardListItems = [
  { id: 'board-post-1', tag: '자유', title: '응원봉 배터리 어디서 갈아끼우면 좋을까요?', author: 'NCTzen_32', time: '5분 전', stats: '댓글 11 · 조회 201' },
  { id: 'board-post-2', tag: '정보', title: '공항 셔틀 동선이랑 짐 보관 팁 정리했어요.', author: 'TripGuide', time: '12분 전', stats: '댓글 24 · 조회 533' },
  { id: 'board-post-3', tag: '후기', title: '고척돔 좌석 시야 후기 사진 모음', author: 'ViewMaster', time: '31분 전', stats: '댓글 39 · 조회 1.1k' },
  { id: 'board-post-4', tag: '자유', title: '오늘 팝업 줄 어느 정도인지 아시는 분?', author: '팝업대기중', time: '1시간 전', stats: '댓글 7 · 조회 122' },
];

const CommentsSection = ({
  title = '댓글',
}: {
  title?: string;
}) => {
  const [sort, setSort] = useState<'latest' | 'popular'>('latest');

  return (
    <div className="rounded-[24px] border border-slate-100 bg-white p-4 shadow-sm">
      <div className="mb-4 flex items-center justify-between">
        <h4 className="text-[13px] font-black text-slate-900">{title}</h4>
        <div className="flex gap-2">
          <button
            onClick={() => setSort('latest')}
            className={`rounded-full px-3 py-1.5 text-[10px] font-black ${
              sort === 'latest' ? 'bg-blue-50 text-blue-700' : 'bg-slate-50 text-slate-400'
            }`}
          >
            최신순
          </button>
          <button
            onClick={() => setSort('popular')}
            className={`rounded-full px-3 py-1.5 text-[10px] font-black ${
              sort === 'popular' ? 'bg-blue-50 text-blue-700' : 'bg-slate-50 text-slate-400'
            }`}
          >
            인기순
          </button>
        </div>
      </div>
      <div className="space-y-4">
        {detailComments.map((comment) => (
          <div key={comment.id} className="border-b border-slate-50 pb-4 last:border-b-0 last:pb-0">
            <div className="mb-1 flex items-center gap-2">
              <span className="text-[11px] font-black text-slate-800">{comment.author}</span>
              <span className="text-[9px] font-bold text-slate-400">{comment.time}</span>
            </div>
            <p className="text-[11px] font-medium leading-relaxed text-slate-600">{comment.body}</p>
            <button className="mt-2 inline-flex items-center gap-1 rounded-full bg-slate-50 px-3 py-1.5 text-[10px] font-black text-slate-500">
              <Heart size={12} />
              좋아요 {comment.likes}
            </button>
          </div>
        ))}
      </div>
      <div className="mt-4 flex items-center justify-center gap-2">
        {['1', '2', '3'].map((page) => (
          <button
            key={page}
            className={`h-8 min-w-8 rounded-full px-2 text-[10px] font-black ${
              page === '1' ? 'bg-blue-800 text-white' : 'bg-slate-50 text-slate-500'
            }`}
          >
            {page}
          </button>
        ))}
      </div>
      <div className="mt-4 flex gap-2">
        <input
          type="text"
          placeholder="댓글을 입력하세요..."
          className="flex-1 rounded-2xl border border-slate-100 bg-slate-50 px-4 py-3 text-xs font-bold focus:outline-none focus:ring-2 focus:ring-blue-100"
        />
        <button className="rounded-2xl bg-blue-800 px-4 py-3 text-white shadow-lg">
          <Send size={18} />
        </button>
      </div>
    </div>
  );
};


const WeatherScreen = ({ onBack }: { onBack: () => void }) => (
  <div className="flex h-full flex-col bg-slate-50">
    <SubHeader title="현지 날씨 정보" onBack={onBack} />
    <div className="flex-1 overflow-y-auto space-y-5 p-5 pb-[112px]">
      <div className="overflow-hidden rounded-[35px] p-6 text-white shadow-lg" style={{ background: wavyonTheme.gradients.banner1 }}>
        <div className="mb-4 flex items-center gap-1.5 rounded-full bg-white/20 px-3 py-1.5 text-[10px] font-black shadow-sm border border-white/20 w-fit">
          <MapPin size={12} /> GPS 기반 현재 위치: 서울특별시 성동구
        </div>
        <div className="flex items-center justify-between px-2">
          <div>
            <h3 className="mb-1 text-6xl font-black tracking-tighter">22°</h3>
            <p className="text-sm font-bold opacity-90">체감 24° · 맑음</p>
          </div>
          <CloudSun size={80} className="text-yellow-300 drop-shadow-md" />
        </div>
      </div>

      <CardContainer className="p-6">
        <h3 className="mb-4 flex items-center gap-2 text-[13px] font-black text-slate-800">
          <CalendarDays size={16} className="text-blue-700" /> 주간 날씨 예보
        </h3>
        <div className="divide-y divide-slate-50">
          {[
            { day: '오늘', icon: CloudSun, temp: '22° / 15°', className: 'text-yellow-500' },
            { day: '내일', icon: Sun, temp: '25° / 16°', className: 'text-orange-500' },
            { day: '수요일', icon: CloudRain, temp: '20° / 14°', className: 'text-blue-500' },
            { day: '목요일', icon: CloudSun, temp: '23° / 15°', className: 'text-yellow-500' },
            { day: '금요일', icon: Sun, temp: '26° / 17°', className: 'text-orange-500' },
          ].map((item, index) => (
            <div key={item.day} className="flex items-center justify-between py-4">
              <span className={`text-[13px] ${index === 0 ? 'font-black text-blue-700' : 'font-bold text-slate-600'}`}>{item.day}</span>
              <div className="flex items-center gap-6">
                <item.icon size={20} className={item.className} />
                <span className="w-16 text-right text-[13px] font-black text-slate-800">{item.temp}</span>
              </div>
            </div>
          ))}
        </div>
      </CardContainer>

      <InlineNotice
        title="옷차림 추천 가이드"
        description="일교차가 커서 귀가 시 쌀쌀할 수 있습니다. 얇은 겉옷을 함께 준비하는 흐름으로 기존 디자인을 복원합니다."
      />
    </div>
  </div>
);

const NotificationsScreen = ({
  onBack,
  navigate,
}: {
  onBack: () => void;
  navigate: Navigate;
}) => (
  <div className="flex h-full flex-col bg-white">
    <SubHeader
      title="알림"
      onBack={onBack}
      right={<button className="rounded-lg bg-blue-50 px-3 py-1.5 text-[11px] font-bold text-blue-700">모두 읽음</button>}
    />
    <div className="flex-1 overflow-y-auto pb-[100px]">
      <div className="p-6 pb-0">
        <ListSearchBar placeholder="알림 검색" />
      </div>
      {notifications.map((item) => (
        <div
          key={item.id}
          onClick={() => item.targetRoute && navigate(item.targetRoute, item.targetParams)}
          className={`flex cursor-pointer gap-4 border-b border-slate-50 p-5 transition-colors hover:bg-slate-50 ${
            item.read ? 'bg-white opacity-70' : 'bg-blue-50/20'
          }`}
        >
          <div className="mt-0.5">
            <BellRing size={20} className="text-blue-700" />
          </div>
          <div className="flex-1">
            <div className="mb-1 flex items-center justify-between">
              <h4 className="text-[13px] font-black text-slate-900">{item.title}</h4>
              <span className="text-[9px] font-bold text-slate-400">{item.time}</span>
            </div>
            <div className="mb-2">
              <StatusBadge label={item.category} className={notificationCategoryClass[item.category]} />
            </div>
            <p className="text-[11px] font-medium leading-relaxed text-slate-600">{item.body}</p>
          </div>
          {!item.read && <div className="mt-2 h-1.5 w-1.5 flex-shrink-0 rounded-full bg-red-500" />}
        </div>
      ))}
    </div>
  </div>
);

const QrCenterScreen = ({ onBack }: { onBack: () => void }) => {
  const [state, setState] = useState<QrDisplayState>('ACTIVE');

  return (
    <div className="flex h-full flex-col bg-slate-50">
      <SubHeader title="QR 탑승권" onBack={onBack} />
      <div className="flex-1 overflow-y-auto p-6 pb-[120px]">
        <div className="mb-6">
          <SegmentTabs
            value={state}
            onChange={setState}
            items={[
              { value: 'ACTIVE', label: '사용 가능' },
              { value: 'EXPIRED', label: '만료' },
              { value: 'REGENERATING', label: '재생성' },
              { value: 'OFFLINE', label: '오프라인' },
              { value: 'FAILURE', label: '실패' },
            ]}
          />
        </div>

        <CardContainer className="overflow-hidden p-8 text-center">
          <div className="mb-6 h-3 w-full rounded-full" style={{ background: wavyonTheme.gradients.banner1 }} />
          <div className="mb-3 flex items-center justify-center gap-2">
            <StatusBadge label={qrStateLabel[state]} className={qrStateClass[state]} />
            <span className="text-[10px] font-bold text-slate-400">예약 1건당 QR 1개</span>
          </div>
          <h3 className="mb-2 text-xl font-black text-slate-900">{qrBase.title}</h3>
          <p className="mb-6 text-[11px] font-bold text-slate-400">{qrBase.vehicle}</p>

          <div className="mx-auto mb-6 flex h-56 w-56 items-center justify-center rounded-[30px] border border-slate-100 bg-slate-50">
            {state === 'ACTIVE' ? (
              <QrCode size={148} className="text-slate-900" />
            ) : state === 'REGENERATING' ? (
              <RefreshCw size={56} className="animate-spin text-purple-600" />
            ) : state === 'OFFLINE' ? (
              <ShieldAlert size={56} className="text-orange-600" />
            ) : (
              <XCircle size={56} className="text-red-500" />
            )}
          </div>

          <p className="mb-4 rounded-xl border border-red-100 bg-red-50 py-2.5 text-[10px] font-bold text-red-600">
            저장 / 공유 / 캡처는 허용되지 않습니다.
          </p>
          <p className="text-[11px] font-medium leading-relaxed text-slate-500">{qrStateDescriptions[state]}</p>

          <div className="mt-6 rounded-[25px] border border-slate-100 bg-slate-50 p-4 text-left">
            <InfoRow label="출발" value={qrBase.departure} />
            <InfoRow label="탑승장소" value={qrBase.place} />
            <InfoRow label="예약인원" value={qrBase.people} emphasize />
            <InfoRow label="최근 갱신" value={qrBase.refreshedAt} />
          </div>
        </CardContainer>
      </div>

      <BottomFixedActionBar>
        <CTAButton variant="ghost" className="flex-1">
          고객센터
        </CTAButton>
        <CTAButton className="flex-1">다시 불러오기</CTAButton>
      </BottomFixedActionBar>
    </div>
  );
};

const ReservationDetailScreen = ({
  onBack,
  route,
  navigate,
}: {
  onBack: () => void;
  route: RouteState;
  navigate: Navigate;
}) => {
  const item = tripReservations.find((reservation) => reservation.id === route.params?.id) ?? tripReservations[0];

  return (
    <div className="flex h-full flex-col bg-slate-50">
      <SubHeader title="예약 상세" onBack={onBack} />
      <div className="flex-1 overflow-y-auto p-6 pb-[120px]">
        <CardContainer className="p-6">
          <div className="mb-4 flex items-center justify-between">
            <div>
              <p className="text-[10px] font-bold text-slate-400">상품 예약</p>
              <h3 className="text-lg font-black text-slate-900">{item.title}</h3>
            </div>
            <StatusBadge label="예약확정" className="border border-blue-100 bg-blue-50 text-blue-700" />
          </div>

          <div className="rounded-[25px] border border-slate-100 bg-slate-50 p-4">
            <InfoRow label="카테고리" value={item.type} />
            <InfoRow label="예약 일시" value={item.time} emphasize />
            <InfoRow label="장소" value={item.location} />
            <InfoRow label="예약자" value="KIM WAVY" />
            <InfoRow label="예약 번호" value={`RSV-${item.id}`} />
          </div>
        </CardContainer>

        <div className="mt-6 rounded-[25px] border border-slate-100 bg-white p-5 shadow-sm">
          <h4 className="mb-3 text-[12px] font-black text-slate-800">예약 안내</h4>
          <p className="text-[11px] font-medium leading-relaxed text-slate-500">
            내 예약 상세는 상품 기준 예약 정보를 노출하며, QR은 포함하지 않습니다. 결제·환불·양도 상세는 별도 센터에서 확인합니다.
          </p>
        </div>
      </div>

      <BottomFixedActionBar>
        <CTAButton variant="ghost" className="flex-1" onClick={() => navigate('payment-center')}>
          결제 / 환불 / 양도
        </CTAButton>
        <CTAButton className="flex-1" onClick={() => navigate('support')}>
          고객센터
        </CTAButton>
      </BottomFixedActionBar>
    </div>
  );
};


const NewsDetailScreen = ({
  onBack,
  route,
  navigate,
}: {
  onBack: () => void;
  route: RouteState;
  navigate: Navigate;
}) => {
  const news = homeNews.find((item) => item.id === route.params?.id) ?? homeNews[0];
  const hasExistingThread = news.id === 'news-1';

  return (
    <div className="flex h-full flex-col bg-white">
      <SubHeader title="뉴스 상세" onBack={onBack} right={<button className="p-2 text-slate-400"><Share2 size={20} /></button>} />
      <div className="flex-1 overflow-y-auto bg-slate-50 pb-[120px]">
        <div className="bg-white pb-6">
          <div className="p-6 pb-2">
            <StatusBadge label="K-POP NEWS" className="border border-blue-100 bg-blue-50 text-blue-700" />
            <h2 className="mb-4 mt-4 text-xl font-black leading-tight text-slate-900">{news.title}</h2>
            <div className="mb-4 border-b border-slate-100 pb-4 text-[10px] font-bold text-slate-400">WAVYON 기자 · 2026.04.20 10:30</div>
          </div>
          <div className="mb-6 px-6">
            <ImagePlaceholder className="h-56 w-full rounded-[30px]" />
          </div>
          <div className="px-6">
            <p className="text-sm font-medium leading-relaxed text-slate-700">
              {news.body}
              <br />
              <br />
              기사 상세에서는 뉴스와 연결된 Live Thread 존재 여부에 따라 배너 클릭으로 리스트 입장 또는 개설 화면으로 이동합니다.
            </p>
          </div>
        </div>

        <div className="space-y-5 p-5">
          <div
            onClick={() =>
              navigate(
                hasExistingThread ? 'live-chat-list' : 'live-thread-create',
                { source: news.id, newsTitle: news.title },
              )
            }
            className="relative cursor-pointer overflow-hidden rounded-[26px] p-5 text-white shadow-lg transition-transform active:scale-95"
            style={{ background: hasExistingThread ? wavyonTheme.gradients.banner4 : wavyonTheme.gradients.banner1 }}
          >
            <div className="absolute right-[-5px] top-[-10px] opacity-20 text-6xl">💬</div>
            <div className="relative z-10">
              <div className="mb-2 flex items-center justify-between">
                <div className="flex items-center gap-2">
                  <div className="h-2 w-2 rounded-full bg-white animate-ping" />
                  <span className="text-[10px] font-black uppercase tracking-widest opacity-90">Live Thread</span>
                </div>
                <span className="rounded-full bg-black/10 px-3 py-1 text-[10px] font-black backdrop-blur-md">
                  {hasExistingThread ? '입장' : '개설'}
                </span>
              </div>
              <h2 className="mb-1 text-lg font-black leading-tight">
                {hasExistingThread ? '이미 개설된 스레드가 있어요' : '이 뉴스로 새 스레드를 만들어요'}
              </h2>
              <p className="text-[10px] font-bold opacity-80">
                {hasExistingThread
                  ? '배너 클릭 시 Community > Live Thread 리스트로 이동합니다.'
                  : '배너 클릭 시 스레드명은 뉴스 제목으로 고정된 개설 화면으로 이동합니다.'}
              </p>
            </div>
          </div>

          <CommentsSection title="뉴스 댓글" />
        </div>
      </div>
    </div>
  );
};


const CommunityDetailScreen = ({ onBack }: { onBack: () => void }) => {
  const post = communityPosts[0];

  return (
    <div className="flex h-full flex-col bg-white">
      <SubHeader title="게시글 상세보기" onBack={onBack} />
      <div className="flex-1 overflow-y-auto space-y-5 bg-slate-50 p-5 pb-[128px]">
        <CardContainer className="p-6">
          <div className="mb-6 flex items-center gap-3">
            <div className="flex h-10 w-10 items-center justify-center rounded-2xl bg-blue-50 font-black text-blue-800">W</div>
            <div>
              <h4 className="text-sm font-black text-slate-900">{post.author}</h4>
              <p className="text-[10px] font-bold text-slate-400">10분 전 · 조회 1.2k</p>
            </div>
            <button className="ml-auto p-2 text-slate-400">
              <MoreHorizontal size={20} />
            </button>
          </div>
          <h3 className="mb-4 text-lg font-black leading-snug text-slate-900">{post.title}</h3>
          <p className="mb-6 text-sm font-medium leading-relaxed text-slate-600">
            {post.excerpt}
            <br />
            <br />
            팬덤 게시판 상세에서도 댓글 영역을 동일한 카드 패턴으로 하단 고정합니다.
          </p>
          <ImagePlaceholder className="mb-6 h-48 w-full rounded-[30px]" />
          <div className="flex items-center gap-6 border-y border-slate-50 py-4 text-[12px] font-black text-slate-400">
            <button className="flex items-center gap-1.5">❤️ 420</button>
            <button className="flex items-center gap-1.5">💬 85</button>
            <button className="ml-auto flex items-center gap-1.5">공유</button>
          </div>
        </CardContainer>

        <CommentsSection title="게시글 댓글" />
      </div>
    </div>
  );
};


const TripCategoryScreen = ({
  onBack,
  route,
  navigate,
}: {
  onBack: () => void;
  route: RouteState;
  navigate: Navigate;
}) => {
  const category = String(route.params?.category ?? 'FOOD');
  const [filter, setFilter] = useState<'전체' | '인기순' | '예약가능' | '할인'>('전체');
  const titleMap: Record<string, string> = {
    FOOD: '제휴 맛집',
    POPUP: '팝업스토어',
    BEAUTY: 'K-뷰티',
  };

  const items = tripProducts.filter((product) => product.category === category);

  return (
    <div className="flex h-full flex-col bg-slate-50">
      <SubHeader title={titleMap[category] ?? '카테고리'} onBack={onBack} />
      <div className="flex-1 overflow-y-auto p-5 pb-[118px]">
        <ListSearchBar placeholder="매장명 / 상품명 검색" withFilter />
        <div className="mt-3 flex gap-2 overflow-x-auto pb-1">
          {(['전체', '인기순', '예약가능', '할인'] as const).map((item) => (
            <button
              key={item}
              onClick={() => setFilter(item)}
              className={`whitespace-nowrap rounded-full border px-3.5 py-1.5 text-[11px] font-black transition-all ${
                filter === item ? 'border-blue-800 bg-blue-800 text-white shadow-md' : 'border-slate-200 bg-white text-slate-600'
              }`}
            >
              {item}
            </button>
          ))}
        </div>

        <div className="mt-4 space-y-3">
          {items.map((product) => (
            <CardContainer key={product.id} onClick={() => navigate('trip-product-detail', { id: product.id })} className="flex gap-3 p-4">
              <ImagePlaceholder label={product.imageLabel} className="h-20 w-20 flex-shrink-0 rounded-2xl" />
              <div className="flex-1">
                <div className="mb-1.5 flex justify-between">
                  <StatusBadge label={product.badge} className={product.badgeClass} />
                </div>
                <h4 className="text-[13px] font-black leading-snug text-slate-900">{product.title}</h4>
                <p className="mt-1 text-[10px] font-bold text-slate-400">{product.description}</p>
                <p className="mt-2 text-[12px] font-black text-slate-900">{product.priceLabel}</p>
              </div>
            </CardContainer>
          ))}
        </div>
      </div>
    </div>
  );
};


const TripProductDetailScreen = ({
  onBack,
  route,
  navigate,
}: {
  onBack: () => void;
  route: RouteState;
  navigate: Navigate;
}) => {
  const product = tripProducts.find((item) => item.id === route.params?.id) ?? tripProducts[0];
  const [slideIndex, setSlideIndex] = useState(0);
  const slides = Array.from({ length: 5 }, (_, index) => `${product.imageLabel} ${index + 1}`);

  return (
    <div className="flex h-full flex-col bg-white">
      <div className="absolute top-0 z-30 flex w-full items-center justify-between px-6 pb-4 pt-14">
        <button onClick={onBack} className="rounded-full bg-black/30 p-2 text-white shadow-sm backdrop-blur-md">
          ←
        </button>
        <button className="rounded-full bg-black/30 p-2 text-white shadow-sm backdrop-blur-md">
          <Share2 size={20} />
        </button>
      </div>

      <div className="relative flex-1 overflow-y-auto pb-[100px]">
        <div className="relative h-[380px] w-full overflow-hidden bg-slate-200">
          <div className="absolute inset-0 flex transition-transform duration-300" style={{ transform: `translateX(-${slideIndex * 100}%)` }}>
            {slides.map((label) => (
              <div key={label} className="flex h-full min-w-full items-center justify-center bg-slate-200 text-slate-400">
                <div className="flex flex-col items-center gap-2">
                  <ImageIcon size={32} />
                  <span className="text-[12px] font-black tracking-[0.24em]">{label}</span>
                </div>
              </div>
            ))}
          </div>
          <div className="absolute inset-0 z-10 bg-gradient-to-t from-slate-900 via-slate-900/30 to-transparent" />
          <div className="absolute bottom-0 z-20 w-full p-6 text-white">
            <StatusBadge label={product.badge} className={`${product.badgeClass} shadow-lg`} />
            <h2 className="mb-2 mt-3 text-2xl font-black leading-tight">{product.title}</h2>
            <div className="mb-4 text-xs font-bold opacity-90">4.9 · 128개의 리뷰</div>
            <div className="flex items-center justify-center gap-2">
              {slides.map((_, index) => (
                <button
                  key={index}
                  onClick={() => setSlideIndex(index)}
                  className={`h-2 rounded-full transition-all ${slideIndex === index ? 'w-5 bg-white' : 'w-2 bg-white/40'}`}
                />
              ))}
            </div>
          </div>
        </div>

        <div className="space-y-8 p-6">
          <div className="flex items-center justify-between border-b border-slate-100 pb-6">
            <div>
              <p className="mb-1 text-[11px] font-bold text-slate-400">공통 상품 템플릿</p>
              {renderPriceWithUnit(product.priceLabel)}
            </div>
            <StatusBadge label={product.category} className="border border-blue-100 bg-blue-50 text-blue-700" />
          </div>

          <div>
            <h4 className="mb-4 text-[14px] font-black text-slate-800">상품 하이라이트</h4>
            <div className="space-y-3">
              {[
                '기존 HOTSPOT 카드와 동일한 톤으로 상세 정보를 확장합니다.',
                '예약 시 날짜, 인원, 요청 사항, 포인트/쿠폰 사용을 함께 처리합니다.',
                '예약/결제 완료 화면은 별도 랜딩 페이지로 분리합니다.',
              ].map((item) => (
                <div key={item} className="flex items-start gap-3">
                  <div className="mt-0.5 rounded-full bg-blue-50 p-1.5">
                    <Check size={12} className="text-blue-700" />
                  </div>
                  <span className="text-[13px] font-bold leading-snug text-slate-700">{item}</span>
                </div>
              ))}
            </div>
          </div>

          <CardContainer className="p-5">
            <h4 className="mb-3 text-[12px] font-black text-slate-800">포함 / 제외</h4>
            <p className="mb-4 text-[11px] font-medium leading-relaxed text-slate-500">
              포함 사항, 현장 안내, 이용 정책을 설계서 기준 정보 슬롯으로 유지합니다.
            </p>
            <InfoRow label="위치" value={product.location} />
            <InfoRow label="예약 방식" value="일정 선택 후 결제" />
            <InfoRow label="포인트 / 쿠폰" value="사용 가능" />
          </CardContainer>
        </div>
      </div>

      <BottomFixedActionBar>
        <CTAButton variant="ghost" className="w-14 px-0">
          ♡
        </CTAButton>
        <CTAButton className="flex-1" onClick={() => navigate('trip-booking', { id: product.id })}>
          예약 진행
        </CTAButton>
      </BottomFixedActionBar>
    </div>
  );
};

const TradeDetailScreen = ({
  onBack,
  navigate,
  route,
}: {
  onBack: () => void;
  navigate: Navigate;
  route: RouteState;
}) => {
  const item = tradeItems.find((trade) => trade.id === route.params?.id) ?? tradeItems[0];
  const readOnly = readOnlyStatuses.includes(item.status);

  return (
    <div className="flex h-full flex-col bg-slate-50">
      <SubHeader title="Trade 상세" onBack={onBack} />
      <div className="flex-1 overflow-y-auto p-6 pb-[120px]">
        <CardContainer className="overflow-hidden">
          <ImagePlaceholder className="h-48 rounded-none rounded-t-[25px]" />
          <div className="p-5">
            <div className="mb-2 flex items-center justify-between">
              <StatusBadge label={tradeStatusLabel[item.status]} className={tradeStatusClass[item.status]} />
              <p className="text-[11px] font-bold text-slate-400">{item.priceLabel}</p>
            </div>
            <h3 className="text-lg font-black text-slate-900">{item.title}</h3>
            <p className="mt-1 text-[11px] font-bold text-slate-500">{item.lastStateText}</p>
          </div>
        </CardContainer>

        <div className="mt-6 grid grid-cols-2 gap-3">
          <CardContainer className="p-5">
            <p className="text-[10px] font-bold text-slate-400">판매자</p>
            <h4 className="mt-1 text-[13px] font-black text-slate-900">{item.sellerNickname}</h4>
          </CardContainer>
          <CardContainer className="p-5">
            <p className="text-[10px] font-bold text-slate-400">예약자 / 상대방</p>
            <h4 className="mt-1 text-[13px] font-black text-slate-900">{item.buyerNickname}</h4>
          </CardContainer>
        </div>

        <InlineNotice
          title="사기 방지 안내"
          description="거래 전 상품 상태와 직거래 장소를 다시 확인하고, 신고/차단 상태에서는 문서 기준 read-only 정책을 적용합니다."
        />
      </div>

      <BottomFixedActionBar>
        <CTAButton variant="ghost" className="flex-1">신고 / 차단</CTAButton>
        <CTAButton className="flex-1" onClick={() => navigate('trade-chat', { id: item.id })}>
          {readOnly ? '대화 보기' : '채팅하기'}
        </CTAButton>
      </BottomFixedActionBar>
    </div>
  );
};

const TradeChatScreen = ({
  onBack,
  route,
}: {
  onBack: () => void;
  route: RouteState;
}) => {
  const item = tradeItems.find((trade) => trade.id === route.params?.id) ?? tradeItems[0];
  const readOnly = readOnlyStatuses.includes(item.status);
  const messages = readOnly ? tradeReadonlyMessages : tradeChatMessages;

  return (
    <div className="flex h-full flex-col bg-slate-50">
      <SubHeader title="Trade 채팅" onBack={onBack} />
      <div className="flex-1 overflow-y-auto p-5 pb-[120px]">
        <CardContainer className="mb-4 p-5">
          <div className="mb-2 flex items-center justify-between gap-2">
            <div>
              <p className="text-[10px] font-bold text-slate-400">거래글 요약</p>
              <h4 className="text-[13px] font-black text-slate-900">{item.title}</h4>
            </div>
            <StatusBadge label={tradeStatusLabel[item.status]} className={tradeStatusClass[item.status]} />
          </div>
          <div className="rounded-[18px] border border-slate-100 bg-slate-50 p-4">
            <InfoRow label="상대방 닉네임" value={item.buyerNickname} />
            <InfoRow label="가격" value={item.priceLabel} emphasize />
          </div>
        </CardContainer>

        <InlineNotice
          title={readOnly ? '입력창 비활성화' : '거래 안내'}
          description={
            readOnly
              ? 'Trade 완료/차단 상태이므로 입력창이 비활성화되었습니다. 기존 대화는 계속 읽을 수 있습니다.'
              : '거래 중에는 상대방과 상태를 명확히 확인하고, 오프라인 만남 장소를 채팅에 남겨주세요.'
          }
          danger={readOnly}
        />

        <div className="mt-5 space-y-4">
          {messages.map((message) => (
            <ChatBubble key={message.id} kind={message.kind} sender={message.sender} time={message.time} text={message.text} />
          ))}
        </div>
      </div>

      <BottomFixedActionBar>
        {readOnly ? (
          <div className="w-full rounded-[20px] border border-slate-100 bg-slate-50 px-4 py-4 text-center text-[12px] font-black text-slate-400">
            read-only 상태입니다.
          </div>
        ) : (
          <>
            <button className="rounded-xl bg-slate-50 p-3 text-slate-400">
              <ImageIcon size={20} />
            </button>
            <input
              type="text"
              placeholder="메시지를 입력하세요..."
              className="flex-1 rounded-2xl border border-transparent bg-slate-100 px-4 py-3 text-xs font-bold focus:outline-none focus:ring-2 focus:ring-blue-100"
            />
            <CTAButton className="px-4 py-3">전송</CTAButton>
          </>
        )}
      </BottomFixedActionBar>
    </div>
  );
};

const SystemAlertDetailScreen = ({
  onBack,
  route,
}: {
  onBack: () => void;
  route: RouteState;
}) => {
  const item =
    systemAlerts.find((alert) => alert.id === route.params?.id) ??
    notifications.find((alert) => alert.id === route.params?.id) ??
    systemAlerts[0];

  return (
    <div className="flex h-full flex-col bg-white">
      <SubHeader title="시스템 알림 상세" onBack={onBack} />
      <div className="flex-1 overflow-y-auto p-6 pb-[100px]">
        <CardContainer className="p-6">
          <div className="mb-3 flex items-center gap-2">
            <StatusBadge label={item.category} className={notificationCategoryClass[item.category]} />
            <span className="text-[10px] font-bold text-slate-400">{item.time}</span>
          </div>
          <h3 className="text-lg font-black text-slate-900">{item.title}</h3>
          <p className="mt-3 text-sm font-medium leading-relaxed text-slate-600">{item.body}</p>
        </CardContainer>
      </div>
    </div>
  );
};

const MyReservationsScreen = ({
  onBack,
  navigate,
}: {
  onBack: () => void;
  navigate: Navigate;
}) => (
  <div className="flex h-full flex-col bg-slate-50">
    <SubHeader title="내 예약" onBack={onBack} />
    <div className="flex-1 overflow-y-auto space-y-3 p-5 pb-[118px]">
      <ListSearchBar placeholder="예약 내역 검색" />
      {tripReservations.map((item) => (
        <CardContainer key={item.id} onClick={() => navigate('reservation-detail', { id: item.id })} className="p-5">
          <div className="mb-2 flex items-center justify-between">
            <StatusBadge label="예약확정" className="border border-blue-100 bg-blue-50 text-blue-700" />
            <span className="text-[10px] font-bold text-slate-400">{item.time}</span>
          </div>
          <h4 className="text-[13px] font-black text-slate-900">{item.title}</h4>
          <p className="mt-1 text-[11px] font-bold text-slate-500">{item.location}</p>
        </CardContainer>
      ))}
    </div>
  </div>
);

const MyTicketsScreen = ({
  onBack,
  navigate,
}: {
  onBack: () => void;
  navigate: Navigate;
}) => (
  <div className="flex h-full flex-col bg-slate-50">
    <SubHeader title="내 티켓" onBack={onBack} />
    <div className="flex-1 overflow-y-auto p-6 pb-[100px] space-y-3">
      <ListSearchBar placeholder="티켓 검색" />
      {ticketRows.map((item) => (
        <CardContainer key={item.id} className="p-5">
          <div className="mb-3 flex items-start justify-between gap-3">
            <div>
              <p className="text-[10px] font-bold text-slate-400">Ticket</p>
              <h4 className="text-[14px] font-black text-slate-900">{item.title}</h4>
            </div>
            <button onClick={() => navigate('qr-center', { reservationId: item.reservationId })} className="rounded-xl bg-blue-50 px-4 py-2 text-[11px] font-black text-blue-700">
              QR
            </button>
          </div>
          <div className="rounded-[20px] border border-slate-100 bg-slate-50 p-4">
            <InfoRow label="이용 일시" value={item.time} emphasize />
            <InfoRow label="이용 장소" value={item.place} />
            <InfoRow label="수량" value={item.quantity} />
          </div>
        </CardContainer>
      ))}
    </div>
  </div>
);

const PaymentCenterScreen = ({
  onBack,
  navigate,
}: {
  onBack: () => void;
  navigate: Navigate;
}) => {
  const [tab, setTab] = useState<'payment' | 'refund' | 'transfer'>('payment');
  const list = paymentHistory[tab];

  return (
    <div className="flex h-full flex-col bg-slate-50">
      <SubHeader title="결제 / 환불 / 양도" onBack={onBack} />
      <div className="flex-1 overflow-y-auto p-6 pb-[100px]">
        <ListSearchBar placeholder="결제 / 환불 / 양도 검색" />
        <div className="mt-4">
          <SegmentTabs
          value={tab}
          onChange={setTab}
          items={[
            { value: 'payment', label: '결제' },
            { value: 'refund', label: '환불' },
            { value: 'transfer', label: '양도' },
          ]}
        />
        </div>
        <div className="mt-6 space-y-3">
          {list.map((item) => (
            <CardContainer key={item.id} onClick={() => navigate('payment-detail', { tab, id: item.id })} className="p-5">
              <div className="mb-1 flex items-center justify-between">
                <h4 className="text-[13px] font-black text-slate-900">{item.title}</h4>
                <span className="text-[11px] font-black text-slate-900">{item.amount}</span>
              </div>
              <p className="text-[10px] font-bold text-slate-400">{item.date}</p>
            </CardContainer>
          ))}
        </div>
      </div>
    </div>
  );
};

const PaymentDetailScreen = ({
  onBack,
  route,
}: {
  onBack: () => void;
  route: RouteState;
}) => {
  const tab = (route.params?.tab as 'payment' | 'refund' | 'transfer') ?? 'payment';
  const item = paymentHistory[tab].find((entry) => entry.id === route.params?.id) ?? paymentHistory[tab][0];
  const template = paymentDetailTemplates[tab];

  return (
    <div className="flex h-full flex-col bg-slate-50">
      <SubHeader title={template.label} onBack={onBack} />
      <div className="flex-1 overflow-y-auto p-6 pb-[100px] space-y-6">
        <CardContainer className="p-6">
          <div className="mb-3 flex items-center justify-between">
            <div>
              <p className="text-[10px] font-bold text-slate-400">상품 정보</p>
              <h3 className="text-lg font-black text-slate-900">{item.title}</h3>
            </div>
            <StatusBadge label={template.status} className="border border-blue-100 bg-blue-50 text-blue-700" />
          </div>
          <div className="rounded-[25px] border border-slate-100 bg-slate-50 p-4">
            <InfoRow label="일시" value={item.date} />
            <InfoRow label="금액" value={item.amount} emphasize />
            <InfoRow label="주문번호" value={`ORD-${item.id}`} />
            <InfoRow label="처리유형" value={tab.toUpperCase()} />
          </div>
        </CardContainer>

        <div className="rounded-[25px] border border-slate-100 bg-white p-5 shadow-sm">
          <h4 className="mb-3 text-[12px] font-black text-slate-800">상세 안내</h4>
          <p className="text-[11px] font-medium leading-relaxed text-slate-500">{template.summary}</p>
        </div>
      </div>
    </div>
  );
};



const TripBookingScreen = ({
  onBack,
  route,
  navigate,
}: {
  onBack: () => void;
  route: RouteState;
  navigate: Navigate;
}) => {
  const product = tripProducts.find((item) => item.id === route.params?.id) ?? tripProducts[0];
  const [selectedDate, setSelectedDate] = useState('2026.04.22');
  const [people, setPeople] = useState('2명');
  const [usedPoints, setUsedPoints] = useState(1000);
  const availableCoupons = couponItems.filter((item) => item.kind === 'coupon');
  const [selectedCouponId, setSelectedCouponId] = useState<string>(availableCoupons[0]?.id ?? '');
  const selectedCoupon = availableCoupons.find((item) => item.id === selectedCouponId);

  return (
    <div className="flex h-full flex-col bg-slate-50">
      <SubHeader title="예약 및 결제" onBack={onBack} />
      <div className="flex-1 overflow-y-auto space-y-5 p-5 pb-[128px]">
        <CardContainer className="p-5">
          <p className="text-[10px] font-bold text-slate-400">예약 상품</p>
          <h3 className="mt-1 text-lg font-black text-slate-900">{product.title}</h3>
          <p className="mt-2 text-[11px] font-bold text-slate-500">{product.location}</p>
        </CardContainer>

        <CardContainer className="p-5">
          <h4 className="mb-4 text-[13px] font-black text-slate-900">예약 정보</h4>
          <div className="grid grid-cols-2 gap-3">
            {['2026.04.22', '2026.04.23', '2026.04.24'].map((date) => (
              <button
                key={date}
                onClick={() => setSelectedDate(date)}
                className={`rounded-[18px] border px-4 py-3 text-[11px] font-black ${
                  selectedDate === date ? 'border-blue-800 bg-blue-800 text-white' : 'border-slate-100 bg-slate-50 text-slate-700'
                }`}
              >
                {date}
              </button>
            ))}
          </div>
          <div className="mt-3 grid grid-cols-3 gap-3">
            {['1명', '2명', '3명'].map((count) => (
              <button
                key={count}
                onClick={() => setPeople(count)}
                className={`rounded-[18px] border px-4 py-3 text-[11px] font-black ${
                  people === count ? 'border-blue-800 bg-blue-800 text-white' : 'border-slate-100 bg-slate-50 text-slate-700'
                }`}
              >
                {count}
              </button>
            ))}
          </div>
          <textarea
            placeholder="요청 사항을 입력하세요"
            className="mt-3 h-24 w-full rounded-[20px] border border-slate-100 bg-slate-50 p-4 text-xs font-bold text-slate-700 placeholder:text-slate-400 focus:outline-none focus:ring-2 focus:ring-blue-100"
          />
        </CardContainer>

        <CardContainer className="p-5">
          <h4 className="mb-4 text-[13px] font-black text-slate-900">포인트 / 쿠폰 / 결제</h4>
          <div className="rounded-[22px] border border-slate-100 bg-slate-50 p-4">
            <InfoRow label="내 포인트" value={`${mySummary.points.toLocaleString()}P`} />
            <InfoRow label="사용 포인트" value={`${usedPoints.toLocaleString()}P`} emphasize />
          </div>
          <div className="mt-3 flex gap-2 overflow-x-auto pb-1">
            {[0, 1000, 3000, mySummary.points].map((point) => (
              <button
                key={point}
                onClick={() => setUsedPoints(point)}
                className={`whitespace-nowrap rounded-full border px-4 py-2 text-[11px] font-black ${
                  usedPoints === point ? 'border-blue-800 bg-blue-800 text-white' : 'border-slate-200 bg-white text-slate-600'
                }`}
              >
                {point === 0 ? '미사용' : point === mySummary.points ? '전액 사용' : `${point.toLocaleString()}P`}
              </button>
            ))}
          </div>

          <div className="mt-4 rounded-[22px] border border-slate-100 bg-slate-50 p-4">
            <div className="mb-3 flex items-center justify-between">
              <h5 className="text-[12px] font-black text-slate-900">내 쿠폰 리스트</h5>
              <span className="text-[10px] font-black text-slate-400">{availableCoupons.length}개 보유</span>
            </div>
            <div className="space-y-2">
              {availableCoupons.map((item) => (
                <button
                  key={item.id}
                  onClick={() => setSelectedCouponId(item.id)}
                  className={`flex w-full items-center justify-between rounded-[18px] border px-4 py-3 text-left ${
                    selectedCouponId === item.id ? 'border-blue-800 bg-blue-50' : 'border-slate-100 bg-white'
                  }`}
                >
                  <div>
                    <div className="text-[11px] font-black text-slate-800">{item.name}</div>
                    <div className="mt-1 text-[9px] font-bold text-slate-400">{item.date}</div>
                  </div>
                  <span className={`text-[10px] font-black ${selectedCouponId === item.id ? 'text-blue-700' : 'text-slate-400'}`}>
                    {selectedCouponId === item.id ? '적용중' : '선택'}
                  </span>
                </button>
              ))}
            </div>
          </div>

          <div className="mt-4 space-y-3 rounded-[22px] border border-slate-100 bg-slate-50 p-4">
            <InfoRow label="적용 쿠폰" value={selectedCoupon?.name ?? '선택 안 함'} />
            <InfoRow label="예약 일자" value={selectedDate} />
            <InfoRow label="인원" value={people} />
            <InfoRow label="결제 금액" value={product.priceLabel} emphasize />
          </div>
        </CardContainer>
      </div>

      <BottomFixedActionBar>
        <CTAButton variant="ghost" className="flex-1">
          취소
        </CTAButton>
        <CTAButton className="flex-1" onClick={() => navigate('trip-booking-complete', { id: product.id })}>
          결제하고 예약 완료
        </CTAButton>
      </BottomFixedActionBar>
    </div>
  );
};


const TripBookingCompleteScreen = ({
  onBack,
  route,
  navigate,
}: {
  onBack: () => void;
  route: RouteState;
  navigate: Navigate;
}) => {
  const product = tripProducts.find((item) => item.id === route.params?.id) ?? tripProducts[0];

  return (
    <div className="flex h-full flex-col bg-slate-50">
      <SubHeader title="예약 완료" onBack={onBack} />
      <div className="flex flex-1 flex-col items-center justify-center p-6 pb-[120px]">
        <div className="w-full max-w-[360px] rounded-[35px] border border-slate-100 bg-white p-8 text-center shadow-sm">
          <div className="mx-auto mb-4 flex h-16 w-16 items-center justify-center rounded-full bg-blue-50 text-blue-700">
            <CheckCircle2 size={30} />
          </div>
          <p className="text-[10px] font-black text-blue-700">BOOKING COMPLETE</p>
          <h3 className="mt-2 text-2xl font-black text-slate-900">예약이 완료되었습니다</h3>
          <p className="mt-3 text-[11px] font-medium leading-relaxed text-slate-500">
            {product.title} 예약 및 결제가 정상 처리되었습니다. 내 예약 / 결제 상세에서 후속 정보를 확인할 수 있습니다.
          </p>

          <div className="mt-6 rounded-[24px] border border-slate-100 bg-slate-50 p-4 text-left">
            <InfoRow label="상품" value={product.title} />
            <InfoRow label="예약번호" value="RSV-BOOKING-2042" />
            <InfoRow label="결제상태" value="결제 완료" emphasize />
          </div>
        </div>
      </div>

      <BottomFixedActionBar>
        <CTAButton variant="ghost" className="flex-1" onClick={() => navigate('payment-center')}>
          결제 상세
        </CTAButton>
        <CTAButton className="flex-1" onClick={() => navigate('my-reservations')}>
          내 예약 보기
        </CTAButton>
      </BottomFixedActionBar>
    </div>
  );
};


const LiveThreadCreateScreen = ({
  onBack,
  route,
}: {
  onBack: () => void;
  route: RouteState;
}) => {
  const fixedTitle = String(route.params?.newsTitle ?? '고척돔 추가 공연 실시간 정보 공유');
  const fromNews = Boolean(route.params?.newsTitle);

  return (
    <div className="flex h-full flex-col bg-slate-50">
      <SubHeader title="Live Thread 개설" onBack={onBack} />
      <div className="flex-1 overflow-y-auto p-6 pb-[120px] space-y-6">
        <CardContainer className="p-5">
          <h4 className="mb-4 text-[13px] font-black text-slate-900">스레드 정보</h4>
          <div className="space-y-3">
            <input
              type="text"
              value={fixedTitle}
              readOnly={fromNews}
              className="w-full rounded-[18px] border border-slate-100 bg-slate-50 px-4 py-3 text-xs font-black text-slate-700 focus:outline-none focus:ring-2 focus:ring-blue-100"
            />
            {fromNews && <p className="text-[10px] font-bold text-slate-400">뉴스 상세에서 진입한 경우 스레드명은 뉴스 제목으로 고정됩니다.</p>}
            <textarea
              defaultValue="현장 동선 / 좌석 시야 / 굿즈 대기열 / 셔틀 이동 관련 실시간 정보를 함께 공유해요."
              className="h-28 w-full rounded-[20px] border border-slate-100 bg-slate-50 p-4 text-xs font-bold text-slate-700 focus:outline-none focus:ring-2 focus:ring-blue-100"
            />
            <div className="grid grid-cols-2 gap-3">
              <button className="rounded-[18px] border border-blue-800 bg-blue-800 px-4 py-3 text-[11px] font-black text-white">24시간 유지</button>
              <button className="rounded-[18px] border border-slate-100 bg-slate-50 px-4 py-3 text-[11px] font-black text-slate-700">팬덤 공개</button>
            </div>
          </div>
        </CardContainer>

        <InlineNotice
          title="Live Thread 정책"
          description="생성 후 24시간 뒤 자동 종료, 신고/비방 제재, 실시간 참여 인원/남은 시간 노출 구조를 유지합니다."
        />
      </div>

      <BottomFixedActionBar>
        <CTAButton variant="ghost" className="flex-1">임시 저장</CTAButton>
        <CTAButton className="flex-1">개설하기</CTAButton>
      </BottomFixedActionBar>
    </div>
  );
};


const CommunityBoardListScreen = ({
  onBack,
  route,
  navigate,
}: {
  onBack: () => void;
  route: RouteState;
  navigate: Navigate;
}) => (
  <div className="flex h-full flex-col bg-slate-50">
    <SubHeader title={String(route.params?.board ?? '팬덤 게시판')} onBack={onBack} />
    <div className="flex-1 overflow-y-auto p-6 pb-[100px] space-y-3">
      <ListSearchBar placeholder="게시판 글 검색" />
      {boardListItems.map((item) => (
        <CardContainer key={item.id} onClick={() => navigate('community-detail', { id: 'community-1' })} className="p-4">
          <div className="mb-2 flex items-center gap-2">
            <span className="rounded bg-blue-50 px-2 py-0.5 text-[9px] font-black text-blue-700">{item.tag}</span>
            <span className="text-[9px] font-bold text-slate-400">{item.time}</span>
          </div>
          <h4 className="text-[13px] font-black text-slate-900">{item.title}</h4>
          <p className="mt-1 text-[10px] font-bold text-slate-500">{item.author}</p>
          <p className="mt-2 text-[10px] font-bold text-slate-400">{item.stats}</p>
        </CardContainer>
      ))}
    </div>
  </div>
);

const PointsCouponsScreen = ({ onBack }: { onBack: () => void }) => {
  const [tab, setTab] = useState<'points' | 'coupons'>('points');

  return (
    <div className="flex h-full flex-col bg-slate-50">
      <SubHeader title="포인트 / 쿠폰" onBack={onBack} />
      <div className="flex-1 overflow-y-auto p-6 pb-[100px]">
        <ListSearchBar placeholder="포인트 / 쿠폰 검색" />
        <div className="mt-4 grid grid-cols-2 gap-3">
          <div className="rounded-[30px] p-5 text-white shadow-xl" style={{ background: wavyonTheme.gradients.dark }}>
            <p className="text-[9px] font-bold opacity-60">보유 포인트</p>
            <h4 className="mt-1 text-2xl font-black">{mySummary.points.toLocaleString()}P</h4>
          </div>
          <div className="rounded-[30px] border border-blue-100 bg-blue-50 p-5 text-blue-900 shadow-sm">
            <p className="text-[9px] font-bold opacity-50">사용 가능 쿠폰</p>
            <h4 className="mt-1 text-2xl font-black">{mySummary.coupons}개</h4>
          </div>
        </div>

        <div className="mt-6">
          <SegmentTabs
            value={tab}
            onChange={setTab}
            items={[
              { value: 'points', label: '포인트' },
              { value: 'coupons', label: '쿠폰' },
            ]}
          />
        </div>

        {tab === 'points' ? (
          <div className="mt-6 space-y-3">
            {pointHistory.map((item) => (
              <CardContainer key={item.id} className="p-5">
                <div className="mb-1 flex items-center justify-between">
                  <h4 className="text-[13px] font-black text-slate-900">{item.title}</h4>
                  <span className={`text-[12px] font-black ${item.delta.startsWith('+') ? 'text-blue-700' : 'text-red-600'}`}>{item.delta}</span>
                </div>
                <p className="text-[10px] font-bold text-slate-400">{item.date}</p>
              </CardContainer>
            ))}
          </div>
        ) : (
          <div className="mt-6 space-y-3">
            {couponItems.map((item) => (
              <CardContainer key={item.id} className="flex items-center justify-between p-5">
                <div>
                  <StatusBadge
                    label={item.kind === 'coupon' ? '쿠폰' : '아이템'}
                    className={item.kind === 'coupon' ? 'border border-blue-100 bg-blue-50 text-blue-700' : 'border border-purple-100 bg-purple-50 text-purple-700'}
                  />
                  <h4 className="mt-2 text-[13px] font-black text-slate-900">{item.name}</h4>
                  <p className="text-[10px] font-bold text-slate-400">{item.date}</p>
                </div>
                <button className="rounded-xl bg-blue-50 px-4 py-2 text-[11px] font-black text-blue-800">사용하기</button>
              </CardContainer>
            ))}
          </div>
        )}
      </div>
    </div>
  );
};

const SupportScreen = ({ onBack }: { onBack: () => void }) => (
  <div className="flex h-full flex-col bg-slate-50">
    <SubHeader title="고객센터" onBack={onBack} />
    <div className="flex-1 overflow-y-auto p-6 pb-[100px] space-y-3">
      {supportItems.map((item) => (
        <CardContainer key={item.id} className="p-5">
          <h4 className="text-[13px] font-black text-slate-900">{item.title}</h4>
          <p className="mt-1 text-[11px] font-medium leading-relaxed text-slate-600">{item.body}</p>
        </CardContainer>
      ))}
    </div>
  </div>
);

const SettingsScreen = ({ onBack }: { onBack: () => void }) => {
  const [language, setLanguage] = useState('ko');

  return (
    <div className="flex h-full flex-col bg-slate-50">
      <SubHeader title="설정" onBack={onBack} />
      <div className="flex-1 overflow-y-auto space-y-8 p-6 pb-[100px]">
        <section>
          <h3 className="mb-3 flex items-center gap-2 px-2 text-[13px] font-black text-slate-800">
            <Globe size={16} className="text-blue-700" />
            언어
          </h3>
          <div className="flex gap-2 rounded-[30px] border border-slate-100 bg-white p-2 shadow-sm">
            {defaultLanguages.map((item) => (
              <button
                key={item}
                onClick={() => setLanguage(item)}
                className={`flex-1 rounded-2xl py-3 text-xs font-black transition-all ${
                  language === item ? 'bg-blue-700 text-white shadow-md' : 'text-slate-500 hover:bg-slate-50'
                }`}
              >
                {item}
              </button>
            ))}
          </div>
        </section>

        <section>
          <h3 className="mb-3 flex items-center gap-2 px-2 text-[13px] font-black text-slate-800">
            <Settings size={16} className="text-blue-700" />
            일반 및 알림
          </h3>
          <div className="overflow-hidden rounded-[30px] border border-slate-100 bg-white shadow-sm">
            {['푸시 알림 수신', '마케팅 정보 수신 동의', 'Trade 상태 변경 알림'].map((item, index) => (
              <div key={item} className={`flex items-center justify-between p-5 ${index < 2 ? 'border-b border-slate-50' : ''}`}>
                <span className="text-[13px] font-bold text-slate-700">{item}</span>
                <div className={`flex h-6 w-12 items-center rounded-full px-1 ${index === 0 ? 'bg-blue-700' : 'bg-slate-200'}`}>
                  <div className={`h-4 w-4 rounded-full bg-white ${index === 0 ? 'translate-x-6' : 'translate-x-0'}`} />
                </div>
              </div>
            ))}
          </div>
        </section>

        <section>
          <h3 className="mb-3 flex items-center gap-2 px-2 text-[13px] font-black text-slate-800">
            <HelpCircle size={16} className="text-blue-700" />
            계정
          </h3>
          <div className="overflow-hidden rounded-[30px] border border-slate-100 bg-white shadow-sm">
            <div className="border-b border-slate-50 p-5 text-[13px] font-bold text-slate-700">로그아웃</div>
            <div className="p-5 text-[13px] font-bold text-red-500">회원 탈퇴</div>
          </div>
        </section>
      </div>
    </div>
  );
};

const LiveChatListScreen = ({ onBack, navigate }: { onBack: () => void; navigate: Navigate }) => (
  <div className="flex h-full flex-col bg-slate-50">
    <SubHeader
      title="Live Chat (24h)"
      onBack={onBack}
      right={
        <button onClick={() => navigate('live-thread-create')} className="rounded-xl bg-blue-800 p-2 text-white shadow-md">
          <Plus size={18} />
        </button>
      }
    />
    <div className="flex-1 overflow-y-auto space-y-4 p-5">
      <ListSearchBar placeholder="Live Thread 검색" />
      <div className="flex gap-3 rounded-2xl border border-blue-100 bg-blue-50 p-4 text-blue-900 shadow-sm">
        <Info size={16} className="mt-0.5 flex-shrink-0" />
        <p className="text-[10px] font-bold leading-relaxed">스레드는 24시간 뒤 자동으로 삭제됩니다. 우상단 + 버튼에서 새 Live Thread를 생성할 수 있습니다.</p>
      </div>
      {liveThreads.map((chat) => (
        <CardContainer key={chat.id} onClick={() => navigate('community-detail', { id: 'community-1' })} className="flex items-center justify-between p-5">
          <div>
            <div className="mb-1.5 flex items-center gap-2">
              {chat.hot && <StatusBadge label="HOT" className="bg-red-600 text-white" />}
              <span className="text-[10px] font-bold text-slate-400">{chat.remain} left</span>
            </div>
            <h4 className="text-sm font-black text-slate-800">{chat.title}</h4>
            <p className="mt-2 flex items-center gap-1 text-[10px] font-black text-blue-800">
              <Users2 size={12} />
              {chat.users}명 참여중
            </p>
          </div>
          <ChevronRight size={20} className="ml-4 text-slate-300" />
        </CardContainer>
      ))}
    </div>
  </div>
);

const ChatRoomScreen = ({
  onBack,
  route,
}: {
  onBack: () => void;
  route: RouteState;
}) => {
  const room = roomChats.find((item) => item.id === route.params?.id) ?? roomChats[0];
  const messages = room.id === 'room-1'
    ? [
        { id: 'room-1-a', kind: 'other' as const, sender: room.name, time: '14:02', text: '탑승객님, 현재 셔틀 출발 5분 전입니다.' },
        { id: 'room-1-b', kind: 'me' as const, sender: '나', time: '14:03', text: '네, 곧 도착합니다!' },
      ]
    : [
        { id: 'room-2-a', kind: 'other' as const, sender: room.name, time: '10:02', text: '혹시 아직 교환 가능할까요?' },
        { id: 'room-2-b', kind: 'me' as const, sender: '나', time: '10:04', text: '네 가능해요. 공연장 앞에서 보실래요?' },
      ];

  return (
    <div className="flex h-full flex-col bg-slate-50">
      <SubHeader title={room.name} onBack={onBack} right={<button className="p-2 text-slate-400"><Search size={20} /></button>} />
      <div className="flex-1 overflow-y-auto p-5 pb-[120px]">
        <div className="mb-6 flex justify-center">
          <span className="rounded-full bg-slate-200 px-3 py-1 text-[9px] font-black text-slate-500">2026년 4월 10일</span>
        </div>
        <div className="space-y-4">
          {messages.map((message) => (
            <ChatBubble key={message.id} kind={message.kind} sender={message.sender} time={message.time} text={message.text} />
          ))}
        </div>
      </div>

      <BottomFixedActionBar>
        <button className="rounded-xl bg-slate-50 p-3 text-slate-400">
          <ImageIcon size={20} />
        </button>
        <input
          type="text"
          placeholder="메시지를 입력하세요..."
          className="flex-1 rounded-2xl border border-transparent bg-slate-100 px-4 py-3 text-xs font-bold focus:outline-none focus:ring-2 focus:ring-blue-100"
        />
        <CTAButton className="px-4 py-3">전송</CTAButton>
      </BottomFixedActionBar>
    </div>
  );
};

export const SubScreenRouter = ({
  route,
  onBack,
  navigate,
}: {
  route: RouteState;
  onBack: () => void;
  navigate: Navigate;
}) => {
  switch (route.id) {
    case 'notifications':
      return <NotificationsScreen onBack={onBack} navigate={navigate} />;
    case 'qr-center':
      return <QrCenterScreen onBack={onBack} />;
    case 'reservation-detail':
      return <ReservationDetailScreen onBack={onBack} route={route} navigate={navigate} />;
    case 'news-detail':
      return <NewsDetailScreen onBack={onBack} route={route} navigate={navigate} />;
    case 'community-detail':
      return <CommunityDetailScreen onBack={onBack} />;
    case 'community-board-list':
      return <CommunityBoardListScreen onBack={onBack} route={route} navigate={navigate} />;
    case 'trip-category':
      return <TripCategoryScreen onBack={onBack} route={route} navigate={navigate} />;
    case 'trip-product-detail':
      return <TripProductDetailScreen onBack={onBack} route={route} navigate={navigate} />;
    case 'trip-booking':
      return <TripBookingScreen onBack={onBack} route={route} navigate={navigate} />;
    case 'trip-booking-complete':
      return <TripBookingCompleteScreen onBack={onBack} route={route} navigate={navigate} />;
    case 'trade-detail':
      return <TradeDetailScreen onBack={onBack} route={route} navigate={navigate} />;
    case 'trade-chat':
      return <TradeChatScreen onBack={onBack} route={route} />;
    case 'system-alert-detail':
      return <SystemAlertDetailScreen onBack={onBack} route={route} />;
    case 'my-reservations':
      return <MyReservationsScreen onBack={onBack} navigate={navigate} />;
    case 'my-tickets':
      return <MyTicketsScreen onBack={onBack} navigate={navigate} />;
    case 'payment-center':
      return <PaymentCenterScreen onBack={onBack} navigate={navigate} />;
    case 'payment-detail':
      return <PaymentDetailScreen onBack={onBack} route={route} />;
    case 'points-coupons':
      return <PointsCouponsScreen onBack={onBack} />;
    case 'support':
      return <SupportScreen onBack={onBack} />;
    case 'settings':
      return <SettingsScreen onBack={onBack} />;
    case 'weather':
      return <WeatherScreen onBack={onBack} />;
    case 'live-chat-list':
      return <LiveChatListScreen onBack={onBack} navigate={navigate} />;
    case 'live-thread-create':
      return <LiveThreadCreateScreen onBack={onBack} route={route} />;
    case 'chat-room':
      return <ChatRoomScreen onBack={onBack} route={route} />;
    default:
      return (
        <div className="flex h-full flex-col bg-white">
          <SubHeader title="준비 중" onBack={onBack} />
          <div className="flex flex-1 items-center justify-center p-10 text-center">
            <div>
              <h3 className="mb-2 text-xl font-black text-slate-800">기능 준비 중</h3>
              <p className="text-[12px] font-bold text-slate-400">기존 카드/모달 패턴으로 안전하게 확장할 자리입니다.</p>
            </div>
          </div>
        </div>
      );
  }
};
