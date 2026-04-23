import 'package:flutter/material.dart';

import '../app/theme.dart';

const kScreenPadding = EdgeInsets.symmetric(horizontal: 20);

enum WavyonButtonVariant { primary, secondary, ghost }

class SegmentTabItem<T> {
  const SegmentTabItem({
    required this.value,
    required this.label,
  });

  final T value;
  final String label;
}

class WavyonCard extends StatelessWidget {
  const WavyonCard({
    super.key,
    required this.child,
    this.onTap,
    this.padding = const EdgeInsets.all(16),
    this.radius = 24,
    this.backgroundColor = Colors.white,
    this.borderColor = WavyonColors.line,
    this.boxShadow = WavyonShadows.card,
  });

  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsets padding;
  final double radius;
  final Color backgroundColor;
  final Color borderColor;
  final List<BoxShadow> boxShadow;

  @override
  Widget build(BuildContext context) {
    final content = DecoratedBox(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: borderColor),
        boxShadow: boxShadow,
      ),
      child: Padding(
        padding: padding,
        child: child,
      ),
    );

    if (onTap == null) {
      return content;
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(radius),
        onTap: onTap,
        child: Ink(
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(radius),
            border: Border.all(color: borderColor),
            boxShadow: boxShadow,
          ),
          child: Padding(
            padding: padding,
            child: child,
          ),
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    super.key,
    required this.title,
    this.subtitle,
    this.action,
    this.icon,
  });

  final String title;
  final String? subtitle;
  final Widget? action;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  if (icon != null) ...[
                    Icon(icon, size: 16, color: WavyonColors.blue),
                    const SizedBox(width: 6),
                  ],
                  Text(
                    title,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          fontSize: 12,
                          color: WavyonColors.text,
                        ),
                  ),
                ],
              ),
              if (subtitle != null) ...[
                const SizedBox(height: 4),
                Text(
                  subtitle!,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ],
          ),
        ),
        if (action != null) action!,
      ],
    );
  }
}

class BadgeChip extends StatelessWidget {
  const BadgeChip({
    super.key,
    required this.label,
    required this.background,
    required this.foreground,
    this.border,
    this.padding = const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    this.fontSize = 9,
  });

  final String label;
  final Color background;
  final Color foreground;
  final Color? border;
  final EdgeInsets padding;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: border ?? background),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.w900,
          color: foreground,
        ),
      ),
    );
  }
}

class FilterChipButton extends StatelessWidget {
  const FilterChipButton({
    super.key,
    required this.label,
    required this.active,
    this.onTap,
  });

  final String label;
  final bool active;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: active ? WavyonColors.primary : Colors.white,
          borderRadius: BorderRadius.circular(999),
          border: Border.all(
            color: active ? WavyonColors.primary : const Color(0xFFE2E8F0),
          ),
          boxShadow: active ? WavyonShadows.card : const [],
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w900,
            color: active ? Colors.white : WavyonColors.subtleText,
          ),
        ),
      ),
    );
  }
}

class SegmentTabs<T> extends StatelessWidget {
  const SegmentTabs({
    super.key,
    required this.items,
    required this.value,
    required this.onChanged,
  });

  final List<SegmentTabItem<T>> items;
  final T value;
  final ValueChanged<T> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: WavyonColors.line),
        boxShadow: WavyonShadows.card,
      ),
      child: Row(
        children: items.map((item) {
          final selected = item.value == value;
          return Expanded(
            child: GestureDetector(
              onTap: () => onChanged(item.value),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                decoration: BoxDecoration(
                  color: selected ? WavyonColors.blue : Colors.transparent,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: selected ? WavyonShadows.blue : const [],
                ),
                child: Text(
                  item.label,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w900,
                    color: selected ? Colors.white : WavyonColors.subtleText,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class SearchBarCard extends StatelessWidget {
  const SearchBarCard({
    super.key,
    required this.placeholder,
    this.withFilter = false,
  });

  final String placeholder;
  final bool withFilter;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: WavyonColors.line),
        boxShadow: WavyonShadows.card,
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 1),
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: WavyonColors.line),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: placeholder,
                  isDense: true,
                  border: InputBorder.none,
                  prefixIcon: const Icon(
                    Icons.search_rounded,
                    size: 18,
                    color: WavyonColors.muted,
                  ),
                  prefixIconConstraints: const BoxConstraints(minWidth: 34),
                ),
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w900,
                  color: WavyonColors.text,
                ),
              ),
            ),
          ),
          if (withFilter) ...[
            const SizedBox(width: 10),
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: WavyonColors.line),
              ),
              child: const Icon(
                Icons.tune_rounded,
                size: 18,
                color: WavyonColors.subtleText,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class PlaceholderThumb extends StatelessWidget {
  const PlaceholderThumb({
    super.key,
    this.label = 'IMAGE',
    this.size = 72,
    this.radius = 18,
  });

  final String label;
  final double size;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.image_outlined,
            color: WavyonColors.muted,
            size: 20,
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: const TextStyle(
              fontSize: 8,
              letterSpacing: 1,
              fontWeight: FontWeight.w900,
              color: WavyonColors.muted,
            ),
          ),
        ],
      ),
    );
  }
}

class WavyonTextField extends StatelessWidget {
  const WavyonTextField({
    super.key,
    required this.hint,
    this.icon,
    this.maxLines = 1,
    this.initialValue,
  });

  final String hint;
  final IconData? icon;
  final int maxLines;
  final String? initialValue;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      maxLines: maxLines,
      style: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w800,
        color: WavyonColors.text,
      ),
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: icon == null ? null : Icon(icon, size: 18),
        alignLabelWithHint: maxLines > 1,
      ),
    );
  }
}

class WavyonButton extends StatelessWidget {
  const WavyonButton({
    super.key,
    required this.label,
    this.onPressed,
    this.variant = WavyonButtonVariant.primary,
    this.expand = false,
    this.padding,
  });

  final String label;
  final VoidCallback? onPressed;
  final WavyonButtonVariant variant;
  final bool expand;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    final background = switch (variant) {
      WavyonButtonVariant.primary => WavyonColors.primary,
      WavyonButtonVariant.secondary => WavyonColors.ink,
      WavyonButtonVariant.ghost => const Color(0xFFF8FAFC),
    };

    final foreground = switch (variant) {
      WavyonButtonVariant.ghost => WavyonColors.subtleText,
      _ => Colors.white,
    };

    final child = GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: padding ?? const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(20),
          border: variant == WavyonButtonVariant.ghost
              ? Border.all(color: WavyonColors.line)
              : null,
          boxShadow: variant == WavyonButtonVariant.ghost
              ? const []
              : (variant == WavyonButtonVariant.primary
                  ? WavyonShadows.blue
                  : WavyonShadows.card),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w900,
            color: foreground,
          ),
        ),
      ),
    );

    if (!expand) {
      return child;
    }

    return SizedBox(width: double.infinity, child: child);
  }
}

class InfoRow extends StatelessWidget {
  const InfoRow({
    super.key,
    required this.label,
    required this.value,
    this.emphasize = false,
  });

  final String label;
  final String value;
  final bool emphasize;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 12,
              fontWeight: emphasize ? FontWeight.w900 : FontWeight.w800,
              color: emphasize ? WavyonColors.primary : WavyonColors.text,
            ),
          ),
        ],
      ),
    );
  }
}

class EmptyState extends StatelessWidget {
  const EmptyState({
    super.key,
    required this.title,
    required this.description,
    this.icon = Icons.info_outline_rounded,
  });

  final String title;
  final String description;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return WavyonCard(
      padding: const EdgeInsets.all(28),
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(icon, color: WavyonColors.muted),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            description,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key,
    required this.kind,
    required this.text,
    this.sender,
    this.time,
  });

  final String kind;
  final String text;
  final String? sender;
  final String? time;

  @override
  Widget build(BuildContext context) {
    if (kind == 'system') {
      return Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xFFE2E8F0),
            borderRadius: BorderRadius.circular(999),
          ),
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.w900,
              color: WavyonColors.subtleText,
            ),
          ),
        ),
      );
    }

    if (kind == 'me') {
      return Align(
        alignment: Alignment.centerRight,
        child: Container(
          constraints: const BoxConstraints(maxWidth: 280),
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: WavyonColors.primary,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(22),
              topRight: Radius.circular(22),
              bottomLeft: Radius.circular(22),
              bottomRight: Radius.circular(6),
            ),
            boxShadow: WavyonShadows.card,
          ),
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: const Color(0xFFDBEAFE),
            borderRadius: BorderRadius.circular(999),
          ),
          alignment: Alignment.center,
          child: Text(
            ((sender != null && sender!.isNotEmpty) ? sender![0] : 'W').toUpperCase(),
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w900,
              color: WavyonColors.primary,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    sender ?? '',
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w900,
                      color: WavyonColors.subtleText,
                    ),
                  ),
                  if (time != null) ...[
                    const SizedBox(width: 8),
                    Text(
                      time!,
                      style: const TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.w800,
                        color: WavyonColors.muted,
                      ),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 6),
              Container(
                constraints: const BoxConstraints(maxWidth: 280),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(6),
                    topRight: Radius.circular(22),
                    bottomLeft: Radius.circular(22),
                    bottomRight: Radius.circular(22),
                  ),
                  border: Border.all(color: WavyonColors.line),
                  boxShadow: WavyonShadows.card,
                ),
                child: Text(
                  text,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: WavyonColors.text,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class BottomFixedActionBar extends StatelessWidget {
  const BottomFixedActionBar({
    super.key,
    required this.children,
  });

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.96),
        border: const Border(top: BorderSide(color: WavyonColors.line)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x08000000),
            blurRadius: 20,
            offset: Offset(0, -8),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: children
              .expand((widget) => [
                    Expanded(child: widget),
                    const SizedBox(width: 12),
                  ])
              .toList()
            ..removeLast(),
        ),
      ),
    );
  }
}

class InlineNotice extends StatelessWidget {
  const InlineNotice({
    super.key,
    required this.title,
    required this.description,
    this.danger = false,
  });

  final String title;
  final String description;
  final bool danger;

  @override
  Widget build(BuildContext context) {
    final background = danger ? const Color(0xFFFEF2F2) : const Color(0xFFEFF6FF);
    final foreground = danger ? WavyonColors.red : WavyonColors.primary;
    final border = danger ? const Color(0xFFFECACA) : const Color(0xFFBFDBFE);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: border),
        boxShadow: WavyonShadows.card,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            danger ? Icons.warning_amber_rounded : Icons.info_outline_rounded,
            size: 18,
            color: foreground,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w900,
                    color: foreground,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 10,
                    height: 1.45,
                    fontWeight: FontWeight.w700,
                    color: foreground.withOpacity(0.82),
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

class SettingRow extends StatelessWidget {
  const SettingRow({
    super.key,
    required this.icon,
    required this.label,
    this.count,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final int? count;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, size: 18, color: WavyonColors.subtleText),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  label,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w900,
                    color: WavyonColors.subtleText,
                  ),
                ),
              ),
              if (count != null) ...[
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    '$count',
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w900,
                      color: WavyonColors.muted,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
              ],
              const Icon(
                Icons.chevron_right_rounded,
                color: Color(0xFFCBD5E1),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.hint,
    this.icon,
    this.enabled = true,
  });

  final String hint;
  final IconData? icon;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !enabled,
      child: Opacity(
        opacity: enabled ? 1 : 0.7,
        child: WavyonTextField(hint: hint, icon: icon),
      ),
    );
  }
}

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    this.onPressed,
    this.secondary = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool secondary;

  @override
  Widget build(BuildContext context) {
    return WavyonButton(
      label: label,
      onPressed: onPressed,
      variant: secondary ? WavyonButtonVariant.secondary : WavyonButtonVariant.primary,
      expand: true,
    );
  }
}
