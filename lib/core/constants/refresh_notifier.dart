import 'package:flutter/foundation.dart';

/// Global event to force pages that list tasks to refresh.
final ValueNotifier<bool> refreshNotifier = ValueNotifier(false);