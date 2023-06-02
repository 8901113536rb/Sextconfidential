import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sextconfidential/utils/Appcolors.dart';
import 'package:sextconfidential/utils/StringConstants.dart';
import 'package:sizer/sizer.dart';

class LocationdenialScreen extends StatefulWidget{
  @override
  LocationdenialScreenState createState() => LocationdenialScreenState();


}

class LocationdenialScreenState extends State<LocationdenialScreen>{

  final List<String> items = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
  ];
  List<String> selectedItems = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolors().backgroundcolor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Appcolors().bottomnavbgcolor,
        leading: GestureDetector(
          onTap: (){
            Navigator.pop(context);
            print("Click back");
          },
          child: Container(
            // color: Colors.white,
              margin: EdgeInsets.only(left: 2.w),
              child: const Icon(Icons.arrow_back_ios_rounded)),
        ),
        title: Text(StringConstants.locationdeniel,style: TextStyle(
            fontSize: 14.sp,
            fontFamily: "PulpDisplay",
            fontWeight: FontWeight.w500,
            color: Appcolors().whitecolor),),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 3.w,right: 3.w),
        child: Column(
          children: [
            SizedBox(
              height: 3.h,
            ),
            Container(
              height: 5.h,
              decoration: BoxDecoration(
                  color: Appcolors().bottomnavbgcolor,
                  borderRadius: BorderRadius.circular(10)
              ),
              width: double.infinity,
              child: DropdownButtonHideUnderline(
                child: DropdownButton2(
                  isExpanded: true,
                  hint: Container(
                    padding: EdgeInsets.only(left: 3.w,right: 3.w),
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      'Select Items',
                      style: TextStyle(
                        fontSize: 14,
                        color: Appcolors().whitecolor,
                      ),
                    ),
                  ),
                  items: items.map((item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      //disable default onTap to avoid closing menu when selecting an item
                      enabled: false,
                      child: StatefulBuilder(
                        builder: (context, menuSetState) {
                          final _isSelected = selectedItems.contains(item);
                          return InkWell(
                            onTap: () {
                              _isSelected
                                  ? selectedItems.remove(item)
                                  : selectedItems.add(item);
                              //This rebuilds the StatefulWidget to update the button's text
                              setState(() {});
                              //This rebuilds the dropdownMenu Widget to update the check mark
                              menuSetState(() {});
                            },
                            child: Container(
                              color: Appcolors().bottomnavbgcolor,
                              height: double.infinity,
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Row(
                                children: [
                                  _isSelected
                                      ?  Icon(Icons.check_box_outlined,color: Appcolors().whitecolor,)
                                      :  Icon(Icons.check_box_outline_blank,color: Appcolors().whitecolor),
                                  const SizedBox(width: 16),
                                  Text(
                                    item,
                                    style: TextStyle(
                                      fontSize: 14,
                                        color: Appcolors().whitecolor
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }).toList(),
                  //Use last selected item as the current value so if we've limited menu height, it scroll to last item.
                  value: selectedItems.isEmpty ? null : selectedItems.last,
                  onChanged: (value) {},
                  selectedItemBuilder: (context) {
                    return items.map(
                          (item) {
                        return Container(
                          alignment: AlignmentDirectional.center,
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            selectedItems.join(', '),
                            style: const TextStyle(
                              fontSize: 14,
                              overflow: TextOverflow.ellipsis,
                            ),
                            maxLines: 1,
                          ),
                        );
                      },
                    ).toList();
                  },
                  buttonStyleData: const ButtonStyleData(
                    height: 40,
                    width: 140,
                  ),
                  menuItemStyleData: const MenuItemStyleData(
                    height: 40,
                    padding: EdgeInsets.zero,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}