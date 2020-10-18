import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hello_world/routes.dart';

class PageContent  extends StatelessWidget{
  final String name;

  const PageContent({Key key, this.name}): super(key: key);

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      appBar: AppBar(title: Text('当前页面: $name')),
      body: ListView(children: <Widget>[
        //
        FlatButton(child: Text(Routes.home), onPressed: (){
            Navigator.pushNamed(ctx, Routes.home);
        },) ,
        FlatButton(child: Text(Routes.login), onPressed: (){
            Navigator.pushNamed(ctx, Routes.login);
        },) ,
        FlatButton(
          child: Text('房屋详情页，id：房屋信息'),
          onPressed: () {
            Navigator.pushNamed(ctx, '/room/666');
          },
        ),      
        FlatButton(child: Text('404页面处理'), onPressed: (){
            Navigator.pushNamed(ctx, '/404');
          },) ,
        ],
      ),
    );
  }
}