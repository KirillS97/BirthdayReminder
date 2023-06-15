import Foundation



// MARK: - class "User"
/*- - - - - - - - - - - - - - - - - - - - - -*/
class User {
    
    // Хранимые свойства объекта
    var firstName: String
    var lastName: String
    var email: String
    var hashValueOfPassword: String // Хэш значение пароля пользователя
    
    // Метод для проверки пароля
    func checkPassword(password: String) -> Bool {
        return (String(password.hashValue) == self.hashValueOfPassword)
    }
    
    // Инициализатор объекта
    init(mailAddress: String, password: String, firstName: String, lastName: String) {
        self.email = mailAddress
        self.hashValueOfPassword = String(password.hashValue)
        self.firstName = firstName
        self.lastName = lastName
    }
}
/*- - - - - - - - - - - - - - - - - - - - - -*/



// MARK: - Подписка класса "User" на протокол "Equatable"
/*- - - - - - - - - - - - - - - - - - - - - -*/
extension User: Equatable {
    static func == (lhs: User, rhs: User) -> Bool {
        if (lhs.hashValueOfPassword == rhs.hashValueOfPassword) &&
            (lhs.email == rhs.email) &&
            (lhs.firstName == rhs.firstName) &&
            (lhs.lastName == rhs.lastName) {
            return true
        } else { return false }
    }
}
/*- - - - - - - - - - - - - - - - - - - - - -*/



// MARK: - class "RegisteredUseres"
/*- - - - - - - - - - - - - - - - - - - - - -*/
class RegisteredUsers {
    // Хранимое свойство в виде словаря, состоящего из зарегестрированных пользователей
    private var registeredUsers: [String: User] = [:]
    
    // Метод регистрации нового пользователя
    func registerUser(firstName: String, lastName: String, email: String, password: String) -> Bool {
        if !registeredUsers.contains(where: { (emailAddress: String, user: User) in
            email == emailAddress
        }) {
            let newUser = User(mailAddress: email, password: password, firstName: firstName, lastName: lastName)
            registeredUsers[newUser.email] = newUser
            return true
        }
        return false
    }
    
    // Метод для удаления зарегестрированного пользователя
    func removeUser(email: String) -> Bool {
        if registeredUsers.contains(where: { (emailAddress: String, user: User) in
            email == emailAddress
        }) {
            registeredUsers.removeValue(forKey: "\(email)")
            return true
        }
        return false
    }
    
    // Метод для верификации пользователя
    func userVerification(email: String, password: String) -> Bool {
        if registeredUsers.contains(where: { (emailAddress: String, user: User) in
            email == emailAddress
        }) {
            return (registeredUsers[email]!.checkPassword(password: password))
        }
        return false
    }
    
    // Метод для передачи данных пользователя
    func returnUser(email: String, password: String) -> User? {
        if registeredUsers.contains(where: { (emailAddress: String, user: User) in
            email == emailAddress
        }) {
            if (registeredUsers[email]!.checkPassword(password: password)) {
                return registeredUsers[email]
            }
        }
        return nil
    }
    
}
/*- - - - - - - - - - - - - - - - - - - - - -*/
