import UIKit


// MARK: - класс "BirthdaysListViewController"
/*---------------------------------------------------------------------------------------------*/
class BirthdaysListViewController: UIViewController {
    

    // MARK: - Хранимые свойства
    /*==================================================================*/
    // Экземпляр Core Data Manager
    private let coreDataManager = CoreDataManager.shared
    
    // Массив людей
    var persons: [Person] = [] {
        didSet {
            self.persons.sort(by: { (person1: Person, person2: Person) -> Bool in
                return person1.numberOfDaysUntilBirthday < person2.numberOfDaysUntilBirthday
            })
        }
    }
    
    // Объект сториборда
    let mainStroryboard = UIStoryboard(name: "Main", bundle: nil)
    
    // Таблица с карточками дней рождений
    var tableview: UITableView!
    
    // Заголовки разделов
    let birthdayInTheNextSevenDaysSectionTitle = "Дни рождения в ближайшие 7 дней"
    let birthdayInTheNextThirtyDaysSectionTitle = "Дни рождения в ближайшие 30 дней"
    let futureBirthdaySectionTitle = "Будущие Дни рождения"
    
    // Массив заголовков разделов таблицы
    var tableViewSectionsTitlesArray: [String] = []
    
    // Словарь, ключем которого является заголовок таблицы, а значением массив людей, день рождение которых соответствует заголовку
    var personsDictionary: [String: [Person]] = [:]
    /*==================================================================*/



    // MARK: - "viewDidLoad" method
    /*==================================================================*/
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        // MARK: Настройка главного "View"
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        self.view.backgroundColor = viewColor
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - */



        // MARK: Настройка панели навигации
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        // Добавление заголовка на панель навигации
        self.navigationItem.title  = "Birthdays List"

        // Создание кнопки "Добавить" для панели навигации
        let addButton = UIBarButtonItem(image: UIImage(systemName: "plus"),
                                        style: .done,
                                        target: self,
                                        action: #selector(addButtonHandler(sender:)))

        // Размещение кнопки "Добавить" на панели навигации
        self.navigationItem.rightBarButtonItem = addButton

        // Изменение цвета кнопок на панели навигации
        self.navigationController?.navigationBar.tintColor = colorOfUIviews
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        
        
        // MARK: Настройка таблицы
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        // Инициализация таблицы
        self.tableview = UITableView(frame: self.view.bounds, style: .plain)
        
        // Назначение источники данных и делегата
        self.tableview.dataSource = self
        self.tableview.delegate = self
        
        self.tableview.estimatedRowHeight = 150
        
        // Добавление таблицы к родительскому вью
        self.view.addSubview(self.tableview)
        
        // Настройка цвета таблицы
        self.tableview.backgroundColor = viewColor
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        
        
        // MARK: Извлечение данных из контекста БД и заполнение массива persons
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        self.persons = self.getPersonsArray()
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        
        // Обновление заголовков разделов
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        self.updateSectionTitles()
        self.updatePersonsDictionary()
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
    }
    /*==================================================================*/
    
    
    
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
    
    
    
    // MARK: Функция для заполнения массива заголовков разделов таблицы
    /*==================================================================*/
    private func updateSectionTitles() {
        if !self.tableViewSectionsTitlesArray.isEmpty {
            self.tableViewSectionsTitlesArray.removeAll()
        }
        for person in persons {
            var sectionTitle: String!
            
            if person.numberOfDaysUntilBirthday <= 7 {
                sectionTitle = self.birthdayInTheNextSevenDaysSectionTitle
            } else if (person.numberOfDaysUntilBirthday > 7) && (person.numberOfDaysUntilBirthday <= 30) {
                sectionTitle = self.birthdayInTheNextThirtyDaysSectionTitle
            } else {
                sectionTitle = self.futureBirthdaySectionTitle
            }
            
            if !self.tableViewSectionsTitlesArray.contains(where: { (title: String) -> Bool in
                title == sectionTitle
            }) {
                self.tableViewSectionsTitlesArray.append(sectionTitle)
            }
            
        }
    }
    /*==================================================================*/
    
    
    
    // MARK: Функция для подсчёта количества строк в разделе таблицы
    /*==================================================================*/
    private func getCountPersonsWhoseBDayMatchesTheSectionTitle(sectionTitle: String) -> Int {
        
        var personCount = 0
        
        switch sectionTitle {
        case self.birthdayInTheNextSevenDaysSectionTitle:
            for person in persons {
                if person.numberOfDaysUntilBirthday <= 7 {
                    personCount += 1
                }
            }
        case self.birthdayInTheNextThirtyDaysSectionTitle:
            for person in persons {
                if (person.numberOfDaysUntilBirthday > 7) && (person.numberOfDaysUntilBirthday <= 30) {
                    personCount += 1
                }
            }
        default:
            for person in persons {
                if person.numberOfDaysUntilBirthday > 30 {
                    personCount += 1
                }
            }
        }
        
        return personCount

    }
    /*==================================================================*/
    
    
    
    private func updatePersonsDictionary() {
        if !self.personsDictionary.isEmpty {
            self.personsDictionary.removeAll()
        }
        
        for title in self.tableViewSectionsTitlesArray {
            var arrayOfPersons: [Person] = []
            
            switch title {
            case self.birthdayInTheNextSevenDaysSectionTitle:
                for person in persons {
                    if person.numberOfDaysUntilBirthday <= 7 {
                        arrayOfPersons.append(person)
                    }
                }
            case self.birthdayInTheNextThirtyDaysSectionTitle:
                for person in persons {
                    if (person.numberOfDaysUntilBirthday > 7) && (person.numberOfDaysUntilBirthday <= 30) {
                        arrayOfPersons.append(person)
                    }
                }
            default:
                for person in persons {
                    if person.numberOfDaysUntilBirthday > 30 {
                        arrayOfPersons.append(person)
                    }
                }
            }
            
            if !arrayOfPersons.isEmpty {
                self.personsDictionary[title] = arrayOfPersons
            }
            
        }
        
    }
    
}
/*---------------------------------------------------------------------------------------------*/





// MARK: - Подписка класса "BirthdaysListViewController" на протокол "UITableViewDataSource" с помощью расширения
/*---------------------------------------------------------------------------------------------*/
extension BirthdaysListViewController: UITableViewDataSource {
    
    
    
    // MARK: - Настройка количества разделов  в таблице
    /*==================================================================*/
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.tableViewSectionsTitlesArray.count
    }
    /*==================================================================*/
    
    
    
    // MARK: - Настройка заголовков разделов
    /*==================================================================*/
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        for i in 0..<self.tableViewSectionsTitlesArray.count {
            if i == section {
                return self.tableViewSectionsTitlesArray[i]
            }
        }
        return ""
    }
    /*==================================================================*/
    
    
    
    // MARK: - Настройка количества строк в разделах таблицы
    /*==================================================================*/
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.tableViewSectionsTitlesArray.count > section {
            let sectionTitle = self.tableViewSectionsTitlesArray[section]
            return self.getCountPersonsWhoseBDayMatchesTheSectionTitle(sectionTitle: sectionTitle)
        }
        return 0
    }
    /*==================================================================*/
    
    
    
    // MARK: - Создание и конфигурация ячеек для строк таблицы
    /*==================================================================*/
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if self.personsDictionary.contains(where: { (title: String, persons: [Person]) in
            title == self.tableViewSectionsTitlesArray[indexPath.section]
        }) {
            let title = self.tableViewSectionsTitlesArray[indexPath.section]
            let cell = TableViewCellForPersonCard(person: self.personsDictionary[title]![indexPath.row],
                                                  style: .default,
                                                  reuseIdentifier: nil)
            return cell
        }
        
        return UITableViewCell()
        
    }
    /*==================================================================*/
    
    
    
    // MARK: - Обработчик нажатия на кнопку добавить
    /*==================================================================*/
    @objc func addButtonHandler(sender: UIBarButtonItem) {
        if sender.isEqual(self.navigationItem.rightBarButtonItem) {
            goToPersonProfileVC(person: nil)
        }
    }
    /*==================================================================*/
    
    
    
    // MARK: - Метод для перехода к вью контроллеру профиля пользователя
    /*==================================================================*/
    private func goToPersonProfileVC(person: Person?) {
        if let personProfileVC = self.mainStroryboard.instantiateViewController(identifier: "PersonProfileViewController") as?  PersonProfileViewController {
            personProfileVC.person = person
            personProfileVC.personProfileView = PersonProfileView(person: person)
            personProfileVC.modalPresentationStyle = .formSheet
            self.present(personProfileVC, animated: true)
            
            personProfileVC.closureForDataTransmission = { () -> Void in
                self.persons = self.getPersonsArray()
                self.updateSectionTitles()
                self.updatePersonsDictionary()
                self.tableview.reloadData()

            }
        }
        
    }
    /*==================================================================*/
    
    
}
/*---------------------------------------------------------------------------------------------*/





// MARK: - Подписка класса "BirthdaysListViewController" на протокол "UITableViewDelegate" с помощью расширения
/*---------------------------------------------------------------------------------------------*/
extension BirthdaysListViewController: UITableViewDelegate {
    
    
    
    // MARK: - Настройка действий, совершаемых над ячейками, по свайпу справа налево
    /*==================================================================*/
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        
        // Инициализация объекта "UIContextualAction", инициирующего действие удаления ячейки
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        let deleteAction = UIContextualAction(style: .destructive,
                                              title: "Удалить") { (action: UIContextualAction,
                                                                   view: UIView,
                                                                   bool: (@escaping (_) -> Void)) -> Void in
            guard self.tableViewSectionsTitlesArray.count > indexPath.section else { return }
            let sectionTitle: String = self.tableViewSectionsTitlesArray[indexPath.section]
            if let personsArray: [Person] = self.personsDictionary[sectionTitle] {
                guard personsArray.count > indexPath.row else { return }
                let selectedPerson = personsArray[indexPath.row]
                PersonEntity.deleteEntity(person: selectedPerson,
                                          context: self.coreDataManager.persistentContainer.viewContext)
                
                self.persons = self.getPersonsArray()
                self.updateSectionTitles()
                self.updatePersonsDictionary()
                self.tableview.reloadData()
            }
        }
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        
        
        // Инициализация объекта "UIContextualAction", инициирующего действие изменения ячейки
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        let changePersonAction = UIContextualAction(style: .normal,
                                              title: "Изменить") { (action: UIContextualAction,
                                                                   view: UIView,
                                                                   bool: (@escaping (_) -> Void)) -> Void in
            guard self.tableViewSectionsTitlesArray.count > indexPath.section else { return }
            let sectionTitle: String = self.tableViewSectionsTitlesArray[indexPath.section]
            if let personsArray: [Person] = self.personsDictionary[sectionTitle] {
                guard personsArray.count > indexPath.row else { return }
                let selectedPerson = personsArray[indexPath.row]
                
            loop: for i in 0..<self.persons.count {
                if self.persons[i] == selectedPerson {
                    self.goToPersonProfileVC(person: self.persons[i])
                    break loop
                    }
                }
                
                self.updateSectionTitles()
                self.updatePersonsDictionary()
                self.tableview.reloadData()
            }
        }
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        
        
        
        // Инициализация кофигурации кнопок
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        let actionsObject = UISwipeActionsConfiguration(actions: [deleteAction, changePersonAction])
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        
        
        // Возврат конфигурации кнопок
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        return actionsObject
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
    }
    /*==================================================================*/
    
    
}
/*---------------------------------------------------------------------------------------------*/

