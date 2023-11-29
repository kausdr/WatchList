//
//  ContentView.swift
//  WatchList
//
//  Created by Kauane Santana on 26/09/23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var movieAPI = MovieAPI()
    @State var pageToggle: Bool = false
    @State var mudarBotaoMyList: Bool = true
    @State var mudarBotaoAssistidos: Bool = true
    @State var serieId: Int = 1355
    @State var searchText: String = ""
    
    var body: some View {
        Home(movieAPI: movieAPI, pageToggle: $pageToggle, serieId: $serieId, searchText: $searchText)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
