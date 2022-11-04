import 'package:path_provider/path_provider.dart';

void init() async {
  String dir;
  String path;
  dir = (await getApplicationDocumentsDirectory()).path;
  path = "$dir/invoice.pdf";
}
