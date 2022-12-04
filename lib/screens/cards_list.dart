import 'package:flashcardsmobile/db_helper/db_helper.dart';
import 'package:flashcardsmobile/modal_class/flash_card.dart';
import 'package:flashcardsmobile/screens/card_detail.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class CardsList extends StatefulWidget {
  const CardsList({super.key});

  @override
  State<CardsList> createState() => _CardsListState();
}

class _CardsListState extends State<CardsList> {
  late FlipCardController _flipController;
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<FlashCard> cardList = [];
  int count = 0;
  int axisCount = 2;
  int cardNumber = 0;

  @override
  void initState() {
    super.initState();
    _flipController = FlipCardController();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = size.width * .9;
    var height = size.height * .5;
    if (cardList.isEmpty) {
      cardList = [];
      updateListView();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cards',
          style: Theme.of(context).textTheme.headline5,
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          cardList.isEmpty
              ? Container()
              : IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                ),
        ],
      ),
      body: cardList.isEmpty
          ? Container(
              color: Colors.white,
              child: Center(
                  child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Click on the add button to add a new card!',
                  style: Theme.of(context).textTheme.bodyText2,
                  textAlign: TextAlign.center,
                ),
              )),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xffF28B83),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.black,
                      width: 2,
                    ),
                  ),
                  padding: const EdgeInsets.all(25),
                  margin: const EdgeInsets.all(25),
                  width: width,
                  height: height,
                  //color: const Color(0xffF28B83),
                  child: FlipCard(
                    controller: _flipController,
                    fill: Fill
                        .fillBack, // Fill the back side of the card to make in the same size as the front.
                    direction: FlipDirection.HORIZONTAL, // default
                    front: Container(
                      child: Text(
                        cardList[cardNumber].front,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    back: Container(
                      child: Text(
                        cardList[cardNumber].back,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        setState(() {
                          cardNumber++;
                        });
                      },
                      child: const Text('I know it'),
                    ),
                    OutlinedButton(
                      onPressed: () {
                        setState(() {
                          if (!_flipController.state!.isFront) {
                            _flipController.toggleCard();
                          }

                          if (cardNumber < cardList.length - 1) {
                            cardNumber++;
                          } else {
                            cardList = List.empty();
                          }
                        });
                      },
                      child: const Text('Next card'),
                    )
                  ],
                )
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigateToDetail(FlashCard('', '', '', false), 'Add Note');
        },
        tooltip: 'Add Note',
        shape: const CircleBorder(
          side: BorderSide(
            color: Colors.black,
            width: 2.0,
          ),
        ),
        backgroundColor: Colors.white,
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: const Color(0xffF28B83),
              ),
              child: Text('Flash Cards App'),
            ),
            ListTile(
              title: const Text('All Cards'),
              onTap: (() {}),
            ),
            const ListTile(
              title: Text('Cards finalized'),
            )
          ],
        ),
      ),
    );
  }

  void navigateToDetail(FlashCard note, String title) async {
    bool result = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => FlashCardDetail(note, title)));

    if (result == true) {
      updateListView();
    }
  }

  void updateListView() async {
    cardList = await databaseHelper.getCardsList();

    databaseHelper.getCardsList().then((value) => {
          setState(
            () {
              cardList = value;
              count = value.length;
            },
          )
        });

    count = cardList.length;
  }
}
