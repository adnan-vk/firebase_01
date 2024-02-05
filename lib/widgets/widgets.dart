import 'package:flutter/material.dart';

textformfield({controller, label, texttype, data, style, max}) {
  return TextFormField(
    controller: controller,
    decoration: InputDecoration(
      prefixText: data,
      prefixStyle: style,
      labelText: label,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
    ),
    keyboardType: texttype,
    maxLength: max,
    validator: (value) {
      if(value == null || value.isEmpty){
        return 'Please  $label';
      }
    },
  );
}

text({data, size, color, weight}) {
  return Text(
    data,
    style: TextStyle(
      fontSize: size,
      color: color,
      fontWeight: weight,
    ),
  );
}

sizedbox({height, width}) {
  return SizedBox(
    height: height,
    width: width,
  );
}

circeavatar({child, radius, color,image}) {
  return CircleAvatar(
    child: child,
    radius: radius,
    backgroundColor: color,
    backgroundImage: image,
  );
}
