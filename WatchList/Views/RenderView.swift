////
////  RenderView.swift
////  WatchList
////
////  Created by Kauane Santana on 01/10/23.
////
//
//import SwiftUI
//import SDWebImageSwiftUI
//import PhotosUI

//
//
//struct RenderView: View {
//    
//    @StateObject var movieAPI = MovieAPI()
//    @EnvironmentObject var listasModel: ListasModel
//    var serieId: Int
//    
//    var body: some View {
//        
//        VStack (spacing: 10){
//            if let serie = movieAPI.series?.first(where: { $0.id == serieId }) {
//                Text("I'm watching to")
//                    .font(.body)
//                    .fontWeight(.bold)
//                WebImage(url: URL(string: "https://image.tmdb.org/t/p/original/\(serie.poster_path ?? "")"))
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .frame(width: 200)
//                    .cornerRadius(5)
//                HStack {
//                    Image("icon")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 20, height: 20)
//                        .cornerRadius(2)
//                    Text("by WatchList")
//                        .font(.caption)
//                        .fontWeight(.bold)
//                    
//                }
//                Divider()
//                    .frame(width: 20, height: 1)
//                    .padding(.horizontal, 30)
//                    .background(.white)
//
//                
//            }
//            else {
//                Text("Loading...")
//            }
//            
//        }
//        .frame(maxWidth: 240, maxHeight: 415)
//        .background(Color(uiColor: .blue))
//        .cornerRadius(10)
//        .onAppear {
//            movieAPI.fetchData()
//        }
//    }
//}
//
//#Preview {
//    RenderView(serieId: 1355)
//}
