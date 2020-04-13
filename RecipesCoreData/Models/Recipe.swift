//
//  Recipe.swift
//  OrderedList
//
//  Created by SchwiftyUI on 9/2/19.
//  Copyright © 2019 SchwiftyUI. All rights reserved.
//

import CoreData

class Recipe: NSManagedObject {
    @NSManaged var name: String
    @NSManaged var lastCooked: Date
    @NSManaged var id: UUID
}

extension Recipe {
    static func getListItemFetchRequest() -> NSFetchRequest<Recipe>{
        let request = Recipe.fetchRequest() as! NSFetchRequest<Recipe>
        request.sortDescriptors = [NSSortDescriptor(key: "lastCooked", ascending: true)]
        return request
    }
}
