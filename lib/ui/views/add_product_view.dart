import 'package:flutter/material.dart';
import 'package:todoApp/core/models/product.dart';
import 'package:todoApp/core/services/product_service.dart';

class AddProductView extends StatefulWidget {
  @override
  _AddProductViewState createState() => _AddProductViewState();
}

class _AddProductViewState extends State<AddProductView> {
  GlobalKey<FormState> formKey = GlobalKey(debugLabel: "formKey");

  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerPrice = TextEditingController();
  TextEditingController controllerImage = TextEditingController();

  String validator(val) {
    if (val.isEmpty) {
      return "Bu alan zorunludur.";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        autovalidate: true,
        key: formKey,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                    controller: controllerName,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: "Ürün İsmi"),
                    validator: this.validator),
                TextFormField(
                  controller: controllerPrice,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Fiyat",
                  ),
                  keyboardType: TextInputType.number,
                  validator: (val) {
                    if (val.isEmpty) {
                      return "Bu alan boş olamaz";
                    } else if (int.tryParse(val) == null) {
                      return "Lütfen nümerik karakterler giriniz.";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: controllerImage,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: "Resim",
                  ),
                  //validator: this.validator,
                ),
                RaisedButton.icon(
                  icon: Icon(Icons.send),
                  label: Text("Ekle"),
                  onPressed: () async {
                    if (formKey.currentState.validate()) {
                      var model = Product(
                          productName: controllerName.text,
                          //imageUrl: controllerImage.text,
                          imageUrl: "https://picsum.photos/seed/picsum/200/300",
                          price: int.parse(controllerPrice.text));
                      await ApiService.getInstance().addProducts(model);
                      Navigator.pop(context);
                    }
                  },
                  shape: StadiumBorder(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
