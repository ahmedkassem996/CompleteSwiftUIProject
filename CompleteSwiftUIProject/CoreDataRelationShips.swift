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
        containner = NSPersistentContainer(name: "CoreDataContainner")
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
            print("Saved Successfully")
        } catch let error {
            print("Error saving core data, \(error.localizedDescription)")
        }
    }
    
}

class CoreDataRelationshipViewModel: ObservableObject {
    let manager = CoreDataManager.instance
    @Published var business: [BusinessEntity] = []
    @Published var department: [DepartmentEntity] = []
    @Published var employee: [EmployeeEntity] = []
    
    init() {
        getBusinesses()
        getDepartments()
        getEmployees()
    }
    
    func getBusinesses() {
        let request = NSFetchRequest<BusinessEntity>(entityName: "BusinessEntity")
        
        let sort = NSSortDescriptor(keyPath: \BusinessEntity.name, ascending: true)
        request.sortDescriptors = [sort]
        
//        let filter = NSPredicate(format: "name == %@", "Apple")
//        request.predicate = filter
        
        do {
            business = try manager.context.fetch(request)
        } catch let err {
            print("Error fetching data. \(err.localizedDescription)")
        }
    }
    
    func getDepartments() {
        let request = NSFetchRequest<DepartmentEntity>(entityName: "DepartmentEntity")
        
        do {
            department = try manager.context.fetch(request)
        } catch let err {
            print("Error fetching data. \(err.localizedDescription)")
        }
    }
    
    func getEmployees() {
        let request = NSFetchRequest<EmployeeEntity>(entityName: "EmployeeEntity")
        
        do {
            employee = try manager.context.fetch(request)
        } catch let err {
            print("Error fetching data. \(err.localizedDescription)")
        }
    }
    
    func getEmployees(forBusiness business: BusinessEntity) {
        let request = NSFetchRequest<EmployeeEntity>(entityName: "EmployeeEntity")
        
        let filter = NSPredicate(format: "business = %@", business)
        request.predicate = filter
        
        do {
            employee = try manager.context.fetch(request)
        } catch let err {
            print("Error fetching data. \(err.localizedDescription)")
        }
    }

    
    func updateBusiness() {
        let existingBusiness = business[2]
        existingBusiness.addToDepartments(department[1])
        save()
    }
    
    func addBusiness() {
        let newBusiness = BusinessEntity(context: manager.context)
        newBusiness.name = "FaceBook"
        
//        // add existing department to new business
//        newBusiness.departments = [department[0], department[1]]
//
//        // add existing employee to new business
//        newBusiness.employees = [employee[0]]
        
        save()
    }
    
    func addDepartment() {
        let newDepartment = DepartmentEntity(context: manager.context)
        newDepartment.name = "Finance"
        newDepartment.businesses = [business[0], business.last!]
        
        newDepartment.addToEmployees(employee[1])
        
        save()
    }
    
    func addEmployee() {
        let newEmployee = EmployeeEntity(context: manager.context)
        newEmployee.name = "Mohammed"
        newEmployee.age = 34
        newEmployee.dateJoined = Date()
//        newEmployee.department = department[1]
        newEmployee.business = business[0]
        save()
    }
    
    func deleteDepartment() {
        let department = department[2]
        manager.context.delete(department)
        save()
    }
    
    func save() {
        business.removeAll()
        department.removeAll()
        employee.removeAll()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.manager.save()
            self.getBusinesses()
            self.getDepartments()
            self.getEmployees()
        }
    }
}

struct CoreDataRelationShips: View {
    
    @StateObject var vm = CoreDataRelationshipViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    Button {
//                        vm.addBusiness()
//                        vm.addDepartment()
//                        vm.addEmployee()
//                        vm.updateBusiness()
//                        vm.getEmployees(forBusiness: vm.business[0])
                        vm.deleteDepartment()
                        
                    } label: {
                        Text("Perform Action")
                            .foregroundColor(.white)
                            .frame(height: 55)
                            .frame(maxWidth: .infinity)
                            .background(Color.blue.cornerRadius(10))
                    }
                    
                    ScrollView(.horizontal, showsIndicators: true) {
                        HStack(alignment: .top) {
                            ForEach(vm.business){ business in
                                BusinessView(entity: business)
                            }
                        }
                    }
                    
                    ScrollView(.horizontal, showsIndicators: true) {
                        HStack(alignment: .top) {
                            ForEach(vm.department){ department in
                                DepartmentView(entity: department)
                            }
                        }
                    }
                    
                    ScrollView(.horizontal, showsIndicators: true) {
                        HStack(alignment: .top) {
                            ForEach(vm.employee){ employee in
                                EmployeeView(entity: employee)
                            }
                        }
                    }
                    
                }
                .padding()
            }
            .navigationTitle("Relationship")
        }
    }
}

struct CoreDataRelationShips_Previews: PreviewProvider {
    static var previews: some View {
        CoreDataRelationShips()
    }
}

struct BusinessView: View {
    let entity: BusinessEntity
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Name \(entity.name ?? "")")
                .bold()
            
            if let departments = entity.departments?.allObjects as? [DepartmentEntity] {
                Text("Departments.")
                    .bold()
                ForEach(departments) { department in
                    Text(department.name ?? "")
                }
            }
            
            if let employees = entity.employees?.allObjects as? [EmployeeEntity] {
                Text("Employees.")
                    .bold()
                
                ForEach(employees){ employee in
                    Text(employee.name ?? "")
                }
            }
        }
        .padding()
        .frame(maxWidth: 300, alignment: .leading)
        .background(Color.gray.opacity(0.5))
        .cornerRadius(10)
        .shadow(radius: 10)
    }
    
}

struct DepartmentView: View {
    let entity: DepartmentEntity
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Name \(entity.name ?? "")")
                .bold()
            
            if let businesses = entity.businesses?.allObjects as? [BusinessEntity] {
                Text("Businesses.")
                    .bold()
                ForEach(businesses) { business in
                    Text(business.name ?? "")
                }
            }
            
            if let employees = entity.employees?.allObjects as? [EmployeeEntity] {
                Text("Employees.")
                    .bold()
                
                ForEach(employees){ employee in
                    Text(employee.name ?? "")
                }
            }
        }
        .padding()
        .frame(maxWidth: 300, alignment: .leading)
        .background(Color.green.opacity(0.5))
        .cornerRadius(10)
        .shadow(radius: 10)
    }
    
}

struct EmployeeView: View {
    let entity: EmployeeEntity
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Name \(entity.name ?? "")")
                .bold()
            Text("Age \(entity.age)")
                .bold()
            Text("Date \(entity.dateJoined ?? Date())")
                .bold()
            
            Text("Business.")
                .bold()
            Text(entity.business?.name ?? "")
            
            Text("department.")
                .bold()
            Text(entity.department?.name ?? "")
            
        }
        .padding()
        .frame(maxWidth: 300, alignment: .leading)
        .background(Color.blue.opacity(0.5))
        .cornerRadius(10)
        .shadow(radius: 10)
    }
    
}
