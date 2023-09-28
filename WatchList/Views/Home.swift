//
//  Home.swift
//  WatchList
//
//  Created by Kauane Santana on 28/09/23.
//

import SwiftUI

struct Home: View {
    
    @Binding var pageToggle: Bool
    @StateObject var listasModel = ListasModel()
    
    var body: some View {
        TabView {
            Explore(pageToggle: $pageToggle)
                .tabItem {
                    Label("Explorar", systemImage: "magnifyingglass")
                }
            
            Listas(pageToggle: $pageToggle)
                .tabItem {
                    Label("Listas", systemImage: "film.stack")
                }
        }
        .environmentObject(listasModel)
    }
}

//struct Home_Previews: PreviewProvider {
//    static var previews: some View {
//        Home(pageToggle: .constant(false))
//    }
//}
