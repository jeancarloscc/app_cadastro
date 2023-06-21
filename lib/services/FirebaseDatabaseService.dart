import 'package:firebase_database/firebase_database.dart';

class FirebaseDatabaseService {
  DatabaseReference _databaseReference = FirebaseDatabase.instance.reference();

  Future<DataSnapshot> readData(String path) async {
    DataSnapshot snapshot = (await _databaseReference.child(path).once()) as DataSnapshot;
    return snapshot;
  }

  Future<void> writeData(String path, Map<String, dynamic> data) async {
    await _databaseReference.child(path).set(data);
  }

  Future<void> updateData(String path, Map<String, dynamic> data) async {
    await _databaseReference.child(path).update(data);
  }

  Future<void> deleteData(String path) async {
    await _databaseReference.child(path).remove();
  }
}
