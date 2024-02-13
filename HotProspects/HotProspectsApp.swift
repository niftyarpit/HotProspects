//
//  HotProspectsApp.swift
//  HotProspects
//
//  Created by Arpit Srivastava on 12/02/24.
//

import SwiftUI
import SwiftData

@main
struct HotProspectsApp: App {

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Prospect.self)
    }
}
