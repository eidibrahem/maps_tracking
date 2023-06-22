import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';
import 'package:testo_maps/data/models/Place_suggestion.dart';
import 'package:testo_maps/data/models/place.dart';
import 'package:testo_maps/data/models/place_directions.dart';
import 'package:testo_maps/data/repository/maps_repo.dart';

part 'maps_state.dart';

class MapsCubit extends Cubit<MapsState> {
  final MapsRepository mapsRepository;
 
 Position? position ;
  MapsCubit(this.mapsRepository) : super(MapsInitial());

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
      emit(DirectionsLoaded(directions));
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
}
