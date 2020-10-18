//library hello_world; 20150729 iOS info.plist
import 'package:sky/widgets.dart';

class HelloWorldApp extends App {
  Widget build() {
    return new Text('Hello, world!');
    //Center(child: new Text('Hello, world!'))
    // DSL布局方式的改变
  }
}

void main() {
  runApp(new HelloWorldApp());
}