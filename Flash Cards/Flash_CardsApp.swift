//
//  Flash_CardsApp.swift
//  Flash Cards
//
//  Created by sam mceachern on 23/10/22.
//

import SwiftUI

@main
struct Flash_CardsApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
