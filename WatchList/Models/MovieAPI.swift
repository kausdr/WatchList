//
//  MovieAPI.swift
//  WatchList
//
//  Created by Kauane Santana on 26/09/23.
//

import SwiftUI

class MovieAPI: ObservableObject {
    @Published var series: [Serie]?
    @Published var currentPage = 1
    
    func fetchData() {
        
        let url = URL(string: "https://api.themoviedb.org/3/discover/tv?sort_by=vote_count.desc&api_key=5c308328e2231e55206210b20a696644&page=\(currentPage)")
        
        URLSession.shared.dataTask(with: url!) { data, response, error in
            if let error = error {
                print(error)
                return
            }
            
            if let data = data {
                do {
//                    let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
//                    print(json)
                    let serie = try JSONDecoder().decode(SerieList.self, from: data)
//                    print(serie.results.count)
                    DispatchQueue.main.async {
                        
                        if let loadedSeries = self.series {
                                self.series = loadedSeries + serie.results
                            
                        }
                        else {
                            self.series = serie.results
                        }
                    }
                    
                    
                    
                    
                } catch (let error){
                    print(error)
                    return
                }
            }
            else {
                print("error")
                return
            }
        }
        .resume()
    }
    
    func fetchDataSearch(query: String) {
        let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = URL(string: "https://api.themoviedb.org/3/search/tv?query=\(encodedQuery ?? "")&api_key=5c308328e2231e55206210b20a696644")

        URLSession.shared.dataTask(with: url!) { data, response, error in
            if let error = error {
                print(error)
                return
            }

            if let data = data {
                do {
                    let serie = try JSONDecoder().decode(SerieList.self, from: data)
                    DispatchQueue.main.async {
                        self.series = serie.results
                    }
                } catch {
                    print(error)
                }
            } else {
                print("error")
            }
        }
        .resume()
    }
}
