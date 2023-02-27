//
//  HashableSwiftUI.swift
//  CompleteSwiftUIProject
//
//  Created by Ahmed Kasem on 27/02/2023.
//

import SwiftUI

struct MyCustomModel: Hashable {
    let title: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
    }
}

struct HashableSwiftUI: View {
    
    let data: [MyCustomModel] =
    [
        MyCustomModel(title: "One"),
        MyCustomModel(title: "Two"),
        MyCustomModel(title: "Three"),
        MyCustomModel(title: "Four"),
        MyCustomModel(title: "Five"),
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 40) {
                ForEach(data, id: \.self) { item in
                    Text(item.hashValue.description)
                        .font(.headline)
                }
            }
        }
    }
}

struct HashableSwiftUI_Previews: PreviewProvider {
    static var previews: some View {
        HashableSwiftUI()
    }
}
