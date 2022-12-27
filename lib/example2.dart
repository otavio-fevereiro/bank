import 'package:flutter/material.dart';

class Now extends StatelessWidget {
  const Now({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BdcAnimationController(
        duration: const Duration(milliseconds: 5000),
        builder: (context, controller) {
          final animation = Tween<double>(begin: 0, end: 1).animate(
            CurvedAnimation(
              parent: controller,
              curve: const Interval(0, 1, curve: Curves.decelerate),
            ),
          );

          return AnimatedBuilder(
            animation: controller,
            builder: (context, child) => Opacity(
              opacity: animation.value,
              child: const Text("Olá Gabriela"),
            ),
          );
        });
  }
}

typedef Builder = Widget Function(
  BuildContext context,
  AnimationController controller,
);

class BdcAnimationController extends StatefulWidget {
  final Builder builder;
  final Duration duration;

  const BdcAnimationController({
    Key? key,
    required this.duration,
    required this.builder,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => BdcAnimationControllerState();
}

class BdcAnimationControllerState extends State<BdcAnimationController>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    //TODO: remove, this is only to start animation
    controller.forward();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, controller);
  }
}
