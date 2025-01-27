import 'package:flutter/material.dart';

class CartWidget extends StatelessWidget {
  const CartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Icon(Icons.shopping_cart_outlined ,
        size: 55,
      ),
    );
  }
}
