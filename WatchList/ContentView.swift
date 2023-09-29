//
//  ContentView.swift
//  WatchList
//
//  Created by Kauane Santana on 26/09/23.
//

import SwiftUI

struct ContentView: View {
    
    @State var pageToggle: Bool = false
    @State var mudarBotaoMyList: Bool = true
    @State var mudarBotaoAssistidos: Bool = true
    @State var serieId: Int = 1355
    
    var body: some View {
        Home(pageToggle: $pageToggle, serieId: $serieId)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
