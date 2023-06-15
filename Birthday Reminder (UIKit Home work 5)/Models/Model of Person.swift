import Foundation

struct Person {
    
    // MARK: Storied properties
    var name:             String  // Имя
    var birthday:         Date    // Дата рождения
    var gender:           Gender  // Пол
    var instagramAccount: String  // Инстаграм-аккаунт
    
    
    
    // MARK: Computed properties
    
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
    
    
    
    // MARK: Methods
    
    // Расчет даты следующего дня рождения
    func calculateTheDateOfNextBirthday() -> Date {
        
        // Разбвика даты Дня Рождения на компоненты
        let componentsOfBDayDate       = Calendar.current.dateComponents([.day, .month], from: birthday)
        let dayOfBDay                  = componentsOfBDayDate.day!
        let monthOfBDay                = componentsOfBDayDate.month!
        
        // Разбивка текущей даты на компоненты
        let currentDate                = Date()
        let calendar                   = Calendar.current
        let componentsOfCurrentDate    = calendar.dateComponents([.day, .month, .year], from: currentDate)
        let currentDay                 = componentsOfCurrentDate.day!
        let currentMonth               = componentsOfCurrentDate.month!
        let currentYear                = componentsOfCurrentDate.year!
        
        // Компоненты даты дня рождения текущего года
        var componentsOfNextBirthday   = DateComponents()
        componentsOfNextBirthday.year  = currentYear
        componentsOfNextBirthday.month = monthOfBDay
        componentsOfNextBirthday.day   = dayOfBDay
        
        // Дата дня рождения текущего года
        var nextBirthday = calendar.date(from: componentsOfNextBirthday)!
        
        // Если разность между датой рождения текущего года и текущей датой  меньше нуля, то следующий день рождения наступит в следующем году
        if nextBirthday.timeIntervalSince(currentDate) < 0 {
            componentsOfNextBirthday.year = (currentYear + 1)
        }
        
        nextBirthday = Calendar.current.date(from: componentsOfNextBirthday)!
        return nextBirthday
    }
    
    // Расчет количества дней до следующего дня рождения
    func calculateHowManyDaysAreLeftUntilBirthday() -> Int {
        var days = ceil( dateOfNextBirthday.timeIntervalSince(Date()) / (60 * 60 * 24) )
        if days > 365 { days = 0 }
        return Int(days)
    }
    
}



extension Person: Hashable {
    enum Gender: Hashable {
        case man
        case woman
    }
}
