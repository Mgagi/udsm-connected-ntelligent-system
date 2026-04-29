import 'package:flutter/material.dart';

class AdminSection {
  const AdminSection({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.builder,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final WidgetBuilder builder;
}

class Metric {
  const Metric(this.label, this.value, this.detail, this.icon, this.color);

  final String label;
  final String value;
  final String detail;
  final IconData icon;
  final Color color;
}

class TableItem {
  const TableItem({
    required this.title,
    required this.subtitle,
    required this.status,
    required this.meta,
  });

  final String title;
  final String subtitle;
  final String status;
  final String meta;
}
