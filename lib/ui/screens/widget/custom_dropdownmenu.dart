import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDropDownMenu extends StatefulWidget {
  const CustomDropDownMenu({
    super.key,
    required this.textController,
    required this.width,
    required this.height,
    required this.label,
    required this.uk,
    required this.list,
    required this.onSelected,
  });

  final TextEditingController textController;
  final double width;
  final double height;
  final String label;
  final List<dynamic> list;
  final Key uk;
  final ValueChanged<String> onSelected;

  @override
  State<CustomDropDownMenu> createState() => _CustomDropDownMenuState();
}

class _CustomDropDownMenuState extends State<CustomDropDownMenu> {
  dynamic dropdownValue;
  late final Key dropdownKey;
  @override
  void initState() {
    dropdownKey = UniqueKey();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: DropdownButtonFormField<dynamic>(
        key: dropdownKey,
        style: Theme.of(context).textTheme.bodyMedium,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(8.sp),
          labelText: widget.label,
          labelStyle: Theme.of(context).textTheme.bodyMedium,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.sp),
            borderSide: const BorderSide(
              color: Colors.black,
              style: BorderStyle.solid,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.sp),
            borderSide: BorderSide(
              width: 2.sp,
              color: Colors.green,
              style: BorderStyle.solid,
            ),
          ),
        ),
        icon: const Icon(Icons.arrow_drop_down),
        onChanged: (dynamic newValue) {
          setState(() {
            dropdownValue = newValue!;
          });
          widget.onSelected(newValue.id.toString());
        },
        items: widget.list.map<DropdownMenuItem<dynamic>>((dynamic value) {
          return DropdownMenuItem<dynamic>(
            value: value,
            child: Text(
              value.nombre,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          );
        }).toList(),
      ),
    );
  }
}
