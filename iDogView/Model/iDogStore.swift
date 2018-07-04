//
//  iDogStore.swift
//  iDogView
//
//  Created by Kevin Tito on 7/4/18.
//  Copyright © 2018 Kevin Tito. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class iDogStore {
    init(){
        
    }
    //Managment the object
    let delegate = UIApplication.shared.delegate as! AppDelegate
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    //save de object
    func save() {
        delegate.saveContext()
    }
    // set favorites, delete and add
    func setFavorite(_ isFavorite: Bool, for dog: Dog) {
        if self.isFavorite(dog: dog) == isFavorite {
            return
        }
        if self.isFavorite(dog: dog) {
            deleteFavorite(for: dog)
        } else {
            addFavorite(for: dog)
        }
    }
    //Delete favorite
    func deleteFavorite(for dog: Dog) {
        let favorite = findFavoriteById(for: dog)
        if let favorite = favorite{
            context.delete(favorite)
            save()
        }
    }
    //Add favorite
    func addFavorite(for dog: Dog) {
        let favoriteEntity = NSEntityDescription.entity(forEntityName: "Favorite", in: context)
        let newFavorite = NSManagedObject(entity: favoriteEntity!, insertInto: context)
        newFavorite.setValue(dog.id, forKey: "id")
        newFavorite.setValue(dog.url, forKey: "url")
        newFavorite.setValue(dog.time, forKey: "uploadedAtList")
        newFavorite.setValue(Date(), forKey: "createdAt")
        save()
    }
    // find favorite by ID, it's the same with name
    func findFavoriteById(for dog: Dog) -> NSManagedObject? {
        let predicate = NSPredicate(format: "id= %@", dog.id)
        return findFavoriteBy(predicate: predicate, for: dog)
    }
    
    //the first func
    func findFavoriteBy(predicate: NSPredicate, for dog: Dog) -> NSManagedObject? {
        let favoriteEntity = NSEntityDescription.entity(forEntityName: "Favorite", in: context)
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: favoriteEntity!.name!)
        request.predicate = predicate
        do {
            let result = try context.fetch(request)
            if let favorite = result.first as? NSManagedObject{
                return favorite
            }
        } catch (let error){
            print("Error: \(error.localizedDescription)")
        }
        return nil
    }
    
    func findAllFavorites() -> [NSManagedObject]? {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorite")
        do {
            let result = try context.fetch(request)
            return result as? [NSManagedObject]
        } catch let error {
            print("Query Error: \(error.localizedDescription)")
        }
        return nil
    }
    
    func isFavorite(dog: Dog) -> Bool {
        return findFavoriteById(for: dog) != nil
    }
    func favorite(dog: Dog) {
        setFavorite(true, for: dog)
    }
    func unFavorite(dog: Dog){
        setFavorite(false, for: dog)
    }
    // convert de object name in string
    func favoriteDogIdAsString() -> String {
        let favorites = findAllFavorites()
        
        if let favorites = favorites {
            print("All Favorites Count: \(favorites.count)")
            return favorites
            .map({$0.value(forKey: "id") as! String})
            .filter({!$0.isEmpty})
            .prefix(20)
            .joined(separator: ",")
        }
        return ""
    }
}
