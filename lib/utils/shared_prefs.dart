import 'package:shared_preferences/shared_preferences.dart';
const String keyIsFirst = "key_isFirst";
const String keyIsDataSet = "key_isDataSet";
class SharedPrefs {
  static SharedPreferences _sharedPrefs;

  init() async {
    if (_sharedPrefs == null) {
      _sharedPrefs = await SharedPreferences.getInstance();
    }
  }

  bool get isFirst => _sharedPrefs.getBool(keyIsFirst) ?? true;
  bool get isDataSet => _sharedPrefs.getBool(keyIsFirst) ?? true;

  set isFirst(bool value) {
    _sharedPrefs.setBool(keyIsFirst, value);
  }
  set isDataSet(bool value) {
    _sharedPrefs.setBool(keyIsFirst, value);
  }
}
