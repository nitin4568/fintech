import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomBottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final textColor =
        Theme.of(context).textTheme.bodySmall?.color ?? Colors.black;

    return Container(
      margin: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10.r,
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.r),
        child: BottomNavigationBar(
          currentIndex: currentIndex,

          onTap: (index) {
            if (index >= 0 && index < 4) {
              onTap(index);
            }
          },

          backgroundColor: Theme.of(context).cardColor,
          elevation: 0,

          selectedItemColor: const Color(0xFF3B82F6),
          unselectedItemColor: textColor.withOpacity(0.5),

          selectedFontSize: 12.sp,
          unselectedFontSize: 11.sp,

          type: BottomNavigationBarType.fixed,

          items: [
            _item(Icons.home, "Home", currentIndex == 0),
            _item(Icons.analytics, "Insights", currentIndex == 1),
            _item(Icons.flag, "Goals", currentIndex == 2),
            _item(Icons.person, "Profile", currentIndex == 3),
          ],
        ),
      ),
    );
  }

  BottomNavigationBarItem _item(
      IconData icon, String label, bool isSelected) {
    return BottomNavigationBarItem(
      icon: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        height: isSelected ? 32.h : 26.h,
        child: Icon(icon, size: isSelected ? 22.sp : 20.sp),
      ),
      label: label,
    );
  }
}