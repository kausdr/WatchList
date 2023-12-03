//
//  Explore.swift
//  WatchList
//
//  Created by Kauane Santana on 26/09/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct Explore: View {
    
    @StateObject var movieAPI: MovieAPI
    @EnvironmentObject var listasModel: ListasModel
    
    @Binding var serieId: Int
    @Binding var pageToggle: Bool
    
    @Binding var searchText: String
    
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
                        LazyVGrid(columns: columns, spacing: 0) {
                            
                            ForEach(series) { serie in
                                NavigationLink {
                                    SerieDescription(movieAPI: movieAPI, pageToggle: $pageToggle, serieId: serie.id, searchText: $searchText)
                                        .onAppear {
                                            movieAPI.fetchDataSearch(query: serie.name)
                                        }
                                } label: {
                                    WebImage(url: URL(string: "https://image.tmdb.org/t/p/original/\(serie.poster_path ?? "")"))
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 115)
                                        .cornerRadius(5)
                                }
                                .padding(.vertical, 4)
                            }
                        }
                        .padding(.horizontal, 16)
                        
                        Button {
                            movieAPI.currentPage += 1
                            movieAPI.fetchData()
                            print(movieAPI.currentPage)
                        } label: {
                            HStack {
                                Image(systemName: "ellipsis" )
                                    .font(.system(size: 25))
                                Text("Show More")
                                
                            }
                            .frame(maxWidth:.infinity, maxHeight: 72)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.vertical, 16)
                            .background{
                                RoundedRectangle(cornerRadius: 14)
                                    .foregroundColor(Color(uiColor: .lightGray))
                            }
                        }
                        .padding(.vertical, 24)
                        .padding(.horizontal, 16)
                        
                    }
                    else {
                        Text("Loading...")
                    }
                    
                }
            }
        }
        .onChange(of: searchText){ newSearch in
            if searchText.isEmpty {
                movieAPI.fetchData()
            }
            else {
                movieAPI.fetchDataSearch(query: newSearch)
            }
        }
        .searchable(text: $searchText)
        
        .onAppear(){
            movieAPI.fetchData()
        }
        .onDisappear() {
            movieAPI.currentPage = 1
            movieAPI.series = nil
        }
        
    }
}

//struct Explore_Previews: PreviewProvider {
//    static var previews: some View {
//        Explore(pageToggle: .constant(false))
//    }
//}
