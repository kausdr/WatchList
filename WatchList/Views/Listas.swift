//
//  Listas.swift
//  WatchList
//
//  Created by Kauane Santana on 27/09/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct Listas: View {
    
    @State var listPagesSelection = "Assistido"
    var listPagesNames = ["Minha Lista", "Assistido"]
    
    var body: some View {
        VStack {
//            Picker("List Pages", selection: $listPagesSelection) {
//                ForEach(listPagesNames, id: \.self) {
//                    Text($0)
//                }
//            }
//            .pickerStyle(.segmented)
            
            MinhaLista(listasModel: ListasModel(myList: [], watchedList: []))
            
        }
    }
}





// --------------------------- Lista Conteúdo ---------------------------
struct MinhaLista: View {
    
    @State var listPagesSelection = "Assistido"
    var listPagesNames = ["Minha Lista", "Assistido"]
    
    @ObservedObject var movieAPI = MovieAPI()
    
    @ObservedObject var listasModel: ListasModel
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                        LazyVGrid(columns: columns, spacing: 5) {
                            
                            ForEach(listasModel.myList) { serie in
                                NavigationLink {
                                    //
                                } label: {
                                    WebImage(url: URL(string: "https://image.tmdb.org/t/p/original/\(serie.poster_path ?? "")"))
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 120)
                                        .cornerRadius(5)
                                }
                            }
                        }
                    
                }
            }
        }
        .padding()
        .onAppear(){
                                    movieAPI.fetchData()
            print(listasModel.myList)
        }
    }
}

struct MinhaLista_Previews: PreviewProvider {
    static var previews: some View {
        MinhaLista(listasModel: ListasModel(myList: [], watchedList: []))
    }
}

//struct Listas_Previews: PreviewProvider {
//    static var previews: some View {
//        Listas()
//    }
//}
