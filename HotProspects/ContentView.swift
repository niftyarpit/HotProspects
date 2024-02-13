//
//  ContentView.swift
//  HotProspects
//
//  Created by Arpit Srivastava on 12/02/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            ProspectsView(.none)
                .tabItem {
                    Label("Everyone", systemImage: "person.3")
                }
            
            ProspectsView(.contacted)
                .tabItem {
                    Label("Contacted", systemImage: "checkmark.circle")
                }

            ProspectsView(.uncontacted)
                .tabItem {
                    Label("Uncontacted", systemImage: "questionmark.diamond")
                }

            MeView()
                .tabItem {
                    Label("Me", systemImage: "person.crop.square")
                }
        }
    }
}

#Preview {
    ContentView()
}
