﻿
Функция get()
	
	ОбъектНоменклатура = ФабрикаXDTO.Тип("http://practicum.yandex.ru", "Номенклатура");
	ОбъектТипНоменклатуры = ФабрикаXDTO.Тип("http://practicum.yandex.ru", "ТипНоменклатуры");
	ОбъектСтатьяЗатрат = ФабрикаXDTO.Тип("http://practicum.yandex.ru", "СтатьяЗатрат");
	ОбъектСписокНоменклатуры = ФабрикаXDTO.Тип("http://practicum.yandex.ru", "СписокНоменклатуры"); //1
	
	Запрос = Новый Запрос; //2
	Запрос.Текст=
	"ВЫБРАТЬ
	|    Номенклатура.Наименование КАК Наименование,
	|    Номенклатура.Артикул КАК Артикул,
	|    ПРЕДСТАВЛЕНИЕ(Номенклатура.ТипНоменклатуры) КАК ТипНоменклатуры,
	|    Номенклатура.СтатьяЗатрат.Наименование КАК СтатьяЗатрат
	|ИЗ
	|    Справочник.Номенклатура КАК Номенклатура
	|ГДЕ
	|    НЕ Номенклатура.ПометкаУдаления
	|    И НЕ Номенклатура.ЭтоГруппа";
	
	СписокНоменклатуры = ФабрикаXDTO.Создать(ОбъектСписокНоменклатуры); //3
	
	Выборка = Запрос.Выполнить().Выбрать();
	
	Пока Выборка.Следующий() Цикл 
		Номенклатура = ФабрикаXDTO.Создать(ОбъектНоменклатура); //4
		ТипНоменклатуры  = ФабрикаXDTO.Создать(ОбъектТипНоменклатуры);
		СтатьяЗатрат = ФабрикаXDTO.Создать(ОбъектСтатьяЗатрат);
		
		ТипНоменклатуры.Наименование = Выборка.ТипНоменклатуры; //5
		СтатьяЗатрат.Наименование = Выборка.СтатьяЗатрат;
		
		Номенклатура.Наименование = Выборка.Наименование;
		Номенклатура.Артикул = Выборка.Артикул;
		Номенклатура.ТипНоменклатуры = ТипНоменклатуры;
		Номенклатура.СтатьяЗатрат = СтатьяЗатрат;
		
		СписокНоменклатуры.Номенклатура.Добавить(Номенклатура);
		
	КонецЦикла;
	
	возврат СписокНоменклатуры; //6
	
КонецФункции
