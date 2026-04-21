
import { useMemo, useState } from 'react';

import { BottomNav, DeviceFrame, MainHeader, MainScrollArea } from './components/layout';
import { ChatScreen } from './screens/ChatScreen';
import { CommunityScreen } from './screens/CommunityScreen';
import { HomeScreen } from './screens/HomeScreen';
import { MyScreen } from './screens/MyScreen';
import { SubScreenRouter } from './screens/SubScreens';
import { TripScreen } from './screens/TripScreen';
import type { MainTab, RouteState } from './lib/types';

const initialTab: MainTab = 'home';

const WavyonMobileFinalPublishing = () => {
  const [activeTab, setActiveTab] = useState<MainTab>(initialTab);
  const [route, setRoute] = useState<RouteState | null>(null);

  const unreadNotifications = 3;
  const unreadChats = 3;

  const navigate = (id: RouteState['id'], params?: Record<string, unknown>) => setRoute({ id, params });
  const goBack = () => setRoute(null);

  const content = useMemo(() => {
    switch (activeTab) {
      case 'home':
        return <HomeScreen onOpenQr={() => navigate('qr-center')} navigate={navigate} />;
      case 'trip':
        return <TripScreen navigate={navigate} />;
      case 'community':
        return <CommunityScreen navigate={navigate} />;
      case 'chat':
        return <ChatScreen navigate={navigate} />;
      case 'my':
        return <MyScreen navigate={navigate} />;
      default:
        return <HomeScreen onOpenQr={() => navigate('qr-center')} navigate={navigate} />;
    }
  }, [activeTab]);

  return (
    <DeviceFrame>
      {route ? (
        <div className="absolute inset-0 z-[200] h-full w-full bg-white animate-in slide-in-from-right duration-300">
          <SubScreenRouter route={route} onBack={goBack} navigate={navigate} />
        </div>
      ) : (
        <>
          <MainHeader
            unreadCount={unreadNotifications}
            onOpenNotifications={() => navigate('notifications')}
            onOpenSettings={() => navigate('settings')}
            onOpenWeather={() => navigate('weather')}
          />
          <MainScrollArea>{content}</MainScrollArea>
          <BottomNav activeTab={activeTab} unreadChatCount={unreadChats} onChange={setActiveTab} />
        </>
      )}
    </DeviceFrame>
  );
};

export default WavyonMobileFinalPublishing;
