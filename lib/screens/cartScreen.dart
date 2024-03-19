import 'package:elma/api/api_cart.dart';
import 'package:elma/constants/ability.dart';
import 'package:elma/constants/constant.dart';
import 'package:elma/screens/paymentMethod.dart';
import 'package:elma/widgets/container_button_model.dart';
import 'package:flutter/material.dart';

import '../models/cart.dart';

class CartScreen extends StatefulWidget {
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List imageList = [
    "images/Ip15.jpg",
    "images/lapdell.jpg",
    "images/pc.jpg",
    "images/Sony.jpg",
    "images/pc.jpg",
    "images/Sony.jpg",
  ];

  List productTitles = ["Mobile", "Laptop", "PC", "Air", "PC", "Air"];

  List reviews = ["54", "100", "789", "34", "789", "34"];
  List quantity = ["54", "100", "789", "34", "789", "34"];

  List prices = ["1.300.000", "1.300.000", "1.300.000", "1.300.000", "1.300.000", "1.300.000"];
  
  Future<List<Cart>> getCart() async {
    return APICart.getCart(Ability.user!.id!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Cart",
        ),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        leading: BackButton(),
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder(
              future: getCart(),
              builder: (context, snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator(),);
                }
                else if(snapshot.hasError) {
                  print(snapshot.error.toString());
                  return const Center(child: CircularProgressIndicator(),);
                }
                else {
                  final data = snapshot.data;
                  return Container(
                    height: 400,
                    child: SingleChildScrollView(
                      child: Column(
                        children: List.generate(data!.length, (index) {
                          return cartItem(data![index]);
                        }),
                      ),
                    ),
                  );
                }
              },
            ),
            Expanded(child: Container()),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Select All",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Checkbox(
                    splashRadius: 20,
                    activeColor: Color(0xFF5C6AC4),
                    value: false,
                    onChanged: (val) {})
              ],
            ),
            Divider(
              height: 20,
              thickness: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total Payment",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "\$300.50",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF5C6AC4),
                  ),
                )
              ],
            ),
            SizedBox(height: 50),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (Context) => PaymentMethod()));
              },
              child: ContainerButtonModel(
                itext: "Checkout",
                containerWidth: MediaQuery.of(context).size.width,
                bgColor: Color(0xFF5C6AC4),
                frColor: kWhiteColor,
              ),
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      )
    );
  }

  Widget cartItem(Cart cart) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 15),
        child: Row(
            children: [
              Checkbox(
                  splashRadius: 20,
                  activeColor: Color(0xFF5C6AC4),
                  value: true,
                  onChanged: (val) {}),
              ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    cart.product!.image!,
                    height: 70,
                    width: 70,
                    fit: BoxFit.cover,
                  )),
              const SizedBox(width: 10,),
              Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 150,
                    child: Text(
                      cart.product!.name!,
                      style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w600,
                          fontSize: 13),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(numberFormatted(cart.product!.price!.first),
                      style: TextStyle(
                          color: Color(0xFF5C6AC4),
                          fontWeight: FontWeight.w900,
                          fontSize: 16)),
                  SizedBox(height: 5,),
                  Row(

                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {

                        },
                        child: Icon(
                          Icons.remove_circle_outline,
                          color: Color(0xFF5C6AC4),
                        ),
                      ),
                      SizedBox(width: 5,),
                      Container(
                        width: 30,
                        height: 30,
                        color: Color.fromARGB(255, 227, 224, 224),
                        // alignment: Alignment.center,
                        child: TextField(
                          enabled: false,
                           // Căn giữa nội dung
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: cart.quantity.toString(),
                            hintStyle: TextStyle(
                              color: Color(0xFF5C6AC4),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 5,),
                      InkWell(
                        onTap: () {

                        },
                        child: Icon(
                          Icons.add_circle_outline,
                          color: Color(0xFF5C6AC4),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ]));
  }

}
