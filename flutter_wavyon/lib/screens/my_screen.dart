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
    final visibleEntries = mySignedIn
        ? myMenuEntries
        : myMenuEntries
            .where(
              (entry) => entry.routeId == AppRouteId.support || entry.routeId == AppRouteId.settings,
            )
            .toList(growable: false);

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 120),
      children: [
        if (mySignedIn) ...[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 96,
                height: 96,
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(32),
                  border: Border.all(color: Colors.white, width: 4),
                  boxShadow: WavyonShadows.strong,
                ),
                child: const Icon(
                  Icons.person_outline_rounded,
                  size: 46,
                  color: WavyonColors.muted,
                ),
              ),
              const SizedBox(width: 18),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'KIM WAVY',
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w900,
                        color: WavyonColors.text,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'wavy_fan_912@service.com',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        color: WavyonColors.muted,
                      ),
                    ),
                    SizedBox(height: 14),
                    BadgeChip(
                      label: '본인인증 완료 회원',
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
        ] else ...[
          WavyonCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '간편인증 가입 회원',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w800,
                              color: WavyonColors.muted,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'ID / PW 없이 간편인증 진입 시 바로 가입과 로그인이 함께 완료됩니다.',
                            style: TextStyle(
                              fontSize: 13,
                              height: 1.45,
                              fontWeight: FontWeight.w900,
                              color: WavyonColors.text,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    const _MiniActionButton(label: '로그아웃'),
                  ],
                ),
                const SizedBox(height: 16),
                ...myAuthProviders.map(
                  (provider) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
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
                              color: provider.isActive ? WavyonColors.muted : const Color(0xFF94A3B8),
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
        ],
        WavyonCard(
          padding: EdgeInsets.zero,
          radius: 35,
          child: Column(
            children: [
              for (final entry in visibleEntries) ...[
                SettingRow(
                  icon: entry.icon,
                  label: entry.label,
                  count: entry.count,
                  onTap: () => onNavigate(AppRoute(entry.routeId, title: entry.label)),
                ),
                if (entry != visibleEntries.last)
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
        color: Colors.white,
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
