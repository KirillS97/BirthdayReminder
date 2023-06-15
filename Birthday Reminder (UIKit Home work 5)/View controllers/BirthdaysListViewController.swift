import UIKit



class BirthdaysListViewController: UIViewController {
    
    typealias WrapOfPersonUI = (wrap:           UIView,
                                avatar:         UIImageView,
                                imageForAvatar: UIImage?,
                                labelName:      UILabel,
                                bdayDateLabel:  UILabel,
                                noticeLabel:    UILabel)
    
    
    
    // MARK: - Хранимые свойства
    /*------------------------------------------------------------------------------*/
    /*------------------------------------------------------------------------------*/
    var persons: [Person: WrapOfPersonUI] = [:]
    var sortedArrayOfPersons: [Person] = []
    let mainStroryboard = UIStoryboard(name: "Main", bundle: nil)
    /*------------------------------------------------------------------------------*/
    /*------------------------------------------------------------------------------*/



    // MARK: - "viewDidLoad" method
    /*------------------------------------------------------------------------------*/
    /*------------------------------------------------------------------------------*/
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        // MARK: Настройка корневогого "View"
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        self.view.backgroundColor = viewColor
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */



        // MARK: Настройка панели навигации
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */

        // Добавление заголовка на панель навигации
        self.navigationItem.title  = "Birthdays List"

        // Создание кнопки "Добавить" для панели навигации
        let addButton = UIBarButtonItem(image: UIImage(systemName: "plus"),
                                        style: .done,
                                        target: self,
                                        action: #selector(goToPersonProfileVC))

        // Размещение кнопки "Добавить" на панели навигации
        self.navigationItem.rightBarButtonItem = addButton

        // Изменение цвета кнопок на панели навигации
        self.navigationController?.navigationBar.tintColor = colorOfUIviews
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
    }
    /*------------------------------------------------------------------------------*/
    /*------------------------------------------------------------------------------*/
    
    
    
    // MARK: - обработчик нажатия на кнопку "Добавить"
    /*------------------------------------------------------------------------------*/
    /*------------------------------------------------------------------------------*/

    @objc func goToPersonProfileVC() {
        let personProfileVC = (mainStroryboard.instantiateViewController(identifier: "PersonProfileViewController") as! PersonProfileViewController)
        self.present(personProfileVC, animated: true, completion: {
            personProfileVC.closureForDataTransmission = { (name: String,
                                                            birthdayDate: Date,
                                                            gender: Person.Gender,
                                                            instagramAccount: String,
                                                            avatarImage: UIImage?) in
                let personForAddition = Person(name: name,
                                               birthday: birthdayDate,
                                               gender: gender,
                                               instagramAccount: instagramAccount)
                self.addPersonToTheList(person: personForAddition, avatarImage: avatarImage)
                for subview in self.view.subviews {
                        subview.removeFromSuperview()
                    }
                self.createUI(arrayOfPerson: self.sortedArrayOfPersons)
            }
        })
    }

    /*------------------------------------------------------------------------------*/
    /*------------------------------------------------------------------------------*/



    // MARK: - метод для добавления нового пользователя в список
    /*------------------------------------------------------------------------------*/
    /*------------------------------------------------------------------------------*/
    func addPersonToTheList(person: Person, avatarImage: UIImage?) {
        
        // MARK: Объявление и инициализация графических элементов
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        let wrap          = UIView()        // Корзина или обёртка
        var avatar        = UIImageView()   // Аватар человека
        let labelName     = UILabel()       // Метка с именем и возрастом человека
        let noticeLabel   = UILabel()       // Метка с количеством дней до следующего ДР
        let bdayDateLabel = UILabel()       // Метка с датой рождения
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        
        
        // MARK: Добавление человека в список
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        if let avatarImage {
            self.persons[person] = (wrap: wrap,
                                    avatar: avatar,
                                    imageForAvatar: avatarImage,
                                    labelName: labelName,
                                    bdayDateLabel: bdayDateLabel,
                                    noticeLabel: noticeLabel)
        } else {
            self.persons[person] = (wrap: wrap,
                                    avatar: avatar,
                                    imageForAvatar: nil,
                                    labelName: labelName,
                                    bdayDateLabel: bdayDateLabel,
                                    noticeLabel: noticeLabel)
        }
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        
        
        // MARK: Обновление отсортированного массива людей
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        updateSortedArrayOfPersons()
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
    }
    /*------------------------------------------------------------------------------*/
    /*------------------------------------------------------------------------------*/
    
    
    
    // MARK: - Метод для добавления графических элементов отображения списка пользователей
    /*------------------------------------------------------------------------------*/
    /*------------------------------------------------------------------------------*/
    func createUI(arrayOfPerson: [Person]) {
        
        arrayOfPerson.forEach { (person: Person) in
            
            // MARK: Локальные переменные
            /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
            let wrap                 = persons[person]!.wrap
            let avatar               = persons[person]!.avatar
            let imageForAvatar       = persons[person]?.imageForAvatar
            let labelName            = persons[person]!.labelName
            let bdayDateLabel        = persons[person]!.bdayDateLabel
            let noticeLabel          = persons[person]!.noticeLabel
            /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
            
            
            
            // MARK: Настройка вью, выполняющего роль корзины
            /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
            
            // Настройка цвета
            wrap.backgroundColor = .white

            // Настройка размера и формы
            wrap.layer.cornerRadius = 12.5
            let heightOfWrapView: CGFloat = 150

            // Добавление объекта к родительскому вью
            self.view.addSubview(wrap)

            // Отключение автоматических ограничений
            wrap.translatesAutoresizingMaskIntoConstraints = false
            
            // Установка ограничений
            NSLayoutConstraint.activate([
                wrap.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.95),
                wrap.heightAnchor.constraint(equalToConstant: heightOfWrapView),
                wrap.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
            ])
            
            if sortedArrayOfPersons.first == person {
                wrap.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
            }
            else {
                var positionInTheSortedArray: Int = 0
                for i in 0..<self.sortedArrayOfPersons.count {
                    if self.sortedArrayOfPersons[i] == person {
                        positionInTheSortedArray = i
                    }
                }
                let previousPerson = self.sortedArrayOfPersons[positionInTheSortedArray - 1]
                wrap.topAnchor.constraint(equalTo: persons[previousPerson]!.wrap.bottomAnchor, constant: 10).isActive = true
            }
            
            /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
            
            
            
            // MARK: Аватар
            /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
            
            // Размер аватара
            let sizeOfAvatar: CGFloat = 125
            
            // Позиционирвоание аватара в "обёртке" с помощью фрейма
            avatar.frame = CGRect(x: ( (heightOfWrapView - sizeOfAvatar) / 2 ),
                                  y: ( (heightOfWrapView - sizeOfAvatar) / 2 ),
                                  width: sizeOfAvatar,
                                  height: sizeOfAvatar)
            
            // Закругления сопряжений аватара для достижения формы круга
            avatar.layer.cornerRadius = (sizeOfAvatar / 2)
            
            // Обрезка изображения аватара по границам круга
            avatar.clipsToBounds = true
            
            // Добавление аватара к корневому вью
            wrap.addSubview(avatar)
            
            // Добавление изображения аватара
            if imageForAvatar == nil {
                if person.gender == .man {
                    avatar.image = UIImage(named: "man.png")
                } else {
                    avatar.image = UIImage(named: "woman.png")
                }
            } else {
                avatar.image = imageForAvatar
            }
            
            // Рисовка границ аватара
            avatar.layer.borderWidth = 1
            avatar.layer.borderColor = .init(red: 0, green: 0, blue: 0, alpha: 0.5)
            
            /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
            
            
            
            // MARK: Метка с именем
            /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
            
            // Настройка метки
            createLabel(label: labelName,
                        text: "\(person.name), \(person.age)",
                        fontSize: 25,
                        fontWeight: .semibold,
                        textColor: .darkGray,
                        isCenterTextAlignment: false)
            
            // Добавление метки к родительскому вью
            wrap.addSubview(labelName)
            
            // Отключение автоматических ограничений
            labelName.translatesAutoresizingMaskIntoConstraints = false
            
            // Установка ограничений
            NSLayoutConstraint.activate([
                labelName.leftAnchor.constraint(equalTo: avatar.rightAnchor, constant: 10),
                labelName.centerYAnchor.constraint(equalTo: avatar.centerYAnchor, constant: -25)
            ])
            
            /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
            
            
            
            // MARK: Метка с напоминанием
            /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
            // Настройка метки
            createLabel(label: noticeLabel,
                        text: updateTheDateForThePerson(person: person),
                        numberOfLines: 2,
                        fontSize: 17,
                        fontWeight: .regular,
                        textColor: .black,
                        isCenterTextAlignment: false)
            
            // Добавление метки к родительскому вью
            wrap.addSubview(noticeLabel)
            
            // Отключение автоматических ограничений
            noticeLabel.translatesAutoresizingMaskIntoConstraints = false
            
            // Установка ограничений
            NSLayoutConstraint.activate([
                noticeLabel.leftAnchor.constraint(equalTo: labelName.leftAnchor),
                noticeLabel.bottomAnchor.constraint(equalTo: wrap.bottomAnchor, constant: -5),
                noticeLabel.rightAnchor.constraint(equalTo: wrap.rightAnchor, constant: -12.5)
            ])
            
            /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
            
            
            
            // MARK: Метка с датой дня рождения
            /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.Y"
            
            createLabel(label: bdayDateLabel,
                        text: dateFormatter.string(from: person.birthday),
                        numberOfLines: 1,
                        fontSize: 20,
                        fontWeight: .medium,
                        textColor: .darkGray,
                        isCenterTextAlignment: false)
            
            // Добавление объекта к родительскому вью
            wrap.addSubview(bdayDateLabel)
            
            // Отключение автоматических ограничений
            bdayDateLabel.translatesAutoresizingMaskIntoConstraints = false
            
            // Установка ограничений
            NSLayoutConstraint.activate([
                bdayDateLabel.leftAnchor.constraint(equalTo: labelName.leftAnchor),
                bdayDateLabel.centerYAnchor.constraint(equalTo: avatar.centerYAnchor, constant: 0)
            ])
            /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
            
        } // Конец цикла "for each"
    }
    /*------------------------------------------------------------------------------*/
    /*------------------------------------------------------------------------------*/
    
    
    
    // MARK: - Метод для формирования правильного текста в уведомительной метки
    /*------------------------------------------------------------------------------*/
    /*------------------------------------------------------------------------------*/
    func updateTheDateForThePerson(person: Person) -> String {
        
        // Текст для уведомительной метки с остатком дней до дня рождения
        var textForNoticeLabel: String = ""
        
        // Настройка текста уведомительной метки
        let daysNumber = String(person.numberOfDaysUntilBirthday)
        
        if daysNumber.count == 1 {
            switch daysNumber {
            case "0": textForNoticeLabel = "Сегодня отмечает \(person.age)"
            case "1": textForNoticeLabel = "Завтра отмечает \(person.age + 1)"
            case "2": textForNoticeLabel = "Послезавтра отмечает \(person.age + 1)"
            case let day where (day == "3") || (day == "4"):
                textForNoticeLabel = "Отмечает \(person.age + 1) через \(daysNumber) дня"
            default:
                textForNoticeLabel = "Отмечает \(person.age + 1) через \(daysNumber) дней"
            }
        } else {
            switch daysNumber {
            case let day where day[day.index(day.endIndex, offsetBy: -2)] == "1":
                textForNoticeLabel = "Отмечает \(person.age + 1) через \(daysNumber) дней"
            case let day where ( day[day.index(day.endIndex, offsetBy: -1)] == "2" ) ||
                ( day[day.index(day.endIndex, offsetBy: -1)] == "3" ) ||
                ( day[day.index(day.endIndex, offsetBy: -1)] == "4" ):
                textForNoticeLabel = "Отмечает \(person.age + 1) через \(daysNumber) дня"
            case let day where day[day.index(day.endIndex, offsetBy: -1)] == "1":
                textForNoticeLabel = "Отмечает \(person.age + 1) через \(daysNumber) день"
            default:
                textForNoticeLabel = "Отмечает \(person.age + 1) через \(daysNumber) дней"
            }
        }
        return textForNoticeLabel
    }
    /*------------------------------------------------------------------------------*/
    /*------------------------------------------------------------------------------*/
    
    
    
    // MARK: - Метод для создания массива людей, отсортированного по количеству дней до их предстоящего дня рождения
    /*------------------------------------------------------------------------------*/
    /*------------------------------------------------------------------------------*/
    func getSortedArrayOfPersons() -> [Person] {
        let sortedArray = self.persons.sorted { pair1, pair2 in
            let (person1, _) = pair1
            let (person2, _) = pair2
            return (person1.numberOfDaysUntilBirthday < person2.numberOfDaysUntilBirthday)
        }.map { (person: Person, _) in
            person
        }
        return sortedArray
    }
    /*------------------------------------------------------------------------------*/
    /*------------------------------------------------------------------------------*/
    
    
    
    // MARK: - Обновление отсортированного массива людей
    /*------------------------------------------------------------------------------*/
    /*------------------------------------------------------------------------------*/
    func updateSortedArrayOfPersons() {
        self.sortedArrayOfPersons = getSortedArrayOfPersons()
    }
    /*------------------------------------------------------------------------------*/
    /*------------------------------------------------------------------------------*/
    


}
