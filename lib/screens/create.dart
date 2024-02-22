import 'package:flutter/material.dart';
import 'package:flutter_c/database.dart';
import 'package:random_string/random_string.dart';

class Staff extends StatefulWidget {
  const Staff({Key? key}) : super(key: key);


  @override
  State<Staff> createState() => _StaffState();
}

class _StaffState extends State<Staff> {
  TextEditingController first_nameController = TextEditingController();
  TextEditingController last_nameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController districtController = TextEditingController();
  TextEditingController wardController = TextEditingController();
  DateTime? selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        dateController.text = selectedDate.toString(); // Display selected date in the text field
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Create ",
              style: TextStyle(
                color: Colors.orange,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Staff",
              style: TextStyle(
                color: Colors.blue,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
     body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 24.0, vertical: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "First Name",
                          style: TextStyle(color: Colors.black, fontSize: 20.0),
                        ),
                        SizedBox(height: 10.0),
                        Container(
                          padding: EdgeInsets.only(left: 10.0),
                          decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextField(
                            controller: first_nameController,
                            decoration: InputDecoration(border: InputBorder.none),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Last Name",
                          style: TextStyle(color: Colors.black, fontSize: 20.0),
                        ),
                        SizedBox(height: 10.0),
                        Container(
                          padding: EdgeInsets.only(left: 10.0),
                          decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextField(
                            controller: last_nameController,
                            decoration: InputDecoration(border: InputBorder.none),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
               SizedBox(height: 10.0),
              Text(
                "Date",
                style: TextStyle(color: Colors.black, fontSize: 20.0),
              ),
              SizedBox(height: 10.0),
              InkWell(
                onTap: () => _selectDate(context),
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      selectedDate != null
                          ? Text(
                              selectedDate!.toString(),
                              style: TextStyle(fontSize: 16.0),
                            )
                          : Text(
                              'Select Date',
                              style: TextStyle(fontSize: 16.0),
                            ),
                      Icon(Icons.calendar_today),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                "Address",
                style: TextStyle(color: Colors.black, fontSize: 20.0),
              ),
              SizedBox(height: 10.0),
              Container(
                padding: EdgeInsets.only(left: 10.0),
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: addressController,
                  decoration: InputDecoration(border: InputBorder.none),
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                "City",
                style: TextStyle(color: Colors.black, fontSize: 20.0),
              ),
              SizedBox(height: 10.0),
              Container(
                padding: EdgeInsets.only(left: 10.0),
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: cityController,
                  decoration: InputDecoration(border: InputBorder.none),
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                "District",
                style: TextStyle(color: Colors.black, fontSize: 20.0),
              ),
              SizedBox(height: 10.0),
              Container(
                padding: EdgeInsets.only(left: 10.0),
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: districtController,
                  decoration: InputDecoration(border: InputBorder.none),
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                "Ward",
                style: TextStyle(color: Colors.black, fontSize: 20.0),
              ),
              SizedBox(height: 10.0),
              Container(
                padding: EdgeInsets.only(left: 10.0),
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: wardController,
                  decoration: InputDecoration(border: InputBorder.none),
              ),
            ),
            SizedBox(height: 20.0),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  String id = randomAlphaNumeric(10);
                  Map<String, dynamic> staffInfoMap = {
                    "Id": id,
                    "First_Name": first_nameController.text,
                    "Last_Name": last_nameController.text,
                    "Date": dateController.text,
                    "Address": addressController.text,
                    "City": cityController.text,
                    "Ward": wardController.text,
                    "District": districtController.text,
                  };
                  await DatabaseMethod().addStaff(staffInfoMap, id).then((value) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Staff added successfully!')),
                    );

                      first_nameController.clear();
                      last_nameController.clear();
                      dateController.clear();
                      addressController.clear();
                      cityController.clear();
                      wardController.clear();
                      districtController.clear();
                      setState(() {
                        selectedDate = null;
                      });
                  }).catchError((error) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Failed to add staff!')),
                    );
                  });
                },
                child: Text(
                  "Create",
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
