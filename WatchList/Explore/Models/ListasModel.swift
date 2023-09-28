//
//  ListasModel.swift
//  WatchList
//
//  Created by Kauane Santana on 27/09/23.
//

import SwiftUI

 class ListasModel: Identifiable, ObservableObject {
    
    @Published var id = UUID()
    
    @Published var myList: [Serie] = []
    @Published var watchedList: [Serie] = []

     init(id: UUID = UUID(), myList: [Serie], watchedList: [Serie]) {
         self.id = id
         self.myList = myList
         self.watchedList = watchedList
     }
     
//     @Published var myList: String
//     @Published var watchedList: String
//
//      init(id: UUID = UUID(), myList: String, watchedList: String) {
//          self.id = id
//          self.myList = myList
//          self.watchedList = watchedList
//      }
    
     func addList(item: Serie) {
         myList.append(item)
         print(myList)
    }
    
    func removeList() {
        //logica de remover da lista
    }
    
     func addWatched(item: Serie) {
        watchedList.append(item)
        print(watchedList)
    }
    
    func removeWatched() {
        //logica de remover da lista de assistidos
    }
}
