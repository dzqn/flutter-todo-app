import 'package:flutter/material.dart';
import 'package:todoApp/core/models/product.dart';
import 'package:todoApp/core/services/product_service.dart';
import 'package:todoApp/ui/shared/widgets/custom_card.dart';
import 'package:todoApp/ui/views/add_product_view.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  ApiService service = ApiService.getInstance();
  List<Product> productList = [];
  Color color = Colors.white; // fake değişken (Kullanılmıyor)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List of Product"),
      ),
      floatingActionButton: _fabButton,
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
        },
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
        child: Text("Siliniyor"),
      ),
      background: Container(
        color: Colors.red,
      ),
      onDismissed: (dismissDirection) async {
        await service.removeProducts(key);
      },
    );
  }

  Widget get _fabButton => FloatingActionButton(
        onPressed: fabPressed,
        child: Icon(Icons.add),
      );

  void fabPressed() {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
        context: context,
        builder: (context) => bottomSheet);
  }

  Widget get bottomSheet => Container(
        height: 100,
        child: Column(
          children: <Widget>[
            Divider(
              thickness: 2,
              indent: 100,
              endIndent: 100,
              color: Colors.grey,
            ),
            RaisedButton(
              child: Text("Ekle"),
              onPressed: () {
                Navigator.pop(context);
                Navigator.of(context)
                    .push(MaterialPageRoute(
                        builder: (context) => AddProductView()))
                    .then((value) => {
                          // Geri gelince sayfanın yenilenmesi için fake yapıldı
                          setState(() {
                            color = color == Colors.white
                                ? Colors.grey
                                : Colors.white;
                          })
                        });
              },
            )
          ],
        ),
      );
}
