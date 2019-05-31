import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class DetailsScreen extends StatelessWidget {
  final jobInformation;
  DetailsScreen({@required this.jobInformation});

  Widget companyCard(String name, String location, String image) => Card(
        color: Colors.grey[50],
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new Padding(
              padding: new EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
              child: Image.network(
                image,
                width: 70,
              ),
            ),
            ListTile(
              title: new Text(name),
              subtitle: new Text(location),
            ),
          ],
        ),
      );

  Widget applyButton() => const FlatButton(
      color: Colors.blueGrey,
      disabledColor: Colors.blueGrey,
      disabledTextColor: Colors.white,
      textColor: Colors.white,
      onPressed: null,
      child: Text("APPLY", style: TextStyle(fontSize: 20)));

  Widget contentCard(String content) => Card(
      color: Colors.grey[50],
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new Padding(
              padding: EdgeInsets.only(
                  top: 10.0, bottom: 30.0, left: 10.0, right: 10.0),
              child: Html(data: """${content}""")),
          this.applyButton(),
          Padding(
            padding: EdgeInsets.only(bottom: 25.0),
          ),
        ],
      ));

  Widget jobTitleWidget(String jobTitle) => Text(
        jobTitle,
        style: TextStyle(
          fontWeight: FontWeight.w700, // lightr
          fontSize: 25,
          color: Colors.white,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Detail Screen',
      home: Scaffold(
          appBar: AppBar(
              title: Text(this.jobInformation.title),
              backgroundColor: Colors.blueGrey[900],
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              )),
          body: SingleChildScrollView(
              child: Center(
                  child: Column(children: <Widget>[
            Container(
                width: 800,
                height: 200,
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                    image: NetworkImage(
                        "https://backgroundcheckall.com/wp-content/uploads/2017/12/background-work-2.jpg"),
                    fit: BoxFit.fill,
                  ),
                ),
                child: new BackdropFilter(
                  filter: new ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
                  child: new Container(
                    decoration:
                        new BoxDecoration(color: Colors.white.withOpacity(0.0)),
                  ),
                )
/* add child content here */
                ),
            Container(
                padding: EdgeInsets.only(left: 15.0, right: 15.0),
                transform: Matrix4.translationValues(0.0, -100.0, 0.0),
                child: Column(
                  children: <Widget>[
                    this.jobTitleWidget(this.jobInformation.title),
                    Padding(
                      padding: EdgeInsets.only(top: 10.0),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.0),
                    ),
                    Center(
                      child: this.companyCard(
                          this.jobInformation.company,
                          this.jobInformation.location,
                          this.jobInformation.companyLogo),
                    ),
                    this.contentCard(this.jobInformation.description)
                  ],
                ))
          ])))),
    );
  }
}
