//
//  ScrollViewReader.swift
//  CompleteSwiftUIProject
//
//  Created by Ahmed Kasem on 26/02/2023.
//

import SwiftUI

struct ScrollViewReaders: View {
    
    @State var scrollToindex: Int = 0
    @State var textFieldText: String = ""
    
    var body: some View {
        VStack {
            
            TextField("Enter text here", text: $textFieldText)
                .frame(height: 55)
                .border(Color.gray)
                .padding(.horizontal)
                .keyboardType(.numberPad)
            
            Button("SCROLL NOW") {
                withAnimation(.spring()) {
                    if let index = Int(textFieldText) {
                        scrollToindex = index
                    }
                }
            }
            
            ScrollView {
                ScrollViewReader { proxy in
                    Button("Click here to go to #20") {
                        proxy.scrollTo(20, anchor: .top)
                    }
                    
                    ForEach(0..<50) { index in
                        Text("item: \(index)")
                            .font(.headline)
                            .frame(height: 200)
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 10)
                            .padding()
                            .id(index)
                    }
                    .onChange(of: scrollToindex) { value in
                        withAnimation(.spring()) {
                            proxy.scrollTo(value, anchor: nil)
                        }
                    }
                }
            }
        }
    }
}

struct ScrollViewReaders_Previews: PreviewProvider {
    static var previews: some View {
        ScrollViewReaders()
    }
}
