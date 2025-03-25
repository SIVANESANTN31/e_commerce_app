import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../api/api_service.dart';
import '../api/cart_provider.dart';
import '../api/product_model.dart';
import 'cart_screen.dart';


class CatalogueScreen extends StatefulWidget {
  @override
  _CatalogueScreenState createState() => _CatalogueScreenState();
}

class _CatalogueScreenState extends State<CatalogueScreen> {
  late Future<List<Product>> products;

  @override
  void initState() {
    super.initState();
    products = ApiService.fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Catalogue",
        style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.indigoAccent,
        actions: [
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.shopping_cart,
                color: Colors.white,),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CartScreen()),
                  );
                },
              ),
              Positioned(
                right: 5,
                top: 5,
                child: CircleAvatar(
                  radius: 10,
                  backgroundColor: Colors.red,
                  child: Text(
                    cart.itemCount.toString(),
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: FutureBuilder<List<Product>>(
        future: products,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error fetching products"));
          } else {
            return GridView.builder(
              padding: EdgeInsets.all(8.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.75,
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final product = snapshot.data![index];

                return Card(
                  elevation: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Stack(children: [Center(child: Image.network(product.thumbnail, fit: BoxFit.cover)),
                           Align(
        alignment: Alignment.bottomRight,
        child: ElevatedButton(
          onPressed: () => cart.addToCart(product),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
          ),
          child: const Text("Add", style: TextStyle(color: Colors.black)),
        ),),]),
                          ),
                        ),
                      ),
                      
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(child: Text(product.title, style: TextStyle(fontWeight: FontWeight.bold))),
                            Divider(),
                            Text("\$${product.price}", style: TextStyle(color: Colors.green)),
                            Text("${product.discountPercentage}% OFF", style: TextStyle(color: Colors.red)),
                          ],
                        ),
                      ),
                      // Center(
                      //   child: ElevatedButton(
                      //     onPressed: () => cart.addToCart(product),
                      //     child: Text("Add"),
                      //   ),
                      // ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
