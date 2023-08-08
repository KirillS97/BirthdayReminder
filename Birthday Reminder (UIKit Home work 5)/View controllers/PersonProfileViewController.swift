import UIKit





  // MARK: - Определение класса "PersonProfileViewController"
/*------------------------------------------------------------------------------------------*/
class PersonProfileViewController: UIViewController {
    
    
    
    // MARK: - Cвойства
    /*========================================================*/
    let coreDataManager          = CoreDataManager.shared    // Экземпляр Core Data Manager
    var scrollView               = UIScrollView()
    var datePickerOfBDayDate     = UIDatePicker()            // Пикер даты для выбора даты рождения
    let genderPicker             = UIPickerView()            // Пикер для выбора гендера
    var personProfileView        : PersonProfileView!        // Графический элемент профиля человека
    var person                   : Person?                   // Добавляемый человек

    var closureForDataTransmission: ( () -> Void )? 
    /*========================================================*/
    
    
    
    // MARK: - "viewDidLoad" method
    /*========================================================*/
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // MARK: Настройка главного "View"
        /*- - - - - - - - - - - - - - - - -*/
        self.view = self.personProfileView
        self.view.backgroundColor = viewColor
        /*- - - - - - - - - - - - - - - - -*/
        
        
        // MARK: Инициализация объекта Person
        /*- - - - - - - - - - - - - - - - -*/
        if self.person == nil {
            self.person = Person(name: "Name",
                                      birthday: Date(timeIntervalSince1970: 0),
                                      gender: .man,
                                      persons: self.getPersonsArray())
        }
        /*- - - - - - - - - - - - - - - - -*/
        
        
        
        // MARK: Настройка "Date Picker" для выбора даты рождения
        /*- - - - - - - - - - - - - - - - -*/
        setUpDatePickerOfBDayDate(datePicker: self.datePickerOfBDayDate,
                                  forTextField: self.personProfileView.birthdayDateTF,
                                  targetForDatePickerHandler: self,
                                  datePickerHandler: #selector(datePickerHandler),
                                  eventForDatePickerHandler: .valueChanged,
                                  targetForDoneButtonHandler: self,
                                  doneButtonHandler: #selector(closeTheDatePicker))
        /*- - - - - - - - - - - - - - - - -*/
        
        
        
        // MARK: Настройка пикера для выбора гендера
        /*- - - - - - - - - - - - - - - - -*/
        setUpGenderPicker(picker: self.genderPicker,
                          pickerDataSource: self,
                          pickerDelegate: self,
                          forTextField: self.personProfileView.genderTF,
                          targetForDoneButtonHandler: self,
                          doneButtonHandler: #selector(genderPickerDoneButtonHandler))
        /*- - - - - - - - - - - - - - - - -*/
        
        
        
        // MARK: Установка обработчиков взаимодействия с текстовыми полями графического элемента профиля человека
        /*- - - - - - - - - - - - - - - - -*/
        self.personProfileView.nameTF.addTarget(self, action: #selector(textFieldsHandler), for: .allEditingEvents)
        self.personProfileView.birthdayDateTF.addTarget(self, action: #selector(textFieldsHandler), for: .allEditingEvents)
        self.personProfileView.ageTF.addTarget(self, action: #selector(ageTFHandler(sender:)), for: .allEditingEvents)
        self.personProfileView.genderTF.addTarget(self, action: #selector(textFieldsHandler), for: .allEditingEvents)
        /*- - - - - - - - - - - - - - - - -*/
        
        
        
        // MARK: Установка обработчика нажатия на кнопку "Изменить фотографию"
        /*- - - - - - - - - - - - - - - - -*/
        self.personProfileView.changeThePhotoButton.addTarget(self,
                                                              action: #selector(self.chooseThePhotoFromPhotoLibrary),
                                                              for: .touchUpInside)
        /*- - - - - - - - - - - - - - - - -*/
        
        
        
        // MARK: Установка обработчика кнопки панели инструментов
        /*- - - - - - - - - - - - - - - - -*/
        if let toolBarItemsArray = self.personProfileView.toolBar.items {
        loop: for button in toolBarItemsArray {
                if button.style == .done {
                    button.target = self
                    button.action = #selector(self.transferThePersonAndGoBack)
                    break loop
                }
            }
        }
        /*- - - - - - - - - - - - - - - - -*/
        
        
        
        // MARK: Добавление текстовым полям выбора даты рождения и выбора гендера делегатов, чтобы пользователь не мог изменять текст внутри этих текстовых полей (текст изменяется только соответствующими пикерами)
        /*- - - - - - - - - - - - - - - - -*/
        self.personProfileView.birthdayDateTF.delegate = self
        self.personProfileView.genderTF.delegate = self
        /*- - - - - - - - - - - - - - - - -*/
        
        
        
        // MARK: Добавление текстовому графическому элементу с поздравлением делегата, чтобы этот делегат реагировал на изменения текста внутри этого текстового графического элемента
        /*- - - - - - - - - - - - - - - - -*/
        self.personProfileView.congratulationTV.delegate = self
        /*- - - - - - - - - - - - - - - - -*/
        
    }
    /*========================================================*/
    
    
    
    // MARK: Функция для преобразования массива PersonEntity из БД в массив Person
    /*==================================================================*/
    private func getPersonsArray() -> [Person] {
        var returnedArray: [Person] = []
        let context = self.coreDataManager.persistentContainer.viewContext
        let personEntitesArray = PersonEntity.getPersonEntitiesArray(context: context)
        for personEntity in personEntitesArray {
            returnedArray.append(Person(personEntity: personEntity))
        }
        return returnedArray
    }
    /*==================================================================*/
    
    
    
    // MARK: - Обработчик взаимодействия с текстовыми полями
    /*========================================================*/
    @objc func textFieldsHandler(sender: UITextField) {
        if sender.isEqual(self.personProfileView.nameTF) {
            if let nameText = self.personProfileView.nameTF.text {
                self.person!.name = nameText
            }
        }
        self.personProfileView.noticeLabel.text = ""
    }
    /*========================================================*/
    
    
    
    // MARK: - Обработчик нажатия на текстовое поле "Возраст"
    /*========================================================*/
    // Функция снимает статус "First responder" с объекта, находящегося в данном статусе
    @objc func ageTFHandler(sender: UITextField) -> Void {
        guard sender.isEqual(self.personProfileView.ageTF) else { return }
        self.view.endEditing(true)
        self.textFieldsHandler(sender: sender)
    }
    /*========================================================*/
    
    
    
    // MARK: - Обработчик взаимодействия с "Date Picker"
    /*========================================================*/
    @objc func datePickerHandler() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.Y"
        let dateFromPicker = self.datePickerOfBDayDate.date
        let textWithBDayDate = dateFormatter.string(from: dateFromPicker)
        self.personProfileView.birthdayDateTF.text = textWithBDayDate
        
        let currentDate = Date()
        
        let age = Int(currentDate.timeIntervalSince(dateFromPicker) / (60 * 60 * 24 * 365))
        
        self.personProfileView.ageTF.text = String(age)
        self.person!.birthday = self.datePickerOfBDayDate.date
    }
    /*========================================================*/
    
    
    
    // MARK: - Обработчик нажатия кнопки "Готово" "Date Picker"
    /*========================================================*/
    @objc func closeTheDatePicker() {
        self.view.endEditing(true)
    }
    /*========================================================*/



    // MARK: - Обработчик нажатия кнопки "Готово" пикера гендера
    /*========================================================*/
    @objc func genderPickerDoneButtonHandler() {
        if self.genderPicker.selectedRow(inComponent: 0) == 0 {
            if self.person?.avatar == nil {
                self.personProfileView.avatar.image = UIImage(named: "man.png")
            }
            self.personProfileView.genderTF.text = "М"
            self.person!.gender = .man
        } else {
            if self.person!.avatar == nil {
                self.personProfileView.avatar.image = UIImage(named: "woman.png")
            }
            self.personProfileView.genderTF.text = "Ж"
            self.person!.gender = .woman
        }
        self.view.endEditing(true)
    }
    /*========================================================*/



    // MARK: - Обработчик нажатия кнопки "Изменить фотографию"
    /*========================================================*/
    @objc func chooseThePhotoFromPhotoLibrary() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true)
    }
    /*========================================================*/

    

    // MARK: - Обработчик нажатия кнопки "Добавить"
    /*========================================================*/
    @objc func transferThePersonAndGoBack() {
        if (self.personProfileView.nameTF.text!.isEmpty) ||
            (self.personProfileView.birthdayDateTF.text!.isEmpty) ||
            (self.personProfileView.ageTF.text!.isEmpty) ||
            (self.personProfileView.genderTF.text!.isEmpty) {
            self.personProfileView.noticeLabel.text = "Заполните все текстовые поля!"
        } else {
            if let findedEntity = PersonEntity.findEntity(person: self.person!,
                                                          context: self.coreDataManager.persistentContainer.viewContext) {
                findedEntity.setUpAttributes(person: self.person!)
                print("finded entity was changed")
            } else {
                PersonEntity.createEntity(person: self.person!, context: self.coreDataManager.persistentContainer.viewContext)
                print("new entity was created")
            }
            self.closureForDataTransmission!()
            self.dismiss(animated: true)
        }
    }
    /*========================================================*/

    
    
}

/*------------------------------------------------------------------------------------------*/





  // MARK: - Реализация подписи класса "PersonProfileViewController" на протокол "UIPickerViewDataSource"
/*------------------------------------------------------------------------------------------*/
extension PersonProfileViewController: UIPickerViewDataSource {

    // Метод, устанавливающий количество компонентов пикера
    func numberOfComponents(in pickerView: UIPickerView) -> Int { 1 }
    
    // Метод, устанавливающий число рядов (строк) в компонентах пикера
    func pickerView(_ pickerView: UIPickerView,
                    numberOfRowsInComponent component: Int) -> Int { 2 }

}
/*------------------------------------------------------------------------------------------*/





  // MARK: - Реализация подписи класса "PersonProfileViewController" на протокол "UIPickerViewDelegate"
/*------------------------------------------------------------------------------------------*/
extension PersonProfileViewController : UIPickerViewDelegate {

    // MARK: Переменные
    /*========================================================*/
    // Высота ряда компонента
    var heightOfRow: CGFloat { return 70 }

    // Изображение "М", высота котогорого, равна высоте ряда кмпонента
    var maleImage: UIImage {
        get {
            let image = UIImage(named: "man.png")!
            return image
        }
    }

    // Изображение "Ж", высота котогорого, равна высоте ряда кмпонента
    var femaleImage: UIImage {
        get {
            let image = UIImage(named: "woman.png")!
            return image
        }
    }
    /*========================================================*/



    // MARK: Установка высоты ряда
    /*========================================================*/
    func pickerView(_ pickerView: UIPickerView,
                    rowHeightForComponent component: Int) -> CGFloat {
        return heightOfRow
    }
    /*========================================================*/



    // MARK: Установка изображений в качестве значений рядов компонента
    /*========================================================*/
    func pickerView(_ pickerView: UIPickerView,
                    viewForRow row: Int,
                    forComponent component: Int,
                    reusing view: UIView?) -> UIView {

        if row == 0 {
            let maleImageView = UIImageView(image: maleImage)
            maleImageView.frame.size = CGSize(width: heightOfRow, height: heightOfRow)
            return maleImageView
        } else {
            let femaleImage = UIImageView(image: femaleImage)
            femaleImage.frame.size = CGSize(width: heightOfRow, height: heightOfRow)
            return femaleImage
        }
    }
    /*========================================================*/



    // MARK: обработчик в/д с пикером выбора гендера
    /*========================================================*/
    func pickerView(_ pickerView: UIPickerView,
                    didSelectRow row: Int,
                    inComponent component: Int) {
        if row == 0 {
            self.personProfileView.genderTF.text = "М"
        } else {
            self.personProfileView.genderTF.text = "Ж"
        }
    }
    //*========================================================*/

}
/*------------------------------------------------------------------------------------------*/





  // MARK: - Реализация подписки класса "PersonProfileViewController" на протоколы "UINavigationControllerDelegate", "UIImagePickerControllerDelegate" для получения доступа к галерее фотографий
/*------------------------------------------------------------------------------------------*/
extension PersonProfileViewController: UINavigationControllerDelegate,
                                       UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let key = UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")

        if let image = info[key] as? UIImage {
            if image.size.width > image.size.height {
                self.person!.avatar = image
            } else {
                self.person!.avatar = image
            }
            self.personProfileView.avatar.image = self.person!.avatar
        }
        picker.dismiss(animated: true)
    }
    
}
/*------------------------------------------------------------------------------------------*/





// MARK: - Реализация подписи класса "PersonProfileViewController" на протокол "UITextFieldDelegate" для запрета редактирования пользователем текстовых полей выбора даты рождения и гендера
/*------------------------------------------------------------------------------------------*/
extension PersonProfileViewController: UITextFieldDelegate {
    
    // MARK: Метод запрещает пользователю изменять текст внутри текстового поля
    /*========================================================*/
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        return false
    }
    /*========================================================*/
}
/*------------------------------------------------------------------------------------------*/





// MARK: - Реализация подписи класса "PersonProfileViewController" на протокол "UITextViewDelegate" для обработки события редактирования текста внутри текстового графического элемента
/*------------------------------------------------------------------------------------------*/
extension PersonProfileViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        self.person!.congratulation = textView.text
    }
}
/*------------------------------------------------------------------------------------------*/
