//
//  View.swift
//  PokeApiEx
//
//  Created by Matias Alvarez on 15/1/25.
//

import SwiftUI

extension View {
    
    func appAlert(_ alert: Binding<AppAlert?>) -> some View {
        let appAlert = alert.wrappedValue ?? AppAlert(title: "", message: "", action: [])
        return self.alert(appAlert.title, isPresented: Binding(value: alert), actions: {
            ForEach(appAlert.action.indices, id: \.self) { index in
                let action = appAlert.action[index]
                Button(action.title, role: action.role, action: action.action)
            }
        }, message: {
            if let message = appAlert.message {
                Text(message)
            }
        })
    }
}

