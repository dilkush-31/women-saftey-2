import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  bool _emergencyAlerts = true;
  bool _locationUpdates = true;
  bool _appUpdates = true;
  bool _soundEnabled = true;
  bool _vibrationEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFFE91E63),
        elevation: 0,
        title: Text(
          'Notifications',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: const Color(0xFFE91E63),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.notifications,
                      size: 48,
                      color: Colors.pink[400],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Stay Updated',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSection('Alert Settings', [
                    _buildSwitchTile(
                      'Emergency Alerts',
                      'Receive alerts in emergency situations',
                      _emergencyAlerts,
                      (value) => setState(() => _emergencyAlerts = value),
                    ),
                    _buildSwitchTile(
                      'Location Updates',
                      'Get notified about location sharing',
                      _locationUpdates,
                      (value) => setState(() => _locationUpdates = value),
                    ),
                    _buildSwitchTile(
                      'App Updates',
                      'Receive updates about new features',
                      _appUpdates,
                      (value) => setState(() => _appUpdates = value),
                    ),
                  ]),
                  const SizedBox(height: 24),
                  _buildSection('Sound & Vibration', [
                    _buildSwitchTile(
                      'Sound',
                      'Play sound for notifications',
                      _soundEnabled,
                      (value) => setState(() => _soundEnabled = value),
                    ),
                    _buildSwitchTile(
                      'Vibration',
                      'Vibrate for notifications',
                      _vibrationEnabled,
                      (value) => setState(() => _vibrationEnabled = value),
                    ),
                  ]),
                  const SizedBox(height: 24),
                  _buildSection('Notification History', [
                    _buildHistoryTile(
                      'Emergency Alert Test',
                      '2 hours ago',
                      Icons.warning,
                      Colors.red,
                    ),
                    _buildHistoryTile(
                      'Location Shared',
                      'Yesterday',
                      Icons.location_on,
                      Colors.green,
                    ),
                    _buildHistoryTile(
                      'App Update Available',
                      '3 days ago',
                      Icons.system_update,
                      Colors.blue,
                    ),
                  ]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.pink[700],
          ),
        ),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Column(children: children),
        ),
      ],
    );
  }

  Widget _buildSwitchTile(
    String title,
    String subtitle,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return SwitchListTile(
      title: Text(
        title,
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: GoogleFonts.poppins(color: Colors.grey[600], fontSize: 12),
      ),
      value: value,
      onChanged: onChanged,
      activeColor: Colors.pink[400],
    );
  }

  Widget _buildHistoryTile(
    String title,
    String time,
    IconData icon,
    Color color,
  ) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: color),
      ),
      title: Text(
        title,
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
      subtitle: Text(
        time,
        style: GoogleFonts.poppins(color: Colors.grey[600], fontSize: 12),
      ),
      trailing: Icon(Icons.chevron_right, color: Colors.grey[400]),
    );
  }
}
