import 'package:flutter/material.dart';

const ucisBlue = Color(0xFF0F5FD7);
const ucisBlueDark = Color(0xFF083F9A);
const ucisInk = Color(0xFF111827);
const ucisMuted = Color(0xFF667085);
const ucisLine = Color(0xFFE8ECF4);
const ucisCanvas = Color(0xFFF7F9FE);
const ucisGold = Color(0xFFF4B740);
const ucisGreen = Color(0xFF12A66A);
const ucisRed = Color(0xFFE33B4A);
const ucisSky = Color(0xFF38A9F5);
const ucisPink = Color(0xFFE84C88);

ThemeData buildUcisTheme() {
  final scheme = ColorScheme.fromSeed(
    seedColor: ucisBlue,
    primary: ucisBlue,
    secondary: ucisGold,
    tertiary: ucisGreen,
    error: ucisRed,
    surface: Colors.white,
    brightness: Brightness.light,
  );

  return ThemeData(
    useMaterial3: true,
    colorScheme: scheme,
    scaffoldBackgroundColor: ucisCanvas,
    fontFamily: 'Roboto',
    textTheme: const TextTheme(
      headlineSmall:
          TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: ucisInk),
      titleLarge:
          TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: ucisInk),
      titleMedium:
          TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: ucisInk),
      bodyMedium: TextStyle(fontSize: 12, color: ucisMuted, height: 1.28),
      labelLarge: TextStyle(fontSize: 12, fontWeight: FontWeight.w800),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: ucisLine),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: ucisLine),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: ucisBlue, width: 1.4),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: ucisBlue,
        foregroundColor: Colors.white,
        minimumSize: const Size.fromHeight(46),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        textStyle: const TextStyle(fontWeight: FontWeight.w900, fontSize: 13),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: ucisInk,
        side: const BorderSide(color: ucisLine),
        minimumSize: const Size.fromHeight(44),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        textStyle: const TextStyle(fontWeight: FontWeight.w900, fontSize: 13),
      ),
    ),
  );
}

class UdsLogo extends StatelessWidget {
  const UdsLogo({super.key, required this.size, this.compact = false});

  final double size;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Image.asset('assets/images/udsm_logo.png',
        width: size, height: compact ? size : null, fit: BoxFit.contain);
  }
}

class PortalTopBar extends StatelessWidget {
  const PortalTopBar({
    super.key,
    required this.initials,
    this.badge,
    this.onBack,
    this.onProfileTap,
    this.showBell = true,
  });

  final String initials;
  final String? badge;
  final VoidCallback? onBack;
  final VoidCallback? onProfileTap;
  final bool showBell;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (onBack != null) ...[
          _CircleIconButton(icon: Icons.arrow_back, onTap: onBack),
          const SizedBox(width: 10),
        ],
        const UdsLogo(size: 36, compact: true),
        const SizedBox(width: 10),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('UDSM MOBILE',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: ucisBlueDark,
                      fontSize: 14,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0)),
              Text('CONNECTED INTELLIGENT SYSTEM',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: ucisMuted,
                      fontSize: 8.5,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0)),
            ],
          ),
        ),
        if (showBell) NotificationBell(count: badge),
        const SizedBox(width: 10),
        _CircleIconButton(icon: Icons.person_outline, onTap: onProfileTap),
      ],
    );
  }
}

class NotificationBell extends StatelessWidget {
  const NotificationBell({super.key, this.count});

  final String? count;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        const _CircleIconButton(icon: Icons.notifications_none),
        if (count != null)
          Positioned(
            right: -2,
            top: -4,
            child: Container(
              width: 17,
              height: 17,
              alignment: Alignment.center,
              decoration:
                  const BoxDecoration(color: ucisRed, shape: BoxShape.circle),
              child: Text(count!,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 9,
                      fontWeight: FontWeight.w900)),
            ),
          ),
      ],
    );
  }
}

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({super.key, required this.initials, this.radius = 19});

  final String initials;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: ucisBlue,
      child: Text(initials,
          style: TextStyle(
              color: Colors.white,
              fontSize: radius > 24 ? 18 : 11,
              fontWeight: FontWeight.w900)),
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  const _CircleIconButton({required this.icon, this.onTap});

  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: 38,
        height: 38,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: ucisLine)),
        child: Icon(icon, color: ucisInk, size: 20),
      ),
    );
  }
}

class PortalSearchBar extends StatelessWidget {
  const PortalSearchBar({super.key, required this.hint});

  final String hint;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: ucisLine),
        boxShadow: const [
          BoxShadow(
              color: Color(0x0D101828), blurRadius: 18, offset: Offset(0, 8))
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: const Icon(Icons.search, color: ucisMuted),
          suffixIcon: const Icon(Icons.tune, color: ucisMuted),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          fillColor: Colors.white,
        ),
      ),
    );
  }
}

class SectionHeading extends StatelessWidget {
  const SectionHeading({super.key, required this.title, this.action});

  final String title;
  final String? action;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Text(title,
                style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                    color: ucisInk))),
        if (action != null)
          Text(action!,
              style: const TextStyle(
                  fontSize: 12, color: ucisBlue, fontWeight: FontWeight.w900)),
      ],
    );
  }
}

class UniversityHeroCard extends StatelessWidget {
  const UniversityHeroCard({
    super.key,
    required this.title,
    required this.body,
    required this.tag,
    required this.action,
  });

  final String title;
  final String body;
  final String tag;
  final String action;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 190,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: const LinearGradient(
          colors: [Color(0xFF063B99), Color(0xFF0F67DA), Color(0xFF72B8F4)],
          stops: [0, .56, 1],
        ),
        boxShadow: const [
          BoxShadow(
              color: Color(0x1A0F5FD7), blurRadius: 18, offset: Offset(0, 10))
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -8,
            bottom: -8,
            child: Icon(Icons.account_balance,
                size: 118, color: Colors.white.withValues(alpha: .28)),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: .18),
                    borderRadius: BorderRadius.circular(8)),
                child: Text(tag,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w900)),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: 190,
                child: Text(title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 21,
                        fontWeight: FontWeight.w900,
                        height: 1.05)),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: 218,
                child: Text(body,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: Color(0xFFEAF2FF),
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        height: 1.22)),
              ),
              const Spacer(),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 13, vertical: 9),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8)),
                child: Text(action,
                    style: const TextStyle(
                        color: ucisBlue,
                        fontSize: 12,
                        fontWeight: FontWeight.w900)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
