import 'package:firebase_1/authenticate/authenticating.dart';
import 'package:firebase_1/models/books.dart';
import 'package:firebase_1/services/price_assign.dart';
import 'package:flutter/material.dart';

class Book extends StatefulWidget {
  const Book(
      {super.key, required this.categoryToBeDisplayed, required this.index});

  final Books categoryToBeDisplayed;
  final int index;

  @override
  State<Book> createState() => _BookState();
}

class _BookState extends State<Book> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          //1
          sliverAppbar(),
          //2
          sliverMainPage(),
        ],
      ),
    );
  }

  sliverAppbar() {
    return SliverAppBar(
      backgroundColor: Colors.white38,
      stretch: true,
      floating: true,
      expandedHeight: 200,
      flexibleSpace: FlexibleSpaceBar(
        background: DecoratedBox(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.center,
                    colors: [Colors.deepPurple[100]!, Colors.white])),
            child: Center(
              child: SizedBox(
                  height: 200,
                  width: 200,
                  child: Image.network(widget
                      .categoryToBeDisplayed.listOfImgUrls[widget.index])),
            )),
      ),
    );
  }

  sliverMainPage() => SliverList(
        delegate: SliverChildBuilderDelegate(((context, index) {
          return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  //1
                  Text(
                      widget.categoryToBeDisplayed.bookNameWithAuthor.keys
                          .elementAt(widget.index),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 25)),
                  //2
                  Text(
                      widget.categoryToBeDisplayed.bookNameWithAuthor.values
                          .elementAt(widget.index),
                      style: const TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 15)),

                  const SizedBox(
                    height: 10,
                  ),
                  //3
                  Text(
                      'Rs.${assigningPricesWRTCategory(widget.categoryToBeDisplayed)[widget.index]}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Color(0xFF8D7DAC),
                      )),
                  const SizedBox(
                    height: 10,
                  ),

                  //4
                  ShoppingTab(
                      price: assigningPricesWRTCategory(
                          widget.categoryToBeDisplayed)[widget.index]),

                  //5
                  const Text('Description')
                ],
              ));
        }), childCount: 1),
      );
}

class ShoppingTab extends StatefulWidget {
  const ShoppingTab({super.key, required this.price});
  final int price;

  @override
  State<ShoppingTab> createState() => _ShoppingTabState();
}

class _ShoppingTabState extends State<ShoppingTab> {
  int quantity = 0;
  var totalPrice = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(35),
          color: const Color.fromARGB(255, 253, 167, 38)),
      child: Column(
        children: [
          //1
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              //1
              SizedBox(
                  width: 40,
                  child: TextButton(
                      onPressed: () => setState(() {
                            if (0 <= quantity && quantity < 10) {
                              quantity += 1;
                              totalPrice += widget.price;
                            } else {
                              quantity;
                              Utilis.showSnackBar('No more than 10. Sorry😕',
                                  color: const Color.fromARGB(255, 252, 193, 104));
                            }
                          }),
                      child: Row(
                        children: const [
                          Icon(
                            Icons.add,
                            color: Color(0xFF000000),
                          ),
                        ],
                      ))),
              //2
              Container(
                height: 30,
                width: 30,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 2)),
                child: Text(quantity.toString()),
              ),
              //3
              SizedBox(
                  width: 30,
                  child: TextButton(
                      onPressed: () => setState(() {
                            if (1 <= quantity && quantity <= 10) {
                              quantity -= 1;
                              totalPrice -= widget.price;
                            } else {
                              quantity;
                              Utilis.showSnackBar('Only errors can be given less then 0 here. Sorry😂',
                                  color: const Color.fromARGB(255, 252, 193, 104));
                            }
                          }),
                      child: const Icon(
                        Icons.remove,
                        color: Color(0xFF000000),
                      ))),
              const SizedBox(
                width: 120,
              ),
              //4

              Text(
                totalPrice.toString(),
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          //2
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.add_shopping_cart_rounded),
            label: const Text('Add to cart'),
            style: ButtonStyle(
                backgroundColor: const MaterialStatePropertyAll(
                  Colors.white,
                ),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(35)))),
          ),
        ],
      ),
    );
  }
}
