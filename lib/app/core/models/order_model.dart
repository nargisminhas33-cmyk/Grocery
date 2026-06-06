import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  final String orderId;
  final String customerId;
  final String shopId;
  final DateTime orderDate;
  final double totalAmount;
  final String status;
  final Map<String, dynamic> deliveryAddress;
  final String paymentMethod;

  OrderModel({
    required this.orderId,
    required this.customerId,
    required this.shopId,
    required this.orderDate,
    required this.totalAmount,
    required this.status,
    required this.deliveryAddress,
    required this.paymentMethod,
  });

  factory OrderModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;;
    return OrderModel(
      orderId: doc.id,
      customerId: data['customerId'] ?? '',
      shopId: data['shopId'] ?? '',
      orderDate: (data['orderDate'] as Timestamp).toDate(),
      totalAmount: (data['totalAmount'] ?? 0).toDouble(),
      status: data['status'] ?? 'pending',
      deliveryAddress: data['deliveryAddress'] ?? {},
      paymentMethod: data['paymentMethod'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'customerId': customerId,
      'shopId': shopId,
      'orderDate': orderDate,
      'totalAmount': totalAmount,
      'status': status,
      'deliveryAddress': deliveryAddress,
      'paymentMethod': paymentMethod,
    };
  }
}
