import 'dart:io';

class Contact
{
  final  String? firstname;
  final  String? chat;
  final  String? phone;
  final File? image;
  final String? date;
  final String? time;

  Contact({required this.firstname,required this.image,required this.chat,required this.phone,required this.date,required this.time, });
}
List<Contact> contact =<Contact>[];