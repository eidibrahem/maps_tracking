import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';
import 'package:testo_maps/data/models/Place_suggestion.dart';
import 'package:testo_maps/data/models/place.dart';
import 'package:testo_maps/data/models/place_directions.dart';
import 'package:testo_maps/data/repository/maps_repo.dart';

import '../../../../helpers/location_helper.dart';

part 'maps_state_tracking.dart';

class MapsCubitTracking extends Cubit<MapsStateTracking> {

  static MapsStateTracking get(context) => BlocProvider.of(context);

  final MapsRepository mapsRepository;
  Position? position ;
   

 
     Marker? cLocation ;

  Set<Marker> markers = Set();

  MapsCubitTracking(this.mapsRepository) : super(MapsInitial());
   PlaceDirections? placeDirections; 
  late List<LatLng>? polylinePoints ;

  void emitPlaceSuggestions(String place, String sessionToken) {
    mapsRepository.fetchSuggestions(place, sessionToken).then((suggestions) {
      emit(PlacesLoaded(suggestions));
    });
  }

  void emitPlaceLocation(String placeId, String sessionToken) {
    mapsRepository.getPlaceLocation(placeId, sessionToken).then((place) {
      emit(PlaceLocationLoaded(place));
    });
  }

  void emitPlaceDirections(LatLng origin, LatLng destination) {
    
    mapsRepository.getDirections(origin, destination).then((directions) {
      placeDirections = directions ;
       polylinePoints = placeDirections!.polylinePoints
        .map((e) => LatLng(e.latitude, e.longitude))
        .toList();
        print('5555555555555${polylinePoints?.length}');
      emit(DirectionsSuccessLoaded());
    });
  }

  void updateLocation({
    required double latitude,
    required double longitude,
    
  }) {
    FirebaseFirestore.instance
        .collection('locations')
        .doc('123456')
        .set({'location1': GeoPoint(latitude,longitude)})
        .then((value) {
          print("Location Updated");
          emit(LocationUpdated());
        })
        .catchError((error) {
          print("Failed to update user: $error");
          
        });
  }
     CameraPosition? myCurrentLocationCameraPosition ;
/*  BitmapDescriptor? markerbitmap ; */
   
/*     void getMarkerShape()async{
 markerbitmap =  await BitmapDescriptor.fromAssetImage(
    ImageConfiguration(size: Size(20, 20), ),
    "android/assets/images/image.png",
);
    } */
  Future<void> getMyCurrentLocation() async {

     await LocationHelper.getCurrentLocation().then((value) {
     position= value ;
    myCurrentLocationCameraPosition = CameraPosition(
    bearing: 0.0,
    target: LatLng(value.latitude, value.longitude),
    tilt: 0.0,
    zoom: 17,
  );
  getDestinationPlace();
 
      emit(LocationUpdated());
    }).catchError((error, stackTrace) {
        print("Failed to update user: $error");
          
    });
  
  /* await BitmapDescriptor.fromAssetImage(
    ImageConfiguration(),
    "android/assets/images/image.png",
) */;
    }
    void goToMyCurrentLocation(Completer<GoogleMapController> mapController) async {
    final GoogleMapController controller = await mapController.future;
    controller.animateCamera(
        CameraUpdate.newCameraPosition(myCurrentLocationCameraPosition!));
  } 
  void getDestinationPlace()async{
 FirebaseFirestore.instance
        .collection('locations')
        .doc('123456')
        .get()
        .then((value) {
    
      print('geoooooooooo   ${value.data()?['latitude']}');
        var k= [value.data()?['latitude'] , value.data()?['longitude']];
      print('geooo      ${k[1]}');
      
     emitPlaceDirections( LatLng (position!.latitude,position!.longitude), LatLng (value.data()?['latitude'], value.data()?['longitude'])); 

     
    }).catchError((error) {
      print('geoooooooooo ${error}');
    
    });

  }

 void getMarker()async{ 
  FirebaseFirestore.instance
        .collection('locations')
        .doc('123456')
       .snapshots()
        .listen((event) { 
          markers={ Marker(
      position: LatLng(event.data()?['latitude'], event.data()?['longitude']),
      markerId: MarkerId('3'),
      onTap: () {},
      infoWindow: InfoWindow(title: "Location 1"),
      icon:BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
    ),};emit(DirectionsSuccessLoaded());
              print('g66666666666  ${event.data()?['latitude']}');
   
        });
        emit(DirectionsSuccessLoaded());
 }

}
