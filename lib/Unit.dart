import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'Models/UnitModel.dart';

class UnitView extends StatefulWidget {
  var units;

  UnitView(this.units);

  @override
  _UnitViewState createState() => _UnitViewState(this.units);
}

class _UnitViewState extends State<UnitView> {
  var units;

  String _getImage() {
    if (Unit.fromJson(units).images.isNotEmpty) {
      return Unit.fromJson(units).images[0].image;
    } else {
      return 'tumb.png';
    }
  }

  _UnitViewState(this.units);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.units = units;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(

        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                child: FadeInImage.assetNetwork(
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                  placeholder: ('resources/tumb.png'),
                  image: _getImage(),
                ),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black38,
                      spreadRadius: 2,
                      blurRadius: 1,
                      offset: Offset(0, 2), // changes position of shadow
                    ),
                  ],
                ),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2.5,
              ),
              Container(
//            color: Colors.transparent,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 4,
//                color: Color(0xFF0E3311).withOpacity(0.5),
                child: FlutterMap(
                  options: new MapOptions(
                    center: new LatLng(35.7135744, 51.4092909),
                    zoom: 15.0,
                  ),
                  layers: [
                    new TileLayerOptions(
                      urlTemplate: "https://api.tiles.mapbox.com/v4/"
                          "{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}",
                      additionalOptions: {
                        'accessToken':
                            'pk.eyJ1IjoieGVudXBzIiwiYSI6ImNrNGZ4bDdoaTBxeXIzbXJtYjl5OGNoa3cifQ.oceZpiVqVTV9s4-RDI3sTQ',
                        'id': 'mapbox.streets',
                      },
                    ),
                    new MarkerLayerOptions(
                      markers: [
                        new Marker(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 4,
                          point: new LatLng(35.7135744, 51.4092909),
                          builder: (ctx) => new Container(
                            child: new Icon(
                              Icons.room,
                              color: Colors.indigo,
                              size: 30.0,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),

                margin: const EdgeInsets.only(left: 50, right: 50, top: 200),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 5,
                      blurRadius: 5,
                      offset: Offset(0, 2), // changes position of shadow
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FloatingActionButton(
                  onPressed: () {},
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.directions,
                    color: Colors.indigo,
                  ),
                ),
                SizedBox(width: 20.0),
                FloatingActionButton(
                  onPressed: () {},
                  heroTag: "btn1",
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.map,
                    color: Colors.deepOrangeAccent,
                  ),
                ),
                SizedBox(width: 20.0),
                FloatingActionButton(
                  onPressed: () {},
                  heroTag: "btn2",
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.favorite,
                    color: Colors.deepPurple,
                  ),
                ),
                SizedBox(width: 20.0),
                FloatingActionButton(
                  onPressed: () {},
                  heroTag: "btn3",
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.speaker_notes,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 30),
            child: Column(
              children: <Widget>[
                Center(
                  child: Text(
                    Unit.fromJson(units).unitDescription,
                    style:
                        TextStyle(fontWeight: FontWeight.w600, fontSize: 20.0),
                  ),
                  heightFactor: 1,
                ),
                Center(
                  child: Text(
                    Unit.fromJson(units).unit_heading,
                    style:
                        TextStyle(fontWeight: FontWeight.w300, fontSize: 15.0),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  child: Icon(Icons.call),
                  color: Colors.white,
                  onPressed: () {},
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(18.0),
                      ),
                ),
                SizedBox(
                  width: 15,
                ),
                RaisedButton(
                  child: Icon(Icons.message,color: Colors.white,),
                  color: Colors.blueAccent,
                  onPressed: () {},
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(18.0),

                )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
