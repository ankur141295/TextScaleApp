import 'package:flutter/material.dart';
import 'package:harivara_test/model/counter.dart';
import 'package:harivara_test/utils/app_constant.dart';
import 'package:provider/provider.dart';
import 'package:vector_math/vector_math.dart' hide Colors;

import 'utils/size_config.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late TextEditingController _controller1;
  late TextEditingController _controller2;

  @override
  void initState() {
    super.initState();
    _controller1 = TextEditingController()..addListener(_textFieldLength1);
    _controller2 = TextEditingController()..addListener(_textFieldLength2);
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    super.dispose();
  }

  void _textFieldLength1() {
    Provider.of<Counter>(context, listen: false)
        .updateCounter1(_controller1.text.length);
  }

  void _textFieldLength2() {
    Provider.of<Counter>(context, listen: false)
        .updateCounter2(_controller2.text.length);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (ctx, constraints) {
          SizeConfig().init(ctx, constraints);
          return _getBody();
        },
      ),
    );
  }

  PreferredSizeWidget _appBar() {
    return AppBar(
      title: const Center(
        child: Text(AppConstant.appbarTitle),
      ),
    );
  }

  Widget _getBody() {
    return Scaffold(
      appBar: _appBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          _columnFirstChild(),
          SizeConfig.verticalSpacer(5),
          Consumer<Counter>(builder: (context, value, child) {
            return _columnSecondChild(value);
          }),
        ],
      ),
    );
  }

  Widget _columnFirstChild() {
    return Row(
      children: [
        Expanded(
          child: _textFieldContainer(_controller1),
        ),
        Expanded(
          child: _textFieldContainer(_controller2),
        ),
      ],
    );
  }

  Widget _columnSecondChild(Counter value) {
    return Transform.rotate(
      angle: _rotationAngle(value.counter1, value.counter2),
      child: Container(
        margin: EdgeInsets.only(
          left: SizeConfig.relativeWidth(2),
          right: SizeConfig.relativeWidth(2),
        ),
        padding: EdgeInsets.all(
          SizeConfig.relativeWidth(3),
        ),
        color: Colors.blue,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _counterContainer("${value.counter1}"),
            _counterContainer("${value.counter2}")
          ],
        ),
      ),
    );
  }

  Widget _textFieldContainer(TextEditingController controller) {
    return Container(
      height: SizeConfig.relativeHeight(40),
      decoration: const BoxDecoration(
        border: Border(
          left: BorderSide(
            width: 3,
          ),
          top: BorderSide(
            width: 3,
          ),
          bottom: BorderSide(
            width: 3,
          ),
          right: BorderSide(width: 1.5),
        ),
      ),
      child: TextField(
        controller: controller,
        decoration: const InputDecoration(
          border: InputBorder.none,
        ),
        keyboardType: TextInputType.multiline,
        maxLines: null,
      ),
    );
  }

  Widget _counterContainer(String count) {
    return Container(
      width: SizeConfig.relativeWidth(15),
      padding: EdgeInsets.all(
        SizeConfig.relativeWidth(1),
      ),
      color: Colors.white,
      child: Center(child: Text(count)),
    );
  }

  ///Negative value left side down, Positive value right side down
  double _rotationAngle(int count1, int count2) {
    if (count1 == count2) {
      return radians(0);
    } else if (count1 > count2) {
      int difference = count1 - count2;
      difference = difference - (difference * 2);
      return (radians(difference.toDouble()));
    } else {
      int difference = count2 - count1;
      return (radians(difference.toDouble()));
    }
  }
}
