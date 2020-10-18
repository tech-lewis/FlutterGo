import 'package:flutter/material.dart';
import 'package:hello_world/page_content.dart';
class NotFoundPage  extends StatelessWidget{
  const NotFoundPage({Key key}): super(key: key);

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      appBar: AppBar(title: Text('404')),
      body: 
        Text('Hello, world!当前页面没找到',
          key: Key('title'),
          textDirection: TextDirection.ltr
        )
    );
  }
}