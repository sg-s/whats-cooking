//
//  ContentView.swift
//  RecipesCoreData
//
//  Created by srinivas on 4/10/20.
//  Copyright © 2020 srinivas.gs. All rights reserved.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var context 
    
    
    // recipeName is owned and managed by ContentView
    // which is why we have marked it as private
    // because we marked it as @State, we have to
    // initialize it here
    @State private var recipeName: String = ""
    
    
    // @Binding declares the dependency on a @state var
    // owneed by another view, which uses the $prefix to
    // pass a binding to this state to another view.
    // in the recieving view, @Binding var is a reference
    // to the data, so it doesn't need to be initialzied
    
    
    
    @State var modalIsPresented = false
    
    
    var body: some View {
        
        NavigationView {
            List {
                ForEach (allRecipes) { recipe in
                    
                    Button (action: {
                        self.updateLastCooked(recipe)
                    }) {
                        RowView(recipe: recipe)
                    }
                }
                .onDelete(perform: removeRecipe)
                

            }
            
            .navigationBarTitle("What's cooking?")
            .navigationBarItems(
                leading: EditButton(),
                trailing:
                    Button(
                        action: {self.modalIsPresented = true}) {
                    Image(systemName: "plus")
                    } )
            
            .sheet(isPresented: $modalIsPresented) {
                NewRecipeView().environment(\.managedObjectContext, self.context)
                }
        }
    }
    
    
    func updateLastCooked(_ recipe: Recipe) {
        let recipeID = recipe.id! as NSUUID
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Recipe")
        fetchRequest.predicate = NSPredicate(format: "id == %@", recipeID as CVarArg)
        fetchRequest.fetchLimit = 1
        do {
            let test = try context.fetch(fetchRequest)
            let recipeUpdate = test[0] as! NSManagedObject
            recipeUpdate.setValue(Date(), forKey: "lastCooked")
        } catch {
            print(error)
        }
    }
    
    func removeRecipe(at offsets: IndexSet) {
        for index in offsets {
            let recipe = allRecipes[index]
            context.delete(recipe)
        }
        
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
    
    
    @FetchRequest(
        entity: Recipe.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Recipe.lastCooked, ascending: true)]
    ) var allRecipes: FetchedResults<Recipe>
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
