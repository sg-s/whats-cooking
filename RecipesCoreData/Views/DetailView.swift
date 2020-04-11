//
//  DetailView.swift
//  RecipesCoreData
//
//  Created by srinivas on 4/11/20.
//  Copyright © 2020 srinivas.gs. All rights reserved.
//

import SwiftUI
import CoreData


struct DetailView: View {
    
    var recipe: Recipe
    
    
    @Environment(\.managedObjectContext) var context
    
    //@Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        VStack{
            Image(systemName: "camera")
            
            Text("SOS")
                .font(.title)
            
        
            Spacer()
            
            Button (action: {
                
                self.updateLastCooked(self.recipe)
                
                //self.presentationMode.wrappedValue.dismiss()
                
                }) {
                    Text("Just cooked!")
                    
                }
            
            Spacer()
            
        } // VStack
            .navigationBarTitle(Text(recipe.name!), displayMode: .inline)
    } // body
    
    func updateLastCooked(_ recipe: Recipe) {

        recipe.lastCooked = Date()
        do {
          try  context.save()
        } catch {
        
        }
        
        
        
        // No idea why I used this old and incredible complex code
//        let recipeID = recipe.id! as NSUUID
//        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Recipe")
//        fetchRequest.predicate = NSPredicate(format: "id == %@", recipeID as CVarArg)
//        fetchRequest.fetchLimit = 1
//
//        do {
//          let test = try context.fetch(fetchRequest)
//          let recipeUpdate = test[0] as! NSManagedObject
//          recipeUpdate.setValue(Date(), forKey: "lastCooked")
//        } catch {
//          print(error)
//        }
        
    
      }
    
    
    
} // DetailView

//struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailView()
//    }
//}
