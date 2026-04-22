import 'package:flutter/material.dart';

import '../data/sample_data.dart';
import '../models/app_models.dart';
import '../widgets/design_system.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({
    super.key,
    required this.onNavigate,
  });

  final RouteHandler onNavigate;

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  final boards = const ['NCT 127', 'Trade', 'Concert Info', 'Free Board'];
  String selectedBoard = 'NCT 127';

  @override
  Widget build(BuildContext context) {
    final isTrade = selectedBoard == 'Trade';

    return Stack(
      children: [
        ListView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 140),
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(selectedBoard, style: Theme.of(context).textTheme.headlineMedium),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(color: const Color(0xFFE8ECF4)),
                  ),
                  child: const Text('3-depth', style: TextStyle(fontWeight: FontWeight.w800)),
                ),
              ],
            ),
            const SizedBox(height: 14),
            SizedBox(
              height: 42,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: boards.length,
                separatorBuilder: (_, _) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final board = boards[index];
                  final active = board == selectedBoard;
                  return ChoiceChip(
                    label: Text(board),
                    selected: active,
                    onSelected: (_) => setState(() => selectedBoard = board),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            const AppTextField(hint: 'Search board', icon: Icons.search_rounded),
            const SizedBox(height: 20),
            if (!isTrade)
              WavyonCard(
                onTap: () => widget.onNavigate(const AppRoute(AppRouteId.liveChatList, title: 'Live Chat')),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Live Thread', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w900, color: Colors.white70)),
                    SizedBox(height: 8),
                    Text(
                      'Realtime discussion banner',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                    ),
                    SizedBox(height: 6),
                    Text('Converted into a simple entry point for the live chat list.'),
                  ],
                ),
              ),
            if (!isTrade) const SizedBox(height: 20),
            SectionTitle(
              title: isTrade ? 'Trade Feed' : 'Board Feed',
              icon: isTrade ? Icons.sell_rounded : Icons.forum_rounded,
              action: TextButton(
                onPressed: () => widget.onNavigate(
                  AppRoute(
                    isTrade ? AppRouteId.tradeWrite : AppRouteId.fandomWrite,
                    title: isTrade ? 'Trade Write' : 'Board Write',
                  ),
                ),
                child: const Text('Write'),
              ),
            ),
            const SizedBox(height: 14),
            if (isTrade)
              ...tradeItems.map(
                (item) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: WavyonCard(
                    onTap: () => widget.onNavigate(AppRoute(AppRouteId.tradeDetail, title: item.title, payload: {'id': item.id})),
                    child: Row(
                      children: [
                        const PlaceholderThumb(size: 70),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BadgeChip(label: item.status, color: Colors.blue, foreground: Colors.blue),
                              const SizedBox(height: 8),
                              Text(item.title, style: Theme.of(context).textTheme.titleMedium),
                              const SizedBox(height: 4),
                              Text(item.price, style: const TextStyle(fontWeight: FontWeight.w900)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            else
              ...communityPosts.map(
                (post) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: WavyonCard(
                    onTap: () => widget.onNavigate(const AppRoute(AppRouteId.communityDetail, title: 'Community Detail')),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BadgeChip(label: post.tag, color: Colors.blue, foreground: Colors.blue),
                        const SizedBox(height: 10),
                        Text(post.title, style: Theme.of(context).textTheme.titleMedium),
                        const SizedBox(height: 8),
                        Text('${post.author} | ${post.meta}', style: Theme.of(context).textTheme.bodyMedium),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
        Positioned(
          right: 20,
          bottom: 104,
          child: FloatingActionButton.extended(
            onPressed: () => widget.onNavigate(
              AppRoute(
                isTrade ? AppRouteId.tradeWrite : AppRouteId.fandomWrite,
                title: isTrade ? 'Trade Write' : 'Board Write',
              ),
            ),
            label: const Text('Write'),
            icon: const Icon(Icons.edit_rounded),
          ),
        ),
      ],
    );
  }
}
