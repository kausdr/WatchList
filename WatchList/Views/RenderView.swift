//
//  RenderView.swift
//  WatchList
//
//  Created by Kauane Santana on 01/10/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct RenderView: View {
    
    @StateObject var movieAPI = MovieAPI()
    @EnvironmentObject var listasModel: ListasModel
    var serieId: Int
    
    var body: some View {
        VStack (spacing: 10){
            if let serie = movieAPI.series?.first(where: { $0.id == serieId }) {
                Text("I'm watching to")
                    .font(.body)
                    .fontWeight(.bold)
                    WebImage(url: URL(string: "https://image.tmdb.org/t/p/original/\(serie.poster_path ?? "")"))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200)
                        .cornerRadius(5)
                Text("by WatchList")
                    .font(.caption)
            }
            else {
                Text("Fetching data...")
            }
            
        }
        .frame(maxWidth: 240, maxHeight: 415)
        .background(Color(uiColor: .blue))
        .cornerRadius(10)
        .onAppear {
            movieAPI.fetchData()
        }
    }
}
    
//    #Preview {
//        RenderView(serieId: .constant(1355))
//    }
