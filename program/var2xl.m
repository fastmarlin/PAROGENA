function var2xl(filename, varargin)
    % Проверка наличия аргументов
    if nargin < 2
        error('Должны быть указаны имя файла и хотя бы один вектор данных.');
    end

    % Получаем имена входных переменных (игнорируем первый аргумент - имя файла)
    varNames = cellfun(@inputname, num2cell(2:nargin), 'UniformOutput', false);

    % Проверяем, что все переменные — векторы-столбцы одинаковой длины
    lengths = cellfun(@length, varargin);
    if any(lengths ~= lengths(1))
        error('Все входные векторы должны быть одинаковой длины.');
    end

    % Формируем таблицу
    T = array2table(cell2mat(cellfun(@(x) x(:), varargin, 'UniformOutput', false)), ...
                    'VariableNames', varNames);

    % Сохраняем в зависимости от расширения
    if endsWith(filename, '.csv')
        writetable(T, filename);
    elseif endsWith(filename, '.xlsx')
        writetable(T, filename);
    else
        error('Поддерживаются только форматы .csv и .xlsx');
    end

    disp(['Данные успешно сохранены в файл: ', filename]);

    % Открытие файла в Excel (только для Windows)
    % if ispc
    %     winopen(filename);
    % else
    %     disp('Автоматическое открытие файла поддерживается только в Windows.');
    % end
end