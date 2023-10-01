//struct Explore: View {
//    @State private var scrollOffset: CGFloat = 0
//    
//    // ... (your existing code)
//    
//    var body: some View {
//        NavigationStack {
//            ScrollViewReader { scrollView in
//                ScrollView {
//                    // Use ScrollViewReader to track scroll offset
//                    
//                    LazyVGrid(columns: columns, spacing: 5) {
//                        ForEach(series.prefix(numberOfSeriesToShow)) { serie in
//                            NavigationLink {
//                                SerieDescription(movieAPI: movieAPI, pageToggle: $pageToggle, serieId: serie.id, searchText: $searchText)
//                                    .onAppear {
//                                        movieAPI.fetchDataSearch(query: serie.name)
//                                    }
//                            } label: {
//                                WebImage(url: URL(string: "https://image.tmdb.org/t/p/original/\(serie.poster_path ?? "")"))
//                                    .resizable()
//                                    .aspectRatio(contentMode: .fit)
//                                    .frame(width: 100)
//                                    .cornerRadius(5)
//                            }
//                            .padding(.vertical, 10)
//                            .id(serie.id)
//                        }
//                    }
//                    .onChange(of: scrollOffset) { offset in
//                        // Check if user scrolled to the bottom
//                        if offset > 0 && offset > scrollView.contentSize.height - scrollView.frame.size.height - 100 {
//                            movieAPI.fetchData()
//                        }
//                    }
//                    .onAppear {
//                        scrollView.scrollTo(series.last?.id, anchor: .bottom)
//                    }
//                }
//            }
//        }
//        // Track scroll offset
//        .onPreferenceChange(OffsetPreferenceKey.self) {
//            scrollOffset = $0
//        }
//    }
//}
