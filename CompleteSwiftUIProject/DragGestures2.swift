//
//  DragGestures2.swift
//  CompleteSwiftUIProject
//
//  Created by Ahmed Kasem on 22/02/2023.
//

import SwiftUI

struct DragGestures2: View {
    
    @State var startingoffsetY: CGFloat = UIScreen.main.bounds.height * 0.5
    @State var currentDragoffsetY: CGFloat = 0
    @State var endingOffsetY: CGFloat = 0
    
    var body: some View {
        ZStack {
            Color.green.ignoresSafeArea()
            
            mySignUpView()
                .offset(y: startingoffsetY)
                .offset(y: currentDragoffsetY)
                .offset(y: endingOffsetY)
                .gesture(
                    DragGesture()
                        .onChanged({ value in
                            withAnimation(.spring()) {
                                currentDragoffsetY = value.translation.height
                            }
                        })
                    
                        .onEnded({ value in
                                                        
                            withAnimation(.spring()) {
                                if currentDragoffsetY < -150 {
                                    endingOffsetY = -startingoffsetY
                                } else if endingOffsetY != 0 && currentDragoffsetY > 150 {
                                    endingOffsetY = 0
                                }
                                currentDragoffsetY = 0
                            }
                        })
                )
            
        }
        .ignoresSafeArea(edges: .bottom)
    }
}

struct DragGestures2_Previews: PreviewProvider {
    static var previews: some View {
        DragGestures2()
    }
}


struct mySignUpView: View {
    var body: some View {
        
        VStack(spacing: 20) {
            Image(systemName: "chevron.up")
                .padding(.top)
            Text("Sign Up")
                .font(.headline)
                .fontWeight(.semibold)
            
            Image(systemName: "flame.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
            
            Text("description ...................................................................................................................................................................")
                .multilineTextAlignment(.center)
            
            Text("CREATE AN ACCOUNT")
                .foregroundColor(.white)
                .font(.headline)
                .padding()
                .padding(.horizontal)
                .background(Color.black.cornerRadius(10))
            
            Spacer()
        }
        .background(Color.white)
        .frame(maxWidth: .infinity)
        .cornerRadius(30)
        
    }
}
