﻿
Процедура ОбработкаПроведения(Отказ, Режим)
	
	Движения.Начисления.Записывать = Истина;
	Движения.УчетЗатрат.Записывать = истина;
	Движения.Хозрасчетный.Записывать = Истина;
	
	//Регистр Начисления
	Для Каждого ТекСтрокаНачисления Из Начисления Цикл
		Движение = Движения.Начисления.Добавить();
		Движение.Сторно = Ложь;
		Движение.ВидРасчета = ТекСтрокаНачисления.ВидРасчёта;
		Движение.ПериодДействияНачало = ТекСтрокаНачисления.ДатаНачала;
		Движение.ПериодДействияКонец = ТекСтрокаНачисления.ДатаОкончания;
		Движение.ПериодРегистрации = ПериодНачисления;
		Движение.БазовыйПериодНачало = ПериодНачисления;
		Движение.БазовыйПериодКонец = ПериодНачисления;
		Движение.Сотрудник = ТекСтрокаНачисления.Сотрудник;
		Движение.ПоказательРасчета = ТекСтрокаНачисления.ПоказательРасчёта;
		Движение.График = ТекСтрокаНачисления.ГрафикРаботы;
	КонецЦикла;
	
	Движения.Начисления.Записать();
	Движения.Начисления.РассчитатьСуммуНачисления();
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	Начисления.Сотрудник КАК Сотрудник,
	|	Начисления.Сумма КАК Сумма,
	|	Начисления.ВидРасчета.СтатьяЗатрат КАК СтатьяЗатрат
	|ИЗ
	|	РегистрРасчета.Начисления КАК Начисления
	|ГДЕ
	|	Начисления.Регистратор = &Регистратор
	|ИТОГИ
	|	СУММА(Сумма)
	|ПО
	|	СтатьяЗатрат";
	
	Запрос.УстановитьПараметр("Регистратор", ЭтотОбъект.Ссылка);
	РезультатЗапроса = Запрос.Выполнить();
	ВыборкаИтогиПоСтатье = РезультатЗапроса.Выбрать(ОбходРезультатаЗапроса.ПоГруппировкам);
	// Регистр "Учет затрат"
	Пока ВыборкаИтогиПоСтатье.Следующий() Цикл
		ДвижениеЗатрат = Движения.УчетЗатрат.Добавить();
		ДвижениеЗатрат.Период = Дата;
		ЗаполнитьЗначенияСвойств(ДвижениеЗатрат, ВыборкаИтогиПоСтатье);         
		// Регистр "Хозрасчетный" 
		ВыборкаДетальные = ВыборкаИтогиПоСтатье.Выбрать(); 
		Пока ВыборкаДетальные.Следующий() Цикл
			ДвижениеХозрасчетный = Движения.Хозрасчетный.Добавить();
			ДвижениеХозрасчетный.СчетДт = ПланыСчетов.Хозрасчетный.РасходыНаПродажу;
			ДвижениеХозрасчетный.СчетКт = ПланыСчетов.Хозрасчетный.РасчетыСПерсоналомПоОплатеТруда;
			ДвижениеХозрасчетный.Период = Дата;
			ДвижениеХозрасчетный.Сумма = ВыборкаДетальные.Сумма;
			ДвижениеХозрасчетный.Содержание = "Отражено начисление заработной платы сотрудникам";
			БухгалтерскийУчет.ЗаполнитьСубконтоПоСчету(ДвижениеХозрасчетный.СчетДт, 
			ДвижениеХозрасчетный.СубконтоДт, ВыборкаДетальные.СтатьяЗатрат);
			БухгалтерскийУчет.ЗаполнитьСубконтоПоСчету(ДвижениеХозрасчетный.СчетКт, 
			ДвижениеХозрасчетный.СубконтоКт, ВыборкаДетальные.Сотрудник);
		КонецЦикла;    
	КонецЦикла;        
		
КонецПроцедуры
