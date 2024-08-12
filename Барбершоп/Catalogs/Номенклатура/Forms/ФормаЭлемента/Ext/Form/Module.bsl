﻿
&НаКлиенте
Процедура ИзменитьЦену(Команда)
	Если Объект.Ссылка.Пустая() Тогда //1
		Сообщить("Перед установкой цены необходимо записать документ!");
	Иначе
		ОткрытьФорму("Справочник.Номенклатура.Форма.ФормаСозданияЦены",Новый Структура("Номенклатура", Объект.Ссылка),,,,, Новый ОписаниеОповещения("ПослеИзмененияЦены", ЭтаФорма),РежимОткрытияОкнаФормы.БлокироватьОкноВладельца); //2
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ПослеИзмененияЦены(Результат, ДополнительныеПараметры) Экспорт    
	ТекущаяРозничнаяЦена =  РаботаСЦенами.ПолучитьЦенуПродажиНаДату(Объект.Ссылка);
КонецПроцедуры 

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	Если НЕ Объект.Ссылка.Пустая() Тогда
		ТекущаяРозничнаяЦена = РаботаСЦенами.ПолучитьЦенуПродажиНаДату(Объект.Ссылка);
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	УстановитьВидимостьЭлементов();
	
КонецПроцедуры 

Процедура УстановитьВидимостьЭлементов()
	
	Если Объект.ТипНоменклатуры = ПредопределенноеЗначение("Перечисление.ТипНоменклатуры.Услуга") Тогда
		Элементы.ДлительностьУслуги.Видимость = Истина;
	Иначе
		Элементы.ДлительностьУслуги.Видимость = Ложь;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ТипНоменклатурыПриИзменении(Элемент)
	
	УстановитьВидимостьЭлементов();
		
КонецПроцедуры

&НаКлиенте
Процедура СчетБухгалтерскогоУчетаНачалоВыбора(Элемент, ДанныеВыбора, ВыборДобавлением, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	СписокДопустимыхЗначений = Новый СписокЗначений;
	Если Объект.ТипНоменклатуры = ПредопределенноеЗначение("Перечисление.ТипНоменклатуры.Товар") Тогда
		СписокДопустимыхЗначений.Добавить(ПредопределенноеЗначение("ПланСчетов.Хозрасчетный.Товары"));
		СписокДопустимыхЗначений.Добавить(ПредопределенноеЗначение("ПланСчетов.Хозрасчетный.Материалы"));
	ИначеЕсли Объект.ТипНоменклатуры = ПредопределенноеЗначение("Перечисление.ТипНоменклатуры.Услуга") Тогда
		СписокДопустимыхЗначений.Добавить(ПредопределенноеЗначение("ПланСчетов.Хозрасчетный.РасходыНаПродажу"));
		СписокДопустимыхЗначений.Добавить(ПредопределенноеЗначение("ПланСчетов.Хозрасчетный.ПрочиеДоходыИРасходы"));
	Иначе
		СписокДопустимыхЗначений.Добавить(ПредопределенноеЗначение("ПланСчетов.Хозрасчетный.ПустаяСсылка"));
	КонецЕсли;
	
	ДанныеВыбора = СписокДопустимыхЗначений;
	
КонецПроцедуры



	




