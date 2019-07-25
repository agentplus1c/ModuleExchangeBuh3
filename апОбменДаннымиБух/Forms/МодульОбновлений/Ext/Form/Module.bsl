﻿
#Область СовместимостьСПлатформой_8_3_5

// Подставляет параметры в строку. Максимально возможное число параметров - 5.
// Параметры в строке задаются как %<номер параметра>. Нумерация параметров начинается с единицы.
//
// Параметры:
//  СтрокаПодстановки  - Строка - шаблон строки с параметрами (вхождениями вида "%ИмяПараметра");
//  Параметр<n>        - Строка - подставляемый параметр.
//
// Возвращаемое значение:
//  Строка   - текстовая строка с подставленными параметрами.
//
&НаКлиентеНаСервереБезКонтекста
Функция СтрШаблон_(СтрокаПодстановки,
	Параметр1, Параметр2 = Неопределено, Параметр3 = Неопределено, Параметр4 = Неопределено, Параметр5 = Неопределено)
	
	Результат = СтрЗаменить(СтрокаПодстановки, "%1", Параметр1);
	Результат = СтрЗаменить(Результат, "%2", Параметр2);
	Результат = СтрЗаменить(Результат, "%3", Параметр3);
	Результат = СтрЗаменить(Результат, "%4", Параметр4);
	Результат = СтрЗаменить(Результат, "%5", Параметр5);
	
	Возврат Результат;
	
КонецФункции
	
// Разбивает строку на несколько строк по разделителю. Разделитель может иметь любую длину.
//
// Параметры:
//  Строка                 - Строка - текст с разделителями;
//  Разделитель            - Строка - разделитель строк текста, минимум 1 символ;
//  ПропускатьПустыеСтроки - Булево - признак необходимости включения в результат пустых строк.
//    Если параметр не задан, то функция работает в режиме совместимости со своей предыдущей версией:
//     - для разделителя-пробела пустые строки не включаются в результат, для остальных разделителей пустые строки
//       включаются в результат.
//     Е если параметр Строка не содержит значащих символов или не содержит ни одного символа (пустая строка), то в
//       случае разделителя-пробела результатом функции будет массив, содержащий одно значение "" (пустая строка), а
//       при других разделителях результатом функции будет пустой массив.
//  СокращатьНепечатаемыеСимволы - Булево - сокращать непечатаемые символы по краям каждой из найденных подстрок.
//
// Возвращаемое значение:
//  Массив - массив строк.
&НаКлиентеНаСервереБезКонтекста 
Функция СтрРазделить_(Знач Строка, Знач Разделитель = ",", Знач ПропускатьПустыеСтроки = Неопределено, СокращатьНепечатаемыеСимволы = Ложь)
	
	Результат = Новый Массив;
	
	// Для обеспечения обратной совместимости.
	Если ПропускатьПустыеСтроки = Неопределено Тогда
		ПропускатьПустыеСтроки = ?(Разделитель = " ", Истина, Ложь);
		Если ПустаяСтрока(Строка) Тогда 
			Если Разделитель = " " Тогда
				Результат.Добавить("");
			КонецЕсли;
			Возврат Результат;
		КонецЕсли;
	КонецЕсли;
	//
	
	Позиция = Найти(Строка, Разделитель);
	Пока Позиция > 0 Цикл
		Подстрока = Лев(Строка, Позиция - 1);
		Если Не ПропускатьПустыеСтроки Или Не ПустаяСтрока(Подстрока) Тогда
			Если СокращатьНепечатаемыеСимволы Тогда
				Результат.Добавить(СокрЛП(Подстрока));
			Иначе
				Результат.Добавить(Подстрока);
			КонецЕсли;
		КонецЕсли;
		Строка = Сред(Строка, Позиция + СтрДлина(Разделитель));
		Позиция = Найти(Строка, Разделитель);
	КонецЦикла;
	
	Если Не ПропускатьПустыеСтроки Или Не ПустаяСтрока(Строка) Тогда
		Если СокращатьНепечатаемыеСимволы Тогда
			Результат.Добавить(СокрЛП(Строка));
		Иначе
			Результат.Добавить(Строка);
		КонецЕсли;
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции

///  Объединяет строки из массива в строку с разделителями.
//
// Параметры:
//  Массив      - Массив - массив строк которые необходимо объединить в одну строку;
//  Разделитель - Строка - любой набор символов, который будет использован в качестве разделителя.
//
// Возвращаемое значение:
//  Строка - строка с разделителями.
// 
&НаКлиентеНаСервереБезКонтекста 
Функция СтрСоединить_(Массив, Разделитель = ",", СокращатьНепечатаемыеСимволы = Ложь)

	Результат = "";
	ТекРазделитель = "";
	
	Для Индекс = 0 По Массив.ВГраница() Цикл
		
		Подстрока = Массив[Индекс];
		
		Если СокращатьНепечатаемыеСимволы Тогда
			Подстрока = СокрЛП(Подстрока);
		КонецЕсли;
		
		Если ТипЗнч(Подстрока) <> Тип("Строка") Тогда
			Подстрока = Строка(Подстрока);
		КонецЕсли;
		
		Результат = Результат + ТекРазделитель + Подстрока;
		
		Если Индекс = 0 Тогда
			ТекРазделитель = Разделитель;
		КонецЕсли;
		
	КонецЦикла;
	
	Возврат Результат;

КонецФункции

// СовместимостьСПлатформой_8_3_5
#КонецОбласти

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	СтррКонтекст = Новый Структура("Версия,ВерсияНастроек"); // Версия - текущая версия обработки, ВерсияНастроек - версия сохраненных настроек
	
КонецПроцедуры

&НаСервере
Функция ТребуетсяОбновитьДоВерсии(ВерсияОбновления, ИзменитьНастройки = Неопределено)
	
	Если ОбщегоНазначенияКлиентСервер.СравнитьВерсии(ВерсияОбновления, СтррКонтекст.Версия)  > 0 Тогда
		Возврат Ложь; // требуется обновиться до более новой версии, о которой модуль не знает
	ИначеЕсли ОбщегоНазначенияКлиентСервер.СравнитьВерсии(ВерсияОбновления, СтррКонтекст.ВерсияНастроек)  < 0 Тогда
		Возврат Ложь; // сохранены настройки от более новой версии обработки, чем запущена в данный момент
	Иначе
		ИзменитьНастройки = Истина;
		Возврат Истина; // требуется обновить настройки до более новой версии
	КонецЕсли;
		
КонецФункции

&НаКлиенте
Функция ИнициализироватьДанныеВХранилищеДляНовойВерсииКлиент(СтараяВерсия, НоваяВерсия) Экспорт
	
	СтррКонтекст.ВерсияНастроек = СтараяВерсия;
	СтррКонтекст.Версия 		= НоваяВерсия;
	
	ИнициализироватьДанныеВХранилищеДляНовойВерсии();
	
	
	Если Не ПустаяСтрока(СтараяВерсия) Тогда
		ТекстРезультат = СтрШаблон_(НСтр("ru = 'Обновлены настройки с версии %1 до версии %2.'"), СтараяВерсия, НоваяВерсия);
	Иначе
		ТекстРезультат = "";//СтрШаблон_(НСтр("ru = 'Инициализированы настройки для версии %1.'"), НоваяВерсия);
	КонецЕсли;

	Возврат ТекстРезультат;
	
КонецФункции	

&НаСервере
Процедура ИнициализироватьДанныеВХранилищеДляНовойВерсии()
	// в реквизите Объект.ВерсияМодуля содержится прежняя версия
	
	стррЗначения = Новый Структура;
	ИзменитьНастройки = Ложь;
	
	ТекОбъект = РеквизитФормыВЗначение("Объект");
	
	ЭтоПервыйЗапуск = ПустаяСтрока(СтррКонтекст.ВерсияНастроек);
	
	Если ЭтоПервыйЗапуск Тогда // первый запуск
		
		ИнициализироватьМодульДляПервогоЗапуска(ТекОбъект);
		стррЗначения.Вставить("СпособРасчетаПросроченныхДолгов", "НеУчитывать");
		
		//++Дейнеко ВГ 2017-09-29 Ратмир
		РежимЗагрузкиЗаказов = "ЗагружатьКакЗаказ";
		//Замена
		//РежимЗагрузкиЗаказов = ?(Константы.ИспользоватьЗаказыКлиентов.Получить(), "ЗагружатьКакЗаказ", "ЗагружатьКакРеализацию");
		//--Дейнеко ВГ 2017-09-29 Ратмир
		
		стррЗначения.Вставить("РежимЗагрузкиЗаказов", РежимЗагрузкиЗаказов);
		
		стррЗначения.Вставить("ПодтвержденияТолькоДляПроведенных", Истина);
		стррЗначения.Вставить("ОтветнаяВыгрузка", Истина);
		
		стррЗначения.Вставить("ВыгружатьМаршруты", Истина);		
		стррЗначения.Вставить("ИнтервалВыгрузкиМаршрутов", 7);
		
		стррЗначения.Вставить("РегистрОстатковТоваров", "СвободныеОстатки");
		
		//++Дейнеко ВГ 2017-09-29 Ратмир
		стррЗначения.Вставить("ИспользоватьХарактеристики", Ложь);
		//Замена
		//стррЗначения.Вставить("СтатусЗаказовКлиентов", Перечисления.СтатусыЗаказовКлиентов.НеСогласован);
		//
		//Если Константы.ИспользоватьСоглашенияСКлиентами.Получить() Тогда
		//	стррЗначения.Вставить("ИспользоватьСоглашения", Истина);
		//КонецЕсли; 
		//
		//Если Константы.ИспользоватьХарактеристикиНоменклатуры.Получить() Тогда
		//	стррЗначения.Вставить("ИспользоватьХарактеристики", Истина);
		//КонецЕсли;
		//--Дейнеко ВГ 2017-09-29 Ратмир
	
	КонецЕсли;
	Если ТребуетсяОбновитьДоВерсии("1.0.0.23", ИзменитьНастройки) Тогда
		стррЗначения.Вставить("ИнтервалАвтообмена", 180);
	КонецЕсли;
	
	Если ТребуетсяОбновитьДоВерсии("1.0.0.29", ИзменитьНастройки) Тогда
		ТекОбъект.УдалитьПодтвержденияДокументов();
	КонецЕсли;
	
	Если ТребуетсяОбновитьДоВерсии("1.0.0.31", ИзменитьНастройки) Тогда
		ОбновитьВидыДокументовИСправочниковВХранилище(ТекОбъект, стррЗначения);
	КонецЕсли;
	
	Если ТребуетсяОбновитьДоВерсии("1.0.0.32", ИзменитьНастройки) Тогда
		// изменен тип значения реквизита "СОДПорт" со "Строка" на "Число"
		СОДПорт = ТекОбъект.ПрочитатьЗначениеНастройки("СОДПорт");
		Если ТипЗнч(СОДПорт) = Тип("Строка") Тогда
			НовоеЗначение = СтрокуВЧисло(СОДПорт);
		ИначеЕсли ТипЗнч(СОДПорт) = Тип("Число") Тогда
			НовоеЗначение = СОДПорт;
		Иначе
			НовоеЗначение = 0;
		КонецЕсли; 
		Если НовоеЗначение <> СОДПорт Тогда
			стррЗначения.Вставить("СОДПорт", НовоеЗначение);
		КонецЕсли; 
	КонецЕсли;
	
	Если ТребуетсяОбновитьДоВерсии("1.0.0.33", ИзменитьНастройки) Тогда
		// заменено название реквизита "ЛКИдентификатор" на "ЛКЛогин"
		НовоеЗначение = ТекОбъект.ПрочитатьЗначениеНастройки("ЛКИдентификатор");
		Если НовоеЗначение <> Неопределено Тогда
			стррЗначения.Вставить("ЛКЛогин", НовоеЗначение);
		КонецЕсли;
	КонецЕсли;
	
	Если ТребуетсяОбновитьДоВерсии("1.0.0.34", ИзменитьНастройки) Тогда
		// добавлен новый реквизит "ЛКЗапомнитьЛогинИПароль"
		ЛКЛогин = ТекОбъект.ПрочитатьЗначениеНастройки("ЛКЛогин");
		Если Не ПустаяСтрока(ЛКЛогин) Тогда
			стррЗначения.Вставить("ЛКЗапомнитьЛогинИПароль", Истина);
		КонецЕсли;
	КонецЕсли;
	
	Если Не ЭтоПервыйЗапуск И ТребуетсяОбновитьДоВерсии("1.0.0.54") Тогда
		// появился новый доп. реквизит справочника Партнеры - ИмяСвойстваАдресИзСервисаПартнер()
		ТекОбъект.СоздатьДополнительныеРеквизитыСправочников(); 
	КонецЕсли;
	
	Если Не ЭтоПервыйЗапуск И ТребуетсяОбновитьДоВерсии("1.0.1.27") Тогда
		// появились новые доп. сведения документов - ИмяСвойстваДокументВремяНачала() и ИмяСвойстваДокументВремяОкончания().
		ТекОбъект.СоздатьДополнительныеРеквизитыДокументов(); 
	КонецЕсли;
	
	Если ТребуетсяОбновитьДоВерсии("1.0.1.35", ИзменитьНастройки) Тогда 
		стррЗначения.Вставить("ПоказыватьАдресКоординат", Истина);
	//{{dm_180423
		ТекОбъект.СоздатьДополнительныеРеквизитыСправочников();
		ТекОбъект.СоздатьДополнительныеРеквизитыДокументов();
	//}}dm_180423
	КонецЕсли;
	
	Если ИзменитьНастройки Или ТекОбъект.ВерсияНастроек <> СтррКонтекст.Версия Тогда
		стррЗначения.Вставить("ВерсияНастроек", СтррКонтекст.Версия); // обязательно записываем новую версию в настройки
		ТекОбъект.СохранитьЗначенияНастроекИзСтруктуры(стррЗначения);
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ИнициализироватьМодульДляПервогоЗапуска(ТекОбъект)
	//{{dm_180423
	//Если НЕ ТекОбъект.Конфигурация("Бухгалтерия_KZ") Тогда
		ТекОбъект.СоздатьДополнительныеРеквизитыСправочников();
		ТекОбъект.СоздатьДополнительныеРеквизитыДокументов();
	//КонецЕсли;
	//}}dm_180423
	ТекОбъект.ПолучитьГруппуПользователейТорговыеАгенты();
	
КонецПроцедуры

// Процедура удаляет из значений атрибутов обработки СписокОчищаемыхДокументов и СписокОчищаемыхСправочников
// несуществующие виды документов и справочников, которые могли остаться от прежних версий обработки.
&НаСервере
Процедура ОбновитьВидыДокументовИСправочниковВХранилище(ТекОбъект, СтррЗначения)
	
	СтррСписки = ТекОбъект.ПрочитатьЗначенияНастроек("СписокОчищаемыхДокументов,СписокОчищаемыхСправочников");
	
	Для Каждого ЭлементСтруктуры Из СтррСписки Цикл
		
		Если ЭлементСтруктуры.Значение = Неопределено Тогда // значение может отсутствовать в хранилище
			Продолжить;
		КонецЕсли;
		
		СписокВсех = ТекОбъект.ПолучитьВсеВидыОбъектовДляМУ(?(ЭлементСтруктуры.Ключ = "СписокОчищаемыхДокументов", "Документ", "Справочник"));
		мУдаляемыеЭлементы = Новый Массив;
		СписокПроверки = ЭлементСтруктуры.Значение;
		Для Каждого Элемент Из СписокПроверки Цикл
			Если СписокВсех.НайтиПоЗначению(Элемент.Значение) = Неопределено Тогда
				мУдаляемыеЭлементы.Добавить(Элемент);
			КонецЕсли;
		КонецЦикла;
		
		Для Каждого Элемент Из мУдаляемыеЭлементы Цикл
			СписокПроверки.Удалить(Элемент);
		КонецЦикла;
		
		Если мУдаляемыеЭлементы.Количество() <> 0 Тогда
			СтррЗначения.Вставить(ЭлементСтруктуры.Ключ, СписокПроверки);
		КонецЕсли;
		
	КонецЦикла;
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста 
Функция СтрокуВЧисло(Строка)
	
	СтрРезультат = "";
	
	БылаТочка = Ложь;
	Для Поз = 1 По СтрДлина(Строка) Цикл
		Символ = Сред(Строка, Поз, 1);
		Код = КодСимвола(Символ);
		Если Код >= 48 И Код <= 57 Или Код = 46 Тогда
			СтрРезультат = СтрРезультат + Символ;
		ИначеЕсли Не БылаТочка И Код = 46 Тогда
			СтрРезультат = СтрРезультат + Символ;
			БылаТочка = Истина;
		КонецЕсли;
	КонецЦикла;
	
	Если БылаТочка Тогда
		СтрРезультат = "0" + СтрРезультат + "0"; // чтобы корректно обработалось число вида ".x" или "x."
	КонецЕсли; 
	
	Возврат ?(СтрДлина(СтрРезультат) = 0, 0, Число(СтрРезультат));
	
КонецФункции
