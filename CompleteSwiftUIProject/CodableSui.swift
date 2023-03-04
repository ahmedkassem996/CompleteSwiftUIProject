//
//  CodableSui.swift
//  CompleteSwiftUIProject
//
//  Created by Ahmed Kasem on 04/03/2023.
//

import SwiftUI

struct CustomerModel: Identifiable, Codable  {
    let id: String
    let name: String
    let points: Int
    let isPremium: Bool
    
//    enum CodingKeys: String, CodingKey {
//        case id
//        case name
//        case points
//        case isPremium
//    }
//
//    init(id: String, name: String, points: Int, isPremium: Bool) {
//        self.id = id
//        self.name = name
//        self.points = points
//        self.isPremium = isPremium
//    }
//
//    init(from decoder: Decoder) throws {
//        let containner = try decoder.container(keyedBy: CodingKeys.self)
//
//        self.id = try containner.decode(String.self, forKey: .id)
//        self.name = try containner.decode(String.self, forKey: .name)
//        self.points = try containner.decode(Int.self, forKey: .points)
//        self.isPremium = try containner.decode(Bool.self, forKey: .isPremium)
//    }
    
}

class CodableViewModel: ObservableObject {
    @Published var customer: CustomerModel? = nil
    
    init() {
        getData()
    }
    
    func getData() {
        guard let data = getJsonData() else {return}
        self.customer = try? JSONDecoder().decode(CustomerModel.self, from: data)
                
//        if
//            let localData = try? JSONSerialization.jsonObject(with: data, options: []),
//            let dictionary = localData as? [String: Any],
//            let id = dictionary["id"] as? String,
//            let name = dictionary["name"] as? String,
//            let points = dictionary["points"] as? Int,
//            let isPremium = dictionary["isPremium"] as? Bool {
//            let newCustomer = CustomerModel(id: id, name: name, points: points, isPremium: isPremium)
//            customer = newCustomer
//        }
            
    }
    
    func getJsonData() -> Data? {
        
        let customer = CustomerModel(id: "1", name: "Ahned", points: 9, isPremium: false)
        let jsonData = try? JSONEncoder().encode(customer)
        
//        let dictionary: [String: Any] = [
//            "id": "12345",
//            "name": "Ahmed",
//            "points": 4,
//            "isPremium": true
//        ]
//        let jsonData = try? JSONSerialization.data(withJSONObject: dictionary, options: [])
        
        return jsonData
    }
    
}

struct CodableSui: View {
    
    @StateObject var vm = CodableViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            if let customer = vm.customer {
                Text(customer.id)
                Text(customer.name)
                Text("\(customer.points)")
                Text(customer.isPremium.description)
            }
        }
    }
}

struct CodableSui_Previews: PreviewProvider {
    static var previews: some View {
        CodableSui()
    }
}
