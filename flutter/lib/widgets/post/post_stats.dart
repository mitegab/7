import 'package:flutter/material.dart';

class PostStats extends StatelessWidget {
  const PostStats({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _StatItem(icon: Icons.comment_outlined, count: '6'),
        _StatItem(icon: Icons.compare_arrows_outlined, count: '6'),
        _StatItem(icon: Icons.favorite_outline, count: '6'),
        _StatItem(icon: Icons.stacked_bar_chart_outlined, count: '6'),
        IconButton(
          visualDensity: VisualDensity.compact,
          onPressed: () {},
          icon: const Icon(Icons.ios_share_outlined),
        ),
      ],
    );
  }
}

class _StatItem extends StatelessWidget {
  const _StatItem({
    required this.icon,
    required this.count,
    super.key,
  });

  final IconData icon;
  final String count;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon),
        const SizedBox(width: 4.0),
        Text(count),
      ],
    );
  }
}
