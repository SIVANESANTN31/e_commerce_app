import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../api/cart_provider.dart';


class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Cart",
      style: TextStyle(color: Colors.white),),
      backgroundColor: Colors.indigoAccent,),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cart.items.length,
              itemBuilder: (context, index) {
                final item = cart.items.values.toList()[index];

                return ListTile(
                  leading: Image.network(item.thumbnail, width: 60),
                  title: Text(item.title),
                  subtitle: Text("\$${item.price}"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () => cart.decreaseQuantity(item.id),
                      ),
                      Text("${item.quantity}"),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () => cart.addToCart(item),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text("Amount Price", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text("\$${cart.totalPrice.toStringAsFixed(2)}", style: TextStyle(fontSize: 22, color: Colors.green)),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {},
                  child: Text("Check Out"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
