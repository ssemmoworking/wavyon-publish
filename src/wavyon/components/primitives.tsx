
import type { LucideIcon } from 'lucide-react';
import {
  AlertTriangle,
  ChevronRight,
  Image as ImageIcon,
  Info,
  Search,
  SlidersHorizontal,
} from 'lucide-react';
import type { ReactNode } from 'react';

import { cx } from '../lib/theme';

type CardContainerProps = {
  children: ReactNode;
  className?: string;
  onClick?: () => void;
};

export const CardContainer = ({ children, className, onClick }: CardContainerProps) => (
  <div
    onClick={onClick}
    className={cx(
      'bg-white border border-slate-100 rounded-[24px] shadow-sm',
      onClick && 'cursor-pointer active:scale-[0.98] transition-transform',
      className,
    )}
  >
    {children}
  </div>
);

export const SectionHeader = ({
  title,
  helper,
  leftIcon: Icon,
  action,
}: {
  title: string;
  helper?: string;
  leftIcon?: LucideIcon;
  action?: ReactNode;
}) => (
  <div className="mb-3 flex items-end justify-between">
    <div>
      <h3 className="flex items-center gap-2 text-[12px] font-black text-slate-800">
        {Icon && <Icon size={16} className="text-blue-700" />}
        {title}
      </h3>
      {helper && <p className="mt-1 text-[10px] font-bold text-slate-400">{helper}</p>}
    </div>
    {action}
  </div>
);

export const StatusBadge = ({
  label,
  className,
}: {
  label: string;
  className: string;
}) => (
  <span className={cx('inline-flex items-center rounded-md px-2 py-0.5 text-[9px] font-black shadow-sm', className)}>
    {label}
  </span>
);

export const FilterChip = ({
  label,
  active,
  onClick,
}: {
  label: string;
  active?: boolean;
  onClick?: () => void;
}) => (
  <button
    onClick={onClick}
    className={cx(
      'whitespace-nowrap rounded-full border px-3.5 py-1.5 text-[11px] font-black transition-all',
      active
        ? 'bg-blue-800 text-white border-blue-800 shadow-md'
        : 'bg-white text-slate-600 border-slate-200 hover:bg-slate-50',
    )}
  >
    {label}
  </button>
);

export const SegmentTabs = <T extends string>({
  items,
  value,
  onChange,
}: {
  items: Array<{ value: T; label: string }>;
  value: T;
  onChange: (value: T) => void;
}) => (
  <div className="flex gap-2 rounded-[22px] border border-slate-100 bg-white p-1.5 shadow-sm">
    {items.map((item) => (
      <button
        key={item.value}
        onClick={() => onChange(item.value)}
        className={cx(
          'flex-1 rounded-[16px] px-3 py-2.5 text-[11px] font-black transition-all',
          value === item.value
            ? 'bg-blue-700 text-white shadow-md'
            : 'text-slate-500 hover:bg-slate-50',
        )}
      >
        {item.label}
      </button>
    ))}
  </div>
);


export const ListSearchBar = ({
  placeholder = '검색어를 입력하세요',
  withFilter,
  className,
}: {
  placeholder?: string;
  withFilter?: boolean;
  className?: string;
}) => (
  <div className={cx('rounded-[22px] border border-slate-100 bg-white p-2.5 shadow-sm', className)}>
    <div className="flex items-center gap-2">
      <div className="flex flex-1 items-center gap-2 rounded-[16px] border border-slate-100 bg-slate-50 px-3 py-2.5">
        <Search size={16} className="text-slate-400" />
        <input
          type="text"
          placeholder={placeholder}
          className="flex-1 bg-transparent text-xs font-black text-slate-700 placeholder:text-slate-400 focus:outline-none"
        />
      </div>
      {withFilter && (
        <button className="rounded-[18px] border border-slate-100 bg-slate-50 p-3 text-slate-500 transition-colors hover:bg-slate-100">
          <SlidersHorizontal size={16} />
        </button>
      )}
    </div>
  </div>
);

export const EmptyState = ({
  title,
  description,
  icon: Icon = Info,
}: {
  title: string;
  description: string;
  icon?: LucideIcon;
}) => (
  <CardContainer className="p-8 text-center">
    <div className="mx-auto mb-3 flex h-14 w-14 items-center justify-center rounded-[20px] bg-slate-50 text-slate-400">
      <Icon size={24} />
    </div>
    <h4 className="text-[13px] font-black text-slate-800">{title}</h4>
    <p className="mt-2 text-[11px] font-bold text-slate-400 leading-relaxed">{description}</p>
  </CardContainer>
);

export const CTAButton = ({
  children,
  className,
  onClick,
  variant = 'primary',
}: {
  children: ReactNode;
  className?: string;
  onClick?: () => void;
  variant?: 'primary' | 'secondary' | 'ghost';
}) => (
  <button
    onClick={onClick}
    className={cx(
      'rounded-[20px] px-5 py-4 text-sm font-black transition-transform active:scale-95',
      variant === 'primary' && 'bg-blue-800 text-white shadow-xl shadow-blue-900/20',
      variant === 'secondary' && 'bg-slate-900 text-white shadow-xl shadow-slate-200',
      variant === 'ghost' && 'bg-slate-50 text-slate-700 border border-slate-100',
      className,
    )}
  >
    {children}
  </button>
);

export const InfoRow = ({
  label,
  value,
  emphasize,
}: {
  label: string;
  value: string;
  emphasize?: boolean;
}) => (
  <div className="flex items-center justify-between gap-4 text-xs font-bold">
    <span className="text-slate-400">{label}</span>
    <span className={cx('text-right text-slate-900', emphasize && 'text-blue-800 font-black')}>{value}</span>
  </div>
);

export const ImagePlaceholder = ({
  label = 'IMAGE',
  className,
}: {
  label?: string;
  className?: string;
}) => (
  <div className={cx('flex items-center justify-center rounded-[18px] bg-slate-100 text-slate-300', className)}>
    <div className="flex flex-col items-center gap-1">
      <ImageIcon size={20} />
      <span className="text-[8px] font-black tracking-wider">{label}</span>
    </div>
  </div>
);

export const ChatBubble = ({
  kind,
  text,
  sender,
  time,
}: {
  kind: 'me' | 'other' | 'system';
  text: string;
  sender?: string;
  time?: string;
}) => {
  if (kind === 'system') {
    return (
      <div className="flex justify-center">
        <div className="rounded-full bg-slate-200 px-3 py-1 text-[9px] font-black text-slate-500">
          {text}
        </div>
      </div>
    );
  }

  if (kind === 'me') {
    return (
      <div className="flex justify-end gap-3">
        <div className="max-w-[80%] rounded-[22px] rounded-tr-none bg-blue-800 p-4 text-[13px] font-bold text-white shadow-md">
          {text}
        </div>
      </div>
    );
  }

  return (
    <div className="flex gap-3">
      <div className="h-8 w-8 flex-shrink-0 rounded-full bg-blue-100 text-[10px] font-black text-blue-800 flex items-center justify-center">
        {sender?.slice(0, 1) ?? 'W'}
      </div>
      <div>
        <div className="mb-1 flex items-center gap-2">
          <span className="text-[11px] font-black text-slate-700">{sender}</span>
          {time && <span className="text-[9px] font-bold text-slate-400">{time}</span>}
        </div>
        <div className="max-w-[80vw] rounded-[22px] rounded-tl-none border border-slate-100 bg-white p-4 text-[13px] font-bold text-slate-800 shadow-sm sm:max-w-[80%]">
          {text}
        </div>
      </div>
    </div>
  );
};

export const BottomFixedActionBar = ({ children }: { children: ReactNode }) => (
  <div className="absolute bottom-0 z-30 w-full border-t border-slate-100 bg-white/95 p-4 pb-8 shadow-[0_-10px_20px_rgba(0,0,0,0.03)] backdrop-blur-md">
    <div className="flex gap-3">{children}</div>
  </div>
);

export const ModalShell = ({
  children,
  onClose,
}: {
  children: ReactNode;
  onClose: () => void;
}) => (
  <div className="absolute inset-0 z-[400] flex items-center justify-center p-6 animate-in fade-in duration-200">
    <div className="absolute inset-0 bg-slate-900/70 backdrop-blur-sm" onClick={onClose} />
    <div className="relative z-10 w-full rounded-[40px] bg-white p-8 shadow-2xl">{children}</div>
  </div>
);

export const InlineNotice = ({
  title,
  description,
  danger,
}: {
  title: string;
  description: string;
  danger?: boolean;
}) => (
  <div
    className={cx(
      'flex gap-3 rounded-[24px] border p-4 shadow-sm',
      danger ? 'border-red-100 bg-red-50 text-red-900' : 'border-blue-100 bg-blue-50 text-blue-900',
    )}
  >
    {danger ? <AlertTriangle size={18} className="mt-0.5 flex-shrink-0" /> : <Info size={18} className="mt-0.5 flex-shrink-0" />}
    <div>
      <h4 className="text-[11px] font-black">{title}</h4>
      <p className="mt-1 text-[10px] font-bold leading-relaxed opacity-80">{description}</p>
    </div>
  </div>
);

export const SettingRow = ({
  icon: Icon,
  label,
  count,
  onClick,
}: {
  icon: LucideIcon;
  label: string;
  count?: number;
  onClick?: () => void;
}) => (
  <button
    onClick={onClick}
    className="flex w-full items-center justify-between p-4 text-left transition-colors active:bg-slate-50"
  >
    <div className="flex items-center gap-4">
      <div className="rounded-xl bg-slate-50 p-2 text-slate-600">
        <Icon size={18} />
      </div>
      <span className="text-[13px] font-black text-slate-700">{label}</span>
    </div>
    <div className="flex items-center gap-2">
      {typeof count === 'number' && (
        <span className="rounded-full bg-slate-100 px-2 py-0.5 text-[10px] font-black text-slate-400">
          {count}
        </span>
      )}
      <ChevronRight size={16} className="text-slate-200" />
    </div>
  </button>
);
