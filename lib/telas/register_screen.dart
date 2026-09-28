import 'package:flutter/material.dart';

import '../widgets/custom_text_field.dart';
import '../widgets/primary_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _usuarioController = TextEditingController();
  final _senhaController = TextEditingController();
  final _confirmarSenhaController = TextEditingController();

  bool _mostrarSenha = false;
  bool _mostrarConfirmacao = false;

  @override
  void dispose() {
    _nomeController.dispose();
    _emailController.dispose();
    _usuarioController.dispose();
    _senhaController.dispose();
    _confirmarSenhaController.dispose();
    super.dispose();
  }

  void _cadastrar() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Dados cadastrados temporariamente em memória.
    final usuarioCadastrado = {
      'nome': _nomeController.text.trim(),
      'email': _emailController.text.trim(),
      'usuario': _usuarioController.text.trim(),
      'senha': _senhaController.text,
    };

    // Retorna para o Login levando os dados cadastrados.
    Navigator.pop(context, usuarioCadastrado);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar conta'),
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
                const SizedBox(height: 10),

                const Icon(
                  Icons.person_add_alt_1,
                  size: 70,
                  color: Color(0xFF7C4DFF),
                ),

                const SizedBox(height: 20),

                const Text(
                  'Crie sua conta',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  'Preencha os dados para começar a usar o Games Rule.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white60,
                    fontSize: 14,
                  ),
                ),

                const SizedBox(height: 30),

                // Nome
                CustomTextField(
                  label: 'Nome',
                  icon: Icons.person_outline,
                  controller: _nomeController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Informe seu nome';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 16),

                // E-mail
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

                const SizedBox(height: 16),

                // Nome de usuário
                CustomTextField(
                  label: 'Nome de usuário',
                  icon: Icons.account_circle_outlined,
                  controller: _usuarioController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Informe um nome de usuário';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 16),

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
                      return 'Informe uma senha';
                    }

                    if (value.length < 4) {
                      return 'A senha deve ter pelo menos 4 caracteres';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 16),

                // Confirmação da senha
                CustomTextField(
                  label: 'Confirme sua senha',
                  icon: Icons.lock_reset_outlined,
                  controller: _confirmarSenhaController,
                  obscureText: !_mostrarConfirmacao,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _mostrarConfirmacao
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _mostrarConfirmacao = !_mostrarConfirmacao;
                      });
                    },
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Confirme sua senha';
                    }

                    if (value != _senhaController.text) {
                      return 'As senhas não são iguais';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 28),

                // Botão cadastrar
                PrimaryButton(
                  text: 'CADASTRAR',
                  onPressed: _cadastrar,
                ),

                const SizedBox(height: 16),

                // Voltar para login
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Já tenho uma conta. Voltar para o login',
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}