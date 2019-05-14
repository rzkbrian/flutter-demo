import 'package:base_flutter/local/DatabaseHelper.dart';
import 'package:base_flutter/local/entities/UserEntity.dart';
import 'package:base_flutter/usecases/repository/user/UserRepositoryLocal.dart';
import 'package:flutter/foundation.dart';

class DbUserRepository implements UserRepositoryLocal {
  DatabaseHelper databaseHelper;

  DbUserRepository(this.databaseHelper);

  @override
  Future<String> deleteUser() {
    // TODO: implement deleteUser
    return null;
  }

  @override
  Future<String> getUser() async {
    await databaseHelper.init();

    List<Map> results;
    results = await databaseHelper.getData(
        UserEntity.tableName, [UserEntity.columnName, UserEntity.columnEmail]);
    debugPrint("Result records: $results");

    if (results.length == 0) return null;

    UserEntity userEntity = UserEntity.fromMap(results[0]);
    return userEntity.email;
  }

  @override
  Future<String> saveUser(UserEntity userEntity) async {
    int id = await databaseHelper.insertRecord(
        UserEntity.tableName, userEntity.toMap());

    debugPrint("new Record with id: $id");

    List<Map<String, dynamic>> results = await databaseHelper.getData(
        UserEntity.tableName, [UserEntity.columnName, UserEntity.columnEmail]);

    return UserEntity.fromMap(results[0]).email;
  }
}
