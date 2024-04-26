import 'package:get/get.dart';
import 'package:myexam/widgets/common_class/marks.dart';

class ExamController extends GetxController {
  RxInt grpValue = 0.obs;
  RxInt currentIndex = 0.obs;
  MarksData marksData = MarksData(examList: []);
}
