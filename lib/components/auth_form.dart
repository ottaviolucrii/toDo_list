import 'dart:io';

import 'package:flutter/material.dart';

import '../core/models/auth_form_data.dart';
import 'user_image_picker.dart';

class AuthForm extends StatefulWidget {
  final void Function(AuthFormData) onSubmit;

  const AuthForm({
    super.key,
    required this.onSubmit,
  });

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  final _formData = AuthFormData();

  void _handleImagePick(File image) {
    _formData.image = image;
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: Theme.of(context).colorScheme.error,
      ),
    );
  }

  void _submit() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if(!isValid) return;

    if(_formData.image == null && _formData.isSignup) {
      return _showError('Imagem não selecionada');
    }

    widget.onSubmit(_formData);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              if(_formData.isSignup)
                // ignore: prefer_const_constructors
                UserImagePicker(onImagePick: _handleImagePick),
              if(_formData.isSignup)
                TextFormField(
                  key: const ValueKey('name'),
                  initialValue: _formData.name,
                  onChanged: (name) => _formData.name = name,
                  decoration: const InputDecoration(labelText: 'Nome'),
                  // ignore: no_leading_underscores_for_local_identifiers
                  validator: (_name) {
                    final name = _name ?? '';
                    if(name.trim().length < 5) {
                      return 'Nome deve ter no mínimo 5 caracteres';
                    }
                    return null;
                  }
                ),
              TextFormField(
                key: const ValueKey('email'),
                initialValue: _formData.email,
                onChanged: (email) => _formData.email = email,
                decoration: const InputDecoration(labelText: 'E-mail'),
                // ignore: no_leading_underscores_for_local_identifiers
                validator: (_email) {
                    final email = _email ?? '';
                    if(!email.contains('@')) {
                      return 'E-mail informado é inválido';
                    }
                    return null;
                  }
              ),
              TextFormField(
                key: const ValueKey('password'),
                initialValue: _formData.password,
                onChanged: (password) => _formData.password = password,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Senha'),
                // ignore: no_leading_underscores_for_local_identifiers
                validator: (_password) {
                    final password = _password ?? '';
                    if(password.length < 6) {
                      return 'Senha deve ter no mínimo 6 caracteres';
                    }
                    return null;
                  }
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: _submit,
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all<Color>(Theme.of(context).colorScheme.primary),
                ),
                child: Text(
                  _formData.isLogin ? 'Entrar' : 'Cadastrar',
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _formData.toggleAuthMode();
                  });
                },
                child: Text(_formData.isLogin  ? 'Criar uma nova conta?' : 'Já possuí conta?'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}