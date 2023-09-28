//
//  ContentView.swift
//  WatchList
//
//  Created by Kauane Santana on 26/09/23.
//

import SwiftUI

struct ContentView: View {
    
    @State var pageToggle: Bool = false
    
    var body: some View {
        Home(pageToggle: $pageToggle)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
