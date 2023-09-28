//
//  Serie.swift
//  WatchList
//
//  Created by Kauane Santana on 26/09/23.
//

import SwiftUI

struct SerieList: Decodable {
    let results: [Serie]
}

struct Serie: Identifiable, Decodable {
    let id: Int
    let name: String
    let overview: String?
    let poster_path: String?
    let backdrop_path: String?
}
