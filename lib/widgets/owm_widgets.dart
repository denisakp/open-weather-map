import 'package:flutter/material.dart';

import 'package:flutter_open_weather_map/models/models.dart';

const primaryColor = Color(0xff2c2c2c);
const blackColor = Colors.black;
const whiteColor = Colors.white;
const greyColor = Color(0xffc4c4c4);
const bgGreyColor = Color(0xfffdfcfc);
const darkGreyColor = Color(0xff9a9a9a);

Widget ownForecast(int index, List<Item>? items) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 15),
    margin: index == 0 ? const EdgeInsets.only(left: 20) : null,
    child: Column(
      children: [
        ownText(
            size: 14,
            text: '${items?[index].dtTxt.hour.toString().padLeft(2, '0')}h',
            color: primaryColor
        ),
        const SizedBox(height: 10),
        Image.network('https://openweathermap.org/img/wn/${items?[index].weather.icon}@2x.png', scale: 2),
        const SizedBox(height: 5),
        ownText(
            size: 14,
            text: '${items?[index].temp}°' // print forecast
        )
      ],
    ),
  );
}

Widget ownText({ FontWeight isBold = FontWeight.normal,  Color color = blackColor,  required double size,  required String text,  int maxLines = 0, bool overFlow = false, bool alignCenter = false }) {
  return Text(
    text,
    textAlign: alignCenter == true ? TextAlign.center : null,
    maxLines: maxLines == 0 ? null : maxLines,
    overflow: overFlow == true ? TextOverflow.ellipsis : null,
    style: TextStyle(
      color: color,
      fontSize: size,
      fontWeight: isBold
    ),
  );
}

Widget owmListTile({ required String first, required String second, required IconData icon, required Color iconColor, String text = '' }) {
  return ListTile(
    trailing: ownText(size: 16, text: text, color: darkGreyColor),
    leading: Icon(icon, color: iconColor),
    title: RichText(
      maxLines: 1,
      text: TextSpan(
        children: [
          TextSpan(
            text: first,
            style: const TextStyle(
              color: darkGreyColor,
              fontSize: 16
            )
          ),
          TextSpan(
            text: second,
            style: const TextStyle(
              color: primaryColor,
              fontSize: 16
            )
          )
        ],
      ),
    ),
  );
}

showSnackBar(BuildContext context, String text, { Color color = primaryColor }) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
        content: Text(text, textAlign: TextAlign.center),
      elevation: 3,
      backgroundColor: color
    )
  );
}