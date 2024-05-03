
import 'package:flutter/material.dart';

import '../../Colors/Hex_Color.dart';

enum FormData {
  Email
}

class SaveToPresetDialogScreen extends StatefulWidget {
  const SaveToPresetDialogScreen({super.key});

  @override
  State<SaveToPresetDialogScreen> createState() => _SaveToPresetDialogScreenState();
}

class _SaveToPresetDialogScreenState extends State<SaveToPresetDialogScreen> {

  var PresetnameController = TextEditingController();
  FormData? selected;
  Color enabled = const Color.fromARGB(255, 63, 56, 89);
  Color enabledtxt = Colors.white;
  Color deaible = Colors.grey;
  Color backgroundColor = const Color(0xFF424550);
  Color forcolor =const Color(0xFFFDFDFE);
  bool ispasswordev = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      color: HexColor("#272931"),
      child: Padding(
        padding: const EdgeInsets.only(left: 11,top: 30,right: 11,bottom: 11),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Add Name To Preset",style: Theme.of(context).textTheme.labelSmall),
            SizedBox(
              height: 15,
            ),
            Text("Please enter the preset name for the cloning for the all parameters settings and you can apply it on the another device after saving this settings",style: Theme.of(context).textTheme.labelMedium),
            SizedBox(height: 30,),
            Text("Preset Name",style: Theme.of(context).textTheme.labelMedium),
            SizedBox(height: 11,),
            Container(
              width: double.infinity,
              height: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: selected == FormData.Email
                    ? enabled
                    : backgroundColor,
              ),
              padding: const EdgeInsets.all(5.0),
              child: TextField(
                controller: PresetnameController,
                onTap: () {
                  setState(() {
                    selected = FormData.Email;
                  });
                },
                decoration: InputDecoration(
                  enabledBorder: InputBorder.none,
                  border: InputBorder.none,

                  hintText: 'Cold Shower',
                  contentPadding: EdgeInsets.all(11),
                  hintStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 14),
                ),
                textAlignVertical: TextAlignVertical.center,
                style: TextStyle(
                    color: selected == FormData.Email
                        ? enabledtxt
                        : deaible,
                    fontWeight: FontWeight.bold,
                    fontSize: 12),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: HexColor("#039597"),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(11),
                      ),
                    ),
                    child: Text("SAVE",style: TextStyle(color: Colors.white,fontSize: 21))),
              ),
            )
          ],
        ),
      ),
    );
  }
}
