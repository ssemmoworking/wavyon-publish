import 'package:flutter/material.dart';

import '../app/theme.dart';
import '../data/sample_data.dart';
import '../models/app_models.dart';
import '../widgets/design_system.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    required this.onNavigate,
  });

  final RouteHandler onNavigate;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(0, 12, 0, 120),
      children: [
        Padding(
          padding: kScreenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionTitle(
                title: 'My Favorites',
                icon: Icons.star_rounded,
              ),
              const SizedBox(height: 14),
              SizedBox(
                height: 82,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: homeFavorites.length,
                  separatorBuilder: (_, _) => const SizedBox(width: 16),
                  itemBuilder: (context, index) {
                    final favorite = homeFavorites[index];
                    return Column(
                      children: [
                        Container(
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                            color: favorite.backgroundColor,
                            borderRadius: BorderRadius.circular(22),
                            border: Border.all(color: Colors.white, width: 2),
                            boxShadow: WavyonShadows.card,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            favorite.symbol,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w900,
                              color: favorite.foregroundColor,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          favorite.label,
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w900,
                            color: WavyonColors.subtleText,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 22),
        Padding(
          padding: kScreenPadding,
          child: _QrHeroCard(
            onTap: () => onNavigate(const AppRoute(AppRouteId.qrCenter, title: 'QR Center')),
          ),
        ),
        const SizedBox(height: 18),
        const Padding(
          padding: kScreenPadding,
          child: _EventPromoCard(),
        ),
        const SizedBox(height: 24),
        Padding(
          padding: kScreenPadding,
          child: _TrendingCard(
            onTap: () => onNavigate(
              const AppRoute(AppRouteId.communityDetail, title: 'Community Detail'),
            ),
          ),
        ),
        const SizedBox(height: 24),
        Padding(
          padding: kScreenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionTitle(title: 'Live K-pop News'),
              const SizedBox(height: 14),
              ...homeNews.map(
                (news) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _NewsCard(
                    news: news,
                    onTap: () => onNavigate(
                      AppRoute(AppRouteId.newsDetail, title: 'News Detail', payload: {'id': news.id}),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        const Padding(
          padding: kScreenPadding,
          child: _HotDealCard(),
        ),
      ],
    );
  }
}

class _QrHeroCard extends StatelessWidget {
  const _QrHeroCard({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: WavyonGradients.banner1,
          borderRadius: BorderRadius.circular(35),
          boxShadow: WavyonShadows.strong,
        ),
        child: Stack(
          children: [
            Positioned(
              right: -24,
              top: -20,
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.16),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Icon(
                    Icons.qr_code_2_rounded,
                    color: Colors.white.withOpacity(0.92),
                    size: 24,
                  ),
                ),
                const SizedBox(height: 18),
                const Text(
                  'NCT 127 Final Shuttle\n1-seat pickup (Gate 77-234)',
                  style: TextStyle(
                    fontSize: 18,
                    height: 1.22,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 18),
                Container(
                  padding: const EdgeInsets.only(top: 14),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(color: Colors.white.withOpacity(0.22)),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.schedule_rounded,
                        color: Colors.blue.shade100,
                        size: 14,
                      ),
                      const SizedBox(width: 6),
                      const Expanded(
                        child: Text(
                          'Departure planned for 14:00',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFFEFF6FF),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.qr_code_rounded, size: 12, color: Colors.white),
                            SizedBox(width: 4),
                            Text(
                              'Open QR',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _EventPromoCard extends StatelessWidget {
  const _EventPromoCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: WavyonGradients.banner2,
        borderRadius: BorderRadius.circular(25),
        boxShadow: WavyonShadows.strong,
      ),
      child: Stack(
        children: [
          Positioned(
            right: -8,
            bottom: -12,
            child: Icon(
              Icons.auto_awesome_rounded,
              size: 76,
              color: Colors.white.withOpacity(0.18),
            ),
          ),
          Row(
            children: [
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BadgeChip(
                      label: 'EVENT',
                      background: Color(0x33FFFFFF),
                      foreground: Colors.white,
                      border: Color(0x33FFFFFF),
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'SUMMER K-FESTA\nLive reward event',
                      style: TextStyle(
                        fontSize: 15,
                        height: 1.2,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: WavyonShadows.card,
                    ),
                    child: const Text(
                      '30% OFF',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w900,
                        color: WavyonColors.pink,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Icon(
                    Icons.arrow_forward_rounded,
                    size: 18,
                    color: Colors.white,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TrendingCard extends StatelessWidget {
  const _TrendingCard({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: WavyonGradients.dark,
          borderRadius: BorderRadius.circular(30),
          boxShadow: WavyonShadows.strong,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                Icon(Icons.trending_up_rounded, size: 18, color: WavyonColors.amber),
                SizedBox(width: 8),
                Text(
                  'Trending Community Topics',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white.withOpacity(0.12)),
              ),
              child: Column(
                children: homePopularPosts.map((post) {
                  final last = post == homePopularPosts.last;
                  return Padding(
                    padding: EdgeInsets.only(bottom: last ? 0 : 12),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0x33F59E0B),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            '${post.rank}',
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w900,
                              color: Color(0xFFFCD34D),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            post.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NewsCard extends StatelessWidget {
  const _NewsCard({
    required this.news,
    required this.onTap,
  });

  final NewsItem news;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final style = news.tag == 'HOT'
        ? const WavyonBadgeStyle(
            background: Color(0xFFFEF2F2),
            foreground: WavyonColors.red,
            border: Color(0xFFFECACA),
          )
        : const WavyonBadgeStyle(
            background: Color(0xFFEFF6FF),
            foreground: WavyonColors.primary,
            border: Color(0xFFBFDBFE),
          );

    return WavyonCard(
      onTap: onTap,
      child: Row(
        children: [
          const PlaceholderThumb(size: 56, radius: 14),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    BadgeChip(
                      label: news.tag,
                      background: style.background,
                      foreground: style.foreground,
                      border: style.border,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      news.time,
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  news.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HotDealCard extends StatelessWidget {
  const _HotDealCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFFEF2F2),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: const Color(0xFFFECACA)),
        boxShadow: WavyonShadows.card,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: const [
                    Text(
                      'WAVYON HOT DEAL',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                        color: WavyonColors.red,
                      ),
                    ),
                    SizedBox(width: 6),
                    Icon(Icons.local_fire_department_rounded, size: 16, color: WavyonColors.amber),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  homeHotDeal.title,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFFB91C1C),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 46,
            height: 46,
            decoration: const BoxDecoration(
              color: WavyonColors.red,
              shape: BoxShape.circle,
              boxShadow: WavyonShadows.card,
            ),
            child: const Icon(Icons.arrow_forward_rounded, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
