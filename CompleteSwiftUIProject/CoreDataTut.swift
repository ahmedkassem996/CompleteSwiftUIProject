//
//  CoreDataTut.swift
//  CompleteSwiftUIProject
//
//  Created by Ahmed Kasem on 01/03/2023.
//

import SwiftUI
import CoreData

// view - UI
// model - data point
// viewModel - manages the data for a view

class CoreDataViewModel: ObservableObject {
    
    let containner: NSPersistentContainer
    @Published var savedEntities: [FruitEntity] = []
    
    init() {
        containner = NSPersistentContainer(name: "FruitsContainner")
        containner.loadPersistentStores { description, error in
            if let error = error {
                print("Error loading core data. \(error)")
            } else {
                print("Successfully loaded core data")
            }
        }
        
        fetchFruits()
    }
    
    func fetchFruits() {
        let request = NSFetchRequest<FruitEntity>(entityName: "FruitEntity")
        
        do {
            savedEntities = try containner.viewContext.fetch(request)
        } catch let err {
            print("Error fetching. \(err)")
        }
        
    }
    
    func addFruits(text: String) {
        let newFruit = FruitEntity(context: containner.viewContext)
        newFruit.name = text
        saveData()
    }
    
    func deleteFruit(indexSet: IndexSet) {
        guard let index = indexSet.first else {return}
        let entity = savedEntities[index]
        containner.viewContext.delete(entity)
    }
    
    func updateFruit(entity: FruitEntity) {
        let currentName = entity.name ?? ""
        let newName = currentName + "!"
        entity.name = newName
        saveData()
    }
    
    func saveData() {
        do {
            try containner.viewContext.save()
            fetchFruits()
        } catch let err {
            print("Error saving. \(err)")
        }
        
    }
    
}

struct CoreDataTut: View {
    
    @StateObject var vm = CoreDataViewModel()
    @State var textfieldText: String = ""
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
               TextField("Add Fruit here...", text: $textfieldText)
                    .font(.headline)
                    .padding(.leading)
                    .frame(height: 55)
                    .background(Color.gray)
                    .cornerRadius(10)
                    .padding(.horizontal)
                
                Button {
                    guard !textfieldText.isEmpty else {return}
                    vm.addFruits(text: textfieldText)
                    textfieldText = ""
                } label: {
                    Text("Button")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color.orange)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                
                List {
                    ForEach(vm.savedEntities) { entity in
                        Text(entity.name ?? "No Name")
                            .onTapGesture {
                                vm.updateFruit(entity: entity)
                            }
                    }
                    .onDelete(perform: vm.deleteFruit(indexSet:))
                }
                .listStyle(PlainListStyle())
                
            }
            .navigationTitle("Fruits")
        }
    }
}

struct CoreDataTut_Previews: PreviewProvider {
    static var previews: some View {
        CoreDataTut()
    }
}
