import 'package:flutter/material.dart';


class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
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
