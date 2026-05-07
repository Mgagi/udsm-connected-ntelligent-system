import 'package:flutter/material.dart';

import 'alumni_screens.dart';
import 'theme.dart';

class UcisMobilePrototype extends StatefulWidget {
  const UcisMobilePrototype({super.key});

  @override
  State<UcisMobilePrototype> createState() => _UcisMobilePrototypeState();
}

class _UcisMobilePrototypeState extends State<UcisMobilePrototype> {
  int _page = -2;
  bool _alumniSessionWarningShown = false;

  void _openStaffLogin() => setState(() => _page = -1);
  void _openStaffHome() => setState(() => _page = 0);
  void _openAlumniLogin() => setState(() => _page = -3);
  void _openAlumniHome() {
    setState(() => _page = alumniHomePage);
    WidgetsBinding.instance.addPostFrameCallback((_) => _showAlumniSessionWarning());
  }

  void _logout() => setState(() {
        _page = -2;
        _alumniSessionWarningShown = false;
      });

  void _showAlumniSessionWarning() {
    if (_alumniSessionWarningShown || !mounted) return;
    _alumniSessionWarningShown = true;
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Session timeout warning'),
        content: const Text('For your security, this alumni session will expire in 02:00 if there is no activity.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Stay signed in')),
          FilledButton(onPressed: () => Navigator.pop(context), child: const Text('Continue')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final phone = _page == -2
        ? WelcomeScreen(onStaffLogin: _openStaffLogin, onAlumniLogin: _openAlumniLogin)
        : _page == -1
            ? StaffLoginScreen(onSignIn: _openStaffHome)
            : _page == -3
                ? AlumniLoginScreen(
                    onSignIn: _openAlumniHome,
                    onRegister: () => setState(() => _page = -4),
                    onBack: () => setState(() => _page = -2),
                  )
                : _page == -4
                    ? AlumniRegistrationScreen(
                        onSubmit: () => setState(() => _page = -5),
                        onBack: _openAlumniLogin,
                      )
                    : _page == -5
                        ? AlumniStatusScreen.pending(onAction: () => setState(() => _page = -6))
                        : _page == -6
                            ? AlumniStatusScreen.approved(onAction: _openAlumniLogin)
                            : _page >= alumniHomePage
                                ? AlumniShell(
                                    page: _page,
                                    onOpen: (page) => setState(() => _page = page),
                                    onLogout: _logout,
                                  )
                                : PhoneShell(
                                    selectedIndex: _page > 5 ? 0 : _page,
                                    onSelect: (index) => setState(() => _page = index),
                                    child: switch (_page) {
                                      0 => StaffHomeScreen(onOpenProfile: () => setState(() => _page = 6)),
                                      1 => const AnnouncementsScreen(),
                                      2 => const ServicesScreen(),
                                      3 => const CalendarScreen(),
                                      4 => const AiAssistantScreen(),
                                      5 => const CampusMapScreen(),
                                      6 => StaffProfileScreen(onLogout: _logout),
                                      _ => StaffHomeScreen(onOpenProfile: () => setState(() => _page = 6)),
                                    },
                                  );

    return Scaffold(
      backgroundColor: ucisCanvas,
      floatingActionButton: _page >= alumniHomePage && _page != alumniAssistantPage
          ? Padding(
              padding: const EdgeInsets.only(bottom: 72),
              child: FloatingActionButton(
                tooltip: 'Open AI assistant',
                onPressed: () => setState(() => _page = alumniAssistantPage),
                child: const Icon(Icons.smart_toy_outlined),
              ),
            )
          : null,
      body: SafeArea(child: phone),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key, required this.onStaffLogin, required this.onAlumniLogin});

  final VoidCallback onStaffLogin;
  final VoidCallback onAlumniLogin;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: ucisCanvas,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(22, 34, 22, 20),
            color: ucisBlue,
            child: const Column(
              children: [
                UdsLogo(size: 50, compact: true),
                SizedBox(height: 10),
                Text('UDSM MOBILE\nAPPLICATION', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w900, height: 1.08)),
                SizedBox(height: 4),
                Text('University of Dar es Salaam', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700)),
                Text('Connected Intelligent System', style: TextStyle(color: Color(0xFFE6ECFF), fontSize: 10, fontWeight: FontWeight.w700)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(22),
            child: UcisCard(
              child: Column(
                children: [
                  const Text('Welcome', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: ucisInk)),
                  const SizedBox(height: 4),
                  const Text('Choose your account type to continue.', textAlign: TextAlign.center, style: TextStyle(fontSize: 11, color: ucisMuted)),
                  const SizedBox(height: 16),
                  FilledButton.icon(onPressed: onStaffLogin, icon: const Icon(Icons.badge_outlined), label: const Text('Login as Staff')),
                  const SizedBox(height: 10),
                  FilledButton.icon(onPressed: onAlumniLogin, icon: const Icon(Icons.workspace_premium_outlined), label: const Text('Login as Alumni')),
                  const SizedBox(height: 10),
                  OutlinedButton.icon(onPressed: null, icon: const Icon(Icons.school_outlined), label: const Text('Login as Student')),
                  const SizedBox(height: 8),
                  const Text('Student access is disabled in this build. Staff and Alumni UI are available.', textAlign: TextAlign.center, style: TextStyle(fontSize: 10, color: ucisMuted)),
                  const SizedBox(height: 8),
                  OutlinedButton.icon(onPressed: null, icon: const Icon(Icons.admin_panel_settings_outlined), label: const Text('Login as Admin')),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class StaffLoginScreen extends StatelessWidget {
  const StaffLoginScreen({super.key, required this.onSignIn});

  final VoidCallback onSignIn;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: ucisCanvas,
      child: Column(
        children: [
          const UcisHeader(title: 'Staff Login', subtitle: 'Sign in with UDSM SSO', leading: 'U', actions: [Icons.arrow_back, Icons.close]),
          Padding(
            padding: const EdgeInsets.all(18),
            child: UcisCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text('Staff account', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: ucisInk)),
                  const SizedBox(height: 12),
                  const TextField(decoration: InputDecoration(hintText: 'Staff email or ID')),
                  const SizedBox(height: 10),
                  const TextField(decoration: InputDecoration(hintText: 'Password'), obscureText: true),
                  const SizedBox(height: 8),
                  const Text('Secure staff access for teaching, student management, grading, events, and announcements.', style: TextStyle(fontSize: 11, color: ucisMuted)),
                  const SizedBox(height: 12),
                  FilledButton(onPressed: onSignIn, child: const Text('Continue')),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PhoneShell extends StatelessWidget {
  const PhoneShell({super.key, required this.selectedIndex, required this.onSelect, required this.child});

  final int selectedIndex;
  final ValueChanged<int> onSelect;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: ucisCanvas,
      child: Column(
        children: [
          Expanded(child: child),
          UcisBottomNav(selectedIndex: selectedIndex, onSelect: onSelect),
        ],
      ),
    );
  }
}

class StaffHomeScreen extends StatelessWidget {
  const StaffHomeScreen({super.key, required this.onOpenProfile});

  final VoidCallback onOpenProfile;

  @override
  Widget build(BuildContext context) {
    return AppScrollView(
      header: const UcisHeader(
        title: 'Welcome back,\nDr. James Kalolo',
        subtitle: 'Staff     College of ICT',
        leading: 'DJ',
        badge: '2',
        trailing: 'J',
      ),
      children: [
        const _AudiencePill(text: 'Lecturer     Computer Engineering and IT'),
        const SizedBox(height: 12),
        const SectionCard(
          title: 'Quick Access',
          child: Column(
            children: [
              Row(children: [
                Expanded(child: QuickTile(icon: Icons.book_outlined, title: 'LMS', subtitle: 'Teaching')),
                SizedBox(width: 10),
                Expanded(child: QuickTile(icon: Icons.folder_copy_outlined, title: 'FYP', subtitle: 'Review')),
                SizedBox(width: 10),
                Expanded(child: QuickTile(icon: Icons.groups_2_outlined, title: 'Students', subtitle: 'Manage')),
              ]),
              SizedBox(height: 10),
              QuickTile(icon: Icons.fact_check_outlined, title: 'Grading', subtitle: 'Submit'),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Wrap(spacing: 9, runSpacing: 9, children: [
          MiniAction(icon: Icons.person_outline, title: 'Profile', subtitle: 'Info', onTap: onOpenProfile),
          const MiniAction(icon: Icons.calendar_month_outlined, title: 'Calendar', subtitle: 'Schedule'),
          const MiniAction(icon: Icons.map_outlined, title: 'Map', subtitle: 'Navigate'),
        ]),
        const SizedBox(height: 12),
        const SectionCard(
          title: 'My Tasks',
          child: Column(
            children: [
              TaskItem(title: 'Submit Semester I Grades', status: 'Pending', level: 'High'),
              SizedBox(height: 10),
              TaskItem(title: 'Review FYP Proposals', status: 'In Progress', level: 'Medium'),
              SizedBox(height: 10),
              TaskItem(title: 'Approve consultation slots', status: 'Today', level: 'Normal'),
            ],
          ),
        ),
      ],
    );
  }
}

class StaffProfileScreen extends StatelessWidget {
  const StaffProfileScreen({super.key, required this.onLogout});

  final VoidCallback onLogout;

  @override
  Widget build(BuildContext context) {
    return AppScrollView(
      header: const UcisHeader(title: 'Profile', subtitle: 'Staff account details', leading: 'DJ'),
      children: [
        const SectionCard(
          title: 'Dr. James Kalolo',
          subtitle: 'Lecturer     Computer Engineering and IT',
          child: Column(
            children: [
              StaffProfileRow(icon: Icons.badge_outlined, title: 'Staff ID', value: 'UDSM-STAFF-2048'),
              SizedBox(height: 10),
              StaffProfileRow(icon: Icons.email_outlined, title: 'Email', value: 'james.kalolo@udsm.ac.tz'),
              SizedBox(height: 10),
              StaffProfileRow(icon: Icons.school_outlined, title: 'College', value: 'College of ICT'),
            ],
          ),
        ),
        const SizedBox(height: 12),
        FilledButton.icon(
          onPressed: onLogout,
          icon: const Icon(Icons.logout),
          label: const Text('Logout'),
          style: FilledButton.styleFrom(backgroundColor: ucisRed),
        ),
      ],
    );
  }
}

class AnnouncementsScreen extends StatelessWidget {
  const AnnouncementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppScrollView(
      header: UcisHeader(title: 'Announcements', subtitle: 'Staff alerts & academic updates', leading: 'U', badge: '1'),
      children: [
        TextField(decoration: InputDecoration(hintText: 'Search announcements...')),
        SizedBox(height: 10),
        FilterRow(labels: ['All', 'Academic', 'Events', 'Emergency', 'General']),
        SizedBox(height: 12),
        AnnouncementItem(title: 'Semester II Examination Timetable Released', tag: 'Academic', level: 'Urgent', time: '2 hours ago'),
        SizedBox(height: 10),
        AnnouncementItem(title: 'FYP proposal review deadline', tag: 'Staff', level: 'Medium', time: '5 hours ago'),
        SizedBox(height: 10),
        AnnouncementItem(title: 'Senate results submission window', tag: 'General', level: '', time: '1 day ago'),
      ],
    );
  }
}

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppScrollView(
      header: UcisHeader(title: 'Services', subtitle: 'Staff academic systems', leading: 'U'),
      children: [
        ServiceCard(title: 'ARIS', body: 'Manage marks, class lists, course allocations, and academic records.', chips: ['Class Lists', 'Marks', 'Courses', 'Reports']),
        SizedBox(height: 12),
        ServiceCard(title: 'LMS', body: 'Upload course materials, assignments, discussions, and online lecture resources.', chips: ['Courses', 'Assignments', 'Resources', 'Forums']),
        SizedBox(height: 12),
        ServiceCard(title: 'FYP Portal', body: 'Review student submissions, supervisor comments, and project progress.', chips: ['Submissions', 'Supervision', 'Review']),
      ],
    );
  }
}

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppScrollView(
      header: UcisHeader(title: 'Calendar', subtitle: 'Academic calendar & events', leading: 'U', trailing: '>'),
      children: [
        SectionCard(
          title: 'March 2026',
          subtitle: 'Tap an item below for details',
          child: Column(
            children: [
              EventRow(title: 'Faculty Meeting', meta: 'Mar 5, 2026 - Nkrumah Hall', tag: 'Academic'),
              EventRow(title: 'UDSM Career Fair 2026', meta: 'Mar 15, 2026 - Nkrumah Hall', tag: 'Events'),
              EventRow(title: 'Semester II Exams Start', meta: 'Mar 20, 2026 - Campus wide', tag: 'Academic'),
            ],
          ),
        ),
      ],
    );
  }
}

class AiAssistantScreen extends StatelessWidget {
  const AiAssistantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppScrollView(
      header: UcisHeader(title: 'AI Assistant', subtitle: 'Online - Ready to help', leading: 'U'),
      children: [
        PromptChip(text: 'How do I submit semester grades?'),
        PromptChip(text: 'Show my assigned FYP reviews'),
        PromptChip(text: 'What classes do I teach today?'),
        PromptChip(text: 'How do I approve consultation slots?'),
        PromptChip(text: 'Where is the Health Center?'),
        PromptChip(text: 'FYP supervision guidelines?'),
        SizedBox(height: 16),
        TextField(minLines: 3, maxLines: 3, decoration: InputDecoration(hintText: '')),
        SizedBox(height: 10),
        TextField(decoration: InputDecoration(hintText: 'Type a message...')),
        SizedBox(height: 10),
        FilledButton(onPressed: null, child: Text('Send')),
      ],
    );
  }
}

class CampusMapScreen extends StatelessWidget {
  const CampusMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppScrollView(
      header: UcisHeader(title: 'Campus Map', subtitle: 'Find buildings, offices & facilities', leading: 'U'),
      children: [
        TextField(decoration: InputDecoration(hintText: 'Search locations... (e.g., CoICT, Library, Health Center)')),
        SizedBox(height: 12),
        MapPreview(),
        SizedBox(height: 10),
        FilterRow(labels: ['All', 'Academic', 'Hostel', 'Services']),
        SizedBox(height: 10),
        Text('Offices', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900, color: ucisInk)),
        LocationRow(title: 'College of ICT (CoICT)', meta: '1 Floors - Main Campus'),
        LocationRow(title: 'Main Library', meta: '3 Floors - Main Campus'),
        LocationRow(title: 'Health Center', meta: '1 Floor - Main Campus'),
        LocationRow(title: 'Nkrumah Hall', meta: '2 Floors - Main Campus'),
      ],
    );
  }
}

class UcisHeader extends StatelessWidget {
  const UcisHeader({super.key, required this.title, required this.subtitle, required this.leading, this.badge, this.trailing, this.actions = const []});

  final String title;
  final String subtitle;
  final String leading;
  final String? badge;
  final String? trailing;
  final List<IconData> actions;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ucisBlue,
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 16),
      child: Row(
        children: [
          CircleAvatar(radius: 17, backgroundColor: Colors.white.withValues(alpha: .18), child: Text(leading, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w900))),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w900, height: 1.05)),
                Text(subtitle, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Color(0xFFE8EEFF), fontSize: 10, fontWeight: FontWeight.w700)),
              ],
            ),
          ),
          if (badge != null) HeaderButton(label: badge!, color: ucisRed),
          if (trailing != null) ...[const SizedBox(width: 8), HeaderButton(label: trailing!)],
          for (final icon in actions) ...[const SizedBox(width: 8), HeaderIcon(icon: icon)],
        ],
      ),
    );
  }
}

class AppScrollView extends StatelessWidget {
  const AppScrollView({super.key, required this.header, required this.children});

  final Widget header;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        header,
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(14),
            child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: children),
          ),
        ),
      ],
    );
  }
}

class UcisCard extends StatelessWidget {
  const UcisCard({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: ucisLine),
        boxShadow: const [BoxShadow(color: Color(0x12000000), blurRadius: 12, offset: Offset(0, 6))],
      ),
      child: child,
    );
  }
}

class SectionCard extends StatelessWidget {
  const SectionCard({super.key, required this.title, required this.child, this.subtitle, this.trailing});

  final String title;
  final String? subtitle;
  final Widget child;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return UcisCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(child: Text(title, textAlign: subtitle == null ? TextAlign.start : TextAlign.center, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w900, color: ucisInk))),
              if (trailing != null) trailing!,
            ],
          ),
          if (subtitle != null) Text(subtitle!, textAlign: TextAlign.center, style: const TextStyle(fontSize: 10, color: ucisMuted, fontWeight: FontWeight.w700)),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}

class UdsLogo extends StatelessWidget {
  const UdsLogo({super.key, required this.size, this.compact = false});

  final double size;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Image.asset('assets/images/udsm_logo.png', width: size, height: compact ? size : null, fit: BoxFit.contain);
  }
}

class HeaderButton extends StatelessWidget {
  const HeaderButton({super.key, required this.label, this.color});

  final String label;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 38,
      height: 28,
      alignment: Alignment.center,
      decoration: BoxDecoration(color: (color ?? Colors.white).withValues(alpha: color == null ? .16 : .95), borderRadius: BorderRadius.circular(12)),
      child: Text(label, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w900)),
    );
  }
}

class HeaderIcon extends StatelessWidget {
  const HeaderIcon({super.key, required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 32,
      alignment: Alignment.center,
      decoration: BoxDecoration(color: Colors.white.withValues(alpha: .16), borderRadius: BorderRadius.circular(12)),
      child: Icon(icon, color: Colors.white, size: 17),
    );
  }
}

class _AudiencePill extends StatelessWidget {
  const _AudiencePill({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
        decoration: BoxDecoration(color: ucisBlue, borderRadius: BorderRadius.circular(999)),
        child: Text(text, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w900)),
      ),
    );
  }
}

class QuickTile extends StatelessWidget {
  const QuickTile({super.key, required this.icon, required this.title, required this.subtitle});

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 84,
      padding: const EdgeInsets.all(7),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: ucisLine)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: ucisBlue, size: 18),
          const SizedBox(height: 3),
          Text(title, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w900, color: ucisInk)),
          Text(subtitle, textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 8.5, color: ucisMuted, height: 1.05)),
        ],
      ),
    );
  }
}

class MiniAction extends StatelessWidget {
  const MiniAction({super.key, required this.icon, required this.title, required this.subtitle, this.onTap});

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 112,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: UcisCard(
          child: Column(
            children: [
              Icon(icon, color: ucisBlue, size: 18),
              const SizedBox(height: 5),
              Text(title, textAlign: TextAlign.center, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w900, color: ucisInk)),
              Text(subtitle, textAlign: TextAlign.center, style: const TextStyle(fontSize: 9, color: ucisMuted)),
            ],
          ),
        ),
      ),
    );
  }
}

class StaffProfileRow extends StatelessWidget {
  const StaffProfileRow({super.key, required this.icon, required this.title, required this.value});

  final IconData icon;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(border: Border.all(color: ucisLine), borderRadius: BorderRadius.circular(14)),
      child: Row(
        children: [
          Icon(icon, color: ucisBlue, size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 10, color: ucisMuted, fontWeight: FontWeight.w800)),
                Text(value, style: const TextStyle(fontSize: 12, color: ucisInk, fontWeight: FontWeight.w900)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TaskItem extends StatelessWidget {
  const TaskItem({super.key, required this.title, required this.status, required this.level});

  final String title;
  final String status;
  final String level;

  @override
  Widget build(BuildContext context) {
    final color = switch (level) {
      'High' => ucisRed,
      'Medium' => ucisGold,
      _ => ucisGreen,
    };

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: ucisLine),
      ),
      child: Row(
        children: [
          const Icon(Icons.assignment_outlined, color: ucisBlue, size: 19),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w900, color: ucisInk)),
                Text(status, style: const TextStyle(fontSize: 10, color: ucisMuted)),
              ],
            ),
          ),
          BadgePill(text: level, color: color),
        ],
      ),
    );
  }
}

class AnnouncementItem extends StatelessWidget {
  const AnnouncementItem({super.key, required this.title, required this.tag, required this.level, required this.time});

  final String title;
  final String tag;
  final String level;
  final String time;

  @override
  Widget build(BuildContext context) {
    return UcisCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 6,
            runSpacing: 6,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              BadgePill(text: tag, color: ucisBlue),
              if (level.isNotEmpty) BadgePill(text: level, color: ucisRed),
              Text(time, style: const TextStyle(fontSize: 10, color: ucisMuted)),
            ],
          ),
          const SizedBox(height: 8),
          Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w900, color: ucisInk)),
          const SizedBox(height: 4),
          const Text('Official academic update for staff action, teaching coordination, and student guidance.', style: TextStyle(fontSize: 11, color: ucisMuted, height: 1.25)),
          const SizedBox(height: 8),
          const Text('Open >', style: TextStyle(fontSize: 11, color: ucisBlue, fontWeight: FontWeight.w900)),
        ],
      ),
    );
  }
}

class ServiceCard extends StatelessWidget {
  const ServiceCard({super.key, required this.title, required this.body, required this.chips});

  final String title;
  final String body;
  final List<String> chips;

  @override
  Widget build(BuildContext context) {
    return UcisCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            const CircleAvatar(radius: 16, backgroundColor: Color(0xFFF2F4F7), child: Icon(Icons.school_outlined, color: ucisBlue, size: 17)),
            const SizedBox(width: 10),
            Expanded(child: Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: ucisInk))),
            const BadgePill(text: 'Connected', color: ucisGreen),
          ]),
          const SizedBox(height: 6),
          Text(body, style: const TextStyle(fontSize: 11, color: ucisMuted)),
          const SizedBox(height: 10),
          Wrap(spacing: 8, runSpacing: 8, children: [for (final chip in chips) BadgePill(text: chip, color: ucisMuted, pale: true)]),
          const SizedBox(height: 10),
          OutlinedButton(onPressed: () {}, child: Text('Open $title >')),
        ],
      ),
    );
  }
}

class EventRow extends StatelessWidget {
  const EventRow({super.key, required this.title, required this.meta, required this.tag});

  final String title;
  final String meta;
  final String tag;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(border: Border.all(color: ucisLine), borderRadius: BorderRadius.circular(14)),
        child: Row(
          children: [
            const Icon(Icons.calendar_month_outlined, color: ucisBlue, size: 18),
            const SizedBox(width: 10),
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w900, color: ucisInk)), Text(meta, style: const TextStyle(fontSize: 10, color: ucisMuted))])),
            BadgePill(text: tag, color: tag == 'Events' ? ucisGold : ucisBlue),
          ],
        ),
      ),
    );
  }
}

class PromptChip extends StatelessWidget {
  const PromptChip({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(999), border: Border.all(color: ucisLine)),
          child: Text(text, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: ucisInk)),
        ),
      ),
    );
  }
}

class MapPreview extends StatelessWidget {
  const MapPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 132,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(colors: [Color(0xFFE9EFFB), Color(0xFFE8F6ED)]),
        border: Border.all(color: ucisLine),
      ),
      alignment: Alignment.bottomLeft,
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('UDSM Main Campus', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900, color: ucisInk)),
          Text('Dar es Salaam, Tanzania', style: TextStyle(fontSize: 10, color: ucisMuted)),
        ],
      ),
    );
  }
}

class LocationRow extends StatelessWidget {
  const LocationRow({super.key, required this.title, required this.meta});

  final String title;
  final String meta;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: UcisCard(
        child: Row(
          children: [
            const Icon(Icons.location_on, color: Color(0xFFE84C88), size: 18),
            const SizedBox(width: 10),
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w900, color: ucisInk)), Text(meta, style: const TextStyle(fontSize: 10, color: ucisMuted))])),
            const Icon(Icons.chevron_right, color: ucisMuted, size: 18),
          ],
        ),
      ),
    );
  }
}

class FilterRow extends StatelessWidget {
  const FilterRow({super.key, required this.labels});

  final List<String> labels;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (var i = 0; i < labels.length; i++) ...[
            BadgePill(text: labels[i], color: i == 0 ? ucisBlue : ucisMuted, pale: i != 0),
            const SizedBox(width: 8),
          ],
        ],
      ),
    );
  }
}

class BadgePill extends StatelessWidget {
  const BadgePill({super.key, required this.text, required this.color, this.pale = false});

  final String text;
  final Color color;
  final bool pale;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: BoxDecoration(color: pale ? const Color(0xFFF2F4F7) : color.withValues(alpha: .14), borderRadius: BorderRadius.circular(999)),
      child: Text(text, style: TextStyle(color: pale ? ucisMuted : color, fontSize: 10, fontWeight: FontWeight.w900)),
    );
  }
}

class UcisBottomNav extends StatelessWidget {
  const UcisBottomNav({super.key, required this.selectedIndex, required this.onSelect});

  final int selectedIndex;
  final ValueChanged<int> onSelect;

  static const _items = [
    (Icons.home_outlined, 'Home'),
    (Icons.notifications_none, 'Alerts'),
    (Icons.layers_outlined, 'Services'),
    (Icons.calendar_month_outlined, 'Calendar'),
    (Icons.smart_toy_outlined, 'AI'),
    (Icons.map_outlined, 'Map'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 62,
      color: Colors.white,
      child: Row(
        children: [
          for (var i = 0; i < _items.length; i++)
            Expanded(
              child: InkWell(
                onTap: () => onSelect(i),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(_items[i].$1, size: 18, color: selectedIndex == i ? ucisBlue : ucisMuted),
                    const SizedBox(height: 3),
                    Text(_items[i].$2, style: TextStyle(fontSize: 9, color: selectedIndex == i ? ucisBlue : ucisMuted, fontWeight: FontWeight.w900)),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
