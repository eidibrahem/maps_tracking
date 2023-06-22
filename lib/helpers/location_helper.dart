import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

import '../cubit_data/business_logic/cubit/maps/maps_cubit.dart';

class LocationHelper {

  static Future<Position> getCurrentLocation(context) async {
    bool isServiceEnabled = await Geolocator.isLocationServiceEnabled();
        await Geolocator.checkPermission() ;
    if (!isServiceEnabled) {
      await Geolocator.requestPermission();
    }
    await Geolocator.requestPermission();
    Position? position =await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    BlocProvider.of<MapsCubit>(context).position = position ;
        
   

final LocationSettings locationSettings = LocationSettings(
  accuracy: LocationAccuracy.high,
  distanceFilter: 100,
);
StreamSubscription<Position> positionStream = Geolocator.getPositionStream(locationSettings: locationSettings).listen(
    (Position? position) {
         BlocProvider.of<MapsCubit>(context)
        .updateLocation(latitude:position!.latitude ,longitude:position.longitude);
         print('000000000000000000000000000000000000000000000000000');
        print(position == null ? 'Unknown' : '${position.latitude.toString()}, ${position.longitude.toString()}');
    });

    return position ;
  }
}
