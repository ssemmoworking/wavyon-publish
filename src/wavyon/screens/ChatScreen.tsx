
import { BellRing, BusFront, MessageCircle, User } from 'lucide-react';
import { useMemo, useState } from 'react';

import { roomChats, systemAlerts, tradeItems } from '../data/mobileData';
import type { ChatTab, Navigate, TradeStatus } from '../lib/types';
import { notificationCategoryClass, tradeStatusClass, tradeStatusLabel } from '../lib/theme';
import { CardContainer, InlineNotice, ListSearchBar, SectionHeader, SegmentTabs, StatusBadge } from '../components/primitives';

const tradeReadOnlyStatuses: TradeStatus[] = ['COMPLETED', 'HIDDEN_BLOCKED'];

export const ChatScreen = ({ navigate }: { navigate: Navigate }) => {
  const [tab, setTab] = useState<ChatTab>('ROOMS');
  const visibleTrades = useMemo(() => tradeItems.filter((item) => item.status !== 'DELETED'), []);

  return (
    <div className="animate-in fade-in duration-500">
      <div className="sticky top-0 z-20 border-b border-slate-100 bg-white px-6 pb-4 pt-10 shadow-sm">
        <h2 className="text-2xl font-black">Chat</h2>
        <div className="mt-4">
          <SegmentTabs
            value={tab}
            onChange={setTab}
            items={[
              { value: 'ROOMS', label: '채팅방' },
              { value: 'TRADE', label: 'Trade' },
              { value: 'SYSTEM', label: '시스템 알림' },
            ]}
          />
        </div>
        <div className="mt-3">
          <ListSearchBar
            placeholder={tab === 'ROOMS' ? '채팅방 검색' : tab === 'TRADE' ? 'Trade 채팅 검색' : '시스템 알림 검색'}
          />
        </div>
      </div>

      {tab === 'ROOMS' && (
        <div className="divide-y divide-slate-50">
          {roomChats.map((chat) => (
            <div
              key={chat.id}
              onClick={() => navigate('chat-room', { id: chat.id })}
              className="flex cursor-pointer items-center gap-4 p-6 transition-all hover:bg-slate-50 active:bg-slate-100"
            >
              <div className="relative">
                <div
                  className={`flex h-14 w-14 items-center justify-center rounded-[20px] shadow-sm ${
                    chat.type === 'DRIVER'
                      ? 'bg-blue-50 text-blue-700'
                      : 'border border-slate-100 bg-white text-slate-400'
                  }`}
                >
                  {chat.type === 'DRIVER' ? <BusFront size={24} /> : <User size={24} />}
                </div>
                {chat.online && <div className="absolute -bottom-1 -right-1 h-3.5 w-3.5 rounded-full border-2 border-white bg-green-500" />}
              </div>
              <div className="min-w-0 flex-1">
                <div className="mb-1 flex items-center justify-between">
                  <h4 className="truncate text-[13px] font-black text-slate-800">{chat.name}</h4>
                  <span className="text-[9px] font-bold text-slate-400">{chat.time}</span>
                </div>
                <p className="truncate text-[11px] font-bold leading-relaxed text-slate-500">{chat.body}</p>
              </div>
              {chat.unread > 0 && (
                <div className="flex h-5 w-5 items-center justify-center rounded-full bg-red-600 text-[10px] font-black text-white shadow-md">
                  {chat.unread}
                </div>
              )}
            </div>
          ))}
        </div>
      )}

      {tab === 'TRADE' && (
        <div className="bg-slate-50 p-6 pb-28">
          <InlineNotice
            title="Trade 채팅 정책"
            description="기존 대화는 읽을 수 있고, 완료/차단 상태에서는 입력창이 비활성화됩니다. 거래글 제목·상태·상대방 닉네임을 상단 고정 노출합니다."
          />
          <div className="mt-6 space-y-3">
            {visibleTrades.map((trade) => (
              <CardContainer key={trade.id} onClick={() => navigate('trade-chat', { id: trade.id })} className="p-5">
                <div className="flex gap-4">
                  <div className="flex h-16 w-16 items-center justify-center rounded-[18px] bg-slate-100 text-slate-300">
                    <MessageCircle size={20} />
                  </div>
                  <div className="min-w-0 flex-1">
                    <div className="mb-1 flex items-center justify-between gap-2">
                      <h4 className="truncate text-[13px] font-black text-slate-900">{trade.title}</h4>
                      <StatusBadge label={tradeStatusLabel[trade.status]} className={tradeStatusClass[trade.status]} />
                    </div>
                    <p className="text-[11px] font-bold text-slate-500">{trade.lastStateText}</p>
                    <div className="mt-2 flex items-center justify-between">
                      <p className="text-[10px] font-bold text-slate-400">상대방 · {trade.buyerNickname}</p>
                      <div className="flex items-center gap-2">
                        {tradeReadOnlyStatuses.includes(trade.status) && <span className="text-[10px] font-black text-slate-400">read-only</span>}
                        {!!trade.unreadCount && (
                          <div className="flex h-5 min-w-5 items-center justify-center rounded-full bg-red-600 px-1.5 text-[10px] font-black text-white shadow-md">
                            {trade.unreadCount}
                          </div>
                        )}
                      </div>
                    </div>
                  </div>
                </div>
              </CardContainer>
            ))}
          </div>
        </div>
      )}

      {tab === 'SYSTEM' && (
        <div className="bg-slate-50 p-6 pb-28">
          <SectionHeader title="시스템 알림" helper="SYSTEM / PAYMENT / TRADE / COMMUNITY / NOTICE / RESERVATION 카테고리만 사용" leftIcon={BellRing} />
          <div className="space-y-3">
            {systemAlerts.map((alert) => (
              <CardContainer key={alert.id} onClick={() => navigate('system-alert-detail', { id: alert.id })} className="p-5">
                <div className="mb-2 flex items-center gap-2">
                  <StatusBadge label={alert.category} className={notificationCategoryClass[alert.category]} />
                  <span className="text-[9px] font-bold text-slate-400">{alert.time}</span>
                </div>
                <h4 className="text-[13px] font-black text-slate-900">{alert.title}</h4>
                <p className="mt-1 text-[11px] font-medium leading-relaxed text-slate-600">{alert.body}</p>
              </CardContainer>
            ))}
          </div>
        </div>
      )}
    </div>
  );
};
