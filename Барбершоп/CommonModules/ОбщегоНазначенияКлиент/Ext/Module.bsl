﻿&НаКлиенте
Процедура СообщитьПользователю(Текст, Поле = Неопределено) Экспорт 
	
	СообщениеПользователю = Новый СообщениеПользователю();
	СообщениеПользователю.Текст = Текст;
	
	Если Поле <> Неопределено Тогда
		СообщениеПользователю.Поле = Поле;
	КонецЕсли;
	СообщениеПользователю.Сообщить();
	
КонецПроцедуры
