
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:testo_maps/cubit_data/business_logic/cubit/maps_test_tracking/maps_cubit_tracking.dart';


class MapScreenTracking extends StatelessWidget {
  const MapScreenTracking({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      //SocialCubit.get(context).getMessages(reciverId: userModel!.uId);
      
  Completer<GoogleMapController> mapController = Completer();  

      return BlocConsumer<MapsCubitTracking, MapsStateTracking>(
          listener: ((context, state) {}),
          builder: (context, state) {
            var cubit =  BlocProvider.of<MapsCubitTracking>(context) ;
            
            return Scaffold(
      
      body:Stack(
        fit: StackFit.expand,
        children:[(state is DirectionsSuccessLoaded && cubit.myCurrentLocationCameraPosition!= null )
              ? buildMap(mapController)
              : Center(
                  child: Container(
                    child: CircularProgressIndicator(
                      color: Colors.blue,
                    ),
                  ),
                ),
        //  buildFloatingSearchBar(),
         /*  isSearchedPlaceMarkerClicked
              ? DistanceAndTime(
                  isTimeAndDistanceVisible: isTimeAndDistanceVisible,
                  placeDirections: placeDirections,
                )
              : Container(), */]),
                floatingActionButton: Container(
        margin: EdgeInsets.fromLTRB(0, 0, 8, 30),
        child: FloatingActionButton(
          backgroundColor: Colors.blue,
          onPressed:()=> cubit.goToMyCurrentLocation(mapController),
          child: Icon(Icons.place, color: Colors.white),
        ),
      ),
    );
          });
    });
  }
    Widget buildMap(mapController) {
    
    return BlocConsumer<MapsCubitTracking, MapsStateTracking>(
          listener: ((context, state) {}),
          builder: (context, state) {
            var cubit =  BlocProvider.of<MapsCubitTracking>(context) ;
            
            return  GoogleMap(
      mapType: MapType.normal,
      myLocationEnabled: true,
      zoomControlsEnabled: false,
      myLocationButtonEnabled: false,
      markers:cubit.markers ,//markers,{cLocation ,cLocation2}markerbitmap
      onCameraMove: (position) => {
       // changeLocation(),
      },
      initialCameraPosition: cubit.myCurrentLocationCameraPosition! ,
      onMapCreated: (GoogleMapController controller) {
       mapController.complete(controller);
      },
      
     // polylines polylinePoints
      polylines:cubit.polylinePoints !=null
          ? {
              Polyline(
                polylineId: const PolylineId('my_polyline'),
                color: Colors.blue ,
                width: 3,
                points: cubit.polylinePoints!,
              ),
            }
          : {},
    );
          });
  }

}
