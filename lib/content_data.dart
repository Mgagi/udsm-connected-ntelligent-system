import 'package:flutter/material.dart';

import 'models.dart';
import 'theme.dart';

const dashboardMetrics = <Metric>[
  Metric('Active users', '28,640', 'Students 24k, staff 1.2k, alumni 3.1k', Icons.people_alt_outlined, ucisGreen),
  Metric('Pending review', '18', 'Announcements awaiting approval', Icons.pending_actions_outlined, ucisGold),
  Metric('Next 7 days', '12', 'Events and academic deadlines', Icons.event_available_outlined, Colors.indigo),
  Metric('Emergency updates', '3', 'Unresolved contact changes', Icons.local_phone_outlined, ucisRed),
  Metric('Feedback', '46', 'New submissions this week', Icons.mark_unread_chat_alt_outlined, Colors.teal),
];

const sampleItems = <TableItem>[
  TableItem(title: 'Semester II registration deadline', subtitle: 'Academic Office', status: 'Urgent', meta: 'Today 16:00'),
  TableItem(title: 'Library system maintenance', subtitle: 'Directorate of ICT', status: 'Scheduled', meta: '30 Apr 2026'),
  TableItem(title: 'DARUSO leadership forum', subtitle: 'DARUSO', status: 'Active', meta: '2 May 2026'),
  TableItem(title: 'Graduation rehearsal notice', subtitle: 'Administration', status: 'Archived', meta: '11 Apr 2026'),
];
