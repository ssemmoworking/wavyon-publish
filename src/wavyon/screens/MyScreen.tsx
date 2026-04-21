
import { Camera, Coins, CreditCard, Headset, Receipt, Settings, Ticket, User } from 'lucide-react';

import { myMenu, myProfile } from '../data/mobileData';
import type { Navigate } from '../lib/types';
import { CardContainer, SettingRow } from '../components/primitives';

const iconMap = {
  '내 예약': Receipt,
  '내 티켓': Ticket,
  '결제 / 환불 / 양도': CreditCard,
  '포인트 / 쿠폰': Coins,
  고객센터: Headset,
  설정: Settings,
};

const authProviders = [
  { name: 'Kakao', state: '최근 사용' },
  { name: 'Apple', state: '간편가입 가능' },
  { name: 'Google', state: '간편가입 가능' },
];

export const MyScreen = ({ navigate }: { navigate: Navigate }) => (
  <div className="animate-in fade-in duration-500 p-5 pt-16">
    <div className="mb-5 flex items-center gap-5">
      <div className="group relative flex h-24 w-24 items-center justify-center overflow-hidden rounded-[35px] border-4 border-white bg-slate-100 shadow-xl">
        <User size={40} className="text-slate-300" />
        <div className="absolute inset-0 flex items-center justify-center bg-black/20 opacity-0 transition-opacity group-hover:opacity-100">
          <Camera size={24} className="text-white" />
        </div>
      </div>
      <div className="flex-1">
        <h3 className="mb-1 text-2xl font-black text-slate-900">{myProfile.name}</h3>
        <p className="mb-3 text-[11px] font-bold text-slate-400">{myProfile.email}</p>
        <span className="rounded-md bg-blue-50 px-2.5 py-1 text-[10px] font-black text-blue-700 shadow-sm">{myProfile.verifiedLabel}</span>
      </div>
    </div>

    <CardContainer className="mb-6 p-4">
      <div className="mb-4 flex items-center justify-between">
        <div>
          <p className="text-[10px] font-bold text-slate-400">간편인증 가입 회원</p>
          <h4 className="mt-1 text-[13px] font-black text-slate-900">ID / PW 없이 간편인증 진입 시 바로 가입과 로그인이 함께 완료됩니다.</h4>
        </div>
        <button className="rounded-xl border border-slate-100 bg-slate-50 px-4 py-2 text-[11px] font-black text-slate-600">로그아웃</button>
      </div>
      <div className="space-y-2">
        {authProviders.map((item) => (
          <div key={item.name} className="flex items-center justify-between rounded-[18px] border border-slate-100 bg-slate-50 px-4 py-3">
            <span className="text-[11px] font-black text-slate-800">{item.name}</span>
            <span className={`text-[10px] font-black ${item.state.includes('사용중') ? 'text-blue-700' : 'text-slate-400'}`}>{item.state}</span>
          </div>
        ))}
      </div>
    </CardContainer>

    <div className="overflow-hidden rounded-[35px] border border-slate-50 bg-white shadow-sm">
      {myMenu.map((item) => {
        const Icon = iconMap[item.label as keyof typeof iconMap] ?? User;
        return (
          <div key={item.id} className="border-b border-slate-50 last:border-b-0">
            <SettingRow icon={Icon} label={item.label} count={item.count} onClick={() => item.route && navigate(item.route)} />
          </div>
        );
      })}
    </div>
  </div>
);
