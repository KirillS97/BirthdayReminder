import UIKit


// MARK: - Функция для настройки пикера выбора гендера
func setUpGenderPicker(picker: UIPickerView,
                       pickerDataSource: UIPickerViewDataSource,
                       pickerDelegate: UIPickerViewDelegate,
                       forTextField: UITextField,
                       targetForDoneButtonHandler: Any?,
                       doneButtonHandler: Selector) {
    
    // Установка источника данных и делегата пикера
    picker.dataSource = pickerDataSource
    picker.delegate   = pickerDelegate
    
    // Установка пикера в качестве всплывающего окна в ответ на получение текстового поля статуса "First Responder"
    forTextField.inputView = picker

    // Панель иснтрументов для пикера гендера
    let toolbarForGenderPicker = UIToolbar()

    // Установка размера для панели инструментов
    toolbarForGenderPicker.sizeToFit()

    // Кнопка "Готово" для панели инструментов
    let buttonDoneForGenderPicker = UIBarButtonItem(title: "Готово",
                                                            style: .done,
                                                            target: targetForDoneButtonHandler,
                                                            action: doneButtonHandler)

    // Настройка цвета кнопки "Готово"
    buttonDoneForGenderPicker.tintColor = colorOfUIviews

    // Пустная нопка для растяжения  пространства панели инструментов
    let flexSpaceButtonForGenderPicker = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                                                 target: targetForDoneButtonHandler,
                                                                 action: nil)

    // Добавление кнопок на панель инструментов
    toolbarForGenderPicker.setItems([flexSpaceButtonForGenderPicker,
                                     buttonDoneForGenderPicker],
                                    animated: true)

    // Добавление панели инструментов в качестве аксессуара для всплывающего окна
    forTextField.inputAccessoryView = toolbarForGenderPicker
}

