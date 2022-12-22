import 'package:flutter/material.dart';

class Now extends StatelessWidget {
  const Now({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bdcTicker = BdcTicker(child: child);
    final controller = AnimationController(vsync: vsync,
      duration: const Duration(milliseconds: 2000),);
    final animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.85, 1, curve: Curves.decelerate),),);

    return Opacity(
      opacity: animation.value,
      child: const Text("Olá Gabriela"),
    );
  }
}

class BdcTicker extends StatefulWidget {
  final Widget child;

  const BdcTicker({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => BdcTickerState();
}

class BdcTickerState extends State<BdcTicker>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
