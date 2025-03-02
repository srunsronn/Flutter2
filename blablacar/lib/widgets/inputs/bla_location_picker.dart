import 'package:week_3_blabla_project/model/ride/locations.dart';
import 'package:week_3_blabla_project/service/locations_service.dart';
import 'package:flutter/material.dart';
import '../../theme/theme.dart';

/// A widget that allows users to pick a location from a list of available locations.
class BlaLocationPicker extends StatefulWidget {
  /// The initial location to be displayed when the widget is first created.
  final Location? initialLocation;

  const BlaLocationPicker({super.key, this.initialLocation});

  @override
  _BlaLocationPickerState createState() => _BlaLocationPickerState();
}

class _BlaLocationPickerState extends State<BlaLocationPicker> {
  /// A list of locations that match the search query.
  List<Location> searchedLocations = [];

  /// Handles the back button press event.
  void handleBackPress() {
    Navigator.of(context).pop();
  }

  /// Handles the selection of a location from the list.
  void handleLocationSelection(Location location) {
    Navigator.of(context).pop(location);
  }

  /// Updates the search results based on the query.
  void handleSearchUpdate(String query) {
    List<Location> results = [];
    if (query.length > 1) {
      // search only if the query is longer than 1 character
      results = filterLocations(query);
    }
    setState(() {
      searchedLocations = results;
    });
  }

  /// Filters the available locations based on the input query.
  List<Location> filterLocations(String input) {
    return LocationsService.availableLocations
        .where((location) =>
            location.name.toUpperCase().contains(input.toUpperCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
            left: BlaSpacings.m, right: BlaSpacings.m, top: BlaSpacings.s),
        child: Column(
          children: [
            CustomSearchBar(
              onBackPress: handleBackPress,
              onSearchUpdate: handleSearchUpdate,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: searchedLocations.length,
                itemBuilder: (ctx, index) => LocationListItem(
                  location: searchedLocations[index],
                  onSelect: handleLocationSelection,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// A widget that represents a single location item in the list.
class LocationListItem extends StatelessWidget {
  /// The location to be displayed.
  final Location location;

  /// The callback function to be called when the location is selected.
  final Function(Location location) onSelect;

  const LocationListItem(
      {super.key, required this.location, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onSelect(location),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(location.name,
                      style: BlaTextStyles.body
                          .copyWith(color: BlaColors.textNormal)),
                  Text(location.country.name,
                      style: BlaTextStyles.label
                          .copyWith(color: BlaColors.textLight)),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: BlaColors.iconLight, size: 16),
          ],
        ),
      ),
    );
  }
}

/// A custom search bar widget that allows users to enter a search query.
class CustomSearchBar extends StatefulWidget {
  /// The callback function to be called when the search query is updated.
  final Function(String text) onSearchUpdate;

  /// The callback function to be called when the back button is pressed.
  final VoidCallback onBackPress;

  const CustomSearchBar(
      {super.key, required this.onSearchUpdate, required this.onBackPress});

  @override
  _CustomSearchBarState createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  /// Checks if the search text is not empty.
  bool get hasSearchText => _searchController.text.isNotEmpty;

  void updateSearch(String text) {
    // notify the listener
    widget.onSearchUpdate(text);
    setState(() {});
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: BlaColors.backgroundAccent,
        borderRadius: BorderRadius.circular(BlaSpacings.radius),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: IconButton(
              onPressed: widget.onBackPress,
              icon: Icon(Icons.arrow_back_ios,
                  color: BlaColors.iconLight, size: 16),
            ),
          ),
          Expanded(
            child: TextField(
              focusNode: _focusNode,
              onChanged: updateSearch,
              controller: _searchController,
              style: TextStyle(color: BlaColors.textLight),
              decoration: InputDecoration(
                hintText: "Enter city, street...",
                border: InputBorder.none,
              ),
            ),
          ),
          hasSearchText
              ? IconButton(
                  icon: Icon(Icons.close, color: BlaColors.iconLight),
                  onPressed: () {
                    _searchController.clear();
                    _focusNode.requestFocus();
                    updateSearch("");
                  },
                )
              : SizedBox.shrink(),
        ],
      ),
    );
  }
}
