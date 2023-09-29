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
         
         print("ADICIONOU")
    }
    
     func removeList(item: Serie) {
         myList.removeAll{
             $0.id == item.id
             
         }
         
         print("REMOVEU")
    }
    
     func addWatched(item: Serie) {
        watchedList.append(item)
         
         print("ADICIONOU")
    }
    
     func removeWatched(item: Serie) {
        watchedList.removeAll{
            $0.id == item.id
            
        }
         
         print("REMOVEU")
    }
}
