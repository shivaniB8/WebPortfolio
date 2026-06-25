import 'package:flutter/material.dart';
import '../theme/colors.dart';

// ─────────────────────────────────────────────
// Models
// ─────────────────────────────────────────────

class ExperienceModel {
  final String company;
  final String role;
  final String period;
  final String location;
  final List<String> bullets;
  final Color accentColor;

  const ExperienceModel({
    required this.company,
    required this.role,
    required this.period,
    required this.location,
    required this.bullets,
    required this.accentColor,
  });
}

class ProjectModel {
  final String title;
  final String description;
  final List<String> tags;
  final String? githubUrl;
  final Color gradientStart;
  final Color gradientEnd;
  final IconData icon;

  const ProjectModel({
    required this.title,
    required this.description,
    required this.tags,
    this.githubUrl,
    required this.gradientStart,
    required this.gradientEnd,
    required this.icon,
  });
}

class SkillCategory {
  final String title;
  final Color color;
  final IconData icon;
  final List<String> skills;

  const SkillCategory({
    required this.title,
    required this.color,
    required this.icon,
    required this.skills,
  });
}

class EducationModel {
  final String institution;
  final String degree;
  final String period;
  final String score;
  final IconData icon;
  final Color color;

  const EducationModel({
    required this.institution,
    required this.degree,
    required this.period,
    required this.score,
    required this.icon,
    required this.color,
  });
}

class CertificationModel {
  final String title;
  final String issuer;
  final String year;
  final IconData icon;
  final Color color;

  const CertificationModel({
    required this.title,
    required this.issuer,
    required this.year,
    required this.icon,
    required this.color,
  });
}

class StatModel {
  final String value;
  final String label;
  final IconData icon;

  const StatModel({
    required this.value,
    required this.label,
    required this.icon,
  });
}

// ─────────────────────────────────────────────
// Data
// ─────────────────────────────────────────────

class PortfolioData {
  PortfolioData._();

  static const String name = 'Shivani Bagal';
  static const String title = 'Flutter Developer';
  static const String email = 'shivanibagal88@gmail.com';
  static const String phone = '+91 9851515050';
  static const String github = 'https://github.com/shivaniB8';
  static const String linkedin =
      'https://www.linkedin.com/in/shivani-bagal-14a2541bb/';
  static const String medium = 'https://medium.com/@shivanibagal88';
  static const String location = 'Pune, Maharashtra, India';

  static const String summary =
      'Flutter Developer with 4 years of experience building secure, scalable mobile applications '
      'for government and enterprise clients. Delivered applications onboarding 50,000+ users, '
      'built systems handling 2.2M+ records, implemented real-time communication using Agora SDK, '
      'integrated multiple payment gateways, automated CI/CD pipelines, and mentored Flutter developers. '
      'Passionate about clean architecture, performance, and AI-powered mobile experiences.';

  static const List<String> typewriterTexts = [
    'Flutter Developer',
    'Mobile App Developer',
    'Team Lead',
  ];

  static const List<StatModel> stats = [
    StatModel(value: '4+', label: 'Years Experience', icon: Icons.calendar_today_rounded),
    StatModel(value: '50K+', label: 'Users Onboarded', icon: Icons.people_rounded),
    StatModel(value: '2.2M+', label: 'Records Managed', icon: Icons.storage_rounded),
    StatModel(value: '5+', label: 'Live Apps', icon: Icons.phone_iphone_rounded),
  ];

  static const List<String> achievements = [
    'Led a team of 5–6 Flutter developers across government-grade projects',
    'Onboarded 50,000+ users in a multi-state police management system',
    'Built data systems managing 2.2 million+ records with real-time sync',
    'Contributed to 15% revenue growth at BeyondWalls (PropTech)',
    'Automated CI/CD with Jenkins & GitHub Actions across multiple apps',
    'Integrated Agora SDK for real-time PTT & VoIP calling features',
    'Shipped 5+ live apps to Play Store and App Store',
    'Mentored and onboarded new Flutter developers',
  ];

  // ── Experience ──────────────────────────────

  static const List<ExperienceModel> experience = [
    ExperienceModel(
      company: 'Samruddh Bharat Tech / Edynamics',
      role: 'Flutter Developer',
      period: '2023 – Present',
      location: 'Pune, India',
      accentColor: AppColors.purple,
      bullets: [
        'Lead a team of 5–6 developers across full end-to-end Flutter app development and deployment',
        'Oversee 4–5 live mobile applications through complete release cycles for Android & iOS',
        'Integrated payment gateways: Cashfree, Paytm, Razorpay, and Easebuzz',
        'Integrated Firebase, Google Maps, WebSockets, YouTube player, and Agora SDK',
        'Developed government and enterprise-grade applications with certificate pinning & security hardening',
        'Automated CI/CD pipelines using Jenkins and GitHub Actions',
        'Mentored and onboarded new Flutter team members',
      ],
    ),
    ExperienceModel(
      company: 'K2V2 Technologies — Kylas & BeyondWalls',
      role: 'Flutter Developer',
      period: '2021 – 2023',
      location: 'Pune, India',
      accentColor: AppColors.cyan,
      bullets: [
        'Delivered BeyondWalls end-to-end, directly contributing to ~15% company revenue growth',
        'Released Android & iOS apps to Google Play Store and Apple App Store',
        'Implemented Razorpay payment integration, push notifications via OneSignal, and deep linking',
        'Built WebView integrations and KYC verification flows',
        'Worked on Kylas CRM mobile application with real-time data sync',
      ],
    ),
    ExperienceModel(
      company: 'CloudShiksha',
      role: 'Flutter Developer Intern',
      period: '2021 – 2022',
      location: 'Remote',
      accentColor: Color(0xFF10B981),
      bullets: [
        'Developed 3 applications: Ayurveda e-commerce, FoxyJobs job portal, ExamPanda mock test app',
        'Used Figma for wireframing and UI design before implementation',
        'Implemented REST API integrations, state management with Provider',
        'Gained hands-on experience in full Flutter app development lifecycle',
      ],
    ),
    ExperienceModel(
      company: 'Kids Galaxy',
      role: 'Project Manager',
      period: '2019 – 2020',
      location: 'Pune, India',
      accentColor: Color(0xFFF59E0B),
      bullets: [
        'Team lead for a group of 10 members on LMS project',
        'Created and managed MongoDB database for the Learning Management System',
        'Web development using HTML and CSS',
        'Coordinated project timelines, deliverables, and team communication',
      ],
    ),
  ];

  // ── Projects ─────────────────────────────────

  static const List<ProjectModel> projects = [
    ProjectModel(
      title: 'Smart Force Police App',
      description:
          'Government-grade police management system deployed across multiple states. '
          'Onboarded 50,000+ users, manages 2.2M+ records, real-time communication, '
          'multi-state deployment (Goa, Delhi, Assam).',
      tags: ['Flutter', 'Firebase', 'Agora', 'BLoC', 'WebSockets'],
      gradientStart: Color(0xFF7C3AED),
      gradientEnd: Color(0xFF4F46E5),
      icon: Icons.security_rounded,
    ),
    ProjectModel(
      title: 'Visitor Connect',
      description:
          'Smart Tourism Platform for tourism authorities. Digital visitor passes, '
          'visa monitoring, travel history tracking and analytics dashboard.',
      tags: ['Flutter', 'Firebase', 'REST APIs', 'Google Maps'],
      gradientStart: Color(0xFF06B6D4),
      gradientEnd: Color(0xFF0284C7),
      icon: Icons.travel_explore_rounded,
    ),
    ProjectModel(
      title: 'Bharat Messenger',
      description:
          'Full-featured real-time messaging app with Firebase authentication, '
          'instant messaging, push notifications, and media sharing.',
      tags: ['Flutter', 'Firebase', 'WebSockets'],
      gradientStart: Color(0xFF10B981),
      gradientEnd: Color(0xFF059669),
      icon: Icons.chat_bubble_rounded,
    ),
    ProjectModel(
      title: 'BeyondWalls',
      description:
          'PropTech mobile app for property developers and agents. '
          'Contributed to 15% company revenue growth. Property selling platform '
          'with KYC, payments, and deep linking.',
      tags: ['Flutter', 'Razorpay', 'Firebase', 'OneSignal'],
      gradientStart: Color(0xFFEC4899),
      gradientEnd: Color(0xFFBE185D),
      icon: Icons.apartment_rounded,
    ),
    ProjectModel(
      title: 'BarBrain — Alcohol Mixer',
      description:
          'Personal project: AI-powered cocktail recommendation app. '
          'Get personalized drink suggestions based on available ingredients.',
      tags: ['Flutter', 'AI', 'Provider'],
      githubUrl: 'https://github.com/shivaniB8/BarBrain',
      gradientStart: Color(0xFFF59E0B),
      gradientEnd: Color(0xFFD97706),
      icon: Icons.local_bar_rounded,
    ),
    ProjectModel(
      title: 'BrainGames',
      description:
          'Brain training quiz game app with multiple categories, '
          'difficulty levels, leaderboards, and progress tracking.',
      tags: ['Flutter', 'Dart'],
      githubUrl: 'https://github.com/shivaniB8/BrainGames',
      gradientStart: Color(0xFF8B5CF6),
      gradientEnd: Color(0xFF7C3AED),
      icon: Icons.psychology_rounded,
    ),
    ProjectModel(
      title: 'SoundMixer',
      description:
          'Ambient sound mixer with customizable timer, preset scenes, '
          'and layered audio for focus, sleep, and relaxation.',
      tags: ['Flutter', 'Audio'],
      githubUrl: 'https://github.com/shivaniB8/SoundMixer',
      gradientStart: Color(0xFF06B6D4),
      gradientEnd: Color(0xFF7C3AED),
      icon: Icons.music_note_rounded,
    ),
  ];

  // ── Skills ──────────────────────────────────

  static const List<SkillCategory> skillCategories = [
    SkillCategory(
      title: 'Mobile Development',
      color: AppColors.catMobile,
      icon: Icons.phone_android_rounded,
      skills: ['Flutter', 'Dart', 'Android Studio', 'Xcode'],
    ),
    SkillCategory(
      title: 'State Management',
      color: AppColors.catState,
      icon: Icons.account_tree_rounded,
      skills: ['BLoC', 'Provider', 'GetX', 'Streams', 'Cubit'],
    ),
    SkillCategory(
      title: 'Backend & APIs',
      color: AppColors.catBackend,
      icon: Icons.cloud_rounded,
      skills: [
        'Firebase',
        'REST APIs',
        'WebSockets',
        'OneSignal',
        'Postman',
        'FCM',
      ],
    ),
    SkillCategory(
      title: 'Payment Gateways',
      color: AppColors.catPayments,
      icon: Icons.payment_rounded,
      skills: ['Razorpay', 'Cashfree', 'Paytm', 'Easebuzz'],
    ),
    SkillCategory(
      title: 'CI/CD & DevOps',
      color: AppColors.catDevOps,
      icon: Icons.developer_mode_rounded,
      skills: [
        'Jenkins',
        'GitHub Actions',
        'Git',
        'GitLab',
        'Bitbucket',
      ],
    ),
    SkillCategory(
      title: 'Architecture',
      color: AppColors.catArch,
      icon: Icons.architecture_rounded,
      skills: ['MVVM', 'MVC', 'Clean Architecture'],
    ),
    SkillCategory(
      title: 'Testing',
      color: AppColors.catTesting,
      icon: Icons.bug_report_rounded,
      skills: ['Unit Testing', 'Integration Testing', 'Golden Image Testing'],
    ),
    SkillCategory(
      title: 'Other Tools',
      color: AppColors.catOther,
      icon: Icons.build_rounded,
      skills: [
        'Agora SDK',
        'Certificate Pinning',
        'Gemini AI',
        'Google Maps',
        'Deep Linking',
        'Figma',
        'YouTube API',
      ],
    ),
  ];

  // ── Education ───────────────────────────────

  static const List<EducationModel> education = [
    EducationModel(
      institution: 'MIT Academy of Engineering',
      degree: 'B.Tech — Computer Engineering',
      period: '2018 – 2022',
      score: 'CGPA: 8.4',
      icon: Icons.school_rounded,
      color: AppColors.purple,
    ),
    EducationModel(
      institution: 'Sri Chaitanya Junior College',
      degree: 'HSC (Higher Secondary)',
      period: '2016 – 2018',
      score: '73%',
      icon: Icons.menu_book_rounded,
      color: AppColors.cyan,
    ),
    EducationModel(
      institution: 'Pragati Vidyala Mangi',
      degree: 'SSC (Secondary School Certificate)',
      period: '2016',
      score: '89%',
      icon: Icons.class_rounded,
      color: Color(0xFF10B981),
    ),
  ];

  // ── Certifications ──────────────────────────

  static const List<CertificationModel> certifications = [
    CertificationModel(
      title: 'Google IT Support Professional Certificate',
      issuer: 'Google',
      year: '2020',
      icon: Icons.support_agent_rounded,
      color: Color(0xFF4285F4),
    ),
    CertificationModel(
      title: 'Architecting with Google Compute Engine',
      issuer: 'Google',
      year: '2021',
      icon: Icons.cloud_done_rounded,
      color: Color(0xFF34A853),
    ),
    CertificationModel(
      title: 'Gemini-Powered Flutter App',
      issuer: 'Google Codelabs',
      year: '2024',
      icon: Icons.auto_awesome_rounded,
      color: AppColors.purple,
    ),
  ];
}
