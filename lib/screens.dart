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
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _showAlumniSessionWarning());
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
        content: const Text(
            'For your security, this alumni session will expire in 02:00 if there is no activity.'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Stay signed in')),
          FilledButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Continue')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final phone = _page == -2
        ? WelcomeScreen(
            onStaffLogin: _openStaffLogin, onAlumniLogin: _openAlumniLogin)
        : _page == -1
            ? StaffLoginScreen(
                onSignIn: _openStaffHome,
                onBack: () => setState(() => _page = -2),
                onCancel: () => setState(() => _page = -2),
              )
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
                        ? AlumniStatusScreen.pending(
                            onAction: () => setState(() => _page = -6))
                        : _page == -6
                            ? AlumniStatusScreen.approved(
                                onAction: _openAlumniLogin)
                            : _page >= alumniHomePage
                                ? AlumniShell(
                                    page: _page,
                                    onOpen: (page) =>
                                        setState(() => _page = page),
                                    onLogout: _logout,
                                    onBackToLogin: _openAlumniLogin,
                                  )
                                : PhoneShell(
                                    selectedIndex: _page == 6
                                        ? -1
                                        : (_page > 4 ? 0 : _page),
                                    onSelect: (index) =>
                                        setState(() => _page = index),
                                    child: switch (_page) {
                                      0 => StaffHomeScreen(
                                          onOpenProfile: () =>
                                              setState(() => _page = 6),
                                          onBackToLogin: _openStaffLogin),
                                      1 => AnnouncementsScreen(
                                          onBack: () =>
                                              setState(() => _page = 0)),
                                      2 => ServicesScreen(
                                          onBack: () =>
                                              setState(() => _page = 0)),
                                      3 => CalendarScreen(
                                          onBack: () =>
                                              setState(() => _page = 0)),
                                      4 => AiAssistantScreen(
                                          onBack: () =>
                                              setState(() => _page = 0)),
                                      5 => CampusMapScreen(
                                          onBack: () =>
                                              setState(() => _page = 0)),
                                      6 => StaffProfileScreen(
                                          onLogout: _logout,
                                          onBack: () =>
                                              setState(() => _page = 0)),
                                      _ => StaffHomeScreen(
                                          onOpenProfile: () =>
                                              setState(() => _page = 6),
                                          onBackToLogin: _openStaffLogin),
                                    },
                                  );

    return Scaffold(
      backgroundColor: ucisCanvas,
      floatingActionButton: _page >= alumniHomePage &&
              _page != alumniAssistantPage
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
  const WelcomeScreen(
      {super.key, required this.onStaffLogin, required this.onAlumniLogin});

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
                Text('UDSM MOBILE\nAPPLICATION',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w900,
                        height: 1.08)),
                SizedBox(height: 4),
                Text('University of Dar es Salaam',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w700)),
                Text('Connected Intelligent System',
                    style: TextStyle(
                        color: Color(0xFFE6ECFF),
                        fontSize: 10,
                        fontWeight: FontWeight.w700)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(22),
            child: UcisCard(
              child: Column(
                children: [
                  const Text('Welcome',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          color: ucisInk)),
                  const SizedBox(height: 4),
                  const Text('Choose your account type to continue.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 11, color: ucisMuted)),
                  const SizedBox(height: 16),
                  FilledButton.icon(
                      onPressed: onStaffLogin,
                      icon: const Icon(Icons.badge_outlined),
                      label: const Text('Login as Staff')),
                  const SizedBox(height: 10),
                  FilledButton.icon(
                      onPressed: onAlumniLogin,
                      icon: const Icon(Icons.workspace_premium_outlined),
                      label: const Text('Login as Alumni')),
                  const SizedBox(height: 10),
                  OutlinedButton.icon(
                      onPressed: null,
                      icon: const Icon(Icons.school_outlined),
                      label: const Text('Login as Student')),
                  const SizedBox(height: 8),
                  const Text(
                      'Student access is disabled in this build. Staff and Alumni UI are available.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 10, color: ucisMuted)),
                  const SizedBox(height: 8),
                  OutlinedButton.icon(
                      onPressed: null,
                      icon: const Icon(Icons.admin_panel_settings_outlined),
                      label: const Text('Login as Admin')),
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
  const StaffLoginScreen({
    super.key,
    required this.onSignIn,
    this.onBack,
    this.onCancel,
  });

  final VoidCallback onSignIn;
  final VoidCallback? onBack;
  final VoidCallback? onCancel;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: ucisCanvas,
      child: Column(
        children: [
          UcisHeader(
              title: 'Staff Login',
              subtitle: 'Sign in with UDSM SSO',
              leading: 'U',
              onBack: onBack,
              actions: [Icons.arrow_back, Icons.close],
              onActionTap: (index) {
                if (index == 0) {
                  onBack?.call();
                } else if (index == 1) {
                  onCancel?.call();
                }
              }),
          Padding(
            padding: const EdgeInsets.all(18),
            child: UcisCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text('Staff account',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          color: ucisInk)),
                  const SizedBox(height: 12),
                  const TextField(
                      decoration:
                          InputDecoration(hintText: 'Staff email or ID')),
                  const SizedBox(height: 10),
                  const TextField(
                      decoration: InputDecoration(hintText: 'Password'),
                      obscureText: true),
                  const SizedBox(height: 8),
                  const Text(
                      'Secure staff access for teaching, student management, grading, events, and announcements.',
                      style: TextStyle(fontSize: 11, color: ucisMuted)),
                  const SizedBox(height: 12),
                  FilledButton(
                      onPressed: onSignIn, child: const Text('Continue')),
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
  const PhoneShell(
      {super.key,
      required this.selectedIndex,
      required this.onSelect,
      required this.child});

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
  const StaffHomeScreen(
      {super.key, required this.onOpenProfile, required this.onBackToLogin});

  final VoidCallback onOpenProfile;
  final VoidCallback onBackToLogin;

  @override
  Widget build(BuildContext context) {
    return AppScrollView(
      header: UcisHeader(
        title: 'Hello, Dr. James Kalolo',
        subtitle: 'Good morning. Your teaching workspace is ready.',
        leading: 'DJ',
        badge: '2',
        onBack: onBackToLogin,
        onProfileTap: onOpenProfile,
      ),
      children: [
        const PortalSearchBar(
            hint: 'Search courses, students, announcements...'),
        const SizedBox(height: 16),
        const UniversityHeroCard(
          tag: 'Staff Portal',
          title: 'Manage Academic Work',
          body:
              'Teaching, grading, supervision, and campus updates in one clean workspace.',
          action: 'Open LMS ->',
        ),
        const SizedBox(height: 18),
        const SectionHeading(title: 'Quick Actions', action: 'View All'),
        const SizedBox(height: 10),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 3,
          childAspectRatio: 1.55,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          children: [
            const QuickTile(
                icon: Icons.fact_check_outlined,
                title: 'Grading',
                subtitle: 'Marks'),
            const QuickTile(
                icon: Icons.map_outlined,
                title: 'Map',
                subtitle: 'Campus'),
            const QuickTile(
                icon: Icons.campaign_outlined,
                title: 'Updates',
                subtitle: 'Latest'),
            const QuickTile(
                icon: Icons.notifications_active_outlined,
                title: 'Alerts',
                subtitle: 'Urgent'),
            const QuickTile(
                icon: Icons.calendar_month_outlined,
                title: 'Calendar',
                subtitle: 'Events'),
            const QuickTile(
                icon: Icons.smart_toy_outlined,
                title: 'AI Help',
                subtitle: 'Ask'),
          ],
        ),
        const SizedBox(height: 18),
        const SectionHeading(title: 'Today\'s Tasks', action: 'View All'),
        const SizedBox(height: 10),
        const SectionCard(
          title: '',
          child: Column(
            children: [
              TaskItem(
                  title: 'Data Structures lecture',
                  status: '09:00 AM - Room B-204',
                  level: 'Normal'),
              SizedBox(height: 10),
              TaskItem(
                  title: 'Submit Semester I Grades',
                  status: 'Pending approval',
                  level: 'High'),
              SizedBox(height: 10),
              TaskItem(
                  title: 'Review FYP Proposals',
                  status: '3 submissions due today',
                  level: 'Medium'),
            ],
          ),
        ),
        const SizedBox(height: 18),
        const SectionHeading(title: 'Latest News', action: 'View All'),
        const SizedBox(height: 10),
        const Row(
          children: [
            Expanded(
                child: NewsMiniCard(
                    icon: Icons.school_outlined,
                    tag: 'ACADEMIC',
                    title: 'Exam timetable released',
                    date: 'May 12, 2026')),
            SizedBox(width: 10),
            Expanded(
                child: NewsMiniCard(
                    icon: Icons.groups_outlined,
                    tag: 'CAMPUS',
                    title: 'Research week briefing',
                    date: 'May 15, 2026')),
          ],
        ),
      ],
    );
  }
}

class StaffProfileScreen extends StatelessWidget {
  const StaffProfileScreen({super.key, required this.onLogout, this.onBack});

  final VoidCallback onLogout;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    return AppScrollView(
      header: UcisHeader(
          title: 'Profile',
          subtitle: 'Staff account details and security',
          leading: 'DJ',
          badge: '2',
          onBack: onBack),
      children: [
        const ProfileSummaryCard(
            name: 'Dr. James Kalolo',
            role: 'Lecturer - Computer Engineering and IT',
            initials: 'DJ'),
        const SizedBox(height: 12),
        const SectionCard(
          title: 'Account Details',
          child: Column(
            children: [
              StaffProfileRow(
                  icon: Icons.badge_outlined,
                  title: 'Staff ID',
                  value: 'UDSM-STAFF-2048'),
              SizedBox(height: 10),
              StaffProfileRow(
                  icon: Icons.email_outlined,
                  title: 'Email',
                  value: 'james.kalolo@udsm.ac.tz'),
              SizedBox(height: 10),
              StaffProfileRow(
                  icon: Icons.school_outlined,
                  title: 'College',
                  value: 'College of ICT'),
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
  const AnnouncementsScreen({super.key, this.onBack});

  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    return AppScrollView(
      header: UcisHeader(
          title: 'Announcements',
          subtitle: 'Staff alerts & academic updates',
          leading: 'U',
          badge: '1',
          onBack: onBack),
      children: const [
        TextField(
            decoration: InputDecoration(hintText: 'Search announcements...')),
        SizedBox(height: 10),
        FilterRow(
            labels: ['All', 'Academic', 'Events', 'Emergency', 'General']),
        SizedBox(height: 12),
        AnnouncementItem(
            title: 'Semester II Examination Timetable Released',
            tag: 'Academic',
            level: 'Urgent',
            time: '2 hours ago'),
        SizedBox(height: 10),
        AnnouncementItem(
            title: 'FYP proposal review deadline',
            tag: 'Staff',
            level: 'Medium',
            time: '5 hours ago'),
        SizedBox(height: 10),
        AnnouncementItem(
            title: 'Senate results submission window',
            tag: 'General',
            level: '',
            time: '1 day ago'),
      ],
    );
  }
}

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key, this.onBack});

  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    return AppScrollView(
      header: UcisHeader(
          title: 'Services',
          subtitle: 'Staff academic systems',
          leading: 'U',
          onBack: onBack),
      children: const [
        ServiceCard(
            title: 'ARIS',
            body:
                'Manage marks, class lists, course allocations, and academic records.',
            chips: ['Class Lists', 'Marks', 'Courses', 'Reports']),
        SizedBox(height: 12),
        ServiceCard(
            title: 'LMS',
            body:
                'Upload course materials, assignments, discussions, and online lecture resources.',
            chips: ['Courses', 'Assignments', 'Resources', 'Forums']),
        SizedBox(height: 12),
        ServiceCard(
            title: 'FYP Portal',
            body:
                'Review student submissions, supervisor comments, and project progress.',
            chips: ['Submissions', 'Supervision', 'Review']),
      ],
    );
  }
}

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key, this.onBack});

  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    return AppScrollView(
      header: UcisHeader(
          title: 'Calendar',
          subtitle: 'Academic calendar & events',
          leading: 'U',
          trailing: '>',
          onBack: onBack),
      children: const [
        SectionCard(
          title: 'March 2026',
          subtitle: 'Tap an item below for details',
          child: Column(
            children: [
              EventRow(
                  title: 'Faculty Meeting',
                  meta: 'Mar 5, 2026 - Nkrumah Hall',
                  tag: 'Academic'),
              EventRow(
                  title: 'UDSM Career Fair 2026',
                  meta: 'Mar 15, 2026 - Nkrumah Hall',
                  tag: 'Events'),
              EventRow(
                  title: 'Semester II Exams Start',
                  meta: 'Mar 20, 2026 - Campus wide',
                  tag: 'Academic'),
            ],
          ),
        ),
      ],
    );
  }
}

class AiAssistantScreen extends StatelessWidget {
  const AiAssistantScreen({super.key, this.onBack});

  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    return AppScrollView(
      header: UcisHeader(
          title: 'AI Assistant',
          subtitle: 'Online - Ready to help',
          leading: 'U',
          onBack: onBack),
      children: const [
        PromptChip(text: 'How do I submit semester grades?'),
        PromptChip(text: 'Show my assigned FYP reviews'),
        PromptChip(text: 'What classes do I teach today?'),
        PromptChip(text: 'How do I approve consultation slots?'),
        PromptChip(text: 'Where is the Health Center?'),
        PromptChip(text: 'FYP supervision guidelines?'),
        SizedBox(height: 16),
        TextField(
            minLines: 3,
            maxLines: 3,
            decoration: InputDecoration(hintText: '')),
        SizedBox(height: 10),
        TextField(decoration: InputDecoration(hintText: 'Type a message...')),
        SizedBox(height: 10),
        FilledButton(onPressed: null, child: Text('Send')),
      ],
    );
  }
}

class CampusMapScreen extends StatelessWidget {
  const CampusMapScreen({super.key, this.onBack});

  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    return AppScrollView(
      header: UcisHeader(
          title: 'Campus Map',
          subtitle: 'Find buildings, offices & facilities',
          leading: 'U',
          onBack: onBack),
      children: const [
        TextField(
            decoration: InputDecoration(
                hintText:
                    'Search locations... (e.g., CoICT, Library, Health Center)')),
        SizedBox(height: 12),
        MapPreview(),
        SizedBox(height: 10),
        FilterRow(labels: ['All', 'Academic', 'Hostel', 'Services']),
        SizedBox(height: 10),
        Text('Offices',
            style: TextStyle(
                fontSize: 12, fontWeight: FontWeight.w900, color: ucisInk)),
        LocationRow(
            title: 'College of ICT (CoICT)', meta: '1 Floors - Main Campus'),
        LocationRow(title: 'Main Library', meta: '3 Floors - Main Campus'),
        LocationRow(title: 'Health Center', meta: '1 Floor - Main Campus'),
        LocationRow(title: 'Nkrumah Hall', meta: '2 Floors - Main Campus'),
      ],
    );
  }
}

class UcisHeader extends StatelessWidget {
  const UcisHeader(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.leading,
      this.badge,
      this.trailing,
      this.onBack,
      this.onProfileTap,
      this.actions = const [],
      this.onActionTap});

  final String title;
  final String subtitle;
  final String leading;
  final String? badge;
  final String? trailing;
  final VoidCallback? onBack;
  final VoidCallback? onProfileTap;
  final List<IconData> actions;
  final ValueChanged<int>? onActionTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ucisCanvas,
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PortalTopBar(
              initials: trailing ?? leading,
              badge: badge,
              onBack: onBack,
              onProfileTap: onProfileTap),
          if (actions.isNotEmpty) ...[
            const SizedBox(height: 10),
            Row(children: [
              for (int i = 0; i < actions.length; i++) ...[
                HeaderIcon(
                  icon: actions[i],
                  onTap: () => onActionTap?.call(i),
                ),
                const SizedBox(width: 8)
              ]
            ]),
          ],
          const SizedBox(height: 18),
          Text(title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  color: ucisInk,
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  height: 1.05)),
          const SizedBox(height: 5),
          Text(subtitle,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  color: ucisMuted, fontSize: 13, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

class ProfileSummaryCard extends StatelessWidget {
  const ProfileSummaryCard(
      {super.key,
      required this.name,
      required this.role,
      required this.initials});

  final String name;
  final String role;
  final String initials;

  @override
  Widget build(BuildContext context) {
    return UcisCard(
      child: Row(
        children: [
          ProfileAvatar(initials: initials, radius: 34),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        color: ucisInk)),
                const SizedBox(height: 3),
                Text(role,
                    style: const TextStyle(
                        fontSize: 12,
                        color: ucisMuted,
                        fontWeight: FontWeight.w700)),
              ],
            ),
          ),
          const Icon(Icons.verified, color: ucisGreen, size: 21),
        ],
      ),
    );
  }
}

class AppScrollView extends StatelessWidget {
  const AppScrollView(
      {super.key, required this.header, required this.children});

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
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: children),
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
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: ucisLine),
        boxShadow: const [
          BoxShadow(
              color: Color(0x12000000), blurRadius: 12, offset: Offset(0, 6))
        ],
      ),
      child: child,
    );
  }
}

class SectionCard extends StatelessWidget {
  const SectionCard(
      {super.key,
      required this.title,
      required this.child,
      this.subtitle,
      this.trailing});

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
          if (title.isNotEmpty)
            Row(
              children: [
                Expanded(
                    child: Text(title,
                        textAlign: subtitle == null
                            ? TextAlign.start
                            : TextAlign.center,
                        style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w900,
                            color: ucisInk))),
                if (trailing != null) trailing!,
              ],
            ),
          if (subtitle != null)
            Text(subtitle!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 10,
                    color: ucisMuted,
                    fontWeight: FontWeight.w700)),
          if (title.isNotEmpty || subtitle != null) const SizedBox(height: 12),
          child,
        ],
      ),
    );
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
      decoration: BoxDecoration(
          color: (color ?? Colors.white)
              .withValues(alpha: color == null ? .16 : .95),
          borderRadius: BorderRadius.circular(12)),
      child: Text(label,
          style: const TextStyle(
              color: Colors.white, fontSize: 12, fontWeight: FontWeight.w900)),
    );
  }
}

class HeaderIcon extends StatelessWidget {
  const HeaderIcon({super.key, required this.icon, this.onTap});

  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 32,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: ucisLine)),
        child: Icon(icon, color: ucisInk, size: 17),
      ),
    );
  }
}

class QuickTile extends StatelessWidget {
  const QuickTile(
      {super.key,
      required this.icon,
      required this.title,
      required this.subtitle,
      this.onTap});

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: ucisLine),
            boxShadow: const [
              BoxShadow(
                  color: Color(0x08000000),
                  blurRadius: 10,
                  offset: Offset(0, 5))
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: _quickColor(title), size: 20),
            const SizedBox(height: 4),
            Text(title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontSize: 10, fontWeight: FontWeight.w900, color: ucisInk)),
            Text(subtitle,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontSize: 8, color: ucisMuted, height: 1.05)),
          ],
        ),
      ),
    );
  }

  Color _quickColor(String title) => switch (title) {
        'Grading' => ucisGold,
        'Students' => ucisGreen,
        'FYP' => ucisPink,
        'AI Help' => ucisSky,
        'Profile' => ucisMuted,
        _ => ucisBlue,
      };
}

class MiniAction extends StatelessWidget {
  const MiniAction(
      {super.key,
      required this.icon,
      required this.title,
      required this.subtitle,
      this.onTap});

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
              Text(title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w900,
                      color: ucisInk)),
              Text(subtitle,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 9, color: ucisMuted)),
            ],
          ),
        ),
      ),
    );
  }
}

class StaffProfileRow extends StatelessWidget {
  const StaffProfileRow(
      {super.key,
      required this.icon,
      required this.title,
      required this.value});

  final IconData icon;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          border: Border.all(color: ucisLine),
          borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          Icon(icon, color: ucisBlue, size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 10,
                        color: ucisMuted,
                        fontWeight: FontWeight.w800)),
                Text(value,
                    style: const TextStyle(
                        fontSize: 12,
                        color: ucisInk,
                        fontWeight: FontWeight.w900)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TaskItem extends StatelessWidget {
  const TaskItem(
      {super.key,
      required this.title,
      required this.status,
      required this.level});

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
        borderRadius: BorderRadius.circular(8),
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
                Text(title,
                    style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w900,
                        color: ucisInk)),
                Text(status,
                    style: const TextStyle(fontSize: 10, color: ucisMuted)),
              ],
            ),
          ),
          Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        ],
      ),
    );
  }
}

class AnnouncementItem extends StatelessWidget {
  const AnnouncementItem(
      {super.key,
      required this.title,
      required this.tag,
      required this.level,
      required this.time});

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
              Text(time,
                  style: const TextStyle(fontSize: 10, color: ucisMuted)),
            ],
          ),
          const SizedBox(height: 8),
          Text(title,
              style: const TextStyle(
                  fontSize: 14, fontWeight: FontWeight.w900, color: ucisInk)),
          const SizedBox(height: 4),
          const Text(
              'Official academic update for staff action, teaching coordination, and student guidance.',
              style: TextStyle(fontSize: 11, color: ucisMuted, height: 1.25)),
          const SizedBox(height: 8),
          const Text('Open >',
              style: TextStyle(
                  fontSize: 11, color: ucisBlue, fontWeight: FontWeight.w900)),
        ],
      ),
    );
  }
}

class ServiceCard extends StatelessWidget {
  const ServiceCard(
      {super.key,
      required this.title,
      required this.body,
      required this.chips});

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
            const CircleAvatar(
                radius: 16,
                backgroundColor: Color(0xFFF2F4F7),
                child: Icon(Icons.school_outlined, color: ucisBlue, size: 17)),
            const SizedBox(width: 10),
            Expanded(
                child: Text(title,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                        color: ucisInk))),
            const BadgePill(text: 'Connected', color: ucisGreen),
          ]),
          const SizedBox(height: 6),
          Text(body, style: const TextStyle(fontSize: 11, color: ucisMuted)),
          const SizedBox(height: 10),
          Wrap(spacing: 8, runSpacing: 8, children: [
            for (final chip in chips)
              BadgePill(text: chip, color: ucisMuted, pale: true)
          ]),
          const SizedBox(height: 10),
          OutlinedButton(onPressed: () {}, child: Text('Open $title >')),
        ],
      ),
    );
  }
}

class NewsMiniCard extends StatelessWidget {
  const NewsMiniCard(
      {super.key,
      required this.icon,
      required this.tag,
      required this.title,
      required this.date});

  final IconData icon;
  final String tag;
  final String title;
  final String date;

  @override
  Widget build(BuildContext context) {
    return UcisCard(
      child: SizedBox(
        height: 112,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                    color: ucisBlue.withValues(alpha: .1),
                    borderRadius: BorderRadius.circular(8)),
                child: Icon(icon, color: ucisBlue, size: 21),
              ),
              const Spacer(),
              const Icon(Icons.bookmark_border, color: ucisMuted, size: 18),
            ]),
            const SizedBox(height: 8),
            Text(tag,
                style: const TextStyle(
                    fontSize: 9, color: ucisBlue, fontWeight: FontWeight.w900)),
            Text(title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontSize: 12,
                    color: ucisInk,
                    fontWeight: FontWeight.w900,
                    height: 1.12)),
            const Spacer(),
            Text(date,
                style: const TextStyle(
                    fontSize: 10,
                    color: ucisMuted,
                    fontWeight: FontWeight.w700)),
          ],
        ),
      ),
    );
  }
}

class EventRow extends StatelessWidget {
  const EventRow(
      {super.key, required this.title, required this.meta, required this.tag});

  final String title;
  final String meta;
  final String tag;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            border: Border.all(color: ucisLine),
            borderRadius: BorderRadius.circular(14)),
        child: Row(
          children: [
            const Icon(Icons.calendar_month_outlined,
                color: ucisBlue, size: 18),
            const SizedBox(width: 10),
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Text(title,
                      style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w900,
                          color: ucisInk)),
                  Text(meta,
                      style: const TextStyle(fontSize: 10, color: ucisMuted))
                ])),
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
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(999),
              border: Border.all(color: ucisLine)),
          child: Text(text,
              style: const TextStyle(
                  fontSize: 11, fontWeight: FontWeight.w800, color: ucisInk)),
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
        gradient: const LinearGradient(
            colors: [Color(0xFFE9EFFB), Color(0xFFE8F6ED)]),
        border: Border.all(color: ucisLine),
      ),
      alignment: Alignment.bottomLeft,
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('UDSM Main Campus',
              style: TextStyle(
                  fontSize: 14, fontWeight: FontWeight.w900, color: ucisInk)),
          Text('Dar es Salaam, Tanzania',
              style: TextStyle(fontSize: 10, color: ucisMuted)),
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
                    children: [
                  Text(title,
                      style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w900,
                          color: ucisInk)),
                  Text(meta,
                      style: const TextStyle(fontSize: 10, color: ucisMuted))
                ])),
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
            BadgePill(
                text: labels[i],
                color: i == 0 ? ucisBlue : ucisMuted,
                pale: i != 0),
            const SizedBox(width: 8),
          ],
        ],
      ),
    );
  }
}

class BadgePill extends StatelessWidget {
  const BadgePill(
      {super.key, required this.text, required this.color, this.pale = false});

  final String text;
  final Color color;
  final bool pale;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: BoxDecoration(
          color: pale ? const Color(0xFFF2F4F7) : color.withValues(alpha: .14),
          borderRadius: BorderRadius.circular(999)),
      child: Text(text,
          style: TextStyle(
              color: pale ? ucisMuted : color,
              fontSize: 10,
              fontWeight: FontWeight.w900)),
    );
  }
}

class UcisBottomNav extends StatelessWidget {
  const UcisBottomNav(
      {super.key, required this.selectedIndex, required this.onSelect});

  final int selectedIndex;
  final ValueChanged<int> onSelect;

  static const _items = [
    (Icons.home_outlined, 'Home'),
    (Icons.campaign_outlined, 'Alerts'),
    (Icons.miscellaneous_services_outlined, 'Services'),
    (Icons.calendar_month_outlined, 'Calendar'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: ucisLine))),
      child: Row(
        children: [
          for (var i = 0; i < _items.length; i++)
            Expanded(
              child: InkWell(
                onTap: () => onSelect(i),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(_items[i].$1,
                        size: 18,
                        color: selectedIndex == i ? ucisBlue : ucisMuted),
                    const SizedBox(height: 3),
                    Text(_items[i].$2,
                        style: TextStyle(
                            fontSize: 9,
                            color: selectedIndex == i ? ucisBlue : ucisMuted,
                            fontWeight: FontWeight.w900)),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
