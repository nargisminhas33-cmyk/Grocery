import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String name;
  final String mobileNumber;
  final String email;
  final Map<String, dynamic> deliveryAddress;
  final GeoPoint gpsLocation;
  final String preferredLanguage;
  final String role;

  UserModel({
    required this.uid,
    required this.name,
    required this.mobileNumber,
    required this.email,
    required this.deliveryAddress,
    required this.gpsLocation,
    required this.preferredLanguage,
    required this.role,
  });

  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;;
    return UserModel(
      uid: doc.id,
      name: data['name'] ?? '',
      mobileNumber: data['mobileNumber'] ?? '',
      email: data['email'] ?? '',
      deliveryAddress: data['deliveryAddress'] ?? {},
      gpsLocation: data['gpsLocation'] ?? const GeoPoint(0, 0),
      preferredLanguage: data['preferredLanguage'] ?? 'en',
      role: data['role'] ?? 'customer',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'mobileNumber': mobileNumber,
      'email': email,
      'deliveryAddress': deliveryAddress,
      'gpsLocation': gpsLocation,
      'preferredLanguage': preferredLanguage,
      'role': role,
    };
  }
}
