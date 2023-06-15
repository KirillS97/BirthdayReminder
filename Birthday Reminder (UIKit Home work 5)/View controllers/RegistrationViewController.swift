import UIKit

class RegistrationViewController: UIViewController {
    
    // MARK: - Хранимые свойства
    /*------------------------------------------------------------------------------*/
    /*------------------------------------------------------------------------------*/
    
    //Изображение вверху сцены с логотоипом ресторана
    var imageForLogo: UIImage!
    var logo: UIImageView!
    
    // Метки с текстом
    var labelSignIn, labelEmail, labelPassword, labelNotice: UILabel!
    
    // Текстовые поля
    var emailTextField, passwordTextField: UITextField!
    
    // Кнопка "Войти"
    var buttonEnter: UIButton!
    
    // Кнопка "Продолжить как гость"
    var buttonEnterForGuest: UIButton!
    
    // Кнопка с глазом для сокрытия пароля в текстовом поле
    var buttonForHidePassword: UIButton!
    
    //Библиотека зарегестрированных пользователей
    var registeredUsers = RegisteredUsers()
    
    /*------------------------------------------------------------------------------*/
    /*------------------------------------------------------------------------------*/
    
    
    
    // MARK: - "viewDidLoad" method
    /*------------------------------------------------------------------------------*/
    /*------------------------------------------------------------------------------*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: Добавление нового пользователя
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        self.registeredUsers.registerUser(firstName: "Tim",
                                          lastName: "Cook",
                                          email: "TimCook@apple.com",
                                          password: "Apple")
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        
        
        // MARK: Настройка заголовка кнопки возврата на эту сцену
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        self.navigationItem.backButtonTitle = "sign in"
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        
        
        // MARK: Настройка корневогого "View"
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        self.view.backgroundColor = viewColor
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        
        
        // MARK: Настройка изображения вверху сцены
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        // Инициализация объектов
        self.imageForLogo = UIImage(named: "mainIcon.png")?.scaleImage(targetWidth: self.view.frame.width * 0.5)
        self.logo = UIImageView()
        
        // Добавление к объекту изображения
        self.logo.image = imageForLogo
        
        // Добавление объекта изображения к корневому "View"
        self.view.addSubview(self.logo)
        
        // Отключение системных ограничений
        self.logo.translatesAutoresizingMaskIntoConstraints = false
        
        // Позиционирование объекта изображения на сцене с помощью ограничений
        NSLayoutConstraint.activate([
            self.logo.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            self.logo.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor,
                                           constant: 0)
        ])
        
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        
        
        // MARK: Настройка текстового поля "Email"
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        // Инициализация
        self.emailTextField = UITextField()
        
        // Настройка текстового поля
        createTextField(textfield: self.emailTextField,
                        placeholder: "user@mail.com",
                        borderStyle: .roundedRect)
        
        // Добавление текстового поля на родительский вью
        self.view.addSubview(self.emailTextField)
        
        // Отключение автоматических ограничений
        self.emailTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.emailTextField.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor,
                                                      constant: 50),
            self.emailTextField.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor,
                                                       constant: -50),
            self.emailTextField.topAnchor.constraint(equalTo: self.logo.bottomAnchor,
                                                     constant: 90)
        ])
        
        // Добавление обработчика нажатия на текстовое поле
        self.emailTextField.addTarget(self, action: #selector(removeTextOfLabelNotice), for: .touchDown)
        
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        
        
        // MARK: Настройка иконки в левой части текстового поля "Email"
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        // Создание объекта масштабированного изображения с исходными пропорциями
        let personImage = UIImage(systemName: "person.fill")
        
        // Создание и инициализация UI графического элемента
        let personImageView = UIImageView(image: personImage)
        personImageView.tintColor = colorOfUIviews
        
        // Добавление UI графического элемента к текстовому полю в качестве левого элемента
        self.emailTextField.leftView = personImageView
        self.emailTextField.leftViewMode = .always
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        
        
        // MARK: Настройка текстового поля "Пароль"
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        // Инициализация
        self.passwordTextField = UITextField()
        
        // Настройка текстового поля
        createTextField(textfield: self.passwordTextField,
                        placeholder: "qwerty",
                        borderStyle: .roundedRect)
        
        // Добавление текстового поля на родительский вью
        self.view.addSubview(self.passwordTextField)
        
        // Отключение автоматических ограничений
        self.passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.passwordTextField.leftAnchor.constraint(equalTo: self.emailTextField.leftAnchor),
            self.passwordTextField.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor,
                                                          constant: -50),
            self.passwordTextField.topAnchor.constraint(equalTo: self.emailTextField.bottomAnchor,
                                                        constant: 20)
        ])
        
        // Добавление обработчика нажатия на текстовое поле
        self.passwordTextField.addTarget(self, action: #selector(removeTextOfLabelNotice), for: .touchDown)
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        
        
        // MARK: Настройка иконки в левой части текстового поля "Пароль"
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        // Создание объекта масштабированного изображения с исходными пропорциями
        let lockImage = UIImage(systemName: "lock.fill")
        
        // Создание и инициализация графического элемента пользовательского интерфейса
        let lockImageView = UIImageView(image: lockImage)
        lockImageView.tintColor = colorOfUIviews
        
        // Добавление UI графического элемента к текстовому полю в качестве левого элемента
        self.passwordTextField.leftView = lockImageView
        self.passwordTextField.leftViewMode = .always
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        
        
        // MARK: Настройка кнопки сокрытия текста для текстового поля "Пароль"
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        // Инициализация
        self.buttonForHidePassword = UIButton()
        
        // Добавление обработчика нажатия на кнопку
        self.buttonForHidePassword.addTarget(self, action: #selector(hideTheText), for: .touchUpInside)


        // Установка изображения
        hideTheText()
        
        self.passwordTextField.rightView = self.buttonForHidePassword
        self.passwordTextField.rightViewMode = .always
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        
        
        // MARK: Настройка метки с уведомлением
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        // Инициализация объекта
        self.labelNotice = UILabel()
        
        // Настройка внешнего вида метки
        createLabel(label: self.labelNotice,
                    text: "",
                    numberOfLines: 2,
                    fontWeight: .light,
                    textColor: colorOfUIviews,
                    isCenterTextAlignment: true)
        
        // Добавление метки на родительский вью
        self.view.addSubview(self.labelNotice)
        
        // Отключение автоматических ограничений
        self.labelNotice.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.labelNotice.leftAnchor.constraint(equalTo: self.emailTextField.leftAnchor),
            self.labelNotice.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.labelNotice.topAnchor.constraint(equalTo: self.passwordTextField.bottomAnchor,
                                                  constant: 20)
        ])
        
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        
        
        // MARK: Настройка кнопки "Продолжить как гость"
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        // Инициализация объекта
        self.buttonEnterForGuest = UIButton()
        
        // Настройка внешнего вида кнопки
        createButton(button: self.buttonEnterForGuest, title: "Продолжить как гость")
        
        // Добавление кнопки на родительский вью
        self.view.addSubview(self.buttonEnterForGuest)
        
        // Отключение автоматических ограничений
        self.buttonEnterForGuest.translatesAutoresizingMaskIntoConstraints = false
        
        // Позиционирование объекта кнопки на сцене с помощью ограничений
        NSLayoutConstraint.activate([
            self.buttonEnterForGuest.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.buttonEnterForGuest.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor,
                                                   constant: 50),
            self.buttonEnterForGuest.topAnchor.constraint(equalTo: self.passwordTextField.bottomAnchor,
                                                          constant: 80)
        ])
        
        // Добавление обработчика нажатия на кнопку
        self.buttonEnterForGuest.addTarget(self, action: #selector(tryEnter(sender:)), for: .touchUpInside)
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        
        
        // MARK: Настройка кнопки "Войти"
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        // Инициализация объекта
        self.buttonEnter = UIButton()
        
        // Настройка внешнего вида кнопки
        createButton(button: self.buttonEnter, title: "Войти")
        
        // Добавление кнопки на родительский вью
        self.view.addSubview(self.buttonEnter)
        
        // Отключение автоматических ограничений
        self.buttonEnter.translatesAutoresizingMaskIntoConstraints = false
        
        // Позиционирование объекта кнопки на сцене с помощью ограничений
        NSLayoutConstraint.activate([
            self.buttonEnter.centerXAnchor.constraint(equalTo: self.buttonEnterForGuest.centerXAnchor),
            self.buttonEnter.leftAnchor.constraint(equalTo: self.buttonEnterForGuest.leftAnchor),
            self.buttonEnter.topAnchor.constraint(equalTo: self.buttonEnterForGuest.bottomAnchor,
                                                     constant: 30)
        ])
        
        // Добавление обработчика нажатия на кнопку
        self.buttonEnter.addTarget(self, action: #selector(tryEnter(sender:)), for: .touchUpInside)
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        
    }
    
    /*------------------------------------------------------------------------------*/
    /*------------------------------------------------------------------------------*/
    
    
    
    // MARK: - "viewWillAppear" method
    /*------------------------------------------------------------------------------*/
    /*------------------------------------------------------------------------------*/
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.labelNotice.text = ""
        self.emailTextField.text = ""
        self.passwordTextField.text = ""
    }
    /*------------------------------------------------------------------------------*/
    /*------------------------------------------------------------------------------*/
    
    
    
    // MARK: - Обработчик нажатия на кнопку "Войти"
    /*------------------------------------------------------------------------------*/
    /*------------------------------------------------------------------------------*/
    
    @objc func tryEnter(sender: UIButton) {
        
        if sender ===  buttonEnter {
            switch (emailTextField.text, passwordTextField.text) {
            case let (email, password) where (email!.isEmpty) || (password!.isEmpty):
                self.labelNotice.text = "Заполните все поля"
            case let (email, password):
                if !self.registeredUsers.userVerification(email: email!, password: password!) {
                    self.labelNotice.text = "Введён неправильный Email или пароль"
                } else {
                    performSegue(withIdentifier: "goToBirthdaysListViewController", sender: nil)
                }
            }
        }
        
        if sender === buttonEnterForGuest {
            performSegue(withIdentifier: "goToBirthdaysListViewController", sender: nil)
        }
    }
    
    /*------------------------------------------------------------------------------*/
    /*------------------------------------------------------------------------------*/
    
    
    
    // MARK: - Обработчик нажатия на кнопку сокрытия пароля
    /*------------------------------------------------------------------------------*/
    /*------------------------------------------------------------------------------*/
    
    @objc func hideTheText() {
        
        if self.passwordTextField.isSecureTextEntry { self.passwordTextField.isSecureTextEntry = false }
        else { self.passwordTextField.isSecureTextEntry = true }
        
        if !passwordTextField.isSecureTextEntry {
            self.buttonForHidePassword.setImage(UIImage(systemName: "eye"), for: .normal)
        } else {
            self.buttonForHidePassword.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        }
        
        self.buttonForHidePassword.tintColor = .darkGray
        
    }
    
    /*------------------------------------------------------------------------------*/
    /*------------------------------------------------------------------------------*/
    
    
    
    // MARK: - Обработчик нажатия для удаления текста уведомительной метки
    /*------------------------------------------------------------------------------*/
    /*------------------------------------------------------------------------------*/
    
    @objc func removeTextOfLabelNotice() {
        self.labelNotice.text = ""
    }
    
    /*------------------------------------------------------------------------------*/
    /*------------------------------------------------------------------------------*/
        
    
}
