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
    ) var recipes: FetchedResults<Recipe>
    
    // @Binding declares the dependency on a @state var
    // owned by another view, which uses the $prefix to
    // pass a binding to this state to another view.
    // in the recieving view, @Binding var is a reference
    // to the data, so it doesn't need to be initialzied
    

    @State var modalIsPresented = false
    
    
    var body: some View {
        
        NavigationView {
            List {
                ForEach(recipes, id: \.self) { recipe in
                    NavigationLink(destination: DetailView(recipe: recipe)) {
                        
                        VStack{
                            Text(recipe.name!)
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                 .foregroundColor(Color(self.getRandomColor()))
                            
                            Text("Last cooked on \(self.formatDate(date: recipe.lastCooked!))")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .foregroundColor(.gray)
                        } // VStack
                        
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

    
    func removeRecipe(at offsets: IndexSet) {
        for index in offsets {
            let recipe = recipes[index]
            context.delete(recipe)
            // this magically saves the data also
        }
    }
    
    
    
}
