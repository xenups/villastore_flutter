import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Models/UnitModel.dart';

class CustomCard extends StatefulWidget {
  var units;

  CustomCard(this.units);

  @override
  _CustomCardState createState() => _CustomCardState(this.units);
}

class _CustomCardState extends State<CustomCard> {
  String _getImage() {
    var x = Unit.fromJson(units);
    if (Unit.fromJson(units).images.isNotEmpty) {
      return Unit.fromJson(units).images[0].image;
    } else {
      return 'tumb.png';
    }
  }

  _CustomCardState(this.units);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.units = units;
  }

  var units;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
          elevation: 10.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ///ghesmate bala
              Stack(
                fit: StackFit.passthrough,
                children: <Widget>[
                  ///axe bala
                  Container(
                    child: ClipRRect(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(20.0)),
                      child: FittedBox(
                        child: Container(
                          child: ClipRRect(
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20.0)),
                            child: FadeInImage.assetNetwork(
//                                              alignment: Alignment.,
                              fit: BoxFit.cover,
                              width: MediaQuery.of(context).size.width,
// add this
                              placeholder: ('resources/tumb.png'),

                              image: _getImage(),
                            ),
                          ),
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    height: 155,
//                              width: MediaQuery.of(context).size.width,
                  ),

                  ///axe bala
                  ///matne roo ax
                  Positioned(
                    child: new Container(
                        child: new Text(Unit.fromJson(units).unit_heading,
                            style: new TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                            )),
                        decoration: new BoxDecoration(
                            color: Color.fromRGBO(0, 0, 0, 0.70),
                            borderRadius: BorderRadius.circular(20.0)),
                        padding: new EdgeInsets.only(left: 20, right: 20)),
                    left: 5.0,
                    bottom: 5.0,
                  )

                  ///matne roo ax
                ],
              ),

              ///ghesmate bala
              SizedBox(
                height: 5,
              ),

              ///ghesmate payeen
              properties(units),


              Container(
                margin: const EdgeInsets.only(
                    bottom: 10, top: 80, left: 20, right: 20),
                alignment: AlignmentDirectional.topStart,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      Unit.fromJson(units).postedBy.user.username.toString(),
                      style: TextStyle(fontSize: 12),
                    ),
                    Text(Unit.fromJson(units).dateOfPosting.toString(),
                        style:
                            TextStyle(fontSize: 15, fontFamily: 'farsifont')),
                  ],
                ),
              )

//ghesmate payeen
            ],
          )),
    );
  }
}

class properties extends StatefulWidget {
  var unit;

  @override
  _propertiesState createState() => _propertiesState(this.unit);

  properties(this.unit);
}

class _propertiesState extends State<properties> {
  var unit;

  _propertiesState(this.unit);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 10),
        child: Row(
          textDirection: TextDirection.rtl,
          children: <Widget>[
            Expanded(
              child: PropertieText(
                  'پارکینگ:',
                  Unit.fromJson(unit).numOfAssignedCarParking.toString(),
                  Icon(
                    Icons.directions_car,
                    color: Colors.deepOrangeAccent,
                    size: 15,
                  )),
            ),
            Expanded(
              child: PropertieText(
                  'پارکت:',
                  Unit.fromJson(unit).carpetArea.toString(),
                  Icon(
                    Icons.center_focus_strong,
                    color: Colors.indigo,
                    size: 15,
                  )),
            ),
            Expanded(
              child: PropertieText(
                  'حمام:',
                  Unit.fromJson(unit).numberOfBathroom.toString(),
                  Icon(
                    Icons.theaters,
                    color: Colors.deepOrange,
                    size: 15,
                  )),
            ),
            Expanded(
              child: PropertieText(
                  'اتاق:',
                  Unit.fromJson(unit).numberOfBedroom.toString(),
                  Icon(
                    Icons.room,
                    color: Colors.black38,
                    size: 15,
                  )),
            ),
          ],
        ));
  }
}

class PropertieText extends StatefulWidget {
  String akey = '';
  String avalue = '';
  Icon icon;

  PropertieText(this.akey, this.avalue, this.icon);

  @override
  _PropertieTextState createState() =>
      _PropertieTextState(this.akey, this.avalue, this.icon);
}

class _PropertieTextState extends State<PropertieText> {
  String akey = '';
  String avalue = '';
  Icon icon;

  @override
  Widget build(BuildContext context) {
    initState() {
      setState(() {
        this.akey = akey;
        this.avalue = avalue;
        this.icon = icon;
      });
    }

    return Container(
//        margin: const EdgeInsets.all(5),
        child: Row(
//          crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          this.akey + ' ' + this.avalue,
          style: TextStyle(color: Colors.black87, fontFamily: 'farsifont'),
          textAlign: TextAlign.right,
          textDirection: TextDirection.rtl,
        ),
        SizedBox(
          width: 5.0,
        ),
        this.icon,
      ],
    ));
  }

  _PropertieTextState(this.akey, this.avalue, this.icon);
}
