//
//  Hapittics.swift
//  CompleteSwiftUIProject
//
//  Created by Ahmed Kasem on 27/02/2023.
//

import SwiftUI

class HapiticManager {
    static let instance = HapiticManager() // singleton
    
    func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }
    
    func impact(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
    
}

struct Hapittics: View {
    var body: some View {
        VStack(spacing: 20) {
            Button("Success"){HapiticManager.instance.notification(type: .success)}
            Button("Warning"){HapiticManager.instance.notification(type: .warning)}
            Button("Error"){HapiticManager.instance.notification(type: .error)}
            Divider()
            Button("Soft"){HapiticManager.instance.impact(style: .soft)}
            Button("Light"){HapiticManager.instance.impact(style: .light)}
            Button("Medium"){HapiticManager.instance.impact(style: .medium)}
            Button("Rigid"){HapiticManager.instance.impact(style: .rigid)}
            Button("Heavy"){HapiticManager.instance.impact(style: .heavy)}
        }
    }
}

struct Hapittics_Previews: PreviewProvider {
    static var previews: some View {
        Hapittics()
    }
}
