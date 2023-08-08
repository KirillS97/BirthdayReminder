import UIKit

class PersonProfileView: UIView {
    
    
    
    // MARK: - Свойства
    /*========================================================*/
    private let scrollView            = UIScrollView()
    private let view                  = UIView()
    
    let noticeLabel                   = UILabel()      // Метка с уведомлением "Заполните все поля"
    let avatar                        = UIImageView()  // Аватар
    let sizeOfAvatar                  = CGFloat(150)   // Размер аватара
    let changeThePhotoButton          = UIButton()     // Кнопка "Изменить фотографию"
    
    let nameTF                        = UITextField()  // Текстовое поле "Имя"
    let birthdayDateTF                = UITextField()  // Текстовое поле "Дата рождения"
    let ageTF                         = UITextField()  // Текстовое поле "Возраст"
    let genderTF                      = UITextField()  // Текстовое поле "Гендер"
    
    let congratulationTV              = UITextViewWithPlaceholder()   // Текстовый графический элемент с поздравлением
    
    private let subView               = UIView()       // Подложка
    
    private let fontSizeForTextFields = CGFloat(17)    // Размер шрифта в текстовых полях. Размер также используется в качестве размера икнонок в левой части текстовых полей
    
    let toolBar               = UIToolbar()    // Панель инструментов
    /*========================================================*/
    
    
    
    // MARK: Настройка панели инструментов
    /*========================================================*/
    private func toolBarSetting() {
        
        // Настройка цвета
        self.toolBar.barTintColor = viewColor
        
        // Добавление к родительскому вью
        self.addSubview(self.toolBar)
        
        // Установка ограничений
        self.addConstraintsToToolBar()
        
        // Инициализация и настройка пустой кнопки для реализация отступа слева
        let emptyButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        // Инициализация и настройка кнопки "Добавить"
        let addButton = UIBarButtonItem(title: "Добавить",
                                        style: .done,
                                        target: nil,
                                        action: nil)
        
        // Настройка цвета кнопки
        addButton.tintColor = colorOfUIviews
        
        // Добавление кнопок на панель инструментов
        self.toolBar.items = [emptyButton, addButton]
        /*- - - - - - - - - - - - - - - - -*/
        
    }
    
    private func addConstraintsToToolBar() -> Void {
        self.toolBar.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.toolBar.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.toolBar.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor),
            self.toolBar.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor)
        ])
    }
    
    private func setUpTitleForAddButton(person: Person?) -> Void {
        if person != nil {
            self.toolBar.items?[1].title = "Готово"
        }
    }
    /*========================================================*/
    
    
    
    // MARK: - Метод для настройки UIScrollView
    /*========================================================*/
    private func setUpScrollView() {
        self.addSubview(self.scrollView)
        self.scrollView.backgroundColor = viewColor
        self.scrollView.keyboardDismissMode = .interactive
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.scrollView.topAnchor.constraint(equalTo: self.toolBar.bottomAnchor),
            self.scrollView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: self.keyboardLayoutGuide.topAnchor),
            self.scrollView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    /*========================================================*/
    
    
    
    // MARK: Настройка UIView
    /*========================================================*/
    private func setUpView() {
        self.view.backgroundColor = .none
        self.scrollView.addSubview(self.view)
        self.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.view.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
            self.view.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor),
            self.view.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor),
            self.view.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor)
        ])
    }
    /*========================================================*/
    
    
    
    // MARK: - Метод для настройки аватара
    /*========================================================*/
    private func avatarSetting() {
        
        // Настройка внешнего вида
        /* - - - - - - - - - - - - - - - - - - - */
        self.avatar.layer.borderWidth = 1
        self.avatar.layer.borderColor = .init(red: 0, green: 0, blue: 0, alpha: 0.15)
        self.avatar.layer.cornerRadius = sizeOfAvatar / 2
        /* - - - - - - - - - - - - - - - - - - - */
        
        // Добавление объекта к родительскому вью
        /* - - - - - - - - - - - - - - - - - - - */
        self.view.addSubview(self.avatar)
        /* - - - - - - - - - - - - - - - - - - - */
        
        // Обрезка изображения аватара по форме и размеру аватара
        /* - - - - - - - - - - - - - - - - - - - */
        self.avatar.clipsToBounds = true
        /* - - - - - - - - - - - - - - - - - - - */
        
        // Настройка цвета заднего фона аватара
        /* - - - - - - - - - - - - - - - - - - - */
        self.avatar.backgroundColor = .white
        /* - - - - - - - - - - - - - - - - - - - */
        
        // Установка ограничений
        /* - - - - - - - - - - - - - - - - - - - */
        self.addConstraintsToAvatar()
        /* - - - - - - - - - - - - - - - - - - - */
    }
    
    private func addConstraintsToAvatar() -> Void {
        self.avatar.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.avatar.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 60),
            self.avatar.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.avatar.widthAnchor.constraint(equalToConstant: sizeOfAvatar),
            self.avatar.heightAnchor.constraint(equalToConstant: sizeOfAvatar)
        ])
    }
    
    func setUpImageForAvatar(person: Person?) -> Void {
        if let person {
            if let personAvatar = person.avatar {
                self.avatar.image = personAvatar
            } else {
                switch person.gender {
                case .man:
                    self.avatar.image = UIImage(named: "man.png")
                case .woman:
                    self.avatar.image = UIImage(named: "woman.png")
                }
            }
        } else {
            self.avatar.image = UIImage(named: "person.png")
        }
    }
    /*========================================================*/
    
    
    
    // MARK: - Метод для настройки кнопки "Изменить фотографию"
    /*========================================================*/
    private func changeThePhotoButtonSetting() {
        
        // Настройка цвета кнопки
        /* - - - - - - - - - - - - - - - - - - - */
        self.changeThePhotoButton.setTitleColor(colorOfUIviews, for: .normal)
        self.changeThePhotoButton.setTitleColor(UIColor(red: 1, green: 0, blue: 0, alpha: 0.25), for: .highlighted)
        /* - - - - - - - - - - - - - - - - - - - */
        
        // Настройка текста кнопки
        /* - - - - - - - - - - - - - - - - - - - */
        self.changeThePhotoButton.setTitle("Изменить фотографию", for: .normal)
        self.changeThePhotoButton.titleLabel?.font = .systemFont(ofSize: 17, weight: .regular)
        /* - - - - - - - - - - - - - - - - - - - */
        
        // Добавление объекта к родительскому вью
        /* - - - - - - - - - - - - - - - - - - - */
        self.view.addSubview(self.changeThePhotoButton)
        /* - - - - - - - - - - - - - - - - - - - */
        
        // Установка ограничений
        /* - - - - - - - - - - - - - - - - - - - */
        self.addConstraintsToChangeThePhotoButton()
        /* - - - - - - - - - - - - - - - - - - - */
    }
    
    private func addConstraintsToChangeThePhotoButton() -> Void {
        self.changeThePhotoButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.changeThePhotoButton.topAnchor.constraint(equalTo: self.avatar.bottomAnchor, constant: 0),
            self.changeThePhotoButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
    }
    /*========================================================*/
    
    
    
    // MARK: - Метод для настройки текстового поля "Имя"
    /*========================================================*/
    private func nameTfSetting() {
        
        /* - - - - - - - - - - - - - - - - - - - */
        createTextField(textfield: self.nameTF,
                        placeholder: "Имя",
                        borderStyle: .roundedRect,
                        fontSize: fontSizeForTextFields,
                        fontWeight: .thin,
                        textColor: .black,
                        backgroundColor: .white)
        /* - - - - - - - - - - - - - - - - - - - */
        
        // Добавление объекта к родительскому вью
        /* - - - - - - - - - - - - - - - - - - - */
        self.view.addSubview(self.nameTF)
        /* - - - - - - - - - - - - - - - - - - - */
        
        // Установка ограничений
        /* - - - - - - - - - - - - - - - - - - - */
        self.addConstraintsToNameTf()
        /* - - - - - - - - - - - - - - - - - - - */
        
        // Настройка иконки в левой части текстового поля "Имя"
        /* - - - - - - - - - - - - - - - - - - - */
        // Создание объекта масштабированного изображения с исходными пропорциями
        let imageForNameTextField = UIImage(systemName: "person.fill")
        
        // Создание и инициализация UI графического элемента
        let imageViewForNameTextField = UIImageView(image: imageForNameTextField)
        imageViewForNameTextField.tintColor = colorOfUIviews
        
        // Добавление UI графического элемента к текстовому полю в качестве левого элемента
        self.nameTF.leftView = imageViewForNameTextField
        self.nameTF.leftViewMode = .always
        /* - - - - - - - - - - - - - - - - - - - */
        
    }
    
    private func addConstraintsToNameTf() -> Void {
        self.nameTF.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.nameTF.topAnchor.constraint(equalTo: self.changeThePhotoButton.bottomAnchor, constant: 20),
            self.nameTF.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 50),
            self.nameTF.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
    }
    
    func setUpTextForNameTF(person: Person?) -> Void {
        if let person {
            self.nameTF.text = person.name
        }
    }
    /*========================================================*/
    
    
    
    // MARK: - Метод для настройки текстового поля "Дата рождения"
    /*========================================================*/
    private func birthdatDateTfSetting() {
        
        /* - - - - - - - - - - - - - - - - - - - */
        createTextField(textfield: self.birthdayDateTF,
                        placeholder: "Дата рождения",
                        borderStyle: .roundedRect,
                        fontSize: fontSizeForTextFields,
                        fontWeight: .thin,
                        textColor: .black,
                        backgroundColor: .white)
        /* - - - - - - - - - - - - - - - - - - - */
        
        // Добавление объекта к родительскому вью
        /* - - - - - - - - - - - - - - - - - - - */
        self.view.addSubview(self.birthdayDateTF)
        /* - - - - - - - - - - - - - - - - - - - */
        
        // Отключение системных автоматических ограничений
        /* - - - - - - - - - - - - - - - - - - - */
        self.birthdayDateTF.translatesAutoresizingMaskIntoConstraints = false
        /* - - - - - - - - - - - - - - - - - - - */
        
        // Установка ограничений
        /* - - - - - - - - - - - - - - - - - - - */
        NSLayoutConstraint.activate([
            self.birthdayDateTF.topAnchor.constraint(equalTo: self.nameTF.bottomAnchor, constant: 10),
            self.birthdayDateTF.leftAnchor.constraint(equalTo: self.nameTF.leftAnchor),
            self.birthdayDateTF.centerXAnchor.constraint(equalTo: self.nameTF.centerXAnchor)
        ])
        /* - - - - - - - - - - - - - - - - - - - */
        
        // Настройка иконки в левой части текстового поля "Дата рождения"
        /* - - - - - - - - - - - - - - - - - - - */
        // Создание объекта масштабированного изображения с исходными пропорциями
        let imageForBirthdayDateTextField = UIImage(named: "iconForBirthdayDateTextField.png")
        
        // Создание и инициализация UI графического элемента
        let imageViewForBirthdayDateTextField = UIImageView(image: imageForBirthdayDateTextField?.withTintColor(colorOfUIviews))
        imageViewForBirthdayDateTextField.contentMode = .scaleAspectFit
        imageViewForBirthdayDateTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageViewForBirthdayDateTextField.widthAnchor.constraint(equalToConstant: 20),
            imageViewForBirthdayDateTextField.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        // Добавление UI графического элемента к текстовому полю в качестве левого элемента
        self.birthdayDateTF.leftView = imageViewForBirthdayDateTextField
        self.birthdayDateTF.leftViewMode = .always
        /* - - - - - - - - - - - - - - - - - - - */
    }
    
    func setUpTextForBirthdatDateTf(person: Person?) -> Void {
        if let person {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd:MM:Y"
            let textWithBDayDate = dateFormatter.string(from: person.birthday)
            self.birthdayDateTF.text = textWithBDayDate
        }
    }
    /*========================================================*/
    
    
    
    // MARK: - Метод для настройки текстового поля "Возраст"
    /*========================================================*/
    private func ageTfSetting() {
        
        /* - - - - - - - - - - - - - - - - - - - */
        createTextField(textfield: self.ageTF,
                        placeholder: "Возраст",
                        borderStyle: .roundedRect,
                        fontSize: fontSizeForTextFields,
                        fontWeight: .thin,
                        textColor: .black,
                        backgroundColor: .white)
        /* - - - - - - - - - - - - - - - - - - - */
        
        // Добавление объекта к родительскому вью
        /* - - - - - - - - - - - - - - - - - - - */
        self.view.addSubview(self.ageTF)
        /* - - - - - - - - - - - - - - - - - - - */
        
        // Отключение системных автоматических ограничений
        /* - - - - - - - - - - - - - - - - - - - */
        self.ageTF.translatesAutoresizingMaskIntoConstraints = false
        /* - - - - - - - - - - - - - - - - - - - */
        
        // Установка ограничений
        /* - - - - - - - - - - - - - - - - - - - */
        NSLayoutConstraint.activate([
            self.ageTF.topAnchor.constraint(equalTo: self.birthdayDateTF.bottomAnchor, constant: 10),
            self.ageTF.leftAnchor.constraint(equalTo: self.nameTF.leftAnchor),
            self.ageTF.centerXAnchor.constraint(equalTo: self.nameTF.centerXAnchor)
        ])
        /* - - - - - - - - - - - - - - - - - - - */
        
        // Настройка иконки в левой части текстового поля "Возраст"
        /* - - - - - - - - - - - - - - - - - - - */
        // Создание объекта изображения
        let imageForAgeTextField = UIImage(named: "iconForAgeTextField.png")
        
        // Создание и инициализация UI графического элемента
        let imageViewForAgeTextField = UIImageView(image: imageForAgeTextField?.withTintColor(colorOfUIviews))
        
        imageViewForAgeTextField.contentMode = .scaleAspectFit
        imageViewForAgeTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageViewForAgeTextField.widthAnchor.constraint(equalToConstant: 20),
            imageViewForAgeTextField.heightAnchor.constraint(equalToConstant: 20),
        ])
        
        // Добавление UI графического элемента к текстовому полю в качестве левого элемента
        self.ageTF.leftView = imageViewForAgeTextField
        self.ageTF.leftViewMode = .always
        /* - - - - - - - - - - - - - - - - - - - */
    }
    
    func setUpTextForAgeTf(person: Person?) -> Void {
        if let person {
            self.ageTF.text = String(person.age)
        }
    }
    /*========================================================*/
    
    
    
    // MARK: - Метод для настройки текстового поля "Гендер"
    /*========================================================*/
    private func genderTFSetting() {
        
        /* - - - - - - - - - - - - - - - - - - - */
        createTextField(textfield: self.genderTF,
                        placeholder: "М / Ж",
                        borderStyle: .roundedRect,
                        fontSize: fontSizeForTextFields,
                        fontWeight: .thin,
                        textColor: .black,
                        backgroundColor: .white)
        /* - - - - - - - - - - - - - - - - - - - */
        
        // Добавление объекта к родительскому вью
        /* - - - - - - - - - - - - - - - - - - - */
        self.view.addSubview(self.genderTF)
        /* - - - - - - - - - - - - - - - - - - - */
        
        // Отключение системных автоматических ограничений
        /* - - - - - - - - - - - - - - - - - - - */
        self.genderTF.translatesAutoresizingMaskIntoConstraints = false
        /* - - - - - - - - - - - - - - - - - - - */
        
        // Установка ограничений
        /* - - - - - - - - - - - - - - - - - - - */
        NSLayoutConstraint.activate([
            self.genderTF.topAnchor.constraint(equalTo: self.ageTF.bottomAnchor, constant: 10),
            self.genderTF.leftAnchor.constraint(equalTo: self.nameTF.leftAnchor),
            self.genderTF.centerXAnchor.constraint(equalTo: self.nameTF.centerXAnchor)
        ])
        /* - - - - - - - - - - - - - - - - - - - */
        
        // Настройка иконки в левой части текстового поля "Гендер"
        /* - - - - - - - - - - - - - - - - - - - */
        // Создание объекта масштабированного изображения с исходными пропорциями
        let imageForGenderTextField = UIImage(named: "iconForGenderTextField.png")
        
        // Создание и инициализация UI графического элемента
        let imageViewForGenderTextField = UIImageView(image: imageForGenderTextField?.withTintColor(colorOfUIviews))
        
        imageViewForGenderTextField.contentMode = .scaleAspectFit
        imageViewForGenderTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageViewForGenderTextField.widthAnchor.constraint(equalToConstant: 20),
            imageViewForGenderTextField.heightAnchor.constraint(equalToConstant: 20),
        ])
        
        // Добавление UI графического элемента к текстовому полю в качестве левого элемента
        self.genderTF.leftView = imageViewForGenderTextField
        self.genderTF.leftViewMode = .always
        /* - - - - - - - - - - - - - - - - - - - */
        
    }
    
    func setUpTextForGenderTF(person: Person?) -> Void {
        if let person {
            switch person.gender {
            case .man: self.genderTF.text = "М"
            case .woman: self.genderTF.text = "Ж"
            }
        }
    }
    /*========================================================*/
    
    
    
    // MARK: - Метод для настройки текстового графического элемента с поздравлением
    /*========================================================*/
    private func congratulationTvSetting() {
        
        // Настройка границ
        /* - - - - - - - - - - - - - - - - - - - */
        self.congratulationTV.layer.borderColor = .init(red: 0, green: 0, blue: 0, alpha: 0.07)
        self.congratulationTV.layer.borderWidth = 1
        self.congratulationTV.layer.cornerRadius = 5
        /* - - - - - - - - - - - - - - - - - - - */
        
        // Настройка шрифта
        /* - - - - - - - - - - - - - - - - - - - */
        self.congratulationTV.font = .systemFont(ofSize: fontSizeForTextFields, weight: .thin)
        /* - - - - - - - - - - - - - - - - - - - */
        
        // Настройка текстового заполнителя
        /* - - - - - - - - - - - - - - - - - - - */
        self.congratulationTV.placeholder = "Напишите своё поздравление"
        /* - - - - - - - - - - - - - - - - - - - */
        
        // Добавление объекта к родительскому вью
        /* - - - - - - - - - - - - - - - - - - - */
        self.view.addSubview(self.congratulationTV)
        /* - - - - - - - - - - - - - - - - - - - */
        
        // Отключение автоматических ограничений
        /* - - - - - - - - - - - - - - - - - - - */
        self.congratulationTV.translatesAutoresizingMaskIntoConstraints = false
        /* - - - - - - - - - - - - - - - - - - - */
        
        // Установка ограничений
        /* - - - - - - - - - - - - - - - - - - - */
        NSLayoutConstraint.activate([
            self.congratulationTV.topAnchor.constraint(equalTo: self.genderTF.bottomAnchor, constant: 10),
            self.congratulationTV.heightAnchor.constraint(equalToConstant: 100),
            self.congratulationTV.leftAnchor.constraint(equalTo: self.nameTF.leftAnchor),
            self.congratulationTV.centerXAnchor.constraint(equalTo: self.nameTF.centerXAnchor)
        ])
        /* - - - - - - - - - - - - - - - - - - - */
    }
    
    func setUpTextForCongratulatioTv(person: Person?) -> Void {
        if let person {
            if let congratulationText = person.congratulation {
                self.congratulationTV.text = congratulationText
            }
        }
    }
    /*========================================================*/
    
    
    
    // MARK: - Метод для настройки подложки
    /*========================================================*/
    private func subViewSetting() {
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
            self.subView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10),
            self.subView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -10),
            self.subView.bottomAnchor.constraint(equalTo: self.congratulationTV.bottomAnchor, constant: 10)
        ])
    }
    /*========================================================*/
    
    
    
    // MARK: - Метод для настройки уведомительной метки
    /*========================================================*/
    private func noticeLabelSetting() {
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
            self.noticeLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.noticeLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 50)
        ])
    }
    /*========================================================*/
    
    
    
    // MARK: - Метод для настройки размера контента UIScrollView
    /*========================================================*/
    private func setUpScrollViewContentSize() {
        NSLayoutConstraint.activate([
            self.view.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor),
            self.view.bottomAnchor.constraint(equalTo: self.noticeLabel.bottomAnchor, constant: 50)
        ])
    }
    /*========================================================*/
    
    
    
    // MARK: - Метод для регистриации объекта PersonProfileView в центре уведомлений
    /*========================================================*/
    private func registationInTheNotificationCenter() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(notification:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(notification:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    /*========================================================*/
    
    
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            
            let keyboardHeight           = keyboardFrame.cgRectValue.height
            let safeAreaBottomInset      = self.safeAreaInsets.bottom
            let scrollViewContentHeight  = self.scrollView.contentSize.height
            let newScrollViewFrameHeight = self.scrollView.frame.height
            let oldScrollViewFrameHeight = newScrollViewFrameHeight + keyboardHeight - safeAreaBottomInset
            
            if scrollViewContentHeight <= oldScrollViewFrameHeight {
                let differenceBetweenContentHeightAndOldFrameHeight = oldScrollViewFrameHeight - scrollViewContentHeight
                self.scrollView.contentOffset.y = keyboardHeight - differenceBetweenContentHeightAndOldFrameHeight - safeAreaBottomInset
            } else {
                self.scrollView.contentOffset.y += (keyboardHeight - self.view.safeAreaInsets.bottom)
            }
            
        }
    }
    
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            
            let keyboardHeight           = keyboardFrame.cgRectValue.height
            let safeAreaBottomInset      = self.safeAreaInsets.bottom
            let scrollViewContentHeight  = self.scrollView.contentSize.height
            let newScrollViewFrameHeight = self.scrollView.frame.height
            let oldScrollViewFrameHeight = newScrollViewFrameHeight + keyboardHeight - safeAreaBottomInset
            
            if scrollViewContentHeight <= oldScrollViewFrameHeight {
                self.scrollView.contentOffset = CGPoint(x: 0, y: 0)
            }
            
        }
        
    }
    
    
    
    // MARK: - Инициализаторы
    /*========================================================*/
    init(person: Person? = nil) {
        
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        
        self.toolBarSetting()
        self.setUpTitleForAddButton(person: person)
        self.setUpScrollView()
        self.setUpView()
        self.avatarSetting()
        self.setUpImageForAvatar(person: person)
        self.changeThePhotoButtonSetting()
        self.nameTfSetting()
        self.setUpTextForNameTF(person: person)
        self.birthdatDateTfSetting()
        self.setUpTextForBirthdatDateTf(person: person)
        self.ageTfSetting()
        self.setUpTextForAgeTf(person: person)
        self.genderTFSetting()
        self.setUpTextForGenderTF(person: person)
        self.congratulationTvSetting()
        self.setUpTextForCongratulatioTv(person: person)
        self.subViewSetting()
        self.noticeLabelSetting()

        self.setUpScrollViewContentSize()
        self.registationInTheNotificationCenter()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /*========================================================*/
    
}
