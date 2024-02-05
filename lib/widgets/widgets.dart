import 'package:flutter/material.dart';

textformfield({controller, label, texttype, data, style, max, bool ph = true}) {
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
      if (value == null || value.isEmpty) {
        return 'Please  $label';
      }
      if (ph == true) {
        if (value!.length != 10) {
          return "Please Enter 10 Numbers";
        }
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

circeavatar({child, radius, color, image}) {
  return CircleAvatar(
    child: child,
    radius: radius,
    backgroundColor: color,
    backgroundImage: image,
  );
}
