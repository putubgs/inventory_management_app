import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:inventory_management_app/models/inventory_model.dart';

class FirestoreInventoryService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  CollectionReference get _inventoryCollection {
    final user = _auth.currentUser;
    if (user == null) throw Exception('User not authenticated');
    
    return _firestore
        .collection('users')
        .doc(user.uid)
        .collection('inventory');
  }

  Future<void> addInventory(InventoryModel inventory) async {
    try {
      await _inventoryCollection.doc(inventory.id).set(inventory.toJson());
    } catch (e) {
      throw Exception('Failed to add inventory: $e');
    }
  }

  Stream<List<InventoryModel>> getInventoryStream() {
    return _inventoryCollection
        .orderBy('name')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return InventoryModel.fromJson(data);
      }).toList();
    });
  }

  Future<void> deleteInventory(String id) async {
    try {
      await _inventoryCollection.doc(id).delete();
    } catch (e) {
      throw Exception('Failed to delete inventory: $e');
    }
  }


} 