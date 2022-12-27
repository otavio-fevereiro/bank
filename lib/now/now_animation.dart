import 'package:bank/now/now_animation_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NowAnimation extends StatefulWidget {
  final Widget child;
  final Duration duration;

  const NowAnimation({
    Key? key,
    required this.duration,
    required this.child,
  }) : super(key: key);

  @override
  State<NowAnimation> createState() => _NowAnimationState();
}

class _NowAnimationState extends State<NowAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Provider<NowAnimationData>(
      create: (_) => NowAnimationData(animationController),
      child: widget.child,
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}
