//
//  ShoppingItemController.swift
//  Shopping List
//
//  Created by Harmony Radley on 3/27/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

extension String { static var addedPreferenceKey = "added" }


class ShoppingItemController {
    
    
    let itemNames = ["Apple", "Grapes", "Milk", "Muffin", "Popcorn", "Soda", "Strawberries"]
    var shoppingItems: [ShoppingItem] = []
   
   
    init() {
        let added = UserDefaults.standard.bool(forKey: .addedPreferenceKey)
        if added {
            loadFromPersistentStore() }
        else {
            UserDefaults.standard.set(true, forKey: .addedPreferenceKey)
            
            saveToPersistentStore()
        }
    }
    
    
    var addedItems : [ShoppingItem] {
           return shoppingItems.filter{$0.hasBeenAdded == true}
       }
    var notAddedItems : [ShoppingItem] {
              return shoppingItems.filter{$0.hasBeenAdded == false}

       }
    
    var shoppingListURL: URL? {
           let fileManager = FileManager.default
           guard let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
               else { return nil }
           return documentsDirectory.appendingPathComponent("ShoppingList.plist")
       }
    
    func saveToPersistentStore() {
        guard let save = shoppingListURL else { return }
        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(shoppingItems)
            try data.write(to: save)
        } catch {
            print("Encoding Error")
        }
    }
    
    func loadFromPersistentStore() {
        guard let save = shoppingListURL else { return }
        do {
            let data = try Data(contentsOf: save)
            let decoder = PropertyListDecoder()
            let shoppingItemList = try decoder.decode([ShoppingItem].self, from: data)
            self.shoppingItems = shoppingItemList
        } catch {
            print("Decoding Error")
        }
    }
        
   
    
}
