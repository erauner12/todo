import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:todo/core/constants/storage_value.dart';

class Storage {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  Future<void> saveData<T>(String key, T value) async {
    if (value is String) {
      await _secureStorage.write(key: key, value: value);
    } else if (value is int || value is double || value is bool) {
      await _secureStorage.write(key: key, value: value.toString());
    } else {
      throw Exception('Unsupported type');
    }
  }

  Future<void> saveLanguage(String languageCode) async {
    await saveData(StorageKey.selectedLanguage, languageCode);
  }

  Future<void> saveApiToken(String token) async {
    await saveData(StorageKey.apiToken, token);
  }

  Future<String?> getLanguage() async {
    return await getData(StorageKey.selectedLanguage);
  }

  Future<String?> getApiToken() async {
    return await getData<String>(StorageKey.apiToken);
  }

  Future<T?> getData<T>(String key) async {
    String? value = await _secureStorage.read(key: key);

    if (value == null) return null;

    if (T == String) {
      return value as T;
    } else if (T == int) {
      return value != null ? int.tryParse(value) as T? : null;
    } else if (T == double) {
      return value != null ? double.tryParse(value) as T? : null;
    } else if (T == bool) {
      return value?.toLowerCase() == 'true' ? true as T? : null;
    } else {
      throw Exception('Unsupported type');
    }
  }

  Future<void> deleteData(String key) async {
    await _secureStorage.delete(key: key);
  }
}