//
//  AppAlert.swift
//  PokeApiEx
//
//  Created by Matias Alvarez on 15/1/25.
//

import SwiftUI

struct AppAlert {
    struct Action {
        let title: String
        let role: ButtonRole?
        let action: () -> Void
    }
    
    var title: String
    var message: String?
    var action: [Action]
}

class ViewModel: ObservableObject {
    @Published var alert: AppAlert?
    
    func showError (_ error: Error) {
        alert = AppAlert(title: "Error", message: error.localizedDescription, action: [AppAlert.Action(title: "Ok", role: .cancel, action: { })])
    }
}
