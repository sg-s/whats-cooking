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
    

    // get all data, sorted by lastCooked
    @FetchRequest(
        entity: Recipe.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Recipe.lastCooked, ascending: true)]
    ) var allRecipes: FetchedResults<Recipe>
    
    // @Binding declares the dependency on a @state var
    // owned by another view, which uses the $prefix to
    // pass a binding to this state to another view.
    // in the recieving view, @Binding var is a reference
    // to the data, so it doesn't need to be initialzied
    

    @State var modalIsPresented = false
    
    
    var body: some View {
        
        NavigationView {
            List {
                ForEach (allRecipes) { recipe in
                    NavigationLink(destination: DetailView(recipe: recipe).environment(\.managedObjectContext, self.context)) {
                        RowView(recipe: recipe)
                    } // nav link
                    
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

    
    func removeRecipe(at offsets: IndexSet) {
        for index in offsets {
            let recipe = allRecipes[index]
            context.delete(recipe)
            // this magically saves the data also
        }
    }
    
    
    
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
