import 'dart:ffi';

import 'package:bank/cards_model.dart';
import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'dart:math' as math;

class TransitionsContainer extends StatefulWidget {
  final List<TransitionWidget> children;
  final Duration duration;

  const TransitionsContainer({
    Key? key,
    required this.duration,
    this.children = const <TransitionWidget>[],
  }) : super(
          key: key,
        );

  @override
  State<StatefulWidget> createState() => TransitionsState();
}

class TransitionsState extends State<TransitionsContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late List<Animation<double>?> outAnimations;
  late List<Animation<double>?> inAnimations;
  late Animation<double> heightAnimation;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    inAnimations = _getInAnimations().toList();
    outAnimations = _getOutAnimations().toList();
    heightAnimation = _getHeightAnimation();

    //controller.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleBottomSheet,
      child: LayoutBuilder(
        builder: (context, constraints) => AnimatedBuilder(
          animation: controller,
          builder: (context, child) => SizedBox(
            height: heightAnimation.value,
            child: Stack(
              children: _getChildren().toList(),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  Iterable<Widget> _getChildren() sync* {
    int index = 0;
    for (var widget in widget.children) {
      var inAnimation = inAnimations[index];
      var outAnimation = outAnimations[index];
      Widget opacity;

      if (inAnimation != null && outAnimation != null) {
        opacity = Opacity(
          opacity: inAnimation.value,
          child: Opacity(
            opacity: outAnimation.value,
            child: widget.child,
          ),
        );
      } else if (inAnimation != null && outAnimation == null) {
        opacity = Opacity(
          opacity: inAnimation.value,
          child: widget.child,
        );
      } else if (inAnimation == null && outAnimation != null) {
        opacity = Opacity(
          opacity: outAnimation.value,
          child: widget.child,
        );
      } else {
        opacity = widget.child;
      }

      yield opacity;

      index++;
    }
  }

  Animation<double> _getHeightAnimation() {
    Iterable<TweenSequenceItem<double>> _getSequence() sync* {
      var last = widget.children.first;
      for (var widget in widget.children) {
        double runningWeight = widget.weight * 0.20;
        double waitingWeight = widget.weight - runningWeight;

        yield TweenSequenceItem(
          tween: Tween(begin: last.height, end: widget.height),
          weight: runningWeight,
        );

        yield TweenSequenceItem(
          tween: Tween(begin: widget.height, end: widget.height),
          weight: waitingWeight,
        );
        last = widget;
      }
    }

    var sequence = TweenSequence(_getSequence().toList());

    return sequence.animate(CurvedAnimation(
      parent: controller,
      curve: const Interval(0, 1, curve: Curves.linear),
    ));
  }

  Iterable<Animation<double>?> _getInAnimations() sync* {
    for (var child in widget.children) {
      if (child.inCurve == null) {
        yield null;
      } else {
        yield Tween<double>(
          begin: 0,
          end: 1,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: child.inCurve!,
          ),
        );
      }
    }
  }

  Iterable<Animation<double>?> _getOutAnimations() sync* {
    for (var child in widget.children) {
      if (child.outCurve == null) {
        yield null;
      } else {
        yield Tween<double>(
          begin: 1,
          end: 0,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: child.outCurve!,
          ),
        );
      }
    }
  }

  _toggleBottomSheet() {
    if (!controller.isAnimating) {
      if (controller.isDismissed) {
        controller.forward();
      } else {
        controller.reset();
      }
    }
  }
}

class TransitionWidget {
  final Interval? inCurve;
  final Interval? outCurve;
  final double height;
  final Widget child;
  late double weight;

  TransitionWidget({
    this.inCurve,
    this.outCurve,
    required this.height,
    required this.child,
  }) {
    weight = _getWeight();
  }

  double _getWeight() {
    double begin = 0;
    double end = 0;

    if (inCurve != null) {
      begin = inCurve!.begin;
    }

    if (outCurve == null && inCurve != null) {
      end = inCurve!.end;
    } else {
      end = outCurve!.end;
    }

    return (end - begin) * 100;
  }
}
