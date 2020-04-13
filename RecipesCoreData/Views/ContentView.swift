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
    @FetchRequest(fetchRequest: Recipe.getListItemFetchRequest()) var recipes: FetchedResults<Recipe>
    
    @State var modalIsPresented = false
    
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(recipes, id: \.self) { recipe in
                        NavigationLink(destination: DetailView(recipe: recipe)) {
                            
                            VStack{
                                Text(recipe.name)
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                     .foregroundColor(Color(self.getRandomColor()))
                                
                                Text("Last cooked on \(self.formatDate(date: recipe.lastCooked))")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .foregroundColor(.gray)
                            } // VStack
                            
                        }
                    }
                    .onDelete(perform: deleteItem)
                    
                }
                
            }
            .navigationBarTitle("What's cooking?")
            .navigationBarItems(
            leading: EditButton(),
            trailing:
                Button(
                    action: {self.modalIsPresented = true}) {
                Image(systemName: "plus.app.fill")
                } )
            .sheet(isPresented: $modalIsPresented) {
            NewRecipeView().environment(\.managedObjectContext, self.context)
            }
        }
    }
    
    
    // simple date formatter
    func formatDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM hh:mm:ss"
        //dateFormatter.timeStyle = .none
        return dateFormatter.string(from: date)
    
    }
    


    func getRandomColor() -> UIColor {
         //Generate between 0 to 1
         let red:CGFloat = CGFloat(drand48())
         let green:CGFloat = CGFloat(drand48())
         let blue:CGFloat = CGFloat(drand48())

         return UIColor(red:red, green: green, blue: blue, alpha: 1.0)
    }

    func deleteItem(indexSet: IndexSet) {
        let source = indexSet.first!
        let deleteMe = recipes[source]
        context.delete(deleteMe)
        saveItems()
    }
    
    func addItem() {
        let newItem = Recipe(context: context)
        newItem.name = "New Meal"
        newItem.lastCooked = Date()
        
        saveItems()
    }
    
    func saveItems() {
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
}

