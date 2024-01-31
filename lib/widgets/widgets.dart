import 'package:flutter/material.dart';

textformfield({controller,label,texttype}){
  return TextFormField(
    controller: controller,
    decoration: InputDecoration(
      labelText: label,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20)
      ),
    ),
    keyboardType: texttype,
  );
}

text({data,size,color,weight}){
  return Text(data,style: TextStyle(
    fontSize: size,
    color: color,
    fontWeight: weight,
  ),);
}

sizedbox({height,width}){
  return SizedBox(
    height: height,
    width: width,
  );
}

circeavatar({child,radius,color}){
  return CircleAvatar(
    child: child,
    radius: radius,
    backgroundColor: color,
  );
}