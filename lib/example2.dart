import 'package:flutter/material.dart';

class Now extends StatelessWidget {
  const Now({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BdcAnimation(
        builder: (context, controller) {
          final animation = Tween<double>(begin: 0, end: 1).animate(
            CurvedAnimation(
              parent: controller,
              curve: const Interval(0.85, 1, curve: Curves.decelerate),),);

          return Opacity(
              opacity: animation.value,
              child: const Text("Olá Gabriela")
          );
        });
  }
}

typedef Builder = Widget Function(BuildContext context, AnimationController controller);

class BdcAnimation extends StatefulWidget {
  final Builder builder;

  const BdcAnimation({
    Key? key,
    required this.builder,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => BdcAnimationState();
}

class BdcAnimationState extends State<BdcAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override void initState() {
    controller = AnimationController(vsync: this,
      duration: const Duration(milliseconds: 2000),);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, controller);
  }
}
