//
//  CoreDataSwiftUIApp.swift
//  CoreDataSwiftUI
//
//  Created by Ashwinkumar Damji on 24/05/25.
//

import SwiftUI

@main
struct CoreDataSwiftUIApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            PersonListView(context: persistenceController.container.viewContext)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
