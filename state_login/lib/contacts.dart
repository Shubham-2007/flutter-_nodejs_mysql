import 'dart:convert';

import 'package:contacts_service/contacts_service.dart' as cnt;
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'package:state_login/models/contactdetail.dart';

List<cnt.Contact> finalcontacts;
List<ContactDetail> phones;

Future<List<ContactDetail>> refreshContacts() async {
  PermissionStatus pstatus = await getContactPermission();
  if (pstatus == PermissionStatus.granted) {
    phones = [];
    var contacts =
        (await cnt.ContactsService.getContacts(withThumbnails: false)).toList();
    finalcontacts = contacts;
    var response = await http.get('http://10.0.2.2:3000/users/number');
    List<dynamic> datanumlist = [];
    if (response.statusCode == 200) datanumlist = jsonDecode(response.body);
    for (final c in datanumlist) {
      for (final num in contacts) {
        print(num.phones.elementAt(0).value);
        print(c["number"]);
        if (num.phones.elementAt(0).value.toString() == (c["number"])) {
          ContactDetail temp = ContactDetail();
          temp.id = c["id"].toString();
          temp.number = c["number"];
          temp.name = c["username"];
          phones.add(temp);
        }
      }
    }
    print(phones.length);
    print("***************11");
    return phones;
  } else {
    handleInvalidPermissions(pstatus);
  }
}

void handleInvalidPermissions(PermissionStatus permissionStatus) {
  if (permissionStatus == PermissionStatus.denied) {
    throw new PlatformException(
        code: "PERMISSION_DENIED",
        message: "Access to location data denied",
        details: null);
  } else if (permissionStatus == PermissionStatus.undetermined) {
    throw new PlatformException(
        code: "PERMISSION_DISABLED",
        message: "Location data is not available on device",
        details: null);
  }
}

Future<PermissionStatus> getContactPermission() async {
  bool ps = await Permission.contacts.request().isGranted;
  if (ps) {
    return PermissionStatus.granted;
  }
}
