clc;
clear all;
close all;

% Carregar dados do arquivo .txt
data = load('Sinais de Teste\curva1.txt'); % substitua pelo nome do arquivo

% Verificar se o vetor está transposto e ajustar
if size(data, 2) > 2
    data = data'; % Transpor para garantir 2 colunas
end

% Extrair tempo e amplitude
t = data(:, 1); % tempo
x = data(:, 2); % amplitude do sinal

% Calcular a FFT do sinal
X_fft = fft(x);

% Definir o número de harmônicos desejado para a reconstrução (ajuste manual)
num_harmonicos = floor(length(x) / 2); % Exemplo de número de harmônicos para evitar Gibbs

% Limitar a FFT ao número de harmônicos definido
X_fft(num_harmonicos+1:end-num_harmonicos) = 0;

% Reconstruir o sinal a partir da FFT
x_reconstruido = ifft(X_fft, 'symmetric');

% Calcular Erro Médio Quadrático
erro_mse = mean((x - x_reconstruido).^2);

% Plotar o gráfico de comparação do sinal original e aproximado
figure;
plot(t, x, 'b', 'DisplayName', 'Original');
hold on;
plot(t, x_reconstruido, 'r--', 'DisplayName', 'Aproximado FFT');
title('Comparação do Sinal Original com o Sinal Aproximado');
xlabel('Tempo');
ylabel('Amplitude');
legend;

% Plotar o gráfico do Erro Médio Quadrático (MSE) em nova janela
figure;
plot(t, (x - x_reconstruido).^2, 'g');
title(['Erro Médio Quadrático (MSE): ', num2str(erro_mse)]);
xlabel('Tempo');
ylabel('Erro Quadrático');

% Gerar tabela de coeficientes
coeficientes = table;
coeficientes.an = real(X_fft(1:num_harmonicos));
coeficientes.bn = imag(X_fft(1:num_harmonicos));

disp('Tabela de Coeficientes a_n e b_n:');
disp(coeficientes);
