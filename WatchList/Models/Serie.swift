//
//  Serie.swift
//  WatchList
//
//  Created by Kauane Santana on 26/09/23.
//

import SwiftUI

struct SerieList: Decodable {
    let results: [Serie]
    
    static func getFromUserDefaultsMyList() -> [Serie] {
        if let series = UserDefaults.standard.object(forKey: "seriesMyList") as? Data {
            let decoder = JSONDecoder()
            if let loadedSeries = try? decoder.decode([Serie].self, from: series) {
                return loadedSeries
            }
        }
        
        return []
    }
    
    
    static func saveInUserDefaultsMyList(results: [Serie]) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(results) {
            UserDefaults.standard.set(encoded, forKey: "seriesMyList")
        }
    }
    
    static func getFromUserDefaultsWatchedList() -> [Serie] {
        if let series = UserDefaults.standard.object(forKey: "seriesWatchedList") as? Data {
            let decoder = JSONDecoder()
            if let loadedSeries = try? decoder.decode([Serie].self, from: series) {
                return loadedSeries
            }
        }
        
        return []
    }
    
    
    static func saveInUserDefaultsWatchedList(results: [Serie]) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(results) {
            UserDefaults.standard.set(encoded, forKey: "seriesWatchedList")
        }
    }
}

struct Serie: Identifiable, Decodable, Encodable{
    let id: Int
    let name: String
    let overview: String?
    let poster_path: String?
    let backdrop_path: String?
    
    private enum CodingKeys: String, CodingKey {
        case id, name,overview, poster_path, backdrop_path
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        overview = try container.decode(String.self, forKey: .overview)
        poster_path = try container.decode(String.self, forKey: .poster_path)
        backdrop_path = try container.decode(String.self, forKey: .backdrop_path)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(overview, forKey: .overview)
        try container.encode(poster_path, forKey: .poster_path)
        try container.encode(backdrop_path, forKey: .backdrop_path)
    }
}
