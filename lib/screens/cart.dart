import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pay/pay.dart';
import 'package:provider/provider.dart';

import 'package:firebase_1/authenticate/authenticating.dart';
import 'package:firebase_1/stateManagment/cart_provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  CartProvider cartProvider = CartProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Cart'),
        centerTitle: true,
      ),
      body: ChangeNotifierProvider(
        create: ((context) => CartProvider()),
        builder: ((context, child) {
          return Consumer<CartProvider>(builder: (context, provider, child) {
            print('works');
            return Column(
              children: [
                yourOrders(),
                grandTotal(),
              ],
            );
          });
        }),
      ),
    );
  }

  yourOrders() {
    return Flexible(
      child: ListView.builder(
          itemCount: listOfOrderedBookNames.length,
          itemBuilder: ((context, index) => Card(
                child: Dismissible(
                  onDismissed: ((direction) => setState(() {
                    listOfOrderedBookNames
                      .remove(listOfOrderedBookNames[index]);
                  })),
                  key: Key(listOfOrderedBookNames[index]),
                  background: Container(
                    color: Colors.red,
                    child: Icon(Icons.delete_forever_rounded),
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(8),
                    leading: Image.network(listOfOrderedBookImage[index]),
                    title: Text(listOfOrderedBookNames[index]),
                    subtitle: Text(listOfOrderedBookNamesAuthor[index]),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Rs.' + listOfPrices[index].toString(),
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text('Qt. ' + listOfQuantities[index].toString(),
                            style: TextStyle(fontWeight: FontWeight.bold))
                      ],
                    ),
                  ),
                ),
              ))),
    );
  }

  grandTotal() {
    int checkoutTotalPrice = 0;
    listOfPrices.forEach((element) {
      checkoutTotalPrice += element;
    });
    final _paymentItems = <PaymentItem>[];

    int grandTotalPrice =
        checkoutTotalPrice == 0 ? 0 : (checkoutTotalPrice + 30);

    myPayButton() {
      orderPlacing() async {
        final docUser = FirebaseFirestore.instance.collection('orders').doc();

        final jsonDoc = OrderStoring(
            orderedBooks: listOfOrderedBookNames,
            grandTotal: grandTotalPrice,
            quantityOfBooks: listOfOrderedBookNames.length);

        try {
          await docUser.set(jsonDoc.toJson());
          Utilis.showSnackBar('Order stored successfully',
              color: Theme.of(context).colorScheme.primary);
        } on FirebaseException catch (_) {
          Utilis.showSnackBar('Failed in Placing order. Try again later');
          Navigator.of(context).pop();
        }
      }

      return GooglePayButton(
        paymentConfigurationAsset: 'gpay.json',
        paymentItems: _paymentItems,
        type: GooglePayButtonType.pay,
        height: 50,
        width: 200,
        onPaymentResult: (resultData) {
          print(resultData);
        },
        onPressed: (() => orderPlacing()),
        loadingIndicator: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    ;

    return SizedBox(
      height: 200,
      width: double.maxFinite,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Wrap(
            runSpacing: 10,
            children: [
              Text(
                'Checkout:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Your total book Ordered price:'),
                  Text(
                    'Rs. ' + checkoutTotalPrice.toString(),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Delivery Charges:'),
                  Text('Rs. 30'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Grand Total:'),
                  Text(
                    'Rs.' + grandTotalPrice.toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Text(
                '*Orders will be reach within 3-4 working days.',
                style: TextStyle(color: Colors.red),
              ),
              Center(
                child: SizedBox(width: 100, child: myPayButton()),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class OrderStoring {
  List<dynamic> orderedBooks;
  int quantityOfBooks;
  int grandTotal;
  String? email = FirebaseAuth.instance.currentUser!.email;
  OrderStoring({
    required this.orderedBooks,
    required this.quantityOfBooks,
    required this.grandTotal,
    this.email,
  });

  Map<String, dynamic> toJson() => {
        'Orders': orderedBooks,
        'grandtotal': grandTotal,
        'Email': email,
        'Quantity': quantityOfBooks
      };
}






// class DeliveringDetails extends StatefulWidget {
//   const DeliveringDetails({super.key});

//   @override
//   State<DeliveringDetails> createState() => _DeliveringDetailsState();
// }

// class _DeliveringDetailsState extends State<DeliveringDetails> {
//   @override
//   Widget build(BuildContext context) {
//     return ValueListenableBuilder(
//         valueListenable: 0,
//         builder: ((context, value, child) => Wrap(
//               runSpacing: 10,
//               children: [
//                 const Divider(
//                   thickness: 1,
//                   height: 20,
//                   indent: 40,
//                   endIndent: 50,
//                 ),
//                 const Text(
//                   'Delivering details',
//                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(15.0),
//                   child: Wrap(
//                     runSpacing: 6,
//                     children: [
//                       //1
//                       gettingTotalPrice(),
//                       //2
//                       deliveryCharges()
//                     ],
//                   ),
//                 )
//               ],
//             )));
//   }

//   gettingTotalPrice() => Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           const Text(
//             'Total price',
//             style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
//           ),
//           Text(
//             totalPrice.value.toString(),
//             style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
//           )
//         ],
//       );

//   deliveryCharges() => Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: const [
//           Text(
//             'Delivery changes',
//             style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
//           ),
//           Text(
//             '40',
//             style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
//           )
//         ],
//       );
// }
