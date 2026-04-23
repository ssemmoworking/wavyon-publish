import 'package:flutter/material.dart';

import '../app/theme.dart';
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
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 120),
      children: [
        Row(
          children: [
            Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                color: const Color(0xFFF1F5F9),
                borderRadius: BorderRadius.circular(35),
                border: Border.all(color: Colors.white, width: 4),
                boxShadow: WavyonShadows.strong,
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  const Center(
                    child: Icon(
                      Icons.person_rounded,
                      size: 44,
                      color: WavyonColors.muted,
                    ),
                  ),
                  Positioned(
                    right: -4,
                    bottom: -4,
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: WavyonColors.ink,
                        borderRadius: BorderRadius.circular(999),
                        border: Border.all(color: Colors.white, width: 3),
                        boxShadow: WavyonShadows.card,
                      ),
                      child: const Icon(
                        Icons.photo_camera_outlined,
                        size: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 18),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'KIM WAVY',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                      color: WavyonColors.text,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'wavy_fan_912@service.com',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      color: WavyonColors.muted,
                    ),
                  ),
                  SizedBox(height: 12),
                  BadgeChip(
                    label: 'Verified member',
                    background: Color(0xFFEFF6FF),
                    foreground: WavyonColors.blue,
                    border: Color(0xFFBFDBFE),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  ),
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
              Row(
                children: [
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Simple login member status',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                            color: WavyonColors.muted,
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          'Quick access without ID/PW remains visible as its own status block.',
                          style: TextStyle(
                            fontSize: 13,
                            height: 1.4,
                            fontWeight: FontWeight.w900,
                            color: WavyonColors.text,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 12),
                  _MiniActionButton(label: 'Log out'),
                ],
              ),
              const SizedBox(height: 14),
              ...myAuthProviders.map(
                (provider) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: WavyonColors.line),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            provider.name,
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w900,
                              color: WavyonColors.text,
                            ),
                          ),
                        ),
                        Text(
                          provider.state,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w900,
                            color: provider.isActive ? WavyonColors.blue : WavyonColors.muted,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        WavyonCard(
          padding: EdgeInsets.zero,
          radius: 35,
          child: Column(
            children: [
              for (final entry in myMenuEntries) ...[
                SettingRow(
                  icon: entry.icon,
                  label: entry.label,
                  count: entry.count,
                  onTap: () => onNavigate(AppRoute(entry.routeId, title: entry.label)),
                ),
                if (entry != myMenuEntries.last)
                  const Divider(height: 1, color: WavyonColors.line),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _MiniActionButton extends StatelessWidget {
  const _MiniActionButton({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: WavyonColors.line),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w900,
          color: WavyonColors.subtleText,
        ),
      ),
    );
  }
}
