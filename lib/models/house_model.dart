class House {
  final String houseId;
  final String houseNumber;
  final String street;
  final String locality;

  final String town;
  final String postCode;
  String energyRating;
  String review;
  String reviewerId;

  House({
    required this.houseId,
    required this.houseNumber,
    required this.street,
    required this.locality,
    required this.town,
    required this.postCode,
    this.energyRating = '',
    this.review = '',
    this.reviewerId = '',
  });

  factory House.fromJson(Map<String, dynamic> json) {
    return House(
      houseId: json['houseId'] as String,
      houseNumber: json['houseNumber'] as String,
      street: json['street'] as String,
      locality: json['locality'] as String,
      town: json['town'] as String,
      postCode: json['postCode'] as String,
      energyRating: json['energyRating'] ?? '',
      review: json['review'] ?? '',
      reviewerId: json['reviewerId'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'houseId': houseId,
      'houseNumber': houseNumber,
      'street': street,
      'locality': locality,
      'town': town,
      'postCode': postCode,
      'energyRating': energyRating,
      'review': review,
      'reviewerId': reviewerId,
    };
  }
}
