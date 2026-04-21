
import { Check, ChevronDown, MessageCircle, Plus, Star, TrendingUp } from 'lucide-react';
import { useMemo, useState } from 'react';

import { favoriteBoards, homeNews, liveThreads, tradeItems } from '../data/mobileData';
import type { Navigate } from '../lib/types';
import { tradeStatusClass, tradeStatusLabel, wavyonTheme } from '../lib/theme';
import { CardContainer, ImagePlaceholder, InlineNotice, ListSearchBar, StatusBadge } from '../components/primitives';

const favoriteTabs = favoriteBoards;
const artistBoards = ['NCT 127', 'NewJeans', 'Stray Kids', 'IVE', 'AESPA', 'RIIZE'] as const;
const infoBoards = ['Trade', '공연정보'] as const;
const extraBoards = ['자유게시판', '실시간 뉴스'] as const;

type CommunityBoard =
  | 'NCT 127'
  | 'NewJeans'
  | 'Stray Kids'
  | 'IVE'
  | 'AESPA'
  | 'RIIZE'
  | '자유게시판'
  | 'Trade'
  | '공연정보'
  | '실시간 뉴스';

const fandomList = [
  { tab: '자유', title: '내일 콘서트 끝나고 셔틀 타러 가는 길 안 복잡할까요?', author: 'WavyUser_01', time: '10분 전', likes: 24, cmts: 8 },
  { tab: '질문', title: '팝업스토어 대기열 지금 어떤가요?', author: '해찬맘', time: '15분 전', likes: 5, cmts: 12 },
  { tab: '정보', title: '고척돔 2층 N구역 시야 사진 공유합니다.', author: '엔시티즌', time: '30분 전', likes: 156, cmts: 40 },
  { tab: '자유', title: '이번 MD 진짜 예쁘게 잘 뽑은듯 ㅠㅠ', author: '마크랑', time: '1시간 전', likes: 82, cmts: 15 },
  { tab: '자유', title: '셔틀 1호차 타시는 분들 같이 가요!', author: '팬더마우스', time: '2시간 전', likes: 14, cmts: 3 },
];

export const CommunityScreen = ({ navigate }: { navigate: Navigate }) => {
  const [selectedBoard, setSelectedBoard] = useState<CommunityBoard>('NCT 127');
  const [isDropdownOpen, setIsDropdownOpen] = useState(false);

  const isArtistBoard = useMemo(() => artistBoards.includes(selectedBoard as (typeof artistBoards)[number]), [selectedBoard]);

  const selectBoard = (value: CommunityBoard) => {
    setSelectedBoard(value);
    setIsDropdownOpen(false);
  };

  return (
    <div className="relative animate-in fade-in duration-500">
      <div className="sticky top-0 z-40 border-b border-slate-100 bg-white/95 px-5 pb-3 pt-5 shadow-sm backdrop-blur-md">
        <div className="relative mb-3 flex items-center justify-between">
          <button onClick={() => setIsDropdownOpen((prev) => !prev)} className="flex items-center gap-2">
            <h2 className="text-[22px] font-black text-slate-900">{selectedBoard}</h2>
            <ChevronDown size={22} className={isDropdownOpen ? 'rotate-180 text-slate-800 transition-transform' : 'text-slate-800 transition-transform'} />
          </button>
          <div className="rounded-full bg-slate-50 px-3 py-1.5 text-[10px] font-black text-slate-500">3depth</div>

          {isDropdownOpen && (
            <>
              <div className="fixed inset-0 z-40" onClick={() => setIsDropdownOpen(false)} />
              <div className="absolute left-0 top-11 z-50 w-64 rounded-[24px] border border-slate-100 bg-white py-2.5 shadow-2xl animate-in fade-in slide-in-from-top-2">
                <div className="max-h-[420px] overflow-y-auto">
                  <div className="mb-2">
                    <div className="flex items-center gap-1.5 px-4 py-2 text-[10px] font-black text-blue-700">
                      <Star size={12} fill="currentColor" />
                      즐겨찾기 게시판
                    </div>
                    {favoriteTabs.map((board) => (
                      <div
                        key={board}
                        onClick={() => selectBoard((board === 'Trade' ? 'Trade' : board) as CommunityBoard)}
                        className="flex cursor-pointer items-center justify-between px-4 py-2.5 text-[13px] font-black text-slate-700 transition-colors hover:bg-slate-50"
                      >
                        {board}
                        {selectedBoard === board && <Check size={16} className="text-blue-700" />}
                      </div>
                    ))}
                  </div>

                  <div className="border-t border-slate-50 pt-2">
                    <div className="px-4 py-2 text-[10px] font-black text-slate-400">일반</div>
                    {extraBoards.map((board) => (
                      <div
                        key={board}
                        onClick={() => selectBoard(board as CommunityBoard)}
                        className="flex cursor-pointer items-center justify-between px-4 py-2.5 text-[13px] font-black text-slate-700 transition-colors hover:bg-slate-50"
                      >
                        {board}
                        {selectedBoard === board && <Check size={16} className="text-blue-700" />}
                      </div>
                    ))}
                  </div>

                  <div className="border-t border-slate-50 pt-2">
                    <div className="px-4 py-2 text-[10px] font-black text-slate-400">아티스트 게시판</div>
                    {artistBoards.map((board) => (
                      <div
                        key={board}
                        onClick={() => selectBoard(board as CommunityBoard)}
                        className="flex cursor-pointer items-center justify-between px-4 py-2.5 text-[13px] font-black text-slate-700 transition-colors hover:bg-slate-50"
                      >
                        {board}
                        {selectedBoard === board && <Check size={16} className="text-blue-700" />}
                      </div>
                    ))}
                  </div>

                  <div className="border-t border-slate-50 pt-2">
                    <div className="px-4 py-2 text-[10px] font-black text-slate-400">정보 및 교환</div>
                    {infoBoards.map((board) => (
                      <div
                        key={board}
                        onClick={() => selectBoard(board as CommunityBoard)}
                        className="flex cursor-pointer items-center justify-between px-4 py-2.5 text-[13px] font-black text-slate-700 transition-colors hover:bg-slate-50"
                      >
                        {board}
                        {selectedBoard === board && <Check size={16} className="text-blue-700" />}
                      </div>
                    ))}
                  </div>
                </div>
              </div>
            </>
          )}
        </div>

        <div className="flex gap-2 overflow-x-auto px-1 pb-1">
          {favoriteTabs.map((tab) => (
            <button
              key={tab}
              onClick={() => selectBoard((tab === 'Trade' ? 'Trade' : tab) as CommunityBoard)}
              className={`whitespace-nowrap rounded-full border px-3.5 py-1.5 text-[11px] font-black transition-all ${
                selectedBoard === tab ? 'border-blue-800 bg-blue-800 text-white shadow-md' : 'border-slate-200 bg-white text-slate-600 hover:bg-slate-50'
              }`}
            >
              {tab}
            </button>
          ))}
        </div>

        {!isArtistBoard && (
          <div className="mt-3">
            <ListSearchBar placeholder={`${selectedBoard} 게시판 검색`} />
          </div>
        )}
      </div>

      <div className="min-h-screen space-y-5 bg-slate-50 p-5 pb-32">
        {selectedBoard === 'Trade' ? (
          <>
            <InlineNotice
              title="안전한 중고거래 정책"
              description="본인인증 완료 유저 전용 게시판입니다. 사기 및 신고 시 문서 기준 상태값만 노출합니다."
            />
                  글쓰기
                </button>
              }
            />
            <div className="grid grid-cols-2 gap-3">
              {tradeItems.filter((item) => item.status !== 'DELETED').map((item) => (
                <CardContainer key={item.id} onClick={() => navigate('trade-detail', { id: item.id })} className="overflow-hidden">
                  <ImagePlaceholder className="h-24 rounded-none rounded-t-[24px]" />
                  <div className="p-3.5">
                    <StatusBadge label={tradeStatusLabel[item.status]} className={tradeStatusClass[item.status]} />
                    <h4 className="mb-1 mt-2 line-clamp-1 text-[11px] font-black text-slate-800">{item.title}</h4>
                    <p className="text-sm font-black text-slate-900">{item.priceLabel}</p>
                  </div>
                </CardContainer>
              ))}
            </div>
          </>
        ) : selectedBoard === '공연정보' ? (
          <>
            <div className="relative overflow-hidden rounded-[26px] p-5 text-white shadow-lg" style={{ background: wavyonTheme.gradients.banner1 }}>
              <div className="relative z-10 pr-10">
                <h4 className="text-sm font-black">Shuttle-K 수요 조사</h4>
                <p className="mt-1 text-[10px] font-bold opacity-80">지방러를 위한 버스 대절 신청</p>
              </div>
            </div>
            <CardContainer onClick={() => navigate('live-chat-list')} className="cursor-pointer p-4">
              <div className="mb-2 flex items-center justify-between">
                <div className="flex items-center gap-2">
                  <div className="h-2 w-2 rounded-full bg-red-500 animate-ping" />
                  <span className="text-[10px] font-black uppercase tracking-widest text-red-500">Live Thread</span>
                </div>
                <span className="text-[10px] font-black text-slate-400">목록 보기</span>
              </div>
              <h4 className="text-sm font-black text-slate-900">LIVE THREAD 리스트</h4>
              <p className="mt-1 text-[11px] font-bold text-slate-500">배너 클릭 시 기존 디자인의 Live Chat (24h) 리스트로 이동합니다.</p>
            </CardContainer>
            <div className="space-y-3">
              {homeNews.map((news) => (
                <CardContainer key={news.id} onClick={() => navigate('news-detail', { id: news.id })} className="flex items-center gap-3 p-3.5">
                  <ImagePlaceholder className="h-12 w-12 rounded-xl" />
                  <div className="flex-1">
                    <div className="mb-1 flex items-center gap-2">
                      <StatusBadge label={news.tag} className={news.tag === 'HOT' ? 'bg-red-50 text-red-600' : 'bg-blue-50 text-blue-700'} />
                      <span className="text-[9px] font-bold text-slate-400">{news.time}</span>
                    </div>
                    <h4 className="line-clamp-1 text-[12px] font-black text-slate-800">{news.title}</h4>
                  </div>
                </CardContainer>
              ))}
            </div>
          </>
        ) : selectedBoard === '실시간 뉴스' ? (
          <div className="space-y-3">
            {homeNews.map((news) => (
              <CardContainer key={news.id} onClick={() => navigate('news-detail', { id: news.id })} className="flex items-center gap-3 p-3.5">
                <ImagePlaceholder className="h-12 w-12 rounded-xl" />
                <div className="flex-1">
                  <div className="mb-1 flex items-center gap-2">
                    <StatusBadge label={news.tag} className={news.tag === 'HOT' ? 'bg-red-50 text-red-600' : 'bg-blue-50 text-blue-700'} />
                    <span className="text-[9px] font-bold text-slate-400">{news.time}</span>
                  </div>
                  <h4 className="line-clamp-1 text-[12px] font-black text-slate-800">{news.title}</h4>
                </div>
              </CardContainer>
            ))}
          </div>
        ) : selectedBoard === '자유게시판' ? (
          <>
            <div className="space-y-3">
              {fandomList.slice(0, 4).map((post, index) => (
                <CardContainer
                  key={`${post.title}-${index}`}
                  onClick={() => navigate('community-detail', { id: 'community-1' })}
                  className="p-4"
                >
                  <div className="mb-2 flex items-center gap-2">
                    <span className="rounded bg-blue-50 px-2 py-0.5 text-[9px] font-black text-blue-700">{post.tab}</span>
                    <span className="text-[9px] font-bold text-slate-400">{post.time}</span>
                  </div>
                  <h4 className="text-[12px] font-black leading-snug text-slate-900">{post.title}</h4>
                  <div className="mt-2 flex items-center justify-between text-[10px] font-bold text-slate-400">
                    <span>{post.author}</span>
                    <span>♥ {post.likes} · 💬 {post.cmts}</span>
                  </div>
                </CardContainer>
              ))}
            </div>
          </>
        ) : (
          <>
            {isArtistBoard && (
              <div
                onClick={() => navigate('live-chat-list')}
                className="relative cursor-pointer overflow-hidden rounded-[26px] p-5 text-white shadow-lg transition-transform active:scale-95"
                style={{ background: wavyonTheme.gradients.banner4 }}
              >
                <div className="absolute right-[-5px] top-[-10px] opacity-20 text-6xl">💬</div>
                <div className="relative z-10">
                  <div className="mb-2 flex items-center justify-between">
                    <div className="flex items-center gap-2">
                      <div className="h-2 w-2 rounded-full bg-white animate-ping" />
                      <span className="text-[10px] font-black uppercase tracking-widest opacity-90">Live Thread</span>
                    </div>
                    <span className="rounded-full bg-black/10 px-3 py-1 text-[10px] font-black backdrop-blur-md">목록</span>
                  </div>
                  <h2 className="mb-1 text-lg font-black leading-tight">
                    {selectedBoard} 팬덤
                    <br />
                    실시간 화력 집중!
                  </h2>
                  <p className="text-[10px] font-bold opacity-80">지금 {liveThreads[0].users.toLocaleString()}명이 대화하고 있어요</p>
                </div>
              </div>
            )}
            <section className="rounded-[24px] border border-slate-100 bg-white p-3.5 shadow-sm">
              <div className="divide-y divide-slate-100">
                {fandomList.map((post, index) => (
                  <div
                    key={`${post.title}-${index}`}
                    onClick={() => navigate('community-detail', { id: 'community-1' })}
                    className="flex cursor-pointer justify-between gap-3 px-1 py-2.5 transition-colors active:bg-slate-50"
                  >
                    <div className="min-w-0 flex-1">
                      <div className="mb-1.5 flex items-center gap-1.5">
                        <span className="rounded bg-blue-50 px-1.5 py-0.5 text-[9px] font-black text-blue-700">{post.tab}</span>
                        <span className="text-[9px] font-bold text-slate-500">{post.author}</span>
                        <span className="text-[8px] font-bold text-slate-400">· {post.time}</span>
                      </div>
                      <h4 className="line-clamp-1 text-[12px] font-bold text-slate-800">{post.title}</h4>
                    </div>
                    <div className="mb-0.5 flex items-end gap-2.5 text-[10px] font-black text-slate-400">
                      <span>♥ {post.likes}</span>
                      <span>💬 {post.cmts}</span>
                    </div>
                  </div>
                ))}
              </div>
            </section>
          </>
        )}
      </div>
{selectedBoard === 'Trade' && (
  <button
    onClick={() => navigate('trade-write')}
    className="fixed bottom-24 right-5 z-50 inline-flex h-12 items-center gap-2 rounded-full px-4 text-[12px] font-black text-white shadow-[0_14px_26px_rgba(15,23,42,0.18)]"
    style={{ background: wavyonTheme.logoGradients.dark }}
  >
    <Plus size={16} />
    글쓰기
  </button>
)}

    </div>
  );
};
