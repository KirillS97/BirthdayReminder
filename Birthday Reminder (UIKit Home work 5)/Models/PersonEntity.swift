//
//  PersonEntity.swift
//  Birthday Reminder (UIKit Home work 5)
//
//  Created by Kirill on 07.08.2023.
//

import Foundation
import CoreData

class PersonEntity: NSManagedObject {
    
    
    
    // MARK: Метод для возврата массива всех PersonEntity из контекста
    /* - - - - - - - - - - - - - - - - - - - - - */
    static func getPersonEntitiesArray(context: NSManagedObjectContext) -> [PersonEntity] {
        
        // Создание запроса к контексту без предиката, чтобы получить все экземпляры PersonEntity
        let requestToContext: NSFetchRequest<PersonEntity> = PersonEntity.fetchRequest()
        
        // Отправка запроса контексту и обработка результата
        if let resultArrayOfPersonEntities = try? context.fetch(requestToContext) {
            return resultArrayOfPersonEntities
        } else {
            return []
        }
    }
    /* - - - - - - - - - - - - - - - - - - - - - */
    
    
    
    // MARK: Метод для поиска в контексте экземпляра PersonEntity
    /* - - - - - - - - - - - - - - - - - - - - - */
    static func findEntity(person: Person, context: NSManagedObjectContext) -> PersonEntity? {
        
        // Создание запроса к контексту базы данных с предикатом для поиска экземпляра PersonEntity по id
        let requestToContext: NSFetchRequest<PersonEntity> = PersonEntity.fetchRequest()
        requestToContext.predicate = NSPredicate(format: "id == %@", person.id)

        // Отправка запроса контексту и обработка результата
        if let resultArrayOfPersonEntities = try? context.fetch(requestToContext) {
            if !resultArrayOfPersonEntities.isEmpty {
                return resultArrayOfPersonEntities.first!
            }
        }
        return nil
    }
    /* - - - - - - - - - - - - - - - - - - - - - */
    
    
    
    // MARK: Метод для создания в контексте базы данных нового экземпляра PersonEntity
    /* - - - - - - - - - - - - - - - - - - - - - */
    static func createEntity(person: Person, context: NSManagedObjectContext) -> Bool {
        
        // Проверка, существует ли в контексте экземпляр PersonEntity с указанным идентификатором. Если нет, то создание
        if let personEntity = PersonEntity.findEntity(person: person, context: context) {
            return false
        } else {
            let newPersonEntity = PersonEntity(context: context)
            newPersonEntity.setUpAttributes(person: person)
            return true
        }
        
    }
    /* - - - - - - - - - - - - - - - - - - - - - */
    
    
    
    // MARK: Метод для удаления экземпляра PersonEntity из контекста
    /* - - - - - - - - - - - - - - - - - - - - - */
    static func deleteEntity(person: Person, context: NSManagedObjectContext) -> Void {
        
        // Проверка, существует ли в контексте экземпляр PersonEntity с указанным идентификатором. Если да, то удаление.
        if let personEntity = PersonEntity.findEntity(person: person, context: context) {
            context.delete(personEntity)
        }
        
    }
    /* - - - - - - - - - - - - - - - - - - - - - */
    
    
    
    // MARK: Настрока атрибутов экземпляра PersonEntity
    /* - - - - - - - - - - - - - - - - - - - - - */
    func setUpAttributes(person: Person) -> Void {
        self.name = person.name
        self.birthday = person.birthday
        self.gender = person.gender.rawValue
        self.congratulation = person.congratulation
        self.id = person.id
        if let personAvatar = person.avatar {
            if let encodedAvatar =  try? NSKeyedArchiver.archivedData(withRootObject: personAvatar,
                                                                      requiringSecureCoding: false) {
                self.avatar = encodedAvatar
            } else {
                self.avatar = nil
            }
        } else {
            self.avatar = nil
        }
    }
    /* - - - - - - - - - - - - - - - - - - - - - */
}
