import 'package:flutter/material.dart';
import 'package:todoApp/ui/shared/widgets/custom_card.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.separated(
          itemBuilder: (context, index) {
            return CustomCard(
              title: "aaaaaa",
              subtitle: "$index",
              imageURL: "https://picsum.photos/200/300",
            );
          },
          separatorBuilder: (context, index) {
            return Divider();
          },
          itemCount: 5),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.adb),
      ),
    );
  }
}
