import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:add_to_cart_animation/add_to_cart_icon.dart';
import 'package:flutter/material.dart';
import 'package:kfc/model/product_model.dart';
import 'package:kfc/model/size_model.dart';
import 'package:kfc/pages/details/widgets/order_button.dart';
import 'package:kfc/pages/details/widgets/product_size.dart';
import 'package:kfc/widgets/fade_in_down.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key, required this.product});

  final ProductModel product;

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final List<SizeModel> sizes = [
    SizeModel(name: "small", qty: "12 Fl Oz"),
    SizeModel(name: "medium", qty: "16 Fl Oz"),
    SizeModel(name: "large", qty: "24 Fl Oz"),
    SizeModel(name: "xl", qty: "__ Fl Oz"),
  ];

  int selectedSize = 2;
  int quantity = 1;
  GlobalKey<CartIconKey> cartKey = GlobalKey<CartIconKey>();
  GlobalKey imageGlobalKey = GlobalKey();
  late Function(GlobalKey) runAddToCartAnimation;
  var _cartQuantityItems = 0;

  void listClick(GlobalKey widgetKey) async {
    await runAddToCartAnimation(widgetKey);
    await cartKey.currentState!
        .runCartAnimation((++_cartQuantityItems).toString());
  }

  void incrementQuantity() {
    setState(() {
      quantity++;
    });
  }

  void decrementQuantity() {
    setState(() {
      if (quantity > 1) {
        quantity--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AddToCartAnimation(
      cartKey: cartKey,
      height: 30,
      width: 30,
      opacity: 0.85,
      dragAnimation: const DragToCartAnimationOptions(
        rotation: true,
      ),
      jumpAnimation: const JumpAnimationOptions(),
      createAddToCartAnimation: (runAddToCartAnimation) {
        this.runAddToCartAnimation = runAddToCartAnimation;
      },
      child: Scaffold(
        // backgroundColor: const Color.fromARGB(255, 234, 255, 180),
        backgroundColor: const Color(0xffffdfa4),

        appBar: AppBar(
          backgroundColor: const Color(0xffffdfa4),
          title: Text('Details'),
          centerTitle: false,
          actions: [
            IconButton(
              icon: const Icon(Icons.cleaning_services),
              onPressed: () {
                setState(() {
                  _cartQuantityItems = 0;
                });
                cartKey.currentState!.runClearCartAnimation();
              },
            ),
            const SizedBox(width: 16),
            AddToCartIcon(
              key: cartKey,
              icon: const Icon(Icons.shopping_cart),
              badgeOptions: const BadgeOptions(
                active: true,
                backgroundColor: Colors.red,
              ),
            ),
            const SizedBox(
              width: 16,
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.sizeOf(context).height / 2.5,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Hero(
                      tag: widget.product.name,
                      child: Container(
                        key: imageGlobalKey,
                        child: Image.asset(
                          widget.product.image,
                          height: MediaQuery.sizeOf(context).height,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              FadeInDown(
                delay: const Duration(milliseconds: 200),
                duration: const Duration(milliseconds: 500),
                from: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Text(
                        widget.product.name,
                        style: const TextStyle(
                            fontSize: 26, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "\₹${widget.product.price.toStringAsFixed(2)}",
                          style: TextStyle(
                              fontSize: 28,
                              color: Color(0xfffe6d02),
                              fontWeight: FontWeight.bold),
                        ),
                        const Text(
                          "Best Sale",
                          style: TextStyle(
                            fontSize: 12,
                            color: const Color(0xfffeae11),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              FadeInDown(
                delay: const Duration(milliseconds: 400),
                duration: const Duration(milliseconds: 500),
                from: 50,
                child: const Text(
                  "Size Options",
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xfffe6d02),
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              FadeInDown(
                delay: const Duration(milliseconds: 600),
                duration: const Duration(milliseconds: 500),
                from: 50,
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      for (var i = 0; i < sizes.length; i++)
                        GestureDetector(
                          onTap: () => setState(() {
                            selectedSize = i;
                          }),
                          child: ProductSize(
                              isSelected: selectedSize == i,
                              iconSize: 25 + (i * 5),
                              sizes: sizes[i]),
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
        bottomNavigationBar: OrderButton(
          quantity: quantity,
          increment: incrementQuantity,
          decrement: decrementQuantity,
          onAddToOrder: () => listClick(imageGlobalKey),
        ),
      ),
    );
  }
}
