import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';
import '../widgets/app_drawer.dart';
import '../widgets/user_product_item.dart';
import 'edit_product_screen.dart';

class UserProductScreen extends StatelessWidget {
  static const routeName = '/user-product-screen';

  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<Products>(context, listen: false).fetchAndSet();
  }

  @override
  Widget build(BuildContext context) {
    final productsData1 = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your product'),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () => _refreshProducts(context),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListView.builder(
            itemBuilder: (_, index) => Column(
              children: <Widget>[
                UserProductItem(
                  productsData1.items[index].id,
                  productsData1.items[index].title,
                  productsData1.items[index].imageUrl,
                ),
                Divider(),
              ],
            ),
            itemCount: productsData1.items.length,
          ),
        ),
      ),
    );
  }
}
