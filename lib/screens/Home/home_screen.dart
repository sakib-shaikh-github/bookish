import 'dart:async';

import 'package:firebase_1/screens/Home/Utilis/category_pressed.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_1/models/books.dart';
import 'package:firebase_1/screens/Home/view/headline.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: body(),
    );
  }

  appBar() {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.background,
      elevation: 0,
      title: Text('$height, $width'),
      leading: IconButton(
        onPressed: () {},
        icon: const Icon(Icons.drag_handle_rounded),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.search_rounded),
        ),
        Stack(
          children: [
            IconButton(
              padding: const EdgeInsets.only(top: 10),
              onPressed: () {},
              icon: const Icon(Icons.shopping_bag_outlined),
            ),
            const Positioned(
              right: 8,
              top: 12,
              child: CircleAvatar(
                radius: 5,
                backgroundColor: Colors.white,
              ),
            ),
          ],
        ),
        IconButton(
            onPressed: () => FirebaseAuth.instance.signOut(),
            icon: const Icon(Icons.logout))
      ],
    );
  }

  body() {
    List<Books> bookObjs = [
      Books.all(),
      Books.biography(),
      Books.fiction(),
      Books.nonFiction(),
      Books.novel(),
      Books.selfHelp()
    ];
    final StreamController<Object> controller = StreamController();
    Books categoryToBeDisplayed = Books.all();

    return Padding(
        padding: const EdgeInsets.fromLTRB(20, 18, 0, 0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          //1
          headLine(context),
          //2 This will deal with whole book categories section
          const SizedBox(
            height: 15,
          ),
          StreamBuilder<Object>(
              stream: controller.stream,
              builder: (context, snapshot) {
                return Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //1 To show categories
                      SizedBox(
                        height: 35,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: bookObjs.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: OutlinedButton(
                                    onPressed: () {
                                      //Here simplifying things
                                      changingButtonColor(bookObjs, index);
                                      displayCategory(
                                          bookObjs, categoryToBeDisplayed);
                                      categoryToBeDisplayed = displayCategory(
                                          bookObjs, categoryToBeDisplayed);

                                      controller.add(Object());
                                    },
                                    style: bookObjs[index].isActive
                                        ? ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    const Color(0xFFD1C4E9)),
                                          )
                                        : null,
                                    child: Text(bookObjs[index].category)),
                              );
                            }),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      //2 To display book section
                      SizedBox(
                        height: 220,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: categoryToBeDisplayed.numberOfBooks,
                            itemBuilder: ((context, index) =>
                                firstCategoryBuilder(
                                    categoryToBeDisplayed, index))),
                      ),
                    ],
                  ),
                );
              })
        ]));
  }

  firstCategoryBuilder(Books categoryToBeDisplayed, int index) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {},
          child: Stack(
            clipBehavior: Clip.hardEdge,
            children: [
              Positioned(
                top: 15,
                child: Container(
                  height: 200,
                  width: 140,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.grey[200],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Wrap(
                      spacing: 5,
                      alignment: WrapAlignment.end,
                      direction: Axis.vertical,
                      children: [
                        Text(
                          categoryToBeDisplayed.bookNameWithAuthor.keys
                              .elementAt(index),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          categoryToBeDisplayed.bookNameWithAuthor.values
                              .elementAt(index),
                        ),
                        const Text(
                          'Rs.150',
                          style: TextStyle(
                              color: Color(0xFF8D7DAC),
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: -5,
                right: 20,
                child: Container(
                    height: 140,
                    width: 90,
                    decoration: BoxDecoration(
                        color: Colors.grey[400],
                        boxShadow: const [
                          BoxShadow(
                              color: Color.fromARGB(231, 80, 79, 79),
                              offset: Offset(-4, 4),
                              blurRadius: 4)
                        ]),
                    child: const SizedBox.shrink()),
              )
            ],
          ),
        ),
      );
}
