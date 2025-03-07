import 'package:flutter/material.dart';
import '../../core/theme/app_theme_export.dart';

/// Widget para demonstrar os componentes do tema
class ThemeShowcaseWidget extends StatelessWidget {
  const ThemeShowcaseWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Demonstração do Tema'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppDimensions.m),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection('Tipografia'),
            _buildTypographyShowcase(),
            const SizedBox(height: AppDimensions.l),
            
            _buildSection('Cores'),
            _buildColorsShowcase(),
            const SizedBox(height: AppDimensions.l),
            
            _buildSection('Botões'),
            _buildButtonsShowcase(),
            const SizedBox(height: AppDimensions.l),
            
            _buildSection('Campos de Texto'),
            _buildInputsShowcase(),
            const SizedBox(height: AppDimensions.l),
            
            _buildSection('Cards'),
            _buildCardsShowcase(),
            const SizedBox(height: AppDimensions.l),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppDimensions.s),
      child: Text(
        title,
        style: AppTypography.h3,
      ),
    );
  }

  Widget _buildTypographyShowcase() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.m),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Título H1', style: AppTypography.h1),
            const SizedBox(height: AppDimensions.s),
            Text('Título H2', style: AppTypography.h2),
            const SizedBox(height: AppDimensions.s),
            Text('Título H3', style: AppTypography.h3),
            const SizedBox(height: AppDimensions.s),
            Text('Título H4', style: AppTypography.h4),
            const SizedBox(height: AppDimensions.s),
            Text('Título H5', style: AppTypography.h5),
            const SizedBox(height: AppDimensions.m),
            
            Text('Body Large', style: AppTypography.bodyLarge),
            const SizedBox(height: AppDimensions.xs),
            Text('Body Large Secondary', style: AppTypography.bodyLargeSecondary),
            const SizedBox(height: AppDimensions.s),
            
            Text('Body Medium', style: AppTypography.bodyMedium),
            const SizedBox(height: AppDimensions.xs),
            Text('Body Medium Secondary', style: AppTypography.bodyMediumSecondary),
            const SizedBox(height: AppDimensions.s),
            
            Text('Body Small', style: AppTypography.bodySmall),
            const SizedBox(height: AppDimensions.xs),
            Text('Body Small Secondary', style: AppTypography.bodySmallSecondary),
            const SizedBox(height: AppDimensions.s),
            
            Text('Caption', style: AppTypography.caption),
            const SizedBox(height: AppDimensions.s),
            Text('OVERLINE', style: AppTypography.overline),
          ],
        ),
      ),
    );
  }

  Widget _buildColorsShowcase() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.m),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildColorRow('Primary', AppColors.primary),
            _buildColorRow('Primary Light', AppColors.primaryLight),
            _buildColorRow('Primary Dark', AppColors.primaryDark),
            const SizedBox(height: AppDimensions.s),
            
            _buildColorRow('Secondary', AppColors.secondary),
            _buildColorRow('Secondary Light', AppColors.secondaryLight),
            _buildColorRow('Secondary Dark', AppColors.secondaryDark),
            const SizedBox(height: AppDimensions.s),
            
            _buildColorRow('Background', AppColors.background),
            _buildColorRow('Surface', AppColors.surface),
            _buildColorRow('Surface Variant', AppColors.surfaceVariant),
            const SizedBox(height: AppDimensions.s),
            
            _buildColorRow('Success', AppColors.success),
            _buildColorRow('Warning', AppColors.warning),
            _buildColorRow('Error', AppColors.error),
            _buildColorRow('Info', AppColors.info),
          ],
        ),
      ),
    );
  }

  Widget _buildColorRow(String name, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppDimensions.xs),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 24,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(AppDimensions.radiusXs),
              border: Border.all(color: Colors.black12),
            ),
          ),
          const SizedBox(width: AppDimensions.m),
          Text(name, style: AppTypography.bodyMedium),
          const Spacer(),
          Text(
            '#${color.value.toRadixString(16).toUpperCase().substring(2)}',
            style: AppTypography.bodySmallSecondary,
          ),
        ],
      ),
    );
  }

  Widget _buildButtonsShowcase() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.m),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: () {},
              child: const Text('Elevated Button'),
            ),
            const SizedBox(height: AppDimensions.m),
            
            OutlinedButton(
              onPressed: () {},
              child: const Text('Outlined Button'),
            ),
            const SizedBox(height: AppDimensions.m),
            
            TextButton(
              onPressed: () {},
              child: const Text('Text Button'),
            ),
            const SizedBox(height: AppDimensions.m),
            
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add),
              label: const Text('Com Ícone'),
            ),
            const SizedBox(height: AppDimensions.m),
            
            ElevatedButton(
              onPressed: null,
              child: const Text('Desabilitado'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputsShowcase() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.m),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TextField(
              decoration: InputDecoration(
                labelText: 'Campo de texto',
                hintText: 'Digite algo aqui',
              ),
            ),
            const SizedBox(height: AppDimensions.m),
            
            const TextField(
              decoration: InputDecoration(
                labelText: 'Com prefixo',
                prefixIcon: Icon(Icons.search),
              ),
            ),
            const SizedBox(height: AppDimensions.m),
            
            const TextField(
              decoration: InputDecoration(
                labelText: 'Com sufixo',
                suffixIcon: Icon(Icons.visibility),
              ),
            ),
            const SizedBox(height: AppDimensions.m),
            
            const TextField(
              decoration: InputDecoration(
                labelText: 'Com erro',
                errorText: 'Mensagem de erro',
              ),
            ),
            const SizedBox(height: AppDimensions.m),
            
            const TextField(
              enabled: false,
              decoration: InputDecoration(
                labelText: 'Desabilitado',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCardsShowcase() {
    return Column(
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(AppDimensions.m),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Card Básico', style: AppTypography.h5),
                const SizedBox(height: AppDimensions.s),
                Text(
                  'Este é um exemplo de card com estilo padrão do tema.',
                  style: AppTypography.bodyMedium,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: AppDimensions.m),
        
        Card(
          elevation: AppDimensions.elevationM,
          child: Padding(
            padding: const EdgeInsets.all(AppDimensions.m),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Card com Elevação Média', style: AppTypography.h5),
                const SizedBox(height: AppDimensions.s),
                Text(
                  'Este card tem uma elevação média para destacar conteúdo importante.',
                  style: AppTypography.bodyMedium,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: AppDimensions.m),
        
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusL),
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppDimensions.m),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Card com Bordas Arredondadas', style: AppTypography.h5),
                const SizedBox(height: AppDimensions.s),
                Text(
                  'Este card tem bordas mais arredondadas para um visual diferenciado.',
                  style: AppTypography.bodyMedium,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
} 