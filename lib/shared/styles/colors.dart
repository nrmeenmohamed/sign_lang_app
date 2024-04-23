import 'package:flutter/material.dart';

Color whitColor = Colors.white;
Color blackColor = Colors.black;
Color blueColor = Color(0xFF008abe);
Color yellowColor = Color(0xFFfdb63c);
Color redColor = Color(0xFFda4663);
Color? lightGreyColor = Colors.grey[300];





bool isDark = false;

void setMode(){
  isDark = !isDark;
  whitColor = isDark ? Colors.black : Colors.white; // Assign colors based on isDark flag
  blackColor = isDark ? Colors.white : Colors.black; // Assign colors based on isDark flag
  lightGreyColor = isDark ? Colors.grey[900] :  Colors.grey[300];
  print('******* change mode *************');
}