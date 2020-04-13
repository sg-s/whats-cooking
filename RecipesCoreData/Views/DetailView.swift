//
//  DetailView.swift
//  RecipesCoreData
//
//  Created by srinivas on 4/11/20.
//  Copyright © 2020 srinivas.gs. All rights reserved.
//


import SwiftUI

struct DetailView: View {
    @Environment(\.managedObjectContext) var context
    @Environment(\.presentationMode) var presentationMode
    
    @State var itemName: String = ""
    @ObservedObject var recipe: Recipe
    
    
    var body: some View {
        VStack {
            TextField("Item Name", text: $itemName)
            Button(action: {
                self.recipe.name = self.itemName
                do {
                    try self.context.save()
                } catch {
                    print(error)
                }
                
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Text("Save")
            }
            
            Spacer()
            
            Button(action: {
                self.recipe.lastCooked = Date()
                do {
                    try self.context.save()
                } catch {
                    print(error)
                }
                
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Text("Just cooked!")
            }
            
            
            Spacer()
            
        }
        .onAppear(perform: {
            self.itemName = self.recipe.name
        })
    }
}

