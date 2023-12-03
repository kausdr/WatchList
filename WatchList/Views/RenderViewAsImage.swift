////CODIGO QUE DEU CERTO 2
//
//import SwiftUI
//import SDWebImageSwiftUI
//
//class ImageSaver: NSObject {
//    func writeToPhotoAlbum(image: UIImage) {
//        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveCompleted), nil)
//    }
//    
//    @objc func saveCompleted(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
//        if let error = error {
//            print("Error saving image: \(error.localizedDescription)")
//        } else {
//            print("Image saved successfully")
//        }
//    }
//}
//
//struct RenderView: View {
//    
//    @StateObject var movieAPI = MovieAPI()
//    @EnvironmentObject var listasModel: ListasModel
//    var serieId: Int
//    @State private var isImageSaved = false
//    
//    var imageView: some View {
//        VStack(spacing: 10) {
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
//                }
////                Divider()
////                    .frame(width: 20, height: 1)
////                    .padding(.horizontal, 30)
////                    .background(.white)
//            } else {
//                Text("Loading...")
//            }
//        }
//        .frame(maxWidth: 240, maxHeight: 415)
//        .background(Color.blue)
//        .cornerRadius(10)
//    }
//    
//    var body: some View {
//        VStack(spacing: 10) {
//            imageView
//            
//            Button("Save ittttttt") {
//                isImageSaved = true
//            }
//        }
//        .background(
//            ImageSaverView(isImageSaved: $isImageSaved) {
//                self.imageView
//            }
//        )
//        .onAppear {
//            movieAPI.fetchData()
//        }
//    }
//}
//
//struct ImageSaverView<Content: View>: View {
//    @Binding var isImageSaved: Bool
//    let content: () -> Content
//
//    var body: some View {
//        content()
//            .onChange(of: isImageSaved) { newValue in
//                if newValue {
//                    saveImage()
//                }
//            }
//    }
//
//    private func saveImage() {
//        guard let image = content().snapshot() else {
//            print("Unable to take a snapshot or content is nil")
//            return
//        }
//        
//        ImageSaver().writeToPhotoAlbum(image: image)
//        isImageSaved = false
//    }
//}
//
//extension View {
//    func snapshot() -> UIImage? {
//        let window = UIWindow(frame: UIScreen.main.bounds)
//        let hostingController = UIHostingController(rootView: self)
//        window.rootViewController = hostingController
//        window.makeKeyAndVisible()
//
//        let renderer = UIGraphicsImageRenderer(size: hostingController.view.bounds.size)
//
//        let image = renderer.image { _ in
//            hostingController.view.drawHierarchy(in: hostingController.view.bounds, afterScreenUpdates: true)
//        }
//
//        window.isHidden = true
//        return image
//    }
//}
//
//struct RenderView_Previews: PreviewProvider {
//    static var previews: some View {
//        RenderView(serieId: 1355)
//    }
//}
