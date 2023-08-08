//
//  CoreDataManager.swift
//  Birthday Reminder (UIKit Home work 5)
//
//  Created by Kirill on 07.08.2023.
//

import Foundation
import CoreData



class CoreDataManager {
    static let shared = CoreDataManager(); private init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "Data Base")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}
