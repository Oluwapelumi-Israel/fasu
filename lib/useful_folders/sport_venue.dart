import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fasu_app/list.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../Phonepages/location_services.dart';
import '../Phonepages/phone_map_page.dart';
import '../map_list.dart';

class SportVenue extends StatefulWidget {
  final String isVenue;
  const SportVenue({super.key, required this.isVenue});

  @override
  State<SportVenue> createState() {
    return _SportVenueState();
  }
}

class _SportVenueState extends State<SportVenue> {
  final GeolocatorPlatform _geolocationPlatform = GeolocatorPlatform.instance;
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> sportCentres = sport(context);

    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 215, 0, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(255, 215, 0, 1),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              width: double.infinity,
              child: widget.isVenue == 'Unilag'
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          sportCentres['Unilag']['image'],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          sportCentres['Unilag']['name'],
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                              color: Color.fromRGBO(128, 0, 0, 1)),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          sportCentres['Unilag']['address'],
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                              color: Color.fromRGBO(128, 0, 0, 1)),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            style: const ButtonStyle(
                                backgroundColor: WidgetStatePropertyAll(
                                    Color.fromRGBO(128, 0, 0, 1))
                            ),
                            onPressed: () async {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return const Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.amberAccent,
                                    ),
                                  );
                                },
                              );
                              var currentLocation = await getCurrentLocation();
                              var currentDestination = await LocationService()
                                  .getPlace(sportCentresName['Unilag']['name']);

                              List<LatLng> latlng = await LocationService()
                                  .getPolyline(
                                  currentLocation, currentDestination);

                              if (!context.mounted) return;
                              Navigator.of(context).pop();
                              Navigator.push(context, CupertinoPageRoute(
                                builder: (BuildContext context) {
                                  return MapSample(
                                    currentLocation: currentLocation,
                                    currentDestination: currentDestination,
                                    lines: latlng,
                                  );
                                },
                              ));
                            },
                            child:  Text(
                              AppLocalizations.of(context)!.click,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.0,
                                  color: Colors.white),
                            ),
                          ),
                        )
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          sportCentres['Lasu']['image'],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          sportCentres['Lasu']['name'],
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                              color: Color.fromRGBO(128, 0, 0, 1)),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          sportCentres['Lasu']['address'],
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                              color: Color.fromRGBO(128, 0, 0, 1)),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            style: const ButtonStyle(
                                backgroundColor: WidgetStatePropertyAll(
                                    Color.fromRGBO(128, 0, 0, 1))),
                            onPressed: () async {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return const Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.amberAccent,
                                    ),
                                  );
                                },
                              );
                              var currentLocation = await getCurrentLocation();
                              var currentDestination = await LocationService()
                                  .getPlace(sportCentresName['Lasu']['name']);

                              List<LatLng> latlng = await LocationService()
                                  .getPolyline(
                                  currentLocation, currentDestination);

                              if (!context.mounted) return;
                              Navigator.of(context).pop();
                              Navigator.push(context, CupertinoPageRoute(
                                builder: (BuildContext context) {
                                  return MapSample(
                                    currentLocation: currentLocation,
                                    currentDestination: currentDestination,
                                    lines: latlng,
                                  );
                                },
                              ));
                            },
                            child: const Text(
                              'Click Here',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.0,
                                  color: Colors.white),
                            ),
                          ),
                        )
                      ],
                    ),
            ),
          ),
          const SizedBox(height: 10,),

        ],
      ),
    );
  }

  Future<dynamic> getCurrentLocation() async {
    var serviceEnabled = await _geolocationPlatform.isLocationServiceEnabled();
    var permission = await _geolocationPlatform.checkPermission();
    Position locate;

    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    if (permission == LocationPermission.denied) {
      permission = await _geolocationPlatform.requestPermission();

      if (permission == LocationPermission.denied) {
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }
    }

    locate = await _geolocationPlatform.getCurrentPosition();

    return locate;
  }
}
