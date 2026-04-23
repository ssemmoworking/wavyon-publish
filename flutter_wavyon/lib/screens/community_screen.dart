import 'package:flutter/material.dart';

import '../app/theme.dart';
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
  String selectedBoard = 'NCT 127';
  bool isDropdownOpen = false;

  bool get isArtistBoard => artistBoards.contains(selectedBoard);
  bool get isTradeBoard => selectedBoard == 'Trade';
  bool get isConcertInfoBoard => selectedBoard == '공연정보';
  bool get isLiveNewsBoard => selectedBoard == '실시간 뉴스';
  bool get isFreeBoard => selectedBoard == '자유게시판';

  void selectBoard(String board) {
    setState(() {
      selectedBoard = board;
      isDropdownOpen = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(bottom: BorderSide(color: WavyonColors.line)),
                boxShadow: WavyonShadows.card,
              ),
              padding: const EdgeInsets.fromLTRB(20, 18, 20, 16),
              child: Column(
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => setState(() => isDropdownOpen = !isDropdownOpen),
                        child: Row(
                          children: [
                            Text(
                              selectedBoard,
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                            const SizedBox(width: 6),
                            AnimatedRotation(
                              turns: isDropdownOpen ? 0.5 : 0,
                              duration: const Duration(milliseconds: 180),
                              child: const Icon(
                                Icons.expand_more_rounded,
                                size: 24,
                                color: WavyonColors.text,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8FAFC),
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: const Text(
                          '3depth',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w900,
                            color: WavyonColors.subtleText,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  SizedBox(
                    height: 38,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: favoriteBoards.length,
                      separatorBuilder: (_, _) => const SizedBox(width: 8),
                      itemBuilder: (context, index) {
                        final board = favoriteBoards[index];
                        return FilterChipButton(
                          label: board,
                          active: selectedBoard == board,
                          onTap: () => selectBoard(board),
                        );
                      },
                    ),
                  ),
                  if (!isArtistBoard) ...[
                    const SizedBox(height: 14),
                    SearchBarCard(
                      placeholder: '$selectedBoard 게시판 검색',
                    ),
                  ],
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 18, 20, 130),
                children: _buildContent(context),
              ),
            ),
          ],
        ),
        if (isDropdownOpen) ...[
          Positioned.fill(
            child: GestureDetector(
              onTap: () => setState(() => isDropdownOpen = false),
              child: Container(color: Colors.transparent),
            ),
          ),
          Positioned(
            left: 20,
            top: 74,
            child: _BoardDropdown(
              selectedBoard: selectedBoard,
              onSelect: selectBoard,
            ),
          ),
        ],
        if (isTradeBoard || isArtistBoard || isFreeBoard)
          Positioned(
            right: 20,
            bottom: 100,
            child: GestureDetector(
              onTap: () => widget.onNavigate(
                AppRoute(
                  isTradeBoard ? AppRouteId.tradeWrite : AppRouteId.fandomWrite,
                  title: isTradeBoard ? '거래글 작성' : '게시글 작성',
                  payload: {'board': selectedBoard},
                ),
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  gradient: WavyonGradients.dark,
                  borderRadius: BorderRadius.circular(999),
                  boxShadow: WavyonShadows.strong,
                ),
                child: Row(
                  children: const [
                    Icon(Icons.edit_outlined, size: 14, color: Colors.white),
                    SizedBox(width: 8),
                    Text(
                      '글쓰기',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }

  List<Widget> _buildContent(BuildContext context) {
    if (isTradeBoard) {
      final visibleTradeItems = tradeItems
          .where((item) => item.statusKey != 'DELETED')
          .toList(growable: false);

      return [
        const InlineNotice(
          title: '거래 게시판 안내',
          description: '거래글 상세, 신고, 숨김 상태는 유지되고 각 상태에 맞는 배지 스타일도 그대로 노출됩니다.',
        ),
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: visibleTradeItems.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            mainAxisExtent: 182,
          ),
          itemBuilder: (context, index) {
            final item = visibleTradeItems[index];
            final style = tradeStatusStyle(item.statusKey);
            return WavyonCard(
              padding: EdgeInsets.zero,
              onTap: () => widget.onNavigate(
                AppRoute(AppRouteId.tradeDetail, title: item.title, payload: {'id': item.id}),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: 96,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.image_outlined,
                          size: 20,
                          color: WavyonColors.muted,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          item.thumbnailLabel,
                          style: const TextStyle(
                            fontSize: 8,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1,
                            color: WavyonColors.muted,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BadgeChip(
                          label: tradeStatusLabel(item.statusKey),
                          background: style.background,
                          foreground: style.foreground,
                          border: style.border,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          item.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item.priceLabel,
                          style: const TextStyle(
                            fontSize: 14,
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
          },
        ),
      ];
    }

    if (isConcertInfoBoard) {
      return [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: WavyonGradients.banner1,
            borderRadius: BorderRadius.circular(26),
            boxShadow: WavyonShadows.strong,
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '셔틀 수요 조사',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 6),
              Text(
                '공연 이동 동선과 셔틀 관련 공지를 한 카드 안에서 빠르게 확인합니다.',
                style: TextStyle(
                  fontSize: 10,
                  height: 1.4,
                  fontWeight: FontWeight.w700,
                  color: Color(0xCCE2E8F0),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        WavyonCard(
          onTap: () => widget.onNavigate(const AppRoute(AppRouteId.liveChatList, title: '라이브 스레드')),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: const [
                      SizedBox(
                        width: 12,
                        height: 12,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: Color(0x33EF4444),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 8,
                        height: 8,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: WavyonColors.red,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'LIVE THREAD',
                    style: TextStyle(
                      fontSize: 10,
                      letterSpacing: 1.2,
                      fontWeight: FontWeight.w900,
                      color: WavyonColors.red,
                    ),
                  ),
                  const Spacer(),
                  const Text(
                    '목록',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w900,
                      color: WavyonColors.muted,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Text(
                '라이브 스레드 바로가기',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                  color: WavyonColors.text,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                '실시간 커뮤니티 흐름으로 바로 진입할 수 있는 빠른 액션 카드입니다.',
                style: TextStyle(
                  fontSize: 11,
                  height: 1.45,
                  fontWeight: FontWeight.w700,
                  color: WavyonColors.subtleText,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        ...liveNewsFeed.map(
          (news) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _NewsBoardCard(
              news: news,
              onTap: () => widget.onNavigate(
                AppRoute(AppRouteId.newsDetail, title: '뉴스 상세', payload: {'id': news.id}),
              ),
            ),
          ),
        ),
      ];
    }

    if (isLiveNewsBoard) {
      return liveNewsFeed
          .map(
            (news) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _NewsBoardCard(
                news: news,
                onTap: () => widget.onNavigate(
                  AppRoute(AppRouteId.newsDetail, title: '뉴스 상세', payload: {'id': news.id}),
                ),
              ),
            ),
          )
          .toList();
    }

    if (isFreeBoard) {
      return [
        SectionTitle(
          title: '자유게시판',
          subtitle: '실시간 뉴스처럼 바로 큰 리스트를 노출하고, 더보기로 전용 목록 페이지에 진입합니다.',
          action: _TopAction(
            label: '더보기',
            onTap: () => widget.onNavigate(const AppRoute(AppRouteId.freeBoard, title: '자유게시판')),
          ),
        ),
        const SizedBox(height: 14),
        ...freeBoardFeed.take(4).map(
          (post) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _CompactPostCard(
              post: post,
              onTap: () => widget.onNavigate(
                const AppRoute(AppRouteId.communityDetail, title: '게시글 상세보기'),
              ),
            ),
          ),
        ),
      ];
    }

    return [
      if (isArtistBoard) ...[
        GestureDetector(
          onTap: () => widget.onNavigate(const AppRoute(AppRouteId.liveChatList, title: '라이브 스레드')),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: WavyonGradients.banner4,
              borderRadius: BorderRadius.circular(26),
              boxShadow: WavyonShadows.strong,
            ),
            child: Stack(
              children: [
                Positioned(
                  right: -4,
                  top: -10,
                  child: Icon(
                    Icons.mode_comment_outlined,
                    size: 72,
                    color: Colors.white.withOpacity(0.18),
                  ),
                ),
                Positioned(
                  right: 8,
                  top: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: const Text(
                      '목록',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                              height: 8,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'LIVE THREAD',
                          style: TextStyle(
                            fontSize: 10,
                            letterSpacing: 1.2,
                            fontWeight: FontWeight.w900,
                            color: Colors.white.withOpacity(0.92),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      '$selectedBoard 팬덤\n실시간 화력 집중!',
                      style: const TextStyle(
                        fontSize: 20,
                        height: 1.16,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '지금 ${liveThreads.first.users}명이 대화하고 있어요',
                      style: TextStyle(
                        fontSize: 10,
                        height: 1.4,
                        fontWeight: FontWeight.w700,
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
      SectionTitle(
        title: isArtistBoard ? '팬덤 게시판' : '게시판',
        icon: Icons.forum_outlined,
        action: _TopAction(
          label: '더보기',
          onTap: () => widget.onNavigate(
            AppRoute(AppRouteId.fandomBoard, title: '$selectedBoard 팬덤 게시판', payload: {'board': selectedBoard}),
          ),
        ),
      ),
      const SizedBox(height: 14),
      WavyonCard(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        child: Column(
          children: communityBoardFeed.map((post) {
            final last = post == communityBoardFeed.last;
            return GestureDetector(
              onTap: () => widget.onNavigate(
                const AppRoute(AppRouteId.communityDetail, title: '게시글 상세보기'),
              ),
              child: Padding(
                padding: EdgeInsets.only(bottom: last ? 0 : 12, top: 4),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFEFF6FF),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      post.tag,
                                      style: const TextStyle(
                                        fontSize: 9,
                                        fontWeight: FontWeight.w900,
                                        color: WavyonColors.blue,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    post.author,
                                    style: const TextStyle(
                                      fontSize: 9,
                                      fontWeight: FontWeight.w800,
                                      color: WavyonColors.subtleText,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    post.time,
                                    style: const TextStyle(
                                      fontSize: 8,
                                      fontWeight: FontWeight.w800,
                                      color: WavyonColors.muted,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                post.title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: WavyonColors.text,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        Padding(
                          padding: const EdgeInsets.only(top: 24),
                          child: Row(
                            children: [
                              _MiniStat(
                                icon: Icons.favorite_border_rounded,
                                value: '${post.likes}',
                              ),
                              const SizedBox(width: 8),
                              _MiniStat(
                                icon: Icons.chat_bubble_outline_rounded,
                                value: '${post.comments}',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    if (!last)
                      const Padding(
                        padding: EdgeInsets.only(top: 12),
                        child: Divider(height: 1, color: WavyonColors.line),
                      ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    ];
  }
}

class _BoardDropdown extends StatelessWidget {
  const _BoardDropdown({
    required this.selectedBoard,
    required this.onSelect,
  });

  final String selectedBoard;
  final ValueChanged<String> onSelect;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        width: 256,
        constraints: const BoxConstraints(maxHeight: 420),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: WavyonColors.line),
          boxShadow: WavyonShadows.strong,
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _DropdownSection(
                title: 'Favorites',
                highlight: true,
                items: favoriteBoards,
                selectedBoard: selectedBoard,
                onSelect: onSelect,
              ),
              _DropdownSection(
                title: 'General',
                items: extraBoards,
                selectedBoard: selectedBoard,
                onSelect: onSelect,
              ),
              _DropdownSection(
                title: 'Artist Boards',
                items: artistBoards,
                selectedBoard: selectedBoard,
                onSelect: onSelect,
              ),
              _DropdownSection(
                title: 'Info & Trade',
                items: infoBoards,
                selectedBoard: selectedBoard,
                onSelect: onSelect,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DropdownSection extends StatelessWidget {
  const _DropdownSection({
    required this.title,
    required this.items,
    required this.selectedBoard,
    required this.onSelect,
    this.highlight = false,
  });

  final String title;
  final List<String> items;
  final String selectedBoard;
  final ValueChanged<String> onSelect;
  final bool highlight;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!highlight) const Divider(height: 1, color: Color(0xFFF8FAFC)),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 6, 16, 6),
            child: Row(
              children: [
                if (highlight) ...[
                  const Icon(Icons.star_rounded, size: 12, color: WavyonColors.blue),
                  const SizedBox(width: 4),
                ],
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                    color: highlight ? WavyonColors.blue : WavyonColors.muted,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 2),
          ...items.map((item) {
            final selected = item == selectedBoard;
            return InkWell(
              onTap: () => onSelect(item),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        item,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w900,
                          color: WavyonColors.subtleText,
                        ),
                      ),
                    ),
                    if (selected)
                      const Icon(
                        Icons.check_rounded,
                        size: 18,
                        color: WavyonColors.blue,
                      ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _CompactPostCard extends StatelessWidget {
  const _CompactPostCard({
    required this.post,
    required this.onTap,
  });

  final CommunityPost post;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return WavyonCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF6FF),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  post.tag,
                  style: const TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w900,
                    color: WavyonColors.blue,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                post.time,
                style: const TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.w800,
                  color: WavyonColors.muted,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            post.title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Text(
                post.author,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  color: WavyonColors.muted,
                ),
              ),
              const SizedBox(width: 10),
              _MiniStat(
                icon: Icons.favorite_border_rounded,
                value: '${post.likes}',
              ),
              const SizedBox(width: 8),
              _MiniStat(
                icon: Icons.chat_bubble_outline_rounded,
                value: '${post.comments}',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _NewsBoardCard extends StatelessWidget {
  const _NewsBoardCard({
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
            foreground: WavyonColors.blue,
            border: Color(0xFFBFDBFE),
          );

    return WavyonCard(
      onTap: onTap,
      child: Row(
        children: [
          const PlaceholderThumb(size: 48, radius: 12),
          const SizedBox(width: 12),
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
                      style: const TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.w800,
                        color: WavyonColors.muted,
                      ),
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

class _TopAction extends StatelessWidget {
  const _TopAction({
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

class _MiniStat extends StatelessWidget {
  const _MiniStat({
    required this.icon,
    required this.value,
  });

  final IconData icon;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 12, color: WavyonColors.muted),
        const SizedBox(width: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w900,
            color: WavyonColors.muted,
          ),
        ),
      ],
    );
  }
}
