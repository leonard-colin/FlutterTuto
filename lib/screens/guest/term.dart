// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:leadeetuto/main.dart';

class TermScreen extends StatefulWidget {
  const TermScreen({super.key});

  @override
  State<TermScreen> createState() => _TermScreenState();
}

class _TermScreenState extends State<TermScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: 0.0,
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Text(
            "Terms & Conditions",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.black,
            onPressed: () {},
          ),
        ),
        body: Padding(
          padding: EdgeInsets.only(
            left: 20.0,
            right: 20.0,
            bottom: 15.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                          "Lorem ipsum dolor sit amet. Ut maiores dolorum ut nemo error non eligendi autem. Qui dolor doloribus sit veniam dolorem nam illum quia sit sint iste est incidunt corporis. Sed libero officia At temporibus amet sit numquam dicta ex voluptatum quisquam non pariatur distinctio? Id minima vitae sed excepturi fugiat eos modi vero qui repudiandae magnam sit nisi laudantium. Eos ipsam commodi eum commodi aliquam aut iste dolor? Nam atque voluptatem qui debitis facilis sed omnis obcaecati est quis repudiandae et facere quam. Qui mollitia quod qui asperiores nihil est architecto cupiditate fuga nisi cum praesentium dolorem et minima voluptate. Et tenetur culpa et alias dolores eos alias dignissimos!Lorem ipsum dolor sit amet. Ut maiores dolorum ut nemo error non eligendi autem. Qui dolor doloribus sit veniam dolorem nam illum quia sit sint iste est incidunt corporis. Sed libero officia At temporibus amet sit numquam dicta ex voluptatum quisquam non pariatur distinctio Id minima vitae sed excepturi fugiat eos modi vero qui repudiandae magnam sit nisi laudantium. Eos ipsam commodi eum commodi aliquam aut iste dolor? Nam atque voluptatem qui debitis facilis sed omnis obcaecati est quis repudiandae et facere quam Qui mollitia quod qui asperiores nihil est architecto cupiditate fuga nisi cum praesentium dolorem et minima voluptate. Et tenetur culpa et alias dolores eos alias dignissimos!  Lorem ipsum dolor sit amet. Ut maiores dolorum ut nemo error non eligendi autem. Qui dolor doloribus sit veniam dolorem nam illum quia sit sint iste est incidunt corporis. Sed libero officia At temporibus amet sit numquam dicta ex voluptatum quisquam non pariatur distinctio? Id minima vitae sed excepturi fugiat eos modi vero qui repudiandae magnam sit nisi laudantium. Eos ipsam commodi eum commodi aliquam aut iste dolor? Nam atque voluptatem qui debitis facilis sed omnis obcaecati est quis repudiandae et facere quam. Qui mollitia quod qui asperiores nihil est architecto cupiditate fuga nisi cum praesentium dolorem et minima voluptate. Et tenetur culpa et alias dolores eos alias dignissimos!Lorem ipsum dolor sit amet. Ut maiores dolorum ut nemo error non eligendi autem. Qui dolor doloribus sit veniam dolorem nam illum quia sit sint iste est incidunt corporis. Sed libero officia At temporibus amet sit numquam dicta ex voluptatum quisquam non pariatur distinctio Id minima vitae sed excepturi fugiat eos modi vero qui repudiandae magnam sit nisi laudantium. Eos ipsam commodi eum commodi aliquam aut iste dolor? Nam atque voluptatem qui debitis facilis sed omnis obcaecati est quis repudiandae et facere quam Qui mollitia quod qui asperiores nihil est architecto cupiditate fuga nisi cum praesentium dolorem et minima voluptate. Et tenetur culpa et alias dolores eos alias dignissimos!  Lorem ipsum dolor sit amet. Ut maiores dolorum ut nemo error non eligendi autem. Qui dolor doloribus sit veniam dolorem nam illum quia sit sint iste est incidunt corporis. Sed libero officia At temporibus amet sit numquam dicta ex voluptatum quisquam non pariatur distinctio? Id minima vitae sed excepturi fugiat eos modi vero qui repudiandae magnam sit nisi laudantium. Eos ipsam commodi eum commodi aliquam aut iste dolor? Nam atque voluptatem qui debitis facilis sed omnis obcaecati est quis repudiandae et facere quam. Qui mollitia quod qui asperiores nihil est architecto cupiditate fuga nisi cum praesentium dolorem et minima voluptate. Et tenetur culpa et alias dolores eos alias dignissimos!Lorem ipsum dolor sit amet. Ut maiores dolorum ut nemo error non eligendi autem. Qui dolor doloribus sit veniam dolorem nam illum quia sit sint iste est incidunt corporis. Sed libero officia At temporibus amet sit numquam dicta ex voluptatum quisquam non pariatur distinctio Id minima vitae sed excepturi fugiat eos modi vero qui repudiandae magnam sit nisi laudantium. Eos ipsam commodi eum commodi aliquam aut iste dolor? Nam atque voluptatem qui debitis facilis sed omnis obcaecati est quis repudiandae et facere quam Qui mollitia quod qui asperiores nihil est architecto cupiditate fuga nisi cum praesentium dolorem et minima voluptate. Et tenetur culpa et alias dolores eos alias dignissimos!"),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    vertical: 15.0,
                  ),
                  backgroundColor: Theme.of(context).primaryColor,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                ),
                onPressed: () => print("accept"),
                child: Text(
                  "accept & continue".toUpperCase(),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
