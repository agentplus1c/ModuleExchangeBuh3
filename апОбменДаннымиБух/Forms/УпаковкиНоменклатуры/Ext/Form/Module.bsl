﻿#Область ОписаниеПеременных
&НаКлиенте
Перем гНаименование;
&НаКлиенте
Перем гНоменклатура;
&НаКлиенте
Перем ВыбранаГруппа;
#КонецОбласти

//&НаКлиенте
//Процедура УпаковкиНоменклатурыНоменклатураОбработкаВыбора(Элемент, ВыбранноеЗначение, СтандартнаяОбработка)
//	// Вставить содержимое обработчика.
//	АБВ = ВыбранноеЗначение; //.ЕдиницаИзмерения;
//	ПриИзмНоменкл(АБВ);	
//КонецПроцедуры

&НаСервере
Процедура ПриИзмНоменкл(АБВ)
	
	Элем = Справочники.Номенклатура.НайтиПоНаименованию(Строка(АБВ)).ЕдиницаИзмерения;
	
КонецПроцедуры


&НаКлиенте
Процедура УпаковкиНоменклатурыОбработкаВыбора(Элемент, ВыбранноеЗначение, СтандартнаяОбработка)
	// Вставить содержимое обработчика.
	АБВ = ВыбранноеЗначение;
КонецПроцедуры


&НаКлиенте
Процедура УпаковкиНоменклатурыПриИзменении(Элемент)
	// Вставить содержимое обработчика.
	
	//в=1;
	//ЭтаФорма.Модифицированность = Истина;
	//Элемент.ТекущиеДанные.Код = Элемент.ТекущаяСтрока + 1;
	//
	//Если Элемент.ТекущийЭлемент.Имя = "УпаковкиНоменклатурыНоменклатура" Тогда
	//	Ед = ПолучитьЕИ(Элемент.ТекущиеДанные.Номенклатура);
	//	Элемент.ТекущиеДанные.ЕдиницаИзмеренияНоменклатуры = Ед;
	//КонецЕсли;
	//ОбновитьОформлениеЭлементов();
	
КонецПроцедуры

&НаСервере
Функция ПолучитьЕИ(Данные)
	ТекОбъект = РеквизитФормыВЗначение("Объект");
	Конфиг = ТекОбъект.ВерсияКонфигурации();
	гКонфигурация = Конфиг.Конфигурация;
	Возврат ?(гКонфигурация = "Бухгалтерия_KZ", Данные.БазоваяЕдиницаИзмерения, Данные.ЕдиницаИзмерения);
КонецФункции

&НаСервере
Процедура СохранитьСправочникНаСервере()
	// Вставить содержимое обработчика.
	ТекОбъект = реквизитФормыВЗначение("Объект");
	Таб = Объект.УпаковкиНоменклатуры.Выгрузить();
	ТекОбъект.СохранитьЗначениеНастройки("УпаковкиНоменклатуры", Таб);
	
	
	
	
КонецПроцедуры

&НаКлиенте
Процедура СохранитьСправочник(Команда)
	
	Если ПроверитьЗаполнениеПолей() Тогда
		СохранитьСправочникНаСервере();
		ЭтаФорма.Модифицированность = Ложь;
		ОбновитьОформлениеЭлементов();
	Иначе
		Сообщить("В справочнике есть незаполненные значения. Сохранение отменено.");
		Возврат;
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Функция ПроверитьЗаполнениеПолей()
	
	Для Каждого СтрокаТ Из Объект.УпаковкиНоменклатуры Цикл
		Если НЕ ЗначениеЗаполнено(СтрокаТ.Номенклатура)
			ИЛИ НЕ ЗначениеЗаполнено(СтрокаТ.Наименование)
			ИЛИ НЕ ЗначениеЗаполнено(СтрокаТ.Коэффициент)
			ИЛИ НЕ ЗначениеЗаполнено(СтрокаТ.ЕдиницаИзмеренияНоменклатуры) Тогда
			
			Возврат Ложь;
		КонецЕсли;
	КонецЦикла;
	
	Возврат Истина;
КонецФункции

&НаКлиенте
Процедура ЗаблокироватьДоступ()
	
	//Для Каждого СтрокаТ Из Элементы.УпаковкиНоменклатуры.ПодчиненныеЭлементы Цикл
	КЦ = Объект.УпаковкиНоменклатуры.Количество();
	
	Для Сч = 0 По КЦ-1 Цикл
		Элементы.УпаковкиНоменклатуры.ТекущаяСтрока = Сч;
		//Элементы.УпаковкиНоменклатуры.ПодчиненныеЭлементы.УпаковкиНоменклатурыЕдиницаИзмеренияНоменклатуры.ТолькоПросмотр = Истина;
		//Элементы.УпаковкиНоменклатуры.ПодчиненныеЭлементы.УпаковкиНоменклатурыКоэффициент.ТолькоПросмотр = Истина;
		//Элементы.УпаковкиНоменклатуры.ПодчиненныеЭлементы.УпаковкиНоменклатурыНаименование.ТолькоПросмотр = Истина;
		//Элементы.УпаковкиНоменклатуры.ПодчиненныеЭлементы.УпаковкиНоменклатурыНоменклатура.ТолькоПросмотр = Истина;
		Для Каждого СтрокаТ Из Элементы.УпаковкиНоменклатуры.ВыделенныеСтроки Цикл
			СтрДанные = Элементы.УпаковкиНоменклатуры.ДанныеСтроки(СтрокаТ);
			
			//Элем = 
		КонецЦикла;
		
		  //Стр = Элементы.УпаковкиНоменклатуры.ТекущиеДанные;
		  
	КонецЦикла;
	
	
КонецПроцедуры	
	



&НаСервере
Процедура ОбновитьОформлениеЭлементов()
	//ЦветаСтиля = Новый Цвет();
	//Если МодифицированностьФормы Тогда
	Если ЭтаФорма.Модифицированность Тогда
		Элементы.СохранитьСправочник.ЦветТекста = ЦветаСтиля.ЦветОсобогоТекста;
	Иначе
		Элементы.СохранитьСправочник.ЦветТекста = ЦветаСтиля.ЦветТекстаКнопки;
	КонецЕсли;
КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	// Вставить содержимое обработчика.
	
	//(( dm_180313 Инициализация справочника УпаковкиНоменклатуры
	ТекОбъект = РеквизитФормыВЗначение("Объект");
	Попытка
		Таб = ТекОбъект.ПрочитатьЗначениеНастройки("УпаковкиНоменклатуры");
		Объект.УпаковкиНоменклатуры.Загрузить(Таб);
	Исключение
	КонецПопытки;
	//)) dm_180313
	Парам = ЭтаФорма.Параметры;
	Если Парам.Свойство("Форма") Тогда
		стррПараметры = Парам.Форма;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	// Вставить содержимое обработчика.
	Если стррПараметры = "Выбор" Тогда
		Элементы.МояКоманднаяПанель.Видимость = Ложь;
		Элементы.КоманднаяПанельВыбора.Видимость  = Истина;
		Элементы.КоманднаяПанельВыбора.ПодчиненныеЭлементы.Выбрать.КнопкаПоУмолчанию = Истина;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПередЗакрытием(Отказ, ЗавершениеРаботы, ТекстПредупреждения, СтандартнаяОбработка)

	Если ЭтаФорма.Модифицированность Тогда
		Отказ = Истина;
		Оповещение = Новый ОписаниеОповещения("СохранитьПродолжить", ЭтотОбъект);
		ПоказатьВопрос(Оповещение, НСтр("ru = 'Данные были изменены. Сохранить изменения?'"), РежимДиалогаВопрос.ДаНетОтмена);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура СохранитьПродолжить(РезультатОтвета, ДополнительныеПараметры) Экспорт
	
	Если РезультатОтвета = КодВозвратаДиалога.Да Тогда
		Если ПроверитьЗаполнениеПолей() Тогда
			СохранитьСправочникНаСервере();
			ЭтаФорма.Модифицированность = Ложь;
			ОбновитьОформлениеЭлементов();
			Закрыть();
		Иначе
			Сообщить("В справочнике есть незаполненные значения. Сохранение отменено.");
			Возврат;
		КонецЕсли;
	ИначеЕсли РезультатОтвета = КодВозвратаДиалога.Нет Тогда
		ЭтаФорма.Модифицированность = Ложь;
		ОбновитьОформлениеЭлементов();
		Закрыть();
	КонецЕсли;
	
КонецПроцедуры


&НаСервере 
Функция ПолучитьКонфигурацию()
	ТекОбъект = РеквизитФормыВЗначение("Объект");
	Конфиг = ТекОбъект.ВерсияКонфигурации();
	Возврат Конфиг.Конфигурация;
КонецФункции

&НаКлиенте
Процедура УпаковкиНоменклатурыНоменклатураПриИзменении(Элемент)
	// Вставить содержимое обработчика.
	А = Элемент;
	//Элемент = Элементы.УпаковкиНоменклатурыНоменклатура;
	//Возврат;
	в=1;
	ЭтаФорма.Модифицированность = Истина;
	Если НЕ ЗначениеЗаполнено(Элемент.Родитель.ТекущиеДанные.Код) Тогда
		Элемент.Родитель.ТекущиеДанные.Код = Элемент.Родитель.ТекущаяСтрока + 1;
	КонецЕсли;
	
	//Если НЕ ЗначениеЗаполнено(Элемент.Родитель.ТекущиеДанные.УникальныйИдентификатор) Тогда
	//	 Элемент.Родитель.ТекущиеДанные.УникальныйИдентификатор = Новый УникальныйИдентификатор();
	//КонецЕсли;
	Если ВыбранаГруппа Тогда
		ПоказатьПредупреждение(,"Выбранный элемент """ + Элемент.Родитель.ТекущиеДанные.Номенклатура + """ является группой. Выберите другой.");
		Элемент.Родитель.ТекущиеДанные.Номенклатура = гНоменклатура;
		ЭтаФорма.Модифицированность = Ложь;
		Возврат;
	КонецЕсли;
	
	Если Элемент.Имя = "УпаковкиНоменклатурыНоменклатура" Тогда
		Ед = ПолучитьЕИ(Элемент.Родитель.ТекущиеДанные.Номенклатура);
		Элемент.Родитель.ТекущиеДанные.ЕдиницаИзмеренияНоменклатуры = Ед;
	КонецЕсли;
	ОбновитьОформлениеЭлементов();
	
	
КонецПроцедуры


&НаКлиенте
Процедура УпаковкиНоменклатурыНаименованиеПриИзменении(Элемент)

	ЭтаФорма.Модифицированность = Истина;
	Если НЕ ЗначениеЗаполнено(Элемент.Родитель.ТекущиеДанные.УникальныйИдентификатор) ИЛИ НЕ Элемент.Родитель.ТекущиеДанные.Наименование = гНаименование Тогда
		 Элемент.Родитель.ТекущиеДанные.УникальныйИдентификатор = Новый УникальныйИдентификатор();
	КонецЕсли;
	ОбновитьОформлениеЭлементов();
	
КонецПроцедуры


&НаКлиенте
Процедура УпаковкиНоменклатурыПередНачаломИзменения(Элемент, Отказ)
	// Вставить содержимое обработчика.
	гНаименование = Элемент.ТекущиеДанные.Наименование;	
	гНоменклатура = Элемент.ТекущиеДанные.Номенклатура;
	
КонецПроцедуры


&НаКлиенте
Процедура УпаковкиНоменклатурыКоэффициентПриИзменении(Элемент)
	// Вставить содержимое обработчика.
	ЭтаФорма.Модифицированность = Истина;
	ОбновитьОформлениеЭлементов();
КонецПроцедуры




&НаКлиенте
Процедура УпаковкиНоменклатурыПередУдалением(Элемент, Отказ)
	// Вставить содержимое обработчика.
 ка = 1;	
//Отказ = Истина;
КонецПроцедуры

&НаКлиенте
Процедура УпаковкиНоменклатурыНоменклатураОбработкаВыбора(Элемент, ВыбранноеЗначение, СтандартнаяОбработка)
	
	ВыбранаГруппа = ЭтоГруппа(ВыбранноеЗначение);
	
КонецПроцедуры

&НаСервере
Функция ЭтоГруппа(ВыбранноеЗначение)
	
	Возврат ВыбранноеЗначение.ЭтоГруппа;
	
КонецФункции

&НаКлиенте
Процедура УпаковкиНоменклатурыПередНачаломДобавления(Элемент, Отказ, Копирование, Родитель, Группа, Параметр)
	// Вставить содержимое обработчика.
	Отказ = Копирование;
	
	
КонецПроцедуры


&НаКлиенте
Процедура ДобавитьЭлемент(Команда)
	// Вставить содержимое обработчика.
	стррПараметры = Новый Структура;
	Оповещение = Новый ОписаниеОповещения("ДобавитьЭлементПродолжить", ЭтотОбъект);
	ИмяФормыЭлемента = ПолучитьИмяФормыНаСервере();
	ОткрытьФорму(ИмяФормыЭлемента,,ЭтаФорма,,,,Оповещение);	
КонецПроцедуры
	
&НаСервере
Функция ПолучитьИмяФормыНаСервере()
	
	ТекОбъект = РеквизитФормыВЗначение("Объект");
	Возврат ТекОбъект.ПолучитьИмяФормы("УпаковкаНоменклатуры");
	
КонецФункции

&НаСервере
Процедура ДобавитьЭлементПродолжить(Результат, ДополнительныеПараметры) Экспорт
	
	Если НЕ Результат = Неопределено Тогда
		//ЭтаФорма.Модифицированность = Истина;
		//ОбновитьОформлениеЭлементов();    
		Таб = Объект.УпаковкиНоменклатуры.Выгрузить();
		Таб1 = Таб.Скопировать();
		Таб1.Сортировать("Код Убыв");
		Код = ?(Таб1.Количество() >0, Таб1[0].Код + 1, 1);
		ЕдиницаИзмеренияНоменклатуры =  ПолучитьЕИ(Результат.Номенклатура);
		НоваяСтрока = Таб.Добавить();
		НоваяСтрока.Наименование = Результат.Наименование;
		НоваяСтрока.Номенклатура = Результат.Номенклатура;
	    НоваяСтрока.Коэффициент = Результат.Коэффициент;
	    НоваяСтрока.Код = Код;
	    НоваяСтрока.ЕдиницаИзмеренияНоменклатуры = ЕдиницаИзмеренияНоменклатуры;
		НоваяСтрока.УникальныйИдентификатор = Новый УникальныйИдентификатор;
		Объект.УпаковкиНоменклатуры.Загрузить(Таб);
		ТекОбъект = реквизитФормыВЗначение("Объект");
		ТекОбъект.СохранитьЗначениеНастройки("УпаковкиНоменклатуры", Таб);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура УдалитьПомеченные(Команда)
    УдалитьПомеченныеОбъекты();
КонецПроцедуры

&НаСервере
Процедура УдалитьПомеченныеОбъекты()
	
	//ЭтаФорма.Модифицированность = Истина;
	//ОбновитьОформлениеЭлементов();    
	Таб = Объект.УпаковкиНоменклатуры.Выгрузить();
	//Отбор = Новый Структура("ПометкаУдаления", Истина);
	Отбор = Новый Структура("ПометкаУдаления", 1);
	НаУдаление = Таб.НайтиСтроки(Отбор);
	Для Каждого СтрокаТаб Из НаУдаление Цикл
		Таб.Удалить(СтрокаТаб);
	КонецЦикла;
	Объект.УпаковкиНоменклатуры.Загрузить(Таб);
	ТекОбъект = реквизитФормыВЗначение("Объект");
	ТекОбъект.СохранитьЗначениеНастройки("УпаковкиНоменклатуры", Таб);
	
КонецПроцедуры

&НаСервере
Процедура УпаковкиНоменклатурыПометкаУдаленияПриИзмененииНаСервере()
	
	Таб = Объект.УпаковкиНоменклатуры.Выгрузить();
	ТекОбъект = реквизитФормыВЗначение("Объект");
	ТекОбъект.СохранитьЗначениеНастройки("УпаковкиНоменклатуры", Таб);
	
КонецПроцедуры

&НаКлиенте
Процедура УпаковкиНоменклатурыПометкаУдаленияПриИзменении(Элемент)
	УпаковкиНоменклатурыПометкаУдаленияПриИзмененииНаСервере();
КонецПроцедуры

&НаКлиенте
Процедура УпаковкиНоменклатурыВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	// Вставить содержимое обработчика.
	А = Поле.Имя;
КонецПроцедуры

&НаКлиенте
Процедура УдалениеПометитьСнять(Команда)
	// Вставить содержимое обработчика.
	Ид = Элементы.УпаковкиНоменклатуры.ТекущиеДанные.УникальныйИдентификатор;
	мСтроки = Элементы.УпаковкиНоменклатуры.ВыделенныеСтроки;
	Для каждого СтрокаТ Из мСтроки Цикл
		СтрокаО = Объект.УпаковкиНоменклатуры.НайтиПоИдентификатору(СтрокаТ);
		СтрокаО.ПометкаУдаления = Число(НЕ Булево(СтрокаО.ПометкаУдаления));
	КонецЦикла;
	УдалениеПометитьСнятьНаСервере(Ид);
КонецПроцедуры
	
	
&НаСервере
Процедура УдалениеПометитьСнятьНаСервере(ИД)
	
	Таб = Объект.УпаковкиНоменклатуры.Выгрузить();
	//СтрокаТ = Таб.Найти(ИД);
	//СтрокаТ.ПометкаУдаления = Число(НЕ Булево(СтрокаТ.ПометкаУдаления));
	ТекОбъект = реквизитФормыВЗначение("Объект");
	ТекОбъект.СохранитьЗначениеНастройки("УпаковкиНоменклатуры", Таб);
	//Объект.УпаковкиНоменклатуры.Загрузить(Таб);
	
КонецПроцедуры


&НаКлиенте
Процедура УдалитьИзХранилища(Команда)
	УдалитьИзХранилищаНаСервере();
	ЭтаФорма.ОбновитьОтображениеДанных();
КонецПроцедуры

&НаСервере
Процедура УдалитьИзХранилищаНаСервере()
	ТекОбъект = реквизитФормыВЗначение("Объект");
	ТекОбъект.УдалитьЗначениеНастройки("УпаковкиНоменклатуры");
КонецПроцедуры

&НаКлиенте
Процедура Выбрать(Команда)
	// Вставить содержимое обработчика.
	ВыбЭл = Элементы.УпаковкиНоменклатуры.ТекущиеДанные;
	Данные = Новый Структура("Код,Наименование,Коэффициент,Номенклатура,ЕдиницаИзмеренияНоменклатуры,УникальныйИдентификатор,ПометкаУдаления");
	ЗаполнитьЗначенияСвойств(Данные, Элементы.УпаковкиНоменклатуры.ТекущиеДанные);
	Закрыть(Данные);
	
КонецПроцедуры




