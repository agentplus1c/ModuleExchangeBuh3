﻿
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)

	СтррКонтекст = Новый Структура("Местоположение");
	ТекОбъект = РеквизитФормыВЗначение("Объект");		
	ТекОбъект.ИнициализироватьКонтекстФормы(СтррКонтекст, Параметры); 
	СтррКонтекст.Местоположение = ТекОбъект.ПрочитатьЗначениеНастройки("МестоположениеДляИнформера");
	
КонецПроцедуры

// ОбработчикиСобытийФормы
#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ДекорацияОписаниеОбработкаНавигационнойСсылки(Элемент, НавигационнаяСсылка, СтандартнаяОбработка)

	Если НавигационнаяСсылка = "mailto" Тогда
		СтандартнаяОбработка = Ложь;
		стрГород = ПолучитьФорму(СтррКонтекст.ПутьКФорме + "МодульКарты").ГородМестоположения(СтррКонтекст.Местоположение);
		стрКлюч = " (" + ?(ЗначениеЗаполнено(стрГород), стрГород + ", ", "") + ТекущаяДата() + ")";
		ЗапуститьПриложение("mailto:mail@agentplus.ru?subject=Доступ в Личный кабинет" + стрКлюч);
	КонецЕсли; 
	
КонецПроцедуры

// ОбработчикиСобытийЭлементовШапкиФормы
#КонецОбласти
