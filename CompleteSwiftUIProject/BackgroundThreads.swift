//
//  BackgroundThreads.swift
//  CompleteSwiftUIProject
//
//  Created by Ahmed Kasem on 03/03/2023.
//

import SwiftUI

class BackgroundThreadViewModel: ObservableObject {
    
    @Published var dataArray: [String] = []
    
    func fetchData() {
        let newData = downloadData()
        dataArray = newData
    }
    
    private func downloadData() -> [String] {
        var data: [String] = []
        for x in 0..<100 {
            data.append("\(x)")
        }
        
        print(Thread.isMainThread)
        print(Thread.current)
        
        return data
    }
    
}

struct BackgroundThreads: View {
    
    @StateObject var vm = BackgroundThreadViewModel()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                Text("Load Data")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .onTapGesture {
                        vm.fetchData()
                    }
                
                ForEach(vm.dataArray, id: \.self) { item in
                    Text(item)
                        .font(.headline)
                        .foregroundColor(.red )
                }
                
            }
        }
    }
    
    func downloadData(completionHandler: @escaping(_ data: String) -> ()){
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            completionHandler("Hello")
        }
    }
    
}

struct BackgroundThreads_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundThreads()
    }
}
