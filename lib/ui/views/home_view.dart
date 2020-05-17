import 'package:flutter/material.dart';
import 'package:todoApp/core/models/product.dart';
import 'package:todoApp/core/services/product_service.dart';
import 'package:todoApp/ui/shared/widgets/custom_card.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  ApiService service = ApiService.getInstance();
  List<Product> productList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder<List<Product>>(
          future: service.getProducts(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                if (snapshot.hasData) {
                  productList = snapshot.data;
                  return _listView;
                }
                return Center(
                  child: Text("Error"),
                );
              default:
                return Center(
                  child: CircularProgressIndicator(),
                );
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.adb),
      ),
    );
  }

  Widget get _listView => ListView.separated(
      itemCount: productList.length,
      separatorBuilder: (context, index) => Divider(),
      itemBuilder: (context, index) => dismiss(
          CustomCard(
            title: productList[index].productName,
            subtitle: "${productList[index].price}",
            imageURL: productList[index].imageUrl,
          ),
          productList[index].key));

  Widget dismiss(Widget child, String key) {
    return Dismissible(
      child: child,
      key: UniqueKey(),
      secondaryBackground: Center(
        child: Text("Hello"),
      ),
      background: Container(
        color: Colors.red,
      ),
      onDismissed: (dismissDirection) async {
        await service.removeProducts(key);
      },
    );
  }
}
