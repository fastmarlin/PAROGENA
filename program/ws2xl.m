function ws2xl(idx)
%   ws2xl Экспорт переменных из workspace в Excel-файл.
%   exportWorkspaceToExcel(idx) создаёт файл 'workspace_variables.xlsx' с
%   таблицей. Столбец A содержит имена переменных, столбец B – значения.
%   Для массивов (векторов, матриц и т.д.) записывается элемент с индексом idx.
%   Для скаляров, строк и символов записывается само значение.
%
%   Пример:
%       x = 42;
%       y = [10, 20, 30];
%       z = 'Hello';
%       exportWorkspaceToExcel(2);   % для y будет взят элемент y(2) = 20
%
%   Примечание: idx должен быть положительным целым числом.

    % Проверка корректности входного аргумента
    if nargin < 1
        error('Необходимо указать индекс элемента для векторных переменных.');
    end
    if ~isscalar(idx) || ~isnumeric(idx) || idx < 1 || fix(idx) ~= idx
        error('Аргумент idx должен быть положительным целым числом.');
    end

    % Получение списка переменных в базовом workspace
    vars = evalin('base', 'who');
    numVars = length(vars);

    % Предварительное выделение ячеек
    names = cell(numVars, 1);
    values = cell(numVars, 1);

    for i = 1:numVars
        name = vars{i};
        % Чтение значения переменной из base workspace
        val = evalin('base', name);

        % Определение, что записывать в столбец B
        if isnumeric(val) && ~isscalar(val)
            % Числовой нескалярный массив
            if idx <= numel(val)
                valueToWrite = val(idx);
            else
                warning('Индекс %d выходит за пределы размера переменной %s (размер: %s). Записано NaN.', ...
                        idx, name, mat2str(size(val)));
                valueToWrite = NaN;
            end
        elseif isscalar(val) || ischar(val) || isstring(val) || islogical(val)
            % Скаляр (число, логический), строка, символьный массив
            valueToWrite = val;
        else
            % Другие типы: ячейки, структуры, объекты, таблицы и т.д.
            if numel(val) > 1 && idx <= numel(val)
                valueToWrite = val(idx);
            elseif numel(val) == 1
                valueToWrite = val;
            else
                warning('Индекс %d выходит за пределы переменной %s (размер: %s). Записано ''N/A''.', ...
                        idx, name, mat2str(size(val)));
                valueToWrite = 'N/A';
            end
        end

        % Формирование строки для записи (если необходимо преобразование)
        if isnumeric(valueToWrite) || islogical(valueToWrite) || ischar(valueToWrite) || isstring(valueToWrite)
            values{i} = valueToWrite;
        else
            % Для сложных объектов – преобразование в текст
            values{i} = evalc('disp(valueToWrite)');
        end

        names{i} = name;
    end

    % Создание таблицы и запись в Excel
    T = table(names, values, 'VariableNames', {'VariableName', 'Value'});
    filename = 'workspace_variables.xlsx';
    writetable(T, filename);
    fprintf('Переменные экспортированы в файл: %s\n', filename);
end