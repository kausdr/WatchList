//
//  Home.swift
//  WatchList
//
//  Created by Kauane Santana on 28/09/23.
//

import SwiftUI

struct Home: View {
    @StateObject var movieAPI: MovieAPI
    @Binding var pageToggle: Bool
    @StateObject var listasModel = ListasModel()
    @Binding var serieId: Int
    @Binding var searchText: String
    
    var body: some View {
        TabView {
            Explore(movieAPI: movieAPI, serieId: $serieId, pageToggle: $pageToggle, searchText: $searchText)
                .tabItem {
                    Label("Explore", systemImage: "magnifyingglass")
                }
            
            Listas(movieAPI: movieAPI, pageToggle: $pageToggle, searchText: $searchText)
                .tabItem {
                    Label("Lists", systemImage: "film.stack")
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
