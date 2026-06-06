import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Generic method to get a collection of documents
  Stream<List<T>> getDocuments<T>(
    String collectionPath,
    T Function(DocumentSnapshot) fromFirestore,
  ) {
    return _firestore.collection(collectionPath).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => fromFirestore(doc)).toList();
    });
  }

  // Generic method to add a document to a collection
  Future<DocumentReference> addDocument(
    String collectionPath,
    Map<String, dynamic> data,
  ) {
    return _firestore.collection(collectionPath).add(data);
  }

  // Generic method to update a document in a collection
  Future<void> updateDocument(
    String collectionPath,
    String docId,
    Map<String, dynamic> data,
  ) {
    return _firestore.collection(collectionPath).doc(docId).update(data);
  }

  // Generic method to delete a document from a collection
  Future<void> deleteDocument(String collectionPath, String docId) {
    return _firestore.collection(collectionPath).doc(docId).delete();
  }
}
