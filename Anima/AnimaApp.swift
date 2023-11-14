//
//  AnimaApp.swift
//  Anima
//
//  Created by Muhammad M. Munir on 13/11/23.
//

import SwiftUI

@main
struct AnimaApp: App {
    @Environment(\.scenePhase) var scenePhase
    @StateObject private var dataController = CoreDataController()

    var body: some Scene {
        WindowGroup {
            NavigationView {
                ListScreen()
                    .environment(
                        \.managedObjectContext,
                         dataController.container.viewContext
                    )
            }
        }
        .onChange(of: scenePhase) { _ in
            dataController.save()
        }
    }
}
