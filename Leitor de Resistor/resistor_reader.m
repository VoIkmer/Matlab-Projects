% Resistor color reader script
clear;
clc;

% Dicionário de cores para valores e multiplicadores
cores = struct('preto', 0, 'marrom', 1, 'vermelho', 2, 'laranja', 3, ...
               'amarelo', 4, 'verde', 5, 'azul', 6, 'violeta', 7, ...
               'cinza', 8, 'branco', 9, 'dourado', -1, 'prata', -2);

multiplicador = [1, 10, 100, 1e3, 1e4, 1e5, 1e6, 1e7, 1e8, 1e9, 0.1, 0.01];
tolerancia_4faixas = {'marrom', 'vermelho', 'dourado', 'prata'};
tolerancia_valores_4faixas = {'±1%', '±2%', '±5%', '±10%'};
tolerancia_5faixas = {'marrom', 'vermelho', 'verde', 'azul', 'violeta'};
tolerancia_valores_5faixas = {'±1%', '±2%', '±0.5%', '±0.25%', '±0.1%'};

% Escolha do tipo de resistor
num_faixas = input('Quantas faixas tem o resistor (4 ou 5)? ');

% Obtenção das cores conforme o número de faixas
switch num_faixas
    case 4
        faixa1 = input('Digite a cor da primeira faixa: ', 's');
        faixa2 = input('Digite a cor da segunda faixa: ', 's');
        faixa3 = input('Digite a cor da terceira faixa (multiplicador): ', 's');
        faixa4 = input('Digite a cor da quarta faixa (tolerância): ', 's');
        
        % Verificar se as cores são válidas
        if ~isfield(cores, faixa1) || ~isfield(cores, faixa2) || ...
           ~isfield(cores, faixa3) || ~isfield(cores, faixa4)
            error('Uma ou mais cores digitadas são inválidas. Verifique as cores disponíveis.');
        end
        
        % Cálculo do valor do resistor
        valor_base = cores.(faixa1) * 10 + cores.(faixa2);
        valor_resistor = valor_base * multiplicador(cores.(faixa3) + 1);
        tolerancia = tolerancia_valores_4faixas{strcmp(tolerancia_4faixas, faixa4)};
        
        % Output
        cores_faixas = {faixa1, faixa2, faixa3, faixa4};
        valores_faixas = {cores.(faixa1), cores.(faixa2), ...
                          ['10^', num2str(cores.(faixa3))], tolerancia};
        
    case 5
        faixa1 = input('Digite a cor da primeira faixa: ', 's');
        faixa2 = input('Digite a cor da segunda faixa: ', 's');
        faixa3 = input('Digite a cor da terceira faixa: ', 's');
        faixa4 = input('Digite a cor da quarta faixa (multiplicador): ', 's');
        faixa5 = input('Digite a cor da quinta faixa (tolerância): ', 's');
        
        % Verificar se as cores são válidas
        if ~isfield(cores, faixa1) || ~isfield(cores, faixa2) || ...
           ~isfield(cores, faixa3) || ~isfield(cores, faixa4) || ...
           ~isfield(cores, faixa5)
            error('Uma ou mais cores digitadas são inválidas. Verifique as cores disponíveis.');
        end
        
        % Cálculo do valor do resistor
        valor_base = cores.(faixa1) * 100 + cores.(faixa2) * 10 + cores.(faixa3);
        valor_resistor = valor_base * multiplicador(cores.(faixa4) + 1);
        tolerancia = tolerancia_valores_5faixas{strcmp(tolerancia_5faixas, faixa5)};
        
        % Output
        cores_faixas = {faixa1, faixa2, faixa3, faixa4, faixa5};
        valores_faixas = {cores.(faixa1), cores.(faixa2), cores.(faixa3), ...
                          ['10^', num2str(cores.(faixa4))], tolerancia};
        
    otherwise
        disp('Número de faixas inválido. Digite 4 ou 5.');
        return;
end

% Exibir resultado
fprintf('\nValor do resistor: %.2f Ω %s\n', valor_resistor, tolerancia);
disp('Tabela de faixas:');
% Criar tabela com cores e valores
tabela = [cores_faixas; valores_faixas];
disp(tabela);

% Opcional: plotar cores como quadrados
figure;
for i = 1:num_faixas
    subplot(2, num_faixas, i);
    rectangle('Position', [0, 0, 1, 1], 'FaceColor', cores_faixas{i});
    axis off;
    title(cores_faixas{i});
end
for i = 1:num_faixas
    subplot(2, num_faixas, num_faixas + i);
    text(0.5, 0.5, valores_faixas{i}, 'HorizontalAlignment', 'center');
    axis off;
end
