import SwiftUI
import SDWebImageSwiftUI

class ImageSaver: NSObject {
    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveCompleted), nil)
    }

    @objc func saveCompleted(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            print("Error saving image: \(error.localizedDescription)")
        } else {
            print("Image saved successfully")
        }
    }
}

struct RenderView: View {
    @StateObject var movieAPI = MovieAPI()
    @EnvironmentObject var listasModel: ListasModel
    var serieId: Int
    @State private var isImageSaved = false
    @State private var isImageLoaded = false
    @State private var image: UIImage?
    @State var didSave: Bool = false

    var imageView: some View {
        VStack(spacing: 10) {
            if let image = image {
                Text("I'm watching to")
                    .font(.body)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200)
                    .cornerRadius(5)
                    .onAppear {
                        isImageLoaded = true
                    }
                    .shadow(color: .black, radius: 5)
                HStack {
                    Image("icon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .cornerRadius(2)
                    Text("by WatchList")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
            } else {
                Text("Loading...")
            }
        }
        .frame(maxWidth: 240, maxHeight: 400)
        .background(Color("Vermelho"))
        .cornerRadius(10)
        .padding(.top, 50)
        
    }

    var body: some View {
        VStack(spacing: 10) {
            VStack {
                Text("Save the image and share with your friends what you are watching!")
                    .multilineTextAlignment(.center)
                    .frame(alignment: .top)
                    .fontWeight(.bold)
                
            }
            .padding(.horizontal, 30)
            
            imageView
            
            Button {
                
                isImageSaved = true
                if didSave {
                    isImageSaved = false
                }
                else {
                    isImageSaved = true
                }
                didSave = true
                
                
            } label: {
                if didSave {
                    Text("Image saved")
                }
                else {
                    Text("Save image")
                }
                
            }
            .frame(width: 100, height: 50)
            .foregroundColor(.white)
            .fontWeight(.bold)
            .background(didSave ? Color(uiColor: .systemGreen) : Color(uiColor: .systemBlue))
            .cornerRadius(5)
            
            
            
            
            
        }
        .background(
            ImageSaverView(isImageSaved: $isImageSaved) {
                self.imageView
                
                    .padding(.bottom, 20)
            }
            
        )
        
        
        
        .onAppear {
            movieAPI.fetchData() {
                DispatchQueue.main.async {
                    guard let serie = movieAPI.series?.first(where: { $0.id == serieId }),
                          let url = URL(string: "https://image.tmdb.org/t/p/original/\(serie.poster_path ?? "")"),
                          let data = try? Data(contentsOf: url)
                    else {
                        return
                    }
                    
                    image = UIImage(data: data)
                }
            }
        }
    }
}

struct ImageSaverView<Content: View>: View {
    @Binding var isImageSaved: Bool
    let content: () -> Content

    var body: some View {
        content()
            .onChange(of: isImageSaved) { newValue in
                if newValue {
                    saveImage()
                }
            }
    }

    private func saveImage() {
        guard let image = content().snapshot() else {
            print("Unable to take a snapshot or content is nil")
            return
        }

        ImageSaver().writeToPhotoAlbum(image: image)
        isImageSaved = false
    }
}

extension View {
    func snapshot() -> UIImage? {
        let window = UIWindow(frame: UIScreen.main.bounds)
        let hostingController = UIHostingController(rootView: self)
        window.rootViewController = hostingController
        window.makeKeyAndVisible()

        let renderer = UIGraphicsImageRenderer(size: hostingController.view.bounds.size)

        let image = renderer.image { _ in
            hostingController.view.drawHierarchy(in: hostingController.view.bounds, afterScreenUpdates: true)
        }

        window.isHidden = true
        return image
    }
}


//struct ShareSheet: UIViewControllerRepresentable {
//
//    var items : [Any]
//
//    func makeUIViewController(context: Context) -> some UIActivityViewController {
//        let controller = UIActivityViewController(activityItems: items, applicationActivities: nil)
//
//        return controller
//    }
//
//    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
//
//    }
//}

struct RenderView_Previews: PreviewProvider {
    static var previews: some View {
        RenderView(serieId: 1355)
    }
}

