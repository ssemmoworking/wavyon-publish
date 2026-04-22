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
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 120),
      children: [
        const SectionTitle(title: 'My Favorites', icon: Icons.star_rounded),
        const SizedBox(height: 14),
        SizedBox(
          height: 96,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: homeFavorites.length,
            separatorBuilder: (_, _) => const SizedBox(width: 14),
            itemBuilder: (context, index) {
              final item = homeFavorites[index];
              return Column(
                children: [
                  Container(
                    width: 58,
                    height: 58,
                    decoration: BoxDecoration(
                      color: item.color,
                      borderRadius: BorderRadius.circular(22),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      item.symbol,
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(item.label, style: Theme.of(context).textTheme.bodyMedium),
                ],
              );
            },
          ),
        ),
        const SizedBox(height: 24),
        _HeroCard(
          title: 'NCT 127 Final Shuttle',
          subtitle: 'Airport pickup | 2 seats | 3:00 PM',
          action: 'Open QR',
          colors: const [Color(0xFF1E3A8A), Color(0xFF4338CA), Color(0xFF9333EA)],
          icon: Icons.qr_code_rounded,
          onTap: () => onNavigate(const AppRoute(AppRouteId.qrCenter, title: 'QR Center')),
        ),
        const SizedBox(height: 18),
        const _HeroCard(
          title: 'SUMMER K-FESTA',
          subtitle: 'Design draft promo block for event and campaign areas',
          action: '30% OFF',
          colors: [Color(0xFF8B5CF6), Color(0xFFEC4899), Color(0xFFF43F5E)],
          icon: Icons.auto_awesome_rounded,
        ),
        const SizedBox(height: 24),
        _HeroCard(
          title: 'Trending Community Topics',
          subtitle: 'Tap to open the highlighted discussion flow',
          action: 'View',
          colors: const [Color(0xFF0F172A), Color(0xFF1E1B4B)],
          icon: Icons.trending_up_rounded,
          onTap: () => onNavigate(const AppRoute(AppRouteId.communityDetail, title: 'Community Detail')),
        ),
        const SizedBox(height: 24),
        const SectionTitle(title: 'Live K-pop News'),
        const SizedBox(height: 14),
        ...homeNews.map(
          (news) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: WavyonCard(
              onTap: () => onNavigate(
                AppRoute(AppRouteId.newsDetail, title: 'News Detail', payload: {'id': news.id}),
              ),
              child: Row(
                children: [
                  const PlaceholderThumb(size: 60),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            BadgeChip(
                              label: news.tag,
                              color: news.tag == 'HOT' ? WavyonColors.red : WavyonColors.blue,
                            ),
                            const SizedBox(width: 8),
                            Text(news.time, style: Theme.of(context).textTheme.bodyMedium),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(news.title, style: Theme.of(context).textTheme.titleMedium),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        WavyonCard(
          child: Row(
            children: [
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'WAVYON HOT DEAL',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900, color: WavyonColors.red),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'K-beauty package and trip-linked promotion area',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFFB91C1C)),
                    ),
                  ],
                ),
              ),
              Container(
                width: 46,
                height: 46,
                decoration: const BoxDecoration(color: WavyonColors.red, shape: BoxShape.circle),
                child: const Icon(Icons.arrow_forward_rounded, color: Colors.white),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _HeroCard extends StatelessWidget {
  const _HeroCard({
    required this.title,
    required this.subtitle,
    required this.action,
    required this.colors,
    required this.icon,
    this.onTap,
  });

  final String title;
  final String subtitle;
  final String action;
  final List<Color> colors;
  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(32),
      child: Ink(
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          gradient: LinearGradient(colors: colors),
          boxShadow: const [
            BoxShadow(
              color: Color(0x190F172A),
              blurRadius: 30,
              offset: Offset(0, 16),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Icon(icon, color: Colors.white.withOpacity(0.9)),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 21,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: TextStyle(
                color: Colors.white.withOpacity(0.84),
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 18),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.18),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                action,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
