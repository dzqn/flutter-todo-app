import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imageURL;

  const CustomCard({Key key, this.title, this.subtitle, this.imageURL})
      : assert(imageURL != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 15,
      child: ListTile(
        title: Text(
          this.title,
        ),
        subtitle: Text(this.subtitle),
        trailing: imagePlace,
      ),
    );
  }

  Widget get imagePlace {
    return imageURL.isEmpty
        ? Container(
            child: Placeholder(),
          )
        : Image.network(imageURL);
  }
}
