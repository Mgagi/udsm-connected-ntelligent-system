import 'package:flutter/material.dart';

import 'theme.dart';

const alumniHomePage = 100;
const alumniUpdatesPage = 101;
const alumniEventsPage = 102;
const alumniJobsPage = 103;
const alumniProfilePage = 104;
const alumniAnnouncementDetailPage = 105;
const alumniNewsDetailPage = 106;
const alumniEventDetailPage = 107;
const alumniSubscribedEventsPage = 108;
const alumniAlmanacPage = 109;
const alumniEmergencyPage = 110;
const alumniMapPage = 111;
const alumniPublicProfilePage = 112;
const alumniDirectoryPage = 113;
const alumniOtherProfilePage = 114;
const alumniJobDetailPage = 115;
const alumniSavedJobsPage = 116;
const alumniNetworkingPage = 117;
const alumniMentorshipPage = 118;
const alumniMentorFormPage = 119;
const alumniMentorshipConnectionsPage = 120;
const alumniMentorshipRequestPage = 121;
const alumniOrganizationsPage = 122;
const alumniFeedbackPage = 123;
const alumniFeedbackConfirmationPage = 124;
const alumniFeedbackHistoryPage = 125;
const alumniPreferencesPage = 126;
const alumniLoginAlertPage = 127;
const alumniSuspiciousPage = 128;
const alumniPolicyPage = 129;
const alumniEditProfilePage = 130;
const alumniOfflinePage = 131;
const alumniAssistantPage = 132;

class AlumniLoginScreen extends StatelessWidget {
  const AlumniLoginScreen(
      {super.key,
      required this.onSignIn,
      required this.onRegister,
      required this.onBack});

  final VoidCallback onSignIn;
  final VoidCallback onRegister;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: ucisCanvas,
      child: Column(
        children: [
          AlumniHeader(
              title: 'Alumni Login',
              subtitle: 'Sign in with UDSM SSO',
              initials: 'A',
              onBack: onBack),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(18),
              child: UcisPanel(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text('Welcome back to UDSM',
                        style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w900,
                            color: ucisInk)),
                    const SizedBox(height: 6),
                    const Text(
                        'Use your alumni SSO credentials to access real-time announcements, jobs, events, mentorship, campus services, and the alumni network.',
                        style: TextStyle(
                            fontSize: 12, color: ucisMuted, height: 1.3)),
                    const SizedBox(height: 14),
                    const TextField(
                        decoration: InputDecoration(
                            hintText: 'SSO email or student ID')),
                    const SizedBox(height: 10),
                    const TextField(
                        decoration: InputDecoration(hintText: 'Password'),
                        obscureText: true),
                    const SizedBox(height: 12),
                    FilledButton.icon(
                        onPressed: onSignIn,
                        icon: const Icon(Icons.login),
                        label: const Text('Continue')),
                    const SizedBox(height: 10),
                    OutlinedButton.icon(
                        onPressed: onRegister,
                        icon: const Icon(Icons.person_add_alt_1_outlined),
                        label: const Text('Register as Alumni')),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AlumniRegistrationScreen extends StatelessWidget {
  const AlumniRegistrationScreen(
      {super.key, required this.onSubmit, required this.onBack});

  final VoidCallback onSubmit;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return AlumniScroll(
      header: AlumniHeader(
          title: 'Alumni Registration',
          subtitle: 'Submit for admin approval',
          initials: 'AR',
          onBack: onBack),
      children: [
        const TextField(decoration: InputDecoration(hintText: 'Full name')),
        const SizedBox(height: 10),
        const TextField(
            decoration:
                InputDecoration(hintText: 'Student ID / matriculation number')),
        const SizedBox(height: 10),
        const Row(children: [
          Expanded(
              child: TextField(
                  decoration: InputDecoration(hintText: 'Graduation year'))),
          SizedBox(width: 10),
          Expanded(
              child: TextField(
                  decoration:
                      InputDecoration(hintText: 'Programme / department'))),
        ]),
        const SizedBox(height: 10),
        const TextField(
            decoration: InputDecoration(hintText: 'Current email address')),
        const SizedBox(height: 10),
        const TextField(
            decoration: InputDecoration(
                hintText: 'Current location / employer (optional)')),
        const SizedBox(height: 10),
        OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.photo_camera_outlined),
            label: const Text('Upload profile photo')),
        const SizedBox(height: 12),
        FilledButton(
            onPressed: onSubmit, child: const Text('Submit for approval')),
      ],
    );
  }
}

class AlumniStatusScreen extends StatelessWidget {
  const AlumniStatusScreen(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.icon,
      required this.action,
      required this.onAction});

  factory AlumniStatusScreen.pending({required VoidCallback onAction}) =>
      AlumniStatusScreen(
        title: 'Registration pending',
        subtitle:
            'Your alumni registration request has been sent to the Alumni Office. You will be notified after admin approval.',
        icon: Icons.hourglass_top_outlined,
        action: 'Preview approval confirmation',
        onAction: onAction,
      );

  factory AlumniStatusScreen.approved({required VoidCallback onAction}) =>
      AlumniStatusScreen(
        title: 'Account approved',
        subtitle:
            'Your alumni account is active. You can now sign in through UDSM SSO and access alumni services.',
        icon: Icons.verified_user_outlined,
        action: 'Return to alumni login',
        onAction: onAction,
      );

  final String title;
  final String subtitle;
  final IconData icon;
  final String action;
  final VoidCallback onAction;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: ucisCanvas,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: UcisPanel(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, size: 48, color: ucisBlue),
                const SizedBox(height: 12),
                Text(title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: ucisInk)),
                const SizedBox(height: 6),
                Text(subtitle,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 12, color: ucisMuted, height: 1.35)),
                const SizedBox(height: 14),
                FilledButton(onPressed: onAction, child: Text(action)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AlumniShell extends StatelessWidget {
  const AlumniShell(
      {super.key,
      required this.page,
      required this.onOpen,
      required this.onLogout,
      required this.onBackToLogin});

  final int page;
  final ValueChanged<int> onOpen;
  final VoidCallback onLogout;
  final VoidCallback onBackToLogin;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: _body),
        AlumniBottomNav(selectedIndex: _navIndex, onSelect: _selectTab),
      ],
    );
  }

  Widget get _body => switch (page) {
        alumniHomePage =>
          AlumniDashboard(onOpen: onOpen, onBackToLogin: onBackToLogin),
        alumniUpdatesPage => AlumniUpdatesScreen(onOpen: onOpen),
        alumniEventsPage => AlumniEventsScreen(onOpen: onOpen),
        alumniJobsPage => AlumniJobsScreen(onOpen: onOpen),
        alumniProfilePage =>
          AlumniProfileHub(onOpen: onOpen, onLogout: onLogout),
        alumniAnnouncementDetailPage => AlumniDetailScreen.announcement(
            onBack: () => onOpen(alumniUpdatesPage)),
        alumniNewsDetailPage =>
          AlumniDetailScreen.news(onBack: () => onOpen(alumniUpdatesPage)),
        alumniEventDetailPage => AlumniDetailScreen.event(
            onBack: () => onOpen(alumniEventsPage),
            onAskAi: () => onOpen(alumniAssistantPage)),
        alumniSubscribedEventsPage =>
          AlumniListScreen.subscribed(onBack: () => onOpen(alumniEventsPage)),
        alumniAlmanacPage =>
          AlumniListScreen.almanac(onBack: () => onOpen(alumniEventsPage)),
        alumniEmergencyPage => AlumniEmergencyScreen(
            onBack: () => onOpen(alumniHomePage),
            onAskAi: () => onOpen(alumniAssistantPage)),
        alumniMapPage => AlumniMapScreen(
            onBack: () => onOpen(alumniHomePage),
            onAskAi: () => onOpen(alumniAssistantPage)),
        alumniPublicProfilePage => AlumniPublicProfileScreen(
            onBack: () => onOpen(alumniProfilePage),
            onEdit: () => onOpen(alumniEditProfilePage)),
        alumniDirectoryPage => AlumniDirectoryScreen(
            onBack: () => onOpen(alumniProfilePage),
            onOpenProfile: () => onOpen(alumniOtherProfilePage)),
        alumniOtherProfilePage =>
          OtherAlumniProfileScreen(onBack: () => onOpen(alumniDirectoryPage)),
        alumniJobDetailPage =>
          AlumniJobDetailScreen(onBack: () => onOpen(alumniJobsPage)),
        alumniSavedJobsPage =>
          AlumniListScreen.savedJobs(onBack: () => onOpen(alumniJobsPage)),
        alumniNetworkingPage =>
          AlumniNetworkingScreen(onBack: () => onOpen(alumniProfilePage)),
        alumniMentorshipPage => AlumniMentorshipScreen(
            onBack: () => onOpen(alumniProfilePage), onOpen: onOpen),
        alumniMentorFormPage =>
          AlumniMentorFormScreen(onBack: () => onOpen(alumniMentorshipPage)),
        alumniMentorshipConnectionsPage => AlumniListScreen.mentorship(
            onBack: () => onOpen(alumniMentorshipPage)),
        alumniMentorshipRequestPage => AlumniMentorshipRequestScreen(
            onBack: () => onOpen(alumniMentorshipPage)),
        alumniOrganizationsPage =>
          AlumniOrganizationsScreen(onBack: () => onOpen(alumniProfilePage)),
        alumniFeedbackPage => AlumniFeedbackScreen(
            onBack: () => onOpen(alumniProfilePage),
            onSubmit: () => onOpen(alumniFeedbackConfirmationPage)),
        alumniFeedbackConfirmationPage => AlumniFeedbackConfirmationScreen(
            onOpenHistory: () => onOpen(alumniFeedbackHistoryPage)),
        alumniFeedbackHistoryPage =>
          AlumniListScreen.feedback(onBack: () => onOpen(alumniProfilePage)),
        alumniPreferencesPage =>
          AlumniPreferencesScreen(onBack: () => onOpen(alumniProfilePage)),
        alumniLoginAlertPage => AlumniNoticeScreen.loginAlert(
            onBack: () => onOpen(alumniProfilePage)),
        alumniSuspiciousPage => AlumniNoticeScreen.suspicious(
            onBack: () => onOpen(alumniProfilePage)),
        alumniPolicyPage =>
          AlumniNoticeScreen.policy(onBack: () => onOpen(alumniHomePage)),
        alumniEditProfilePage =>
          AlumniEditProfileScreen(onBack: () => onOpen(alumniProfilePage)),
        alumniOfflinePage =>
          AlumniNoticeScreen.offline(onBack: () => onOpen(alumniHomePage)),
        alumniAssistantPage =>
          AlumniAssistantScreen(onBack: () => onOpen(alumniHomePage)),
        _ => AlumniDashboard(onOpen: onOpen, onBackToLogin: onBackToLogin),
      };

  int get _navIndex => switch (page) {
        alumniHomePage ||
        alumniEmergencyPage ||
        alumniMapPage ||
        alumniPolicyPage ||
        alumniOfflinePage ||
        alumniAssistantPage =>
          0,
        alumniUpdatesPage ||
        alumniAnnouncementDetailPage ||
        alumniNewsDetailPage =>
          1,
        alumniEventsPage ||
        alumniEventDetailPage ||
        alumniSubscribedEventsPage ||
        alumniAlmanacPage =>
          2,
        alumniJobsPage || alumniJobDetailPage || alumniSavedJobsPage => 3,
        _ => -1,
      };

  void _selectTab(int index) => onOpen(switch (index) {
        0 => alumniHomePage,
        1 => alumniUpdatesPage,
        2 => alumniEventsPage,
        3 => alumniJobsPage,
        _ => alumniProfilePage,
      });
}

class AlumniDashboard extends StatelessWidget {
  const AlumniDashboard(
      {super.key, required this.onOpen, required this.onBackToLogin});

  final ValueChanged<int> onOpen;
  final VoidCallback onBackToLogin;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {},
      child: AlumniScroll(
        header: AlumniHeader(
            title: 'Hello, Asha',
            subtitle: 'Good morning. Stay connected with your university.',
            initials: 'AM',
            badge: '3',
            onBack: onBackToLogin,
            onProfileTap: () => onOpen(alumniProfilePage)),
        children: [
          const PortalSearchBar(
              hint: 'Search events, jobs, alumni, announcements...'),
          const SizedBox(height: 16),
          const UniversityHeroCard(
            tag: 'Alumni Portal',
            title: 'Welcome Back to UDSM',
            body:
                'Events, jobs, mentorship, news, and campus services for graduates.',
            action: 'Explore Now ->',
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
              DashboardTile(
                  icon: Icons.campaign_outlined,
                  title: 'Updates',
                  value: 'Latest',
                  onTap: () => onOpen(alumniUpdatesPage)),
              DashboardTile(
                  icon: Icons.event_available_outlined,
                  title: 'Events',
                  value: '3 new',
                  onTap: () => onOpen(alumniEventsPage)),
              DashboardTile(
                  icon: Icons.work_outline,
                  title: 'Jobs',
                  value: '12 posts',
                  onTap: () => onOpen(alumniJobsPage)),
              DashboardTile(
                  icon: Icons.volunteer_activism_outlined,
                  title: 'Mentor',
                  value: 'Request',
                  onTap: () => onOpen(alumniMentorshipPage)),
              DashboardTile(
                  icon: Icons.map_outlined,
                  title: 'Map',
                  value: 'Campus',
                  onTap: () => onOpen(alumniMapPage)),
              DashboardTile(
                  icon: Icons.smart_toy_outlined,
                  title: 'AI Help',
                  value: 'Ask',
                  onTap: () => onOpen(alumniAssistantPage)),
            ],
          ),
          const SizedBox(height: 18),
          const SectionHeading(
              title: 'Latest Announcements', action: 'View All'),
          const SizedBox(height: 10),
          SectionBlock(
            title: '',
            child: Column(children: [
              CompactFeedItem(
                  title: 'Alumni homecoming registration is open',
                  meta: 'Administration - Today',
                  tag: 'Alumni',
                  color: ucisBlue,
                  onTap: () => onOpen(alumniAnnouncementDetailPage)),
              CompactFeedItem(
                  title: 'DARUSO community service invitation',
                  meta: 'DARUSO - Yesterday',
                  tag: 'DARUSO',
                  color: ucisGold,
                  onTap: () => onOpen(alumniAnnouncementDetailPage)),
              CompactFeedItem(
                  title: 'Transcript service maintenance window',
                  meta: 'Academic Office - 2 days ago',
                  tag: 'Admin',
                  color: ucisGreen,
                  onTap: () => onOpen(alumniAnnouncementDetailPage)),
            ]),
          ),
          const SizedBox(height: 18),
          const SectionHeading(title: 'Latest News', action: 'View All'),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                  child: AlumniNewsMiniCard(
                      icon: Icons.article_outlined,
                      tag: 'OFFICIAL',
                      title: 'Innovation week opens applications',
                      date: 'May 2026',
                      onTap: () => onOpen(alumniNewsDetailPage))),
              const SizedBox(width: 10),
              Expanded(
                  child: AlumniNewsMiniCard(
                      icon: Icons.work_outline,
                      tag: 'CAREER',
                      title: 'Career fair registration opens',
                      date: 'May 30, 2026',
                      onTap: () => onOpen(alumniJobsPage))),
            ],
          ),
        ],
      ),
    );
  }
}

class AlumniUpdatesScreen extends StatelessWidget {
  const AlumniUpdatesScreen({super.key, required this.onOpen});

  final ValueChanged<int> onOpen;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {},
      child: AlumniScroll(
        header: const AlumniHeader(
            title: 'Announcements & News',
            subtitle: 'Newest active information first',
            initials: 'U'),
        children: [
          const TextField(
              decoration:
                  InputDecoration(hintText: 'Search announcements and news')),
          const SizedBox(height: 10),
          const FilterChips(labels: [
            'All',
            'Academic',
            'Administrative',
            'Alumni',
            'General'
          ]),
          const SizedBox(height: 12),
          SectionBlock(
            title: 'Administration announcements',
            child: Column(children: [
              CompactFeedItem(
                  title: 'Alumni homecoming registration is open',
                  meta: 'Alumni Office - Today',
                  tag: 'Administration',
                  color: ucisBlue,
                  onTap: () => onOpen(alumniAnnouncementDetailPage)),
              CompactFeedItem(
                  title: 'Transcript service maintenance window',
                  meta: 'Academic Office - 2 days ago',
                  tag: 'Academic',
                  color: ucisGreen,
                  onTap: () => onOpen(alumniAnnouncementDetailPage)),
            ]),
          ),
          const SizedBox(height: 12),
          SectionBlock(
            title: 'DARUSO announcements',
            child: CompactFeedItem(
                title: 'DARUSO community service invitation',
                meta: 'DARUSO - Yesterday',
                tag: 'DARUSO',
                color: ucisGold,
                onTap: () => onOpen(alumniAnnouncementDetailPage)),
          ),
          const SizedBox(height: 12),
          SectionBlock(
            title: 'News feed',
            child: Column(children: [
              CompactFeedItem(
                  title: 'UDSM innovation week opens applications',
                  meta: 'Official - May 2026',
                  tag: 'Official',
                  color: ucisBlue,
                  onTap: () => onOpen(alumniNewsDetailPage)),
              CompactFeedItem(
                  title: 'Sports alumni support new facilities',
                  meta: 'Sports - May 2026',
                  tag: 'Sports',
                  color: ucisGold,
                  onTap: () => onOpen(alumniNewsDetailPage)),
            ]),
          ),
        ],
      ),
    );
  }
}

class AlumniEventsScreen extends StatefulWidget {
  const AlumniEventsScreen({super.key, required this.onOpen});

  final ValueChanged<int> onOpen;

  @override
  State<AlumniEventsScreen> createState() => _AlumniEventsScreenState();
}

class _AlumniEventsScreenState extends State<AlumniEventsScreen> {
  bool calendar = false;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {},
      child: AlumniScroll(
        header: const AlumniHeader(
            title: 'Events & Almanac',
            subtitle: 'Alumni reunions, ceremonies, campus life',
            initials: 'E'),
        children: [
          SegmentedButton<bool>(
            segments: const [
              ButtonSegment(value: false, label: Text('List')),
              ButtonSegment(value: true, label: Text('Calendar'))
            ],
            selected: {calendar},
            onSelectionChanged: (value) =>
                setState(() => calendar = value.first),
          ),
          const SizedBox(height: 10),
          const FilterChips(labels: [
            'All',
            'Alumni',
            'Academic',
            'Social',
            'Sports',
            'Ceremony'
          ]),
          const SizedBox(height: 12),
          if (calendar)
            const CalendarPreview()
          else ...[
            CompactFeedItem(
                title: 'Alumni Networking Night',
                meta: 'May 22, 2026 - Nkrumah Hall',
                tag: 'Alumni',
                color: ucisGold,
                onTap: () => widget.onOpen(alumniEventDetailPage)),
            CompactFeedItem(
                title: 'UDSM Career Fair',
                meta: 'May 30, 2026 - Library Lawns',
                tag: 'Career',
                color: ucisBlue,
                onTap: () => widget.onOpen(alumniEventDetailPage)),
            CompactFeedItem(
                title: 'Graduation Ceremony',
                meta: 'June 12, 2026 - Convocation Grounds',
                tag: 'Ceremony',
                color: ucisGreen,
                onTap: () => widget.onOpen(alumniEventDetailPage)),
          ],
          const SizedBox(height: 12),
          Row(children: [
            Expanded(
                child: OutlinedButton.icon(
                    onPressed: () => widget.onOpen(alumniSubscribedEventsPage),
                    icon: const Icon(Icons.notifications_active_outlined),
                    label: const Text('My Events'))),
            const SizedBox(width: 10),
            Expanded(
                child: OutlinedButton.icon(
                    onPressed: () => widget.onOpen(alumniAlmanacPage),
                    icon: const Icon(Icons.calendar_month_outlined),
                    label: const Text('Almanac'))),
          ]),
        ],
      ),
    );
  }
}

class AlumniJobsScreen extends StatelessWidget {
  const AlumniJobsScreen({super.key, required this.onOpen});

  final ValueChanged<int> onOpen;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {},
      child: AlumniScroll(
        header: const AlumniHeader(
            title: 'Job Board',
            subtitle: 'Admin-posted opportunities for alumni',
            initials: 'J'),
        children: [
          const TextField(
              decoration:
                  InputDecoration(hintText: 'Search jobs by title or keyword')),
          const SizedBox(height: 10),
          const FilterChips(labels: [
            'All',
            'ICT',
            'Full-time',
            'Contract',
            'Internship',
            'Dar es Salaam'
          ]),
          const SizedBox(height: 12),
          JobPost(
              title: 'Data Analyst',
              company: 'CRDB Bank',
              location: 'Dar es Salaam',
              deadline: 'May 28',
              onTap: () => onOpen(alumniJobDetailPage)),
          JobPost(
              title: 'Software Engineer',
              company: 'UDSM ICT Directorate',
              location: 'Hybrid',
              deadline: 'June 4',
              onTap: () => onOpen(alumniJobDetailPage)),
          JobPost(
              title: 'Project Officer',
              company: 'UNDP Tanzania',
              location: 'Dodoma',
              deadline: 'June 10',
              onTap: () => onOpen(alumniJobDetailPage)),
          const SizedBox(height: 8),
          OutlinedButton.icon(
              onPressed: () => onOpen(alumniSavedJobsPage),
              icon: const Icon(Icons.bookmark_border),
              label: const Text('Saved jobs')),
        ],
      ),
    );
  }
}

class AlumniProfileHub extends StatelessWidget {
  const AlumniProfileHub(
      {super.key, required this.onOpen, required this.onLogout});

  final ValueChanged<int> onOpen;
  final VoidCallback onLogout;

  @override
  Widget build(BuildContext context) {
    return AlumniScroll(
      header: const AlumniHeader(
          title: 'Profile',
          subtitle: 'Active alumni account and preferences',
          initials: 'AM',
          badge: '3'),
      children: [
        const AlumniProfileSummaryCard(),
        const SizedBox(height: 12),
        SectionBlock(
          title: 'Profile Tools',
          child: Wrap(spacing: 9, runSpacing: 9, children: [
            ActionPill(
                icon: Icons.badge_outlined,
                label: 'Public profile',
                onTap: () => onOpen(alumniPublicProfilePage)),
            ActionPill(
                icon: Icons.edit_outlined,
                label: 'Edit profile',
                onTap: () => onOpen(alumniEditProfilePage)),
            ActionPill(
                icon: Icons.notifications_outlined,
                label: 'Preferences',
                onTap: () => onOpen(alumniPreferencesPage)),
            ActionPill(
                icon: Icons.policy_outlined,
                label: 'Policy notice',
                onTap: () => onOpen(alumniPolicyPage)),
          ]),
        ),
        const SizedBox(height: 12),
        SectionBlock(
          title: 'Alumni services',
          child: Column(children: [
            MenuAction(
                icon: Icons.people_alt_outlined,
                title: 'Alumni directory / network',
                onTap: () => onOpen(alumniDirectoryPage)),
            MenuAction(
                icon: Icons.hub_outlined,
                title: 'Networking hub and messages',
                onTap: () => onOpen(alumniNetworkingPage)),
            MenuAction(
                icon: Icons.volunteer_activism_outlined,
                title: 'Mentorship',
                onTap: () => onOpen(alumniMentorshipPage)),
            MenuAction(
                icon: Icons.groups_2_outlined,
                title: 'Student organizations',
                onTap: () => onOpen(alumniOrganizationsPage)),
            MenuAction(
                icon: Icons.feedback_outlined,
                title: 'Feedback submission',
                onTap: () => onOpen(alumniFeedbackPage)),
          ]),
        ),
        const SizedBox(height: 12),
        SectionBlock(
          title: 'Security',
          child: Column(children: [
            MenuAction(
                icon: Icons.login_outlined,
                title: 'Login alert: new device',
                onTap: () => onOpen(alumniLoginAlertPage)),
            MenuAction(
                icon: Icons.warning_amber_outlined,
                title: 'Suspicious activity warning',
                onTap: () => onOpen(alumniSuspiciousPage)),
          ]),
        ),
        const SizedBox(height: 12),
        FilledButton.icon(
            onPressed: onLogout,
            icon: const Icon(Icons.logout),
            label: const Text('Logout')),
      ],
    );
  }
}

class AlumniDetailScreen extends StatelessWidget {
  const AlumniDetailScreen(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.body,
      required this.onBack,
      this.onAskAi,
      this.action});

  factory AlumniDetailScreen.announcement({required VoidCallback onBack}) =>
      AlumniDetailScreen(
        title: 'Alumni homecoming registration is open',
        subtitle: 'Administration - Posted May 7, 2026',
        body:
            'The Alumni Office invites graduates to register for the 2026 homecoming. Attachments include the programme schedule and participation guide. Expired announcements are hidden automatically from feeds.',
        onBack: onBack,
        action: 'Download attachment',
      );

  factory AlumniDetailScreen.news({required VoidCallback onBack}) =>
      AlumniDetailScreen(
        title: 'UDSM innovation week opens applications',
        subtitle: 'Official News - May 2026',
        body:
            'Applications are open for graduate founders and researchers. This news article supports embedded images, related articles, search retrieval, and sharing.',
        onBack: onBack,
        action: 'Share article',
      );

  factory AlumniDetailScreen.event(
          {required VoidCallback onBack, required VoidCallback onAskAi}) =>
      AlumniDetailScreen(
        title: 'Alumni Networking Night',
        subtitle: 'May 22, 2026 - Nkrumah Hall',
        body:
            'Reconnect with classmates, meet current students, and explore mentorship opportunities. The location links to campus navigation and subscribers receive reminders.',
        onBack: onBack,
        onAskAi: onAskAi,
        action: 'RSVP / Subscribe',
      );

  final String title;
  final String subtitle;
  final String body;
  final VoidCallback onBack;
  final VoidCallback? onAskAi;
  final String? action;

  @override
  Widget build(BuildContext context) {
    return AlumniScroll(
      header: AlumniHeader(
          title: title, subtitle: subtitle, initials: 'D', onBack: onBack),
      children: [
        UcisPanel(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            BadgePill(text: subtitle.split(' - ').first, color: ucisBlue),
            const SizedBox(height: 12),
            Container(
                height: 120,
                decoration: BoxDecoration(
                    color: const Color(0xFFEAF0FF),
                    borderRadius: BorderRadius.circular(8)),
                alignment: Alignment.center,
                child: const Icon(Icons.image_outlined,
                    size: 42, color: ucisBlue)),
            const SizedBox(height: 12),
            Text(body,
                style: const TextStyle(
                    fontSize: 12, color: ucisMuted, height: 1.35)),
            const SizedBox(height: 12),
            if (action != null)
              FilledButton(onPressed: () {}, child: Text(action!)),
            if (onAskAi != null) ...[
              const SizedBox(height: 8),
              OutlinedButton.icon(
                  onPressed: onAskAi,
                  icon: const Icon(Icons.smart_toy_outlined),
                  label: const Text('Ask AI about this event')),
            ],
          ]),
        ),
      ],
    );
  }
}

class AlumniEmergencyScreen extends StatelessWidget {
  const AlumniEmergencyScreen(
      {super.key, required this.onBack, required this.onAskAi});

  final VoidCallback onBack;
  final VoidCallback onAskAi;

  @override
  Widget build(BuildContext context) {
    return AlumniScroll(
      header: AlumniHeader(
          title: 'Emergency contacts',
          subtitle: 'View and quick-call campus services',
          initials: '!',
          onBack: onBack),
      children: [
        const EmergencyContact(
            role: 'Campus Security',
            phone: '+255 22 241 0500',
            hours: '24 hours'),
        const EmergencyContact(
            role: 'Medical Centre',
            phone: '+255 22 241 0703',
            hours: '24 hours'),
        const EmergencyContact(
            role: 'Fire & Rescue', phone: '114', hours: '24 hours'),
        const EmergencyContact(
            role: 'Alumni Office',
            phone: '+255 22 241 0032',
            hours: 'Mon-Fri 08:00-16:00'),
        const SizedBox(height: 10),
        FilledButton.icon(
            onPressed: onAskAi,
            icon: const Icon(Icons.smart_toy_outlined),
            label: const Text('Get help from AI')),
      ],
    );
  }
}

class AlumniMapScreen extends StatelessWidget {
  const AlumniMapScreen(
      {super.key, required this.onBack, required this.onAskAi});

  final VoidCallback onBack;
  final VoidCallback onAskAi;

  @override
  Widget build(BuildContext context) {
    return AlumniScroll(
      header: AlumniHeader(
          title: 'Campus map',
          subtitle: 'Search, filter, pan, zoom, and navigate',
          initials: 'M',
          onBack: onBack),
      children: [
        const TextField(
            decoration: InputDecoration(hintText: 'Search locations')),
        const SizedBox(height: 10),
        const FilterChips(labels: [
          'All',
          'Academic',
          'Administrative',
          'Accommodation',
          'Services'
        ]),
        const SizedBox(height: 12),
        Container(
          height: 230,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              gradient: const LinearGradient(
                  colors: [Color(0xFFE8F1FF), Color(0xFFFFF4D6)]),
              border: Border.all(color: ucisLine)),
          child: const Stack(children: [
            Positioned(left: 20, top: 35, child: MapPin(label: 'Library')),
            Positioned(right: 30, top: 70, child: MapPin(label: 'CoICT')),
            Positioned(left: 84, bottom: 45, child: MapPin(label: 'Health')),
            Align(
                alignment: Alignment.bottomLeft,
                child: Text('UDSM Main Campus - live map preview',
                    style: TextStyle(
                        fontWeight: FontWeight.w900, color: ucisInk))),
          ]),
        ),
        const SizedBox(height: 10),
        Row(children: [
          Expanded(
              child: FilledButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.directions_walk),
                  label: const Text('Get directions'))),
          const SizedBox(width: 10),
          Expanded(
              child: OutlinedButton.icon(
                  onPressed: onAskAi,
                  icon: const Icon(Icons.smart_toy_outlined),
                  label: const Text('Ask AI'))),
        ]),
      ],
    );
  }
}

class AlumniPublicProfileScreen extends StatelessWidget {
  const AlumniPublicProfileScreen(
      {super.key, required this.onBack, required this.onEdit});

  final VoidCallback onBack;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    return AlumniScroll(
      header: AlumniHeader(
          title: 'My alumni profile',
          subtitle: 'Public-facing profile card',
          initials: 'AM',
          onBack: onBack),
      children: [
        UcisPanel(
          child: Column(children: [
            const CircleAvatar(
                radius: 34,
                backgroundColor: ucisBlue,
                child: Text('AM',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w900))),
            const SizedBox(height: 10),
            const Text('Asha Mwakalinga',
                style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.w900, color: ucisInk)),
            const Text('BSc Computer Science, 2019',
                style: TextStyle(fontSize: 11, color: ucisMuted)),
            const SizedBox(height: 10),
            const Text(
                'Product manager building inclusive financial technology. Open to mentoring final-year students and early alumni.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, color: ucisMuted, height: 1.3)),
            const SizedBox(height: 12),
            FilledButton.icon(
                onPressed: onEdit,
                icon: const Icon(Icons.edit_outlined),
                label: const Text('Edit profile')),
          ]),
        ),
      ],
    );
  }
}

class AlumniDirectoryScreen extends StatelessWidget {
  const AlumniDirectoryScreen(
      {super.key, required this.onBack, required this.onOpenProfile});

  final VoidCallback onBack;
  final VoidCallback onOpenProfile;

  @override
  Widget build(BuildContext context) {
    return AlumniScroll(
      header: AlumniHeader(
          title: 'Alumni directory',
          subtitle: 'Browse, filter, connect, and message',
          initials: 'N',
          onBack: onBack),
      children: [
        const TextField(
            decoration: InputDecoration(
                hintText: 'Search alumni by name, year, programme')),
        const SizedBox(height: 10),
        const FilterChips(
            labels: ['All', '2019', 'ICT', 'Finance', 'Dar es Salaam']),
        const SizedBox(height: 12),
        AlumniPerson(
            name: 'Neema John',
            role: 'Cybersecurity Analyst - 2018',
            onTap: onOpenProfile),
        AlumniPerson(
            name: 'Baraka Mushi',
            role: 'Civil Engineer - 2015',
            onTap: onOpenProfile),
        AlumniPerson(
            name: 'Rehema Said',
            role: 'Public Health Specialist - 2020',
            onTap: onOpenProfile),
      ],
    );
  }
}

class OtherAlumniProfileScreen extends StatelessWidget {
  const OtherAlumniProfileScreen({super.key, required this.onBack});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return AlumniScroll(
      header: AlumniHeader(
          title: 'Neema John',
          subtitle: 'Cybersecurity Analyst - Class of 2018',
          initials: 'NJ',
          onBack: onBack),
      children: [
        const SectionBlock(
            title: 'Public profile',
            child: Text(
                'BSc Telecommunications Engineering. Based in Dar es Salaam. Interested in cybersecurity mentorship and women in technology communities.',
                style: TextStyle(fontSize: 12, color: ucisMuted, height: 1.3))),
        const SizedBox(height: 10),
        Row(children: [
          Expanded(
              child: FilledButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.person_add_alt),
                  label: const Text('Connect'))),
          const SizedBox(width: 10),
          Expanded(
              child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.chat_bubble_outline),
                  label: const Text('Message'))),
        ]),
      ],
    );
  }
}

class AlumniJobDetailScreen extends StatelessWidget {
  const AlumniJobDetailScreen({super.key, required this.onBack});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return AlumniScroll(
      header: AlumniHeader(
          title: 'Data Analyst',
          subtitle: 'CRDB Bank - Dar es Salaam',
          initials: 'J',
          onBack: onBack),
      children: [
        const SectionBlock(
          title: 'Job description',
          subtitle: 'Deadline: May 28, 2026',
          child: Text(
              'Analyze customer and digital banking data, prepare dashboards, and support product decisions. Application links and employer contacts are maintained by administrators.',
              style: TextStyle(fontSize: 12, color: ucisMuted, height: 1.35)),
        ),
        const SizedBox(height: 10),
        Row(children: [
          Expanded(
              child: FilledButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.open_in_new),
                  label: const Text('Apply / Visit link'))),
          const SizedBox(width: 10),
          Expanded(
              child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.bookmark_border),
                  label: const Text('Save job'))),
        ]),
      ],
    );
  }
}

class AlumniNetworkingScreen extends StatelessWidget {
  const AlumniNetworkingScreen({super.key, required this.onBack});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return AlumniScroll(
      header: AlumniHeader(
          title: 'Networking hub',
          subtitle: 'Connections, groups, and messages',
          initials: 'C',
          onBack: onBack),
      children: const [
        SectionBlock(
            title: 'Pending and accepted connections',
            child: Column(children: [
              ConnectionRow(name: 'Rehema Said', status: 'Pending'),
              ConnectionRow(name: 'Baraka Mushi', status: 'Accepted')
            ])),
        SizedBox(height: 12),
        SectionBlock(
            title: 'Groups / communities',
            child: Column(children: [
              ConnectionRow(name: 'Class of 2019', status: '124 members'),
              ConnectionRow(name: 'CoICT Alumni', status: '842 members'),
              ConnectionRow(name: 'Founders Circle', status: '56 members')
            ])),
        SizedBox(height: 12),
        SectionBlock(
            title: 'Message thread',
            child: Text(
                'Neema: Karibu to the cybersecurity alumni group. Let us know what topics you want covered next month.',
                style: TextStyle(fontSize: 12, color: ucisMuted))),
      ],
    );
  }
}

class AlumniMentorshipScreen extends StatelessWidget {
  const AlumniMentorshipScreen(
      {super.key, required this.onBack, required this.onOpen});

  final VoidCallback onBack;
  final ValueChanged<int> onOpen;

  @override
  Widget build(BuildContext context) {
    return AlumniScroll(
      header: AlumniHeader(
          title: 'Mentorship',
          subtitle: 'Mentor students or seek guidance',
          initials: 'M',
          onBack: onBack),
      children: [
        Row(children: [
          Expanded(
              child: DashboardTile(
                  icon: Icons.volunteer_activism_outlined,
                  title: 'Become a mentor',
                  value: 'Create profile',
                  onTap: () => onOpen(alumniMentorFormPage))),
          const SizedBox(width: 10),
          Expanded(
              child: DashboardTile(
                  icon: Icons.manage_accounts_outlined,
                  title: 'Connections',
                  value: '3 active',
                  onTap: () => onOpen(alumniMentorshipConnectionsPage))),
        ]),
        const SizedBox(height: 12),
        SectionBlock(
          title: 'Requests',
          child: Column(children: [
            MenuAction(
                icon: Icons.inbox_outlined,
                title: 'Review student request from Grace Paul',
                onTap: () => onOpen(alumniMentorshipRequestPage)),
            MenuAction(
                icon: Icons.search_outlined,
                title: 'Browse senior alumni mentors',
                onTap: () {}),
          ]),
        ),
      ],
    );
  }
}

class AlumniMentorFormScreen extends StatelessWidget {
  const AlumniMentorFormScreen({super.key, required this.onBack});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return AlumniScroll(
      header: AlumniHeader(
          title: 'Become a mentor',
          subtitle: 'Submit mentor profile',
          initials: 'B',
          onBack: onBack),
      children: const [
        FilterChips(labels: ['Academic', 'Career', 'Personal Development']),
        SizedBox(height: 10),
        TextField(decoration: InputDecoration(hintText: 'Areas of expertise')),
        SizedBox(height: 10),
        TextField(decoration: InputDecoration(hintText: 'Availability')),
        SizedBox(height: 10),
        TextField(
            minLines: 3,
            maxLines: 4,
            decoration: InputDecoration(hintText: 'Mentor profile summary')),
        SizedBox(height: 12),
        FilledButton(onPressed: null, child: Text('Submit mentor profile')),
      ],
    );
  }
}

class AlumniMentorshipRequestScreen extends StatelessWidget {
  const AlumniMentorshipRequestScreen({super.key, required this.onBack});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return AlumniScroll(
      header: AlumniHeader(
          title: 'Mentorship request',
          subtitle: 'Review before accepting',
          initials: 'R',
          onBack: onBack),
      children: [
        const SectionBlock(
            title: 'Grace Paul',
            subtitle: 'Final-year student - Computer Science',
            child: Text(
                'Grace is requesting monthly career mentorship focused on product management interviews and final-year project presentation preparation.',
                style: TextStyle(fontSize: 12, color: ucisMuted, height: 1.3))),
        const SizedBox(height: 12),
        Row(children: [
          Expanded(
              child:
                  FilledButton(onPressed: () {}, child: const Text('Accept'))),
          const SizedBox(width: 10),
          Expanded(
              child: OutlinedButton(
                  onPressed: () {}, child: const Text('Decline'))),
        ]),
      ],
    );
  }
}

class AlumniOrganizationsScreen extends StatelessWidget {
  const AlumniOrganizationsScreen({super.key, required this.onBack});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return AlumniScroll(
      header: AlumniHeader(
          title: 'Student organizations',
          subtitle: 'Campus life and historical links',
          initials: 'O',
          onBack: onBack),
      children: const [
        CompactFeedItem(
            title: 'UDSM ICT Students Association',
            meta: 'Technology - Lead: Judith Elias',
            tag: 'Former member',
            color: ucisBlue),
        CompactFeedItem(
            title: 'Entrepreneurship Club',
            meta: 'Business - Lead: Paulo Henry',
            tag: 'Events',
            color: ucisGold),
        CompactFeedItem(
            title: 'Debate Society',
            meta: 'Leadership - Lead: Halima Rashid',
            tag: 'Open',
            color: ucisGreen),
      ],
    );
  }
}

class AlumniAssistantScreen extends StatelessWidget {
  const AlumniAssistantScreen({super.key, required this.onBack});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return AlumniScroll(
      header: AlumniHeader(
          title: 'AI Assistant',
          subtitle: 'Navigation, events, emergencies, announcements',
          initials: 'AI',
          onBack: onBack),
      children: const [
        ChatBubble(
            text:
                'Hello Asha. I can help with campus directions, emergency contacts, events, job deadlines, mentorship actions, and recent announcements.'),
        Wrap(spacing: 8, runSpacing: 8, children: [
          BadgePill(text: 'Find a location', color: ucisBlue),
          BadgePill(text: 'Show upcoming events', color: ucisGold),
          BadgePill(text: 'Emergency contacts', color: ucisRed),
          BadgePill(text: 'Latest announcements', color: ucisGreen),
        ]),
        SizedBox(height: 12),
        TextField(
            minLines: 4,
            maxLines: 5,
            decoration: InputDecoration(hintText: 'Ask UCIS AI...')),
        SizedBox(height: 10),
        FilledButton(onPressed: null, child: Text('Send')),
      ],
    );
  }
}

class AlumniFeedbackScreen extends StatelessWidget {
  const AlumniFeedbackScreen(
      {super.key, required this.onBack, required this.onSubmit});

  final VoidCallback onBack;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return AlumniScroll(
      header: AlumniHeader(
          title: 'Feedback',
          subtitle: 'Help improve UCIS',
          initials: 'F',
          onBack: onBack),
      children: [
        const FilterChips(
            labels: ['Bug Report', 'Suggestion', 'Complaint', 'Compliment']),
        const SizedBox(height: 10),
        const TextField(
            minLines: 5,
            maxLines: 6,
            decoration: InputDecoration(hintText: 'Describe your feedback')),
        const SizedBox(height: 10),
        OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.attach_file),
            label: const Text('Attach screenshot')),
        const SizedBox(height: 6),
        SwitchListTile(
            value: false,
            onChanged: (_) {},
            title: const Text('Submit anonymously')),
        const SizedBox(height: 10),
        FilledButton(onPressed: onSubmit, child: const Text('Submit feedback')),
      ],
    );
  }
}

class AlumniFeedbackConfirmationScreen extends StatelessWidget {
  const AlumniFeedbackConfirmationScreen(
      {super.key, required this.onOpenHistory});

  final VoidCallback onOpenHistory;

  @override
  Widget build(BuildContext context) {
    return AlumniStatusScreen(
        title: 'Feedback received',
        subtitle:
            'Thank you. Your message has been logged and routed to the responsible office.',
        icon: Icons.mark_email_read_outlined,
        action: 'View feedback history',
        onAction: onOpenHistory);
  }
}

class AlumniPreferencesScreen extends StatelessWidget {
  const AlumniPreferencesScreen({super.key, required this.onBack});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    const prefs = [
      'Announcements',
      'Events',
      'Jobs',
      'Mentorship requests',
      'News',
      'Alumni event notifications'
    ];
    return AlumniScroll(
      header: AlumniHeader(
          title: 'Notification preferences',
          subtitle: 'Choose real-time alerts',
          initials: 'P',
          onBack: onBack),
      children: [
        for (final pref in prefs)
          SwitchListTile(
              value: true,
              onChanged: (_) {},
              title: Text(pref),
              subtitle: const Text('Push notification enabled')),
      ],
    );
  }
}

class AlumniEditProfileScreen extends StatelessWidget {
  const AlumniEditProfileScreen({super.key, required this.onBack});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return AlumniScroll(
      header: AlumniHeader(
          title: 'Edit profile',
          subtitle: 'Personal details and social links',
          initials: 'E',
          onBack: onBack),
      children: const [
        TextField(decoration: InputDecoration(hintText: 'Full name')),
        SizedBox(height: 10),
        TextField(decoration: InputDecoration(hintText: 'Bio')),
        SizedBox(height: 10),
        TextField(decoration: InputDecoration(hintText: 'Current job title')),
        SizedBox(height: 10),
        TextField(decoration: InputDecoration(hintText: 'Employer')),
        SizedBox(height: 10),
        TextField(decoration: InputDecoration(hintText: 'Location')),
        SizedBox(height: 10),
        TextField(decoration: InputDecoration(hintText: 'Contact email')),
        SizedBox(height: 10),
        TextField(decoration: InputDecoration(hintText: 'LinkedIn profile')),
        SizedBox(height: 12),
        NoticeLine(
            icon: Icons.verified_user_outlined, text: 'Account status: Active'),
        SizedBox(height: 12),
        FilledButton(onPressed: null, child: Text('Save changes')),
      ],
    );
  }
}

class AlumniNoticeScreen extends StatelessWidget {
  const AlumniNoticeScreen(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.icon,
      required this.color,
      required this.onBack});

  factory AlumniNoticeScreen.loginAlert({required VoidCallback onBack}) =>
      AlumniNoticeScreen(
          title: 'New login alert',
          subtitle:
              'A login was detected from Android, Dar es Salaam, on May 7, 2026 at 09:42. If this was not you, change your password and contact support.',
          icon: Icons.login_outlined,
          color: ucisBlue,
          onBack: onBack);
  factory AlumniNoticeScreen.suspicious({required VoidCallback onBack}) =>
      AlumniNoticeScreen(
          title: 'Suspicious activity',
          subtitle:
              'Multiple failed sign-in attempts were detected. UCIS has temporarily increased verification checks for your account.',
          icon: Icons.warning_amber_outlined,
          color: ucisRed,
          onBack: onBack);
  factory AlumniNoticeScreen.policy({required VoidCallback onBack}) =>
      AlumniNoticeScreen(
          title: 'Policy update',
          subtitle:
              'UDSM has updated data protection and alumni communication policies. Please review the notice before continuing to sensitive services.',
          icon: Icons.policy_outlined,
          color: ucisGold,
          onBack: onBack);
  factory AlumniNoticeScreen.offline({required VoidCallback onBack}) =>
      AlumniNoticeScreen(
          title: 'Offline mode',
          subtitle:
              'You are offline. UCIS is showing cached alumni content so feeds never load as a blank screen.',
          icon: Icons.cloud_off_outlined,
          color: ucisMuted,
          onBack: onBack);

  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return AlumniScroll(
      header: AlumniHeader(
          title: title,
          subtitle: 'Security and compliance',
          initials: 'S',
          onBack: onBack),
      children: [
        UcisPanel(
          child: Column(children: [
            Icon(icon, size: 46, color: color),
            const SizedBox(height: 10),
            Text(subtitle,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 12, color: ucisMuted, height: 1.35)),
            const SizedBox(height: 12),
            FilledButton(onPressed: onBack, child: const Text('Done')),
          ]),
        ),
      ],
    );
  }
}

class AlumniListScreen extends StatelessWidget {
  const AlumniListScreen(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.items,
      required this.onBack});

  factory AlumniListScreen.subscribed({required VoidCallback onBack}) =>
      AlumniListScreen(
          title: 'My subscribed events',
          subtitle: 'Upcoming reminders',
          items: const [
            'Alumni Networking Night - reminder tomorrow',
            'UDSM Career Fair - reminder in 3 days'
          ],
          onBack: onBack);
  factory AlumniListScreen.almanac({required VoidCallback onBack}) =>
      AlumniListScreen(
          title: 'University almanac',
          subtitle: 'Read-only academic calendar',
          items: const [
            'Semester registration closes - May 16',
            'Examinations begin - June 1',
            'Graduation ceremony - June 12'
          ],
          onBack: onBack);
  factory AlumniListScreen.savedJobs({required VoidCallback onBack}) =>
      AlumniListScreen(
          title: 'Saved jobs',
          subtitle: 'Bookmarked opportunities',
          items: const [
            'Data Analyst - CRDB Bank',
            'Software Engineer - UDSM ICT Directorate'
          ],
          onBack: onBack);
  factory AlumniListScreen.mentorship({required VoidCallback onBack}) =>
      AlumniListScreen(
          title: 'My mentorship connections',
          subtitle: 'Mentor and mentee relationships',
          items: const [
            'Grace Paul - Pending',
            'Michael Kato - Active',
            'Dr. Mwinyi - Completed'
          ],
          onBack: onBack);
  factory AlumniListScreen.feedback({required VoidCallback onBack}) =>
      AlumniListScreen(
          title: 'My feedback history',
          subtitle: 'Submitted items and status',
          items: const [
            'Suggestion: Alumni directory filters - Open',
            'Bug report: Event RSVP state - Resolved'
          ],
          onBack: onBack);

  final String title;
  final String subtitle;
  final List<String> items;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return AlumniScroll(
      header: AlumniHeader(
          title: title, subtitle: subtitle, initials: 'L', onBack: onBack),
      children: [
        for (final item in items)
          CompactFeedItem(
              title: item, meta: subtitle, tag: 'Active', color: ucisBlue)
      ],
    );
  }
}

class AlumniScroll extends StatelessWidget {
  const AlumniScroll({super.key, required this.header, required this.children});

  final Widget header;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        header,
        Expanded(
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
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

class AlumniHeader extends StatelessWidget {
  const AlumniHeader(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.initials,
      this.badge,
      this.onProfileTap,
      this.onBack});

  final String title;
  final String subtitle;
  final String initials;
  final String? badge;
  final VoidCallback? onProfileTap;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ucisCanvas,
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PortalTopBar(
              initials: initials,
              badge: badge,
              onBack: onBack,
              onProfileTap: onProfileTap),
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

class AlumniProfileSummaryCard extends StatelessWidget {
  const AlumniProfileSummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return UcisPanel(
      child: Row(
        children: [
          const ProfileAvatar(initials: 'AM', radius: 34),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Asha Mwakalinga',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        color: ucisInk)),
                SizedBox(height: 3),
                Text('Class of 2019 - Product Manager',
                    style: TextStyle(
                        fontSize: 12,
                        color: ucisMuted,
                        fontWeight: FontWeight.w700)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
            decoration: BoxDecoration(
                color: ucisGreen.withValues(alpha: .12),
                borderRadius: BorderRadius.circular(8)),
            child: const Text('Active',
                style: TextStyle(
                    color: ucisGreen,
                    fontSize: 10,
                    fontWeight: FontWeight.w900)),
          ),
        ],
      ),
    );
  }
}

class AlumniBottomNav extends StatelessWidget {
  const AlumniBottomNav(
      {super.key, required this.selectedIndex, required this.onSelect});

  final int selectedIndex;
  final ValueChanged<int> onSelect;

  static const _items = [
    (Icons.home_outlined, 'Home'),
    (Icons.campaign_outlined, 'Updates'),
    (Icons.event_outlined, 'Events'),
    (Icons.work_outline, 'Jobs'),
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
                child: Semantics(
                  button: true,
                  label: _items[i].$2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(_items[i].$1,
                          size: 19,
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
            ),
        ],
      ),
    );
  }
}

class UcisPanel extends StatelessWidget {
  const UcisPanel({super.key, required this.child});

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
          ]),
      child: child,
    );
  }
}

class SectionBlock extends StatelessWidget {
  const SectionBlock(
      {super.key, required this.title, required this.child, this.subtitle});

  final String title;
  final String? subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return UcisPanel(
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        if (title.isNotEmpty)
          Text(title,
              style: const TextStyle(
                  fontSize: 15, fontWeight: FontWeight.w900, color: ucisInk)),
        if (subtitle != null)
          Text(subtitle!,
              style: const TextStyle(
                  fontSize: 10, color: ucisMuted, fontWeight: FontWeight.w700)),
        if (title.isNotEmpty || subtitle != null) const SizedBox(height: 12),
        child,
      ]),
    );
  }
}

class DashboardTile extends StatelessWidget {
  const DashboardTile(
      {super.key,
      required this.icon,
      required this.title,
      required this.value,
      required this.onTap});

  final IconData icon;
  final String title;
  final String value;
  final VoidCallback onTap;

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
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(icon, color: _tileColor(title), size: 20),
          const SizedBox(height: 4),
          Text(title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontSize: 10, fontWeight: FontWeight.w900, color: ucisInk)),
          Text(value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontSize: 8, fontWeight: FontWeight.w700, color: ucisMuted)),
        ]),
      ),
    );
  }

  Color _tileColor(String title) => switch (title) {
        'Events' => ucisGold,
        'Jobs' => ucisGreen,
        'Mentor' => ucisPink,
        'Map' => ucisSky,
        'AI Help' => ucisMuted,
        _ => ucisBlue,
      };
}

class CompactFeedItem extends StatelessWidget {
  const CompactFeedItem(
      {super.key,
      required this.title,
      required this.meta,
      required this.tag,
      required this.color,
      this.onTap});

  final String title;
  final String meta;
  final String tag;
  final Color color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: UcisPanel(
          child: Row(children: [
            Container(
                width: 4,
                height: 48,
                decoration: BoxDecoration(
                    color: color, borderRadius: BorderRadius.circular(8))),
            const SizedBox(width: 10),
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  BadgePill(text: tag, color: color),
                  const SizedBox(height: 6),
                  Text(title,
                      style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w900,
                          color: ucisInk)),
                  Text(meta,
                      style: const TextStyle(fontSize: 10, color: ucisMuted)),
                ])),
            const Icon(Icons.chevron_right, color: ucisMuted, size: 18),
          ]),
        ),
      ),
    );
  }
}

class JobPost extends StatelessWidget {
  const JobPost(
      {super.key,
      required this.title,
      required this.company,
      required this.location,
      required this.deadline,
      required this.onTap});

  final String title;
  final String company;
  final String location;
  final String deadline;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => CompactFeedItem(
      title: title,
      meta: '$company - $location - Deadline: $deadline',
      tag: 'Full-time',
      color: ucisBlue,
      onTap: onTap);
}

class AlumniNewsMiniCard extends StatelessWidget {
  const AlumniNewsMiniCard(
      {super.key,
      required this.icon,
      required this.tag,
      required this.title,
      required this.date,
      required this.onTap});

  final IconData icon;
  final String tag;
  final String title;
  final String date;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: UcisPanel(
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
                      fontSize: 9,
                      color: ucisBlue,
                      fontWeight: FontWeight.w900)),
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
      ),
    );
  }
}

class FilterChips extends StatelessWidget {
  const FilterChips({super.key, required this.labels});

  final List<String> labels;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(children: [
        for (var i = 0; i < labels.length; i++) ...[
          BadgePill(
              text: labels[i],
              color: i == 0 ? ucisBlue : ucisMuted,
              pale: i != 0),
          const SizedBox(width: 8),
        ],
      ]),
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

class ActionPill extends StatelessWidget {
  const ActionPill(
      {super.key,
      required this.icon,
      required this.label,
      required this.onTap});

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => ActionChip(
      avatar: Icon(icon, size: 17, color: ucisBlue),
      label: Text(label),
      onPressed: onTap,
      labelStyle: const TextStyle(fontSize: 11, fontWeight: FontWeight.w900));
}

class MenuAction extends StatelessWidget {
  const MenuAction(
      {super.key,
      required this.icon,
      required this.title,
      required this.onTap});

  final IconData icon;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 9),
        child: Row(children: [
          Icon(icon, color: ucisBlue, size: 19),
          const SizedBox(width: 10),
          Expanded(
              child: Text(title,
                  style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w900,
                      color: ucisInk))),
          const Icon(Icons.chevron_right, color: ucisMuted, size: 18),
        ]),
      ),
    );
  }
}

class NoticeLine extends StatelessWidget {
  const NoticeLine(
      {super.key, required this.icon, required this.text, this.onTap});

  final IconData icon;
  final String text;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: const Color(0xFFFFF7DF),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFFFFE3A3))),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Icon(icon, color: ucisGold, size: 18),
          const SizedBox(width: 8),
          Expanded(
              child: Text(text,
                  style: const TextStyle(
                      fontSize: 11,
                      color: ucisInk,
                      height: 1.25,
                      fontWeight: FontWeight.w700))),
        ]),
      ),
    );
  }
}

class CalendarPreview extends StatelessWidget {
  const CalendarPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return UcisPanel(
      child: GridView.count(
        crossAxisCount: 7,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          for (var day = 1; day <= 35; day++)
            Container(
              margin: const EdgeInsets.all(3),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: {9, 16, 22, 30}.contains(day)
                      ? ucisGold.withValues(alpha: .22)
                      : const Color(0xFFF7F8FA),
                  borderRadius: BorderRadius.circular(8)),
              child: Text('$day',
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w900,
                      color: {9, 16, 22, 30}.contains(day)
                          ? ucisBlue
                          : ucisMuted)),
            ),
        ],
      ),
    );
  }
}

class EmergencyContact extends StatelessWidget {
  const EmergencyContact(
      {super.key,
      required this.role,
      required this.phone,
      required this.hours});

  final String role;
  final String phone;
  final String hours;

  @override
  Widget build(BuildContext context) => CompactFeedItem(
      title: role, meta: '$phone - $hours', tag: 'Quick-call', color: ucisRed);
}

class MapPin extends StatelessWidget {
  const MapPin({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) => Column(children: [
        const Icon(Icons.location_on, color: ucisRed, size: 28),
        Text(label,
            style: const TextStyle(
                fontSize: 9, fontWeight: FontWeight.w900, color: ucisInk))
      ]);
}

class AlumniPerson extends StatelessWidget {
  const AlumniPerson(
      {super.key, required this.name, required this.role, required this.onTap});

  final String name;
  final String role;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => CompactFeedItem(
      title: name, meta: role, tag: 'Connect', color: ucisBlue, onTap: onTap);
}

class ConnectionRow extends StatelessWidget {
  const ConnectionRow({super.key, required this.name, required this.status});

  final String name;
  final String status;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Row(children: [
          const CircleAvatar(
              radius: 15,
              backgroundColor: Color(0xFFEAF0FF),
              child: Icon(Icons.person_outline, size: 17, color: ucisBlue)),
          const SizedBox(width: 10),
          Expanded(
              child: Text(name,
                  style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w900,
                      color: ucisInk))),
          BadgePill(text: status, color: ucisBlue),
        ]),
      );
}

class ChatBubble extends StatelessWidget {
  const ChatBubble({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) => Align(
        alignment: Alignment.centerLeft,
        child: Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: ucisLine)),
          child: Text(text,
              style:
                  const TextStyle(fontSize: 12, height: 1.3, color: ucisInk)),
        ),
      );
}
