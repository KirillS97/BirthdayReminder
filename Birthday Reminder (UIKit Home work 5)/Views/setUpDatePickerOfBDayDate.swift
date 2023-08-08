import UIKit


// MARK: - Функция для настройки пикера даты и установки его в качестве всплывающего окна при получении тесквого поля статуса "First Responder"
func setUpDatePickerOfBDayDate(datePicker: UIDatePicker,
                               forTextField: UITextField,
                               targetForDatePickerHandler: Any?,
                               datePickerHandler: Selector,
                               eventForDatePickerHandler: UIControl.Event,
                               targetForDoneButtonHandler: Any?,
                               doneButtonHandler: Selector) {
    
    // Установка "Date picker" в качестве всплывающего окна в ответ на получение текстового поля статуса "First Responder"
    forTextField.inputView = datePicker

    // Установка стиля
    datePicker.preferredDatePickerStyle = .wheels

    // Установка режима
    datePicker.datePickerMode = .date
    
    // Установка максимальной даты
    datePicker.maximumDate = Date(timeIntervalSinceNow: (-24 * 60 * 60))

    // Добавление обработчика взаимодействия пользователя с пикером
    datePicker.addTarget(targetForDatePickerHandler, action: datePickerHandler, for: eventForDatePickerHandler)

    // Панель иснтрументов для пикера даты
    let toolbarForDatePickerOfBDayDate = UIToolbar()

    // Установка размера для панели инструментов
    toolbarForDatePickerOfBDayDate.sizeToFit()

    // Кнопка "Готово" для панели инструментов
    let buttonDoneForDatePickerOfBDayDate = UIBarButtonItem(title: "Готово",
                                                            style: .done,
                                                            target: targetForDoneButtonHandler,
                                                            action: doneButtonHandler)

    // Настройка цвета кнопки "Готово"
    buttonDoneForDatePickerOfBDayDate.tintColor = colorOfUIviews

    // Пустная нопка для растяжения  пространства панели инструментов
    let flexSpaceButtonForDatePickerOfBDayDate = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                                                 target: targetForDoneButtonHandler,
                                                                 action: nil)

    // Добавление кнопок на панель инструментов
    toolbarForDatePickerOfBDayDate.setItems([flexSpaceButtonForDatePickerOfBDayDate,
                                            buttonDoneForDatePickerOfBDayDate],
                                            animated: true)

    // Добавление панели инструментов в качестве аксессуара для всплывающего окна
    forTextField.inputAccessoryView = toolbarForDatePickerOfBDayDate
}
