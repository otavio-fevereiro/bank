class CardsModel {
  final List<CardModel> _cards;

  CardsModel({required List<CardModel> cards})
      : _cards = cards,
        length = cards.length;

  final int length;

  CardModel getCard(int index) {
    return _cards[index];
  }
}

class CardModel {
  CardModel({
    required this.title,
    required this.text,
    required this.image, //'https://noticiaoficial.com/wp-content/uploads/2021/08/Nubank_new_card-1-1-1024x644.png'
  });

  final String title;
  final String text;
  final String image;
}
