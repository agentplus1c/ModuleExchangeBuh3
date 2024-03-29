﻿#Область ГлобальныеПеременные

&НаКлиенте
Перем МодульМТ;  // Общий клиентский модуль со спецификой мобильной торговли

// ГлобальныеПеременные
#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура КомандаСправка(Команда)

	ОткрытьФормуОбработки("МодульСправки").ВнешнийВызовОткрытьСправку(ЭтаФорма.ИмяФормы);
	
КонецПроцедуры

#Область ОбработчикиКомандФормы_НавигацияПоФормам

&НаКлиенте
Процедура КомандаПоказатьПартнеров(Команда)
	
	ОткрытьФорму("Справочник." + СтррКонтекст.СпрТоргТочки.ВидСправочника + ".ФормаСписка");
	
КонецПроцедуры

&НаКлиенте
Процедура КомандаПоказатьГлавнуюФорму(Команда)
	
	ОткрытьФормуОбработки("ГлавнаяФорма");
	
КонецПроцедуры

&НаКлиенте
Процедура КомандаВыполнить(Команда)
	
	МодульМТ.КомандаВыполнить(Команда, ЭтотОбъект)
	
КонецПроцедуры

// ОбработчикиКомандФормы_НавигацияПоФормам
#КонецОбласти

// ОбработчикиКомандФормы
#КонецОбласти

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	СтррКонтекст = Новый Структура("НастройкиАгентовРедактируются,ID,ДляВыбора", Ложь);	
	
	СтррКонтекст.Вставить("СпрТоргТочки"); // KT2000_Alcohol_Trade признаки для получения свойств конфигурации и торговых точек
	
	ТекОбъект = РеквизитФормыВЗначение("Объект");		
	ТекОбъект.ИнициализироватьКонтекстФормы(СтррКонтекст, Параметры);
	//{{dm_180618
	ТекОбъект.ВОКонтекстФормыДополнить(СтррКонтекст, "*Мерчендайзинг", Истина);
	
	ПрочестьОбъектИзХранилища();
	//}}dm_180618
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	//Элементы.ГруппаКоманднаяПанель.ЦветФона = СтррКонтекст.Цвета.ФонРаздела;
	//Если СтррКонтекст.ДляВыбора = Истина Тогда
	//	Элементы.ГруппаКоманднаяПанель.Видимость = Ложь;
	//	мСтроки = Объект.ДокМерчендайзинг.НайтиСтроки(Новый Структура("ID", СтррКонтекст.ID));
	//	Если мСтроки.Количество() <> 0 Тогда
	//		Элементы.Документы.ТекущаяСтрока = мСтроки[0].ПолучитьИдентификатор();
	//	КонецЕсли; 
	//КонецЕсли;
	//{{dm_180618
	МодульМТ = ПолучитьФорму(СтррКонтекст.ПутьКФорме + "МодульОбщийМТ", СтррКонтекст, ЭтаФорма, "АгентПлюсМодульОбщийМТ"); // в СтррКонтекст есть заполненное свойство "ВХОбщиеПараметры"
	МодульМТ.ВОПриОткрытии(ЭтотОбъект);		
	//}}dm_180618
	
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)

	Если МодульМТ.ОбработкаОповещенияФормы(ЭтотОбъект, ИмяСобытия, Параметр, Источник) Тогда
	ИначеЕсли ИмяСобытия = "АПДокументЗаписан_" + СтррКонтекст.ВО.ВидОбъекта Тогда // записан новый документ или обновлен существующий
		ПрочестьОбъектИзХранилища();
		МодульМТ.ВОЭлементыВыделить(ЭтотОбъект, Параметр);
	ИначеЕсли ИмяСобытия = "АПЗагруженыНовыеДанныеИзМУ" Тогда // загружены новые данные из МУ
		ПрочестьОбъектИзХранилища();
	КонецЕсли;
	
КонецПроцедуры

// ОбработчикиСобытийФормы
#КонецОбласти

#Область ОбработчикиТаблицыФормыДокументы

&НаКлиенте
Процедура ДокументыПередНачаломДобавления(Элемент, Отказ, Копирование, Родитель, Группа, Параметр)

	Отказ = Истина;
	//ID = ?(Копирование, ДокументТЗПолучитьIDТекущего(), Неопределено);
	//ДокументТЗОткрытьФорму(ID, Копирование);
	//{{dm_180618
	МодульМТ.ВООткрытьФормуИзФормыСписка(ЭтотОбъект, Истина, Копирование);
	//}}dm_180618
	
КонецПроцедуры

&НаКлиенте
Процедура ДокументыПередУдалением(Элемент, Отказ)
	
	МодульМТ.ВОЭлементыПередПометкойУдаления(ЭтотОбъект, Элемент, Отказ);
	
КонецПроцедуры                      	

&НаКлиенте
Процедура ДокументыВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	//Поле1 = Элементы.Документы.ТекущиеДанные;
	
	//Если СтррКонтекст.ДляВыбора = Истина Тогда
	//	//ДокументыВыбратьЗначения(ВыбраннаяСтрока);
	//ИначеЕсли Элемент.ТекущиеДанные <> Неопределено Тогда
	//	ДокументТЗОткрытьФорму(ДокументТЗПолучитьIDТекущего());
	//КонецЕсли;
	//{{dm_180618
	МодульМТ.ВОЭлементыВыбор(ЭтотОбъект);
	//}}dm_180618
КонецПроцедуры

// ОбработчикиТаблицыФормыДокументы
#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область СлужебныеПроцедурыИФункции_Хранилище

&НаСервере
Процедура ПрочестьОбъектИзХранилища() Экспорт

	ТекОбъект = РеквизитФормыВЗначение("Объект");
	
	тз = ТекОбъект.ВОТЗЗагрузить(СтррКонтекст.ВО);
	ТекОбъект[СтррКонтекст.ВО.РеквизитОбработки] = тз;
	
	ЗначениеВРеквизитФормы(ТекОбъект, "Объект");

КонецПроцедуры

// СлужебныеПроцедурыИФункции_Хранилище
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

// СлужебныеПроцедурыИФункции_Прочие
#КонецОбласти

#Область СлужебныеПроцедурыИФункции_ДокументСписка

&НаКлиенте
Процедура ДокументТЗОткрытьФорму(ID = Неопределено, Копирование = Ложь)
	
	Ключ = ?(ID = Неопределено Или Копирование, Новый УникальныйИдентификатор, ID);
	стррПараметры = Новый Структура("ID,Копирование,ВызовИзФормыСписка", ID, Копирование, Истина);
	ОткрытьФормуОбработки("ДокументМерчендайзинг", стррПараметры, Ключ);
	
КонецПроцедуры

&НаКлиенте
Функция ДокументТЗПолучитьIDТекущего()
	
	СтрокаТ = Элементы.Документы.ТекущиеДанные;
	Возврат ?(СтрокаТ <> Неопределено, СтрокаТ.ID, Неопределено);

КонецФункции

&НаКлиенте
Процедура ПриПовторномОткрытии()
	// Вставить содержимое обработчика.
	а=23;
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаПерехода(ОбъектПерехода, СтандартнаяОбработка)
	// Вставить содержимое обработчика.
	а=23;
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаАктивизации(АктивныйОбъект, Источник)
	// Вставить содержимое обработчика.
	а=23;
КонецПроцедуры

// СлужебныеПроцедурыИФункции_ДокументыСписка
#КонецОбласти 

// СлужебныеПроцедурыИФункции
#КонецОбласти 
