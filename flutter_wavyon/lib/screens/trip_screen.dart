import 'package:flutter/material.dart';

import '../app/theme.dart';
import '../data/sample_data.dart';
import '../models/app_models.dart';
import '../widgets/design_system.dart';

class TripScreen extends StatefulWidget {
  const TripScreen({
    super.key,
    required this.onNavigate,
  });

  final RouteHandler onNavigate;

  @override
  State<TripScreen> createState() => _TripScreenState();
}

class _TripScreenState extends State<TripScreen> {
  String infoTab = '맛집 정보';
  bool isGuideOpen = false;

  @override
  Widget build(BuildContext context) {
    final previewProducts = infoTab == '맛집 정보' ? foodTripProducts : travelTripProducts;
    final category = infoTab == '맛집 정보' ? 'FOOD' : 'POPUP';

    return Stack(
      children: [
        ListView(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 120),
          children: [
            Text(
              'Trip & Infrastructure',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 20),
            SectionTitle(
              title: '맛집 정보 / 여행 정보',
              subtitle: '상단 탭 리스트도 HOTSPOT 톤의 카드형 미리보기로 노출합니다.',
              action: _MiniGhostButton(
                label: '더보기',
                onTap: () => widget.onNavigate(
                  AppRoute(AppRouteId.tripCategory, title: '카테고리', payload: {'category': category}),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                FilterChipButton(
                  label: '맛집 정보',
                  active: infoTab == '맛집 정보',
                  onTap: () => setState(() => infoTab = '맛집 정보'),
                ),
                const SizedBox(width: 8),
                FilterChipButton(
                  label: '여행 정보',
                  active: infoTab == '여행 정보',
                  onTap: () => setState(() => infoTab = '여행 정보'),
                ),
              ],
            ),
            const SizedBox(height: 14),
            ...previewProducts.map(
              (product) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _ProductCard(
                  product: product,
                  onTap: () => widget.onNavigate(
                    AppRoute(
                      AppRouteId.tripProductDetail,
                      title: product.title,
                      payload: {'id': product.id},
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const SectionTitle(
              title: 'HOTSPOT',
              subtitle: '실시간 트렌드 기반 추천 상품',
              icon: Icons.local_fire_department_rounded,
            ),
            const SizedBox(height: 14),
            ...hotspotTripProducts.map(
              (product) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _ProductCard(
                  product: product,
                  onTap: () => widget.onNavigate(
                    AppRoute(
                      AppRouteId.tripProductDetail,
                      title: product.title,
                      payload: {'id': product.id},
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 14),
            GestureDetector(
              onTap: () => setState(() => isGuideOpen = true),
              child: Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  gradient: WavyonGradients.banner3,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: WavyonShadows.strong,
                ),
                child: Stack(
                  children: [
                    Positioned(
                      right: -8,
                      bottom: -8,
                      child: Icon(
                        Icons.flight_takeoff_rounded,
                        size: 70,
                        color: Colors.white.withOpacity(0.18),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.flight_takeoff_rounded, size: 16, color: Colors.white),
                            SizedBox(width: 8),
                            Text(
                              '인천공항 스마트 가이드',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '항공편 입력 후 설계 기준 정보 모달로 확인합니다.',
                          style: TextStyle(
                            fontSize: 10,
                            height: 1.4,
                            fontWeight: FontWeight.w700,
                            color: Colors.white.withOpacity(0.78),
                          ),
                        ),
                        const SizedBox(height: 14),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.18),
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(color: Colors.white.withOpacity(0.28)),
                                ),
                                child: Text(
                                  '예: KE071',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.white.withOpacity(0.92),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(14),
                                boxShadow: WavyonShadows.card,
                              ),
                              child: const Text(
                                '조회',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w900,
                                  color: WavyonColors.blue,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const SectionTitle(
              title: '카테고리 바로가기',
              subtitle: '제휴 맛집 / 팝업스토어 / K-뷰티는 기존 버튼 구조를 유지합니다.',
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                Expanded(
                  child: _QuickCategoryTile(
                    label: '제휴 맛집',
                    icon: Icons.restaurant_rounded,
                    background: const Color(0xFFFFEDD5),
                    foreground: const Color(0xFFEA580C),
                    onTap: () => widget.onNavigate(
                      const AppRoute(AppRouteId.tripCategory, title: '제휴 맛집'),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _QuickCategoryTile(
                    label: '팝업스토어',
                    icon: Icons.shopping_bag_rounded,
                    background: const Color(0xFFF3E8FF),
                    foreground: const Color(0xFF9333EA),
                    onTap: () => widget.onNavigate(
                      const AppRoute(AppRouteId.tripCategory, title: '팝업스토어'),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _QuickCategoryTile(
                    label: 'K-뷰티',
                    icon: Icons.auto_awesome_rounded,
                    background: const Color(0xFFFCE7F3),
                    foreground: const Color(0xFFDB2777),
                    onTap: () => widget.onNavigate(
                      const AppRoute(AppRouteId.tripCategory, title: 'K-뷰티'),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        if (isGuideOpen) _GuideModal(onClose: () => setState(() => isGuideOpen = false)),
      ],
    );
  }
}

class _ProductCard extends StatelessWidget {
  const _ProductCard({
    required this.product,
    required this.onTap,
  });

  final ProductItem product;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return WavyonCard(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PlaceholderThumb(
            label: product.imageLabel,
            size: 76,
            radius: 18,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BadgeChip(
                  label: product.badge,
                  background: product.badgeBackground,
                  foreground: product.badgeForeground,
                  border: product.badgeBackground,
                ),
                const SizedBox(height: 10),
                Text(
                  product.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 4),
                Text(
                  product.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  product.priceLabel,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w900,
                    color: WavyonColors.text,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickCategoryTile extends StatelessWidget {
  const _QuickCategoryTile({
    required this.label,
    required this.icon,
    required this.background,
    required this.foreground,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final Color background;
  final Color foreground;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: WavyonCard(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        child: Column(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: background,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(icon, size: 18, color: foreground),
            ),
            const SizedBox(height: 10),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w900,
                color: WavyonColors.text,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GuideModal extends StatelessWidget {
  const _GuideModal({required this.onClose});

  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final statusStyle = tradeStatusStyle('ON_SALE');

    return Positioned.fill(
      child: Material(
        color: Colors.black.withOpacity(0.4),
        child: InkWell(
          onTap: onClose,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(30),
                child: Container(
                  width: 398,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: WavyonColors.line),
                    boxShadow: WavyonShadows.strong,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: const [
                                    DecoratedBox(
                                      decoration: BoxDecoration(
                                        color: Color(0xFFEFF6FF),
                                        borderRadius: BorderRadius.all(Radius.circular(12)),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(8),
                                        child: Icon(
                                          Icons.flight_takeoff_rounded,
                                          size: 16,
                                          color: WavyonColors.blue,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      'AIRPORT GUIDE',
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w900,
                                        color: WavyonColors.blue,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                  'KE071 항공편 조회 결과',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w900,
                                    color: WavyonColors.text,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '설계 기준 항공편 관련 정보 모달',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          GestureDetector(
                            onTap: onClose,
                            child: Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                color: const Color(0xFFF8FAFC),
                                borderRadius: BorderRadius.circular(999),
                              ),
                              child: const Icon(
                                Icons.close_rounded,
                                size: 18,
                                color: WavyonColors.muted,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 18),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8FAFC),
                          borderRadius: BorderRadius.circular(22),
                          border: Border.all(color: WavyonColors.line),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '항공편',
                                        style: TextStyle(
                                          fontSize: 9,
                                          fontWeight: FontWeight.w800,
                                          color: WavyonColors.muted,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        '대한항공 KE071',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w900,
                                          color: WavyonColors.text,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                BadgeChip(
                                  label: '정상 운항',
                                  background: statusStyle.background,
                                  foreground: statusStyle.foreground,
                                  border: statusStyle.border,
                                ),
                              ],
                            ),
                            const SizedBox(height: 14),
                            const InfoRow(label: '출발', value: '2026.04.22 13:10'),
                            const InfoRow(label: '터미널', value: 'T2'),
                            const InfoRow(label: '체크인 카운터', value: 'D15 - D22'),
                            const InfoRow(label: '탑승 게이트', value: '248'),
                            const InfoRow(label: '보안검색 권장', value: '출발 2시간 전'),
                          ],
                        ),
                      ),
                      const SizedBox(height: 14),
                      const WavyonCard(
                        child: Text(
                          '셔틀 승차장, 수하물 규정, 체크인 마감, 언어별 공항 안내 문구가 같은 모달 셀 안에서 확장되도록 유지합니다.',
                          style: TextStyle(
                            fontSize: 11,
                            height: 1.5,
                            fontWeight: FontWeight.w700,
                            color: WavyonColors.subtleText,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: WavyonButton(
                              label: '닫기',
                              variant: WavyonButtonVariant.ghost,
                              onPressed: onClose,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: WavyonButton(
                              label: '확인',
                              onPressed: onClose,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _MiniGhostButton extends StatelessWidget {
  const _MiniGhostButton({
    required this.label,
    required this.onTap,
  });

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: const Color(0xFFF8FAFC),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w900,
            color: WavyonColors.subtleText,
          ),
        ),
      ),
    );
  }
}
