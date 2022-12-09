import 'dart:ffi';

import 'package:bank/cards_model.dart';
import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'dart:math' as math;

class ScrollBehaviorModified extends ScrollBehavior {
  const ScrollBehaviorModified();

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return const BouncingScrollPhysics();
  }
}

void main() {
  var card = CardModel(
    title: "Sua fatura vence amanhã.",
    text: "Pagar >",
    image:
        "https://noticiaoficial.com/wp-content/uploads/2021/08/Nubank_new_card-1-1-1024x644.png",
  );

  var cards = CardsModel(
    cards: [card, card, card, card, card, card, card, card],
  );

  runApp(
    MaterialApp(
      color: AppColors.withe,
      scrollBehavior: const ScrollBehaviorModified(),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.purple,
          elevation: 0,
          //title: const Text('Home'),
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.account_circle_rounded),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.remove_red_eye),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.question_mark_rounded),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.add),
            )
          ],
        ),
        body: NowDash(
          hello: "Olá Gabriela",
          loading: "Você tem ${cards.length} notificações",
          cards: cards,
        ),
      ),
    ),
  );
}

class NowDash extends StatefulWidget {
  const NowDash({
    Key? key,
    required this.hello,
    required this.loading,
    required this.cards,
  }) : super(key: key);

  final String hello;
  final String loading;
  final CardsModel cards;

  @override
  State<StatefulWidget> createState() => _NowDashState();
}

class _NowDashState extends State<NowDash> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> heightAnimation;
  late Animation<Offset> cardsInAnimation;
  late Animation<Offset> helloOutAnimation;
  late Animation<double> helloOutOpacityAnimation;
  late Animation<Offset> notificationInAnimation;
  late Animation<double> notificationInOpacityAnimation;
  late Animation<double> notificationOutOpacityAnimation;
  late Animation<Offset> notificationOutAnimation;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4000),
    );

    heightAnimation = Tween(
      begin: 80.0,
      end: 190.0,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(
          0.85,
          1,
          curve: Curves.decelerate,
        ),
      ),
    );

    cardsInAnimation = Tween<Offset>(
      begin: const Offset(1, 0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(
          0.9,
          1.0,
          curve: Curves.decelerate,
        ),
      ),
    );

    helloOutAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0, -1),
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(
          0.3,
          0.4,
          curve: Curves.decelerate,
        ),
      ),
    );

    helloOutOpacityAnimation = Tween<double>(
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

    notificationInAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(
          0.3,
          0.4,
          curve: Curves.decelerate,
        ),
      ),
    );

    notificationInOpacityAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(
          0.30,
          0.36,
          curve: Curves.linear,
        ),
      ),
    );

    notificationOutOpacityAnimation = Tween<double>(
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

    notificationOutAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0, -1),
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(
          0.80,
          0.9,
          curve: Curves.decelerate,
        ),
      ),
    );

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleBottomSheet,
      child: LayoutBuilder(
        builder: (context, constraints) => AnimatedBuilder(
          animation: controller,
          builder: (context, child) => ListView(
            physics: const NeverScrollableScrollPhysics(),
            children: <Widget>[
              Container(
                color: AppColors.purple,
                height: heightAnimation.value,
                padding: const EdgeInsets.only(bottom: 15),
                child: Stack(
                  children: [
                    SlideTransition(
                      position: helloOutAnimation,
                      child: Opacity(
                        opacity: helloOutOpacityAnimation.value,
                        child: Hello(text: widget.hello),
                      ),
                    ),
                    // SlideTransition(
                    //   position: notificationOutAnimation,
                    //   child:
                      SlideTransition(
                        position: notificationInAnimation,
                        child: Opacity(
                          opacity: notificationOutOpacityAnimation.value,
                          child: Opacity(
                            opacity: notificationInOpacityAnimation.value,
                            child: Hello(text: widget.loading),
                          ),
                        ),
                      ),
                    // ),
                    SlideTransition(
                      position: cardsInAnimation,
                      child: Cards(cards: widget.cards),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _toggleBottomSheet() {
    if (!controller.isAnimating) {
      if (controller.isDismissed) {
        controller.forward();
      } else {
        controller.reverse();
      }
    }
  }
}

class Hello extends StatelessWidget {
  const Hello({
    Key? key,
    required this.text,
  }) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Text(
        text,
        style: const TextStyle(
          color: AppColors.withe,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
    );
  }
}

class Cards extends StatelessWidget {
  const Cards({Key? key, required this.cards}) : super(key: key);
  final CardsModel cards;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: cards.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.only(left: 7),
          child: NuCard(card: cards.getCard(index)),
        );
      },
    );
  }
}

class NuCard extends StatelessWidget {
  const NuCard({Key? key, required this.card}) : super(key: key);
  final CardModel card;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: AppColors.withe,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Container(
        width: 182,
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Transform.rotate(
                  angle: math.pi / 180 * 90,
                  child: Image.network(
                    card.image,
                    width: 40,
                    height: 40,
                  ),
                ),
                const Icon(
                  Icons.more_vert,
                  color: AppColors.gray,
                ),
              ],
            ),
            const Spacer(),
            Expanded(
              flex: 2,
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  card.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  card.text,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.purple,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
