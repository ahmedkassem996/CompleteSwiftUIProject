//
//  DownloadWithEscaping.swift
//  CompleteSwiftUIProject
//
//  Created by Ahmed Kasem on 08/03/2023.
//

import SwiftUI

//struct PostModel: Identifiable, Codable {
//    let userId: Int
//    let id: Int
//    let title: String
//    let body: String
//}

class DownloadWithEscapingViewModel: ObservableObject {
    
    @Published var posts: [PostModel] = []
    
    init() {
        getPosts()
    }
    
    func getPosts() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {return}
        
        downloadData(fromUrl: url, model: [PostModel].self) {[weak self] data in
            if let data = data {
                guard let self = self else {return}
                self.posts.append(contentsOf: data)
            } else {
                print("Error")
            }
        }
    }
    
    func downloadData<T>(fromUrl url: URL, model: T.Type, completionHandler: @escaping(_ data: T?) -> ()) where T: Codable {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let data = data,
                error == nil,
                let response = response as? HTTPURLResponse,
                response.statusCode >= 200 && response.statusCode < 300
            else {
                print("Error Downloading Data")
                return
            }
            
            guard let data = try? JSONDecoder().decode(T.self, from: data) else {return}
            DispatchQueue.main.async {
                completionHandler(data)
            }
            
            
        }.resume()
    }
    
}

struct DownloadWithEscaping: View {
    
    @StateObject var vm = DownloadWithEscapingViewModel()
    
    var body: some View {
        List {
            ForEach(vm.posts) { post in
                VStack(alignment: .leading) {
                    Text(post.title)
                        .font(.headline)
                    Text(post.body)
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}

struct DownloadWithEscaping_Previews: PreviewProvider {
    static var previews: some View {
        DownloadWithEscaping()
    }
}
