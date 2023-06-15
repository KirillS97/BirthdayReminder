import UIKit




/*= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =*/
  // MARK: - Определение класса "PersonProfileViewController"
/*= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =*/
class PersonProfileViewController: UIViewController {
    
    
    
    // MARK: - Хранимые свойства
    /*------------------------------------------------------------------------------*/
    /*------------------------------------------------------------------------------*/
    
    var addButton                = UIButton()     // Кнопка "Добавить"
    let noticeLabel              = UILabel()      // Метка с уведомлением "Заполните все поля"
    var avatar                   = UIImageView()  // Аватар
    let sizeOfAvatar             = CGFloat(150)   // Размер аватара
    var imageForAvatar: UIImage? = nil            // Изображение для аватара
    var changeThePhotoButton     = UIButton()     // Кнопка "Изменить фотографию"
    
    var nameTextField            = UITextField()  // Текстовое поле "Имя"
    var birthdayDateTextField    = UITextField()  // Текстовое поле "Дата рождения"
    var ageTextField             = UITextField()  // Текстовое поле "Возраст"
    var genderTextField          = UITextField()  // Текстовое поле "Гендер"
    var instagramTextField       = UITextField()  // Текстовое поле "Инстаграм аккаунт"
    
    var subView                  = UIView()       // Подложка
    
    var datePickerOfBDayDate     = UIDatePicker() // Пикер даты для выбора даты рождения
    let genderPicker             = UIPickerView() // Пикер для выбора гендера
    
    var birthdayDate             = Date()         // Дата рождения
    var gender:                    Person.Gender! // Гендер
    var closureForDataTransmission: ( (String, Date, Person.Gender, String, UIImage?) -> Void )?  // Замыкание для передачи данных во вью контроллер со списком дней рождений
    
    /*------------------------------------------------------------------------------*/
    /*------------------------------------------------------------------------------*/
    
    
    // MARK: - "viewDidLoad" method
    /*------------------------------------------------------------------------------*/
    /*------------------------------------------------------------------------------*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // MARK: Переменные и константы
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        let fontSizeForTextFields: CGFloat = 17  // Размер шрифта в текстовых полях. Размер также используется в качестве размера икнонок в левой части текстовых полей
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        
        
        // MARK: Настройка корневогого "View"
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        self.view.backgroundColor = viewColor
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        
        
        // MARK: Настройка кнопки "Добавить"
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        // Настройка цвета кнопки
        self.addButton.setTitleColor(colorOfUIviews, for: .normal)
        self.addButton.setTitleColor(UIColor(red: 1, green: 0, blue: 0, alpha: 0.25), for: .highlighted)
        
        // Настройка заголовка кнопки
        self.addButton.setTitle("Добавить", for: .normal)
        self.addButton.titleLabel?.font = .systemFont(ofSize: 17, weight: .medium)
        
        // Добавление обработчика нажатия на копку
        self.addButton.addTarget(self, action: #selector(transferThePersonAndGoBack), for: .touchUpInside)
        
        // Добавление объекта к родительскому вью
        self.view.addSubview(self.addButton)
        
        // Отключение системных автоматических ограничений
        self.addButton.translatesAutoresizingMaskIntoConstraints = false
        
        // Установка ограничений
        NSLayoutConstraint.activate([
            self.addButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor,
                                                constant: 10),
            self.addButton.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor,
                                                  constant: -10)
        ])
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        
        
        // MARK: Настройка аватара
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        // Настройка внешнего вида
        self.avatar.layer.borderWidth = 1
        self.avatar.layer.borderColor = .init(red: 0, green: 0, blue: 0, alpha: 1)
        self.avatar.layer.cornerRadius = sizeOfAvatar / 2
        
        // Добавление объекта к родительскому вью
        self.view.addSubview(self.avatar)
        
        // Отключение системных автоматических ограничений
        self.avatar.translatesAutoresizingMaskIntoConstraints = false
        
        // Обрезка изображения аватара по форме и размеру аватара
        self.avatar.clipsToBounds = true
        
        // Установка изображения аватара
        if imageForAvatar != nil { self.avatar.image = imageForAvatar }
        else if !self.genderTextField.text!.isEmpty {
            switch self.genderTextField.text! {
            case "М":
                self.avatar.image = UIImage(named: "man.png")!.scaleImage(targetWidth: sizeOfAvatar, targetHeight: sizeOfAvatar)
            case "Ж":
                self.avatar.image = UIImage(named: "woman.png")!.scaleImage(targetWidth: sizeOfAvatar, targetHeight: sizeOfAvatar)
            default:
                self.avatar.image = UIImage(systemName: "person.fill")
            }
        } else {
            self.avatar.image = UIImage(systemName: "person.fill")
            self.avatar.tintColor = .systemGray2
        }
        
        // Настройка цвета заднего фона аватара
        self.avatar.backgroundColor = .white
        
        // Установка ограничений
        NSLayoutConstraint.activate([
            self.avatar.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 60),
            self.avatar.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            self.avatar.widthAnchor.constraint(equalToConstant: sizeOfAvatar),
            self.avatar.heightAnchor.constraint(equalToConstant: sizeOfAvatar)
        ])
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        
        
        // MARK: Кнопка "Изменить фотографию"
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        // Настройка цвета кнопки
        self.changeThePhotoButton.setTitleColor(colorOfUIviews, for: .normal)
        self.changeThePhotoButton.setTitleColor(UIColor(red: 1, green: 0, blue: 0, alpha: 0.25), for: .highlighted)
        
        // Настройка текста кнопки
        self.changeThePhotoButton.setTitle("Изменить фотографию", for: .normal)
        self.changeThePhotoButton.titleLabel?.font = .systemFont(ofSize: 17, weight: .regular)
        
        // Добавление обработчика нажатия на кнопку
        self.changeThePhotoButton.addTarget(self, action: #selector(chooseThePhotoFromPhotoLibrary), for: .touchUpInside)
        
        // Добавление объекта к родительскому вью
        self.view.addSubview(self.changeThePhotoButton)
        
        // Отключение системных автоматических ограничений
        self.changeThePhotoButton.translatesAutoresizingMaskIntoConstraints = false
        
        // Установка ограничений
        NSLayoutConstraint.activate([
            self.changeThePhotoButton.topAnchor.constraint(equalTo: self.avatar.bottomAnchor,
                                                constant: 0),
            self.changeThePhotoButton.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor)
        ])
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        
        
        // MARK: Текстовое поле "Имя"
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        createTextField(textfield: self.nameTextField,
                        placeholder: "Имя",
                        borderStyle: .roundedRect,
                        fontSize: fontSizeForTextFields,
                        fontWeight: .thin,
                        textColor: .black,
                        backgroundColor: .white)
        
        // Добавление обработчика взаимодействия
        self.nameTextField.addTarget(self, action: #selector(self.deleteTheNoticeLabelText), for: .allTouchEvents)
        
        // Добавление объекта к родительскому вью
        self.view.addSubview(self.nameTextField)
        
        // Отключение системных автоматических ограничений
        self.nameTextField.translatesAutoresizingMaskIntoConstraints = false
        
        // Установка ограничений
        NSLayoutConstraint.activate([
            self.nameTextField.topAnchor.constraint(equalTo: self.changeThePhotoButton.bottomAnchor, constant: 20),
            self.nameTextField.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 50),
            self.nameTextField.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor)
        ])
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        
        
        // MARK: Настройка иконки в левой части текстового поля "Имя"
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        // Создание объекта масштабированного изображения с исходными пропорциями
        let imageForNameTextField = UIImage(systemName: "person.fill")
        
        // Создание и инициализация UI графического элемента
        let imageViewForNameTextField = UIImageView(image: imageForNameTextField)
        imageViewForNameTextField.tintColor = colorOfUIviews
        
        // Добавление UI графического элемента к текстовому полю в качестве левого элемента
        self.nameTextField.leftView = imageViewForNameTextField
        self.nameTextField.leftViewMode = .always
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        
        
        // MARK: Текстовое поле "Дата рождения"
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        createTextField(textfield: self.birthdayDateTextField,
                        placeholder: "Дата рождения",
                        borderStyle: .roundedRect,
                        fontSize: fontSizeForTextFields,
                        fontWeight: .thin,
                        textColor: .black,
                        backgroundColor: .white)
        
        // Добавление обработчика взаимодействия
        self.birthdayDateTextField.addTarget(self, action: #selector(self.deleteTheNoticeLabelText), for: .touchDown)
        
        // Добавление объекта к родительскому вью
        self.view.addSubview(self.birthdayDateTextField)
        
        // Отключение системных автоматических ограничений
        self.birthdayDateTextField.translatesAutoresizingMaskIntoConstraints = false
        
        // Установка ограничений
        NSLayoutConstraint.activate([
            self.birthdayDateTextField.topAnchor.constraint(equalTo: self.nameTextField.bottomAnchor, constant: 10),
            self.birthdayDateTextField.leftAnchor.constraint(equalTo: self.nameTextField.leftAnchor),
            self.birthdayDateTextField.centerXAnchor.constraint(equalTo: self.nameTextField.centerXAnchor)
        ])
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        
        
        // MARK: Настройка иконки в левой части текстового поля "Дата рождения"
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        // Создание объекта масштабированного изображения с исходными пропорциями
        let imageForBirthdayDateTextField = UIImage(named: "iconForBirthdayDateTextField.png")?.scaleImage(targetWidth: nil, targetHeight: fontSizeForTextFields)
        
        // Создание и инициализация UI графического элемента
        let imageViewForBirthdayDateTextField = UIImageView(image: imageForBirthdayDateTextField?.withTintColor(colorOfUIviews))
        
        // Добавление UI графического элемента к текстовому полю в качестве левого элемента
        self.birthdayDateTextField.leftView = imageViewForBirthdayDateTextField
        self.birthdayDateTextField.leftViewMode = .always
        
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        
        
        // MARK: Настройка "Date Picker" для текстового поля "Дата рождения"
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        // Установка "Date picker" в качестве всплывающего окна в ответ на получение текстового поля "Дата рождения" статуса "First Responder"
        self.birthdayDateTextField.inputView = self.datePickerOfBDayDate
        
        // Установка стиля
        self.datePickerOfBDayDate.preferredDatePickerStyle = .wheels
        
        // Установка режима
        self.datePickerOfBDayDate.datePickerMode = .date
        
        // Добавление обработчика взаимодействия пользователя с пикером
        self.datePickerOfBDayDate.addTarget(self, action: #selector(datePickerHandler), for: .valueChanged)
        
        // Панель иснтрументов для пикера даты
        let toolbarForDatePickerOfBDayDate = UIToolbar()
        
        // Установка размера для панели инструментов
        toolbarForDatePickerOfBDayDate.sizeToFit()
         
        // Кнопка "Готово" для панели инструментов
        let buttonDoneForDatePickerOfBDayDate = UIBarButtonItem(title: "Готово",
                                                                style: .done,
                                                                target: self,
                                                                action: #selector(closeTheDatePicker))
        
        // Настройка цвета кнопки "Готово"
        buttonDoneForDatePickerOfBDayDate.tintColor = colorOfUIviews
        
        // Пустная нопка для растяжения  пространства панели инструментов
        let flexSpaceButtonForDatePickerOfBDayDate = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                                                     target: self,
                                                                     action: nil)
        
        // Добавление кнопок на панель инструментов
        toolbarForDatePickerOfBDayDate.setItems([flexSpaceButtonForDatePickerOfBDayDate,
                                                buttonDoneForDatePickerOfBDayDate],
                                                animated: true)
        
        // Добавление панели инструментов в качестве аксессуара для всплывающего окна
        self.birthdayDateTextField.inputAccessoryView = toolbarForDatePickerOfBDayDate
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        
        
        // MARK: Текстовое поле "Возраст"
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        createTextField(textfield: self.ageTextField,
                        placeholder: "Возраст",
                        borderStyle: .roundedRect,
                        fontSize: fontSizeForTextFields,
                        fontWeight: .thin,
                        textColor: .black,
                        backgroundColor: .white)
        
        // Добавление объекта к родительскому вью
        self.view.addSubview(self.ageTextField)
        
        // Добавление обработчика взаимодействия
        self.ageTextField.addTarget(self, action: #selector(ageTFHandler), for: .allTouchEvents)
        
        // Отключение системных автоматических ограничений
        self.ageTextField.translatesAutoresizingMaskIntoConstraints = false
        
        // Установка ограничений
        NSLayoutConstraint.activate([
            self.ageTextField.topAnchor.constraint(equalTo: self.birthdayDateTextField.bottomAnchor, constant: 10),
            self.ageTextField.leftAnchor.constraint(equalTo: self.nameTextField.leftAnchor),
            self.ageTextField.centerXAnchor.constraint(equalTo: self.nameTextField.centerXAnchor)
        ])
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        
        
        // MARK: Настройка иконки в левой части текстового поля "Возраст"
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        // Создание объекта масштабированного изображения с исходными пропорциями
        let imageForAgeTextField = UIImage(named: "iconForAgeTextField.png")?.scaleImage(targetWidth: nil, targetHeight: fontSizeForTextFields)
        
        // Создание и инициализация UI графического элемента
        let imageViewForAgeTextField = UIImageView(image: imageForAgeTextField?.withTintColor(colorOfUIviews))
        
        // Добавление UI графического элемента к текстовому полю в качестве левого элемента
        self.ageTextField.leftView = imageViewForAgeTextField
        self.ageTextField.leftViewMode = .always
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        
        
        // MARK: Текстовое поле "Гендер"
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        createTextField(textfield: self.genderTextField,
                        placeholder: "М / Ж",
                        borderStyle: .roundedRect,
                        fontSize: fontSizeForTextFields,
                        fontWeight: .thin,
                        textColor: .black,
                        backgroundColor: .white)
        
        // Добавление объекта к родительскому вью
        self.view.addSubview(self.genderTextField)
        
        // Отключение системных автоматических ограничений
        self.genderTextField.translatesAutoresizingMaskIntoConstraints = false
        
        // Установка ограничений
        NSLayoutConstraint.activate([
            self.genderTextField.topAnchor.constraint(equalTo: self.ageTextField.bottomAnchor, constant: 10),
            self.genderTextField.leftAnchor.constraint(equalTo: self.nameTextField.leftAnchor),
            self.genderTextField.centerXAnchor.constraint(equalTo: self.nameTextField.centerXAnchor)
        ])
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        
        
        // MARK: Настройка иконки в левой части текстового поля "Гендер"
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        // Создание объекта масштабированного изображения с исходными пропорциями
        let imageForGenderTextField = UIImage(named: "iconForGenderTextField.png")?.scaleImage(targetWidth: nil, targetHeight: fontSizeForTextFields)
        
        // Создание и инициализация UI графического элемента
        let imageViewForGenderTextField = UIImageView(image: imageForGenderTextField?.withTintColor(colorOfUIviews))
        
        // Добавление UI графического элемента к текстовому полю в качестве левого элемента
        self.genderTextField.leftView = imageViewForGenderTextField
        self.genderTextField.leftViewMode = .always
        
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        
        
        // MARK: Настройка "Picker" для текстового поля "Гендер"
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        self.genderPicker.dataSource = self
        self.genderPicker.delegate   = self
        
        self.genderTextField.inputView = self.genderPicker
        
        // Панель иснтрументов для пикера гендера
        let toolbarForGenderPicker = UIToolbar()
        
        // Установка размера для панели инструментов
        toolbarForGenderPicker.sizeToFit()
         
        // Кнопка "Готово" для панели инструментов
        let buttonDoneForGenderPicker = UIBarButtonItem(title: "Готово",
                                                                style: .done,
                                                                target: self,
                                                                action: #selector(genderPickerDoneButtonHandler))
        
        // Настройка цвета кнопки "Готово"
        buttonDoneForGenderPicker.tintColor = colorOfUIviews
        
        // Пустная нопка для растяжения  пространства панели инструментов
        let flexSpaceButtonForGenderPicker = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                                                     target: self,
                                                                     action: nil)
        
        // Добавление кнопок на панель инструментов
        toolbarForGenderPicker.setItems([flexSpaceButtonForGenderPicker,
                                         buttonDoneForGenderPicker],
                                        animated: true)
        
        // Добавление панели инструментов в качестве аксессуара для всплывающего окна
        self.genderTextField.inputAccessoryView = toolbarForGenderPicker
        
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        
        
        // MARK: Текстовое поле "Instagram аккаунт"
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        createTextField(textfield: self.instagramTextField,
                        placeholder: "Instagram аккаунт",
                        borderStyle: .roundedRect,
                        fontSize: fontSizeForTextFields,
                        fontWeight: .thin,
                        textColor: .black,
                        backgroundColor: .white)
        
        // Добавление объекта к родительскому вью
        self.view.addSubview(self.instagramTextField)
        
        // Отключение системных автоматических ограничений
        self.instagramTextField.translatesAutoresizingMaskIntoConstraints = false
        
        // Установка ограничений
        NSLayoutConstraint.activate([
            self.instagramTextField.topAnchor.constraint(equalTo: self.genderTextField.bottomAnchor, constant: 10),
            self.instagramTextField.leftAnchor.constraint(equalTo: self.nameTextField.leftAnchor),
            self.instagramTextField.centerXAnchor.constraint(equalTo: self.nameTextField.centerXAnchor)
        ])
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        
        
        // MARK: Настройка иконки в левой части текстового поля "Instagram аккаунт"
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        // Создание объекта масштабированного изображения с исходными пропорциями
        let imageForInstagramTextField = UIImage(named: "iconForInstagramTextField.png")?.scaleImage(targetWidth: nil, targetHeight: fontSizeForTextFields)
        
        // Создание и инициализация UI графического элемента
        let imageViewForInstagramTextField = UIImageView(image: imageForInstagramTextField?.withTintColor(colorOfUIviews))
        
        // Добавление UI графического элемента к текстовому полю в качестве левого элемента
        self.instagramTextField.leftView = imageViewForInstagramTextField
        self.instagramTextField.leftViewMode = .always
        
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        
        
        // MARK: Настройка подложки "subView"
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        // Добавление объекта к родительскому вью
        self.view.addSubview(self.subView)
        
        // Перемещение объекта на задний план в иерархии
        self.view.sendSubviewToBack(self.subView)
        
        // Установка цвета заднего фона
        self.subView.backgroundColor = .white
        
        // Установка радиуса закругления сопряжения сторон
        self.subView.layer.cornerRadius = 12.5
        
        // Отключение системных автоматических ограничений
        self.subView.translatesAutoresizingMaskIntoConstraints = false
        
        // Установка ограничений
        NSLayoutConstraint.activate([
            self.subView.topAnchor.constraint(equalTo: self.avatar.topAnchor, constant: -10),
            self.subView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 10),
            self.subView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -10),
            self.subView.bottomAnchor.constraint(equalTo: self.instagramTextField.bottomAnchor, constant: 10)
        ])
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        
        
        // MARK: Настройка уведомительной метки
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        // Настройка внешнего вида метки
        createLabel(label: self.noticeLabel,
                    text: "",
                    numberOfLines: 1,
                    fontSize: 20,
                    fontWeight: .regular,
                    textColor: .systemRed,
                    isCenterTextAlignment: true)
        
        // Добавление объекта к корневому вью
        self.view.addSubview(self.noticeLabel)
        
        // Отключение автоматических ограничений
        self.noticeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Установка ограничений
        NSLayoutConstraint.activate([
            self.noticeLabel.topAnchor.constraint(equalTo: self.subView.bottomAnchor, constant: 30),
            self.noticeLabel.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            self.noticeLabel.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 50)
        ])
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
    }
    
    /*------------------------------------------------------------------------------*/
    /*------------------------------------------------------------------------------*/
    
    
    
    // MARK: - Функция для удаления текста уведомительной метки
    /*------------------------------------------------------------------------------*/
    /*------------------------------------------------------------------------------*/
    @objc func deleteTheNoticeLabelText() {
        self.noticeLabel.text = ""
    }
    /*------------------------------------------------------------------------------*/
    /*------------------------------------------------------------------------------*/
    
    
    
    // MARK: - Обработчик нажатия на текстовое поле "Возраст"
    /*------------------------------------------------------------------------------*/
    /*------------------------------------------------------------------------------*/
    // Функция снимает статус "First responder" с объекта, находящегося в данном статусе
    @objc func ageTFHandler() -> Void {
        self.view.endEditing(true)
        self.deleteTheNoticeLabelText()
    }
    /*------------------------------------------------------------------------------*/
    /*------------------------------------------------------------------------------*/
    
    
    
    // MARK: - Обработчик взаимодействия с "Date Picker"
    /*------------------------------------------------------------------------------*/
    /*------------------------------------------------------------------------------*/
    @objc func datePickerHandler() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.Y"
        let dateFromPicker = self.datePickerOfBDayDate.date
        let textWithBDayDate = dateFormatter.string(from: dateFromPicker)
        self.birthdayDateTextField.text = textWithBDayDate
        
        
        let currentDate = Date()
        
        let age = Int(currentDate.timeIntervalSince(dateFromPicker) / (60 * 60 * 24 * 365))
        
        self.ageTextField.text = String(age)
        self.birthdayDate = dateFromPicker
        
    }
    /*------------------------------------------------------------------------------*/
    /*------------------------------------------------------------------------------*/
    
    
    
    // MARK: - Обработчик нажатия кнопки "Готово" "Date Picker"
    /*------------------------------------------------------------------------------*/
    /*------------------------------------------------------------------------------*/
    @objc func closeTheDatePicker() {
        self.view.endEditing(true)
    }
    /*------------------------------------------------------------------------------*/
    /*------------------------------------------------------------------------------*/
    
    
    
    // MARK: - Обработчик нажатия кнопки "Готово" пикера гендера
    /*------------------------------------------------------------------------------*/
    /*------------------------------------------------------------------------------*/
    @objc func genderPickerDoneButtonHandler() {
        if self.genderPicker.selectedRow(inComponent: 0) == 0 {
            if self.imageForAvatar == nil {
                self.avatar.image = UIImage(named: "man.png")!.scaleImage(targetWidth: sizeOfAvatar, targetHeight: sizeOfAvatar)
            }
            self.genderTextField.text = "М"
            self.gender = .man
        } else {
            if self.imageForAvatar == nil {
                self.avatar.image = UIImage(named: "woman.png")!.scaleImage(targetWidth: sizeOfAvatar, targetHeight: sizeOfAvatar)
            }
            self.genderTextField.text = "Ж"
            self.gender = .woman
        }
        self.view.endEditing(true)
    }
    /*------------------------------------------------------------------------------*/
    /*------------------------------------------------------------------------------*/
    
    
    
    // MARK: - Обработчик нажатия кнопки "Изменить фотографию"
    /*------------------------------------------------------------------------------*/
    /*------------------------------------------------------------------------------*/
    @objc func chooseThePhotoFromPhotoLibrary() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true)
    }
    /*------------------------------------------------------------------------------*/
    /*------------------------------------------------------------------------------*/
    
    
    
    // MARK: - Обработчик нажатия кнопки "Добавить"
    /*------------------------------------------------------------------------------*/
    /*------------------------------------------------------------------------------*/
    @objc func transferThePersonAndGoBack() {
        if (nameTextField.text!.isEmpty) ||
            (birthdayDateTextField.text!.isEmpty) ||
            (genderTextField.text!.isEmpty) ||
            (instagramTextField.text!.isEmpty) {
            self.noticeLabel.text = "Заполните все поля!"
        } else {
            
            self.closureForDataTransmission!(self.nameTextField.text!,
                                             self.birthdayDate,
                                             self.gender,
                                             self.instagramTextField.text!,
                                             self.imageForAvatar)
            self.dismiss(animated: true)
        }
    }
    /*------------------------------------------------------------------------------*/
    /*------------------------------------------------------------------------------*/
    
}
/*= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =*/

/*= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =*/










/*= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =*/
  // MARK: - Реализация подписи класса "PersonProfileViewController" на протокол "UIPickerViewDataSource"
/*= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =*/
extension PersonProfileViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int { 1 }
    
    func pickerView(_ pickerView: UIPickerView,
                    numberOfRowsInComponent component: Int) -> Int { 2 }
    
}
/*= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =*/

/*= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =*/










/*= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =*/
  // MARK: - Реализация подписи класса "PersonProfileViewController" на протокол "UIPickerViewDelegate"
/*= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =*/
extension PersonProfileViewController : UIPickerViewDelegate {
    
    // MARK: Переменные
    /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
    // Высота ряда компонента
    var heightOfRow: CGFloat { return 70 }
    
    // Изображение "М", высота котогорого, равна высоте ряда кмпонента
    var maleImage: UIImage {
        get {
            let image = UIImage(named: "man.png")!
            return image.scaleImage(targetWidth: heightOfRow)
        }
    }
    
    // Изображение "Ж", высота котогорого, равна высоте ряда кмпонента
    var femaleImage: UIImage {
        get {
            let image = UIImage(named: "woman.png")!
            return image.scaleImage(targetWidth: heightOfRow)
        }
    }
    /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
    
    
    
    // MARK: Установка высоты ряда
    /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
    func pickerView(_ pickerView: UIPickerView,
                    rowHeightForComponent component: Int) -> CGFloat {
        return heightOfRow
    }
    /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
    
    
    
    // MARK: Установка изображений в качестве значений рядов компонента
    /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
    func pickerView(_ pickerView: UIPickerView,
                    viewForRow row: Int,
                    forComponent component: Int,
                    reusing view: UIView?) -> UIView {
        
        if row == 0 {
            return UIImageView(image: maleImage)
        } else {
            return UIImageView(image: femaleImage)
        }
    }
    /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
    
    
    
    // MARK: обработчик в/д с пикером
    /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
    func pickerView(_ pickerView: UIPickerView,
                    didSelectRow row: Int,
                    inComponent component: Int) {
        if row == 0 {
            self.genderTextField.text = "М"
        } else {
            self.genderTextField.text = "Ж"
        }
    }
    /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
    
}
/*= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =*/

/*= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =*/










/*= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =*/
  // MARK: - Реализация подписи класса "PersonProfileViewController" на протоколы "UINavigationControllerDelegate", "UIImagePickerControllerDelegate"
/*= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =*/
extension PersonProfileViewController: UINavigationControllerDelegate,
                                       UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let key = UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")
        
        if let image = info[key] as? UIImage {
            if image.size.width > image.size.height {
                self.imageForAvatar = image.scaleImage(targetWidth: nil, targetHeight: self.sizeOfAvatar)
            } else {
                self.imageForAvatar = image.scaleImage(targetWidth: self.sizeOfAvatar, targetHeight: nil)
            }
            self.avatar.image = self.imageForAvatar
        }
        picker.dismiss(animated: true)
    }
}
/*= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =*/

/*= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =*/
