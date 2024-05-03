import 'package:flutter/material.dart';

import '../../Colors/Hex_Color.dart';

class IncOrDecDialogBottomSheet extends StatefulWidget {
  String? name;
  String? value;
   IncOrDecDialogBottomSheet({super.key,this.name,this.value});

  @override
  State<IncOrDecDialogBottomSheet> createState() => _IncOrDecDialogBottomSheetState();
}

class _IncOrDecDialogBottomSheetState extends State<IncOrDecDialogBottomSheet> {

  var CounterController =TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CounterController.text=widget.value!;
  }

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
            Text(widget.name!,style: Theme.of(context).textTheme.labelSmall),
            SizedBox(
              height: 15,
            ),
            Text("Recommanded ${widget.name!} is ${widget.value!}",style: Theme.of(context).textTheme.labelMedium),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(Icons.remove_circle,color:HexColor("#424550"),size: 50,),
                SizedBox(
                  width: 200,
                  height: 50,
                  child: TextField(
                    controller:CounterController ,

                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,

                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: HexColor("#424550"),
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(50)
                      ),
                    ),
                  ),
                ),
                Icon(Icons.add_circle,color:HexColor("#039597"),size: 50),
              ],
            ),

            Padding(
              padding: const EdgeInsets.only(top:30 ),
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
