//
//  SerieDescription.swift
//  WatchList
//
//  Created by Kauane Santana on 27/09/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct SerieDescription: View {
    
    @StateObject var movieAPI = MovieAPI()
    @EnvironmentObject var listasModel: ListasModel
    @Binding var pageToggle: Bool
    @State var mudarBotaoMyList: Bool = true
    @State var mudarBotaoAssistidos: Bool = true
    
    var serieId: Int
    
    var body: some View {
        VStack{
            ScrollView{
                if let serie = movieAPI.series?.first(where: { $0.id == serieId }) {
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
                                    mudarBotaoMyList.toggle()
                                    if !listasModel.myList.contains(where: {$0.id == serieId }) {
                                        listasModel.addList(item: serie)
                                    }
                                    else {
                                        listasModel.removeList(item: serie)
                                    }
                                    
                                    
                                } label: {
                                    HStack {
                                        
                                        Image(systemName: mudarBotaoMyList ? "plus.app" : "checkmark.square.fill")
                                            .font(.system(size: 25))
                                        Text("Minha Lista")
                                        
                                        
                                    }
                                    .frame(maxWidth:.infinity, maxHeight: 72)
                                    .multilineTextAlignment(.center)
                                    .minimumScaleFactor(0.05)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .padding(.vertical, 16)
                                    .background{
                                        RoundedRectangle(cornerRadius: 14)
                                            .foregroundColor(mudarBotaoMyList ? Color(uiColor: .lightGray) : Color(uiColor: .systemGreen))
                                    }
                                    
                                    
                                }
                                
                                Button{
                                    mudarBotaoAssistidos.toggle()
                                    if !listasModel.watchedList.contains(where: {$0.id == serieId }) {
                                        listasModel.addWatched(item: serie)
                                    }
                                    else {
                                        listasModel.removeWatched(item: serie)
                                    }
                                    
                                } label: {
                                    HStack {
                                        Image(systemName: mudarBotaoAssistidos ? "plus.app" : "checkmark.square.fill")
                                            .font(.system(size: 25))
                                        Text("Assistido")
                                        
                                    }
                                    .frame(maxWidth:.infinity, maxHeight: 72)
                                    .fontWeight(.bold)
                                    .clipped()
                                    .foregroundColor(.white)
                                    .padding(.vertical, 16)
                                    .background{
                                        RoundedRectangle(cornerRadius: 14)
                                            .foregroundColor(mudarBotaoAssistidos ? Color(uiColor: .lightGray) : Color(uiColor: .systemGreen))
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
                else {
                    Text("Fetching data...")
                        .background(.green)
                }
                
            }
        }
        .frame(maxWidth: .infinity)
        .onAppear(){
            movieAPI.fetchData()
            
            if listasModel.myList.contains(where: {$0.id == serieId }) {
                mudarBotaoMyList = false
            }
            
            if listasModel.watchedList.contains(where: {$0.id == serieId }) {
                mudarBotaoAssistidos = false
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

//struct SerieDescription_Previews: PreviewProvider {
//    static var previews: some View {
//        SerieDescription(pageToggle: .constant(false), serieId: 1399)
//    }
//}
