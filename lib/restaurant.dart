class Restaurant {
  final int id;
  final String name;
  final String city;
  final String address;
  final double latitude;
  final double longitude;
  final String cuisines;
  final double averageCostForTwo;
  final String currency;
  final double rating;
  final String ratingText;
  final int votes;
  final bool hasTableBooking;
  final bool hasOnlineDelivery;
  final bool isDeliveringNow;
  final int priceRange;
  final String image;

  Restaurant({
    required this.id,
    required this.name,
    required this.city,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.cuisines,
    required this.averageCostForTwo,
    required this.currency,
    required this.rating,
    required this.ratingText,
    required this.votes,
    required this.hasTableBooking,
    required this.hasOnlineDelivery,
    required this.isDeliveringNow,
    required this.priceRange,
    required this.image,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      id: json['id'],
      name: json['name'],
      city: json['city'],
      address: json['address'],
      latitude: json['latitude']?.toDouble() ?? 0.0,
      longitude: json['longitude']?.toDouble() ?? 0.0,
      cuisines: json['cuisines'],
      averageCostForTwo: json['averageCostForTwo']?.toDouble() ?? 0.0,
      currency: json['currency'],
      rating: json['rating']?.toDouble() ?? 0.0,
      ratingText: json['ratingText'],
      votes: json['votes'],
      hasTableBooking: json['hasTableBooking'],
      hasOnlineDelivery: json['hasOnlineDelivery'],
      isDeliveringNow: json['isDeliveringNow'],
      priceRange: json['priceRange'],
      image: json['image'] ?? '',
    );
  }
}
