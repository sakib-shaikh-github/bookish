import 'dart:async';

import 'package:firebase_1/screens/Home/Utilis/category_pressed.dart';
import 'package:firebase_1/screens/Home/model/categories_builder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_1/models/books.dart';
import 'package:firebase_1/screens/Home/view/headline.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: body(),
      drawer: drawer(),
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

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 5),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //1
              headLine(context),
              //2 This will deal with whole book categories section
              const SizedBox(
                height: 15,
              ),
              //3
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
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: OutlinedButton(
                                        onPressed: () {
                                          //Here simplifying things
                                          changingButtonColor(bookObjs, index);

                                          categoryToBeDisplayed =
                                              displayCategory(bookObjs,
                                                  categoryToBeDisplayed);

                                          controller.add(Object());
                                        },
                                        style: bookObjs[index].isActive
                                            ? ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        const Color(
                                                            0xFFD1C4E9)),
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
                            height: 230,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: categoryToBeDisplayed.numberOfBooks,
                                itemBuilder: ((context, index) =>
                                    categoryBuilder(categoryToBeDisplayed,
                                        index, context))),
                          ),
                        ],
                      ),
                    );
                  }),

              // 4
              nonFictionCategoryBuilder(context),
              // 5
              selfHelpCategoryBuilder(context),
              //6
              fictionCategoryBuilder(context),
              //7
              novelCategoryBuilder(context),
              //8
              biographyCategoryBuilder(context)
            ]),
      ),
    );
  }

  drawer() {
    buildDrawerItem(String title, Widget widget) {
      return ListTile(
        title: Text(title),
        trailing: widget,
      );
    }

    return Drawer(
      width: 250,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: [buildDrawerItem('Profile', Text(''))],
        ),
      ),
    );
  }
}
