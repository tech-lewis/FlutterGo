import 'package:flutter/material.dart';
import 'package:hello_world/page_content.dart';
// 1. 新建文件 /pages/home/index.dart
// 2. 添加 material, page_content依赖
// 1. 需要准备 4 个 tab 内容区（tabView）
List<Widget> tabViewList=[
  PageContent(name:'首页'),
  PageContent(name:'搜索'),
  PageContent(name:'资讯'),
  PageContent(name:'我的'),
];
// 2. 需要准备 4 个 BottomNavigationBarItem

List<BottomNavigationBarItem> barItemList=[
  BottomNavigationBarItem(title: Text('首页'),icon: Icon(Icons.home)),
  BottomNavigationBarItem(title: Text('搜索'),icon: Icon(Icons.search)),
  BottomNavigationBarItem(title: Text('资讯'),icon: Icon(Icons.info)),
  BottomNavigationBarItem(title: Text('我的'),icon: Icon(Icons.account_circle)),
];

// 3. 编写无状态组件
class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
 int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  
      body:tabViewList[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items:barItemList,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        onTap: _onItemTapped,
      ),
    );
  }
}