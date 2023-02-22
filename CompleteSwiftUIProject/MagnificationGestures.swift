//
//  MagnificationGestures.swift
//  CompleteSwiftUIProject
//
//  Created by Ahmed Kasem on 19/02/2023.
//

import SwiftUI

struct MagnificationGestures: View {
    
    @State var currentAmount: CGFloat = 0
    @State var lastAmount: CGFloat = 0
    
    var body: some View {
        
        VStack {
            HStack {
                Circle().frame(width: 35, height: 35)
                Text("AhmedKassem")
                Spacer()
                Image(systemName: "ellipses")
            }
            .padding(.horizontal)
            Rectangle()
                .frame(height: 300)
                .scaleEffect(1 + currentAmount)
                .gesture(
                    MagnificationGesture()
                        .onChanged { value in
                            currentAmount = value - 1
                        }
                        .onEnded({ value in
                            withAnimation(.spring()) {
                                currentAmount = 0
                            }
                        })
                )
            HStack {
                Image(systemName: "heart.fill")
                Image(systemName: "text.bubble.fill")
                Spacer()
            }
            .padding(.horizontal)
            .font(.headline)
            Text("My photo")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
        }
        
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//            .font(.title)
//            .padding(40)
//            .background(Color.red.cornerRadius(10))
//            .scaleEffect(1 + currentAmount + lastAmount)
//            .gesture(
//                MagnificationGesture()
//                    .onChanged { value in
//                        currentAmount = value - 1
//                    }
//                    .onEnded({ value in
//                        lastAmount += currentAmount
//                        currentAmount = 0
//                    })
//            )
    }
}

struct MagnificationGestures_Previews: PreviewProvider {
    static var previews: some View {
        MagnificationGestures()
    }
}
