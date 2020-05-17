class Product {
  String imageUrl;
  int price;
  String productName;
  String key;

  Product({this.imageUrl, this.price, this.productName});

  Product.fromJson(Map<String, dynamic> json) {
    imageUrl = json['imageUrl'];
    price = json['price'];
    productName = json['productName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imageUrl'] = this.imageUrl;
    data['price'] = this.price;
    data['productName'] = this.productName;
    return data;
  }
}

class ProductList {
  List<Product> products = [];

  ProductList.fromJsonList(Map value) {
    value.forEach((key, value) {
      var product = Product.fromJson(value);
      product.key = key;
      products.add(product);
    });
  }
}
