//
//  SerieDescription.swift
//  WatchList
//
//  Created by Kauane Santana on 27/09/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct SerieDescription: View {
    
    @ObservedObject var movieAPI = MovieAPI()
    @ObservedObject var listasModel: ListasModel
    
    var serieId: Int
    
    var body: some View {
        NavigationStack {
            VStack{
                ScrollView{
                    if let series = movieAPI.series {
                        
                        ForEach(series) { serie in
                            if serie.id == serieId {
                                VStack(spacing: 0){
                                    WebImage(url: URL(string: "https://image.tmdb.org/t/p/original/\(serie.backdrop_path ?? "")"))
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(maxWidth: .infinity)
                                    
                                    VStack (alignment: .leading, spacing: 10){
                                        Text(serie.name)
                                            .font(.headline)
                                            .padding(.vertical, 10)
                                        HStack(spacing: 15){
                                            Button{
                                                listasModel.addList(item: serie)
                                            } label: {
                                                HStack {
                                                    Image(systemName: "plus.app")
                                                        .font(.system(size: 25))
                                                    Text("Minha Lista")
                                                    
                                                }
                                                .frame(maxWidth:.infinity)
                                                .fontWeight(.bold)
                                                .foregroundColor(.white)
                                                .padding(.vertical, 16)
                                                .background{
                                                    RoundedRectangle(cornerRadius: 14)
                                                        .foregroundColor(Color(uiColor: .lightGray))
                                                }
                                                
                                                
                                            }
                                            
                                            
                                            Button{
                                                listasModel.addWatched(item: serie)
                                            } label: {
                                                HStack {
                                                    Image(systemName: "plus.app")
                                                        .font(.system(size: 25))
                                                    Text("Assistido")
                                                    
                                                }
                                                .frame(maxWidth:.infinity)
                                                .fontWeight(.bold)
                                                .foregroundColor(.white)
                                                .padding(.vertical, 16)
                                                .background{
                                                    RoundedRectangle(cornerRadius: 14)
                                                        .foregroundColor(Color(uiColor: .lightGray))
                                                }
                                            }
                                        }
                                        .frame(maxWidth: .infinity)
                                        
                                        HStack (spacing: 42){
                                            Text("Show people you're watching")
                                                .font(.body)
                                                .fontWeight(.bold)
                                                .foregroundColor(Color(uiColor: .systemGray2))
                                            Image(systemName: "chevron")
                                        }
                                        .padding(.vertical, 24)
                                        
                                        VStack (alignment: .leading, spacing: 10){
                                            NavigationLink{
                                                Listas()
                                            } label: {
                                                Text("Ir")
                                            }
                                            .fontWeight(.bold)
                                            .foregroundColor(.purple)
                                            Text("Description")
                                                .font(.headline)
                                                .foregroundColor(Color(uiColor: .systemGray2))
                                            Text(serie.overview ?? "")
                                                .font(.body)
                                        }
                                    }
                                    .padding(.horizontal, 24)
                                }
                            }
                        }
                    }
                    else {
                        Text("Fetching data...")
                    }
                    
                }
            }
            .frame(maxWidth: .infinity)
            .onAppear(){
                movieAPI.fetchData()
            }
        }
    }
    
    
//    func shareToInstagramStories(image: UIImage) {
//
//        guard let instagramURL = URL(string: "instagram-stories://share") else {return}
//
//        if UIApplication.shared.canOpenURL(instagramURL) {
//            let paste = [["com.instagram.sharedSticker.backgroundImage": image as Any]]
//            UIPasteboard.general.setItems(paste)
//            UIApplication.shared.open(instagramURL)
//        }
//
//    }
//
//
//    @IBAction func shareButton(_ sender Any) {
//        shareToInstagramStories(image: UIImage(named: "blabla") ?? UIImage())
//    }
}

struct SerieDescription_Previews: PreviewProvider {
    static var previews: some View {
        SerieDescription(listasModel: ListasModel(myList: [], watchedList: []), serieId: 1399)
    }
}
