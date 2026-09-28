import 'package:flutter/material.dart';

import '../widgets/custom_text_field.dart';
import '../widgets/primary_button.dart';

class RecuperarSenhaScreen extends StatefulWidget {
  const RecuperarSenhaScreen({super.key});

  @override
  State<RecuperarSenhaScreen> createState() => _RecuperarSenhaScreenState();
}

class _RecuperarSenhaScreenState extends State<RecuperarSenhaScreen> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _recuperarSenha() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Solicitação realizada! Verifique seu e-mail.',
        ),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recuperar senha'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 30),

                const Icon(
                  Icons.lock_reset,
                  size: 80,
                  color: Color(0xFF7C4DFF),
                ),

                const SizedBox(height: 24),

                const Text(
                  'Esqueceu sua senha?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 12),

                const Text(
                  'Informe o e-mail cadastrado para solicitar a recuperação da sua senha.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white60,
                    fontSize: 15,
                  ),
                ),

                const SizedBox(height: 35),

                CustomTextField(
                  label: 'E-mail',
                  icon: Icons.email_outlined,
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Informe seu e-mail';
                    }

                    if (!value.contains('@') || !value.contains('.')) {
                      return 'Informe um e-mail válido';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 25),

                PrimaryButton(
                  text: 'RECUPERAR SENHA',
                  onPressed: _recuperarSenha,
                ),

                const SizedBox(height: 15),

                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Voltar para o Login',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}