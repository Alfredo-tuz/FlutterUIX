
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BasicAnimationPage extends StatefulWidget {

  @override
  _BasicAnimationPageState createState() => _BasicAnimationPageState();
}

class _BasicAnimationPageState extends State<BasicAnimationPage> with TickerProviderStateMixin{

  AnimationController _controller;
  Animation<double> _counter;
  Animation<Color> _color;

  bool _isCompleted = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(duration: Duration(seconds: 1),vsync: this);
    _counter = Tween<double>(begin:0,end: 1).animate(_controller);
    _color = ColorTween(begin: Colors.redAccent,end:Colors.green).animate(_controller);

    _counter.addListener((){
      setState(() {
          _isCompleted=_controller.status == AnimationStatus.completed;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
       body: Container(
         width: double.infinity,
         height: double.infinity,
         child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children: <Widget>[
             Text(_counter.value.toStringAsFixed(2),
             style: TextStyle(
               fontSize: 40,
               color:_color.value
              )
             ),
             SizedBox(height: 20,),
             CupertinoButton(
               child: Text('Start'), 
               onPressed: (){
                  if(_isCompleted){
                    _controller.reverse();
                  }else{
                    _controller.forward(from:0);//Start animation
                  }
               }
            )
           ],
         ),
       ),
    );
  }
}