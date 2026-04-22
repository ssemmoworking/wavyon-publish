import 'package:flutter/material.dart';

import '../data/sample_data.dart';
import '../models/app_models.dart';
import '../widgets/design_system.dart';

class MyScreen extends StatelessWidget {
  const MyScreen({
    super.key,
    required this.onNavigate,
  });

  final RouteHandler onNavigate;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 120),
      children: [
        Row(
          children: [
            Container(
              width: 92,
              height: 92,
              decoration: BoxDecoration(
                color: const Color(0xFFF1F5F9),
                borderRadius: BorderRadius.circular(32),
              ),
              child: const Icon(Icons.person_rounded, size: 44, color: Color(0xFF94A3B8)),
            ),
            const SizedBox(width: 16),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('KIM WAVY', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900)),
                  SizedBox(height: 4),
                  Text('wavy_fan_912@service.com', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF64748B))),
                  SizedBox(height: 10),
                  BadgeChip(label: 'Verified member', color: Colors.blue, foreground: Colors.blue),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        WavyonCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Simple login provider status block'),
              const SizedBox(height: 12),
              ...const [
                _AuthRow(name: 'Kakao', state: 'Recently used'),
                _AuthRow(name: 'Apple', state: 'Available'),
                _AuthRow(name: 'Google', state: 'Available'),
              ],
            ],
          ),
        ),
        const SizedBox(height: 20),
        WavyonCard(
          padding: EdgeInsets.zero,
          child: Column(
            children: myMenuEntries
                .map(
                  (entry) => ListTile(
                    onTap: () => onNavigate(AppRoute(entry.routeId, title: entry.label)),
                    leading: Icon(entry.icon),
                    title: Text(entry.label, style: const TextStyle(fontWeight: FontWeight.w800)),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (entry.count != null)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF1F5F9),
                              borderRadius: BorderRadius.circular(999),
                            ),
                            child: Text('${entry.count}', style: const TextStyle(fontWeight: FontWeight.w800)),
                          ),
                        const SizedBox(width: 8),
                        const Icon(Icons.chevron_right_rounded),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}

class _AuthRow extends StatelessWidget {
  const _AuthRow({
    required this.name,
    required this.state,
  });

  final String name;
  final String state;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Expanded(child: Text(name, style: const TextStyle(fontWeight: FontWeight.w800))),
          Text(state, style: const TextStyle(fontWeight: FontWeight.w800, color: Colors.blue)),
        ],
      ),
    );
  }
}
