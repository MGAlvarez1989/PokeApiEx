//
//  View.swift
//  PokeApiEx
//
//  Created by Matias Alvarez on 15/1/25.
//

import SwiftUI

extension View {
    
    func appAlert(_ alert: Binding<AppAlert?>) -> some View {
        let appAlertTest = alert.wrappedValue ?? AppAlert(title: "", message: "", action: [])
        return self.alert(appAlertTest.title, isPresented: Binding(value: alert), actions: {
            ForEach(appAlertTest.action.indices, id: \.self) { index in
                let action = appAlertTest.action[index]
                Button(action.title, role: action.role, action: action.action)
            }
        }, message: {
            if let message = appAlertTest.message {
                Text(message)
            }
        })
    }
}

