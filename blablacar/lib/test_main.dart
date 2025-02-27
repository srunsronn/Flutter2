import 'package:week_3_blabla_project/model/ride/locations.dart';
import 'package:week_3_blabla_project/model/ride/ride.dart';
import 'package:week_3_blabla_project/model/ride_pref/ride_pref.dart';
import 'package:week_3_blabla_project/model/user/user.dart';
import 'package:week_3_blabla_project/service/rides_service.dart';

void main() {
  // Get today's date
  final today = DateTime.now();

  // Fetch all available rides
  List<Ride> allRides = RidesService.availableRides;

  // Filter rides that are scheduled for today
  List<Ride> todayRides = allRides.where((ride) {
    return ride.departureDate.year == today.year &&
        ride.departureDate.month == today.month &&
        ride.departureDate.day == today.day;
  }).toList();

  // Print today's rides
  print("Today's Rides:");
  if (todayRides.isNotEmpty) {
    for (Ride ride in todayRides) {
      print(
          'Ride from ${ride.departureLocation.name} to ${ride.arrivalLocation.name}, '
          'Departure Time: ${ride.departureDate.hour}:${ride.departureDate.minute.toString().padLeft(2, '0')}, '
          'Driver: ${ride.driver.firstName} ${ride.driver.lastName}, '
          'Seats Available: ${ride.availableSeats}, '
          'Price per Seat: ${ride.pricePerSeat}');
    }
  } else {
    print("No rides scheduled for today.");
  }
}
