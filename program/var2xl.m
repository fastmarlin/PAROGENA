function var2xl(varargin)
    % Проверка наличия аргументов
    if nargin == 0
        error('Должен быть хотя бы один входной аргумент.');
    end

    % Получаем имена входных переменных
    varNames = cellfun(@inputname, num2cell(1:nargin), 'UniformOutput', false);

    % Проверяем, что все переменные — векторы-столбцы одинаковой длины
    lengths = cellfun(@length, varargin);
    if any(lengths ~= lengths(1))
        error('Все входные векторы должны быть одинаковой длины.');
    end

    % Формируем таблицу
    T = array2table(cell2mat(cellfun(@(x) x(:), varargin, 'UniformOutput', false)), ...
                    'VariableNames', varNames);

    % Запрос имени файла
    [file, path] = uiputfile({'*.xlsx','Excel-файл'}, 'Сохранить как');
    if isequal(file,0) || isequal(path,0)
        return; % Пользователь отменил сохранение
    end

    fullFileName = fullfile(path, file);

    % Сохраняем в зависимости от расширения
    if endsWith(fullFileName, '.csv')
        writetable(T, fullFileName);
    elseif endsWith(fullFileName, '.xlsx')
        writetable(T, fullFileName);
    else
        error('Поддерживаются только форматы .csv и .xlsx');
    end

    disp(['Данные успешно сохранены в файл: ', fullFileName]);

    % Открытие файла в Excel (только для Windows)
if ispc % Проверка, что система Windows
    winopen(fullFileName);
else
    disp('Автоматическое открытие файла поддерживается только в Windows.');
end
end