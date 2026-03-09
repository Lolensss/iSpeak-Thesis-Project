import 'package:flutter/material.dart';
import '../theme/app_theme.dart';        
import 'language_screen.dart';  
import 'editprofile_screen.dart';
import 'login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // These will be populated from DB
  String userName = "";
  String userEmail = "";
  String userInitials = "";
  String selectedLanguage = "";
  
  int sessions = 0;
  int avgScore = 0; 
  int dayStreak = 0;

  @override
  void initState() {
    super.initState();
    // Load user data from DB
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    // TODO: Fetch from MongoDB via API
    // For now, just show loading state
  }

  void _goToLanguageScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LanguageScreen()),
    ).then((value) {
      if (value != null) {
        setState(() {
          selectedLanguage = value;
          // Save language preference to DB
        });
      }
    });
  }

  void _goToEditProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProfileScreen(
          userName: userName,
          userEmail: userEmail,
        ),
      ),
    ).then((value) {
      if (value != null) {
        setState(() {
          userName = value['name'];
          userEmail = value['email'];
          userInitials = value['name']
              .split(' ')
              .map((e) => e[0])
              .join()
              .toUpperCase();
          // Save changes to DB
        });
      }
    });
  }

  void _logout() async {
    // Await the result of the dialog to see if the user confirmed.
    final bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Log Out'),
          content: const Text('Are you sure you want to log out?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, true),
              child: const Text('Log Out', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );

    // If the user did not confirm (e.g., pressed cancel or tapped outside),
    // do nothing.
    if (confirmed != true) {
      return;
    }

    // If confirmed, proceed with logout logic.
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    // After an async gap, always check if the widget is still mounted
    // before interacting with its BuildContext.
    if (!mounted) return;

    // Navigate to the login screen and remove all previous routes.
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: 320, 
              width: double.infinity,
              color: AppTheme.accentColor, 
            ),
            
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    const Text(
                      'Profile',
                      style: TextStyle(
                        fontSize: 28,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.bold,
                        color: Colors.white, 
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Account settings',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white70, 
                      ),
                    ),

                    const SizedBox(height: 32),

                    // User Card
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withAlpha((0.08 * 255).round()),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          // Avatar
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: AppTheme.accentColor,
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: Center(
                              child: Text(
                                userInitials,
                                style: const TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 16),

                          // User Info
                          Text(
                            userName,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),

                          const SizedBox(height: 4),

                          Text(
                            userEmail,
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[600],
                            ),
                          ),

                          const SizedBox(height: 20),

                          // Stats Row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    '$sessions',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: AppTheme.primaryColor,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Sessions',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    '$avgScore',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.amber,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Avg Score',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    '$dayStreak',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: AppTheme.primaryColor,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Day Streak',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 28),

                    //Score Guide 
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Score Guide Title with Icon
                          Row(
                            children: [
                              Icon(Icons.info_outline, color: AppTheme.accentColor, size: 20),
                              const SizedBox(width: 8),
                              const Text(
                                'Score Guide',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),

                          // Score Items using Emojis
                          _buildScoreGuideItem('95', 'Excellent', '85-100 points', Colors.green, '🎉'),
                          const SizedBox(height: 12),
                          _buildScoreGuideItem('76', 'Good', '70-84 points', Colors.amber, '👍'),
                          const SizedBox(height: 12),
                          _buildScoreGuideItem('58', 'Fair', '50-69 points', Colors.orange, '💪'),
                          const SizedBox(height: 12),
                          _buildScoreGuideItem('42', 'Needs Work', '0-49 points', Colors.red, '📈'),
                        ],
                      ),
                    ),

                    const SizedBox(height: 28),

                    // Language Option
                    _buildOptionTile(
                      icon: Icons.language,
                      title: 'Language',
                      subtitle: 'English & Filipino',
                      onTap: _goToLanguageScreen,
                    ),

                    const SizedBox(height: 12),

                    // Edit Profile Option
                    _buildOptionTile(
                      icon: Icons.edit,
                      title: 'Edit Profile',
                      subtitle: 'Update your information',
                      onTap: _goToEditProfile,
                    ),

                    const SizedBox(height: 12),

                    // Logout Option
                    _buildOptionTile(
                      icon: Icons.logout,
                      title: 'Log Out',
                      subtitle: null,
                      onTap: _logout,
                      isLogout: true,
                    ),

                    const SizedBox(height: 24),

                    // Footer
                    Center(
                      child: Text(
                        'iSpeak v1.0.0',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //Pastel background, solid circle, emoji icon
  Widget _buildScoreGuideItem(
    String score,
    String label,
    String range,
    Color color,
    String emoji, 
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
        color: color.withAlpha((0.12 * 255).round()), // Pastel background tint
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          //Large Colored Number
          SizedBox(
            width: 45,
            child: Text(
              score,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ),
          const SizedBox(width: 8),
          
          // Middle: Texts
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  range,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          ),
          
          // Solid Colored circle with Emoji
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color, // Solid color

              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                emoji,
                style: const TextStyle(fontSize: 18), // Emoji sizing
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionTile({
    required IconData icon,
    required String title,
    required String? subtitle,
    required VoidCallback onTap,
    bool isLogout = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isLogout ? Colors.red.withAlpha((0.1 * 255).round()) : Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isLogout ? Colors.red : AppTheme.primaryColor,
              size: 24,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: isLogout ? Colors.red : Colors.black87,
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ]
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: Colors.grey[400],
            ),
          ],
        ),
      ),
    );
  }
}