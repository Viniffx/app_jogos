import 'package:flutter/material.dart';

import '../widgets/custom_text_field.dart';
import '../widgets/primary_button.dart';
import 'register_screen.dart';
import 'recuperar_senha.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final _usuarioController = TextEditingController();
  final _senhaController = TextEditingController();

  Map<String, String>? _usuarioCadastrado;

  bool _mostrarSenha = false;

  @override
  void dispose() {
    _usuarioController.dispose();
    _senhaController.dispose();
    super.dispose();
  }

  void _entrar() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final usuario = _usuarioController.text.trim();
    final senha = _senhaController.text;

    // Usuário temporário para testar a tela.
    final loginPadrao = (usuario == 'admin@gmail.com' && senha == '1234');

    final loginCadastrado =
        _usuarioCadastrado != null &&
        (usuario == _usuarioCadastrado!['email'] ||
            usuario == _usuarioCadastrado!['usuario']) &&
        senha == _usuarioCadastrado!['senha'];

    if (loginPadrao || loginCadastrado) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login realizado com sucesso!'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Usuário ou senha inválidos.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _esqueciSenha() {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const RecuperarSenhaScreen(),
    ),
  );
}

void _criarConta() async {
  final resultado = await Navigator.push<Map<String, String>>(
    context,
    MaterialPageRoute(
      builder: (context) => const RegisterScreen(),
    ),
  );

  if (resultado != null) {
    setState(() {
      _usuarioCadastrado = resultado;
      _usuarioController.text = resultado['email'] ?? '';
    });

    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Cadastro realizado com sucesso!'),
        backgroundColor: Colors.green,
      ),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 30,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [

                  // Logo
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      color: const Color(0xFF7C4DFF),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: const Icon(
                      Icons.sports_esports,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Nome do aplicativo
                  const Text(
                    'Game Rule',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    'Avalie. Compartilhe. Descubra.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white60,
                      fontSize: 15,
                    ),
                  ),

                  const SizedBox(height: 40),

                  // Card de login
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: const Color(0xFF191923),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [

                        const Text(
                          'Entrar',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Usuário / Email
                        CustomTextField(
                          label: 'Usuário ou e-mail',
                          icon: Icons.person_outline,
                          controller: _usuarioController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Informe seu usuário ou e-mail';
                            }

                            return null;
                          },
                        ),

                        const SizedBox(height: 18),

                        // Senha
                        CustomTextField(
                          label: 'Senha',
                          icon: Icons.lock_outline,
                          controller: _senhaController,
                          obscureText: !_mostrarSenha,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _mostrarSenha
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                _mostrarSenha = !_mostrarSenha;
                              });
                            },
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Informe sua senha';
                            }

                            if (value.length < 4) {
                              return 'A senha deve ter pelo menos 4 caracteres';
                            }

                            return null;
                          },
                        ),

                        const SizedBox(height: 10),

                        // Esqueci minha senha
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: _esqueciSenha,
                            child: const Text(
                              'Esqueci minha senha',
                            ),
                          ),
                        ),

                        const SizedBox(height: 10),

                        // Botão entrar
                        PrimaryButton(
                          text: 'ENTRAR',
                          onPressed: _entrar,
                        ),

                        const SizedBox(height: 20),

                        // Divisor
                        Row(
                          children: [
                            const Expanded(
                              child: Divider(color: Colors.white24),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: Text(
                                'ou',
                                style: TextStyle(
                                  color: Colors.white54,
                                ),
                              ),
                            ),
                            const Expanded(
                              child: Divider(color: Colors.white24),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        // Criar conta
                        OutlinedButton(
                          onPressed: _criarConta,
                          style: OutlinedButton.styleFrom(
                            minimumSize: const Size(
                              double.infinity,
                              52,
                            ),
                            side: const BorderSide(
                              color: Color(0xFF7C4DFF),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'CRIAR CONTA',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  const Text(
                    'Game Rule © 2026',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white38,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}