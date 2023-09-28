//
//  ListasModel.swift
//  WatchList
//
//  Created by Kauane Santana on 27/09/23.
//

import SwiftUI

 class ListasModel: ObservableObject {
    
    @Published var myList: [Serie] = []
    @Published var watchedList: [Serie] = []

     init() {
     }
     
     func addList(item: Serie) {

             myList.append(item)
         
//         myList.append(item)
         
         print(myList)
         print("-------")
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
