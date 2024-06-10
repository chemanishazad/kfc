import 'package:flutter/material.dart';
import 'package:kfc/widgets/fade_in_down.dart';

class OrderButton extends StatelessWidget {
  final int quantity;
  final Function()? increment;
  final Function()? decrement;
  final Function()? onAddToOrder;

  const OrderButton({
    required this.quantity,
    required this.increment,
    required this.decrement,
    required this.onAddToOrder,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FadeInDown(
      delay: const Duration(milliseconds: 800),
      duration: const Duration(milliseconds: 500),
      from: 50,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Theme.of(context).primaryColor,
                    minimumSize: const Size(35, 35),
                    padding: const EdgeInsets.symmetric(horizontal: 22),
                    shape: const CircleBorder(),
                    elevation: 0,
                  ),
                  onPressed: quantity > 1 ? decrement : null,
                  child: const Text('-', style: TextStyle(fontSize: 18)),
                ),
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Text(
                    "$quantity",
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Theme.of(context).primaryColor,
                    minimumSize: const Size(35, 35),
                    padding: const EdgeInsets.symmetric(horizontal: 22),
                    shape: const CircleBorder(),
                    elevation: 0,
                  ),
                  onPressed: increment,
                  child: const Text(
                    '+',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Theme.of(context).primaryColor,
                minimumSize: const Size(180, 50),
                padding: const EdgeInsets.symmetric(horizontal: 30),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
                elevation: 0,
              ),
              onPressed: onAddToOrder,
              child: const Text('Add to Order', style: TextStyle(fontSize: 15)),
            ),
          ],
        ),
      ),
    );
  }
}
