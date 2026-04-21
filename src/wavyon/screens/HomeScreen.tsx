
import { ArrowRight, Clock3, Flame, QrCode, Sparkles, Star, TrendingUp } from 'lucide-react';

import { homeFavorites, homeHotDeal, homeNews, homePopularPosts } from '../data/mobileData';
import type { Navigate } from '../lib/types';
import { CardContainer, ImagePlaceholder, SectionHeader, StatusBadge } from '../components/primitives';
import { wavyonTheme } from '../lib/theme';

export const HomeScreen = ({
  onOpenQr,
  navigate,
}: {
  onOpenQr: () => void;
  navigate: Navigate;
}) => (
  <div className="animate-in fade-in duration-500">
    <section className="px-6 pt-5">
      <SectionHeader title="My Favorites" leftIcon={Star} />
      <div className="flex gap-4 overflow-x-auto pb-2">
        {homeFavorites.map((favorite) => (
          <div key={favorite.id} className="flex flex-shrink-0 flex-col items-center gap-2">
            <div className={`flex h-14 w-14 items-center justify-center overflow-hidden rounded-[22px] border-2 border-white shadow-sm ${favorite.className}`}>
              <span className="text-xl font-black">{favorite.symbol}</span>
            </div>
            <span className="text-[10px] font-black text-slate-500">{favorite.id}</span>
          </div>
        ))}
      </div>
    </section>

    <section className="mt-6 px-6">
      <div
        onClick={onOpenQr}
        className="group relative cursor-pointer overflow-hidden rounded-[35px] p-6 text-white shadow-xl transition-transform active:scale-95"
        style={{ background: wavyonTheme.gradients.banner1 }}
      >
        <div className="absolute right-0 top-0 h-32 w-32 -mr-10 -mt-10 rounded-full bg-white/20 blur-2xl" />
        <div className="relative z-10">
          <div className="mb-4 flex items-start justify-end">
            <QrCode size={24} className="opacity-90" />
          </div>
          <h3 className="text-lg font-black leading-tight">
            NCT 127 고척돔 셔틀
            <br />
            1호차 (경기77바1234)
          </h3>
          <div className="mt-4 flex items-center justify-between border-t border-white/20 pt-4">
            <div className="flex items-center gap-1.5">
              <Clock3 size={14} className="text-blue-200" />
              <span className="text-xs font-bold text-blue-50">14:00 출발 예정</span>
            </div>
            <span className="flex items-center gap-1 rounded-xl bg-white/20 px-3 py-1 text-[10px] font-black">
              <QrCode size={12} />
              QR 열기
            </span>
          </div>
        </div>
      </div>
    </section>

    <section className="mt-6 px-6">
      <div
        className="relative flex items-center justify-between overflow-hidden rounded-[25px] p-5 text-white shadow-lg"
        style={{ background: wavyonTheme.gradients.banner2 }}
      >
        <div className="absolute -bottom-4 -right-4 rotate-12 opacity-20">
          <Sparkles size={80} />
        </div>
        <div className="relative z-10">
          <span className="mb-1.5 inline-block rounded-full bg-white/20 px-2 py-0.5 text-[9px] font-black uppercase tracking-wider shadow-sm">
            EVENT
          </span>
          <h2 className="text-[15px] font-black leading-tight">
            SUMMER K-FESTA
            <br />
            셔틀 얼리버드
          </h2>
        </div>
        <div className="relative z-10 text-right">
          <p className="mb-1 rounded-lg bg-white px-2 py-1 text-[11px] font-black text-pink-600 shadow-md">30% 할인</p>
          <ArrowRight size={16} className="ml-auto opacity-80" />
        </div>
      </div>
    </section>

    <section className="mt-8 px-6">
      <div
        onClick={() => navigate('community-detail', { id: 'community-1' })}
        className="relative cursor-pointer overflow-hidden rounded-[30px] p-6 text-white shadow-xl transition-all active:scale-[0.98]"
        style={{ background: wavyonTheme.gradients.dark }}
      >
        <div className="relative z-10">
          <div className="mb-4 flex items-center justify-between">
            <h4 className="flex items-center gap-2 text-[13px] font-black">
              <TrendingUp size={18} className="text-amber-400" />
              실시간 커뮤니티 인기글
            </h4>
          </div>
          <div className="rounded-2xl border border-white/10 bg-white/10 p-4 backdrop-blur-md">
            {homePopularPosts.map((post) => (
              <div key={post.id} className="mb-3 flex items-center gap-2 last:mb-0">
                <span className="rounded bg-amber-500/20 px-2 py-0.5 text-[10px] font-black text-amber-300">{post.rank}위</span>
                <p className="truncate text-[12px] font-bold text-white">{post.title}</p>
              </div>
            ))}
          </div>
        </div>
      </div>
    </section>

    <section className="mt-8 px-6">
      <SectionHeader title="실시간 K-POP 뉴스" />
      <div className="space-y-3">
        {homeNews.map((news) => (
          <CardContainer
            key={news.id}
            onClick={() => navigate('news-detail', { id: news.id })}
            className="flex items-center gap-4 p-4 hover:bg-blue-50"
          >
            <ImagePlaceholder className="h-14 w-14 rounded-xl" />
            <div className="flex-1">
              <div className="mb-1 flex items-center gap-2">
                <StatusBadge label={news.tag} className={news.tag === 'HOT' ? 'bg-red-50 text-red-600' : 'bg-blue-50 text-blue-700'} />
                <span className="text-[9px] font-bold text-slate-400">{news.time}</span>
              </div>
              <h4 className="line-clamp-1 text-[13px] font-black text-slate-800">{news.title}</h4>
            </div>
          </CardContainer>
        ))}
      </div>
    </section>

    <section className="mb-8 mt-8 px-6">
      <div className="flex items-center justify-between rounded-[30px] border border-red-100 bg-red-50 p-6 shadow-sm">
        <div>
          <h4 className="flex items-center gap-2 text-sm font-black text-red-900">
            WAVYON HOT DEAL
            <Flame size={16} fill="currentColor" />
          </h4>
          <p className="mt-1 text-[11px] font-bold text-red-700/70">{homeHotDeal.title}</p>
        </div>
        <button className="rounded-2xl bg-red-600 p-3 text-white shadow-lg shadow-red-200">
          <ArrowRight size={20} />
        </button>
      </div>
    </section>
  </div>
);
