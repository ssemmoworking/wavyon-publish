
import type { LucideIcon } from 'lucide-react';
import { Bell, ChevronRight, CloudSun, Home, Map, MessageCircle, Settings, User, Users } from 'lucide-react';
import type { ReactNode } from 'react';

import type { MainTab } from '../lib/types';
import { cx, wavyonTheme } from '../lib/theme';

export const DeviceFrame = ({ children }: { children: ReactNode }) => (
  <div className="flex min-h-screen items-center justify-center bg-slate-200 p-0 font-sans text-slate-900 sm:p-4">
    <div className="relative flex h-[932px] w-full max-w-[430px] flex-col overflow-hidden rounded-[55px] border-[10px] border-slate-900 bg-white shadow-[0_20px_50px_rgba(0,0,0,0.3)]">
      <div className="pointer-events-none absolute top-0 z-[110] flex w-full items-center justify-between px-10 pt-4 text-xs font-bold text-slate-800">
        <span>9:41</span>
        <div className="flex items-center gap-2">
          <span className="text-[10px]">5G</span>
          <div className="h-[10px] w-5 rounded-[3px] border border-slate-800 p-[1px]">
            <div className="h-full w-full rounded-[1px] bg-slate-800" />
          </div>
        </div>
      </div>
      {children}
    </div>
  </div>
);

export const MainHeader = ({
  unreadCount,
  onOpenSettings,
  onOpenNotifications,
  onOpenWeather,
}: {
  unreadCount: number;
  onOpenSettings: () => void;
  onOpenNotifications: () => void;
  onOpenWeather: () => void;
}) => (
  <header className="z-[100] flex shrink-0 flex-col justify-center border-b border-slate-100 bg-white/95 px-5 pb-2.5 pt-12 backdrop-blur-xl">
    <div className="flex h-10 items-center justify-between">
      <div className="flex items-center">
        <span
          className="text-2xl font-black italic tracking-tighter"
          style={{
            backgroundImage: wavyonTheme.gradients.text,
            WebkitBackgroundClip: 'text',
            WebkitTextFillColor: 'transparent',
          }}
        >
          WAVYON
        </span>
      </div>
      <div className="flex items-center gap-1">
        <button onClick={onOpenSettings} className="rounded-full p-2 text-slate-600 transition-colors hover:bg-slate-50">
          <Settings size={18} />
        </button>
        <button onClick={onOpenNotifications} className="relative rounded-full p-2 text-slate-600 transition-colors hover:bg-slate-50">
          <Bell size={18} />
          {unreadCount > 0 && <div className="absolute right-2 top-2 h-1.5 w-1.5 rounded-full bg-red-600 ring-2 ring-white" />}
        </button>
      </div>
    </div>

    <button
      onClick={onOpenWeather}
      className="mt-2.5 flex w-full items-center justify-between rounded-2xl border border-slate-100 bg-slate-50 px-3.5 py-2 shadow-sm transition-colors hover:bg-slate-100"
    >
      <div className="flex items-center gap-2.5">
        <div className="rounded-xl bg-white p-1.5 shadow-sm">
          <CloudSun size={17} className="text-blue-500" />
        </div>
        <div className="flex items-center gap-1.5 text-left">
          <span className="text-[12px] font-black text-slate-900">서울 (Seoul)</span>
          <span className="text-[11px] font-bold text-blue-600">22°C 맑음</span>
        </div>
      </div>
      <ChevronRight size={16} className="text-slate-400" />
    </button>
  </header>
);

export const SubHeader = ({
  title,
  onBack,
  right,
}: {
  title: string;
  onBack: () => void;
  right?: ReactNode;
}) => (
  <header className="sticky top-0 z-20 flex items-center justify-between border-b border-slate-100 bg-white/95 px-5 pb-3 pt-14 shadow-sm backdrop-blur-md">
    <div className="flex items-center gap-4">
      <button onClick={onBack} className="-ml-2 rounded-full p-2 transition-colors hover:bg-slate-100">
        ←
      </button>
      <h2 className="text-lg font-black">{title}</h2>
    </div>
    {right}
  </header>
);

const navItems: Array<{ id: MainTab; label: string; icon: LucideIcon }> = [
  { id: 'home', label: '홈', icon: Home },
  { id: 'trip', label: 'Trip', icon: Map },
  { id: 'community', label: 'Community', icon: Users },
  { id: 'chat', label: 'Chat', icon: MessageCircle },
  { id: 'my', label: 'My', icon: User },
];

export const BottomNav = ({
  activeTab,
  unreadChatCount,
  onChange,
}: {
  activeTab: MainTab;
  unreadChatCount: number;
  onChange: (tab: MainTab) => void;
}) => (
  <nav className="absolute bottom-0 z-[150] flex h-[95px] w-full items-center justify-around border-t border-slate-100 bg-white/95 px-4 pb-6 backdrop-blur-2xl shadow-[0_-10px_20px_rgba(0,0,0,0.03)]">
    {navItems.map((item) => {
      const active = item.id === activeTab;
      const Icon = item.icon;
      return (
        <button
          key={item.id}
          onClick={() => onChange(item.id)}
          className={cx('relative flex flex-col items-center gap-1 transition-all', active ? 'scale-110' : 'opacity-30')}
        >
          <div className={cx('relative rounded-2xl p-2.5', active && 'bg-blue-50 shadow-sm')}>
            <Icon size={22} className={active ? 'text-blue-700' : 'text-slate-700'} strokeWidth={active ? 3 : 2} />
            {item.id === 'chat' && unreadChatCount > 0 && (
              <span className="absolute -right-1 -top-1 flex h-4 w-4 items-center justify-center rounded-full border-2 border-white bg-red-600 text-[8px] font-black text-white shadow-sm">
                {unreadChatCount}
              </span>
            )}
          </div>
          <span className={cx('text-[10px] font-black', active ? 'text-blue-700' : 'text-slate-600')}>{item.label}</span>
        </button>
      );
    })}
  </nav>
);

export const MainScrollArea = ({ children }: { children: ReactNode }) => (
  <div className="relative flex-1 overflow-hidden">
    <main className="h-full overflow-y-auto bg-[#FBFBFF] pb-[118px]">{children}</main>
  </div>
);
