import 'package:flutter/material.dart';
import 'constants.dart';

class DropdownSexo extends StatefulWidget {
  DropdownSexo({Key key}) : super(key: key);

  @override
  _DropdownSexo createState() => _DropdownSexo();
}

/// This is the private State class that goes with MyStatefulWidget.
class _DropdownSexo extends State<DropdownSexo> {
  String _value;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width * 0.8,
      decoration: BoxDecoration(
        color: kPrimaryLightColor,
        borderRadius: BorderRadius.circular(29),
      ),
      child: DropdownButton<String>(
        items: [
          DropdownMenuItem(
            value: "1",
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                ImageIcon(AssetImage('icons/round_male_black_24.png')),
                SizedBox(width: 10),
                Text(
                  "Masculino",
                ),
              ],
            ),
          ),
          DropdownMenuItem(
            value: "2",
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(width: 10),
              ],
            ),
          ),
        ],
        onChanged: (value) {
          setState(() {
            _value = value;
          });
        },
        value: _value,
        isExpanded: true,
      ),
      // (
      //   value: dropdownValue,
      //   icon: Icon(Icons.arrow_downward, color: kPrimaryColor),
      //   iconSize: 24,
      //   elevation: 16,
      //   isExpanded: true,
      //   style: TextStyle(color: Colors.black54),
      //   underline: Container(
      //     height: 2,
      //     color: kPrimaryLightColor,
      //   ),
      //   onChanged: (String newValue) {
      //     setState(() {
      //       dropdownValue = newValue;
      //     });
      //   },
      //   items: <String>['Sexo', 'Masculino', 'Feminino']
      //       .map<DropdownMenuItem<String>>((String value) {
      //     return DropdownMenuItem<String>(
      //       value: value,
      //       child: Text(
      //         value,
      //         style: TextStyle(color: Colors.black54, fontFamily: 'Monda'),
      //       ),
      //     );
      //   }).toList(),
      // ),
    );
  }
}
