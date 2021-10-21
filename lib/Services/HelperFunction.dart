import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HelperFunction{

  static String SharedPreferenceUserLoggedIn = 'ISLOGGEDIN';
  static String SharedPreferenceUserNameKey = 'USERNAMEKEY';
  static String SharedPreferenceUserEmailKey = 'USEREMAILKEY';

  //:TODO: Save Data to SharedPreference
  static Future<bool> saveUserLoggedInSharedPreference(bool IsUserLoggedIn) async{
        SharedPreferences pref = await SharedPreferences.getInstance();
        return await pref.setBool(SharedPreferenceUserLoggedIn, IsUserLoggedIn);
  }

  static Future<bool> saveUserNameSharedPreference(String UserName) async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    return await pref.setString(SharedPreferenceUserNameKey, UserName);
  }

  static Future<bool> saveUserEmailSharedPreference(String UserEmail) async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    return await pref.setString(SharedPreferenceUserLoggedIn, UserEmail);
  }


  //:TODO: Get Data to SharedPreference
  static Future<bool> getUserLoggedInSharedPreference() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    return await pref.getBool(SharedPreferenceUserLoggedIn);
  }

  static Future<String> getUserNameSharedPreference() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    return await pref.getString(SharedPreferenceUserNameKey);
  }

  static Future<String> getUserEmailSharedPreference() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    return await pref.getString(SharedPreferenceUserLoggedIn);
  }


}