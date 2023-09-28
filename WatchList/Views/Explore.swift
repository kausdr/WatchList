//
//  Explore.swift
//  WatchList
//
//  Created by Kauane Santana on 26/09/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct Explore: View {
    
    @ObservedObject var movieAPI = MovieAPI()
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    if let series = movieAPI.series {
                        LazyVGrid(columns: columns, spacing: 5) {
                            
                            ForEach(series) { serie in
                                NavigationLink {
                                    SerieDescription(listasModel: ListasModel(myList: [], watchedList: []), serieId: serie.id)
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
                    else {
                        Text("Fetching data...")
                            .foregroundColor(.white)
                    }
                    
                }
            }
        }
        .padding()
        .onAppear(){
                        movieAPI.fetchData()
        }
    }
}

struct Explore_Previews: PreviewProvider {
    static var previews: some View {
        Explore()
    }
}
