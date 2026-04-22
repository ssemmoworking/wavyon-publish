import 'package:flutter/material.dart';

import '../data/sample_data.dart';
import '../models/app_models.dart';
import '../widgets/design_system.dart';

class TripScreen extends StatelessWidget {
  const TripScreen({
    super.key,
    required this.onNavigate,
  });

  final RouteHandler onNavigate;

  @override
  Widget build(BuildContext context) {
    final hotspot = tripProducts.where((item) => item.category == 'HOTSPOT').toList();
    final preview = tripProducts.where((item) => item.category != 'HOTSPOT').take(3).toList();

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 120),
      children: [
        Text('Trip & Infrastructure', style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 20),
        SectionTitle(
          title: 'Preview Categories',
          subtitle: 'Food, popup, and beauty sections from the original draft',
          action: TextButton(
            onPressed: () => onNavigate(const AppRoute(AppRouteId.tripCategory, title: 'Trip Category')),
            child: const Text('More'),
          ),
        ),
        const SizedBox(height: 14),
        ...preview.map((product) => _ProductCard(product: product, onNavigate: onNavigate)),
        const SizedBox(height: 24),
        const SectionTitle(
          title: 'HOTSPOT',
          subtitle: 'Recommended items based on the design draft structure',
          icon: Icons.local_fire_department_rounded,
        ),
        const SizedBox(height: 14),
        ...hotspot.map((product) => _ProductCard(product: product, onNavigate: onNavigate)),
        const SizedBox(height: 24),
        WavyonCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(Icons.flight_takeoff_rounded, color: Colors.blue),
                  SizedBox(width: 8),
                  Text('Airport Guide Lookup', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w900)),
                ],
              ),
              const SizedBox(height: 10),
              const Text('Basic modal in React was converted into a simple lookup block for Flutter.'),
              const SizedBox(height: 14),
              const AppTextField(hint: 'Flight number, e.g. KE071', icon: Icons.search_rounded),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: PrimaryButton(
                      label: 'Open Guide',
                      onPressed: () => onNavigate(const AppRoute(AppRouteId.weather, title: 'Airport Guide')),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        const SectionTitle(title: 'Quick Categories'),
        const SizedBox(height: 14),
        Row(
          children: [
            _QuickCategory(label: 'Food', icon: Icons.restaurant_rounded, onTap: () => onNavigate(const AppRoute(AppRouteId.tripCategory, title: 'Food'))),
            const SizedBox(width: 12),
            _QuickCategory(label: 'Popup', icon: Icons.shopping_bag_rounded, onTap: () => onNavigate(const AppRoute(AppRouteId.tripCategory, title: 'Popup'))),
            const SizedBox(width: 12),
            _QuickCategory(label: 'Beauty', icon: Icons.auto_awesome_rounded, onTap: () => onNavigate(const AppRoute(AppRouteId.tripCategory, title: 'Beauty'))),
          ],
        ),
      ],
    );
  }
}

class _ProductCard extends StatelessWidget {
  const _ProductCard({
    required this.product,
    required this.onNavigate,
  });

  final ProductItem product;
  final RouteHandler onNavigate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: WavyonCard(
        onTap: () => onNavigate(
          AppRoute(AppRouteId.tripProductDetail, title: product.title, payload: {'id': product.id}),
        ),
        child: Row(
          children: [
            const PlaceholderThumb(size: 78),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BadgeChip(label: product.badge, color: product.badgeColor, foreground: product.badgeColor),
                  const SizedBox(height: 8),
                  Text(product.title, style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 6),
                  Text(product.description, style: Theme.of(context).textTheme.bodyMedium),
                  const SizedBox(height: 8),
                  Text(product.price, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w900)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickCategory extends StatelessWidget {
  const _QuickCategory({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Ink(
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: const Color(0xFFE8ECF4)),
          ),
          child: Column(
            children: [
              Icon(icon, color: Colors.blue),
              const SizedBox(height: 10),
              Text(label, style: const TextStyle(fontWeight: FontWeight.w800)),
            ],
          ),
        ),
      ),
    );
  }
}
