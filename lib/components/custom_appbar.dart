import 'package:app_hello/untils/config.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget{
  const CustomAppBar({Key? key, this.appTitle, this.route, this.icon, this.actions, required double iconSize  }): super(key: key);
  @override
  Size get preferredSize => const Size.fromHeight(60);//default height of app bar is 60// chiều cao mặc định của thanh ứng dụng là 60

  final String? appTitle;
  final String? route;
  final FaIcon? icon;
  final List<Widget>? actions;

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar>{
  bool isFav = false;
  @override
  Widget build(BuildContext context){
    return AppBar(
      automaticallyImplyLeading: true,
      backgroundColor: Colors.white,// backgroud color is white in this app//mau nen la mau trang
      elevation: 0,
      title: Text(
        widget.appTitle!,
        style: const TextStyle(
          fontSize: 20,
          color: Colors.black,
        ),
      ),
      //if icon is not set, return null//nếu biểu tượng không được đặt, trả về null
      leading: widget.icon != null
          ? Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Config.primaryColor,
            ),
            child: IconButton(
              onPressed: (){
                //if route is given, then this icon button will navigate to that route// nếu tuyến đường được đưa ra thì nút biểu tượng này sẽ điều hướng đến tuyến đường đó
                if (widget.route != null){
                  Navigator.of(context).pushNamed(widget.route!);
                }else{
                  //else, just simply pop back to previous page// nếu không, chỉ cần quay lại trang trước
                  Navigator.of(context).pop();
                }
              }, 
              icon: widget.icon!,
              iconSize: 16,
              color: Colors.white,
            ),
          )
          :null,
          // if action is not set, return null// nếu hành động không được đặt, trả về null
          actions: widget.actions ?? null,
    );
  }
}