import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/core/util/storage.dart';
import 'package:todo/presentation/route/rout_paths.dart';
import 'package:todo/presentation/views/base/base-state.dart';

class TokenSetupPage extends StatefulWidget {
  const TokenSetupPage({super.key});

  @override
  State<TokenSetupPage> createState() => _TokenSetupPageState();
}

class _TokenSetupPageState extends BaseState<TokenSetupPage> {
  final _controller = TextEditingController();
  final _storage = GetIt.I<Storage>();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadToken();
  }

  Future<void> _loadToken() async {
    final token = await _storage.getApiToken();
    if (token != null) {
      _controller.text = token;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _saveToken() async {
    setState(() => _isLoading = true);
    try {
      final token = _controller.text.trim();
      if (token.isEmpty) return; // or showSnackBar…

      await _storage.saveApiToken(token); // <-- may throw
      if (mounted) context.go(AppRoutePath.homeRoute);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save token: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('API Token Setup')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Please enter your Todoist API token to continue.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: localization.enterApiToken,
                border: const OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _isLoading ? null : _saveToken,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: _isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                          strokeWidth: 2, color: Colors.white),
                    )
                  : Text(localization.saveAndContinue),
            ),
          ],
        ),
      ),
    );
  }
}