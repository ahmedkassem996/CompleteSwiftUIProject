//
//  Arrays.swift
//  CompleteSwiftUIProject
//
//  Created by Ahmed Kasem on 27/02/2023.
//

import SwiftUI

struct UserModel: Identifiable {
    let id = UUID().uuidString
    let name: String?
    let points: Int
    let isVerified: Bool
}

class ArrayModificationViewModel: ObservableObject {
    
    @Published var dataArray: [UserModel] = []
    @Published var filteredArray: [UserModel] = []
    @Published var mappedArray: [String] = []
    
    init() {
        getUsers()
        updateFilteredArray()
    }
    
    func updateFilteredArray() {
        
        // sort
//        filteredArray = dataArray.sorted { (user1, user2) -> Bool in
//            return user1.points > user2.points
//        }
        
//        filteredArray = dataArray.sorted(by: {$0.points < $1.points})
        
        // filter
//        filteredArray = dataArray.filter({ user in
//            return user.isVerified
//        })
        
//        filteredArray = dataArray.filter({$0.isVerified})
        
        // map
//        mappedArray = dataArray.map({ user in
//            return user.name
//        })
        
//        mappedArray = dataArray.map({$0.name})
        
//        mappedArray = dataArray.compactMap({ user in
//            return user.name
//        })
        
//        mappedArray = dataArray.compactMap({$0.name})
        
        mappedArray = dataArray.sorted(by: {$0.points < $1.points})
            .filter({$0.isVerified})
            .compactMap({$0.name})
    }
    
    func getUsers() {
        let user1 = UserModel(name: "Ahmed", points: 5, isVerified: true)
        let user2 = UserModel(name: "Mohammed", points: 5, isVerified: false)
        let user3 = UserModel(name: "Ali", points: 59, isVerified: true)
        let user4 = UserModel(name: nil, points: 39, isVerified: true)
        let user5 = UserModel(name: "Maha", points: 30, isVerified: false)
        let user6 = UserModel(name: "Faten", points: 25, isVerified: true)
        let user7 = UserModel(name: "Osama", points: 40, isVerified: false)
        let user8 = UserModel(name: "Bassem", points: 12, isVerified: true)
        let user9 = UserModel(name: "Galal", points: 15, isVerified: false)
        let user10 = UserModel(name: "Belal", points: 51, isVerified: false)
        
        self.dataArray.append(contentsOf:[
            user1,
            user2,
            user3,
            user4,
            user5,
            user6,
            user7,
            user8,
            user9,
            user10
        ])
    }
    
}

struct Arrays: View {
    
    @StateObject var vm = ArrayModificationViewModel()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                
                ForEach(vm.mappedArray, id: \.self) { name in
                    Text(name)
                        .font(.title)
                }
                
//                ForEach(vm.filteredArray) { user in
//                    VStack(alignment: .leading) {
//                        Text(user.name)
//                            .font(.headline)
//                        HStack {
//                            Text("Points: \(user.points)")
//                            Spacer()
//                            if user.isVerified {
//                                Image(systemName: "flame.fill")
//                            }
//                        }
//                    }
//                .foregroundColor(.white)
//                .padding()
//                .background(Color.blue.cornerRadius(10))
//                .padding(.horizontal)
//               }
            }
        }
    }
}

struct Arrays_Previews: PreviewProvider {
    static var previews: some View {
        Arrays()
    }
}
