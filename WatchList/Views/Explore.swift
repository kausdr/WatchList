//
//  Explore.swift
//  WatchList
//
//  Created by Kauane Santana on 26/09/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct Explore: View {
    
    @StateObject var movieAPI = MovieAPI()
    @EnvironmentObject var listasModel: ListasModel
    
    @Binding var serieId: Int
    @Binding var pageToggle: Bool
    
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
                                    SerieDescription(pageToggle: $pageToggle, serieId: serie.id)
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

//struct Explore_Previews: PreviewProvider {
//    static var previews: some View {
//        Explore(pageToggle: .constant(false))
//    }
//}
