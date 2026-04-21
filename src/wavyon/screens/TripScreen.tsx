
import { Flame, PlaneTakeoff, ShoppingBag, Sparkles, Utensils, X } from 'lucide-react';
import { useMemo, useState } from 'react';

import { tripProducts } from '../data/mobileData';
import type { Navigate } from '../lib/types';
import { wavyonTheme } from '../lib/theme';
import { CardContainer, FilterChip, ImagePlaceholder, SectionHeader, StatusBadge } from '../components/primitives';

const categoryButtons = [
  { id: 'FOOD', label: '제휴 맛집', icon: Utensils, className: 'bg-orange-50 text-orange-600' },
  { id: 'POPUP', label: '팝업스토어', icon: ShoppingBag, className: 'bg-purple-50 text-purple-600' },
  { id: 'BEAUTY', label: 'K-뷰티', icon: Sparkles, className: 'bg-pink-50 text-pink-600' },
] as const;

type InfoTab = '맛집 정보' | '여행 정보';

export const TripScreen = ({ navigate }: { navigate: Navigate }) => {
  const hotspotProducts = useMemo(() => tripProducts.filter((product) => product.category === 'HOTSPOT'), []);
  const foodProducts = useMemo(() => tripProducts.filter((product) => product.category === 'FOOD').slice(0, 2), []);
  const travelProducts = useMemo(
    () => tripProducts.filter((product) => product.category === 'POPUP' || product.category === 'BEAUTY').slice(0, 2),
    [],
  );
  const [isGuideModalOpen, setIsGuideModalOpen] = useState(false);
  const [infoTab, setInfoTab] = useState<InfoTab>('맛집 정보');

  const previewProducts = infoTab === '맛집 정보' ? foodProducts : travelProducts;
  const moreCategory = infoTab === '맛집 정보' ? 'FOOD' : 'POPUP';

  return (
    <div className="animate-in fade-in pb-8 duration-500">
      <header className="px-5 pb-3 pt-5">
        <h2 className="text-[22px] font-black">Trip & Infrastructure</h2>
      </header>

      <section className="mb-6 px-5">
        <SectionHeader
          title="맛집 정보 / 여행 정보"
          helper="상단 탭 리스트도 HOTSPOT 톤의 카드형 미리보기로 노출합니다."
          action={
            <button
              onClick={() => navigate('trip-category', { category: moreCategory })}
              className="rounded-xl bg-slate-50 px-3 py-2 text-[10px] font-black text-slate-600"
            >
              더보기
            </button>
          }
        />
        <div className="mb-3 flex gap-2 overflow-x-auto pb-1">
          {(['맛집 정보', '여행 정보'] as const).map((item) => (
            <FilterChip key={item} label={item} active={infoTab === item} onClick={() => setInfoTab(item)} />
          ))}
        </div>
        <div className="space-y-3">
          {previewProducts.map((product) => (
            <CardContainer
              key={`${infoTab}-${product.id}`}
              onClick={() => navigate('trip-product-detail', { id: product.id })}
              className="flex gap-3 p-4"
            >
              <ImagePlaceholder label={product.imageLabel} className="h-[76px] w-[76px] flex-shrink-0 rounded-[18px]" />
              <div className="min-w-0 flex-1">
                <div className="mb-1.5 flex justify-between">
                  <StatusBadge label={product.badge} className={product.badgeClass} />
                </div>
                <h4 className="line-clamp-1 text-[12px] font-black leading-snug text-slate-900">{product.title}</h4>
                <p className="mt-1 line-clamp-2 text-[10px] font-bold text-slate-400">{product.description}</p>
                <p className="mt-2 text-[12px] font-black text-slate-900">{product.priceLabel}</p>
              </div>
            </CardContainer>
          ))}
        </div>
      </section>

      <section className="mb-6 px-5">
        <SectionHeader title="HOTSPOT" helper="실시간 트렌드 기반 추천 상품" leftIcon={Flame} />
        <div className="space-y-3">
          {hotspotProducts.map((product) => (
            <CardContainer
              key={product.id}
              onClick={() => navigate('trip-product-detail', { id: product.id })}
              className="flex gap-3 p-4"
            >
              <ImagePlaceholder label={product.imageLabel} className="h-[76px] w-[76px] flex-shrink-0 rounded-[18px]" />
              <div className="min-w-0 flex-1">
                <div className="mb-1.5 flex justify-between">
                  <StatusBadge label={product.badge} className={product.badgeClass} />
                </div>
                <h4 className="line-clamp-1 text-[12px] font-black leading-snug text-slate-900">{product.title}</h4>
                <p className="mt-1 line-clamp-2 text-[10px] font-bold text-slate-400">{product.description}</p>
                <p className="mt-2 text-[12px] font-black text-slate-900">{product.priceLabel}</p>
              </div>
            </CardContainer>
          ))}
        </div>
      </section>

      <section className="mb-6 px-5">
        <div className="relative min-h-[128px] overflow-hidden rounded-[24px] p-4 text-white shadow-xl" style={{ background: wavyonTheme.gradients.banner3 }}>
          <div className="absolute bottom-[-10px] right-[-8px] opacity-20">
            <PlaneTakeoff size={66} />
          </div>
          <div className="relative z-10 flex h-full min-h-[96px] flex-col justify-between">
            <div className="mb-3">
              <h3 className="flex items-center gap-2 text-[13px] font-black">
                <PlaneTakeoff size={16} />
                인천공항 스마트 가이드
              </h3>
              <p className="mt-1 text-[10px] font-bold text-blue-100">항공편명 입력 후 설계 기준 정보를 모달로 확인합니다.</p>
            </div>
            <div className="flex gap-2">
              <input
                type="text"
                placeholder="예: KE071"
                className="flex-1 rounded-xl border border-white/30 bg-white/20 px-3 py-2 text-xs font-black text-white placeholder:text-blue-100/70 focus:outline-none focus:ring-2 focus:ring-white"
              />
              <button
                onClick={() => setIsGuideModalOpen(true)}
                className="rounded-xl bg-white px-4 py-2 text-xs font-black text-blue-700 shadow-md"
              >
                조회
              </button>
            </div>
          </div>
        </div>
      </section>

      <section className="mb-8 px-5">
        <SectionHeader title="카테고리 바로가기" helper="제휴 맛집 / 팝업스토어 / K-뷰티는 기존 버튼 진입 구조를 유지합니다." />
        <div className="grid grid-cols-3 gap-3">
          {categoryButtons.map((item) => {
            const Icon = item.icon;
            return (
              <button
                key={item.id}
                onClick={() => navigate('trip-category', { category: item.id })}
                className="rounded-[22px] border border-slate-100 bg-white p-3.5 shadow-sm transition-transform active:scale-95"
              >
                <div className={`mx-auto mb-2.5 flex h-11 w-11 items-center justify-center rounded-[16px] ${item.className}`}>
                  <Icon size={18} />
                </div>
                <div className="text-center text-[10px] font-black text-slate-800">{item.label}</div>
              </button>
            );
          })}
        </div>
      </section>

      {isGuideModalOpen && (
        <div className="fixed inset-0 z-50 flex items-end justify-center bg-slate-950/40 p-4 sm:items-center">
          <div className="absolute inset-0" onClick={() => setIsGuideModalOpen(false)} />
          <div className="relative z-10 w-full max-w-[398px] rounded-[30px] border border-slate-100 bg-white p-5 shadow-2xl animate-in fade-in slide-in-from-top-2">
            <div className="mb-4 flex items-start justify-between gap-4">
              <div>
                <div className="mb-2 flex items-center gap-2">
                  <div className="rounded-xl bg-blue-50 p-2 text-blue-700">
                    <PlaneTakeoff size={16} />
                  </div>
                  <span className="text-[10px] font-black text-blue-700">AIRPORT GUIDE</span>
                </div>
                <h3 className="text-lg font-black text-slate-900">KE071 항공편 조회 결과</h3>
                <p className="mt-1 text-[10px] font-bold text-slate-400">설계 기준 항공편 관련 정보 모달</p>
              </div>
              <button onClick={() => setIsGuideModalOpen(false)} className="rounded-full bg-slate-50 p-2 text-slate-400">
                <X size={18} />
              </button>
            </div>

            <div className="space-y-3">
              <div className="rounded-[22px] border border-slate-100 bg-slate-50 p-4">
                <div className="mb-3 flex items-center justify-between">
                  <div>
                    <p className="text-[9px] font-bold text-slate-400">항공편</p>
                    <h4 className="text-[14px] font-black text-slate-900">대한항공 KE071</h4>
                  </div>
                  <StatusBadge label="정상 운항" className="border border-green-100 bg-green-50 text-green-600" />
                </div>
                <div className="space-y-2 text-[11px] font-bold text-slate-600">
                  <div className="flex justify-between"><span className="text-slate-400">출발</span><span>2026.04.22 13:10</span></div>
                  <div className="flex justify-between"><span className="text-slate-400">터미널</span><span>T2</span></div>
                  <div className="flex justify-between"><span className="text-slate-400">체크인 카운터</span><span>D15 - D22</span></div>
                  <div className="flex justify-between"><span className="text-slate-400">탑승 게이트</span><span>248</span></div>
                  <div className="flex justify-between"><span className="text-slate-400">보안검색 권장</span><span>출발 2시간 전</span></div>
                </div>
              </div>

              <CardContainer className="p-4">
                <p className="text-[11px] font-bold leading-relaxed text-slate-600">
                  셔틀 승차장, 수하물 규정, 체크인 마감, 언어별 공항 안내 문구가 같은 모달 셸 안에서 확장되도록 유지합니다.
                </p>
              </CardContainer>
            </div>

            <div className="mt-5 flex gap-3">
              <button className="flex-1 rounded-[18px] border border-slate-100 bg-slate-50 px-4 py-3 text-[12px] font-black text-slate-700">
                다시 조회
              </button>
              <button className="flex-1 rounded-[18px] bg-blue-800 px-4 py-3 text-[12px] font-black text-white shadow-lg">
                확인
              </button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
};
