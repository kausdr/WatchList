//
//  Listas.swift
//  WatchList
//
//  Created by Kauane Santana on 27/09/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct Listas: View {
    @StateObject var movieAPI: MovieAPI
    @EnvironmentObject var listasModel: ListasModel
    @State var listPagesSelection = "Assistido"
    var listPagesNames = ["Minha Lista", "Assistido"]
    @Binding var pageToggle: Bool
    
    @Binding var searchText: String
    
    var body: some View {
        NavigationStack{
            VStack (spacing: 20){
                Picker("List Pages", selection: $listPagesSelection) {
                    ForEach(listPagesNames, id: \.self) {
                        Text($0)
                    }
                }
                .padding(24)
                .pickerStyle(.segmented)
                .onChange(of: listPagesSelection) { newValue in
                    pageToggle.toggle()
                }
                
                if pageToggle {
                    MinhaLista(movieAPI: movieAPI, pageToggle: $pageToggle, searchText: $searchText)
                }
                else {
                    AssistidoLista(movieAPI: movieAPI, pageToggle: $pageToggle, searchText: $searchText)
                }
            }
        }
    }
}





// --------------------------- Conteúdo Minha Lista ---------------------------
struct MinhaLista: View {
    @StateObject var movieAPI: MovieAPI
    
    @EnvironmentObject var listasModel: ListasModel
    
    @Binding var pageToggle: Bool
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    @Binding var searchText: String
    
    var body: some View {
        ScrollView {
            VStack {
                LazyVGrid(columns: columns, spacing: 5) {
                    ForEach(listasModel.myList) { serie in
                        NavigationLink {
                            SerieDescription(movieAPI: movieAPI, pageToggle: $pageToggle, serieId: serie.id, searchText: $searchText)
                                .onAppear {
//                                    movieAPI.fetchDataSearch(query: serie.name)
                                    movieAPI.fetchData()
                                }
                        } label: {
                            WebImage(url: URL(string: "https://image.tmdb.org/t/p/original/\(serie.poster_path ?? "")"))
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100)
                                .cornerRadius(5)
                        }
                        .padding(.vertical, 10)
                    }
                }
                
            }
            .padding(.horizontal, 16)
        }
    }
}

// --------------------------- Conteúdo Assistido ---------------------------
struct AssistidoLista: View {
    
    @StateObject var movieAPI: MovieAPI
    
    @EnvironmentObject var listasModel: ListasModel
    
    @Binding var pageToggle: Bool
    
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    @Binding var searchText: String
    
    var body: some View {
        ScrollView {
            VStack {
                LazyVGrid(columns: columns, spacing: 5) {
                    ForEach(listasModel.watchedList) { serie in
                        NavigationLink {
                            SerieDescription(movieAPI: movieAPI, pageToggle: $pageToggle, serieId: serie.id, searchText: $searchText)
                                .onAppear {
                                    movieAPI.fetchDataSearch(query: serie.name)
                                }
                        } label: {
                            WebImage(url: URL(string: "https://image.tmdb.org/t/p/original/\(serie.poster_path ?? "")"))
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100)
                                .cornerRadius(5)
                        }
                        .padding(.vertical, 10)
                    }
                }
                
            }
            .padding(.horizontal, 16)
        }
    }
}

//struct MinhaLista_Previews: PreviewProvider {
//    static var previews: some View {
//        MinhaLista()
//    }
//}

//struct Listas_Previews: PreviewProvider {
//    static var previews: some View {
//        Listas()
//    }
//}
