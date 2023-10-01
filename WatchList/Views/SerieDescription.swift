//
//  SerieDescription.swift
//  WatchList
//
//  Created by Kauane Santana on 27/09/23.
//

import SwiftUI
import SDWebImageSwiftUI
import PhotosUI

class ImageSaver: NSObject {
    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveCompleted), nil)
    }
    
    @objc func saveCompleted(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        print("Saved!")
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
//        else {
//            print("deu erro aqui ó")
//        }
//        
//    }
//    
//    @IBAction func shareButton(_ sender: Any) {
//        shareToInstagramStories(image: UIImage(named: "imgTeste") ?? UIImage())
//    }
}

struct SerieDescription: View {
    
    @StateObject var movieAPI = MovieAPI()
    @EnvironmentObject var listasModel: ListasModel
    @Binding var pageToggle: Bool
    @State var mudarBotaoMyList: Bool = true
    @State var mudarBotaoAssistidos: Bool = true
    
    var imgView: some View {
            return createViewImage()
    }
    
    var serieId: Int
//    @State private var imgOk = false
    
    
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
                                .font(.title)
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
                            
//                            HStack{
//                                Text("Show people you're watching it")
//                                    .font(.body)
//                                    .fontWeight(.bold)
//                                    .foregroundColor(Color(uiColor: .systemGray2))
//                                Spacer()
//                                Button {
//                                    print("compartilhando")
//                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//                                        let renderer = ImageRenderer (content: imgView)
//                                        
//                                        if let image = renderer.uiImage {
//                                            let imageSaver = ImageSaver()
//                                            imageSaver.writeToPhotoAlbum(image: image)
//                                        }
//                                        print("renderizou")
//                                    }
//                                    
//                                    
//                                    
//                                    //                                    imageSaver.shareButton((Any).self)
//                                    //                                    shareToInstagramStories(image: UIImage(named: "imgTeste") ?? UIImage())
//                                } label: {
//                                    Image(systemName: "square.and.arrow.up")
//                                        .foregroundColor(Color(uiColor: .systemBlue))
//                                        .font(.system(size: 25))
//                                        .fontWeight(.bold)
//                                }
//                                
//                                //                                NavigationLink{
//                                //                                    RenderView(serieId: serie.id)
//                                //                                } label: {
//                                //                                    Text("Ir")
//                                //                                }
//                                
//                            }
//                            .padding(.vertical, 24)
                            
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
    
    
    
    
    
    

    
    
    
    

    
    
    
    //    -------------------- VIEW TO BE RENDERED --------------------
    
    private func createViewImage() -> some View{
        return VStack (spacing: 10){
            if let serie = movieAPI.series?.first(where: { $0.id == serieId }) {
                Text("I'm watching to")
                    .font(.body)
                    .fontWeight(.bold)
                WebImage(url: URL(string: "https://image.tmdb.org/t/p/original/\(serie.poster_path ?? "")"))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200)
                    .cornerRadius(5)
                    .onAppear {
                        print("carregou")
                    }
                
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

//struct SerieDescription_Previews: PreviewProvider {
//    static var previews: some View {
//        SerieDescription(pageToggle: .constant(false), serieId: 1399)
//    }
//}
