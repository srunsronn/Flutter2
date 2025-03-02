import 'package:flutter/material.dart';
import 'package:week_3_blabla_project/screens/ride_pref/widgets/ride_pref_input_tile.dart';
import 'package:week_3_blabla_project/theme/theme.dart';
import 'package:week_3_blabla_project/utils/animations_util.dart';
import 'package:week_3_blabla_project/utils/date_time_util.dart';
import 'package:week_3_blabla_project/widgets/actions/blabla_button.dart';
import 'package:week_3_blabla_project/widgets/display/bla_divider.dart';
import 'package:week_3_blabla_project/widgets/inputs/bla_location_picker.dart';

import '../../../model/ride/locations.dart';
import '../../../model/ride_pref/ride_pref.dart';

///
/// A Ride Preference From is a view to select:
///   - A depcarture location
///   - An arrival location
///   - A date
///   - A number of seats
///
/// The form can be created with an existing RidePref (optional).
///
class RidePrefForm extends StatefulWidget {
  // The form can be created with an optional initial RidePref.
  final RidePref? initRidePref;

  const RidePrefForm({super.key, this.initRidePref});

  @override
  State<RidePrefForm> createState() => _RidePrefFormState();
}

class _RidePrefFormState extends State<RidePrefForm> {
  Location? departure;
  late DateTime departureDate;
  Location? arrival;
  late int requestedSeats;

  // ----------------------------------
  // Initialize the Form attributes
  // ----------------------------------

  @override
  void initState() {
    super.initState();

    if (widget.initRidePref != null) {
      departure = widget.initRidePref!.departure;
      arrival = widget.initRidePref!.arrival;
      departureDate = widget.initRidePref!.departureDate;
      requestedSeats = widget.initRidePref!.requestedSeats;
    } else {
      // If no given preferences set default values
      departure = null;
      // departure = Location(
      //     name: "Paris", country: Country.france); // for testing swapping
      departureDate = DateTime.now(); // default
      arrival = null;
      // arrival = Location(
      //     name: "Lyon", country: Country.france); // for testing swapping
      requestedSeats = 1; // default 1 seat
    }
  }

  // ----------------------------------
  // Handle events
  // ----------------------------------

  void onDeparturePressed() async {
    //select location
    Location? selectedLocation =
        await Navigator.of(context).push<Location>(MaterialPageRoute(
      builder: (ctx) => BlaLocationPicker(
        initialLocation: departure,
      ),
    ));

    // update form
    if (selectedLocation != null) {
      setState(() {
        departure = selectedLocation;
      });
    }
  }

  void onArrivalPressed() async {
    //select location
    Location? selectedLocation =
        await Navigator.of(context).push<Location>(MaterialPageRoute(
      builder: (ctx) => BlaLocationPicker(
        initialLocation: arrival,
      ),
    ));

    // update form
    if (selectedLocation != null) {
      setState(() {
        arrival = selectedLocation;
      });
    }
  }

  void onSearchPressed() {
    // pop with return data if valid
    if (departure != null && arrival != null) {
      Navigator.pop(
        context,
        RidePref(
          departure: departure!,
          arrival: arrival!,
          departureDate: departureDate,
          requestedSeats: requestedSeats,
        ),
      );
    }
  }

  void onSwapPressed() {
    //switch departure and arrival
    setState(() {
      Location? temp = departure;
      departure = arrival;
      arrival = temp;
    });
  }

  // ----------------------------------
  // Compute the widgets rendering
  // ----------------------------------

  // ----------------------------------
  // Build the widgets
  // ----------------------------------

  // use getter to make code clean and readable
  String get departureLabel =>
      departure != null ? departure!.name : "Leaving from";
  String get arrivalLabel => arrival != null ? arrival!.name : "Going to";

  bool get showDeparturePLaceHolder => departure == null;
  bool get showArrivalPLaceHolder => arrival == null;

  String get dateLabel => DateTimeUtils.formatDateTime(departureDate);
  String get numberLabel => requestedSeats.toString();

  bool get switchVisible => departure != null && arrival != null;
  // Check if Search Button should be enabled
  bool get isSearchEnabled => departure != null && arrival != null;

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: BlaSpacings.m),
            // Input departure location
            child: Column(
              children: [
                RidePrefInputTile(
                  isPlaceHolder: showDeparturePLaceHolder,
                  title: departureLabel,
                  onPressed: onDeparturePressed,
                  leftIcon: Icons.circle_outlined,
                  rightIcon: switchVisible ? Icons.swap_vert : null,
                  onRightIconPressed: switchVisible ? onSwapPressed : null,
                ),
                const BlaDivider(),

                // Input arrival location
                RidePrefInputTile(
                  isPlaceHolder: showArrivalPLaceHolder,
                  title: arrivalLabel,
                  leftIcon: Icons.circle_outlined,
                  onPressed: onArrivalPressed,
                ),
                const BlaDivider(),

                // 3 - Input the ride date
                RidePrefInputTile(
                    title: dateLabel,
                    leftIcon: Icons.calendar_month_sharp,
                    onPressed: () => {}),

                const BlaDivider(),

                // 4 - Input number of seats
                RidePrefInputTile(
                    title: numberLabel,
                    leftIcon: Icons.person,
                    onPressed: () => {})
              ],
            ),
          ),

          // search button
          BlablaButton(
            text: "Search",
            onPressed: isSearchEnabled ? onSearchPressed : null,
          ), // Disable if invalid
        ]);
  }
}
