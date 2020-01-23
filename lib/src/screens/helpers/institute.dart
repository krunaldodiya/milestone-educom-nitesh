import 'package:milestone_educom/src/helpers/vars.dart';
import 'package:milestone_educom/src/models/institute.dart';

String getInstituteName(Institute institute) {
  if (institute.name != null) {
    return institute.name;
  }

  return appName;
}
