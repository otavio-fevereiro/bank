import 'package:bank/now/now_animation_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NowHelloAnimation extends StatefulWidget {
  final Widget child;

  const NowHelloAnimation({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  State<NowHelloAnimation> createState() => _NowHelloAnimationState();
}

class _NowHelloAnimationState extends State<NowHelloAnimation>
    with SingleTickerProviderStateMixin {
  late Animation<double> opacity;
  late AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    animationController =
        Provider.of<NowAnimationData>(context).animationController;
    opacity = opacityAnimation(animationController);

    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) => GestureDetector(
        onTap: onTap,
        child: Opacity(
          opacity: opacity.value,
          child: widget.child,
        ),
      ),
    );
  }

  void onTap() {
    if (!animationController.isAnimating) {
      if (animationController.isDismissed) {
        animationController.forward();
      } else {
        animationController.reset();
      }
    }
  }

  Animation<double> opacityAnimation(AnimationController controller) {
    return Tween<double>(
      begin: 1,
      end: 0,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(
          0.20,
          0.35,
          curve: Curves.linear,
        ),
      ),
    );
  }
}
