//
//  LongPressGestures.swift
//  CompleteSwiftUIProject
//
//  Created by Ahmed Kasem on 19/02/2023.
//

import SwiftUI

struct LongPressGestures: View {
    
    @State var isComplete: Bool = false
    @State var isSuccess: Bool = false
    
    var body: some View {
        
        VStack {
            Rectangle()
                .fill(isSuccess ? Color.green : Color.blue)
                .frame(maxWidth: isComplete ? .infinity : 0)
                .frame(height: 55)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.gray)
            
            HStack {
                Text("Click Here")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.black)
                    .cornerRadius(10)
                    .onLongPressGesture(minimumDuration: 1.0, maximumDistance: 50.0) {(isPresenting) in
                        if isPresenting {
                            withAnimation(.easeInOut(duration: 1.0)) {
                                isComplete.toggle()
                            }
                        } else {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                if !isSuccess {
                                    withAnimation(.easeInOut) {
                                        isComplete = false
                                    }
                                }
                            }
                        }
                    } perform: {
                        withAnimation(.easeInOut) {
                            isSuccess = true
                        }
                    }

                
                Text("Reset")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.black)
                    .cornerRadius(10)
                    .onTapGesture {
                        isComplete = false
                        isSuccess = false
                    }
            }
            
        }
        
//        Text(isComplete ? "Completed" : "Not Complete")
//            .padding()
//            .padding(.horizontal)
//            .background(isComplete ? Color.green : Color.gray)
//            .cornerRadius(10)
////            .onTapGesture {
////                isComplete.toggle()
////            }
//            .onLongPressGesture(minimumDuration: 5.0, maximumDistance: 1.0) {
//                isComplete.toggle()
//            }
    }
}

struct LongPressGestures_Previews: PreviewProvider {
    static var previews: some View {
        LongPressGestures()
    }
}
