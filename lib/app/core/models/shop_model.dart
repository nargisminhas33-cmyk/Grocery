import 'package:cloud_firestore/cloud_firestore.dart';

class ShopModel {
  final String shopId;
  final String shopName;
  final String ownerName;
  final String phoneNumber;
  final String whatsappNumber;
  final String tradeLicenseNumber;
  final Map<String, dynamic> address;
  final GeoPoint gpsCoordinates;
  final Map<String, dynamic> openingHours;
  final double deliveryRadius;
  final String status;
  final double rating;
  final double responsePerformance;

  ShopModel({
    required this.shopId,
    required this.shopName,
    required this.ownerName,
    required this.phoneNumber,
    required this.whatsappNumber,
    required this.tradeLicenseNumber,
    required this.address,
    required this.gpsCoordinates,
    required this.openingHours,
    required this.deliveryRadius,
    required this.status,
    required this.rating,
    required this.responsePerformance,
  });

  factory ShopModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;;
    return ShopModel(
      shopId: doc.id,
      shopName: data['shopName'] ?? '',
      ownerName: data['ownerName'] ?? '',
      phoneNumber: data['phoneNumber'] ?? '',
      whatsappNumber: data['whatsappNumber'] ?? '',
      tradeLicenseNumber: data['tradeLicenseNumber'] ?? '',
      address: data['address'] ?? {},
      gpsCoordinates: data['gpsCoordinates'] ?? const GeoPoint(0, 0),
      openingHours: data['openingHours'] ?? {},
      deliveryRadius: (data['deliveryRadius'] ?? 0).toDouble(),
      status: data['status'] ?? 'pending',
      rating: (data['rating'] ?? 0).toDouble(),
      responsePerformance: (data['responsePerformance'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'shopName': shopName,
      'ownerName': ownerName,
      'phoneNumber': phoneNumber,
      'whatsappNumber': whatsappNumber,
      'tradeLicenseNumber': tradeLicenseNumber,
      'address': address,
      'gpsCoordinates': gpsCoordinates,
      'openingHours': openingHours,
      'deliveryRadius': deliveryRadius,
      'status': status,
      'rating': rating,
      'responsePerformance': responsePerformance,
    };
  }
}
