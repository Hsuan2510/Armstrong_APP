import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Armstrong Number APP',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Armstrong Number APP'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int testnum=0;
  bool first_flag=true;
  bool _buttonEnabled = true; // 追踪按钮状态的变量
  late TextEditingController _textFieldController;
  String _result = '';
  // late 是指定类型的变量，但不初始化，可以在后面初始化
  // TextEditingController 是一个控制文本输入的控制器

  @override
  void initState() {
    super.initState();
    _textFieldController = TextEditingController();
  }

  @override
  void dispose() {
    _textFieldController.dispose(); // 释放资源
    super.dispose(); // 调用父类的 dispose 方法
  }

  Future<void> _FindNextNumber1() async {
    _buttonEnabled = false; // 禁用按钮
    testnum=int.tryParse(_textFieldController.text) ?? 0;
    while(true){
      int sum = 0;
      int temp = testnum;
      int n = testnum.toString().length;
      while (temp != 0) {
        if (n==1){
          sum += temp;
          break;
        }
        final int remainder = temp % 10;
        int plus = 1;
        for (int i = 0; i < n; i++) {
          plus = plus * remainder;
        }
        sum += plus;
        temp ~/= 10; // 除以 10
      }
      if (testnum == sum) {
        _result = 'The next number is $testnum';
        first_flag=false;
        break;
      } else {
        _result = '$testnum';
        // 這邊要delay 100ms讓UI更新
        // 增加数字并延迟 100 毫秒
        await Future.delayed(Duration(milliseconds: 100));
        testnum++;
      }
      setState(() {});
    }
    setState(() {
      _buttonEnabled = true; // 启用按钮
    });
  }
  Future<void> _FindNextNumber2() async {
    _buttonEnabled = false; // 禁用按钮
    testnum=testnum+1;
    while(true){
      int sum = 0;
      int temp = testnum;
      int n = testnum.toString().length;
      while (temp != 0) {
        if (n==1){
          sum += temp;
          break;
        }
        final int remainder = temp % 10;
        int plus = 1;
        for (int i = 0; i < n; i++) {
          plus = plus * remainder;
        }
        sum += plus;
        temp ~/= 10; // 除以 10
      }
      if (testnum == sum) {
        _result = 'The next number is $testnum';
        first_flag=false;
        break;
      } else {
        _result = '$testnum';
        // 這邊要delay 100ms讓UI更新
        // 增加数字并延迟 100 毫秒
        await Future.delayed(Duration(milliseconds: 100));
        testnum++;
      }
      setState(() {});
    }
    setState(() {
      _buttonEnabled = true; // 启用按钮
    });
  }
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          //增加一段文字框
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: const Text(
                'Starting Number:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10), // 间距
            TextField(
              controller: _textFieldController,
              decoration: const InputDecoration(
                hintText: 'input Number...',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')), // 只允许输入数字
              ],
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: _buttonEnabled ?_FindNextNumber1 : null,
                child: const Text('Find next number', style: TextStyle(fontSize: 20),),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Text(
                _result,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: _buttonEnabled ?_FindNextNumber2 : null,
                child: const Text('Find next number', style: TextStyle(fontSize: 20),),
              ),
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
