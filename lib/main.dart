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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Armstrong Number APP'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late int testnum;
  bool first_flag=true;
  bool _buttonEnabled = true; // 追踪按钮状态的变量
  late TextEditingController _textFieldController;
  String _result = '';

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
    // 如果_textFieldController.text为空，则返回
    if (_textFieldController.text.isEmpty) {
      _result = 'Please input a number';
      setState(() {});
      return;
    }
    _buttonEnabled = false; // 禁用按钮
    testnum=int.tryParse(_textFieldController.text) ?? 0; // 从输入框中获取数字 如果沒有數字就用0
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
        await Future.delayed(Duration(milliseconds: 100)); // 這邊要delay 100ms讓UI更新
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          //增加一段文字框
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: const Text(
                'Starting Number:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  height: 2,
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
