import 'package:bank/now/now_animation_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NowSuggestionAnimation extends StatefulWidget {
  final Widget child;

  const NowSuggestionAnimation({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  State<NowSuggestionAnimation> createState() => _NowSuggestionAnimationState();
}

class _NowSuggestionAnimationState extends State<NowSuggestionAnimation>
    with SingleTickerProviderStateMixin {
  late Animation<double> opacityIn;
  late Animation<double> opacityOut;
  late AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    animationController =
        Provider.of<NowAnimationData>(context).animationController;
    opacityIn = opacityInAnimation(animationController);
    opacityOut = opacityOutAnimation(animationController);

    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) => Opacity(
        opacity: opacityOut.value,
        child: Opacity(
          opacity: opacityIn.value,
          child: widget.child,
        ),
      ),
    );
  }

  Animation<double> opacityInAnimation(AnimationController controller) {
    return Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(
          0.38,
          0.46,
          curve: Curves.linear,
        ),
      ),
    );
  }

  Animation<double> opacityOutAnimation(AnimationController controller) {
    return Tween<double>(
      begin: 1,
      end: 0,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(
          0.80,
          0.86,
          curve: Curves.linear,
        ),
      ),
    );
  }
}
