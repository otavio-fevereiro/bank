// import 'package:bank/now/now_animation_data.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// class NowHelloAnimation extends StatefulWidget {
//   final Widget child;
//
//   const NowHelloAnimation({
//     Key? key,
//     required this.child,
//   }) : super(key: key);
//
//   @override
//   State<NowHelloAnimation> createState() => _NowHelloAnimationState();
// }
//
// class _NowHelloAnimationState extends State<NowHelloAnimation>
//     with SingleTickerProviderStateMixin {
//   late Animation<double> opacity;
//   late AnimationController animationController;
//
//   late Animation<Offset> position;
//
//   @override
//   Widget build(BuildContext context) {
//     animationController =
//         Provider
//             .of<NowAnimationData>(context)
//             .animationController;
//     opacity = opacityAnimation(animationController);
//     position = positionAnimation(animationController);
//
//     return AnimatedBuilder(
//       animation: animationController,
//       builder: (context, child) =>
//           GestureDetector(
//               onTap: onTap,
//               child:
//               SlideTransition(
//                   position: position,
//                   child: Opacity(
//                     opacity: opacity.value,
//                     child: widget.child,
//                   ),
//               ),
//           ),
//     );
//   }
//
//   void onTap() {
//     if (!animationController.isAnimating) {
//       if (animationController.isDismissed) {
//         animationController.forward();
//       } else {
//         animationController.reset();
//       }
//     }
//   }
//
//   Animation<double> opacityAnimation(AnimationController controller) {
//     return Tween<double>(
//       begin: 1,
//       end: 0,
//     ).animate(
//       CurvedAnimation(
//         parent: controller,
//         curve: const Interval(
//           0.41,
//           0.46,
//           curve: Curves.linear,
//         ),
//       ),
//     );
//   }
//
//   Animation<Offset> positionAnimation(AnimationController animationController) {
//     return Tween<Offset>(
//       begin: Offset.zero,
//       end: const Offset(0, -1),
//     ).animate(
//       CurvedAnimation(
//         parent: animationController,
//         curve: const Interval(
//           0.41,
//           0.51,
//           curve: Cubic(0.7, 0, 0.28, 1),
//         ),
//       ),
//     );
//   }
// }
