import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_google_maps/model/map_type_google.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../data_dummy.dart';

class MapsV1page extends StatefulWidget {
  const MapsV1page({super.key});

  @override
  State<MapsV1page> createState() => _MapsV1pageState();
}

class _MapsV1pageState extends State<MapsV1page> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  double latitude = -6.1957677389502415;
  double longitude = 106.79616644676038;
  var mapType = MapType.normal;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Google Maps V1"),
        actions: [
          PopupMenuButton(
              onSelected: onSelectedMapType,
              itemBuilder: (context) {
                return googleMapTypes.map((MapTypeGoogle mapTypeGoogle) {
                  return PopupMenuItem(
                      value: mapTypeGoogle.type,
                      child: Text(mapTypeGoogle.type.name));
                }).toList();
              })
        ],
      ),
      body: Stack(
        children: [
          //GOOGLE_MAP
          _buildGoogleMap(),

          //Kartu alamat
          _buildDetailCard()
        ],
      ),
    );
  }

  _buildGoogleMap() {
    return GoogleMap(
      mapType: mapType,
      initialCameraPosition:
          CameraPosition(target: LatLng(latitude, longitude), zoom: 17),
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
      markers: markers,
      myLocationButtonEnabled: false,
    );
  }

  void onSelectedMapType(Type value) {
    setState(() {
      switch (value) {
        case Type.Normal:
          mapType = MapType.normal;
          break;
        case Type.Hybrid:
          mapType = MapType.hybrid;
          break;
        case Type.terrain:
          mapType = MapType.terrain;
          break;
        case Type.Satelite:
          mapType = MapType.satellite;
          break;
        default:
      }
    });
  }

  _buildDetailCard() {
    return Align(
      alignment: Alignment.bottomCenter,
        child: SizedBox(
      height: 150,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          const SizedBox(
            width: 10,
          ),
          _displayPlaceCard(
              "https://idn.sch.id/wp-content/uploads/2016/10/ima-studio.png",
              "ImaStudio",
              -6.1952988,
              106.7926625),
          const SizedBox(
            width: 10,
          ),
          _displayPlaceCard(
              "https://2.bp.blogspot.com/-0WirdbkDv4U/WxUkajG0pAI/AAAAAAAADNA/FysRjLMqCrw_XkcU0IQwuqgKwXaPpRLRgCLcBGAs/s1600/1528109954774.jpg",
              "Monas",
              -6.1753871,
              106.8249587),
          const SizedBox(
            width: 10,
          ),
          _displayPlaceCard(
              "https://cdn1-production-images-kly.akamaized.net/n8uNqIv9lZ3PJVYw-8rfy8DZotE=/640x360/smart/filters:quality(75):strip_icc():format(jpeg)/kly-media-production/medias/925193/original/054708200_1436525200-6-Masjid-Megah-Istiqlal.jpg",
              "Masjid Istiqlal",
              -6.1702229,
              106.8293614),
          const SizedBox(
            width: 10,
          ),
          _displayPlaceCard(
              "https://img-z.okeinfo.net/library/images/2018/08/14/gtesxf7d7xil1zry76xn_14364.jpg",
              "Istana Merdeka",
              -6.1701238,
              106.8219881),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
    ));
  }

  _displayPlaceCard(String imageUrl, String name, double lat, double lgn) {
    return GestureDetector(
      onTap: () {
        _onClickPlaceCard(lat, lgn);
      },
      child: Container(
        width: MediaQuery.of(context).size.width - 30,
        height: 90,
        margin: const EdgeInsets.only(bottom: 30),
        child: Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          elevation: 10,
          child: Row(
            children: [
              Container(
                width: 90,
                height: 90,
                margin: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image: NetworkImage(imageUrl), fit: BoxFit.cover)),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        const Text(
                          "4.9",
                          style: TextStyle(fontSize: 15),
                        ),
                        Row(
                          children: stars(),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text(
                      "Indonesia \u00B7 Jakarta Barat",
                      style: TextStyle(color: Colors.black, fontSize: 15),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      width: 200,
                      child: Text(
                        "Closed \u00B7 Open 09.00 Monday",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> stars() {
    List<Widget> list1 = [];
    for (var i = 0; i < 5; i++) {
      list1.add(const Icon(
        Icons.star,
        color: Colors.orange,
        size: 15,
      ));
    }
    return list1;
  }
  
  void _onClickPlaceCard(double lat, double lgn) async{
    setState(() {
      latitude = lat;
      longitude = lgn;
    });

    GoogleMapController controller = await _controller.future;
    LatLng target = LatLng(latitude, longitude);
    CameraPosition cameraPosition = CameraPosition(target: target, zoom: 17, bearing: 192, tilt: 55);
    CameraUpdate cameraUpdate = CameraUpdate.newCameraPosition(cameraPosition);
    controller.animateCamera(cameraUpdate);
  }
}
