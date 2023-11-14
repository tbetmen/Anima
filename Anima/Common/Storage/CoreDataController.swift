//
//  CoreDataController.swift
//  Anima
//
//  Created by Muhammad M. Munir on 13/11/23.
//

import CoreData
import Foundation

final class CoreDataController: ObservableObject {
    let container: NSPersistentContainer
    
    static var preview: CoreDataController = {
        let result = CoreDataController(inMemory: true)
        let viewContext = result.container.viewContext
        for _ in 0..<10 {
            let newPhoto = LocalAnimalPhoto(context: viewContext)
            newPhoto.createdAt = Date()
            newPhoto.id = Int64(1)
            newPhoto.name = "Lion"
            newPhoto.imageURL = "https://images.pexels.com/photos/41315/africa-african-animal-cat-41315.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=1200&w=800"
        }
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Anima")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { description, error in
            if let error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
    
    public func save() {
        let context = container.viewContext
        
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
