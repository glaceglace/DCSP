import 'dart:math';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:flutter/foundation.dart';
import 'dart:developer';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _State createState() => new _State();
}

class _State extends State<MyApp> {
  double _heading = 0;
  double _vor1 = 90;
  double _vor2 = 120;
  double _azimuth1To2 = 0;
  double _distance = 0;
  double _vor1ToODis = 0;
  double _vor2ToODis = 0;
  double _az1ToO = 0;
  double _az2ToO = 0;
  final double _pie = 3.14159;

  void calculate() {

    double alpha = (this._vor1 - this._vor2).abs();
    double beta = (((_heading + _vor1) % 360) - 180 - _azimuth1To2).abs() % 360;
    double gamma = 180 - alpha - beta;

    double vor2ToDis =
        sin(beta * this._pie / 180) * _distance / sin(alpha * this._pie / 180);
    double vor1ToODis =
        sin(gamma * this._pie / 180) * _distance / sin(alpha * this._pie / 180);
    double az2ToO = (this._heading + this._vor1) % 360 - _azimuth1To2;
    double az1ToO = az2ToO + _heading;
print("alpha:$alpha");
print("beta:$beta");
print("gamma:$gamma");
    this.setState(() {
      this._vor2ToODis = vor2ToDis;
      this._vor1ToODis = vor1ToODis;
      this._az2ToO = az2ToO;
      this._az1ToO = az1ToO;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DCS Positioning',
      home: Scaffold(
          appBar: AppBar(
            title: Text('DCS Positioning'),
          ),
          body: Container(
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Row(
              children: [
                getMultipleNeedleExample(false, _heading, _vor1, _vor2),
                Container(
                  width: 500,
                  child: Column(
                      
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Slider(
                              value: _heading.toDouble(),
                              min: 0.0,
                              max: 359,
                              divisions: 360,
                              activeColor: Colors.red,
                              inactiveColor: Colors.black,
                              label: "Heading: ${this._heading.round()}",
                              onChanged: (double newValue) {
                                setState(() {
                                  _heading = newValue;
                                });
                              },
                              semanticFormatterCallback: (double newValue) {
                                return '${newValue.round()}';
                              }),
                          Slider(
                              value: _vor1.toDouble(),
                              min: 0.0,
                              max: 359,
                              divisions: 360,
                              activeColor: Colors.blue,
                              inactiveColor: Colors.black,
                              label: "Station 1: ${this._vor1.round()}",
                              onChanged: (double newValue) {
                                setState(() {
                                  _vor1 = newValue;
                                });
                              },
                              semanticFormatterCallback: (double newValue) {
                                return '${newValue.round()}';
                              }),
                          Slider(
                              value: _vor2.toDouble(),
                              min: 0.0,
                              max: 359,
                              divisions: 360,
                              activeColor: Colors.green,
                              inactiveColor: Colors.black,
                              label: "Station 2: ${this._vor2.round()}",
                              onChanged: (double newValue) {
                                setState(() {
                                  _vor2 = newValue;
                                });
                              },
                              semanticFormatterCallback: (double newValue) {
                                return '${newValue.round()}';
                              })
                        ])
                  
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.my_location,
                  color: Colors.blue,
                  size: 50.0,
                  semanticLabel: 'Station 1',
                ),
                Column(children: [
                  Container(
                      width: 200,
                      child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Azimuth',
                          ),
                          onChanged: (text) {
                            this._azimuth1To2 = double.parse(text) % 360;
                          })),
                  Text(
                      ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"),
                  Container(
                    width: 200,
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Distance',
                      ),
                      onChanged: (text) {
                        this._distance = double.parse(text);
                      },
                    ),
                  )

                  /*
                    Image.asset("assets/arrow.png",
                height: 5,
                width: 500,
                fit: BoxFit.fitWidth,
                )
                */
                ]),
                Icon(
                  Icons.my_location,
                  color: Colors.green,
                  size: 50.0,
                  semanticLabel: 'Station 2',
                )
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            RaisedButton(
              onPressed: () {
                this.calculate();
              },
              child:
                  const Text('Calculate', style: TextStyle(fontSize: 20)),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.my_location,
                        color: Colors.blue,
                        size: 50.0,
                        semanticLabel: 'Station 1',
                      ),
                      Column(children: [
                        Text("${this._az1ToO}"),
                        Text(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"),
                        Text("${this._vor1ToODis}")

                        /*
                    Image.asset("assets/arrow.png",
                height: 5,
                width: 500,
                fit: BoxFit.fitWidth,
                )
                */
                      ]),
                      Icon(
                        Icons.my_location,
                        color: Colors.red,
                        size: 50.0,
                        semanticLabel: 'Station 2',
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.my_location,
                        color: Colors.green,
                        size: 50.0,
                        semanticLabel: 'Station 1',
                      ),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("${this._az2ToO}"),
                            Text(
                                ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"),
                            Text("${this._vor2ToODis}")

                            /*
                    Image.asset("assets/arrow.png",
                height: 5,
                width: 500,
                fit: BoxFit.fitWidth,
                )
                */
                          ]),
                      Icon(
                        Icons.my_location,
                        color: Colors.red,
                        size: 50.0,
                        semanticLabel: 'Station 2',
                      )
                    ],
                  ),
                ],
              ),
            )
          ]))),
    );
  }

  SfRadialGauge getMultipleNeedleExample(
      bool isTileView, double heading, double vor1, double vor2) {
    return SfRadialGauge(
      key: kIsWeb ? UniqueKey() : null,
      axes: <RadialAxis>[
        RadialAxis(
            showAxisLine: false,
            radiusFactor: kIsWeb ? 0.43 : 0.5,
            startAngle: 270,
            endAngle: 270,
            minimum: 0,
            maximum: 360,
            showFirstLabel: false,
            interval: 30,
            labelOffset: 10,
            minorTicksPerInterval: 5,
            onLabelCreated: mainAxisLabelCreated,
            axisLabelStyle: GaugeTextStyle(fontSize: 10),
            minorTickStyle: MinorTickStyle(
                lengthUnit: GaugeSizeUnit.factor, length: 0.03, thickness: 1),
            majorTickStyle:
                MajorTickStyle(lengthUnit: GaugeSizeUnit.factor, length: 0.1)),
        RadialAxis(
            axisLineStyle: AxisLineStyle(
                thicknessUnit: GaugeSizeUnit.factor,
                thickness: 0.08,
                color: const Color(0xFFFFCD60)),
            startAngle: 270,
            endAngle: 270,
            minimum: 0,
            maximum: 360,
            radiusFactor: kIsWeb ? 0.8 : 0.9,
            showFirstLabel: false,
            interval: 30,
            labelOffset: 10,
            axisLabelStyle: GaugeTextStyle(fontSize: isTileView ? 10 : 12),
            onLabelCreated: mainAxisLabelCreated,
            minorTicksPerInterval: 5,
            minorTickStyle: MinorTickStyle(
                lengthUnit: GaugeSizeUnit.factor, length: 0.05, thickness: 1),
            majorTickStyle:
                MajorTickStyle(lengthUnit: GaugeSizeUnit.factor, length: 0.1),
            pointers: <GaugePointer>[
              NeedlePointer(
                  value: vor1,
                  needleLength: 0.35,
                  needleColor: const Color(0xFF3777de),
                  lengthUnit: GaugeSizeUnit.factor,
                  needleStartWidth: 0,
                  needleEndWidth: isTileView ? 3 : 5,
                  enableAnimation: false,
                  knobStyle: KnobStyle(knobRadius: 0),
                  animationType: AnimationType.ease),
              NeedlePointer(
                  value: vor2,
                  needleLength: 0.35,
                  needleColor: const Color(0xFF0f9660),
                  lengthUnit: GaugeSizeUnit.factor,
                  needleStartWidth: 0,
                  needleEndWidth: isTileView ? 3 : 5,
                  enableAnimation: false,
                  knobStyle: KnobStyle(knobRadius: 0),
                  animationType: AnimationType.ease),
              NeedlePointer(
                  value: heading,
                  needleLength: 0.85,
                  lengthUnit: GaugeSizeUnit.factor,
                  needleColor: const Color(0xFFF67280),
                  needleStartWidth: 0,
                  needleEndWidth: isTileView ? 3 : 5,
                  enableAnimation: false,
                  animationType: AnimationType.bounceOut,
                  knobStyle: KnobStyle(
                      borderColor: const Color(0xFFF67280),
                      borderWidth: 0.015,
                      color: Colors.white,
                      sizeUnit: GaugeSizeUnit.factor,
                      knobRadius: isTileView ? 0.04 : 0.05)),
            ]),
      ],
    );
  }

  void mainAxisLabelCreated(AxisLabelCreatedArgs args) {
    if (args.text == '360') {
      args.text = '0';
    }
  }
}
