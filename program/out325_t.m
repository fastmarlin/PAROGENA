%% Скрипт для создания Excel-файла ConstructionResults.xlsx
% Очистка командного окна и закрытие предыдущих Excel-серверов (на всякий случай)
% clc;
% clear all; % осторожно: очистит все переменные, лучше использовать clearvars -except res w1 ...
% Но мы предполагаем, что нужные переменные уже загружены в рабочую область.
% Поэтому не используем clear all в финальном скрипте, только clearvars при необходимости.

%% 1. Ручное указание 28 переменных с данными (замените на свои имена)
% Каждая переменная должна быть либо скаляром, либо вектором-строкой.
% Порядок переменных должен соответствовать порядку строк в res.names.
dataVars = {
    S1min;   % данные для первой строки (A3)
    S1;   % данные для второй строки (A4)
    S2;
    n;
    n1;
    n2;
    L_sr;
    L_max;
    L_min;
    L;
    h.h1;
    h.h1;
    h.h2;
    h.h3;
    h.h4;
    h.h5;
    D1;
    D2;
    D;
    deltaD;
    Z_kor;
    b_sv1;
    b_sv2;
    b_dn;
    S1_k;
    S2_k;
    L_cob;
    L_krob    % данные для 28-й строки (A30)
};

%% 2. Проверка существования необходимых переменных
load out325_names.mat
if ~exist('res', 'var') || ~isstruct(res) || ~isfield(res, 'names') || ~isfield(res, 'units')
    error('Переменная "res" (структура с полями names и units) не найдена в рабочей области.');
end
if ~exist('w1', 'var')
    error('Переменная "w1" не найдена в рабочей области.');
end

% Преобразуем res.names и res.units в вертикальные массивы ячеек (если они ещё не такие)
if isstring(res.names)
    namesCell = cellstr(res.names(:));
elseif iscell(res.names)
    namesCell = res.names(:);
else
    error('res.names должен быть строковым массивом или массивом ячеек.');
end

if isstring(res.units)
    unitsCell = cellstr(res.units(:));
elseif iscell(res.units)
    unitsCell = res.units(:);
else
    error('res.units должен быть строковым массивом или массивом ячеек.');
end

numRows = length(namesCell);   % ожидается 28
numW = length(w1);             % количество столбцов с данными

% Проверка соответствия количества переменных количеству строк
if length(dataVars) ~= numRows
    error('Количество переменных в dataVars (%d) не совпадает с количеством строк в res.names (%d).', ...
          length(dataVars), numRows);
end

%% 3. Проверка, открыт ли файл ConstructionResults.xlsx в Excel
fileName = 'ConstructionResults.xlsx';
fullPath = fullfile(pwd, fileName); % абсолютный путь к файлу в текущей папке

% Используем COM-сервер Excel для проверки блокировки файла
excelApp = [];
try
    excelApp = actxserver('Excel.Application');
    excelApp.Visible = false; % работаем в фоне
    
    % Пытаемся открыть файл в режиме только для чтения (ReadOnly = true)
    % Если файл уже открыт другим процессом в монопольном режиме, возникнет ошибка.
    workbook = excelApp.Workbooks.Open(fullPath, 0, true); % 0 - UpdateLinks: не обновлять, true - ReadOnly
    % Если мы дошли сюда, файл существует и не заблокирован монопольно, но возможно открыт кем-то ещё?
    % На самом деле, если файл открыт в Excel с правами на запись, то при попытке открыть его
    % с ReadOnly=true ошибки не будет. Но при попытке записи в файл через writecell позже может возникнуть ошибка.
    % Лучше проверить свойство ReadOnly у книги: если оно false, значит файл не занят на запись.
    if ~workbook.ReadOnly
        % Файл не занят, можно работать
        workbook.Close(false); % закрываем без сохранения
    else
        % Файл открыт кем-то с правами на запись (или защищён от записи на диске)
        workbook.Close(false);
        error('Файл "%s" уже открыт в Excel. Пожалуйста, закройте его и запустите скрипт снова.', fileName);
    end
catch ME
    % Если файл не существует, ошибка при открытии тоже возникнет, но это нормально.
    if contains(ME.message, 'не найден') || contains(ME.message, 'not found')
        % Файла нет — это хорошо, продолжаем
    elseif contains(ME.message, 'отказано в доступе') || contains(ME.message, 'Access Denied') ...
            || contains(ME.message, 'уже используется') || contains(ME.message, 'in use')
        error('Файл "%s" уже открыт в другой программе. Пожалуйста, закройте его и повторите попытку.', fileName);
    else
        % Другие ошибки (например, проблемы с COM)
        warning('Не удалось проверить статус файла через Excel COM: %s', ME.message);
        % Продолжим, но будем готовы к ошибке записи
    end
end

% Закрываем Excel-сервер
if ~isempty(excelApp)
    excelApp.Quit();
    delete(excelApp);
end

%% 4. Формирование данных для записи в Excel
% Определяем размер полной таблицы: строки = numRows + 2 (заголовки), столбцы = 2 + numW
totalRows = numRows + 2;
totalCols = 2 + numW;

% Создаём массив ячеек, заполненный пустыми строками
dataCell = cell(totalRows, totalCols);
dataCell(:) = {''}; % по умолчанию пусто

% Заполняем заголовки
dataCell{1, 3} = 'Скорость теплоносителя, м/с'; % C1
dataCell{2, 1} = 'Величина';                    % A2
dataCell{2, 2} = 'Единица измерения';           % B2

% Заполняем значения w1 в строку 2, начиная с колонки 3 (C)
if numW > 0
    dataCell(2, 3:totalCols) = num2cell(w1);
end

% Заполняем столбцы A и B значениями из res.names и res.units (начиная с 3-й строки)
dataCell(3:end, 1) = namesCell;
dataCell(3:end, 2) = unitsCell;

% Заполняем данные для каждой строки из переменных dataVars
for i = 1:numRows
    currentVar = dataVars{i};
    rowIdx = i + 2;   % номер строки в Excel (3,4,...)
    
    if isscalar(currentVar)
        % Если скаляр, повторяем значение во всех колонках от 3 до totalCols
        dataCell(rowIdx, 3:totalCols) = {currentVar};
    elseif isvector(currentVar) && (isrow(currentVar) || iscolumn(currentVar))
        % Преобразуем в строку, если нужно
        vec = currentVar(:)';  % гарантированно строка
        lenVec = length(vec);
        if lenVec >= numW
            % Берём первые numW элементов
            dataCell(rowIdx, 3:totalCols) = num2cell(vec(1:numW));
        else
            % Заполняем имеющиеся элементы, остальное остаётся пустым
            dataCell(rowIdx, 3:(2+lenVec)) = num2cell(vec);
            % столбцы после (2+lenVec+1) уже пустые по умолчанию
        end
    else
        warning('Переменная №%d не является скаляром или вектором. Пропускаем.', i);
    end
end

%% 5. Запись в Excel-файл с обработкой возможной ошибки блокировки
try
    writecell(dataCell, fileName, 'Sheet', 1, 'Range', 'A1');
    fprintf('Файл "%s" успешно создан.\n', fileName);
catch ME
    if contains(ME.message, 'Access Denied') || contains(ME.message, 'отказано в доступе') ...
            || contains(ME.message, 'in use')
        error('Не удалось записать файл "%s". Возможно, он открыт в Excel. Закройте файл и повторите попытку.', fileName);
    else
        rethrow(ME);
    end
end

% Дополнительно: можно открыть файл для просмотра (опционально)
% winopen(fileName);

% %% 6. Применение числового формата к диапазонам C9:H11 и C22:H22
% try
%     excelApp = actxserver('Excel.Application');
%     excelApp.Visible = false;
%     workbook = excelApp.Workbooks.Open(fullPath);
%     sheet = workbook.Sheets.Item(1);
% 
%     % Установка числового формата (два знака после запятой)
%     range1 = sheet.Range('C9:H11');
%     range2 = sheet.Range('C22:H22');
%     range1.NumberFormat = '0.00';   % Можно заменить на 'General' или '0'
%     range2.NumberFormat = '0.00';
% 
%     workbook.Save();
%     workbook.Close(false);
%     excelApp.Quit();
%     delete(excelApp);
%     fprintf('Числовой формат применён к диапазонам C9:H11 и C22:H22.\n');
% catch ME
%     % Закрываем Excel в случае ошибки
%     try %#ok<TRYNC>
%         workbook.Close(false);
%         excelApp.Quit();
%         delete(excelApp);
%     end
%     error('Ошибка при форматировании Excel: %s', ME.message);
% end