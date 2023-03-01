//
//  CoreDataRelationShips.swift
//  CompleteSwiftUIProject
//
//  Created by Ahmed Kasem on 01/03/2023.
//

import SwiftUI
import CoreData

class CoreDataManager {
    static let instance = CoreDataManager()
    let containner: NSPersistentContainer
    let context: NSManagedObjectContext
    
    init() {
        containner = NSPersistentContainer(name: "")
        containner.loadPersistentStores { description, error in
            if let error = error {
                print("Error loading core data. \(error)")
            }
        }
        context = containner.viewContext
    }
    
    func save() {
        do {
            try context.save()
        } catch let error {
            print("Error saving core data, \(error.localizedDescription)")
        }
    }
    
}

class CoreDataRelationshipViewModel: ObservableObject {
    let manager = CoreDataManager.instance
}

struct CoreDataRelationShips: View {
    
    @StateObject var vm = CoreDataRelationshipViewModel()
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct CoreDataRelationShips_Previews: PreviewProvider {
    static var previews: some View {
        CoreDataRelationShips()
    }
}
