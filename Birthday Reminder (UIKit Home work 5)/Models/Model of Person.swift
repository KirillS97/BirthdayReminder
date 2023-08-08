import UIKit

struct Person {
    
    // MARK: - Stored properties
    /*======================================*/
    var name:             String   // Имя
    var birthday:         Date     // Дата рождения
    var gender:           Gender   // Пол
    var congratulation:   String?  // Поздравление
    var avatar:           UIImage? // Аватар
    var id:               String = UUID().uuidString // Уникальный идентификатор
    /*======================================*/
    
    
    
    // MARK: - Computed properties
    /*======================================*/
    // Возраст
    var age: Int {
        let currentDate = Date()
        let fullAge = ( currentDate.timeIntervalSince(birthday) / (60 * 60 * 24 * 365) )
        return Int(fullAge)
    }
    
    // Дата следующего дня рождения
    var dateOfNextBirthday: Date {
        calculateTheDateOfNextBirthday()
    }
    
    // Количество дней до следующего дня рождения
    var numberOfDaysUntilBirthday: Int {
        calculateHowManyDaysAreLeftUntilBirthday()
    }
    /*======================================*/
    
    
    
    // MARK: - Methods
    /*======================================*/
    
    // MARK: Расчет даты следующего дня рождения
    /* - - - - - - - - - - - - */
    private func calculateTheDateOfNextBirthday() -> Date {
        
        // Календарь
        let calendar                   = Calendar.current
        
        // Разбвика даты Дня Рождения на компоненты
        let componentsOfBDayDate       = calendar.dateComponents([.day, .month], from: birthday)
        let dayOfBDay                  = componentsOfBDayDate.day!
        let monthOfBDay                = componentsOfBDayDate.month!
        
        // Разбивка текущей даты на компоненты
        let currentDate                = Date()
        let componentsOfCurrentDate    = calendar.dateComponents([.day, .month, .year], from: currentDate)
        let currentDay                 = componentsOfCurrentDate.day!
        let currentMonth               = componentsOfCurrentDate.month!
        let currentYear                = componentsOfCurrentDate.year!
        
        // Компоненты даты дня рождения в текущем году
        var componentsOfNextBirthday   = DateComponents()
        componentsOfNextBirthday.year  = currentYear
        componentsOfNextBirthday.month = monthOfBDay
        componentsOfNextBirthday.day   = dayOfBDay
        
        // Дата дня рождения к текущем году
        var nextBirthday = calendar.date(from: componentsOfNextBirthday)!
        
        // Если разность между датой рождения текущего года и текущей датой  меньше нуля, то следующий день рождения наступит в следующем году
        if nextBirthday.timeIntervalSince(currentDate) < 0 {
            componentsOfNextBirthday.year = (currentYear + 1)
            nextBirthday = calendar.date(from: componentsOfNextBirthday)!
        }
        
        return nextBirthday
    }
    /* - - - - - - - - - - - - */
    
    
    
    // MARK: Расчет количества дней до следующего дня рождения
    /* - - - - - - - - - - - - */
    private func calculateHowManyDaysAreLeftUntilBirthday() -> Int {
        var days = ceil( dateOfNextBirthday.timeIntervalSince(Date()) / (60 * 60 * 24) )
        if days > 365 { days = 0 }
        return Int(days)
    }
    /* - - - - - - - - - - - - */
    
    
    
    // MARK: Расчет количества дней до следующего дня рождения
    /* - - - - - - - - - - - - */
    mutating func setAvatar(avatar: UIImage?) {
        self.avatar = avatar
    }
    
    /* - - - - - - - - - - - - */
    
    
    
    // MARK: Проверка и изменение уникального идентификатора
    /* - - - - - - - - - - - - */
    mutating private func checkAndChangeId(personsArray: [Person]) {
        while personsArray.contains(where: { person in
            person.id == self.id
        }) {
            self.id = UUID().uuidString
        }
    }
    
    /* - - - - - - - - - - - - */
    
    /*======================================*/
    
    
    
    // MARK: - Initializers
    /*======================================*/
    init(name: String, birthday: Date, gender: Gender, congratulation: String? = nil, avatar: UIImage? = nil, persons: [Person]) {
        self.name = name
        self.birthday = birthday
        self.gender = gender
        self.congratulation = congratulation
        self.avatar = avatar
        self.checkAndChangeId(personsArray: persons)
    }
    
    init(personEntity: PersonEntity) {
        self.name = personEntity.name ?? "Имя не установлено"
        self.birthday = personEntity.birthday ?? Date(timeIntervalSince1970: 0)
        self.gender = Gender(rawValue: personEntity.gender ?? Gender.man.rawValue) ?? .man
        self.congratulation = personEntity.congratulation
        self.id = personEntity.id ?? UUID().uuidString
        if let encodedAvatar = personEntity.avatar {
            if let decodedAvtar = try? NSKeyedUnarchiver.unarchivedObject(ofClass: UIImage.self, from: encodedAvatar) {
                self.avatar = decodedAvtar
            }
        }
    }
    /*======================================*/
    
}



// MARK: - Расширение структуры Person
extension Person: Hashable {
    enum Gender: String, Hashable {
        case man
        case woman
    }
}
