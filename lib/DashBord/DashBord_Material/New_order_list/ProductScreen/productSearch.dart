import 'package:flutter/material.dart';
import 'package:animation_search_bar/animation_search_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SeachProductView extends StatefulWidget {
  const SeachProductView({Key? key}) : super(key: key);

  @override
  State<SeachProductView> createState() => _SeachProductViewState();
}

class _SeachProductViewState extends State<SeachProductView> {
  TextEditingController textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size(double.infinity, 65),
          child: SafeArea(
              child: Container(
            decoration: const BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                  color: Colors.black26,
                  blurRadius: 5,
                  spreadRadius: 0,
                  offset: Offset(0, 5))
            ]),
            alignment: Alignment.center,
            child: AnimationSearchBar(
                backIcon: FontAwesomeIcons.arrowLeft,
                backIconColor: Colors.black,
                centerTitle: 'Search Product',
                onChanged: (text) => debugPrint(text),
                searchTextEditingController: textController,
                horizontalPadding: 5),
          ))),
      body: Container(
        height: 500,
        width: double.infinity,
        color: Colors.red,
      ),
    );
  }
}
