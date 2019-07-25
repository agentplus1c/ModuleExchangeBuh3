﻿
#Область ГлобальныеПеременные

&НаКлиенте
Перем МодульМТ;  // Общий клиентский модуль со спецификой мобильной торговли

&НаКлиенте
Перем КэшированныеЗначения; //используется механизмом обработки изменения реквизитов ТЧ

// ГлобальныеПеременные
#КонецОбласти

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

// СовместимостьСПлатформой_8_3_5
#КонецОбласти

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	СтррКонтекст = Новый Структура("IDNew,ПрежниеЗначенияСтроки"); // общие значения модуля формы
	СтррКонтекст.Вставить("СпрТоргТочки"); // KT2000_Alcohol_Trade признаки для получения свойств конфигурации и торговых точек
	
	СтррКонтекст.Вставить("РедактироватьРеквизитыМТ", Истина); // признак разрешения редактирования координат
	
	ТекОбъект = РеквизитФормыВЗначение("Объект");		
	ТекОбъект.ИнициализироватьКонтекстФормы(СтррКонтекст, Параметры, "ID"); //dm_180615: ID
	//{{dm_180615
	ТекОбъект.ВОКонтекстФормыДополнить(СтррКонтекст, "*Мерчендайзинг", Ложь);
	ПрочестьОбъектИзХранилища(Параметры.ID);
	ТекОбъект.ВОПриСозданииФормыЭлемента(ЭтотОбъект);
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	//// Загружаем общий клиентский модуль "МодульОбщийМТ". В параметре "Параметры" важно передавать структуру с заполненным
	//// свойством "ВХОбщиеПараметры" - оно используется для предотвращения повторной загрузки текущей обработки.
	//МодульМТ = ПолучитьФорму(СтррКонтекст.ПутьКФорме + "МодульОбщийМТ", СтррКонтекст, ЭтаФорма, "АгентПлюсМодульОбщийМТ"); // в СтррКонтекст есть заполненное свойство "ВХОбщиеПараметры"
	//МодульМТ.ФормаСведенияИзМТРежимРедактированияОбновить(ЭтотОбъект);
	//МодульМТ.ФормаОбновитьАдресПартнера(ЭтотОбъект);
	//
	//Элементы.ГруппаКоманднаяПанель.ЦветФона = СтррКонтекст.Цвета.ФонРаздела;
	//ФормаОбновитьВидимостьЭлементов();
	//{{dm_180618	
	МодульМТ = ПолучитьФорму(СтррКонтекст.ПутьКФорме + "МодульОбщийМТ", СтррКонтекст, ЭтаФорма, "АгентПлюсМодульОбщийМТ"); // в СтррКонтекст есть заполненное свойство "ВХОбщиеПараметры"
	МодульМТ.ВОПриОткрытии(ЭтотОбъект);
	
	ФормаОбновитьЗаголовок();
	ФормаОбновитьВидимостьЭлементов();
	//}}dm_180618
	
КонецПроцедуры

&НаКлиенте
Процедура ПередЗакрытием(Отказ, ЗавершениеРаботы, ТекстПредупреждения, СтандартнаяОбработка)
	
	Если ЭтаФорма.Модифицированность Тогда
		Отказ = Истина;
		Оповещение = Новый ОписаниеОповещения("СохранитьПродолжить", ЭтотОбъект);
		ПоказатьВопрос(Оповещение, НСтр("ru = 'Данные были изменены. Сохранить изменения?'"), РежимДиалогаВопрос.ДаНетОтмена);
	КонецЕсли;
	
КонецПроцедуры

// ОбработчикиСобытийФормы
#КонецОбласти


#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура КомандаВыполнить(Команда)
	
	МодульМТ.КомандаВыполнить(Команда, ЭтотОбъект)
	
КонецПроцедуры

&НаКлиенте
Процедура КомандаСохранить(Команда)
	
	СохранитьОбъектВХранилищеКлиент();
	
КонецПроцедуры

&НаКлиенте
Процедура КомандаПровестиИЗакрыть(Команда)
	
	СохранитьОбъектВХранилищеКлиент(1); // признак Проведен
	Закрыть();
	
КонецПроцедуры

&НаКлиенте
Процедура КомандаПровести(Команда)
	
	СохранитьОбъектВХранилищеКлиент(1); // признак Проведен
	
КонецПроцедуры

&НаКлиенте
Процедура КомандаСправка(Команда)

	ОткрытьФормуОбработки("МодульСправки").ВнешнийВызовОткрытьСправку(ЭтаФорма.ИмяФормы);
	
КонецПроцедуры

#Область ОбработчикиКомандФормы_НавигацияПоФормам

&НаКлиенте
Процедура КомандаПоказатьДокументыМерчендайзинг(Команда)
	
	ОткрытьФормуОбработки("ДокументыМерчендайзинга");
	
КонецПроцедуры

&НаКлиенте
Процедура КомандаПоказатьПартнеров(Команда)
	
	ОткрытьФорму("Справочник." + СтррКонтекст.СпрТоргТочки.ВидСправочника + ".ФормаСписка");
	
КонецПроцедуры

&НаКлиенте
Процедура КомандаПоказатьГлавнуюФорму(Команда)
	
	ОткрытьФормуОбработки("ГлавнаяФорма");
	
КонецПроцедуры

// ОбработчикиКомандФормы_НавигацияПоФормам
#КонецОбласти

// ОбработчикиКомандФормы
#КонецОбласти

#Область ОбработчикиСобытийЭлементовФормы

&НаКлиенте
Процедура ПартнерПриИзменении(Элемент)
	
	МодульМТ.ФормаОбновитьАдресПартнера(ЭтотОбъект);
	
КонецПроцедуры

&НаКлиенте
Процедура КонтрагентПриИзменении(Элемент)
	
	МодульМТ.КонтрагентПриИзменении(ЭтотОбъект, Элемент);	
	
КонецПроцедуры

&НаКлиенте
Процедура ДатаПриИзменении(Элемент)
	
	УстановитьМодифицированостьФормы();
	
КонецПроцедуры

&НаКлиенте
Процедура ОрганизацияПриИзменении(Элемент)
	
	МодульМТ.ОрганизацияПриИзменении(ЭтотОбъект, Элемент);
	
КонецПроцедуры

&НаКлиенте
Процедура ДоговорПриИзменении(Элемент)
	
	МодульМТ.ДоговорПриИзменении(ЭтотОбъект, Элемент);
	
КонецПроцедуры

&НаКлиенте
Процедура ЭлементФормыПриИзменении(Элемент)
	
	УстановитьМодифицированостьФормы();
	
КонецПроцедуры

#Область ОбработчикиСобытийЭлементовФормы_РеквизитыМТ

&НаКлиенте
Процедура ИнфоМТВремяСозданияНажатие(Элемент, СтандартнаяОбработка)
	
	МодульМТ.РеквизитМТПриНажатииСсылки(ЭтотОбъект, Элемент, СтандартнаяОбработка);
	
КонецПроцедуры

&НаКлиенте
Процедура ИнфоМТКоординатыМестаСозданияНажатие(Элемент, СтандартнаяОбработка)
	
	стррРезультат = МодульМТ.РеквизитМТПриНажатииСсылки(ЭтотОбъект, Элемент, СтандартнаяОбработка);
	Если ТипЗнч(стррРезультат) = Тип("Структура") Тогда // нужно показать выбор из меню
	  	ПоказатьВыборИзМеню(стррРезультат.Оповещение, стррРезультат.Меню, Элемент);
	КонецЕсли; 
	
КонецПроцедуры

&НаКлиенте
Процедура ИнфоМТАдресОбъектаНажатие(Элемент, СтандартнаяОбработка)
	
	МодульМТ.РеквизитМТПриНажатииСсылки(ЭтотОбъект, Элемент, СтандартнаяОбработка);
	
КонецПроцедуры

&НаКлиенте
Процедура ЭлементМТСведенияНажатие(Элемент)
	
	стррРезультат = МодульМТ.РеквизитМТПриНажатииСсылки(ЭтотОбъект, Элемент);
	Если ТипЗнч(стррРезультат) = Тип("Структура") Тогда // нужно показать выбор из меню
	  	ПоказатьВыборИзМеню(стррРезультат.Оповещение, стррРезультат.Меню, Элемент);
	КонецЕсли; 
	
КонецПроцедуры

// ОбработчикиСобытийЭлементовФормы_РеквизитыМТ
#КонецОбласти

// ОбработчикиСобытийЭлементовФормы
#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область СлужебныеПроцедурыИФункции_Хранилище

// Процедура считывает объект (документ) из хранилища значений.
&НаСервере
Процедура ПрочестьОбъектИзХранилища(КлючID) 
	
	ТекОбъект = РеквизитФормыВЗначение("Объект");
	
	ID = КлючID;
	стррОбъект = ТекОбъект.ВОЭлементЗагрузить(СтррКонтекст.ВО, ID);
	
	Если стррОбъект = Неопределено Тогда // создание нового документа, заполняем документ значениями по умолчанию

	Иначе
		ТекОбъект.ЗаполнитьРеквизитыОбъектаИзСтруктуры(ЭтотОбъект, стррОбъект);
	КонецЕсли; 
	
КонецПроцедуры

&НаКлиенте
Функция СохранитьОбъектВХранилищеКлиент(НовыйСтатус = Неопределено)
	
	МодульМТ.ВОПередЗаписьюЭлемента(ЭтотОбъект, НовыйСтатус);
	
	СохранитьОбъектВХранилище();
	УстановитьМодифицированостьФормы(Ложь);
	Оповестить("АПДокументЗаписан_" + СтррКонтекст.ВО.ВидОбъекта, ID);
	
	Возврат Истина;
	
КонецФункции

// Процедура сохраняет объект (документ) в хранилище значений.
&НаСервере
Процедура СохранитьОбъектВХранилище()
	
	стрРеквизитыШапкиОсн = "Статус,Дата,Номер,ВремяНачала,ВремяОкончания,Широта,Долгота,АдресПоГеокодеру,Менеджер,Комментарий,ДокументОснование";
	стрРеквизитыШапкиДоп = "Партнер,Контрагент,Соглашение,Организация,Договор,СуммаДокумента";
	стрРеквизитыТЧ		 = "Товары";
	стррОбъект = Новый Структура(стрРеквизитыШапкиОсн + "," + стрРеквизитыШапкиДоп + "," + стрРеквизитыТЧ); // сохраняемые реквизиты объекта
	ЗаполнитьЗначенияСвойств(СтррОбъект, ЭтаФорма,, стрРеквизитыТЧ);
	
	стррОбъект.Товары = Товары.Выгрузить();
	
	РеквизитФормыВЗначение("Объект").ВОЭлементСохранить(СтррКонтекст.ВО, ID, стррОбъект);
	
КонецПроцедуры

&НаКлиенте
Процедура СохранитьПродолжить(РезультатОтвета, ДополнительныеПараметры) Экспорт
	
	Если РезультатОтвета = КодВозвратаДиалога.Да Тогда
		Если СохранитьОбъектВХранилищеКлиент() Тогда
			Закрыть();
		КонецЕсли; 
	ИначеЕсли РезультатОтвета = КодВозвратаДиалога.Нет Тогда
		УстановитьМодифицированостьФормы(Ложь);
		Закрыть();
	КонецЕсли;
	
КонецПроцедуры

// СлужебныеПроцедурыИФункции_Хранилище
#КонецОбласти 

#Область СлужебныеПроцедурыИФункции_РаботаСФормой

&НаКлиенте
Процедура ФормаОбновитьВидимостьЭлементов()
	
	МодульМТ.ФормаСведенияИзМТОбновить(ЭтотОбъект);
	
КонецПроцедуры



&НаКлиенте
Процедура УстановитьМодифицированостьФормы(Режим = Истина) Экспорт
	
	ЭтаФорма.Модифицированность = Режим;
	Элементы.Сохранить.ЦветТекста = СтррКонтекст.Цвета[?(Режим, "ТекстВнимание", "Авто")];
	
КонецПроцедуры

&НаКлиенте
Процедура ФормаОбновитьЗаголовок()
	
	ВсегоСтрок = Товары.Количество();
	
	Если СуммаДокумента = 0 Тогда
		ЭтаФорма.Заголовок = НСтр("ru = 'Мерчендайзинг'");	
	Иначе
		ЭтаФорма.Заголовок = СтрШаблон_(НСтр("ru = 'Мерчендайзинг (Сумма: %1)'"), Формат(СуммаДокумента, "ЧДЦ=2"));
	КонецЕсли; 
	
КонецПроцедуры


// СлужебныеПроцедурыИФункции_РаботаСФормой
#КонецОбласти 

#Область СлужебныеПроцедурыИФункции_Прочие

&НаКлиенте
Функция ОткрытьФормуОбработки(ИмяФормы, стррПараметры = Неопределено, Уникальность = Неопределено, Оповещение = Неопределено)
	
	Если стррПараметры = Неопределено Тогда
		стррПараметры = Новый Структура;
	КонецЕсли; 
	стррПараметры.Вставить("ВХОбщиеПараметры", СтррКонтекст.ВХОбщиеПараметры);
	Возврат ОткрытьФорму(СтррКонтекст.ПутьКФорме + ИмяФормы, стррПараметры, ЭтаФорма, Уникальность,,, Оповещение);
	
КонецФункции

&НаКлиенте
Процедура ТоварыУпаковкаНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	стррПараметры = Новый Структура("Форма","Выбор");
	Оповещение = Новый ОписаниеОповещения("ЗакончитьВыборУпаковки", ЭтаФорма, Элемент);
	ОткрытьФормуОбработки("УпаковкиНоменклатуры", стррПараметры,,Оповещение);
	
	
КонецПроцедуры 

&НаКлиенте
Процедура ЗакончитьВыборУпаковки(Данные, ДопПараметры) Экспорт
	
	Если Данные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	//Конфигурация = ЕИНоменклатуры();
	Если  ДопПараметры.Действие = "Упаковка" Тогда
		Если НЕ Данные.Номенклатура = Элементы.Товары.ТекущиеДанные.Номенклатура Тогда
			Сообщить("Данный вид упаковки: """ + Данные.Наименование + """ не подходит для текущей номенклатуры: """ + Элементы.Товары.ТекущиеДанные.Номенклатура + """!");
			Возврат;
		КонецЕсли;
		Элементы.Товары.ТекущиеДанные.Упаковка = Данные;
		//Если ДопПараметры = "Упаковка" Тогда
		Элементы.Товары.ТекущиеДанные.УпаковкаНаименование = Данные.Наименование + " (1 " + Данные.Наименование + " = " + Строка(Данные.Коэффициент) + " " + Данные.ЕдиницаИзмеренияНоменклатуры + ")";
		Элементы.Товары.ТекущиеДанные.ЗначУпак = 0;
		Количество = Элементы.Товары.ТекущиеДанные.Количество/Данные.Коэффициент;
		Цена = Элементы.Товары.ТекущиеДанные.Цена*Данные.Коэффициент;
		Элементы.Товары.ТекущиеДанные.Количество = ?((Количество > 0) И (Цел(Количество) = Количество), Количество, 0);
		Элементы.Товары.ТекущиеДанные.Цена = ?((Количество > 0) И (Цел(Количество) = Количество), Цена, 0);
		Элементы.Товары.ТекущиеДанные.Сумма = Элементы.Товары.ТекущиеДанные.Цена*Элементы.Товары.ТекущиеДанные.Количество;
	Иначе
		//ЕИНоменклатуры = ЕИНоменклатуры(Элементы.Товары.ТекущиеДанные.Номенклатура);
		Если НЕ Данные = ЕИНоменклатуры(Элементы.Товары.ТекущиеДанные.Номенклатура) Тогда
			Сообщить("Данная единица измерения: """ + Данные + """ не подходит для текущей номенклатуры: """ + Элементы.Товары.ТекущиеДанные.Номенклатура + """!");
			Возврат;
		КонецЕсли;
		Элементы.Товары.ТекущиеДанные.Упаковка = Данные;
		Элементы.Товары.ТекущиеДанные.УпаковкаНаименование = Данные;
		Элементы.Товары.ТекущиеДанные.ЗначУпак = 1;
		Элементы.Товары.ТекущиеДанные.Количество = Элементы.Товары.ТекущиеДанные.Количество * ДопПараметры.Элемент.Коэффициент;
		Элементы.Товары.ТекущиеДанные.Цена = Элементы.Товары.ТекущиеДанные.Цена/ДопПараметры.Элемент.Коэффициент;
		Элементы.Товары.ТекущиеДанные.Сумма = Элементы.Товары.ТекущиеДанные.Цена*Элементы.Товары.ТекущиеДанные.Количество;
	КонецЕсли;
		УстановитьМодифицированостьФормы();
	//КонецЕсли;
	//ДопПараметр
	
КонецПроцедуры

&НаКлиенте
Процедура ТоварыУпаковкаНаименованиеНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	Действия = Новый Структура("Упаковка, Единица, Элемент", "Упаковка", "Единица", Элементы.Товары.ТекущиеДанные.Упаковка);
	СписокКнопок = Новый СписокЗначений;                                                         
	СписокКнопок.Добавить(Действия.Единица, НСтр("ru = 'Классификатор единиц измерения'", "ru"));
	СписокКнопок.Добавить(Действия.Упаковка, НСтр("ru = 'Упаковки номенклатуры'", "ru"));
	СписокКнопок.Добавить(КодВозвратаДиалога.Отмена);
	Оповещение = Новый ОписаниеОповещения(                               
			"ТоварыУпаковкаНаименованиеНачалоВыбораЗавершение", ЭтаФорма, Действия);
	
	ПоказатьВопрос(Оповещение, НСтр("ru = 'Из какого справочника выбрать?'", "ru"), СписокКнопок,,Действия.Упаковка);
	
КонецПроцедуры

&НаКлиенте
Процедура ТоварыУпаковкаНаименованиеНачалоВыбораЗавершение(Результат, Действия) Экспорт
	
	ДопПараметры = Новый Структура("Действие, Элемент", ,Действия.Элемент);  
	Если Результат = Действия.Упаковка Тогда
		стррПараметры = Новый Структура("Форма","Выбор");
		ДопПараметры.Вставить("Действие", Действия.Упаковка);
		Оповещение = Новый ОписаниеОповещения("ЗакончитьВыборУпаковки", ЭтаФорма, ДопПараметры);
		ОткрытьФормуОбработки("УпаковкиНоменклатуры", стррПараметры,,Оповещение);
	ИначеЕсли Результат = Действия.Единица Тогда
		стррПараметры = Новый Структура;
		стррПараметры.Вставить("ВХОбщиеПараметры", СтррКонтекст.ВХОбщиеПараметры);
		ДопПараметры.Вставить("Действие", Действия.Единица);
		Оповещение = Новый ОписаниеОповещения("ЗакончитьВыборУпаковки", ЭтаФорма, ДопПараметры);
		ОткрытьФорму("Справочник.КлассификаторЕдиницИзмерения.ФормаВыбора", стррПараметры, ЭтаФорма,,,,Оповещение);
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Функция ЕИНоменклатуры(ЭлементНоменклатуры)
	
	ТекОбъект = РеквизитФормыВЗначение("Объект");
	стрр = ТекОбъект.ВерсияКонфигурации();
	Возврат ?(стрр.Конфигурация ="Бухгалтерия_RU", ЭлементНоменклатуры.ЕдиницаИзмерения, ЭлементНоменклатуры.БазоваяЕдиницаИзмерения);
	
КонецФункции

&НаСервере
Функция РеквизитыФормы() Экспорт
	
	мРеквизиты = ЭтаФорма.ПолучитьРеквизиты();
	мРеквизитыТЧ = Этаформа.ПолучитьРеквизиты("Товары");
	стррДок = Новый Структура;
	Для Каждого сРеквизит Из мРеквизиты Цикл
		Если сРеквизит.Имя = "Объект" Тогда
			Продолжить;
		КонецЕсли;
		стррДок.Вставить(сРеквизит.Имя,);
	КонецЦикла;
	
	стррДок.Вставить("Товары", Товары);
		
		
	Возврат стррДок;
КонецФункции

&НаКлиенте
Процедура ТоварыКоличествоПриИзменении(Элемент)
	// Вставить содержимое обработчика.
	Элементы.Товары.ТекущиеДанные.Сумма = Элементы.Товары.ТекущиеДанные.Количество*Элементы.Товары.ТекущиеДанные.Цена;
КонецПроцедуры

&НаКлиенте
Процедура ТоварыЦенаПриИзменении(Элемент)
	// Вставить содержимое обработчика.
	Элементы.Товары.ТекущиеДанные.Сумма = Элементы.Товары.ТекущиеДанные.Количество*Элементы.Товары.ТекущиеДанные.Цена;
КонецПроцедуры

// СлужебныеПроцедурыИФункции_Прочие
#КонецОбласти 

// СлужебныеПроцедурыИФункции
#КонецОбласти 
