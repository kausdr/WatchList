//
//  MovieAPI.swift
//  WatchList
//
//  Created by Kauane Santana on 26/09/23.
//

import SwiftUI

class MovieAPI: ObservableObject {
    @Published var series: [Serie]?
    
    func fetchData() {
        let url = URL(string: "https://api.themoviedb.org/3/discover/tv?sort_by=vote_count.desc&api_key=5c308328e2231e55206210b20a696644")
        
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
                    self.series = serie.results
                    
                    
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
}
