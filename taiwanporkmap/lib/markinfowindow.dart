import 'package:flutter/material.dart';

class InfoWindowData{
  ///名稱	@name market_name
  ///標章代碼	@caseCode case_code
  ///介紹	@context context
  ///住址	@address addr
  ///營業天 @weekDay business_week
  ///營業時間	@businessTime business_hours business_hours_end
  ///有效日期	 @validDate ValidDate
  ///更新時間	@updateDateTime last_edited_date
  ///@isShow Show or hide
  bool isShow = false;
  String name = '';
  String caseCode = '';
  String context = '';
  String address = '';
  String weekDay = '';
  String businessTime = '';
  String validDate = '';
  String updateDateTime = '';
}

//callback
typedef void BoolCallback(bool val);

//ignore: must_be_immutable
class MarkInfoWindow extends StatefulWidget {

  bool isShow;
  String name = '';
  String caseCode = '';
  String context = '';
  String address = '';
  String weekDay = '';
  String businessTime = '';
  String validDate = '';
  String updateDateTime = '';
  //callback
  BoolCallback boolCallback;

  MarkInfoWindow({
    Key key,
    this.isShow,
    this.name,
    this.caseCode,
    this.context,
    this.address,
    this.weekDay,
    this.businessTime,
    this.validDate,
    this.updateDateTime,
    this.boolCallback,
  }) : super(key: key);

  @override
  _MarkInfoWindowState createState() {
    return new _MarkInfoWindowState();
  }
}

class _MarkInfoWindowState extends State<MarkInfoWindow> {
  _MarkInfoWindowState();

  @override
  void initState() {
    super.initState();
  }

  void _close(){
    setState(() {
      widget.isShow=false;
      //use callback update parent variable
      widget.boolCallback(false);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.isShow,
      child:Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              decoration:BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius:BorderRadius.all(Radius.circular(10))
              ),
              width: MediaQuery.of(context).size.width * 4/ 5,
              //color: Colors.amber,
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      width: 32.0,
                      height: 32.0,
                      decoration: new BoxDecoration(
                        color: Colors.orange,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: Icon(Icons.close,size:14),
                        onPressed: _close,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(4.0),
                          child:Text('名稱:  '),
                        ),
                        Text(
                            widget.name,
                            style:
                            TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(4.0),
                          child:Text('標章代碼:  '),
                        ),
                        Text(widget.caseCode)
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(4.0),
                          child:Text('介紹:  '),
                        ),
                        Flexible(
                          child: Container(
                            child:Text(
                              widget.context,
                              softWrap: true,
                              //overflow: TextOverflow.ellipsis,
                              // style: TextStyle(
                              //   fontSize: 13.0,
                              //   fontFamily: 'Roboto',
                              //   color: new Color(0xFF212121),
                              //   fontWeight: FontWeight.bold,
                              // ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(4.0),
                          child:Text('住址:  '),
                        ),
                        Flexible(
                          child: Container(
                            child:Text(
                              widget.address,
                              softWrap: true,
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(4.0),
                          child:Text('營業天:  '),
                        ),
                        Flexible(
                          child: Container(
                            child:Text(
                              widget.weekDay,
                              softWrap: true,
                              style: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(4.0),
                          child:Text('營業時間:  '),
                        ),
                        Text(widget.businessTime)
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(4.0),
                          child:Text('有效日期:  '),
                        ),
                        Text(widget.validDate)
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(4.0),
                          child:Text('更新時間:  '),
                        ),
                        Text(widget.updateDateTime)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

